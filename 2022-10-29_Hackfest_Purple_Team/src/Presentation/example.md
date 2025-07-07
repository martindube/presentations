---
marp: true
theme: dark
title: Présentation Pentest
description: Un modèle de présentation pour ETTIC
size: 16:9
header: "Présentation de rapport XYZ"
footer: "Document confidentiel"
paginate: true
class: default_slide
_paginate: false        # Ne pas paginer la page 1.
_class: separation_page1 # Style de la page 1.
math: katex
---
<!-- Toujours "Double Quotes" les variables dans la section de déclaration des varaibles plus haut ^ -->


<!-- Optionel: Liens réutilisable -->
[marp-team]: https://github.com/marp-team
[marpit]: https://github.com/marp-team/marpit
[marp-core]: https://github.com/marp-team/marp-core
[marp-cli]: https://github.com/marp-team/marp-cli
[marp-vscode]: https://github.com/marp-team/marp-vscode

<!-- For light theme -->
<!-- ![h:150](../Ressources/images_tpl/teams/ettic-logo-transparentbg-medium.png) -->

<!-- For dark theme -->
![h:150](../Ressources/images_tpl/teams/ettic-logo-transparentbg-medium-whitetext.png)

# Markdown Presentation Template

### :calendar: 2021-11-06

---

# README

Cette présentation se veut un modèle pour faciliter la rédaction de présentation en markdown pour l'équipe ETTIC.

Elle a été faite avec VSCode et le plugin [marp-vscode][marp-vscode]. 

Le contenu est une version adapté de ce fichier d'[exemple](https://gist.github.com/yhatt/a7d33a306a87ff634df7bb96aab058b5).

Ce thème est une version adapté du thème [par défaut](https://github.com/marp-team/marp-core/blob/main/themes/default.scss).

---

<!-- _class: separation_page1 -->
# Separation page 1

Hello World!
 
---

<!-- _class: separation_page2 -->
# Separation page 2

Hello World!
 
---

# Marp Features

- :memo: **Write slide deck with plain Markdown** (CommonMark)
- :factory: Built on [Marpit framework][marpit]: A brand-new skinny framework for creating slide deck
- :gear: [Marp Core][marp-core]: Easy to start using the core engine and built-in themes via npm
- :tv: [Marp CLI][marp-cli]: Convert Markdown into HTML, PDF, PPTX, and ../Ressources/images_tpl
- :vs: [Marp for VS Code][marp-vscode]: Live-preview your deck while editting
- :star_struck: [Markdown-it-emoji](https://github.com/ikatyang/emoji-cheat-sheet): Tons of emojis
- and more...

---

# How to write slides?

Split pages by horizontal ruler (e.g. `---`). It's very simple.

```markdown
# Slide 1

foobar

---

# Slide 2

foobar
```

---

# Bullet points

* Bullet 1
  * Sub-bullet 1
    * Sub-Sub-bullet 1
    * Sub-Sub-bullet 2
    * Sub-Sub-bullet 3
  * Sub-bullet 2
* Bullet 2
* **Du texte sur plusieurs lignes.** Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin fermentum erat eu consequat posuere. Praesent fringilla ante eget ex congue cursus. Aliquam diam augue, aliquam quis pellentesque non, hendrerit eu justo. Nunc vulputate metus felis, at placerat quam congue sit amet.
---

# Table

| Command          | Default | Unhooking | Comments                                                       |
| ---------------- | ------- | --------- | -------------------------------------------------------------- |
| execute-assembly | Hot     | Cool      | ProcessRollup2 + ScriptControlScanTelemetry                    |
| powerpick        | Hot     | Cool      | ProcessRollup2 + ScriptControlScanTelemetry + NewScriptWritten |
| shspawn          | Hot     | Cool      | ProcessRollup2 + Depends on shellcode                          |
| inject           | Hot     | Warm      | RemotePivot + InjectedThread                                   |

<br/>
<br/>
Unhooking is awesome!

---

# Small Table

| Command          | Default |
| ---------------- | ------- |
| execute-assembly | Hot     |
| powerpick        | Hot     |
| shspawn          | Hot     |
| inject           | Hot     |

---

# Fancy Table 1

<div class="fancy-table1">

| Command        | Defaul                                                                  |
| -------------- | ----------------------------------------------------------------------- |
| Malléabilité   | Modification du comportement réseau et système.                         |
| Modularité     | Ajout de modules personnalisés pour intégrer des fonctionnalités.       |
| Furtivité      | Contournement des mécanismes de détection moderne (ex: EDR, NIDS/NIPS). |
| Automatisation | Réalisation de tâches et d'actions via un langage de scripting.         |

</div>

---

# Fancy Table 2

<div class="fancy-table2">

| Texte invisible        | Il y a 3 ans                                               | Aujourd'hui                                               |
| ---------------------- | ---------------------------------------------------------- | --------------------------------------------------------- |
| Modus Operandi         | Attaques automatisées                                      | Attaques manuelles (opérateurs)                           |
| Sophistication         | Minimal à Intermédiaire<br/>(Script-Kiddie / Toolkit User) | Avancé à Expert<br/>(Toolkit Developer / Malware Creator) |
| Capacité d'outils      | Utilisation d'outils open-source                           | Utilisation de framework propriétaires                    |
| Contrôles du mouvement | Efficaces                                                  | ??? (à déterminer)                                        |

</div>

---

# 2 colones

Veuillez choisir entre la...

<div class="twocols">

## pillule bleu

- Ignorance
- a
- b
- c
- d

## pillule rouge

- Volonté d'apprendre
- Vérité qui changera ta vie
- a
- b
- c
- d

</div>

---

# 3 colones

<div class="threecols">

## Keep

- S'entraîner
- Bien manger
- Dormir

## Start

- Aller au gym
- Méditer

## Stop

- Prendre mon téléphone la première heure de la journée

</div>

---

# Directives

Marp has extended syntax called **"Directives"** to support creating beautiful slides.

Insert front-matter to the top of Markdown:

```
---
theme: default
---
```

or HTML comment to anywhere:

```html
<!-- theme: default -->
```

https://marpit.marp.app/directives

---

## [Global directives](https://marpit.marp.app/directives?id=global-directives)

- `theme`: Choose theme
- `size`: Choose slide size from `16:9` and `4:3` *(except Marpit framework)*
- [`headingDivider`](https://marpit.marp.app/directives?id=heading-divider): Instruct to divide slide pages at before of specified heading levels

```
---
theme: gaia
size: 4:3
---

# Content
```

> Marp can use [built-in themes in Marp Core](https://github.com/marp-team/marp-core/tree/master/themes#readme): `default`, `gaia`, and `uncover`.

---

## [Local directives](https://marpit.marp.app/directives?id=local-directives)

These are the setting value per slide pages.

- `paginate`: Show pagination by set `true`
- `header`: Specify the contents for header
- `footer`: Specify the contents for footer
- `class`: Set HTML class for current slide
- `color`: Set text color
- `backgroundColor`: Set background color

---

### Spot directives

Local directives would apply to **defined page and following pages**.

They can apply to single page by using underscore prefix such as `_class`.

![bg right 95%](https://marpit.marp.app/assets/directives.png)

---

### Example

This page is using invert color scheme [defined in Marp built-in theme](https://github.com/marp-team/marp-core/tree/master/themes#readme).

<!-- _class: invert -->

```html
<!-- _class: invert -->
```

---

# [Image syntax](https://marpit.marp.app/image-syntax)

You can resize image size and apply filters through keywords: `width` (`w`), `height` (`h`), and filter CSS keywords.

```markdown
![width:100px height:100px](image.png)
```

```markdown
![blur sepia:50%](filters.png)
```

Please refer [resizing image syntax](https://marpit.marp.app/image-syntax?id=resizing-image) and [a list of CSS filters](https://marpit.marp.app/image-syntax?id=image-filters).

![](../Ressources/images_tpl/300px-Desjardins_Group_logo.svg.png) ![blur sepia:50%](../Ressources/images_tpl/300px-Desjardins_Group_logo.svg.png)

---


# Simple slide with center image (default)

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultricies elit sed augue viverra, tempus ultrices urna dignissim. 

![h:350px](../Ressources/images_tpl/side-image1.jpg)

---

<!-- class: align_left_img -->
# Simple slide with left image

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultricies elit sed augue viverra, tempus ultrices urna dignissim. 

```
<!-- class: align_left_img -->
```

![h:270px](../Ressources/images_tpl/side-image1.jpg)

---

<!-- class: align_right_img -->
# Simple slide with left right

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ultricies elit sed augue viverra, tempus ultrices urna dignissim. 

```
<!-- class: align_right_img -->
```

![h:270px](../Ressources/images_tpl/side-image1.jpg)

---

<!-- Remettre la class par défaut -->
<!-- class: default_slide -->
# [Background image](https://marpit.marp.app/image-syntax?id=slide-backgrounds)

You can set background image for a slide by using `bg` keyword.

```markdown
![bg opacity:20%](../Ressources/images_tpl/green_bg.png)
```

![bg opacity:20%](../Ressources/images_tpl/green_bg.png)

---

## Multiple backgrounds ([Marpit's advanced backgrounds](https://marpit.marp.app/image-syntax?id=advanced-backgrounds))

Marp can use multiple background ../Ressources/images_tpl.

```markdown
![bg blur:3px](https://fakeimg.pl/800x600/fff/ccc/?text=A)
![bg blur:3px](https://fakeimg.pl/800x600/eee/ccc/?text=B)
![bg blur:3px](https://fakeimg.pl/800x600/ddd/ccc/?text=C)
```

Also can change alignment direction by including `vertical` keyword.

![bg blur:3px](https://fakeimg.pl/800x600/fff/ccc/?text=A)
![bg blur:3px](https://fakeimg.pl/800x600/eee/ccc/?text=B)
![bg blur:3px](https://fakeimg.pl/800x600/ddd/ccc/?text=C)

---

## [Split background](https://marpit.marp.app/image-syntax?id=split-backgrounds)

Marp can use [Deckset](https://docs.deckset.com/English.lproj/Media/01-background-../Ressources/images_tpl.html#split-slides) style split background(s).

Make a space for background by `bg` + `left` / `right` keywords.

```markdown
![bg right](./../Ressources/images_tpl/side-image2.jpg)
```

![bg right:45%](./../Ressources/images_tpl/side-image2.jpg)

---

## [Split background](https://marpit.marp.app/image-syntax?id=split-backgrounds)

Marp can use [Deckset](https://docs.deckset.com/English.lproj/Media/01-background-../Ressources/images_tpl.html#split-slides) style split background(s).

Make a space for background by `bg` + `left` / `right` keywords.

```markdown
![bg left](./../Ressources/images_tpl/side-image2.jpg)
```

![bg left:45%](./../Ressources/images_tpl/side-image2.jpg)

---

## [Fragmented list](https://marpit.marp.app/fragmented-list)

Marp will parse a list with asterisk marker as the fragmented list for appearing contents one by one. (_**Only for exported HTML** by [Marp CLI][marp-cli] / [Marp for VS Code][marp-vscode]_)

```markdown
# Bullet list

- One
- Two
- Three

---

# Fragmented list

* One
* Two
* Three
```

---

## Math typesetting (only for [Marp Core][marp-core])

[KaTeX](https://katex.org/) math typesetting such as $ax^2+bc+c$ can use with [Pandoc's math syntax](https://pandoc.org/MANUAL.html#math).

$$I_{xx}=\int\int_Ry^2f(x,y)\cdot{}dydx$$

```tex
$ax^2+bc+c$
```
```tex
$$I_{xx}=\int\int_Ry^2f(x,y)\cdot{}dydx$$
```

---

## Auto-scaling (only for [Marp Core][marp-core])

*Several built-in themes* are supported auto-scaling for code blocks and math typesettings.

```text
Too long code block will be scaled-down automatically. ------------>
```
```text
Too long code block will be scaled-down automatically. ------------------------>
```
```text
Too long code block will be scaled-down automatically. ------------------------------------------------>
```

---

##### <!--fit--> Auto-fitting header (only for [Marp Core][marp-core])
##### <!--fit--> is available by annotating `<!--fit-->` in headings.

<br />

```html
## <!--fit--> Auto-fitting header (only for Marp Core)
```

---

## [Theme CSS](https://marpit.marp.app/theme-css)

<style scoped>
pre {
  font-size: 19px;
}
</style>

Marp uses `<section>` as the container of each slide. And others are same as styling for plain Markdown. The customized theme can use in [Marp CLI][marp-cli] and [Marp for VS Code][marp-vscode].

```css
/* @theme your-theme */

@import 'default';

section {
  /* Specify slide size */
  width: 960px;
  height: 720px;
}

h1 {
  font-size: 30px;
  color: #c33;
}
```

---

## [Tweak style in Markdown](https://marpit.marp.app/theme-css?id=tweak-style-through-markdown)

`<style>` tag in Markdown will work in the context of theme CSS.

```markdown
---
theme: default
---

<style>
section {
  background: yellow;
}
</style>

Re-painted yellow background, ha-ha.
```

> You can also add custom styling by class like `section.custom-class { ... }`.
> Apply style through `<!-- _class: custom-class -->`.

---

## [Scoped style](https://marpit.marp.app/theme-css?id=scoped-style)

If you want one-shot styling for current page, you can use `<style scoped>`.

```markdown
<style scoped>
a {
  color: green;
}
</style>

![Green link!](https://marp.app/)
```

<style scoped>
a { color: green; }
</style>

---

# Specific Header/footer

<!-- _header: "**Some bold header**" -->
<!-- _footer: "**A bold footer**" -->

```html
<!-- _header: "**Some bold header**" -->
<!-- _footer: "**A bold footer**" -->
```

---

# Slide with overflow

1
2
3  (@TODO: Déterminer comment on devrait gérer les overflows)
4
5
6
7
8
9
10
11
12
13
14
overflow overflow overflow

---

# Slide with GIF

Pour avoir des GIF dans une présentation, exporter en HTML.

![h:400px](../Ressources/images_tpl/demo.gif)

---

<!-- _class: separation_page1 -->
# Enjoy writing slides! :v: <!--fit-->

##### ![w:1em h:1em](https://avatars1.githubusercontent.com/u/20685754?v=4)  Marp: Markdown presentation ecosystem — https://marp.app/

###### by Marp Team ([@marp-team][marp-team])