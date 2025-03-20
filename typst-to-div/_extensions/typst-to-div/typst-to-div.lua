
-- | Use custom typst functions as quarto divs | --

-- inserts ] at the end of typst block
local function endTypstBlock(blocks)

  local lastBlock = blocks[#blocks]

  if lastBlock.t == "Para" or lastBlock.t == "Plain" then

    lastBlock.content:insert(pandoc.RawInline('typst', '\n]'))
    return blocks

  else

    blocks:insert(pandoc.RawBlock('typst', ']\n'))
    return blocks

  end
end

-- gets options for preferred prefixes from the document meta, or falls back
-- if not specified
function readMeta(m)
  if m["typst-block-prefix"] ~= nil then
    typst_block_prefix = pandoc.utils.stringify(m["typst-block-prefix"])
  else
    typst_block_prefix = "typst-block"
  end

  if m["typst-inline-prefix"] ~= nil then
    typst_inline_prefix = pandoc.utils.stringify(m["typst-inline-prefix"])
  else
    typst_inline_prefix = "typst-inline"
  end
end

-- helps pandoc convert quarto divs to typst blocks
function convertDiv(el)

  quarto.log.output("checking block" .. tostring(el.classes) ..
    " against " .. typst_block_prefix)

  -- if block prefix is found in the classes for the content div, it is
  -- wrapped in a raw typst block using the corresponding style
  if string.match(tostring(el.classes) .. "-", typst_block_prefix) then

    quarto.log.output("FOUND BLOCK")

    divName = string.match(
      tostring(el.classes),
      typst_block_prefix .. "%-(.*)%}")
    local blocks = pandoc.List({
      pandoc.RawBlock('typst', '#' .. divName .. '[')
    })
    blocks:extend(el.content)
    return endTypstBlock(blocks)

  end

end

-- helps pandoc convert quarto spans to typst inlines
function convertInline(el)

  quarto.log.output("checking inline: " .. tostring(el.classes) ..
    " against " .. typst_inline_prefix)

  -- if block prefix is found in the classes for the content div, it is
  -- wrapped in a raw typst block using the corresponding style
  if string.match(tostring(el.classes) .. "-", typst_inline_prefix) then

    quarto.log.output("FOUND INLINE")

    inlineName = string.match(
      tostring(el.classes),
      typst_inline_prefix .. "%-(.*)%}")
    local inlines = pandoc.List({
      pandoc.RawInline('typst', '#' .. inlineName .. '[')
    })

    el.content:insert(pandoc.RawInline('typst', ']'))
    inlines:extend(el.content)
    return inlines

  end

end

return {
  {
    Meta = readMeta
  },
  {
    Div = convertDiv,
    Span = convertInline
  }
}
