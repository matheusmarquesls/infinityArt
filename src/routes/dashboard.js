var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/dadosGraficoDht/:idObras", function (req, res) {
    dashboardController.dadosGraficoDht(req, res);
});

router.get("/dadosGraficoLdr/:idObras", function (req, res) {
    dashboardController.dadosGraficoLdr(req, res);
});

router.get("/dadosGraficoSemana/:idObras", function (req, res) {
    dashboardController.dadosGraficoSemana(req, res);
});

router.get("/dadosGraficoEstado/:idObras", function (req, res) {
    dashboardController.dadosGraficoEstado(req, res);
});

router.get("/listarKpis/:idObras", function (req, res) {
    dashboardController.listarKpis(req, res);
});

module.exports = router;