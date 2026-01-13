import matplotlib.pyplot as plt
import os

# 1. Configuration des Couleurs et Styles
algo_colors = {
    "selection": "red",
    "insertion": "blue",
    "stdsort": "green",
    "stablesort": "purple",
    "quicksortdet": "orange",
    "quicksortrnd": "brown"
}

# Correspondance des styles de ligne pour Matplotlib
line_styles = {
    1: "-",       # Solide (Aléatoire)
    2: "--",      # Tirets (Presque trié)
    3: ":"        # Pointillés (Inversé)
}

def read_data(filename):
    x = []
    y = []
    if os.path.exists(filename):
        with open(filename, 'r') as f:
            for line in f:
                parts = line.split()
                if len(parts) == 2:
                    x.append(float(parts[0]))
                    y.append(float(parts[1]))
    return x, y

def create_plot(algo_list, title_text, output_filename):
    plt.figure(figsize=(10, 6)) # Taille de l'image
    
    has_data = False
    for alg in algo_list:
        for type_num in [1, 2, 3]:
            filename = "{}_type{}.data".format(alg, type_num)
            x, y = read_data(filename)
            
            if len(x) > 0:
                has_data = True
                label_text = "{} (type {})".format(alg, type_num)
                plt.plot(x, y, 
                         color=algo_colors[alg], 
                         linestyle=line_styles[type_num], 
                         label=label_text)

    if has_data:
        plt.title(title_text)
        plt.xlabel("Taille (n)")
        plt.ylabel("Temps (microsecondes)")
        plt.legend() # Affiche la légende
        plt.grid(True) # Ajoute une grille pour lire plus facilement
        plt.savefig(output_filename)
        print(f"Graphique sauvegardé : {output_filename}")
        plt.close()
    else:
        print(f"Aucune donnée trouvée pour {title_text}")

# --- GRAPHIQUE 1 : Les Algos Lents ---
print("Génération du graphique des algos lents...")
create_plot(["selection", "insertion"], 
            "Comparaison des Algorithmes Lents", 
            "graph_slow.pdf")

# --- GRAPHIQUE 2 : Les Algos Rapides ---
print("Génération du graphique des algos rapides...")
create_plot(["stdsort", "stablesort", "quicksortdet", "quicksortrnd"], 
            "Comparaison des Algorithmes Rapides", 
            "graph_fast.pdf")