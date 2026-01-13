#!/bin/bash

# Pour chaque algo je crée un exécutable
for alg in selection insertion stdsort stablesort quicksortdet quicksortrnd
do
    echo "Compilation de $alg..."
    # je fais le .o de l'algo(soit selection.o, insertion.o, ...)
    g++ -Wall -Ofast -c $alg.cpp -o $alg.o
    
    # je fais le .o de main.cpp
    g++ -Wall -Ofast -c main.cpp -o main.o
    
    #   je lie les 2 .o pour faire l'executable final qui s'appelle $alg (soit selection, insertion, ...)
    g++ -Wall -Ofast main.o $alg.o -o $alg
done

# je donne un message pour dire que je commence les tests
echo "Lancement des tests..."

# Pour chaque algo...
for alg in selection insertion stdsort stablesort quicksortdet quicksortrnd
do
    # Pour chaque type de tableau (1=Aléatoire, 2=Presque Trié, 3=Inverse)
    for type in 1 2 3
    do  
        echo "Test de l'algorithme $alg sur le type $type"
        
        # On fait varier la taille n (de 1000 à 10000 par pas de 1000, par exemple)
        for n in $(seq 1000 1000 10000)
        do
            # On lance le programme avec un timeout de 10 minutes (600s) 
            # comme c'etait demandé dans le pdf si ca depasse 10minute on arrete le test
            # ">>" veut dire "ajoute le résultat à la fin du fichier"
            timeout 600s ./$alg $n $type >> ${alg}_type${type}.data
            
            # On verifie si on verifie si le programme s'arrete a cause du timeout
            # comme timeout renvoie 124 si c'est on depasse 10min donc si ret est = 124 on sera quon a depasse 10mi
            # si ret egale 1 la il y a erreur somewhere
            # si ret egale 0 tout est ok
            ret=$?
            if [ $ret -eq 124 ]; then
                echo "  TIMEOUT pour n=$n (Arrêt de ce test)"
                break # On arrête de tester cet algo pour ce type, c'est trop long
            fi
        done
    done
done