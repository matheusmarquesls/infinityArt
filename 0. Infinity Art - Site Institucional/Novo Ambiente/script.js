
const kpis = document.getElementsByClassName('critico');

let qtdObras = 20; 
let obrasPerigo = 10;
let obras5HorasPerigo = 0;
let obras1HoraPerigo = 0;
let porcentagemTotalObrasPerigo = (obrasPerigo * 100) / qtdObras ;
let porcentagemTotalObrasPerigoFormatada = porcentagemTotalObrasPerigo.toFixed(1);

for(posicao = 0; posicao < kpis.length ; posicao++){
    let kpiAtual = kpis[posicao];

    if(posicao == 0){
        
    if(obrasPerigo >= 1){
        kpiAtual.classList.add('alerta') 
    }
    }
    else if(posicao == 1){

        if(obras5HorasPerigo >= 1 ){
            kpiAtual.classList.add('alerta') 
        }
    }
    else if(posicao == 2){
        
    if(obras1HoraPerigo >= 1){
        kpiAtual.classList.add('alerta') 
    }
    }
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