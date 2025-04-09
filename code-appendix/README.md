# `code-appendix` Extension For Quarto

Moves the display of code chunks when `echo: true` to an appendix at the end of 
`.qmd` documents. Also can facilitate writing the code chunks to a user-defined 
file, if desired. Compatible with `pdf`, `typst`, `html`, `docx`, and possibly 
other formats. 

## Use case 

This filter is useful when you want to include the outputs of analysis code in a 
Quarto document but don't want the code chunks themselves displayed until the 
very end. Such a scenario might be a homework assignment, an analysis 
presented to both technical and non-technical readers, or a blog post which focuses
on the analysis itself (i.e., not a tutorial).

The traditional way to control the location of code chunks in the rendered/knit 
`.qmd`/`.rmd` document is to use `ref.label` (when using `knitr` engine). 
For example [#6650](https://github.com/quarto-dev/quarto-cli/discussions/6650#discussioncomment-6861503).
This filter represents a simpler but less flexible tool to achieve the same goal. 

## Features

When enabled, this filter stops the rendering of code chunks throughout the main 
body of the document and instead prints them altogether in an appendix at the 
end. The behavior of the filter can be controlled using the following YAML options:

- `code-appendix-title: str`. A string giving the code appendix title. Defaults to "Code".
- `code-appendix-header-level: int`. An integer giving the code appendix header 
  level. Defaults to 1. 
- `code-appendix-file: str`. A string giving a path pointing to an external file 
  to write the code chunks to. If not specified, no file is written. File path is relative
  to the location of the `.qmd` file for which a code appendix is desired. If 
  no file extension is included, the code chunks are written to a `.md` file by 
  default.
- `code-appendix-write: bool`. If `false`, don't create code appendix when rendering
  `.qmd`. If `true` do create code appendix. Defaults to `true`.

For greatest flexibility, users can write code chunks to an external `.qmd` file
using `code-appendix-file`, make edits by hand if necessary, then include in the 
main document via the `{{< include >}}` shortcode. Note that this workflow would
require two renderings: one to create external file and one to render the appendix
with the `{{< include >}}` shortcode and `code-appendix-write: false` to turn off
the automatic appendix. 

Note that `echo: true` must be set in the document YAML for this filter to be 
useful. Otherwise, no code chunks are available to the filter to create a code 
appendix.

## Installing

```bash
quarto add cl-roberts/.lua-filters/code-appendix
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

Basic usage requires writing `.qmd` files which contain code chunks that you would
like to display as an appendix at the end of the document. In the YAML of your Quarto 
document, include the following lines:

```
filters:
    - code-appendix
```

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

