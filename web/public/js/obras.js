
// let obrasPerigo = 0;

function obrasLinha() {

    // let idUsuario = sessionStorage.getItem('ID_USUARIO');
    let idAmbiente = sessionStorage.getItem('ID_AMBIENTE');

    let id = 1

    fetch(`/obras/listarObras/${idAmbiente}`).then(function (resposta) {

        if (resposta.ok) {
            if (resposta.status == 204) {
                throw "Nenhum resultado encontrado!!";
            }

            resposta.json().then(function (resposta) {
                console.log("Dados recebidos: ", JSON.stringify(resposta));

                const bodyTabela = document.getElementById('tbody_corpo_tabela')

                for (let i = 0; i < resposta.length; i++) {
                    
                    let linha = document.createElement('tr');
                    linha.dataset.idObras = resposta[i].id;
                    linha.dataset.tipo_tinta = resposta[i].tipo_tinta;

                    linha.addEventListener('click', function() {
                        let idObras = this.dataset.idObras;
                        let tipo_tinta = this.dataset.tipo_tinta;

                        sessionStorage.ID_OBRAS = idObras;
                        sessionStorage.ID_TINTA = tipo_tinta;

                    window.open('dashboard.html'); // Abre o link em uma nova aba
                    });
                    bodyTabela.appendChild(linha)

                    var obraAtual = resposta[i];

                    let celId = document.createElement('td');
                    celId.textContent = id
                    linha.appendChild(celId);

                    let pintura = obraAtual.nome;

                    let celPintura = document.createElement('td');
                    celPintura.textContent = pintura
                    linha.appendChild(celPintura);

                    let tintaTipo = obraAtual.tipo_tinta

                    let celTipoTinta = document.createElement('td');
                    celTipoTinta.textContent = tintaTipo
                    linha.appendChild(celTipoTinta);

                    let situacaoAtual = obraAtual.situacao

                    let situacao = ''
                    let situacaoCor = ''

                    if (situacaoAtual == 0) {
                        situacao = 'Seguro'
                        situacaoCor = 'seguro'
                    } else if (situacaoAtual == 1) {
                        situacao = 'Perigo'
                        situacaoCor = 'perigo'
                    } else if (situacaoAtual == -1) {
                        situacao = 'Sem dados'
                        situacaoCor = 'black'
                    }

                    let celSituacao = document.createElement('td');
                    celSituacao.textContent = `${situacao}`
                    celSituacao.classList.add(situacaoCor)
                    linha.appendChild(celSituacao);

                    id++

                }


                let localEndereco = document.querySelector('.local_endereco');
                let localAmbiente = document.querySelector('.local_ambiente');

                localEndereco.innerHTML += ` ${sessionStorage.getItem('NOME_ENDERECO')}`
                localAmbiente.innerHTML += ` ${sessionStorage.getItem('NOME_AMBIENTE')}`

                // script do objeto 
                $(document).ready(function () {
                    $('#minhaTabela').DataTable({
                        dom: '<"custom-header"lf>rt<"custom-footer"ip>',
                        pageLength: 5,
                        lengthMenu: [5, 10, 25, 50, 100],
                        language: {
                            info: 'Páginas _PAGE_ de _PAGES_',
                            infoEmpty: 'Nenhum registro disponível',
                            infoFiltered: '(filtrado de _MAX_ registros totais)',
                            lengthMenu: '_MENU_ Registros por páginas',
                            zeroRecords: 'Nada encontrado',
                            search: "",  // Desativa o label do input de busca
                            searchPlaceholder: "Digite para buscar...",  // Placeholder do input de busca
                            paginate: {
                                previous: "Anterior",
                                next: "Próximo"
                            }
                        },
                    });
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

function obrasKpi() {

    let idAmbiente = sessionStorage.getItem('ID_AMBIENTE');

    fetch(`/obras/listarKpis/${idAmbiente}`).then(function (resposta) {

        if (resposta.ok) {
            if (resposta.status == 204) {
                throw "Nenhum resultado encontrado!!";
            }

            resposta.json().then(function (resposta) {
                console.log("Dados recebidos: ", JSON.stringify(resposta));

                const qtdObras = resposta[0].kpi;
                const obrasPerigo = resposta[1].kpi;
               
                const porcentagemTotalObrasPerigo = (obrasPerigo * 100) / qtdObras;
                const porcentagemTotalObrasPerigoFormatada = porcentagemTotalObrasPerigo.toFixed(1);

                const kpis = document.querySelector('.critico');

                if (obrasPerigo >= 1) {
                    kpis.classList.add('alerta')
                } else {
                    kpis.classList.remove('alerta')
                } 

                h1_quantidade_obras.innerHTML = qtdObras;
                h1_obras_totais_perigo.innerHTML = obrasPerigo;

                div_quantidade_obras_perigo.innerHTML = `${porcentagemTotalObrasPerigoFormatada}% do total de endereco`;
            })
        }
        else {
            throw ('Houve um erro na API!');
        }
    }).catch(function (resposta) {
        console.error(resposta);
        // finalizarAguardar();
    });
};



function cadastrarObras(){

    let idAmbiente = sessionStorage.getItem('ID_AMBIENTE');
    var nome = input_nome.value
    var tinta = input_tinta.value

    fetch(`/local/cadastrarObras/${idAmbiente}`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
            nome: nome,
            tinta: tinta
        }),
    })
        .then(function (resposta) {
            console.log("resposta: ", resposta);
    
            if (resposta.ok) {
                
            alert("cadastro realizado")
    
            } else {
                alert('Houve um erro ao tentar realizar o cadastro!')
                throw "Houve um erro ao tentar realizar o cadastro!";
            }
        })
        .catch(function (resposta) {
            console.log(`#ERRO: ${resposta}`);
    
        });
    
    return false;
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "index.html";
}