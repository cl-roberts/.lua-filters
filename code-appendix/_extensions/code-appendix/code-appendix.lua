

-- remove source code in CodeBlocks from main body and save to appendix
appendix = {}

function CodeBlock(el)

  if el.classes[2] == "cell-code" then 
    table.insert(appendix, el)
    return {}
  else 
    return el
  end

end

-- reads yaml to obtain desired header for code appendix
-- writes appendix to file
function Meta(m)

  if m["code-appendix-title"] ~= nil then
    codeAppendixTitle = pandoc.utils.stringify(m["code-appendix-title"])
  else
    codeAppendixTitle = pandoc.Str("Code")
  end

  if m["code-appendix-header-level"] ~= nil then
    codeAppendixHeaderLevel = tonumber(pandoc.utils.stringify(m["code-appendix-header-level"]))
  else
    codeAppendixHeaderLevel = 1
  end

  if m["code-appendix-write"] ~= nil then
    codeAppendixWrite = m["code-appendix-write"]
  else
    codeAppendixWrite = true
  end

  -- write appendix to file
  if m["code-appendix-file"] ~= nil then

    codeAppendixFile = pandoc.utils.stringify(m["code-appendix-file"])    
    codeAppendixExt = codeAppendixFile:match("%.[^.]+$")    

    if codeAppendixExt == nil then
      codeAppendixExt = ".md"
      codeAppendixFile = codeAppendixFile .. codeAppendixExt
    end

    local f = io.open(pandoc.system.get_working_directory() .. "/" .. codeAppendixFile, 'w')
 
    for index, value in ipairs(pandoc.List(appendix)) do
      if codeAppendixExt == ".md" or codeAppendixExt == ".qmd" then
        f:write(
          "```" .. "\n" .. pandoc.List(appendix)[index].text .. "\n" .. "```" .. "\n\n"
        )
      else 
        f:write(
          pandoc.List(appendix)[index].text .. "\n\n"
        )  
      end
    end
    
    f:close()

  end

  return m

end

-- append pandoc document with source code
function Pandoc(doc)

  if codeAppendixWrite then
    appendixHeader = pandoc.Header(codeAppendixHeaderLevel, codeAppendixTitle)
    doc.blocks:extend(pandoc.List({appendixHeader}))
    doc.blocks:extend(pandoc.List(appendix))
  end

  return doc

end
