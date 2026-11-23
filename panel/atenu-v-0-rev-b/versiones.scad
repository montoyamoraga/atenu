// versiones.scad

// version del panel de atenu, grabada en el panel. sigue la version de
// la placa con la que calza: v<mayor>.<menor> rev-<letra>
VERSION = "v0.1 rev-b";

ATENU_TEXTO = "atenu";
ATENU_HP = 5;

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
