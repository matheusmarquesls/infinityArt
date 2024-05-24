// script.js

$(document).ready(function () {
    $('#minhaTabela').DataTable({
        language: {
            info: 'Páginas _PAGE_ de _PAGES_',
            infoEmpty: 'Nenhum registro disponível',
            infoFiltered: '(filtered from _MAX_ total records)',
            lengthMenu: '_MENU_ Registros por páginas',
            zeroRecords: 'Nada encontrado'
        },
    });
});
