module Main where

import Correios  as CO (fetchCep)
import ViaCep    as VC (fetchCep)
import CepAberto as CA (fetchCep)
import Widenet   as WN (fetchCep)

data Endereco = Endereco
  { uf          :: String
  , cidade      :: String
  , bairro      :: String
  , cep         :: String
  , logradouro  :: String
  , numero      :: Int
  , complemento :: String
  } deriving (Show)

main :: IO ()
main = do
  putStrLn "Qual CEP devo buscar?"
  cep <- getLine
  response <- CO.fetchCep cep
  -- response <- VC.fetchCep cep
  -- response <- CA.fetchCep cep
  -- response <- WN.fetchCep cep
  print response