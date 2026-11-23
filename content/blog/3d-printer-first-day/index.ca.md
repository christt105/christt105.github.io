---
title: "Primer dia de fracàs amb la meva impressora 3D"
description: "Vaig comprar una Ender 3 Max de segona mà per uns 60 euros i el primer dia va ser un desastre: primera capa irregular, fils per tot arreu i una retracció que no funciona."
date: 2026-11-23
image: cover.png
keywords:
  - Impressora 3D
  - Ender 3 Max
  - Ender 3
  - Stringing
  - Retracció
  - Calibratge
  - Primera capa
readingTime: true
comments: true
categories:
  - Impressora 3D
tags:
  - ender-3
  - 3d-printing
---
Aquest és el dia u d'una sèrie de diaris que vull fer amb la nova impressora que m'he comprat. L'hi he comprat al meu cosí per uns 60 euros: se la volia treure de sobre i comprar-se una Bambu Lab, per tenir multimaterial i no perdre tant de temps en manteniment. És una Ender 3 Max a la qual ha fet algunes modificacions que estan molt bé. És absurdament gran, més del que esperava.

Ja vaig tenir una Anet A8 fa moltíssims anys. La vaig muntar jo mateix i vaig acabar venent-la perquè no l'usava: quan anava a imprimir alguna cosa sempre havia de dedicar-hi un munt de manteniment. Sé que aquesta també en té, però la vaig comprar bàsicament per tornar a treure'm el cuquet de la impressió 3D i fer quatre collonades.

El primer dia ha estat un fracàs.

## Primera capa: comencem regular

Primer vaig apretar els cargols i vaig ajustar el bàsic, i vaig llançar una impressió de prova: la primera capa a les quatre cantonades i al centre del llit. Es veu bé en general, però hi ha irregularitats. Crec que és un tema de calibratge, perquè el broquet estava massa a prop del llit. És l'única cosa del dia que va sortir mitjanament bé.

![Quadrats de prova de la primera capa a les cantonades i al centre del llit](first-layer-five-squares.jpg)

![Un quadrat amb la primera capa irregular](first-layer-uneven-square.jpg)
![Un altre quadrat de prova, amb una zona clarament pitjor](first-layer-worse-square.jpg)

## Temperatura: comencen els fils

Després vaig fer una torre de temperatura i aquí ja vaig començar a veure coses lletges. Sortien moltíssims fils, per tot arreu, i em vaig posar una mica nerviós.

Una torre de temperatura és una peça que s'imprimeix en diversos trams, cadascun a una temperatura diferent (aquí de 195 a 220 graus). La idea és comparar els trams i quedar-te amb la temperatura que funciona millor per a aquell filament. Importa perquè el plàstic més calent és més líquid i degota més pel broquet, que és justament el que forma els fils (stringing). Si el problema fos només la temperatura, bastaria baixar-la fins que els fils desapareguessin sense que la peça comencés a fallar per manca de fusió.

![Torre de temperatura, de 195 a 220 graus](temperature-tower.jpg)

Com es veu a la imatge, hi ha moltíssims fils. On menys n'hi ha és a 195 °C, la temperatura més baixa, que a més està lleugerament per sota del mínim que recomana el venedor del filament. La temperatura influeix molt, però la impressora no hauria d'imprimir així. Tot i això, ens dona moltes pistes per identificar el problema.

## Retracció: desastre total

Vaig estar investigant i semblava un tema de retracció.

La retracció és quan l'extrusor estira una mica del filament cap enrere just abans que el capçal es desplaci sense imprimir. Així s'alleugereix la pressió dins del broquet i no degota plàstic pel camí. Si la retracció no fa bé la seva feina, queden fils fins entre les parts de la peça, que és exactament el que em passava. Es configura amb la distància (quant filament retrau) i la velocitat, i la manera habitual d'ajustar-la és una prova de retracció: una peça que s'imprimeix amb distàncies diferents i on busques el valor amb menys fils.

Així que vaig fer aquesta prova. Va sortir fatal, tota fatal, des del 0 fins al 6 que vaig provar. L'Ender té un extrusor Bowden, que funciona diferent d'un directe, i la retracció és una cosa important a tenir en compte, però com es veu, no hi va haver cap canvi.

![Prova de retracció plena de fils](retraction-test-stringing.jpg)

Per arrodonir-ho, en acabar una impressió el broquet continua extruint filament i queda un fil penjant de la impressora. Això em va donar alguna pista sobre el problema.

![Un fil de filament penjant del broquet en acabar](filament-string-hanging-from-nozzle.jpg)

## La peça de la meva germana

Després vaig imprimir una peça que volia la meva germana per no sé què del laboratori. Va sortir bastant malament, però com que no era una cosa definitiva la vaig deixar així, i sort, perquè m'ha dit que s'han de canviar coses. Té fils que es poden tallar i polir, però no hauria d'imprimir així.

Hi ha un altre problema, que no és tant de la impressora: la peça té molt voladís, i els fils quedaven penjant entre les parts.

![La peça de la meva germana vista des de dalt, amb fils creuats](sister-part-top-view.jpg)
![Els fils entre els voladissos](sister-part-stringing-overhangs.jpg)
![La peça de la meva germana de front](sister-part-front-view.jpg)
![Una altra vista de la peça, amb fils a l'aire](sister-part-strings-in-air.jpg)

![Dues barres unides per fils a l'aire](bridge-bars-strings.jpg)

## Una mica d'alegria: la peça del calaix

Perquè no fos tot negatiu, vaig imprimir la típica peça d'IKEA per subjectar els cargols d'un calaix que es trencava cada dos dies, de la qual me'n faltava una.

![La peça al llit](ikea-part-on-bed.jpg)
![La peça acabada de fer](ikea-part-finished.jpg)
![La peça sobre la taula](ikea-part-on-table.jpg)
![Les dues meitats de la peça](ikea-part-two-halves.jpg)

La que vaig triar era una mica més ampla que l'original, però encaixa bé, i que sobresurti una mica només es nota en obrir el calaix.

![La peça col·locada al calaix](ikea-part-in-drawer.jpg)

Si l'hagués demanat a IKEA me n'haurien donat deu de franc, però bé, m'ha fet una certa il·lusió haver-la impresa jo.

## Conclusió

Un primer dia bastant dolent, però és una mica la gràcia d'aquesta impressora. Té solució i segur que pot funcionar moltíssim millor. Ens veiem el pròxim dia, a veure si aconsegueixo arreglar-ho.
