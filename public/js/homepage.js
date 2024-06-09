let nomeUsuario = sessionStorage.NOME_USUARIO;

username.innerHTML = `${nomeUsuario}`

let subMenu = document.getElementById("sub-menu-wrap");

function toggleMenu() {
    subMenu.classList.toggle("open-menu");
};

document.addEventListener('DOMContentLoaded', function () {
    let idUsuario = sessionStorage.getItem('ID_USUARIO');

    const btnSession = document.querySelector('.nav-button');
    const userSession = document.querySelector('.nav-profile');

    if (btnSession && userSession) {
        if (idUsuario == undefined) {

            btnSession.style.display = 'flex';
            userSession.style.display = 'none';
        } else {
            userSession.style.display = 'flex';
            btnSession.style.display = 'none';
        }
    } else {
        console.error("Os elementos 'btn-bar' ou 'user-logon' não foram encontrados no DOM.");
    }
});

function limparSessao() {
    sessionStorage.clear();
    window.location = "index.html";
}
