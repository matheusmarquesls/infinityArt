var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/graficoDht/:idObras", function (req, res) {
    dashboardController.graficoDht(req, res);
});

router.get("/graficoLdr/:idObras", function (req, res) {
    dashboardController.graficoLdr(req, res);
});

module.exports = router;