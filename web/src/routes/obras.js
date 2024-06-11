var express = require("express");
var router = express.Router();

var obrasController = require("../controllers/obrasController");

router.get("/listarObras/:idAmbiente", function (req, res) {
    obrasController.listarObras(req, res);
});

router.get("/listarKpis/:idAmbiente", function(req,res){
    obrasController.listarKpis(req,res);
});

module.exports = router;