# Modèle de présentation

## Installation

1. Installer VS code
2. À l'ouverture du répertoire (`Ctrl + k, Ctrl + o`), il vous sera proposé de télécharger les extensions nécessaires.
   1. **Marp for VS Code** est requis
   2. Les autres sont optionel mais pratique

Pour plus d'information, suivre les indications de la page suivante: https://github.com/marp-team/marp-vscode


## Usage

Le fichier `./Presentation/example.md` comprend plusieurs cas d'usage et exemples.

Le répertoire `./Ressources/images_tpl/` comprend les logos de chaque pratique ainsi que d'autres images réutilisables. 

Pour des besoins plus spécifiques, la documentation détaillé du projet marp est ici: https://marpit.marp.app/markdown


## Thèmes

Les thèmes sont le répertoire `./Ressources/presentation_themes/`.

Pour utiliser un thème, changer la variable `theme` dans l'entête de la présentation. 

Pour créer un thème, il suffit de créer un sous-répertoire, d'y développer un fichier CSS et de déposer les images. 

Pour construire des images d'arrière plan, utiliser le fichier `./Ressources/presentation_themes/gimp_presentation.xcf` et les *layers* à l'intérieur.


## Exporter la présentation

1. Dans VS code, taper `F1` ou `Ctrl + Shift + P`
2. Dans le champ de recherche, taper: `Marp: Export Slide Deck`
3. Cliquer sur la commande.


## Copier/coller des images en markdown

1. Installer [Markdown Image](https://marketplace.visualstudio.com/items?itemName=hancel.markdown-image). 
2. Copier une image
3. Coller l'image à l'aide de `Ctrl + Shift + V` ou `Alt + Shift + V`.
4. Les images seront stocké dans le répertoire `./Ressources/images_local/` par défaut. 

