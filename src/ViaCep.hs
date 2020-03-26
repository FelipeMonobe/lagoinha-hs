module ViaCep (
  fetchCep,
) where

import Control.Lens                  ((^.))
import Data.ByteString.Lazy.Internal (ByteString)
import qualified Network.Wreq  as WR (Response, get, responseBody)

fetchCep :: String -> IO (ByteString)
fetchCep cep = do
  response <- WR.get url
  return (response ^. WR.responseBody)
    where url = endpoint ++ cep ++ format
          endpoint = "https://viacep.com.br/ws/"
          format   = "/json"