{-# LANGUAGE OverloadedStrings #-}

module Correios (
  fetchCep,
) where

import Control.Lens                          ((.~), (&))
import Data.ByteString.Lazy.Internal         (ByteString)
import qualified Data.ByteString.Char8 as BS (pack)
import qualified Network.Wreq          as WR (Response, postWith, defaults, header)
import qualified Text.XML.Light        as XM (parseXML)

-- fetchCep :: String -> IO (WR.Response ByteString)
fetchCep cep = fetchXML
  -- where xmlString = (fetchXML cep) ^. WR.responseBody
  -- mapM_ putStrLn
  --     . concatMap (map (fromJust.findAttr (unqual name)).filterElementsName (== unqual elm))
  --     . onlyElems.  parseXML

fetchXML :: String -> IO (WR.Response ByteString)
fetchXML cep        = (WR.postWith opts url payload)
  where payload     = BS.pack ("<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:cli=\"http://cliente.bean.master.sigep.bsb.correios.com.br/\"><soapenv:Header/><soapenv:Body><cli:consultaCEP><cep>" ++ cep ++ "</cep></cli:consultaCEP></soapenv:Body></soapenv:Envelope>")
        contentType = BS.pack "application/xml; charset=utf-8"
        opts        = WR.defaults & WR.header "Content-Type" .~ [contentType]
        url         = "https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl"