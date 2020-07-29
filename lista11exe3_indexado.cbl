      $set sourceformat"free"
      *>Divisão de identificação do programa
       identification division.
       program-id. "lista11exe3_indexado".
       author. "Daiana Weiss".
       installation. "PC".
       date-written. 28/07/2020.
       date-compiled. 28/07/2020.



      *>Divisão para configuração do ambiente
       environment division.
       configuration section.
           special-names. decimal-point is comma.

      *>-----Declaração dos recursos externos
       input-output section.
       file-control.

           select arqCadAluno assign to "arqCadAluno.dat"
           organization is indexed
           access mode is dynamic
           lock mode is automatic
           record key is fd-cod
           file status is ws-fs-arqCadAluno.

       i-o-control.

      *>Declaração de variáveis
       data division.

      *>----Variaveis de arquivos
       file section.
       fd arqCadAluno.
       01  fd-alunos.
           05  fd-cod                              pic 9(03).
           05  fd-aluno                            pic x(12).
           05  fd-endereco                         pic x(14).
           05  fd-mae                              pic x(12).
           05  fd-pai                              pic x(12).
           05  fd-telefone                         pic x(08).
           05  fd-notas.
               10 fd-nota1                             pic 9(02)v99 value 00.
               10 fd-nota2                             pic 9(02)v99 value 00.
               10 fd-nota3                             pic 9(02)v99 value 00.
               10 fd-nota4                             pic 9(02)v99 value 00.

      *>----Variaveis de trabalho
       working-storage section.

       01  alunos.
           05  cod                                 pic 9(03).
           05  aluno                               pic x(12).
           05  endereco                            pic x(14).
           05  mae                                 pic x(12).
           05  pai                                 pic x(12).
           05  telefone                            pic x(08).
           05 notas.
               10  nota1                            pic 9(02)v99
                                                   value 00.
               10  nota2                            pic 9(02)v99
                                                   value 00.
               10  nota3                            pic 9(02)v99
                                                   value 00.
               10  nota4                            pic 9(02)v99
                                                   value 00.

       77  menu                                    pic x(02).

       01 ws-tela-menu.
          05  ws-cadastro-aluno                    pic  x(01).
          05  ws-cadastro-nota                     pic  x(01).
          05  ws-consulta-cadastro                 pic  x(01).
          05  ws-consulta-seq-cadastro             pic  x(01).
          05  ws-deletar-cadastro                  pic  x(01).
          05  ws-alterar-cadastro                  pic  x(01).
          05  ws-sair                              pic  x(01).

       77 ws-msn                                   pic  x(50).

       77 ws-fs-arqCadAluno                        pic 9(02).
       77 ws-msn-erro-ofsset                       pic 9(02).
       77 ws-msn-erro-cod                          pic 9(02).
       77 ws-msn-erro-text                         pic X(42).


      *>----Variaveis para comunicação entre programas
       linkage section.


      *>----Declaração de tela
       screen section.
       01  tela-menu.
      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
           05 blank screen.
           05 line 01 col 01 value "                                                                     [ ]Sair     ".
           05 line 02 col 01 value "                                Cadastro de Alunos                               ".
           05 line 03 col 01 value "      MENU                                                                       ".
           05 line 04 col 01 value "        [ ]Cadastro de Alunos                                                    ".
           05 line 05 col 01 value "        [ ]Cadastro de Notas                                                     ".
           05 line 06 col 01 value "        [ ]Consulta Cadastro                                                     ".
           05 line 07 col 01 value "        [ ]Consulta Cadastro Sequencial                                          ".
           05 line 08 col 01 value "        [ ]Alterar Cadastro                                                      ".
           05 line 09 col 01 value "        [ ]Apagar Cadastro                                                       ".


           05 sc-sair-menu            line 01  col 71 pic x(01) using ws-sair               foreground-color 12.
           05 sc-cadastro-aluno       line 04  col 10 pic x(01) using ws-cadastro-aluno     foreground-color 15.
           05 sc-cadastro-nota        line 05  col 10 pic x(01) using ws-cadastro-nota      foreground-color 15.
           05 sc-consulta-cadastro    line 06  col 10 pic x(01) using ws-consulta-cadastro  foreground-color 15.
           05 sc-consulta-cadastro    line 07  col 10 pic x(01) using ws-consulta-seq-cadastro  foreground-color 15.
           05 sc-alterar-cadastro     line 08  col 10 pic x(01) using ws-alterar-cadastro   foreground-color 15.
           05 sc-deletar-cadastro     line 09  col 10 pic x(01) using ws-deletar-cadastro   foreground-color 15.


      *>-----------------------------------------------------------------------------------------------------------------------

       01  tela-cad-notas.
      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
           05 blank screen.
           05 line 01 col 01 value "                                                                     [ ]Sair     ".
           05 line 02 col 01 value "                                Cadastro de Notas                                ".
           05 line 03 col 01 value "       Cod. Aluno:                                                               ".
           05 line 04 col 01 value "       Nota      :                                                               ".
           05 line 05 col 01 value "       Nota      :                                                               ".
           05 line 06 col 01 value "       Nota      :                                                               ".
           05 line 07 col 01 value "       Nota      :                                                               ".
           05 line 22 col 01 value "              [__________________________________________________]               ".


           05 sc-sair-cad-not         line 01  col 71 pic x(01)     using ws-sair foreground-color 12.
           05 sc-cod-aluno            line 03  col 19 pic 9(03)     using cod     foreground-color 15.
           05 sc-nota                 line 04  col 19 pic 9(02)v99  using nota1   foreground-color 15.
           05 sc-nota                 line 05  col 19 pic 9(02)v99  using nota2   foreground-color 15.
           05 sc-nota                 line 06  col 19 pic 9(02)v99  using nota3   foreground-color 15.
           05 sc-nota                 line 07  col 19 pic 9(02)v99  using nota4   foreground-color 15.
           05 sc-msn-cad-not          line 22  col 16 pic x(50)     using ws-msn  foreground-color 15.
      *>-----------------------------------------------------------------------------------------------------------------------

       01  tela-cad-aluno.
      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
           05 blank screen.
           05 line 01 col 01 value "                                                                     [ ]Sair     ".
           05 line 02 col 01 value "                                Cadastro de Alunos                               ".
           05 line 03 col 01 value "       Nome        :                                                             ".
           05 line 04 col 01 value "       Endereco    :                                                             ".
           05 line 05 col 01 value "       Nome da mae :                                                             ".
           05 line 06 col 01 value "       Nome do pai :                                                             ".
           05 line 07 col 01 value "       Telefone    :                                                             ".


           05 sc-nome-aluno        line 03  col 21 pic x(25) using aluno      foreground-color 15.
           05 sc-endereco          line 04  col 21 pic x(35) using endereco   foreground-color 15.
           05 sc-mae               line 05  col 21 pic x(25) using mae        foreground-color 15.
           05 sc-pai               line 06  col 21 pic x(25) using pai        foreground-color 15.
           05 sc-telefone          line 07  col 21 pic x(15) using telefone   foreground-color 15.
           05 sc-sair-cad-not      line 01  col 71 pic x(01) using ws-sair    foreground-color 12.

      *>----------------------------------------------------------------------------------------------------------------
       01  tela-consulta-cad.
      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
           05 blank screen.
           05 line 01 col 01 value "                                                                     [ ]Sair     ".
           05 line 02 col 01 value "                                Consulta de Cadastro                             ".
           05 line 03 col 01 value " Cod  Aluno      Endereco       Mae         Pai        Tel          Notas        ".

           05 sc-sair-cad-not         line 01  col 71 pic x(01)     using ws-sair foreground-color 12.
           05 sc-cadastro             line 04  col 02 pic x(76)     from  alunos  foreground-color 12.


       01  tela-pede-cod-consulta.
      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
           05 blank screen.
           05 line 01 col 01 value "                                                                     [ ]Sair     ".
           05 line 02 col 01 value "                                Insira o Cod de Consulta                         ".
           05 line 03 col 01 value "       Cod. Aluno:                                                               ".

           05 sc-sair-cad-not         line 01  col 71 pic x(01)     using ws-sair foreground-color 12.
           05 sc-cod-aluno            line 03  col 19 pic 9(03)     using cod     foreground-color 15.


      *>Declaração do corpo do programa
       procedure division.

           perform inicializa.
           perform processamento.
           perform finaliza.

      *>------------------------------------------------------------------------
      *>  procedimentos de inicialização
      *>------------------------------------------------------------------------
       inicializa section.
           move zeros to cod
      *>   inicializa menu
           move  spaces      to     menu

      *>   abrindo o arquivo para leitura e escrita
           open i-o arqCadAluno

      *>   tratamento de file status
           if ws-fs-arqCadAluno  <> 00
           and ws-fs-arqCadAluno <> 05 then
               move 1                                to ws-msn-erro-ofsset
               move ws-fs-arqCadAluno                to ws-msn-erro-cod
               move "Erro ao abrir arquivo"          to ws-msn-erro-text
               perform finaliza-anormal
           end-if

           .
       inicializa-exit.
           exit.

      *>------------------------------------------------------------------------
      *>  Processamento Principal
      *>------------------------------------------------------------------------
       processamento section.

           perform until ws-sair = "X"
                      or ws-sair = "x"

      *>        inicialização das variaveis  da tela
                move   space  to  ws-cadastro-aluno
                move   space  to  ws-cadastro-nota
                move   space  to  ws-consulta-cadastro
                move   space  to  ws-alterar-cadastro
                move   space  to  ws-deletar-cadastro
                move   space  to  ws-sair

                display tela-menu
                accept tela-menu

                if ws-cadastro-aluno = "X"
                or ws-cadastro-aluno = "x" then
                       perform cadastrar-aluno
                end-if

                if ws-cadastro-nota = "X"
                or ws-cadastro-nota = "x" then
                       perform cadastrar-notas
                end-if

                if ws-consulta-cadastro = "X"
                or ws-consulta-cadastro = "x" then
                       perform consultar-cadastro
                end-if

                if ws-consulta-seq-cadastro = "X"
                or ws-consulta-seq-cadastro = "x" then
                       perform consultar-cadastro-seq
                end-if


                if ws-alterar-cadastro = "X"
                or ws-alterar-cadastro = "x" then
                       perform alterar-cadastro
                end-if

                if ws-deletar-cadastro = "X"
                or ws-deletar-cadastro = "x" then
                       perform deletar-cadastro
                end-if


           end-perform
           .
       processamento-exit.
           exit.

      *>------------------------------------------------------------------------
      *>  cadastro de aluno
      *>------------------------------------------------------------------------
       cadastrar-aluno section.
      *>   inicializando variaveis
           move spaces to aluno
           move spaces to endereco
           move spaces to pai
           move spaces to mae
           move spaces to telefone
           display tela-cad-aluno
           accept tela-cad-aluno
           move alunos to fd-alunos

      *>   procurando o cod do prox aluno
           perform buscar-cod

      *>   gravando no arquivo
           write fd-alunos from alunos

      *>   tratamento de file status
           if ws-fs-arqCadAluno <> 00 and ws-fs-arqCadAluno <> 23  then
               move 2                                   to ws-msn-erro-ofsset
               move ws-fs-arqCadAluno                   to ws-msn-erro-cod
               move "Erro ao ler arq. no cad. de aluno" to ws-msn-erro-text
               perform finaliza-anormal
           end-if

           .
       cadastrar-aluno-exit.
           exit.


      *>------------------------------------------------------------------------
      *>  buscar o cod
      *>------------------------------------------------------------------------
       buscar-cod section.


      *>   definindo onde o arq comeca
           move 1 to fd-cod
           read arqCadAluno

           if ws-fs-arqCadAluno = 23 then
               move 1 to cod
           else
               perform until ws-fs-arqCadAluno = 10
      *>       le o arq sequencialmente e add um no cod
                   read arqCadAluno next
               end-perform
      *>       passando os dados para a var da ws
               move fd-cod to cod
               add 1 to cod
           end-if
           .
       buscar-cod-exit.
           exit.


      *>------------------------------------------------------------------------
      *>  cadastro de notas
      *>------------------------------------------------------------------------
       cadastrar-notas section.

           perform until ws-sair = "V"
                      or ws-sair = "v"
      *>       inicializando variaveis
               move zeros      to  cod
               move zeros      to nota1
               move zeros      to nota2
               move zeros      to nota3
               move zeros      to nota4

               display tela-cad-notas
               accept tela-cad-notas

      *>       movendo o cod digitado para a chave do arquivo
               move cod to fd-cod
      *>       puxando os dados do arquivo pelo codigo digitado
               read arqCadAluno

      *>       tratamento de file status
               if ws-fs-arqCadAluno <> 00 then
                   move 3                                     to ws-msn-erro-ofsset
                   move ws-fs-arqCadAluno                     to ws-msn-erro-cod
                   move "Erro ao ler arq. para aceitar notas" to ws-msn-erro-text
                   perform finaliza-anormal
               end-if

      *>       passando os dados recebidos da tela para o arquivo
               move notas     to fd-notas
               move space     to ws-msn

      *>       validando as notas (de 1 a 10)
               if  nota1 >= 0 and nota1 <= 10
               and nota2 >= 0 and nota2 <= 10
               and nota3 >= 0 and nota3 <= 10
               and nota4 >= 0 and nota4 <= 10 then
                   rewrite fd-alunos
               else
                   move  "Nota Invalida!"     to ws-msn
                   display tela-cad-notas
               end-if

               accept tela-cad-notas
           end-perform
           .
       cadastrar-notas-exit.
           exit.

      *>------------------------------------------------------------------------
      *>  consultar cadastro
      *>------------------------------------------------------------------------
       consultar-cadastro-seq section.
      *>   inicializando o cod
           move zeros to cod

      *>   lendo sequencialmente ate o final
           read arqCadAluno next into alunos

      *>   tratamento de file status
           if ws-fs-arqCadAluno <> 00 and ws-fs-arqCadAluno <> 10 then
               move 4                                 to ws-msn-erro-ofsset
               move ws-fs-arqCadAluno                 to ws-msn-erro-cod
               move "Erro ao ler arq. para consulta sequencial." to ws-msn-erro-text
               perform finaliza-anormal
           end-if

      *>   imprimindo o cadastro na tela
           display tela-consulta-cad
           accept tela-consulta-cad

           .
       consultar-cadastro-seq-exit.
           exit.

      *>------------------------------------------------------------------------
      *>  consultar cadastro
      *>------------------------------------------------------------------------
       consultar-cadastro section.
      *>   inicializando o cod
           move zeros to cod

      *>   pedindo o codigo para o usuario
           display tela-pede-cod-consulta
           accept tela-pede-cod-consulta

      *>   movendo o codigo digitado para a chave do arquivo
           move cod to fd-cod
      *>   lendo o registro de acordo com o codigo digitado
           read arqCadAluno into alunos

      *>   tratamento de file status
           if ws-fs-arqCadAluno <> 00 then
               move 5                                 to ws-msn-erro-ofsset
               move ws-fs-arqCadAluno                 to ws-msn-erro-cod
               move "Erro ao ler arq. para consulta." to ws-msn-erro-text
               perform finaliza-anormal
           end-if


      *>   imprimindo o cod na tela
           display tela-consulta-cad
           accept tela-consulta-cad

           .
       consultar-cadastro-exit.
           exit.

      *>------------------------------------------------------------------------
      *>  alterar cadastro
      *>------------------------------------------------------------------------
       alterar-cadastro section.
      *>   pedindo o codigo para o usuario
           display tela-pede-cod-consulta
           accept tela-pede-cod-consulta

      *>   achando o registro dentro do arquivo
           move cod to fd-cod
      *>   lendo o registro de acordo com o codigo digitado
           read arqCadAluno into alunos

      *>   tratamento de file status
           if ws-fs-arqCadAluno <> 00 then
               move 6                                  to ws-msn-erro-ofsset
               move ws-fs-arqCadAluno                  to ws-msn-erro-cod
               move "Erro ao ler arq. para alteracao " to ws-msn-erro-text
               perform finaliza-anormal
           end-if

      *>   aceitando os novos dados do cadastro p alteracao
           display tela-cad-aluno
           accept tela-cad-aluno

      *>   passando os dados recebidos para o arquivo
           move alunos to fd-alunos
           rewrite fd-alunos

           .
       alterar-cadastro-exit.
           exit.

      *>------------------------------------------------------------------------
      *>  apagar cadastro
      *>------------------------------------------------------------------------
       deletar-cadastro section.
      *>   pedindo o codigo para o usuario
           display tela-pede-cod-consulta
           accept tela-pede-cod-consulta

      *>   achando o registro dentro do arquivo
           move cod to fd-cod
           delete arqCadAluno

      *>   tratamento de file status
           if ws-fs-arqCadAluno <> 00 then
               move 7                                  to ws-msn-erro-ofsset
               move ws-fs-arqCadAluno                  to ws-msn-erro-cod
               move "Erro ao ler arq. para excluir cad. " to ws-msn-erro-text
               perform finaliza-anormal
           end-if

           .
       deletar-cadastro-exit.
           exit.


      *>------------------------------------------------------------------------
      *>  Finalização  Anormal
      *>------------------------------------------------------------------------
       finaliza-anormal section.
           display erase
           display ws-msn-erro-ofsset
           display ws-msn-erro-cod
           display ws-msn-erro-text
           Stop run
           .
       finaliza-anormal-exit.
           exit.

      *>------------------------------------------------------------------------
      *>  Finalização
      *>------------------------------------------------------------------------
       finaliza section.
           close arqCadAluno

           if ws-fs-arqCadAluno  <> 00 then
               move 8                                to ws-msn-erro-ofsset
               move ws-fs-arqCadAluno                to ws-msn-erro-cod
               move "Erro ao fechar arquivo"         to ws-msn-erro-text
               perform finaliza-anormal
           end-if
           Stop run
           .
       finaliza-exit.
           exit.



