section .data ; section contenant toutes les données statiques (initialisées à l'avance)
    msg db 'Hello world', 0xa ; on définit un message à afficher suivi de 0xa
                              ; 0xa = 10 en décimal = saut de ligne (LF) en ASCII = "\n"
    
    len equ $ - msg ; longueur_message égale adresse_actuelle - adresse_de_début_de_msg
                    ; ici, len = 13 (12 caractères + saut de ligne)

section .text ; section contenant le code exécutable
    global _start ; point d'entrée du programme (Linux commence ici)

_start: ; début du programme principal

    mov edx, len ; EDX (donnée) = longueur du message (nombre d'octets à écrire)
    mov ecx, msg ; ECX (compteur) = adresse du message (ce qu'on veut afficher)
    mov ebx, 1   ; EBX = 1 (1 = stdout = l'écran)
    mov eax, 4   ; EAX = 4 (4 = systcall "write")

    int 0x80     ; interruption logicielle → Linux exécute write(stdout, msg, len)
                 ; c’est ce qui affiche "Hello world" suivi d’un saut de ligne

    mov eax, 1   ; EAX = 1 (1 = systcall "exit")
    mov ebx, 0   ; EBX = 0 (0 = "return" = succès)

    int 0x80     ; interruption → Linux quitte proprement le programme
