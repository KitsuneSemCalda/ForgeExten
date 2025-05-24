add_rules("mode.debug", "mode.release")

set_project("ForgeExten")
set_version("1.0.0-alpha")
set_languages("cxx20")
target("ForgeExten")
set_kind("binary")

set_warnings("allextra")
add_cxxflags("-Werror")
add_cxxflags("-Wno-gnu-line-marker")
add_cxxflags("-Wpedantic")

if is_mode("debug") then
	set_optimize("none")
	set_symbols("debug")
	add_ldflags("-fno-omit-frame-pointer")
	add_ldflags("-fsanitize=undefined")
	add_defines("FORGE_DEBUG")
end

if is_mode("release") then
	set_optimize("fastest")
	set_symbols("hidden")
	add_defines("NDEBUG")
end

if is_plat("linux") then
	if has_config("use_pkg") then
		add_packages("vulkan")
	else
		add_links("vulkan")
	end
end

add_includedirs("Include")
add_files("Src/**.cpp")

target_end()

task("clangd")
set_menu({
	usage = "xmake clangd",
	description = "generate a new version of compile_commands.json from clangd",
})
on_run(function()
	if os.isfile("compile_commands.json") then
		os.rm("compile_commands.json")
	end
	os.exec("xmake project -k compile_commands")
end)
task_end()

option("use_pkg")
set_default(true)
set_showmenu(true)
set_description("Use pkg-config to find Vulkan")
option_end()
