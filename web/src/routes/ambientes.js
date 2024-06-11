var express = require("express");
var router = express.Router();

var ambientesController = require("../controllers/ambientesController");

router.post("/listarAmbientes/:idUsuario", function (req, res) {
    ambientesController.listarAmbientes(req, res);
});

module.exports = router;