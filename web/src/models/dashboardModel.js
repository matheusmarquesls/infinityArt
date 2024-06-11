
var database = require("../database/config");

function dadosGraficoDht(idObras) {
    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function dadosGraficoDht()");
    var instrucaoSql = `
        select * from vw_grafico_dht
        where id = ${idObras};   
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function dadosGraficoLdr(idObras) {
    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function dadosGraficoLdr()");
    var instrucaoSql = `
        select * from vw_grafico_ldr
        where id = ${idObras};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function dadosGraficoSemana(idObras) {
    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function dadosGraficoSemana()");
    var instrucaoSql = `
        select 

    'Segunda-feira' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 0 and id = ${idObras}) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 0 and id = ${idObras}) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 0 and id = ${idObras}) as limites_atingidos

union all

select 
    'Terça-feira' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 1 and id = ${idObras}) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 1 and id = ${idObras}) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 1 and id = ${idObras}) as limites_atingidos

union all

select 
    'Quarta-feira' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 2 and id = ${idObras}) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 2 and id = ${idObras}) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 2 and id = ${idObras}) as limites_atingidos

union all

select 
    'Quinta-feira' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 3 and id = ${idObras}) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 3 and id = ${idObras}) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 3 and id = ${idObras}) as limites_atingidos

union all

select 
	
    'Sexta-feira' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 4 and id = ${idObras}) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 4 and id = ${idObras}) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 4 and id = ${idObras}) as limites_atingidos

union all

select 
    'Sábado' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 5 and id = ${idObras}) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 5 and id = ${idObras}) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 5 and id = ${idObras}) as limites_atingidos

union all

select 
    'Domingo' as dia_da_semana,
    (select (sum(vw_temp.qtd_min_temp) + sum(vw_temp.qtd_max_temp)) from vw_temp where vw_temp.dia_da_semana = 6 and id = ${idObras}) +
    (select (sum(vw_umid.qtd_min_umid) + sum(vw_umid.qtd_max_umid)) from vw_umid where vw_umid.dia_da_semana = 6 and id = ${idObras}) +
    (select (sum(vw_lux.qtd_max_lux)) from vw_lux where vw_lux.dia_da_semana = 6 and id = ${idObras}) as limites_atingidos;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function dadosGraficoEstado(idObras) {
    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function dadosGraficoEstado()");
    var instrucaoSql = `
    select 
        sum(qtd_min_lux) as minimo,
        sum(qtd_max_lux) as maximo
        from vw_lux_dia_atual
        where id = ${idObras} and date(dataL) = current_date()
    union all
        select 
        sum(qtd_min_umid) as minimo,
        sum(qtd_max_umid) as maximo
        from vw_umid_dia_atual
        where id = ${idObras} and date(dataL) = current_date()
    union all
        select 
        sum(qtd_min_temp) as minimo,
        sum(qtd_max_temp) as maximo
        from vw_temp_dia_atual
        where id = ${idObras} and date(dataL) = current_date();
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarKpis(idObras) {
    console.log("ACESSEI O AVISO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listarKpis()");
    var instrucaoSql = `
        select 
            sum(qtd_min_lux) as minimo,
            sum(qtd_max_lux) as maximo
            from vw_lux_dia_atual
            where id = ${idObras} and date(dataL) = current_date()
        union all
        select 
            sum(qtd_min_umid) as minimo,
            sum(qtd_max_umid) as maximo
            from vw_umid_dia_atual
            where id = ${idObras} and date(dataL) = current_date()
        union all
            select 
            sum(qtd_min_temp) as minimo,
            sum(qtd_max_temp) as maximo
            from vw_temp_dia_atual
            where id = ${idObras} and date(dataL) = current_date();
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    dadosGraficoDht,
    dadosGraficoLdr,
    dadosGraficoSemana,
    dadosGraficoEstado,
    listarKpis
}