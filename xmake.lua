add_rules("mode.debug", "mode.release")

target("ForgeExten")
set_kind("binary")
add_includedirs("Include")

add_files("Src/*.cpp")

toolchain("ForgeExten")
set_kind("standalone")
set_toolset("cc", "clang", "tcc", "gcc")
set_toolset("cxx", "clang", "clang++", "g++")
set_toolset("ld", "ld.lld", "clang", "ld")
set_toolset("ar", "ar")
set_toolset("ex", "ar")
set_toolset("strip", "strip")

on_load(function(toolchain)
	local march = is_arch("x86_64", "x64") and "-m64" or "-m32"

	toolchain:add("cxflags", march)
	toolchain:add("ldflags", march)
	toolchain:add("shflags", march)
	if not is_plat("windows") and os.isdir("/usr") then
		for _, includedir in ipairs({ "/usr/local/include", "/usr/include" }) do
			if os.isdir(includedir) then
				toolchain:add("includedirs", includedir)
			end
		end
		for _, linkdir in ipairs({ "/usr/local/lib", "/usr/lib" }) do
			if os.isdir(linkdir) then
				toolchain:add("linkdirs", linkdir)
			end
		end
	end
end)

toolchain_end()

task("clangd")
set_menu({
	usage = "xmake clangd",
	description = "generate a new version of compile_commands.json from clangd",
})
on_run(function()
	os.exec("rm -rf compile_commands.json")
	os.exec("xmake project -k compile_commands")
end)

task_end()
