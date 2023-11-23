module ExtensionUtils where

import Effect (Effect)

foreign import data ExtensionMetadata :: Type

foreign import getPath :: ExtensionMetadata -> String -> Effect String
