{-# LANGUAGE OverloadedStrings #-}

module Correios (
  fetchCep,
) where

import Control.Lens                          ((.~), (&), (^.))
import Data.ByteString.Lazy.Internal         (ByteString)
import qualified Data.ByteString.Char8 as BS (pack)
import qualified Network.Wreq          as WR (Response, responseBody, postWith, defaults, header)
import qualified Text.XML.Light        as XM (parseXML)

-- fetchCep :: String -> IO (WR.Response ByteString)
-- fetchCep cep = do
--   xmlString <- fetchXML cep

------ Example code from Rosetta code to get Student.Name from a XML string ------
-- xmlRead elm name  = mapM_ putStrLn
--   . concatMap (map (fromJust.findAttr (unqual name)).filterElementsName (== unqual elm))
--   . onlyElems
--   . parseXML

xmlRead "Student" "Name" students

fetchXML :: String -> IO (ByteString)
fetchXML cep = do
  response <- WR.postWith opts url payload
  return (response ^. WR.responseBody)
    where payload     = BS.pack xml
          contentType = BS.pack "application/xml; charset=utf-8"
          opts        = WR.defaults & WR.header "Content-Type" .~ [contentType]
          url         = "https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl"
          xml         = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:cli=\"http://cliente.bean.master.sigep.bsb.correios.com.br/\"><soapenv:Header/><soapenv:Body><cli:consultaCEP><cep>" ++ cep ++ "</cep></cli:consultaCEP></soapenv:Body></soapenv:Envelope>"