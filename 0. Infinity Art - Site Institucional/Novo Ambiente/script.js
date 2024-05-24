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