
-- Remove Para's that consist of . . .
return {
  {
    Para = function(elem)
      test = 0
      for i = 1, 5, 2 do
        if elem.content[i] == pandoc.Str "." then
          test = test + 1
        end
      end
      if test == 3 then
        elem.content = {{nil}}
      end
      return elem
    end
  }
}
