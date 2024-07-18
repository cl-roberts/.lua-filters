
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

-- detects project name as the parent directory to _extensions
local function getProjectName(path)

  pattern1 = ".*//(.*)//_extensions//"
  pattern2 = ".*\\(.*)\\_extensions\\"

  if (string.match(path, pattern1) == nil) then
    return string.match(path, pattern2)
  else
    return string.match(path, pattern1)
  end

end

-- helps pandoc convert quarto divs to typst blocks
function Div(el)

  project = string.gsub(getProjectName(PANDOC_SCRIPT_FILE), "%-", "%%-")

  if string.match(tostring(el.classes), project) then

    divName = string.match(tostring(el.classes), project .. "%-(.*)%}")
    local blocks = pandoc.List({
      pandoc.RawBlock('typst', '#' .. divName .. '[')
    })
    blocks:extend(el.content)
    return endTypstBlock(blocks)

  end

end

