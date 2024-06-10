var express = require("express");
var router = express.Router();

var localController = require("../controllers/localController");

router.post("/cadastrarEndereco/:idUsuario", function (req, res) {
    localController.cadastrarEndereco(req, res);
    
    
});

module.exports = router;