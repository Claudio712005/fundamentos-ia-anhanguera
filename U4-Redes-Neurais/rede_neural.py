import numpy as np

np.set_printoptions(precision=4, suppress=True)

X = np.array([
    [0, 0, 1],
    [0, 1, 1],
    [1, 0, 1],
    [1, 1, 1]
], dtype=float)

y = np.array([
    [0],
    [0],
    [0],
    [1]
], dtype=float)

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

def derivada_sigmoid(x):
    return x * (1 - x)

rng = np.random.default_rng(42)
pesos = rng.uniform(-1, 1, size=(3, 1))

taxa_aprendizado = 0.5
epocas = 10000

for epoca in range(epocas):
    saida = sigmoid(X @ pesos)
    erro = y - saida
    delta = erro * derivada_sigmoid(saida)
    pesos += taxa_aprendizado * (X.T @ delta)

    if (epoca + 1) in [1, 1000, 5000, 10000]:
        mse = np.mean(erro ** 2)
        print(f"Epoca {epoca + 1}: MSE = {mse:.6f}")

previsoes = sigmoid(X @ pesos)
classes = (previsoes >= 0.5).astype(int)
acuracia = np.mean(classes == y) * 100

print("\nPesos finais:")
print(pesos)

print("\nSaidas previstas:")
print(previsoes)

print("\nClasses previstas:")
print(classes)

print(f"\nAcuracia: {acuracia:.2f}%")
