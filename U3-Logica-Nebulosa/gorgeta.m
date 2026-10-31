clear;
clc;
close all;

comidas = 0:1:10;
servicos = 0:1:10;
universo = linspace(5, 15, 501);

ruim = @(x) max(0, min(1, (5 - x) / 5));
medio = @(x) max(0, 1 - abs(x - 5) / 5);
otimo = @(x) max(0, min(1, (x - 5) / 5));

pequena = @(x) max(0, min(1, (10 - x) / 5));
normal = @(x) max(0, 1 - abs(x - 10) / 5);
generosa = @(x) max(0, min(1, (x - 10) / 5));

convencional = zeros(11, 11);
nebulosa = zeros(11, 11);

for i = 1:numel(comidas)
    for j = 1:numel(servicos)
        c = comidas(i);
        s = servicos(j);

        if c < 4 || s < 4
            convencional(j, i) = 5;
        elseif c >= 8 || s >= 8
            convencional(j, i) = 15;
        else
            convencional(j, i) = 10;
        endif

        regra1 = max(ruim(c), ruim(s));
        regra2 = max(medio(c), medio(s));
        regra3 = max(otimo(c), otimo(s));

        conjunto1 = min(regra1, pequena(universo));
        conjunto2 = min(regra2, normal(universo));
        conjunto3 = min(regra3, generosa(universo));

        agregado = max(max(conjunto1, conjunto2), conjunto3);

        nebulosa(j, i) = sum(universo .* agregado) / sum(agregado);
    endfor
endfor

casos = [
    2 2;
    5 5;
    8 9;
    3 9
];

fprintf("COMPARACAO DE GORJETAS\n");
fprintf("Comida | Servico | Convencional | Nebulosa\n");

for k = 1:rows(casos)
    c = casos(k, 1);
    s = casos(k, 2);

    fprintf(
        "%6d | %7d | %11.2f%% | %7.2f%%\n",
        c,
        s,
        convencional(s + 1, c + 1),
        nebulosa(s + 1, c + 1)
    );
endfor

[C, S] = meshgrid(comidas, servicos);

figure(1);
surf(C, S, convencional);
xlabel("Qualidade da comida");
ylabel("Qualidade do servico");
zlabel("Gorjeta (%)");
title("Modelo convencional");
print("modelo_convencional.png", "-dpng");

figure(2);
surf(C, S, nebulosa);
xlabel("Qualidade da comida");
ylabel("Qualidade do servico");
zlabel("Gorjeta (%)");
title("Modelo com logica nebulosa");
print("modelo_nebuloso.png", "-dpng");
