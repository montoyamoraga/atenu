// atenu_panel.scad
// agujeros copiados de la placa de esta misma revision
// (../../hardware/atenu-v-0-rev-a/atenu-v-0-rev-a.kicad_pcb): dos
// canales, cada uno con entrada, potenciometro y salida, de arriba
// hacia abajo. canal 1 en la columna izquierda, canal 2 en la derecha
//
// la placa (25 x 90 mm) va centrada en el panel, vista de frente. las
// posiciones son los centros de los footprints en kicad (eje de cada
// potenciometro, barril de cada jack), convertidas a porcentajes de
// layout como en los paneles de popusintes-cajas-paneles

include <../../terceros/popusintes-cajas-paneles/comun/comun.scad>
include <./versiones.scad>

// borde de la placa en coordenadas de kicad, en mm
ATENU_PCB_X0 = 30;
ATENU_PCB_Y0 = 30;
ATENU_PCB_ANCHO = 25;
ATENU_PCB_ALTO = 90;

// coordenadas de kicad (y hacia abajo) a porcentajes de layout
function atenu_px(x_pcb, ancho) = (x_pcb - ATENU_PCB_X0 + (ancho - ATENU_PCB_ANCHO) / 2) / ancho;
function atenu_py(y_pcb, alto) = (y_pcb - ATENU_PCB_Y0 + (alto - ATENU_PCB_ALTO) / 2) / alto;

// rebaje circular en la cara frontal (+z) alrededor de cada jack, para
// que la tuerca baje y alcance mas rosca. el panel queda con
// PANEL_PROFUNDIDAD - JACK_REBAJE_HONDO de espesor en esa zona
JACK_REBAJE_DIAMETRO = 10;
JACK_REBAJE_HONDO = 1.2;

module rebaje_jack(ancho, alto, px, py) {
  p = posicion(ancho, alto, px, py);
  translate([p[0], p[1], PANEL_PROFUNDIDAD - JACK_REBAJE_HONDO])
    cylinder(h = JACK_REBAJE_HONDO + 1, d = JACK_REBAJE_DIAMETRO, $fn = 50);
}

module atenu_panel() {
  ancho = MODULO_ANCHO * ATENU_HP;
  alto  = MODULO_ALTURA_3U;

  // RV1, RV2
  POTES = [[37, 62.5], [48, 79.5]];

  // J1 y J3 (entradas), J2 y J4 (salidas)
  // J2 esta 1 mm a la izquierda de su columna en la placa
  JACKS = [[37, 40.92], [48, 47.92], [36, 101.92], [48, 110.92]];

  difference() {
    panel_base(ancho, alto);

    union() {
      agujeros_tornillos(ancho, alto, ambos_lados = false);

      for (p = POTES)
        agujero_perilla(ancho, alto, atenu_px(p[0], ancho), atenu_py(p[1], alto));

      for (p = JACKS) {
        agujero_jack(ancho, alto, atenu_px(p[0], ancho), atenu_py(p[1], alto));
        rebaje_jack(ancho, alto, atenu_px(p[0], ancho), atenu_py(p[1], alto));
      }

      grabados_panel(ATENU_TEXTO, VERSION, ancho, alto);
    }
  }
}
