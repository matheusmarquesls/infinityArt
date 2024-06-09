var express = require("express");
var router = express.Router();

var ambientesController = require("../controllers/ambientesController");

router.get("/listarAmbientes/:idUsuario/:idEndereco", function (req, res) {
    ambientesController.listarAmbientes(req, res);
});

module.exports = router;