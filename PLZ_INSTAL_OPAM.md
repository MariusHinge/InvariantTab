# Guide ultime pour installer opam/frama-c et la totalité de l'internet

Le but de ce tuto est de pouvoir travailler et faire fonctionner des plugins frama-c.

## Installation
On doit d'abord installer emacs (ouai je sais mais on est pas obligé de l'utiliser), opam et quelques paquets pour opam
'''
sudo apt install emacs
sudo apt install opam
opam install merlin tuareg ocp-indent
'''

Alors, si vous avez un message d'erreur, lisez-le, il devrait vous indiquez les paquets qu'il vous manque pour faire l'installation.
La commande d'installation est dans le message et a à peu pres cette tronche
'''
opam depext machin-truc-bidule
'''

Ensuite quand on a fini avec tout ces paquets, il faut creer un sous-dossier frama-c dans .emacs
'''
mkdir ~/.emacs.d/frama-c
'''

Par la même occasion, on va faire un peu de magie noire
'''
touch lol.txt
'''

Et il faut écrire dedans:
'''
(add-to-list 'load-path "~/.emacs.d/frama-c")
(load-library "frama-c-recommended")
'''

