var database = require("../database/config");

function listarAmbientes(idUsuario, idEndereco) {

    console.log(`Console idEndereco no model ${idEndereco}`)

    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listarAmbientes()");
    var instrucaoSql = `

         select id, nome, qtd_obras, situacao
         from vw_select_ambientes
         where idUsuario = ${idUsuario} and endereco = ${idEndereco};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    listarAmbientes
}