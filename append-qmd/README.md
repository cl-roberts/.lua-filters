# Append-qmd Extension For Quarto

This extension automatically appends your Quarto document with provided `.qmd` files. 

## Use case

You have some generic appendices that you would like to include at the end of several reports, presentations,
blog entries, etc. However, copy/pasting those appendices into every separate Quarto document is a waste of 
time and error prone. If only there was a way to include generic material at rendering as a one-liner...

## Installing

```bash
quarto add clroberts-adfg/lua-filters/append-qmd
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

Basic usage requires writing `.qmd` files which contain content that you would like to append to another
Quarto document. Then place those files in the same directory as the `append-qmd.lua` script (i.e. at
`_extensions/append-qmd`). Then include the following lines into the YAML of your Quarto document. 
Commenting/uncommenting those lines will toggle inclusion of the appendices.

> filters: 
> 
> &nbsp;&nbsp; - append-qmd

Note that this filter is greedy in the sense that it will include any `.qmd` file in the above directory.
To customize behavior, it will be necessary to make copies of the directory, include different appendix
files, and strategically place near your projects as needed. 
 
## Example

Here is the source code for an example revealJS slideshow with 2 appendices: [example.qmd](example.qmd). 
This filter *should* work with any output format in any OS (not tested).

