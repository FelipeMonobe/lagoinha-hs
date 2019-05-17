{-# LANGUAGE OverloadedStrings #-}

module CepAberto (
  fetchCep,
) where

import Control.Lens                          ((.~), (&))
import Data.ByteString.Lazy.Internal         (ByteString)
import qualified Data.ByteString.Char8 as BS (pack)
import qualified Network.Wreq          as WR (Response, getWith, defaults, header)

fetchCep :: String -> IO (WR.Response ByteString)
fetchCep cep  = WR.getWith opts (url ++ cep)
  where token = BS.pack "Token token=37d718d2984e6452584a76d3d59d3a26"
        opts  = WR.defaults & WR.header "Authorization" .~ [token]
        url   = "http://www.cepaberto.com/api/v2/ceps.json?cep="