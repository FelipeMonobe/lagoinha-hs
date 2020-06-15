module Network.Lagoinha.ViaCep (
  fetchEndereco,
) where

import Data.Aeson
import Control.Lens                  ((^.))
import Data.ByteString.Lazy.Internal (ByteString)
import Network.Lagoinha.Types        (Endereco (..))
import qualified Network.Wreq  as WR (get, responseBody)
import qualified Data.Maybe    as MB (fromJust)

instance FromJSON Endereco where
  parseJSON = withObject "endereco" $ \o -> do
    uf          <- o .: "uf"
    cidade      <- o .: "localidade"
    bairro      <- o .: "bairro"
    cep         <- o .: "cep"
    logradouro  <- o .: "logradouro"
    complemento <- o .: "complemento"
    return Endereco {..}

fetchEndereco :: String -> IO (Endereco)
fetchEndereco c = do
  jsonStr  <- fetchJSON c
  endereco <- parseEndereco jsonStr
  putStrLn "[CONCLUÍDO] Requisição em https://viacep.com.br"
  return endereco

parseEndereco :: ByteString -> IO (Endereco)
parseEndereco x = do
  return $ MB.fromJust $ decode x

fetchJSON :: String -> IO (ByteString)
fetchJSON c = do
  response <- WR.get $ "https://viacep.com.br/ws/" ++ c ++ "/json"
  return $ response ^. WR.responseBody