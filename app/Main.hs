module Main where

import Correios         as CO (fetchCep)
import ViaCep           as VC (fetchCep)
import CepAberto        as CA (fetchCep)
import Control.Lens           ((^.))
import Network.Wreq     as R  (responseBody)
import qualified Text.XML.Light.Input  as XM (parseXML)

main :: IO ()
main = do
    XM.parseXML "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ns2:consultaCEPResponse xmlns:ns2=\"http://cliente.bean.master.sigep.bsb.correios.com.br/\"><return><bairro>Vila Morse</bairro><cep>05624001</cep><cidade>S\195\163o Paulo</cidade><complemento2>- de 601/602 ao fim</complemento2><end>Rua Manuel Jacinto</end><uf>SP</uf></return></ns2:consultaCEPResponse></soap:Body></soap:Envelope>"
    -- putStrLn "Qual CEP devo buscar?"
    -- cep <- getLine
    -- response <- CO.fetchCep cep
    -- print (response ^. R.responseBody)

    -- response <- VC.fetchCep cep
    -- response <- CA.fetchCep cep
    -- print (response ^. R.responseBody)