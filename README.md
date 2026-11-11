# atenu

## About

atenu is an open source hardware Eurorack dual passive attenuator module by [piruetas](https://piruetas.xyz), part of popusintes. It has two independent channels, each with an input jack, a linear potentiometer and an output jack, and needs no power. The board is made in KiCad 10 with its own local footprint, 3D model and SPICE libraries, included in each revision's `bibliotecas/` folder, and the panel is made in OpenSCAD with the shared modules from [popusintes-cajas-paneles](https://github.com/piruetasxyz/popusintes-cajas-paneles), included as a git submodule in `terceros/`. Hardware is licensed under CERN-OHL-P-2.0, and the panel and documentation under CC-BY-SA-4.0 (see [LICENSE.md](./LICENSE.md)). Documentation, schematic, board render and bill of materials (in Spanish): <https://piruetas.xyz/atenu/>.

## Acerca de

Atenuador pasivo doble eurorack de [piruetas](https://piruetas.xyz), parte de popusintes, hecho en KiCad y publicado como hardware de código abierto.

Documentación, esquemático, placa y Bill of materials: <https://piruetas.xyz/atenu/>.

## Características

- 2 canales independientes, cada uno con entrada, potenciómetro y salida.
- Potenciómetros lineales B100k de 9 mm (Alpha RD901F, de [Thonk](https://www.thonk.co.uk/)), cableados como divisor de voltaje: entrada en un extremo, GND en el otro, salida en el cursor.
- Jacks mono de 3.5 mm QingPu WQP-PJ398SM (tipo Thonkiconn). Las entradas tienen el switch a GND: sin cable enchufado, la salida queda en 0 V.
- Pasivo: no lleva header de alimentación ni consume corriente. Solo atenúa (ganancia entre 0 y 1), no amplifica ni invierte.
- Placa de 25 × 90 mm, 2 capas, solo componentes THT. Panel de 5 HP.

## Manual de uso

El manual de uso está en la [documentación](https://piruetas.xyz/atenu/#manual-de-uso).

## Revisiones

- `v0.1 rev-a`: diseñada en octubre 2026 y fabricada en JLCPCB. Funciona, pero los potenciómetros quedaron al revés (ver errores abajo).
- `v0.1 rev-b`: en desarrollo. Corrige la huella de los potenciómetros y agrega simulación SPICE.

### Errores conocidos de rev-a

El esquemático está bien; el error está en la huella.

- **Potenciómetros al revés.** La huella `POT_TH_Alps_RK09K_Single_Vertical` calza mecánicamente con los potenciómetros Alpha RD901F, pero tiene los pads 1 y 3 intercambiados respecto a sus patas. Girando en sentido horario el cursor va hacia GND (silencio), y en antihorario hacia la entrada (volumen máximo).

Como los potenciómetros son lineales (B100k), la curva es la misma en ambos sentidos: solo cambia la dirección. No hay arreglo limpio para las placas ya fabricadas: funcionan al revés (antihorario = más volumen). Es el mismo error de suma rev-a.

### Simulación

rev-b se puede simular en KiCad (Inspeccionar → Simulador → Ejecutar). Los modelos de los conectores están en [bibliotecas/spice/eurorack.lib](./hardware/atenu-v-0-rev-b/bibliotecas/spice/eurorack.lib), adaptados de suma, para no agregar fuentes al esquemático: J1 y J3 se comportan como osciladores senoidales de 10 Vpp (J1 a 220 Hz, J3 a 330 Hz; se cambian con `amplitud` y `frecuencia` en Sim.Params), y J2 y J4 como la entrada de 100k de otro módulo. La posición de cada potenciómetro se cambia con `pos` en Sim.Params (0 = antihorario completo, 1 = horario completo).

Con RV1 en `pos=0.75` y RV2 en `pos=0.25`, ngspice da 3.16 V y 1.05 V de pico en las salidas, para 5 V de pico en las entradas (ganancia 0.63 y 0.21; la carga de 100k baja un poco la ganancia respecto a la posición del potenciómetro).

### Pendientes para rev-b

Ya está hecho en [hardware/atenu-v-0-rev-b](./hardware/atenu-v-0-rev-b):

- Biblioteca propia `popusintes` ([bibliotecas/popusintes.pretty](./hardware/atenu-v-0-rev-b/bibliotecas/popusintes.pretty) y [bibliotecas/popusintes.3dshapes](./hardware/atenu-v-0-rev-b/bibliotecas/popusintes.3dshapes)), copiada de [popusintes-esquematicos-placas](https://github.com/piruetasxyz/popusintes-esquematicos-placas) para que el repositorio sea autocontenido, con la huella corregida `Potenciometro_Alpha_RD901F_Vertical`: misma geometría que la de rev-a, con los pads 1 y 3 intercambiados. Visto de frente con las patas hacia abajo, pad 1 = pata izquierda (antihorario, GND), pad 3 = pata derecha (horario, entrada).
- Pistas de entrada de RV1 y RV2 movidas a la pata derecha. DRC sin conexiones pendientes y sin diferencias con el esquemático.
- Todo renombrado de rev-a a rev-b, incluida la carpeta de salida de los gerbers (`../atenu-v-0-rev-b-fab/`), para no pisar los archivos de rev-a.
- Modelos SPICE y campos `Sim.*` en el esquemático.

Falta:

- [ ] Rellenar las zonas en KiCad (tecla B) y revisar los potenciómetros en el visor 3D.
- [ ] Revisar el texto de la serigrafía en un computador con las fuentes del proyecto instaladas antes de generar los gerbers.
- [ ] Generar gerbers y archivos de taladrado de rev-b (`hardware/atenu-v-0-rev-b-fab`).
- [ ] Panel de rev-b: las posiciones de los potenciómetros y jacks no cambiaron, así que el panel de rev-a calza. Falta decidir si se copia a `panel/atenu-v-0-rev-b` con `VERSION = "v0.1 rev-b"`.
- [ ] Actualizar [kicad-retrata.yml](./kicad-retrata.yml) y [docs](./docs) para que apunten a rev-b.

## Estructura del repositorio

- [hardware/atenu-v-0-rev-a](./hardware/atenu-v-0-rev-a): proyecto de KiCad (esquemático y placa), los archivos fuente del diseño.
- [hardware/atenu-v-0-rev-a/bibliotecas](./hardware/atenu-v-0-rev-a/bibliotecas): huellas y modelos 3D usados por el proyecto. Van en el repositorio para que el proyecto de KiCad se abra sin instalar bibliotecas adicionales.
- [hardware/atenu-v-0-rev-a-fab](./hardware/atenu-v-0-rev-a-fab): gerbers y archivos de taladrado para fabricar la placa.
- [hardware/atenu-v-0-rev-b](./hardware/atenu-v-0-rev-b): proyecto de KiCad de rev-b (en desarrollo). Sus [bibliotecas](./hardware/atenu-v-0-rev-b/bibliotecas) incluyen la biblioteca propia `popusintes` con la huella corregida del potenciómetro, y los modelos SPICE en `spice/`.
- [panel/atenu-v-0-rev-a](./panel/atenu-v-0-rev-a): archivos fuente de OpenSCAD del panel de 5 HP, con los agujeros de los potenciómetros y jacks de la placa rev-a. Se abre [atenu.scad](./panel/atenu-v-0-rev-a/atenu.scad); la versión grabada en el panel está en [versiones.scad](./panel/atenu-v-0-rev-a/versiones.scad).
- [terceros/popusintes-cajas-paneles](https://github.com/piruetasxyz/popusintes-cajas-paneles): submódulo de git con las constantes eurorack y las funciones y módulos de OpenSCAD compartidos entre las cajas y paneles de popusintes. Para clonar el repositorio con el submódulo: `git clone --recursive https://github.com/piruetasxyz/atenu.git`, o `git submodule update --init` si ya estaba clonado.
- [docs](./docs): documentación, publicada en <https://piruetas.xyz/atenu/>. Las capturas del esquemático y de la placa, y la tabla de Bill of materials, las genera [kicad-retrata](https://github.com/piruetasxyz/kicad-retrata) en cada push (ver [kicad-retrata.yml](./kicad-retrata.yml)).
- [LICENSES](./LICENSES): textos completos de las licencias.

## Fabricación

Como es hardware de código abierto, los archivos fuente de KiCad, los archivos de fabricación de [hardware/atenu-v-0-rev-a-fab](./hardware/atenu-v-0-rev-a-fab) y la [Bill of materials](https://piruetas.xyz/atenu/#bill-of-materials-v01-rev-a) están publicados para que cualquiera pueda estudiar, modificar y fabricar el diseño. piruetas no da soporte para unidades fabricadas o armadas por terceros.

## Créditos

- Aarón Montoya-Moraga: investigación, esquemático, PCB, panel, fabricación y documentación.

## Licencia

atenu es (c) 2026 piruetas SpA / Aarón Montoya-Moraga.

- Hardware (`hardware/`): [CERN-OHL-P-2.0](./LICENSES/CERN-OHL-P-2.0.txt).
- Panel (`panel/`): [CC-BY-SA-4.0](./LICENSES/CC-BY-SA-4.0.txt).
- Documentación (`docs/`): [CC-BY-SA-4.0](./LICENSES/CC-BY-SA-4.0.txt).
- Biblioteca compartida (`terceros/popusintes-cajas-paneles`): submódulo con su propia licencia, MIT.
- El nombre, logo y marca de piruetas no están cubiertos por estas licencias: ver [LicenseRef-piruetas-branding](./LICENSES/LicenseRef-piruetas-branding.txt).

Ver [LICENSE.md](./LICENSE.md) para los detalles. El repositorio sigue la especificación [REUSE](https://reuse.software/).
