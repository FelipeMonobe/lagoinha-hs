module Widenet (
  fetchEndereco,
) where

import Data.Aeson
import Control.Lens                  ((^.))
import Data.ByteString.Lazy.Internal (ByteString)
import Endereco                      (Endereco (..))
import qualified Network.Wreq  as WR (get, responseBody)
import qualified Data.Maybe    as MB (fromJust)

instance FromJSON Endereco where
  parseJSON = withObject "endereco" $ \o -> do
    uf          <- o .: "state"
    cidade      <- o .: "city"
    bairro      <- o .: "district"
    cep         <- o .: "code"
    logradouro  <- o .: "address"
    complemento <- pure ""
    return Endereco {..}

fetchEndereco :: String -> IO (Endereco)
fetchEndereco c = do
  jsonStr  <- fetchJSON c
  endereco <- parseEndereco jsonStr
  putStrLn "[CONCLUÍDO] Requisição em https://apps.widenet.com.br"
  return endereco

parseEndereco :: ByteString -> IO (Endereco)
parseEndereco x = do
  return $ MB.fromJust $ decode x

fetchJSON :: String -> IO (ByteString)
fetchJSON c = do
  response <- WR.get $ "https://apps.widenet.com.br/busca-cep/api/cep/" ++ c ++ ".json"
  return $ response ^. WR.responseBody