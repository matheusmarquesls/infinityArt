    // ESCOPO GLOBAL

    const caracterMaiusculo = "QWERTYUIOPASDFGHJKLZXCVBNM";
    const caracterMinusculo = "qwertyuiopasdfghjklzxcvbnm";
    const caracterNum = "1234567890";
    const caracterEspecial = "!#$%&*?@_";


    // FUNÇÃO QUE VAI APAGAR O NOME E SOBRENOME PARA EMAIL, SENHA E CONFIRMAR SENHA...
    // SE CASO OS INPUTS ESTIVEREM CERTOS
    function proximoPasso() {

        event.preventDefault()

        // DECLARANDO INPUTS - OBVIO.
        const nome = input_nome.value;
        const sobrenome = input_sobrenome.value;
        // const email = input_email.value;
        // const senha = input_senha.value;

        // DESCLARANDO VALIDAÇÕES BASICAS
        let validar_nome = nome.length > 2;
        let validar_sobrenome = sobrenome.length > 3 && sobrenome.length <= 20;

        let validacaoTotal = nome == "" || sobrenome == "";

        if (validacaoTotal == true
            || validar_nome == false
            || validar_sobrenome == false) {

            if (validacaoTotal == true) {
                alert(`ERRO: Preencha todos os campos!`)
            }
            // VALIDA SE O NOME TEM MAIS DE 2 CARACTERES
            // SE FOR FALSO, É EXIBIDO UMA MENSAGEM COM DISPLAY FLEX
            // CASO CONTRARIO É REMOVIDO O FLEX PARA NONE
            if (validar_nome == false) {
                document.getElementById("erro_inputNome").style.display = "flex";
            } else {
                document.getElementById("erro_inputNome").style.display = "none";
            }

            // VALIDA SE O SOBRENOME TEM MAIS DE 3 CARACTERES
            if (validar_sobrenome == false) {
                document.getElementById("erro_inputSobrenome").style.display = "flex";
            } else {
                document.getElementById("erro_inputSobrenome").style.display = "none";
            }

        } else {
            document.getElementById("erro_inputNome").style.display = "none";
            document.getElementById("erro_inputSobrenome").style.display = "none";

            document.querySelectorAll('.section-1').forEach(function (elemento) {
                elemento.style.display = "none";
            });

            document.querySelectorAll('.section-2').forEach(function (elemento) {
                elemento.style.display = "block";
            });
        }

    }
    function cadastrarUsuario() {

        // ESSE COMANDO IMPEDE A PAGINA DE BUGAR QUANDO O BOTAO DO FORMULARIO FOR APERTADO
        // ESSE COMANDO PREVINE QUE A PAGINA PROCURE UMA SAIDA.
        event.preventDefault()

        // DECLARANDO INPUTS - OBVIO.
        const nome = input_nome.value;
        const sobrenome = input_sobrenome.value;
        const email = input_email.value;
        const senha = input_senha.value;
        const confirmar = input_confirmaSenha.value;


        // DESCLARANDO VALIDAÇÕES BASICAS
        let validar_email = email.indexOf("@") >= 0 && email.indexOf(".") >= 0;
        let validacaoTotal = nome == "" || sobrenome == "" || senha == "" || email == "";

        // VALIDAÇÃO COMPOSTA DA SENHA
        let tamanhoSenha = senha.length >= 8;
        let qtdMaiusculo = 0;
        let qtdMinisculo = 0;
        let qtdNum = 0;
        let qtdCarecterEspecial = 0;
        let validarConfirmar = senha === confirmar;

        // LAÇO QUE VAI PASSAR EM CADA CARACTER DA SENHA [contador] E,
        // CONFORME CADA VERIFICAÇÃO, CASO SEJA ECONTRADO UMA POSIÇÃO
        // VALIDA (=! -1), O PARAMETRO INCREMENTA MAIS UM.
        for (let contador = 0; contador <= senha.length; contador++) {

            if (caracterMaiusculo.indexOf(senha[contador]) != -1) {
                qtdMaiusculo++;
            }
            if (caracterMinusculo.indexOf(senha[contador]) != -1) {
                qtdMinisculo++;
            }
            if (caracterNum.indexOf(senha[contador]) != -1) {
                qtdNum++;
            }
            if (caracterEspecial.indexOf(senha[contador]) != -1) {
                qtdCarecterEspecial++
            }
        }

        // CASO UMA DAS VALIDAÇÕES SEJA FALSA 
        // É RETORNADO QUAL CAMPO ESTÁ INCORRETO
        // CASO CONTRARIO, O SISTEMA FINALIZA O CADASTRO
        if (validacaoTotal == true
            || validar_email == false
            || tamanhoSenha == false
            || qtdMaiusculo == 0
            || qtdMinisculo == 0
            || qtdNum == 0
            || qtdCarecterEspecial == 0
            || validarConfirmar == false) {

            // VALIDA SE HÁ ALGUM CAMPO VAZIO
            if (validacaoTotal == true) {
                alert(`preencha todos os campos`)
            }

            // VALIDA SE O EMAIL TEM @ E PONTO-FINAL
            if (validar_email == false) {
                document.getElementById("erro_inputEmail").style.display = "flex";
            } else {
                document.getElementById("erro_inputEmail").style.display = "none";
            }

            // VALIDAÇÃO DE SENHA COMPOSTA:
            // CASO SENHA ESTEJA INCORRETA A MENSAGEM DE ERRO FICA DISPLAY FLEX
            // CASO CONTRARIO FICA DISPLAY NONE (ORIGINAL)
            if (tamanhoSenha == false
                || qtdMaiusculo == 0
                || qtdMinisculo == 0
                || qtdNum == 0
                || qtdCarecterEspecial == 0) {

                document.getElementById("erro_inputSenha").style.display = "flex";


                // TAMBEM QUANDO A SENHA ESTIVER INCORRETA,
                // SERA FEITA UMA VALIDAÇÃO DE QUAL PARTE DA SENHA ESTA FALTANDO.
                // QUANDO UMA PARTE DA SENHA FALTAR
                // UM PARAGRAFO (P) DA DIV ERRO_INPUT É SETADO COMO BLOCK
                // CASO CONTRARIO ELE É REMOVIDO 
                if (qtdCarecterEspecial == 0) {
                    document.getElementById("erroSenha1").style.display = "block";
                } else {
                    document.getElementById("erroSenha1").style.display = null;
                }
                if (tamanhoSenha == false) {
                    document.getElementById("erroSenha2").style.display = "block";
                } else {
                    document.getElementById("erroSenha2").style.display = null;
                }
                if (qtdMaiusculo == 0) {
                    document.getElementById("erroSenha3").style.display = "block";
                } else {
                    document.getElementById("erroSenha3").style.display = null
                }
                if (qtdMinisculo == 0) {
                    document.getElementById("erroSenha4").style.display = "block";
                } else {
                    document.getElementById("erroSenha4").style.display = null
                }
                if (qtdNum == 0) {
                    document.getElementById("erroSenha5").style.display = "block";
                } else {
                    document.getElementById("erroSenha5").style.display = null;
                }

            } else {
                document.getElementById("erro_inputSenha").style.removeProperty("display");
            }
            if (validarConfirmar == false) {
                document.getElementById("erro_inputConfirmarSenha").style.display = "flex";
            } else {
                document.getElementById("erro_inputConfirmarSenha").style.display = "none";
            }

        }
        else {
            cadastrar()
        }

    }

    // FUNÇÂO ANIMAÇÂO DO CADASTRO E LOGIN
    document.getElementById('chamada-cadastro-btn').addEventListener('click', function () {
        const cobertura = document.getElementById('cobertura');

        cobertura.classList.remove('left');
        cobertura.classList.add('right');

        const login = document.getElementById('chamada-login');
        login.classList.remove('hide');

        const cadastro = document.getElementById('chamada-cadastrar');
        cadastro.classList.add('hide');
    })

    document.getElementById('chamada-login-btn').addEventListener('click', function () {
        const cobertura = document.getElementById('cobertura');
        cobertura.classList.remove('right');
        cobertura.classList.add('left');

        const login = document.getElementById('chamada-login');
        login.classList.add('hide');

        const cadastro = document.getElementById('chamada-cadastrar');
        cadastro.classList.remove('hide');
    })

    function cadastrar() {

        //Recupere o valor da nova input pelo nome do id
        // Agora vá para o método fetch logo abaixo
        var nomeVar = input_nome.value;
        var sobrenomeVar = input_sobrenome.value;
        var emailVar = input_email.value;
        var senhaVar = input_senha.value;

        // Enviando o valor da nova input
        fetch("/usuarios/cadastrar", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                // crie um atributo que recebe o valor recuperado aqui
                // Agora vá para o arquivo routes/usuario.js
                nomeServer: nomeVar,
                sobrenomeServer: sobrenomeVar,
                emailServer: emailVar,
                senhaServer: senhaVar,

            }),
        })
            .then(function (resposta) {
                console.log("resposta: ", resposta);

                if (resposta.ok) {
                    
                    alert("Cadastro realizado com sucesso! Realize seu login ao lado.")

                    const cobertura = document.getElementById('cobertura');
                    cobertura.classList.remove('right');
                    cobertura.classList.add('left');

                    const login = document.getElementById('chamada-login');
                    login.classList.add('hide');

                    const cadastro = document.getElementById('chamada-cadastrar');
                    cadastro.classList.remove('hide');

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

    // FUNCAO PARA O USUARIO REALIZAR O LOGIN (WEB-DATA-VIZ)

    function entrar() {

        var emailVar = inputEmailLogin.value;
        var senhaVar = inputSenhaLogin.value;

        console.log("FORM LOGIN: ", emailVar);
        console.log("FORM SENHA: ", senhaVar);

        fetch("/usuarios/autenticar", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                emailServer: emailVar,
                senhaServer: senhaVar,
            })
        }).then(function (resposta) {
            console.log("ESTOU NO THEN DO entrar()!")

            if (resposta.ok) {
                console.log(resposta);

                resposta.json().then(json => {
                    console.log(json);
                    console.log(JSON.stringify(json));
                    sessionStorage.EMAIL_USUARIO = json.email;
                    sessionStorage.NOME_USUARIO = json.nome;
                    sessionStorage.ID_USUARIO = json.idUsuario;

                    setTimeout(function () {
                        window.location.href = "index.html";
                    }, 1000); // apenas para exibir o loading

                });

            } else {

                console.log("Houve um erro ao tentar realizar o login!");
                alert('Houve um erro ao realizar o Login!')

                resposta.text().then(texto => {
                    console.error(texto);
                });
            }

        }).catch(function (erro) {
            console.log(erro);
        })

        return false;
    }


