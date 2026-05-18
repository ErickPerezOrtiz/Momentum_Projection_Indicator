# Momentum Projection Indicator

Indicador técnico personalizado desarrollado en MQL4 para MetaTrader 4, diseñado para análisis de swing trading en múltiples timeframes (M30, H1, H4, D1).

## Descripción general

MomentumProjection calcula el momentum acumulado de los cuerpos de velas durante un período configurable y lo proyecta hacia adelante en el tiempo, permitiendo anticipar el sesgo direccional potencial antes de que sea visible en la acción del precio.

## Cómo funciona

1. Para cada barra, el indicador suma el tamaño del cuerpo (Close - Open) de las últimas `Per` velas, normalizado por el valor de punto del instrumento.
2. Este momentum acumulado se grafica como la **línea Signal** (morada).
3. Una Media Móvil Simple de la Signal se grafica como la **línea MA** (negra), actuando como capa de suavizado y confirmación.
4. Ambas líneas se desplazan `DrawShift` barras hacia adelante en el gráfico, proyectando el momentum actual hacia el futuro.

## Parámetros

| Parámetro | Valor por defecto | Descripción |
|-----------|------------------|-------------|
| Per | 14 | Número de velas usadas para calcular el momentum |
| DrawShift | 14 | Número de barras a proyectar hacia adelante |
| MaPeriod | 34 | Período de la Media Móvil de la señal |

## Señales

- **Signal cruza por encima del cero** → momentum alcista en construcción.
- **Signal cruza por debajo del cero** → momentum bajista en construcción.
- **Signal por encima de la MA** → tendencia de momentum confirmada.
- **Signal cruza por debajo de la MA** → posible debilitamiento o reversión.

## Timeframes recomendados

Funciona en M30, H1, H4 y D1. Para swing trading los más efectivos son H4 y D1. M30 y H1 pueden usarse para confirmación de momentum intradía.

## Plataforma

- MetaTrader 4 (MT4).
- Lenguaje: MQL4.

## Autor

Desarrollado por Erick Alexander Perez Ortiz.  
Estudiante de Analítica y Ciencia de Datos — ITLA, República Dominicana.
