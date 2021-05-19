let Extension = { Type = { name : Text, domain : Text }, default = {=} }

let render =
      \(extension : Extension.Type) ->
        { `.gitattributes` =
            "/${extension.name}@${extension.domain}/ linguist-generated=true"
        }

in  { Extension, render }
