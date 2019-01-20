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
// participantes del sistema y regular el tamaño de los 'Astros'.
float masa_maxima;
   
// ==== Constantes globales ==== //
float G = 1;  // Constante gravitacional

/*
Configuración del entorno de simulación
---------------------------------------
*/
void setup() {
  //noLoop();
  background(255);  // Fondo color blanco
  size(800,800);    // Tamaño de la pantalla
  frameRate(60);    // Tasa de frames por segundo
  smooth(4);        // Grado de anti-aliasing
  
  // Se instancia el arreglo que contendrá a cada 'Astro'
  astros = new Astro[6];
  
  // Se instancia la 'Estrella' (ej. Sol)
  astros[0] = new Astro( new PVector(20, 0), // Posición inicial (respecto al centro)
                         new PVector(0, 0),  // Velocidad inicial (Vx, Vy)
                         1000,               // Masa de la 'Estrella'
                         10,                 // Diametro de la 'Estrella' (en pixeles)
                         true );             // Identificador para reconocer si es 'Estrella' o no
  
  astros[0].configurar_figura(true);  // Configuración posterior para la 'Estrella'.
  astros[0].velocidad_angular = 0.5;  // Se establece una velocidad angular para una rotación circular de la 'Estrella'
  
  // Se instancian los 'Planetas' orbitando alrededor de la 'Estrella'
  Astro estrella = astros[0];
  for (int i = 1; i < astros.length; i++) {
    astros[i] = new Astro( new PVector(estrella.posicion.x + 50 * i, 0),  // Posición inicial (respecto al centro)
                           new PVector(0, 1.58 * i),                      // Velocidad inicial (Vx, Vy)
                           random(estrella.masa - 200),                   // Masa del 'Planeta'
                           0,                                             // Diametro del 'Planeta' (en pixeles)
                           false );                                       // Identificador para reconocer si es 'Estrella' o no
                           
    astros[i].configurar_figura(true);  // Configuración posterior para los 'Planetas'.
  }
  
}

void draw() {
  fill(255, 20);                 // Se prepara un relleno color blanco con un grado de opacidad
  rect(0, 0, width, height);     // Se dibuja un rectangulo de acuerdo a la dimensiones de la ventana. 
  translate(width/2, height/2);  // Se desplazan las próximas figuras hacia al centro.
  run();
}

void run() {
  PVector aceleracion, fuerza_total;
  float angulo;
  
  for (Astro astro : astros) {
    
    // Instrucciones para 'Estrella'
    if (astro.es_estrella) {
      angulo = radians(astro.angulo + astro.velocidad_angular);  // Se obtiene el nuevo ángulo para la 'Estrella'
      astro.posicion.rotate(angulo);                             // Se actualiza posición de acuerdo al nuevo ángulo
      astro.angulo = angulo;                                     // Se configura el nuevo ángulo
      
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
