# typst-to-div Extension For Quarto

Enables using custom typst functions from a `typst-template.typ` file as a
div when authoring in Quarto. This filter is a generalization of 
[this one](https://github.com/quarto-ext/typst-templates/blob/main/ams/_extensions/ams/ams.lua). 

## Use case

The standard way to run `.qmd` content through custom typst styling appears to 
be to wrap said content in typst blocks, e.g.

````
```{=typst}
#block(
    fill:luma(230), 
    inset:16pt,
    outset:-8pt, 
    radius:4pt,
    [
```

...quarto content...

```{=typst}
    ]   
) 
```
````

This lua filter provides syntactic sugar for instead applying typst styling 
via quarto divs and spans, e.g. the following typst code gets placed into a 
`typst-template.typ` file:

```
#let myblock(text) = block(text,
    fill:luma(230), 
    inset:16pt,
    outset:-8pt, 
    radius:4pt
  )
```

then called as a div in the `.qmd`:

```
::: {tb-myblock}
...quarto content...
:::
```

There is support for inline styling as well. Simply declare the function 

```
#let mytext(body) = text(red)[#body]
```

and call it inline via `[spans]{.ti-mytext}`. Note that the div and span classes 
are named the user-defined typst function names with prefixes that can be set in 
the document YAML (separated with a `-`). 

## Installing

```bash
quarto add cl-roberts/lua-filters/typst-to-div
```

This will install the extension under the _extensions subdirectory. If you're
using version control, you will want to check in this directory.

## Using

Basic usage requires writing `.qmd` files which contain content that you would
like to render as pdf using `format: typst`. In the YAML of your Quarto 
document, include the following lines:

> filters: 
> 
> &nbsp;&nbsp; - typst-to-div

Set the div and span prefixes in the document YAML with 

> typst-block-prefix: tb
> 
> typst-inline-prefix: ti

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

