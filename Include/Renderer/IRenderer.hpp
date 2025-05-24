#pragma once

#include <Renderer/Helper/FrameRenderInfo.hpp>

/**
 * @class IRenderer
 * @brief Interface for rendering systems providing lifecycle and frame control.
 *
 * Defines the contract for renderers to initialize, shutdown, and handle
 * per-frame operations.
 */
class IRenderer {
public:
  virtual ~IRenderer() = default;

  /**
   * @brief Initializes the renderer, allocating necessary resources.
   * Must be called before any frame operations.
   */
  virtual void Init() = 0;

  /**
   * @brief Shuts down the renderer and releases all allocated resources.
   * No frame operations should be called after this.
   */
  virtual void Shutdown() = 0;

  /**
   * @brief Starts a new frame, preparing the renderer with timing info.
   * @param info Frame timing and index information.
   */
  virtual void BeginFrame(const RenderFrameInfo &info) = 0;

  /**
   * @brief Ends the current frame, finalizing rendering operations.
   */
  virtual void EndFrame() = 0;
};
