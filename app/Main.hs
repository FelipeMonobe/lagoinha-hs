module Main where

import Correios              as CO (fetchCep)
import ViaCep                as VC (fetchCep)
import CepAberto             as CA (fetchCep)
import Widenet               as WN (fetchCep)

main :: IO ()
main = do
    putStrLn "Qual CEP devo buscar?"
    cep <- getLine
    -- response <- CO.fetchCep cep
    -- response <- VC.fetchCep cep
    -- response <- CA.fetchCep cep
    -- response <- WN.fetchCep cep
    print response