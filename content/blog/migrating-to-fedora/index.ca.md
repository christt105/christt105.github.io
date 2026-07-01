---
title: "De Zorin OS a Fedora: Crònica d'una migració i un USB rebel"
description: La meva experiència migrant el portàtil a Fedora, els problemes inexplicables amb el pendrive d'instal·lació i les meves primeres impressions amb la distro del barret.
date: 2026-07-01
image: cover.png
keywords:
  - Fedora
  - Zorin OS
  - Linux
  - boot
  - USB
  - instal·lació
readingTime: true
comments: true
draft: false
categories:
  - Sistemes Operatius
tags:
  - linux
  - zorin-os
  - fedora
  - instalacio
  - opinion
---

## Punts clau d'aquesta migració

Abans d'entrar en detalls, aquí us deixo un resum ràpid de com ha anat aquest procés:

* **La decisió:** Després del gust agredolç amb Zorin OS (especialment pel tema de kernels antics i suport de maquinari modern com el wifi), vaig decidir fer el salt a Fedora al portàtil.
* **L'obstacle de l'USB:** Preparar l'instal·lador va ser un mal de cap inesperat. El pendrive es quedava penjat indefinidament a la pantalla de boot de Fedora.
* **La solució a l'engegada:** Vaig haver de lluitar amb el format de la imatge, ajustar un parell de coses a la BIOS (com desactivar el Secure Boot) i utilitzar el mode de gràfics bàsics perquè per fi carregués l'instal·lador.
* **El sistema final:** Fedora 40/41 amb Gnome va com una moto. I el millor de tot: la targeta de xarxa funciona de sèrie sense scripts estranys.

---

Hola de nou!

Com ja us vaig avançar en el post anterior on us explicava el meu petit fracàs amb Zorin OS, tenia clar que el següent pas per al portàtil de casa era provar Fedora. La veritat és que Zorin es veu genial, però quedar-te estancat en un kernel antic quan tens maquinari modern a casa és una recepta per al desastre.

Així que, aprofitant una estona lliure aquest cap de setmana, em vaig disposar a fer la migració. Spoiler: no va ser bufar i fer ampolles.

## El misteri del pendrive rebel

Per començar, em vaig baixar la ISO de Fedora Workstation. Com solc fer sempre, vaig agafar un pendrive vell que tinc per l'escriptori i vaig cremar la imatge.

Aquí va començar el malson. Vaig connectar l'USB al portàtil, el vaig engegar, vaig seleccionar arrencar des del dispositiu USB i... res. Es quedava congelat de forma indefinida a la pantalla de boot de Fedora. Aquella pantalla de càrrega fosca amb el logotip de Fedora i la roda donant voltes (o de vegades ni això, es quedava el cursor parpellejant a dalt a l'esquerra en pla dramàtic).

La veritat és que al començament vaig pensar que era cosa del propi USB. De vegades aquests pendrives promocionals barats fallen més que una escopeta de fira. Així que vaig buscar un altre pen de millor qualitat, el vaig tornar a flassejar fent servir Ventoy, i ho vaig tornar a intentar. Mateix resultat. Es quedava allà penjat, rient-se de mi.

Vaig decidir canviar de tàctica i utilitzar l'eina oficial, **Fedora Media Writer**, en lloc de Ventoy o Rufus. A més, vaig entrar a la BIOS del portàtil per desactivar el *Secure Boot*, que a vegades es posa un poc tonto amb distros que no són Ubuntu o Windows.

Per últim, al menú d'arrencada de Fedora (Grub), en lloc de donar-li a l'opció per defecte, vaig entrar a la secció de *Troubleshooting* (resolució de problemes) i vaig seleccionar **Start Fedora in basic graphics mode** (arrencar Fedora en mode de gràfics bàsics). No sé si va ser per l'eina oficial, el Secure Boot o el mode de gràfics bàsics, però la pantalla de càrrega per fi va avançar i em vaig plantar a l'instal·lador de Fedora. Quin alleujament!

## Instal·lació i posada a punt

Una vegada dins de l'instal·lador de Fedora, tot va anar com una seda. Anaconda (l'instal·lador de Fedora) ha millorat bastant la seva interfície i ara és súper intuïtiu. Vaig crear les particions de nou (aquesta vegada assegurant-me de deixar una partició swap decent de 8 GB per evitar que se'm congelés la RAM en obrir dues pestanyes de VS Code) i li vaig donar a instal·lar.

 En uns deu minuts ja tenia l'ordinador reiniciat i amb l'escriptori net de Fedora llest per a trastejar.

El primer que vaig fer, òbviament, va ser comprovar si el wifi funcionava. I efectivament: com que porta un kernel de Linux molt actualitzat (la versió 6.8+ enfront del kernel 6.2 que arrossegava Zorin), va reconèixer la targeta MediaTek a l'instant. Sense scripts de GitHub de dubtosa procedència i sense por que una actualització em trenqui la connexió. Això sí que és vida!

## Primeres sensacions

Per ara la veritat és que estic encantat. Gnome pur a Fedora se sent extremadament fluid i net. He tornat a configurar tot l'ecosistema que compartim:

* **Flatpaks** habilitats a la botiga de programari (imprescindible per a Calibre, Discord i Spotify).
* **Syncthing** configurat en segon pla per sincronitzar el meu vault d'Obsidian.
* **VS Code** i el client de Git llistos per a quan em ve de gust programar des del sofà.

Tot i que a la meva parella li és una mica igual la distribució mentre pugui obrir Calibre i els seus llibres, agraeixo molt tenir un sistema amb paquets actualitzats i un cicle de suport robust.

Sé que no sóc cap expert en Fedora (sempre he estat més de la família de Debian/Ubuntu), però l'estabilitat i frescor que transmet aquesta distro m'està agradant molt. Ja us aniré explicant si sorgeixen més problemes en el dia a dia.

I vosaltres? Heu tingut problemes rars en arrencar Fedora des d'un USB? Ens veiem en el proper post!
