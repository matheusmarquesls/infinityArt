function ambienteLinha() {

    let idUsuario = sessionStorage.getItem('ID_USUARIO');
    let idEndereco = sessionStorage.getItem('ID_ENDERECO');

    fetch(`/ambientes/listarAmbientes/${idUsuario}/${idEndereco}`).then(function (resposta) {

        if (resposta.ok) {
            if (resposta.status == 204) {
                throw "Nenhum resultado encontrado!!";
            }

            resposta.json().then(function (resposta) {
            console.log("Dados recebidos: ", JSON.stringify(resposta));

            const bodyTabela = document.getElementById('tbody_corpo_tabela')

            let ambientePerigo = 0;

                for (let i = 0; i < resposta.length; i++) {
                    
                    let linha = document.createElement('tr');
                    linha.addEventListener('click', function() {
                    window.open('ambiente.html', '_blank'); // Abre o link em uma nova aba
                    });
                    bodyTabela.appendChild(linha)
                        
                    var ambienteAtual = resposta[i];

                    let id = ambienteAtual.id

                    let celId = document.createElement('td');
                    celId.textContent = id
                    linha.appendChild(celId);

                    let ambiente = ambienteAtual.nome
            
                    let celAmbientes = document.createElement('td');
                    celAmbientes.textContent = `${ambiente}`
                    linha.appendChild(celAmbientes);

                    let qtdObras = ambienteAtual.qtd_obras

                    let obrasTotal = document.createElement('td');
                    obrasTotal.textContent = `${qtdObras}`
                    linha.appendChild(obrasTotal);

                    let qtdObrasPerigo = ambienteAtual.qtd_obras_perigo

                    let obrasPerigo = document.createElement('td');
                    obrasPerigo.textContent = `${qtdObrasPerigo}`
                    linha.appendChild(obrasPerigo);

                    let situacaoAtual = ambienteAtual.situacao
                    let situacao = 'Seguro'
                    let situacaoCor = 'seguro'
    
                    if (situacaoAtual == 1) {
                        situacao = 'Perigo'
                        situacaoCor = 'perigo'
                        ambientePerigo++
                    }
                    
                    let celSituacao = document.createElement('td');
                    celSituacao.textContent = `${situacao}`
                    celSituacao.classList.add(situacaoCor)
                    linha.appendChild(celSituacao);
    
                }

                const qtdAmbientes = resposta.length;

                const porcentagemTotalAmbientePerigo = (ambientePerigo * 100) / qtdAmbientes ;
                const porcentagemTotalAmbientePerigoFormatada = porcentagemTotalAmbientePerigo.toFixed(1);

                const kpis = document.querySelector('.critico');

                    if(ambientePerigo >= 1){
                        kpis.classList.add('alerta') 
                    } else {
                        kpis.classList.remove('alerta')
                    }

                h1_quantidade_ambientes.innerHTML = qtdAmbientes;
                h1_ambientes_totais_perigo.innerHTML = ambientePerigo;

                div_quantidade_ambientes_perigo.innerHTML = `${porcentagemTotalAmbientePerigoFormatada}% do total de endereco`;

                let localEndereco = document.querySelector('.local_nome');

                localEndereco.innerHTML += ` ${sessionStorage.getItem('NOME_ENDERECO')}`

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

function limparSessao() {
    sessionStorage.clear();
    window.location = "index.html";
}