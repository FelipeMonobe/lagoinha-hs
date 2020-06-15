module Main (
  main,
) where

import qualified Control.Monad              as MN (forM)
import qualified Control.Concurrent.Async   as AS (async, waitAnyCancel)
import qualified Network.Lagoinha.Correios  as CO (fetchEndereco)
import qualified Network.Lagoinha.ViaCep    as VC (fetchEndereco)
import qualified Network.Lagoinha.CepAberto as CA (fetchEndereco)
import qualified Network.Lagoinha.Widenet   as WN (fetchEndereco)

main :: IO ()
main = do
  putStrLn "Qual CEP buscar?"
  cep      <- getLine
  requests <- MN.forM [ VC.fetchEndereco
                      , CO.fetchEndereco
                      , CA.fetchEndereco
                      , WN.fetchEndereco
                      ] $ \fn -> AS.async $ fn cep
  (_, response) <- AS.waitAnyCancel requests
  print response