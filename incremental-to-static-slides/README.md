# Incremental-to-static-slides Extension For Quarto

This extension simply removes lines that contain ". . ." in a quarto document. The intention is to make presentation slides with Quarto and increment bullet points using ". . ." syntax, then use `incremental-to-static-slides.lua` to toggle off that feature.

## Use case

You are giving a talk. You want the bullet points in said talk to increment as you go, so your listeners aren't overwhelmed by a wall of text on each slide. BUT... you go to share your slides with a colleague (or print them for students, etc.) and face the realization that your 30-slide presentation actually has 67 slides because every bullet point is tediously printed one-at-a-time. There must be a better way...

Use this lua-filter to delete the ". . ." lines at rendering so you can create a static version of your presentation without further work.

## Installing

Install this extension with the following shell command

```bash
quarto add cl-roberts/lua-filters/incremental-to-static-slides
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

Basic usage requires including the following lines into the YAML of your Quarto document. I recommend commenting/uncommenting those lines for when you need static/incremental slides, respectively.

> filters: 
> 
> &nbsp;&nbsp; - incremental-to-static-slides

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

