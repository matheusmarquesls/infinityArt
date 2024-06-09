// var ambiente_processo = 'producao';
var ambiente_processo = 'desenvolvimento';

var caminho_env = ambiente_processo === 'producao' ? '.env' : '.env.dev';
// Acima, temos o uso do operador ternário para definir o caminho do arquivo .env
// A sintaxe do operador ternário é: condição ? valor_se_verdadeiro : valor_se_falso

require("dotenv").config({ path: caminho_env });

var express = require("express");
var cors = require("cors");
var path = require("path");
var PORTA_APP = process.env.APP_PORT;
var HOST_APP = process.env.APP_HOST;

var app = express();

var indexRouter = require("./src/routes/index");
var usuarioRouter = require("./src/routes/usuarios");
var avisosRouter = require("./src/routes/avisos");
var enderecoRouter = require("./src/routes/enderecos");
var ambientesRouter = require("./src/routes/ambientes");

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

app.use(cors());

app.use("/", indexRouter);
app.use("/usuarios", usuarioRouter);
app.use("/avisos", avisosRouter);
app.use("/enderecos", enderecoRouter);
app.use("/ambientes", ambientesRouter);

app.listen(PORTA_APP, function () {
    console.log(`                                                                                                                                                                                                                                                                                                                                                                                                      
IIIIIIIIII                   ffffffffffffffff    iiii                     iiii          tttt                                                   AAA                                           tttt          
I::::::::I                  f::::::::::::::::f  i::::i                   i::::i      ttt:::t                                                  A:::A                                       ttt:::t          
I::::::::I                 f::::::::::::::::::f  iiii                     iiii       t:::::t                                                 A:::::A                                      t:::::t          
II::::::II                 f::::::fffffff:::::f                                      t:::::t                                                A:::::::A                                     t:::::t          
  I::::Innnn  nnnnnnnn     f:::::f       ffffffiiiiiiinnnn  nnnnnnnn    iiiiiiittttttt:::::tttttttyyyyyyy           yyyyyyy                A:::::::::A          rrrrr   rrrrrrrrr   ttttttt:::::ttttttt    
  I::::In:::nn::::::::nn   f:::::f             i:::::in:::nn::::::::nn  i:::::it:::::::::::::::::t y:::::y         y:::::y                A:::::A:::::A         r::::rrr:::::::::r  t:::::::::::::::::t    
  I::::In::::::::::::::nn f:::::::ffffff        i::::in::::::::::::::nn  i::::it:::::::::::::::::t  y:::::y       y:::::y                A:::::A A:::::A        r:::::::::::::::::r t:::::::::::::::::t    
  I::::Inn:::::::::::::::nf::::::::::::f        i::::inn:::::::::::::::n i::::itttttt:::::::tttttt   y:::::y     y:::::y                A:::::A   A:::::A       rr::::::rrrrr::::::rtttttt:::::::tttttt    
  I::::I  n:::::nnnn:::::nf::::::::::::f        i::::i  n:::::nnnn:::::n i::::i      t:::::t          y:::::y   y:::::y                A:::::A     A:::::A       r:::::r     r:::::r      t:::::t          
  I::::I  n::::n    n::::nf:::::::ffffff        i::::i  n::::n    n::::n i::::i      t:::::t           y:::::y y:::::y                A:::::AAAAAAAAA:::::A      r:::::r     rrrrrrr      t:::::t          
  I::::I  n::::n    n::::n f:::::f              i::::i  n::::n    n::::n i::::i      t:::::t            y:::::y:::::y                A:::::::::::::::::::::A     r:::::r                  t:::::t          
  I::::I  n::::n    n::::n f:::::f              i::::i  n::::n    n::::n i::::i      t:::::t    tttttt   y:::::::::y                A:::::AAAAAAAAAAAAA:::::A    r:::::r                  t:::::t    tttttt
II::::::IIn::::n    n::::nf:::::::f            i::::::i n::::n    n::::ni::::::i     t::::::tttt:::::t    y:::::::y                A:::::A             A:::::A   r:::::r                  t::::::tttt:::::t
I::::::::In::::n    n::::nf:::::::f            i::::::i n::::n    n::::ni::::::i     tt::::::::::::::t     y:::::y                A:::::A               A:::::A  r:::::r                  tt::::::::::::::t
I::::::::In::::n    n::::nf:::::::f            i::::::i n::::n    n::::ni::::::i       tt:::::::::::tt    y:::::y                A:::::A                 A:::::A r:::::r                    tt:::::::::::tt
IIIIIIIIIInnnnnn    nnnnnnfffffffff            iiiiiiii nnnnnn    nnnnnniiiiiiii         ttttttttttt     y:::::y                AAAAAAA                   AAAAAAArrrrrrr                      ttttttttttt  
                                                                                                        y:::::y                                                                                            
                                                                                                       y:::::y                                                                                             
                                                                                                      y:::::y                                                                                              
                                                                                                     y:::::y                                                                                               
                                                                                                    yyyyyyy                                                                                                                                                                                 
    \n\n\n                                                                                                 
    Servidor do seu site já está rodando! Acesse o caminho a seguir para visualizar .: http://${HOST_APP}:${PORTA_APP} :. \n\n
    Você está rodando sua aplicação em ambiente de .:${process.env.AMBIENTE_PROCESSO}:. \n\n
    \tSe .:desenvolvimento:. você está se conectando ao banco local. \n
    \tSe .:producao:. você está se conectando ao banco remoto. \n\n
    \t\tPara alterar o ambiente, comente ou descomente as linhas 1 ou 2 no arquivo 'app.js'\n\n`);
});
