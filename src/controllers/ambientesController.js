var ambientesModel = require("../models/ambientesModel");

function listarAmbientes(req, res) {
    var idUsuario = req.params.idUsuario;
    var idEndereco = req.params.idEndereco;

    ambientesModel.listarAmbientes(idUsuario, idEndereco)
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
    listarAmbientes
}