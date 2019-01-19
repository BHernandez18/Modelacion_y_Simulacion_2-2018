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
---------------------------------------------------------
==== Definición de Clases ====

class Astro:
------------
Representación de los 'Astros' que componen el sistema a simular.
Un astro puede identificarse como 'Estrella' o 'Planeta' según sea
su configuración.

  
Parámetros:
----------
PVector posicion    : Vector que define la posición (x,y) del 'Astro'
PVector velocidad   : Vector que define la velocidad (Vx, Vy) del 'Astro'
float masa          : Representa la masa del 'Astro'
float diametro      : Representa el diametro del 'Astro' en pixeles
boolean es_estrella : Identifica si el 'Astro' es una 'Estrella' (true) o 'Planeta' (false)
color r, g, b       : Establece la combinación de colores RGB con la que se muestra el 'Astro'.

*/

class Astro {
  
  PVector posicion;
  PVector velocidad;
  float masa;
  float diametro;
  float angulo;
  float velocidad_angular;
  boolean es_estrella;
  color r, g, b;
  
  // Constructor predeterminado
  Astro () {
  }
  
  // Constructor personalizado
  Astro (PVector posicion,
         PVector velocidad,
         float masa,
         float diametro,
         boolean es_estrella) {
              
    this.posicion = posicion;
    this.velocidad = velocidad;
    this.masa = masa;
    this.diametro = diametro;
    this.es_estrella = es_estrella;
    this.angulo = PVector.angleBetween(new PVector(width/2, height/2), this.posicion);
    
    // Se actualiza la variable global 'masa_maxima'
    actualizar_masa_maxima();
  }
  
  /*
  void actualizar_masa_maxima():
  ------------------------------
  Este método permite reemplazar el valor de la variable global
  'masa_maxima' por la masa actual del 'Astro', siempre y cuando
  esta sea mayor que la de la variable global.
    
  */
  void actualizar_masa_maxima() {
    if (masa_maxima < this.masa) {
      masa_maxima = this.masa;
    }
  }
  
  /*
  void configurar_figura(boolean dinamico):
  -----------------------------------------
  Método que permite configurar el diámetro del 'Astro' y la
  combinación de colores RGB con la cual se mostrará por pantalla.
    
  Parámetros:
  -----------
  boolean dinamico: Valor lógico que permitirá saber si se configurará
                    el diámetro del 'Astro' de forma dinámica y relativo
                    a la variable 'masa_maxima'
  */
  void configurar_figura(boolean dinamico) {
    
    if (dinamico) { this.diametro = map(this.masa, 0, masa_maxima, 0, width / (astros.length * 16)); }
    if (this.es_estrella) { r = 255; g = 0; b = 0; }
    else                  { r = int(random(255)); g = int(random(255)); b = int(random(255)); }
  }
  
  
  /*
  PVector calcular_fuerza():
  --------------------------
    Función que permite calcular la fuerza total que se ejerce sobre
    el 'Astro', a partir de los demás 'Astros' presentes en el sistema.
    
  Retorno:
  --------
  PVector fuerza_total: Vector que contiene el total de fuerza ejercida
                        sobre el 'Astro' en las coordenadas (x,y).
  */
  PVector calcular_fuerza() {
    PVector fuerza_total = new PVector(0,0);
    float distancia = 0;
    float escalar = 0;
    
    for (Astro astro : astros) {
      PVector fuerza = null;
      
      // Condición para no comparar consigo mismo.
      if (astro != this) {
        fuerza = PVector.sub(this.posicion, astro.posicion);
        distancia = fuerza.mag();
        fuerza.normalize();
        escalar = (-G * this.masa * astro.masa) / pow(distancia, 2);
        fuerza_total.add(fuerza.mult(escalar));
      }
    }
    return fuerza_total;
  }
}

/*
Configuración del entorno de simulación
---------------------------------------
*/
void setup() {
  background(255);
  size(800,800);
  frameRate(60);
  smooth();
  astros = new Astro[6];
  
  // Estrella
  astros[0] = new Astro( new PVector(20, 0), new PVector(10, 10), 500, 10, true);
  astros[0].configurar_figura(true);
  astros[0].velocidad_angular = 0.5;
  
  // Planeta
  Astro estrella = astros[0];
  for (int i = 1; i < astros.length; i++) {
    astros[i] = new Astro( new PVector(estrella.posicion.x + 70 * i, 0),
                           new PVector(0, 1.58 + 0.3 * i),
                           70 + 1.5 * i,
                           0,
                           false);
    astros[i].configurar_figura(true);
  }
  
}

void draw() {
  run();
}

void run() {
  fill(255,25);
  rect(0,0,width,height);
  
  translate(width/2, height/2);
  for (Astro astro : astros) {
    PVector aceleracion, fuerza_total, centro;
    float distancia, escalar, angulo;
    if (astro.es_estrella) {
      
      angulo = radians(astro.angulo + astro.velocidad_angular);
      astro.posicion.rotate(angulo);
      astro.angulo = angulo;
      
      fill(astro.r, astro.g, astro.b);
      ellipse(astro.posicion.x, astro.posicion.y, astro.diametro, astro.diametro);    
    }
    else {
      fuerza_total = astro.calcular_fuerza();
      aceleracion = PVector.div(fuerza_total, astro.masa);
      astro.velocidad.add(aceleracion);
      astro.posicion.add(astro.velocidad);
      
      fill(astro.r, astro.g, astro.b);
      ellipse(astro.posicion.x, astro.posicion.y, astro.diametro, astro.diametro);
    }
  }
}
