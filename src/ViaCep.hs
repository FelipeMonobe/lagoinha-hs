module ViaCep (
  fetchCep,
) where

import Data.ByteString.Lazy.Internal (ByteString)
import qualified Network.Wreq  as WR (Response, get)

fetchCep :: String -> IO (WR.Response ByteString)
fetchCep cep  = WR.get (url ++ cep ++ "/json/")
  where url   = "https://viacep.com.br/ws/"