# Guide ultime pour installer opam/frama-c et la totalité de l'internet

Le but de ce tuto est de pouvoir travailler et faire fonctionner des plugins frama-c.

## Installation
On doit d'abord installer emacs (ouai je sais mais on est pas obligé de l'utiliser), opam et quelques paquets pour opam
---
sudo apt install emacs
sudo apt install opam
opam install merlin tuareg ocp-indent
---

Alors, si vous avez un message d'erreur, lisez-le, il devrait vous indiquez les paquets qu'il vous manque pour faire l'installation.
La commande d'installation est dans le message et a à peu pres cette tronche
---
opam depext machin-truc-bidule
---

Enfin on télécharge frama-c (même rq que précédement, si ca marche pas lisez le msg d'erreur)
---
opam install frama-c
---

Ensuite quand on a fini avec tout ces paquets, il faut creer un sous-dossier frama-c dans .emacs
---
mkdir ~/.emacs.d/frama-c
---


## Setup de l'environnement
Ensuite on va récupérer les sources de frama-c.
Il faut vous rendre à la page:

http://frama-c.com/download.html

et cliquez sur: 20171101 Source distribution [Compilation instructions]

Vous obtenez un .tar.gz que vous décompressez où bon vous semble. (de préférence pas dans tmp ou telechargement mais vous êtes grands, hein). Vous allez enfin partager à emacs tout un tas de fichier d'un bloc.
---
cp <<path to frama-c sources>>/share/emacs/frama-c-*.el ~/.emacs.d/frama-c/
---

Par la même occasion, on va faire un peu de magie noire
---
touch ~/.emacs
---

Et il faut écrire dedans:
---
(add-to-list 'load-path "~/.emacs.d/frama-c")
(load-library "frama-c-recommended")
---

Félicitations! Tout devrait marcher à présent. Pour tester, on peut faire la commande suivante:
---
frama-c -load-script hello_world.ml
---

En cas de problème, google peut vous aider mieux que moi