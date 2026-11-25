// versiones.scad

// version del panel de atenu. sigue la version de
// la placa con la que calza: v<mayor>.<menor> rev-<letra>
VERSION = "v0.1 rev-b";

ATENU_TEXTO = "atenu";
ATENU_HP = 5;

// espesor del panel, mas grueso que PANEL_PROFUNDIDAD (2.4 mm) para
// que no se doble. el rebaje de los jacks crece en la misma medida,
// asi el jack sigue viendo 1.2 mm de panel y la tuerca la misma rosca
ATENU_PANEL_PROFUNDIDAD = 3.0;
ATENU_JACK_REBAJE_HONDO = ATENU_PANEL_PROFUNDIDAD - (PANEL_PROFUNDIDAD - JACK_REBAJE_HONDO);

// versiones
//
// v0.1 rev-a: noviembre 2026. primer panel de atenu. agujeros para los
// dos potenciometros y los cuatro jacks de la placa atenu-v-0-rev-a.
// despues de probar el primer impreso, que calzo con la placa, se agrega
// un rebaje en la cara frontal alrededor de cada jack para que entren
// las tuercas
//
// v0.1 rev-b: noviembre 2026. panel para la placa atenu-v-0-rev-b. la
// placa cambia el footprint de los potenciometros (alps -> alpha
// rd901f, pines 1 y 3 invertidos) pero el eje queda en el mismo lugar,
// asi que los agujeros de jacks y potenciometros son los mismos que en
// rev-a. los agujeros de los tornillos M3 pasan a ser elipses
// horizontales de 6 x 3.4 mm, centradas en la misma posicion, para dar
// holgura al montar en el riel
//
// noviembre 2026: se quitan los grabados (nombre y version) de la
// cara trasera, porque eran tan sutiles que no se leian bien
//
// noviembre 2026: el panel pasa de 2.4 a 3.0 mm de espesor para que no
// se doble (rigidez ~2x, crece con el cubo del espesor). el rebaje de
// los jacks pasa de 1.2 a 1.8 mm de hondo, asi la zona del jack sigue
// en 1.2 mm y la tuerca alcanza la misma rosca
