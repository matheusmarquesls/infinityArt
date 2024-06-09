var express = require("express");
var router = express.Router();

var enderecosController = require("../controllers/enderecosController");

router.get("/listarEnderecos/:idUsuario", function (req, res) {
    enderecosController.listarEnderecos(req, res);
});

module.exports = router;