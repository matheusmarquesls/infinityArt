var database = require("../database/config");

function cadastrarEndereco(idUsuario, nome, estado, cidade , bairro, logradouro, complemento, cep) {


    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listarAmbientes()");
    var instrucaoSql = `
         insert into endereco (nome,estado,cidade,bairro,logradouro,complemento,cep,fkUsuario)
          values ('${nome}','${estado}','${cidade}','${bairro}','${logradouro}','${complemento}','${cep}', ${idUsuario});`
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    cadastrarEndereco
}