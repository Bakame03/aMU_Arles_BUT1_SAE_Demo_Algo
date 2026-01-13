#include <iostream>
#include <vector>
#include <chrono>  
#include <random>   
#include <algorithm>
#include <string>
#include "sort.hpp" 

int main(int argc, char* argv[]) {
    // pour verifier que le user a bien donner la taille du tableau et le type du tableau a generer
    if (argc < 3) {
        std::cerr << "Usage: " << argv[0] << " <n> <type>" << std::endl;
        return 0;
    }

    // Conversion des arguments(donc taille et type) de string a int
    int n = std::stoi(argv[1]);
    int type = std::stoi(argv[2]);

    // pour generer un nb au hasard qu'on vas utiliser dans mt19937 comme entrée pour eviter que
    // mt1997 nous sort tjr la meme suite de nombre qd on lance le programme
    std::random_device rd;
    std::mt19937 gen(rd());
    
    // pour avoir des valuer a remplir dans le tableau 
    // et comme dans le pdf on m'as dit The vectors contain elements that of type int between 0 and 1024n,
    // where n is the size of the vector 
    std::uniform_int_distribution<int> distrib_full(0, 1024 * n);
    // pour générer la variable r demandée dans la formule que r est entre (0 à 1023)
    std::uniform_int_distribution<int> distrib_noise(0, 1023);

    std::vector<int> v(n);

    // donc la je rempli le tableau selon le type demandé par le user
    if (type == 1) {
        // Type 1 : Tout est aléatoire
        for (int i = 0; i < n; i++) {
            v[i] = distrib_full(gen);
        }
    } 
    else if (type == 2) {
        // Type 2 : Première moitié presque triée (croissant)
        // ici j'utilise cette logique qui est dans le pdf d'ailleur, de 1024 * i pour s'assurer d'avoir la moitie du tab croissant
        // car distrib_noise peut par ex a i = 0 donner 900 et a i = 1 donner 100 donc pas croissant
        // mais si on fait 1024 * i + r avec r entre 0 et 1023 on est sur que ca sera croissant
        for (int i = 0; i < n / 2; i++) {
            v[i] = 1024 * i + distrib_noise(gen);
        }
        // Le reste est aléatoire
        for (int i = n / 2; i < n; i++) {
            v[i] = distrib_full(gen);
        }
    } 
    else if (type == 3) {
        // Type 3 : Première moitié presque triée (décroissant/inversé)
        for (int i = 0; i < n / 2; i++) {
            v[i] = 1024 * (n - i) + distrib_noise(gen);
        }
        // Le reste est aléatoire
        for (int i = n / 2; i < n; i++) {
            v[i] = distrib_full(gen);
        }
    }

    // Mesure du temps avec chrono
    auto start = std::chrono::steady_clock::now();
    
    mySort(v);
    
    auto end = std::chrono::steady_clock::now();

    // Calcul de la durée en microsecondes
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start).count();

    // pour guide sagemath
    // n ce sera l'axe horizontal X du graphique
    // duration ce sera l'axe vertical Y du graphique
    // par ex Pour 1000 éléments, j'ai mis 450 microsecondes
    std::cout << n << " " << duration << std::endl;

    return 0;
}