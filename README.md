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
- Todo renombrado de rev-a a rev-b, incluida la carpeta de salida de los gerbers (`../atenu-v-0-rev-b-fab/`), para no pisar los archivos de rev-a. La fecha de la serigrafía quedó en `2026-11`.
- Modelos SPICE y campos `Sim.*` en el esquemático y en la placa.

Falta:

- [ ] Rellenar las zonas en KiCad (tecla B), guardar y revisar los potenciómetros en el visor 3D. **Antes de generar gerbers**: el relleno guardado de la zona GND es anterior al cambio de pads, así que todavía cubre la pata nueva de la entrada (la dejaría en corto con GND) y no llega a la pata nueva de GND. El DRC sin rellenar muestra esos errores; después de rellenar, el DRC queda sin conexiones pendientes y sin diferencias con el esquemático.
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

### Pendiente antes de certificar con OSHWA

atenu todavía no está postulado a la certificación de [OSHWA](https://certification.oshwa.org/). Antes de postular hay que corregir las licencias de algunos archivos de terceros en las `bibliotecas/` de cada revisión: hoy [REUSE.toml](./REUSE.toml) los marca como CERN-OHL-P-2.0 de piruetas junto con todo `hardware/**`, pero no son trabajo propio.

| Archivo | Origen | Licencia | Cómo se verificó |
| --- | --- | --- | --- |
| `PJ398SM.step` (modelo 3D del jack) | [clacktronics/AudioJacks](https://github.com/clacktronics/AudioJacks), "Copyright (c) 2021 Barwise" | MIT | archivo idéntico (mismo hash) |
| `Jack_3.5mm_QingPu_WQP-PJ398SM_Vertical.kicad_mod` (huella del jack) | [clacktronics/AudioJacks](https://github.com/clacktronics/AudioJacks), convertida al formato nuevo de KiCad | MIT | mismo nombre, descripción y etiquetas |
| `ALPHA-RD901F-40.step` (modelo 3D del potenciómetro) | [dhaillant/kicad-3dmodels](https://github.com/dhaillant/kicad-3dmodels), commit `e87a021` (2018-09-09) | GPL-3.0 | archivo idéntico (mismo hash); la licencia del repositorio es anterior a ese commit |
| Huella del potenciómetro (`POT_TH_Alps_RK09K_Single_Vertical` en rev-a, `Potenciometro_Alpha_RD901F_Vertical` en rev-b) | muy probablemente la biblioteca de huellas de KiCad, rotada; en rev-b además con los pads 1 y 3 intercambiados | CC-BY-SA-4.0 con la excepción de KiCad para diseños | descripción igual a la de la biblioteca antigua de KiCad y misma geometría; probable, no confirmado |
| `SOD-123FL_L2.8-W1.8-LS3.7-R-RD.step` / `.wrl` y `Diodo_SOD-123FL.kicad_mod` (solo en rev-b) | EasyEDA/LCSC, convertidos con `easyeda2kicad` | sin licencia clara | atenu no los usa: vienen en la copia completa de `popusintes` |

Los dos modelos 3D llegaron a través de la biblioteca BYOM de [popusintes-esquematicos-placas](https://github.com/piruetasxyz/popusintes-esquematicos-placas), que no trae archivo de licencia ni indica de dónde salieron sus archivos.

Falta:

- [ ] Decidir el modelo 3D del potenciómetro: mantener el de dhaillant (GPL-3.0) y agregar su fuente de FreeCAD, `ALPHA-RD901F-40.fcstd` del mismo commit, como pide la GPL; o reemplazarlo por el modelo 3D `Potentiometer_Alps_RK09K_Single_Vertical` de la biblioteca de KiCad, que es casi igual y tiene la licencia de la biblioteca de KiCad. Como el modelo es un archivo aparte que solo se usa para el render 3D, no debería afectar la licencia CERN-OHL-P-2.0 de la placa (lectura propia, no es asesoría legal).
- [ ] Agregar a [LICENSES](./LICENSES) los textos que falten: `MIT.txt`, `GPL-3.0-only.txt` (si se mantiene el modelo de dhaillant) y una `LicenseRef` con la excepción de la biblioteca de KiCad.
- [ ] Agregar en [REUSE.toml](./REUSE.toml) una anotación por cada archivo de terceros, después de la de `hardware/**` para que la reemplace, en rev-a y en rev-b.
- [ ] Quitar de rev-b los archivos del diodo SOD-123FL, que atenu no usa y no tienen licencia clara.
- [ ] Agregar una sección de modelos y huellas de terceros a este README y a [LICENSE.md](./LICENSE.md), con créditos a clacktronics/Barwise, dhaillant y la biblioteca de KiCad.
- [ ] Hacer los mismos arreglos en [popusintes-esquematicos-placas](https://github.com/piruetasxyz/popusintes-esquematicos-placas), que es la fuente de la biblioteca `popusintes`, y en suma, que tiene los mismos archivos.
- [ ] Correr `reuse lint` (está en [requirements.txt](./requirements.txt)) y revisar que no queden archivos sin licencia.
