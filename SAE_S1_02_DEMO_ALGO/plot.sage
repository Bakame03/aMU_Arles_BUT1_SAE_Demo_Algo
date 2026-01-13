import os

# ici je donne a chaque algo sa color pour les differencier
algo_colors = {
    "selection": "red",
    "insertion": "blue",
    "stdsort": "green",
    "stablesort": "purple",
    "quicksortdet": "orange",
    "quicksortrnd": "brown"
}

# ici je donne les tyles de traits spécifiques selon le Type 
line_styles = {
    1: "-",       # Type 1 (Aléatoire) -> Trait plein
    2: "--",      # Type 2 (Presque trié) -> Tirets
    3: ":"        # Type 3 (Inversé) -> Pointillés
}

# pour lire les fichiers .data
def read_data(filename):
    points = []
    # On vérifie si le fichier existe si non on fait rien
    if os.path.exists(filename):
        with open(filename, 'r') as f:
            for line in f:
                parts = line.split()
                if len(parts) == 2:
                    # On s'assure qu'on a le temps et la taille
                    points.append((float(parts[0]), float(parts[1])))
    return points

# pour creer le graphique selon les Algo donner
def create_plot(algo_list, title_text):
    P = Graphics() # vide au depart
    
    for alg in algo_list:
        for type_num in [1, 2, 3]:
            filename = "{}_type{}.data".format(alg, type_num)
            
            data = read_data(filename)
            
            if len(data) > 0:
                legend = "{} (type {})".format(alg, type_num)
                
                P += line(data, 
                          color=algo_colors[alg], 
                          linestyle=line_styles[type_num], 
                          legend_label=legend,
                          title=title_text,
                          axes_labels=['Taille (n)', 'Temps (microsec)'])
    return P

# Les Algos Lents 
slow_algos = ["selection", "insertion"]
p_slow = create_plot(slow_algos, "Comparaison des Algorithmes Lents")
p_slow.save("graph_slow.pdf") 

# Les Algos Rapides
fast_algos = ["stdsort", "stablesort", "quicksortdet", "quicksortrnd"]
p_fast = create_plot(fast_algos, "Comparaison des Algorithmes Rapides")
p_fast.save("graph_fast.pdf")