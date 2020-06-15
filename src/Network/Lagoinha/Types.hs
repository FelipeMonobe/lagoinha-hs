module Network.Lagoinha.Types (
  Endereco (..),
) where

data Endereco = Endereco
  { uf          :: String
  , cidade      :: String
  , bairro      :: String
  , cep         :: String
  , logradouro  :: String
  , complemento :: String
  } deriving (Show)