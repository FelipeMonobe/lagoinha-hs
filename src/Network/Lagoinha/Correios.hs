module Network.Lagoinha.Correios (
  fetchEndereco,
) where

import Control.Lens                          ((.~), (&), (^.))
import Data.ByteString.Lazy.Internal         (ByteString)
import Text.XML.Light.Types                  (Element)
import Network.Lagoinha.Types                (Endereco (..))
import qualified Data.ByteString.Char8 as BS (pack)
import qualified Network.Wreq          as WR (responseBody, postWith, defaults, header)
import qualified Text.XML.Light        as XM (unqual, parseXMLDoc, findElement, strContent)
import qualified Data.Maybe            as MB (fromJust)

fetchEndereco :: String -> IO (Endereco)
fetchEndereco c = do
  xmlString <- fetchXML c
  let xml    = MB.fromJust $ XM.parseXMLDoc xmlString
  endereco  <- parseEndereco xml
  putStrLn "[CONCLUÍDO] Requisição em https://apps.correios.com.br"
  return endereco

parseEndereco :: Element -> IO (Endereco)
parseEndereco x = do
  let prop p = XM.strContent $ MB.fromJust $ XM.findElement (XM.unqual p) x
  return Endereco { uf = prop "uf"
                  , cidade = prop "cidade"
                  , bairro = prop "bairro"
                  , cep = prop "cep"
                  , logradouro = prop "end"
                  , complemento = prop "complemento2"
                  }

fetchXML :: String -> IO (ByteString)
fetchXML c = do
  let opts    = WR.defaults & WR.header "Content-Type" .~ [BS.pack "application/xml; charset=utf-8"]
  let url     = "https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl"
  let payload = BS.pack $ "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:cli=\"http://cliente.bean.master.sigep.bsb.correios.com.br/\"><soapenv:Header/><soapenv:Body><cli:consultaCEP><cep>" ++ c ++ "</cep></cli:consultaCEP></soapenv:Body></soapenv:Envelope>"
  response   <- WR.postWith opts url payload
  return $ response ^. WR.responseBody