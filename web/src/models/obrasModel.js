
var database = require("../database/config");

function listarObras(idAmbiente) {
    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listarPorUsuario()");
    var instrucaoSql = `
    select id, nome, tipo_tinta, situacao 
    from vw_select_obras 
    where id_ambiente = ${idAmbiente}
    order by situacao desc;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarKpis(idAmbiente) {
    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listarPorUsuario()");
    var instrucaoSql = `
    select 
    count(id) kpis
    from vw_select_obras 
    where id_ambiente = ${idAmbiente}
    union
    select 
    count(situacao) 
    from vw_select_obras 
    where situacao = 1 and id_ambiente = ${idAmbiente};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    listarObras,
    listarKpis
}