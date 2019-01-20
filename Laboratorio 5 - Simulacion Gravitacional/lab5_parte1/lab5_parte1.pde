/*
------------------------------------------------------------
>> Laboratorio 5 - Modelación y Simulación
>> Simulación Gravitacional

Integrantes:  Pablo Cáceres Luzanto
              Benjamín Hernández Cortés
              
Fecha: 21 de Enero de 2019
Profesor: Fernando Rannou Fuentes
Ayudante: Francisco Muñoz Bravo
------------------------------------------------------------
El siguiente programa hecho en Processing simula un sistema
monoplanetario, cuya 'Estrella' central permanece estática
en todo instante y en donde existe un único 'Planeta' que
orbita alrededor de ella.
------------------------------------------------------------
*/

// ==== Variables globales ==== //

// Arreglo representativo del sistema a simular, donde se
// contiene a cada uno de los 'Astros' participantes.
Astro[] astros;

// Flotante para definir la mayor masa entre todo los astros
// participantes del sistema y regular el tamaño de los 'Astros'
float masa_maxima;
   
// ==== Constantes globales ==== //
// Por simplicidad se considerará la constante gravitacional como 1
float G = 1;

/*
Configuración del entorno de simulación
---------------------------------------
*/
void setup() {
  background(255);  // Fondo color blanco
  size(800,800);    // Tamaño de la pantalla
  frameRate(60);    // Tasa de frames por segundo
  smooth(4);        // Grado de anti-aliasing
  
  // Se instancia el arreglo que contendrá a cada 'Astro'
  astros = new Astro[2];
  
  // Se instancia la 'Estrella' (ej. Sol)
  astros[0] = new Astro( new PVector(0, 0),  // Posición inicial (respecto al centro)
                         new PVector(0, 0),  // Velocidad inicial (Vx, Vy)
                         500,                // Masa de la 'Estrella'
                         10,                 // Diametro de la 'Estrella' (en pixeles)
                         true );             // Identificador para reconocer si es 'Estrella' o no
  
  astros[0].configurar_figura(false);  // Configuración posterior para la 'Estrella'
  
  // Se instancia el 'Planeta' orbitando alrededor de la 'Estrella'
  astros[1] = new Astro( new PVector(200, 0),  // Posición inicial (respecto al centro)
                         new PVector(0, 1.5),  // Velocidad inicial (Vx, Vy)
                         100,                  // Masa del 'Planeta'
                         0,                    // Diametro del 'Planeta' (en pixeles)
                         false );              // Identificador para reconocer si es 'Estrella' o no
  
  astros[1].configurar_figura(true);  // Configuración posterior para el 'Planeta'
}

void draw() {
  fill(255, 20);                 // Se prepara un relleno color blanco con un grado de opacidad
  rect(0, 0, width, height);     // Se dibuja un rectangulo de acuerdo a la dimensiones de la ventana
  translate(width/2, height/2);  // Se desplazan las próximas figuras hacia al centro
  
  run();
}

void run() {
  PVector aceleracion, fuerza_total;
  for (Astro astro : astros) {
    
    // Instrucciones para 'Estrella'
    if (astro.es_estrella) {
      fill(astro.r, astro.g, astro.b);
      ellipse(astro.posicion.x, astro.posicion.y, astro.diametro, astro.diametro);    
    }
    
    // Instrucciones para 'Planeta'
    else {
      fuerza_total = astro.calcular_fuerza();               // Fuerza total sobre el 'Planeta'
      aceleracion = PVector.div(fuerza_total, astro.masa);  // Cálculo de su aceleración
      astro.velocidad.add(aceleracion);                     // Se actualiza su velocidad
      astro.posicion.add(astro.velocidad);                  // Se actualiza su posicion
      
      fill(astro.r, astro.g, astro.b);
      ellipse(astro.posicion.x, astro.posicion.y, astro.diametro, astro.diametro);
    }
  }
}
