// let obrasPerigo = 0;

let metricas = [];

if (metricas.length == 0) {

  let lux = document.getElementById('ideal_lux');
  let temp = document.getElementById('ideal_temp');
  let umid = document.getElementById('ideal_umid');
  
  if (sessionStorage.getItem('ID_TINTA') == 'Oleo') {
      metricas.push('Até 200Lx')
      metricas.push('18°C - 21°C')
      metricas.push('40% - 45%')
  } else if (sessionStorage.getItem('ID_TINTA') == 'Guache') {
      metricas.push('Até 50Lx')
      metricas.push('19°C - 21°C')
      metricas.push('45% - 55%')
  } else {
      metricas.push('Até 50Lx')
      metricas.push('18°C - 21°C')
      metricas.push('40% - 60%')
  }

  lux.innerHTML = metricas[0];
  temp.innerHTML = metricas[1];
  umid.innerHTML = metricas[2];

}

function atualizarGraficos() {
  dadosGraficoDht();
  dadosGraficoLdr();
  dadosGraficoEstado();
  dadosGraficoSemana();
  listarKpis();

  findGraficoSemana.update()
  findGraficoEstado.update()

  setTimeout(atualizarGraficos, 10000); // Chama novamente a função após 5 segundos
}

const graficoDHT = document.getElementById('graficoDHT');

let findGraficoDHT = new Chart(graficoDHT, {
  type: 'line',
  data: {
    labels: [],
    datasets: [
      {
        label: 'Temperatura',
        data: [],
        backgroundColor: '#EB5344',
        borderColor: '#EB6344',
        borderWidth: 2,
        fill: false,
      },
      {
        label: 'Umidade',
        data: [],
        backgroundColor: '#23B3D8',
        borderColor: '#26C5EB',
        borderWidth: 2,
        fill: false,
      }
    ]
  },
  options: {
    plugins: {
      legend: {
        position: 'bottom'
      },
    },
    scales: {
      y: {
        beginAtZero: true,
        min: 10,
        max: 100,
      }
    }
  }
});

function dadosGraficoDht() {

  // let idUsuario = sessionStorage.getItem('ID_USUARIO');
  let idObras = sessionStorage.getItem('ID_OBRAS');

  fetch(`/dashboard/dadosGraficoDht/${idObras}`).then(function (resposta) {

    if (resposta.ok) {
      if (resposta.status == 204) {
        throw "Nenhum resultado encontrado!!";
      }

      resposta.json().then(function (resposta) {
        console.log("Dados recebidos: ", JSON.stringify(resposta));

        findGraficoDHT.data.datasets[0].data = [];
        findGraficoDHT.data.datasets[1].data = [];

        let agora = new Date();

        let horas = agora.getHours();
        let minutos = agora.getMinutes();
        let segundos = agora.getSeconds();

        horas = horas < 10 ? '0' + horas : horas;
        minutos = minutos < 10 ? '0' + minutos : minutos;
        segundos = segundos < 10 ? '0' + segundos : segundos;

        if (findGraficoDHT.data.labels.length == 7) {
          findGraficoDHT.data.labels.shift()
        }

        findGraficoDHT.data.labels.push(horas + ':' + minutos + ':' + segundos);

        for (let posicao = resposta.length - 1;
          posicao >= 0;
          posicao--) {

          let tempAtual = resposta[posicao].temp;
          let umidAtual = resposta[posicao].umid;

          findGraficoDHT.data.datasets[0].data.push(tempAtual);
          findGraficoDHT.data.datasets[1].data.push(umidAtual);

          findGraficoDHT.update()

        }

      });
    } else {
      throw ('Houve um erro na API!');
    }
  }).catch(function (resposta) {
    console.error(resposta);
    // finalizarAguardar();
  });
}

const graficoLDR = document.getElementById('graficoLDR');

let findGrafioLDR = new Chart(graficoLDR, {
  type: 'line',
  data: {
    labels: [],
    datasets: [{
      label: 'Luminosidade',
      data: [], // Valores de luminosidade
      backgroundColor: '#EBB831',
      borderColor: 'rgba(255, 206, 86, 1)', // Cor da linha
      borderWidth: 2,
      fill: false // Sem preenchimento
    }]
  },
  options: {
    plugins: {
      legend: {
        position: 'bottom',
      },
    },
    scales: {
      y: {
        beginAtZero: true,
        min: 0,
        max: 800,
      },
    },
  }
});

function dadosGraficoLdr() {

  // let idUsuario = sessionStorage.getItem('ID_USUARIO');
  let idObras = sessionStorage.getItem('ID_OBRAS');

  fetch(`/dashboard/dadosGraficoLdr/${idObras}`).then(function (resposta) {

    if (resposta.ok) {
      if (resposta.status == 204) {
        throw "Nenhum resultado encontrado!!";
      }

        resposta.json().then(function (resposta) {
        console.log("Dados recebidos: ", JSON.stringify(resposta));

        findGrafioLDR.data.datasets[0].data = [];

        let agora = new Date();

        let horas = agora.getHours();
        let minutos = agora.getMinutes();
        let segundos = agora.getSeconds();

        horas = horas < 10 ? '0' + horas : horas;
        minutos = minutos < 10 ? '0' + minutos : minutos;
        segundos = segundos < 10 ? '0' + segundos : segundos;

        if (findGrafioLDR.data.labels.length == 7) {
          findGrafioLDR.data.labels.shift()
        }

        findGrafioLDR.data.labels.push(horas + ':' + minutos + ':' + segundos);

        for (let posicao = resposta.length - 1;
          posicao >= 0;
          posicao--) {

          let medidaAtual = resposta[posicao].lux;

          findGrafioLDR.data.datasets[0].data.push(medidaAtual);

          findGrafioLDR.update()

        }

      });

    } else {
      throw ('Houve um erro na API!');
    }
  }).catch(function (resposta) {
    console.error(resposta);
    // finalizarAguardar();
  });
}


const graficoEstado = document.getElementById('graficoEstado');

let findGraficoEstado = new Chart(graficoEstado, {
  type: 'bar',
  data: {
    labels: ['Luminosidade', 'Umidade', 'Temperatura'],
    datasets: [
      {
        label: 'Min',
        data: [],
        borderWidth: 1,
        // borderColor: 'black',
        backgroundColor: '#007bff',
      },
      {
        label: 'Max',
        data: [],
        borderWidth: 1,
        // borderColor: 'black',
        backgroundColor: '#dc3545',
      },
    ]
  },
  options: {
    indexAxis: 'y',
    elements: {
      bar: {
        borderWidth: 2,
      }
    },
    responsive: true,
    plugins: {
      legend: {
        position: 'bottom',
      },
    }
  },
});

function dadosGraficoEstado() {

  // let idUsuario = sessionStorage.getItem('ID_USUARIO');
  let idObras = sessionStorage.getItem('ID_OBRAS');

  fetch(`/dashboard/dadosGraficoEstado/${idObras}`).then(function (resposta) {

    if (resposta.ok) {
      if (resposta.status == 204) {
        throw "Nenhum resultado encontrado!!";
      }

        resposta.json().then(function (resposta) {
        console.log("Dados recebidos: ", JSON.stringify(resposta));

        findGraficoEstado.data.datasets[0].data = [];
        findGraficoEstado.data.datasets[1].data = [];

        let minLux = resposta[0].minimo;
        let maxLux = resposta[0].maximo;

        let minUmid = resposta[1].minimo;
        let maxUmid = resposta[1].maximo;

        let minTemp = resposta[2].minimo;
        let maxTemp = resposta[2].maximo;

        findGraficoEstado.data.datasets[0].data.push(minLux);
        findGraficoEstado.data.datasets[0].data.push(minUmid);
        findGraficoEstado.data.datasets[0].data.push(minTemp);

        findGraficoEstado.data.datasets[1].data.push(maxLux);
        findGraficoEstado.data.datasets[1].data.push(maxUmid);
        findGraficoEstado.data.datasets[1].data.push(maxTemp);

        findGraficoEstado.update()

      });
    } else {
      throw ('Houve um erro na API!');
    }
  }).catch(function (resposta) {
    console.error(resposta);
    // finalizarAguardar();
  });
}

const graficoSemana = document.getElementById('grafico-semana');

let findGraficoSemana = new Chart(graficoSemana, {
  type: 'bar',
  data: {
    labels: ['Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'],
    datasets: [{
      label: 'Dias da Semana',
      data: [],
      borderWidth: 1
    }]
  },
  options: {
    plugins: {
      legend: {
        position: 'bottom',
      },
    },
    scales: {
      y: {
        beginAtZero: true
      }
    }
  }
});

function dadosGraficoSemana() {

  // let idUsuario = sessionStorage.getItem('ID_USUARIO');
  let idObras = sessionStorage.getItem('ID_OBRAS');

  fetch(`/dashboard/dadosGraficoSemana/${idObras}`).then(function (resposta) {

    if (resposta.ok) {
      if (resposta.status == 204) {
        throw "Nenhum resultado encontrado!!";
      }

      resposta.json().then(function (resposta) {
        console.log("Dados recebidos: ", JSON.stringify(resposta));

        findGraficoSemana.data.datasets[0].data = [];

        for (let posicao = 0;
          posicao < resposta.length;
          posicao++) {

          let diaAtual = resposta[posicao].limites_atingidos;

          if (diaAtual == null || diaAtual == undefined) {
            diaAtual = 0;
          }

          findGraficoSemana.data.datasets[0].data.push(diaAtual);

        }

        findGraficoSemana.update()

      });
    } else {
      throw ('Houve um erro na API!');
    }
  }).catch(function (resposta) {
    console.error(resposta);
    // finalizarAguardar();
  });
}

function listarKpis() {

  // let idUsuario = sessionStorage.getItem('ID_USUARIO');
  let idObras = sessionStorage.getItem('ID_OBRAS');

  fetch(`/dashboard/listarKpis/${idObras}`).then(function (resposta) {

    if (resposta.ok) {
      if (resposta.status == 204) {
        throw "Nenhum resultado encontrado!!";
      }

      resposta.json().then(function (resposta) {
        console.log("Dados recebidos: ", JSON.stringify(resposta));

        let lux = document.getElementById('kpi_lux');
        let temp = document.getElementById('kpi_temp');
        let umid = document.getElementById('kpi_umid');

        lux.innerHTML = "";
        temp.innerHTML = "";
        umid.innerHTML = "";

        lux.innerHTML = resposta[0].limite;
        temp.innerHTML = resposta[1].limite;
        umid.innerHTML = resposta[2].limite;

        let kpis = document.querySelectorAll('.kpi');

        for (let posicao = 0; posicao < 3; posicao++) {

          let kpiAtual = kpis[posicao];

        // Remova todas as classes de cor
        kpiAtual.classList.remove('kpi-verde', 'kpi-amarelo', 'kpi-vermelho');

        // Aplique a classe correta com base no valor de resposta[posicao].limite
        if (resposta[posicao].limite < 3) {
          kpiAtual.classList.add('kpi-verde');
        } else if (resposta[posicao].limite >= 3 && resposta[posicao].limite <= 4) {
          kpiAtual.classList.add('kpi-amarelo');
        } else {
          kpiAtual.classList.add('kpi-vermelho');
        }

        }

      });
    } else {
      throw ('Houve um erro na API!');
    }
  }).catch(function (resposta) {
    console.error(resposta);
    // finalizarAguardar();
  });
}

function limparSessao() {
  sessionStorage.clear();
  window.location = "index.html";
}