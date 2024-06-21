# theastroshed-pixinsight-scripts

repository for PixInsight scripts and utilities

## Fix Tiled Zoom

I like to tile my calibrated and integrated master frames, then stretch and zoom them to fit the window.
If you check the "automatic zoom calculation" checkbox it will try to find the zoom that works best for _each window_

Additionally, it will do an STF auto stretch on each window.

If you save a process icon you can drop it onto one window and it will work globally

## Smart Rename View

This script simply renames the main view of an image to match whatever is in 
the filter, which allows you to hardcode values in your process icons (For example,
Red, Green, and Blue) rather than having to manually change them.

You can set a prefix and suffix, for example `foo_` and `_bar`, and the resulting
view name would be `foo_<filter>_bar`, or `foo_Red_bar`.
    
If you click the `Batch-mode cheat enabled` and save a process icon it will apply to
_all_ image windows rather than just the one you drop it on (kind of like a global apply)