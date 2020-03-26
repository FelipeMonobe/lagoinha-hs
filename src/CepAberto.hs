{-# LANGUAGE OverloadedStrings #-}

module CepAberto (
  fetchCep,
) where

import Control.Lens                          ((.~), (&), (^.))
import Data.ByteString.Lazy.Internal         (ByteString)
import qualified Data.ByteString.Char8 as BS (pack)
import qualified Network.Wreq          as WR (Response, getWith, defaults, header, responseBody)

fetchCep :: String -> IO (ByteString)
fetchCep cep  = do
  response <- WR.getWith opts url
  return (response ^. WR.responseBody)
    where token    = BS.pack "Token token=d60b6b7a01a6302dd124382f34561bd9"
          opts     = WR.defaults & WR.header "Authorization" .~ [token]
          url      = endpoint ++ cep
          endpoint = "http://www.cepaberto.com/api/v3/cep?cep="