// Variables globales
Astro[] astros;

// Constantes
float masa_maxima = 0;
float G = pow(6.674, -11);

// << Definición de Clases >>
class Astro {
  
  PVector posicion;
  PVector velocidad;
  PShape astro_shape;
  float masa;
  float diametro;
  boolean es_estrella;
  color r, g, b;
  
  Astro () {
  }
  
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
    
    actualizar_masa_maxima();
  }
  
  void actualizar_masa_maxima() {
    if (masa_maxima < this.masa) {
      masa_maxima = this.masa;
    }
  }
  
  void crear_figura(boolean dinamico) {
    
    // Definición de la figura
    if (dinamico) {
      this.diametro = map(this.masa, 0, masa_maxima, 10, 50);
    }
    this.astro_shape = createShape(ELLIPSE, this.posicion.x, this.posicion.y, this.diametro, this.diametro);
    
    // Configuración del color de relleno
    this.astro_shape.setFill( color(random(255), random(255), random(255)) );
    if (this.es_estrella) {
      this.astro_shape.setFill( color(255, 0, 0) );
    }
    
    // Creación de la figura
    shape(this.astro_shape);
  }
  
  PVector calcular_fuerza() {
    PVector fuerza = null;
    float r_modulo = 0;
    float escalar = 0;
    
    for (Astro astro : astros) {
      if (astro != this) {
        r_modulo = sqrt( pow((this.posicion.x - astro.posicion.x) , 2) + pow((this.posicion.y - astro.posicion.y) , 2));
        escalar = (-G * this.masa * astro.masa) / r_modulo;
        
        // Se obtiene la fuerza
        fuerza = new PVector(this.posicion.x - astro.posicion.x, this.posicion.y - astro.posicion.y);
        fuerza.mult(escalar);
      }
    }
    return fuerza;
  }
}

// Configuracion inicial
void setup() {
  size(800,800);    // Tamaño de la pantalla
  background(255);  // Fondo color blanco
  astros = new Astro[2];
  
  // Estrella
  astros[0] = new Astro( new PVector(width/2, height/2), new PVector(0, 0), 100, 10, true );
  astros[0].crear_figura(false);
  
  // Planeta
  astros[1] = new Astro( new PVector(width/2 + 200, height/2), new PVector(10, 10), 20, 0, false);
  astros[1].crear_figura(true);
  
  for (Astro astro : astros) {
    println(astro.calcular_fuerza());
  }
}

// Actualizacion de figura
void draw() {
  astros[0].astro_shape.setVisible(true);
  astros[1].astro_shape.setVisible(true);
}
