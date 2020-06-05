module CepAberto (
  fetchEndereco,
) where

import Control.Lens                          ((.~), (&), (^.))
import Data.ByteString.Lazy.Internal         (ByteString)
import Data.Aeson                            ((.:), FromJSON (..))
import Endereco                              (Endereco (..))
import qualified Data.Aeson            as AE (decode, withObject)
import qualified Data.ByteString.Char8 as BS (pack)
import qualified Network.Wreq          as WR (getWith, defaults, header, responseBody)
import qualified Data.Maybe            as MB (fromJust)

instance FromJSON Endereco where
  parseJSON = AE.withObject "endereco" $ \o -> do
    est         <- o   .: "estado"
    cid         <- o   .: "cidade"
    uf          <- est .: "sigla"
    cidade      <- cid .: "nome"
    bairro      <- o   .: "bairro"
    cep         <- o   .: "cep"
    logradouro  <- o   .: "logradouro"
    complemento <- o   .: "complemento"
    return Endereco {..}

fetchEndereco :: String -> IO (Endereco)
fetchEndereco c = do
  jsonStr  <- fetchJSON c
  endereco <- parseEndereco jsonStr
  putStrLn "[CONCLUÍDO] Requisição em http://www.cepaberto.com"
  return endereco

parseEndereco :: ByteString -> IO (Endereco)
parseEndereco x = do
  return $ MB.fromJust $ AE.decode x

fetchJSON :: String -> IO (ByteString)
fetchJSON c = do
  let token = BS.pack "Token token=d60b6b7a01a6302dd124382f34561bd9"
  let opts  = WR.defaults & WR.header "Authorization" .~ [token]
  response <- WR.getWith opts $ "http://www.cepaberto.com/api/v3/cep?cep=" ++ c
  return $ response ^. WR.responseBody