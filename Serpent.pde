// Taille de la grille
int tailleGrille = 400;

// Taille du serpent et de la proie
int tailleSerpent = tailleGrille / 20;
int tailleProie = tailleGrille / 20;

// Positions initiales du serpent et de la proie
int[] xSerpent = new int[tailleGrille * tailleGrille];
int[] ySerpent = new int[tailleGrille * tailleGrille];
int xProie, yProie;

// Direction initiale du serpent
int direction = 0; // 0 : droite, 1 : gauche, 2 : haut, 3 : bas

// Longueur initiale du serpent
int longueurSerpent = 1;

// Variable pour stocker la perte
boolean perdu = false;

void setup() {
  size(800, 600); // Fenêtre plus grande
  frameRate(10);
  noStroke();
  
  // Initialisation des positions du serpent et de la proie
  xSerpent[0] = width / 2;
  ySerpent[0] = height / 2;
  xProie = (int)random(0, width - tailleProie);
  yProie = (int)random(0, height - tailleProie);
}

void draw() {
  background(0);
  
  // Affichage de la proie
  fill(255, 0, 0);
  rect(xProie, yProie, tailleProie, tailleProie);
  
  // Déplacement du serpent
  for (int i = longueurSerpent - 1; i > 0; i--) {
    xSerpent[i] = xSerpent[i - 1];
    ySerpent[i] = ySerpent[i - 1];
  }
  
  // Mise à jour de la tête du serpent en fonction de la direction
  if (direction == 0) {
    xSerpent[0] += tailleSerpent;
  } else if (direction == 1) {
    xSerpent[0] -= tailleSerpent;
  } else if (direction == 2) {
    ySerpent[0] -= tailleSerpent;
  } else if (direction == 3) {
    ySerpent[0] += tailleSerpent;
  }
  
 // Vérification de la collision avec la proie
if (dist(xSerpent[0], ySerpent[0], xProie, yProie) < tailleSerpent/2 + tailleProie/2) {
  longueurSerpent++;
  xProie = (int)random(0, width - tailleProie);
  yProie = (int)random(0, height - tailleProie);
}

  
  // Vérification de la collision avec les bords
  if (xSerpent[0] < 0 || xSerpent[0] > width - tailleSerpent || ySerpent[0] < 0 || ySerpent[0] > height - tailleSerpent) {
    perdu = true;
  }
  
  // Vérification de la collision avec la queue
  for (int i = 1; i < longueurSerpent; i++) {
    if (xSerpent[0] == xSerpent[i] && ySerpent[0] == ySerpent[i]) {
      perdu = true;
    }
  }
  
  // Affichage du serpent
  fill(0, 255, 0);
  for (int i = 0; i < longueurSerpent; i++) {
    rect(xSerpent[i], ySerpent[i], tailleSerpent, tailleSerpent);
  }
  
  // Affichage du message de perte
if (perdu) {
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Perdu ! Votre score est de " + (longueurSerpent - 1) + ". Appuyez sur 'R' pour recommencer", width / 2, height / 2);
  noLoop();
}

}

void keyPressed() {
  // Mise à jour de la direction en fonction des touches pressées
  if (keyCode == RIGHT && direction != 1) {
    direction = 0;
  } else if (keyCode == LEFT && direction != 0) {
    direction = 1;
  } else if (keyCode == UP && direction != 3) {
    direction = 2;
  } else if (keyCode == DOWN && direction != 2) {
    direction = 3;
  }
  
  // Recommencer la partie
  if (key == 'R' || key == 'r') {
    // Réinitialisation des variables
    direction = 0;
    longueurSerpent = 1;
    xSerpent[0] = width / 2;
    ySerpent[0] = height / 2;
    xProie = (int)random(0, width - tailleProie);
    yProie = (int)random(0, height - tailleProie);
    perdu = false;
    loop(); // Relancer la boucle principale
  }
}
