
const kpis = document.getElementsByClassName('critico');

const qtdObras = 44; 
const obrasPerigo = 34;
const obras5HorasPerigo = 0;
const obras1HoraPerigo = 0;

const porcentagemTotalObrasPerigo = (obrasPerigo * 100) / qtdObras ;
const porcentagemTotalObrasPerigoFormatada = porcentagemTotalObrasPerigo.toFixed(1);

for(posicao = 0; posicao < kpis.length ; posicao++){
    let kpiAtual = kpis[posicao];

    if(posicao == 0){
        
    if(obrasPerigo >= 1){
        kpiAtual.classList.add('alerta') 
    } else {
        kpiAtual.classList.remove('alerta')
    }
    }
    else if(posicao == 1){

        if(obras5HorasPerigo >= 1 ){
            kpiAtual.classList.add('alerta') 
        }
        else {
            kpiAtual.classList.remove('alerta')
        }
    }
    else if(posicao == 2){
        
    if(obras1HoraPerigo >= 1){
        kpiAtual.classList.add('alerta') 
    }
    else {
        kpiAtual.classList.remove('alerta')
    }
    }
}

    let id = 0;
    let pintura = "Pintura";
    let tipoTinta = ["Oléo", "Acrílica", "Guache"];
    let situacao = ["Seguro", "Perigo"];

    let qtdObrasPerigoRestante = obrasPerigo;

    const bodyTabela = document.getElementById('tbody_corpo_tabela')

    bodyTabela.innerHTML = "";

    for(let obrasEmLinha = 1; obrasEmLinha <= qtdObras; obrasEmLinha++) {

        const tintaVariavel = Math.floor(Math.random() * 3);
    
        if (qtdObrasPerigoRestante > 0) {
            
            let linha = document.createElement('tr');
            linha.addEventListener('click', function() {
                window.open('https://www.w3schools.com', '_blank'); // Abre o link em uma nova aba
            });
            bodyTabela.appendChild(linha)
            
            let celId = document.createElement('td');
            celId.textContent = id + 1
            linha.appendChild(celId);
    
            let celPintura = document.createElement('td');
            celPintura.textContent = `${pintura} ${id + 1}`
            linha.appendChild(celPintura);
    
            let celTipoTinta = document.createElement('td');
            celTipoTinta.textContent = `${tipoTinta[tintaVariavel]}`
            linha.appendChild(celTipoTinta);
    
            let celSituacao = document.createElement('td');
            celSituacao.textContent = `${situacao[1]}`
            celSituacao.classList.add('perigo')
            linha.appendChild(celSituacao);

        } else {

            let linha = document.createElement('tr');
            linha.setAttribute('data-href', '')
            bodyTabela.appendChild(linha)
    
            let celId = document.createElement('td');
            celId.textContent = id + 1
            linha.appendChild(celId);
    
            let celPintura = document.createElement('td');
            celPintura.textContent = `${pintura} ${id + 1}`
            linha.appendChild(celPintura);
    
            let celTipoTinta = document.createElement('td');
            celTipoTinta.textContent = `${tipoTinta[tintaVariavel]}`
            linha.appendChild(celTipoTinta);
            
            let celSituacao = document.createElement('td');
            celSituacao.textContent = `${situacao[0]}`
            celSituacao.classList.add('seguro')
            linha.appendChild(celSituacao);

        }

        // linha.addEventListener('click', function() {
        //     window.location.href = this.getAttribute('data-href');
        // });

        qtdObrasPerigoRestante--
        id++

    }


h1_quantidade_obras.innerHTML = qtdObras;
h1_obras_totais_perigo.innerHTML = obrasPerigo;
h1_obras_5horas_perigo.innerHTML = obras5HorasPerigo;
h1_obras_1hora_perigo.innerHTML = obras1HoraPerigo; 
div_quantidade_obras_perigo.innerHTML = `${porcentagemTotalObrasPerigoFormatada}% do total de obras`  ;

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