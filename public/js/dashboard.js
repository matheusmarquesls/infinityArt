// let obrasPerigo = 0;

function graficoDht() {

    // let idUsuario = sessionStorage.getItem('ID_USUARIO');
    let idObras = sessionStorage.getItem('ID_OBRA');

    fetch(`/obras/listarObras/${idObras}`).then(function (resposta) {

        if (resposta.ok) {
            if (resposta.status == 204) {
                throw "Nenhum resultado encontrado!!";
            }

            resposta.json().then(function (resposta) {
                console.log("Dados recebidos: ", JSON.stringify(resposta));

                const graficoDHT = document.getElementById('graficoDHT');
              
                new Chart(graficoDHT, {
                  type: 'line',
                  data: {
                    labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
                    datasets: [
                      {
                        label: 'Temperatura',
                        data: [20, 22, 23, 25, 24, 25],
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 2,
                        fill: false,
                      },
                      {
                        label: 'Umidade',
                        data: [60, 65, 63, 70, 75, 72],
                        borderColor: 'rgba(75, 192, 192, 1)',
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
                      }
                    }
                  }
                });

            });
        } else {
            throw ('Houve um erro na API!');
        }
    }).catch(function (resposta) {
        console.error(resposta);
        // finalizarAguardar();
    });
}