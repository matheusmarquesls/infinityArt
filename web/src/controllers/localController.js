var localModel = require("../models/localModel");

function cadastrarEndereco(req, res) {

    var idUsuario = req.params.idUsuario;
    var nome = req.body.nomeServer;
    var estado = req.body.estadoServer;
    var cidade = req.body.cidadeServer;
    var bairro = req.body.bairroServer;
    var logradouro = req.body.logradouroServer;
    var complemento = req.body.complementoServer;
    var cep = req.body.cepServer;

    if (!idUsuario) {
        return res.status(400).send("ID do usuário não fornecido");
    }

    localModel.cadastrarEndereco(idUsuario, nome, estado, cidade, bairro, logradouro, complemento, cep)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.status(200).json(resultado);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "Houve um erro ao buscar os avisos: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function cadastrarAmbientes(req, res) {

    var idEndereco = req.params.idEndereco;
    var nome = req.body.nome;

    if (!nome) {
        return res.status(400).send("ID do nome não fornecido");
    }
    if (!idEndereco) {
        return res.status(400).send("ID do endereco não fornecido");
    }
    
    localModel.cadastrarAmbientes(idEndereco, nome)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.status(200).json(resultado);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "Houve um erro ao buscar os avisos: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}


function cadastrarObras(req, res) {

    var idAmbiente = req.params.idAmbiente;
    var nome = req.body.nome;
    var tinta = req.body.tinta;

    if (!nome) {
        return res.status(400).send("ID do nome não fornecido");
    }
    if (!tinta) {
        return res.status(400).send("ID da tinta não fornecido");
        }
    if (!idAmbiente) {
        return res.status(400).send("ID do ambiente não fornecido");
    }
    


    
    localModel.cadastrarObras(idAmbiente, nome, tinta)
        .then(
            function (resultado) {
                if (resultado.length > 0) {
                    res.status(200).json(resultado);
                } else {
                    res.status(204).send("Nenhum resultado encontrado!");
                }
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "Houve um erro ao buscar os avisos: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}


module.exports = {
    cadastrarEndereco,
    cadastrarAmbientes,
    cadastrarObras,
}