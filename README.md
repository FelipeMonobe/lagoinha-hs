# lagoinha-hs
> Haskell project inspired by https://github.com/IgorHalfeld/lagoinha.
---
## About
✔️ - This project is mainly a Haskell study case, therefore susceptible to change, that can generate an executable/program from its source code.
<br>
❌ - This project isn't a library to install and import into your current project to use.

## What it does
When executed, this program prompts for a brazilian zip code (CEP) and then <b>races</b> 4 concurrent fetch requests for its address components. The result is printed in [Endereco](src/Endereco.hs) type format.<br>
Current services are Cep Aberto, Correios, Via CEP and Widenet.

## Usage (with stack)
```sh
> git clone git@github.com:FelipeMonobe/lagoinha-hs.git
> cd lagoinha-hs
> stack build
> stack exec lagoinha-hs-exe
```
>⚠️ Change git clone url accordingly with your preference.