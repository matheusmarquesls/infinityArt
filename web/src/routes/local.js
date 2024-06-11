var express = require("express");
var router = express.Router();

var localController = require("../controllers/localController");

router.post("/cadastrarEndereco/:idUsuario", function (req, res) {
    localController.cadastrarEndereco(req, res);
});

router.post("/cadastrarAmbientes/:idEndereco", function (req, res) {
    localController.cadastrarAmbientes(req, res);
});
router.post("/cadastrarObras/:idAmbiente", function (req, res) {
    localController.cadastrarObras(req, res);
});

module.exports = router;