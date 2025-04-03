

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
-- writes appendix to txt file if desired
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

  -- write appendix to text file
  if m["code-appendix-write"] ~= nil then

    codeAppendixWrite = pandoc.utils.stringify(m["code-appendix-write"])

    if codeAppendixWrite == "true" then
      local f = io.open(pandoc.system.get_working_directory() .. '/code-appendix.txt', 'w')
      for index, value in ipairs(pandoc.List(appendix)) do
        f:write(pandoc.List(appendix)[index].text .. "\n\n")
      end
      f:close()
    end
  
  end

  return m

end

-- append pandoc document with source code
function Pandoc(doc)
  
  appendixHeader = pandoc.Header(codeAppendixHeaderLevel, codeAppendixTitle)
  doc.blocks:extend(pandoc.List({appendixHeader}))
  doc.blocks:extend(pandoc.List(appendix))

  return doc

end
