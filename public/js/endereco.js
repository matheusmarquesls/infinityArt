function enderecoLinhas() {

    let idUsuario = sessionStorage.getItem('ID_USUARIO')

    let id = 1

    fetch(`/enderecos/listarEnderecos/${idUsuario}`).then(function (resposta) {

        if (resposta.ok) {
            if (resposta.status == 204) {
                throw "Nenhum resultado encontrado!!";
            }

            resposta.json().then(function (resposta) {
            console.log("Dados recebidos: ", JSON.stringify(resposta));

            const bodyTabela = document.getElementById('tbody_corpo_tabela')

            let enderecoPerigo = 0;

                for (let i = 0; i < resposta.length; i++) {
                    
                    let linha = document.createElement('tr');
                    linha.dataset.idEndereco = resposta[i].id;
                    linha.dataset.nomeEndereco = resposta[i].nome;

                    linha.addEventListener('click', function() {
                        let idEndereco = this.dataset.idEndereco;
                        let nomeEndereco = this.dataset.nomeEndereco;

                            sessionStorage.ID_ENDERECO = idEndereco;
                            sessionStorage.NOME_ENDERECO = nomeEndereco;

                       window.open('ambiente.html', '_blank'); // Abre o link em uma nova aba  
                    });
                    bodyTabela.appendChild(linha)
                        
                    var enderecoAtual = resposta[i];
                    
                    let celId = document.createElement('td');
                    celId.textContent = id
                    linha.appendChild(celId);

                    let endereco = enderecoAtual.nome; 

                    let celEndereco = document.createElement('td');
                    celEndereco.textContent = `${endereco}`
                    linha.appendChild(celEndereco);

                    let rua = enderecoAtual.rua;
                    
                    let celRua = document.createElement('td');
                    celRua.textContent = `${rua}`
                    linha.appendChild(celRua);

                    let cep = enderecoAtual.cep;
                    
                    let celCEP = document.createElement('td');
                    celCEP.textContent = `${cep}`
                    linha.appendChild(celCEP);

                    let qtdAmbientes = enderecoAtual.qtd_ambientes;
    
                    let celQtdAmbientes = document.createElement('td');
                    celQtdAmbientes.textContent = `${qtdAmbientes}`
                    linha.appendChild(celQtdAmbientes);

                    let qtdObras = enderecoAtual.qtd_obras
    
                    let celQtdObras = document.createElement('td');
                    celQtdObras.textContent = `${qtdObras}`
                    linha.appendChild(celQtdObras);
    
                    let situacaoAtual = enderecoAtual.situacao
                    let situacao = 'Seguro'
                    let situacaoCor = 'seguro'
    
                    if (situacaoAtual == 1) {
                        situacao = 'Perigo'
                        situacaoCor = 'perigo'
                        enderecoPerigo++
                    }
                    
                    let celSituacao = document.createElement('td');
                    celSituacao.textContent = `${situacao}`
                    celSituacao.classList.add(situacaoCor)
                    linha.appendChild(celSituacao);

                    id++
    
                }

                const qtdEndereco = resposta.length;

                const porcentagemTotalEnderecoPerigo = (enderecoPerigo * 100) / qtdEndereco ;
                const porcentagemTotalEnderecoPerigoFormatada = porcentagemTotalEnderecoPerigo.toFixed(1);

                const kpis = document.querySelector('.critico');

                    if(enderecoPerigo >= 1){
                        kpis.classList.add('alerta') 
                    } else {
                        kpis.classList.remove('alerta')
                    }

                h1_quantidade_endereco.innerHTML = qtdEndereco;
                h1_endereco_totais_perigo.innerHTML = enderecoPerigo;

                div_quantidade_endereco_perigo.innerHTML = `${porcentagemTotalEnderecoPerigoFormatada}% do total de endereco`;

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