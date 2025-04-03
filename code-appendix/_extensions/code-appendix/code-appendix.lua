

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

-- append pandoc document with source code
function Pandoc(el)
  
  appendixHeader = pandoc.Header(1, pandoc.Str "test")
  el.blocks:extend(pandoc.List({appendixHeader}))
  el.blocks:extend(pandoc.List(appendix))

  return el

end

