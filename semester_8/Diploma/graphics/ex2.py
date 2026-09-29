import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
from itertools import permutations

def get_simplex_vertices_2d(sigma):
    """
    Возвращает вершины 2D-симплекса (треугольника) для перестановки sigma.
    sigma: кортеж (a,b) из (1,2) или (2,1)
    """
    vertices = []
    vertices.append([0, 0])  # g1
    vertices.append(np.eye(2)[sigma[0]-1])  # e_sigma1
    vertices.append([1, 1])   # e_sigma1 + e_sigma2 = (1,1)
    return np.array(vertices)

def get_simplex_vertices_3d(sigma):
    """
    Возвращает вершины 3D-симплекса (тетраэдра) для перестановки sigma.
    sigma: кортеж (a,b,c) — перестановка (1,2,3)
    """
    vertices = []
    vertices.append([0, 0, 0])  # g1
    vertices.append(np.eye(3)[sigma[0]-1])  # e_sigma1
    vertices.append(np.eye(3)[sigma[0]-1] + np.eye(3)[sigma[1]-1])  # e_sigma1 + e_sigma2
    vertices.append([1, 1, 1])   # e_sigma1 + e_sigma2 + e_sigma3
    return np.array(vertices)

def plot_2d():
    fig, axes = plt.subplots(1, 2, figsize=(10, 5))
    
    # Перестановки для 2D
    perms_2d = list(permutations([1, 2]))
    
    for idx, sigma in enumerate(perms_2d):
        ax = axes[idx]
        verts = get_simplex_vertices_2d(sigma)
        
        # Рисуем треугольник
        tri = plt.Polygon(verts, alpha=0.6, edgecolor='black', facecolor='skyblue')
        ax.add_patch(tri)
        
        # Рисуем точки вершин
        ax.scatter(verts[:,0], verts[:,1], color='red', zorder=5)
        
        # Рисуем единичный квадрат
        square = plt.Rectangle((0,0), 1, 1, fill=False, edgecolor='black', linewidth=1.5)
        ax.add_patch(square)
        
        ax.set_xlim(-0.1, 1.1)
        ax.set_ylim(-0.1, 1.1)
        ax.set_aspect('equal')
        ax.grid(True, alpha=0.3)
    
    plt.tight_layout()
    plt.show()

def plot_3d():
    fig = plt.figure(figsize=(12, 8))
    perms_3d = list(permutations([1, 2, 3]))
    
    # 3x2 сетка для шести тетраэдров
    for idx, sigma in enumerate(perms_3d):
        ax = fig.add_subplot(2, 3, idx+1, projection='3d')
        verts = get_simplex_vertices_3d(sigma)
        
        # Тетраэдр: 4 вершины -> 4 треугольные грани
        # Индексы граней для тетраэдра: [0,1,2], [0,1,3], [0,2,3], [1,2,3]
        faces = [[verts[0], verts[1], verts[2]],
                 [verts[0], verts[1], verts[3]],
                 [verts[0], verts[2], verts[3]],
                 [verts[1], verts[2], verts[3]]]
        
        collection = Poly3DCollection(faces, alpha=0.4, edgecolor='black', facecolor='lightgreen')
        ax.add_collection3d(collection)
        
        # Рисуем вершины
        ax.scatter(verts[:,0], verts[:,1], verts[:,2], color='red', s=30)
        
        # Рисуем единичный куб
        r = [0, 1]
        for x in r:
            for y in r:
                ax.plot([x, x], [y, y], [0, 1], 'gray', alpha=0.5)
                ax.plot([x, x], [0, 1], [y, y], 'gray', alpha=0.5)
                ax.plot([0, 1], [x, x], [y, y], 'gray', alpha=0.5)
        
        ax.set_xlim(0, 1)
        ax.set_ylim(0, 1)
        ax.set_zlim(0, 1)
    
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    print("2D разбиение единичного квадрата:")
    plot_2d()
    print("\n3D разбиение единичного куба:")
    plot_3d()