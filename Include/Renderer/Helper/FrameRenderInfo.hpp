#pragma once

#include <chrono>

/**
 * @struct RenderFrameInfo
 * @brief Contains timing and indexing information for a single render frame.
 *
 * This structure holds essential frame data used by the renderer to manage
 * frame timing and sequencing. The deltaTime represents the duration elapsed
 * since the last frame, providing high-precision timing to ensure smooth
 * animations and physics updates. The frameIndex tracks the current frame
 * number, useful for frame-dependent logic.
 */
struct RenderFrameInfo {
  /// Duration of time elapsed since the last rendered frame (in seconds) using
  /// (double precision).
  std::chrono::duration<double> deltaTime;

  /// Sequential index of the current frame, starting from zero.
  uint32_t frameIndex = 0;

  /**
   * @brief Constructs a RenderFrameInfo instance with explicit timing and frame
   * index.
   *
   * This constructor initializes the RenderFrameInfo structure with a specified
   * elapsed frame time and frame sequence index. Explicit initialization
   * ensures clarity and prevents uninitialized values, which is critical for
   * precise timing and frame-dependent logic in rendering systems.
   *
   * @param dt The elapsed time since the previous frame, represented as a
   *           std::chrono::duration<double> (in seconds).
   * @param idx The zero-based sequential index of the current frame.
   */
  RenderFrameInfo(std::chrono::duration<double> dt, uint32_t idx)
      : deltaTime(dt), frameIndex(idx) {}
};
