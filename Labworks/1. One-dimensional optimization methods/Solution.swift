import Foundation

enum Errors: Error {
    case invalidParameters
}

func f(_ x: Double) -> Double {
    return pow(x, 2) + 2 * x - 4
}

let a = -2.0
let b = 1.0
let epsilon = 0.0001
let delta = Double.random(in: 0..<(epsilon / 2)) // Константа различимости

guard a <= b && epsilon > 0 else {
    print("Неверные параметры")
    throw Errors.invalidParameters
}

// Метод равномерного поиска

var N = Int(ceil((b - a) / epsilon))

var min1_x = a
var min1_y = f(a)

for i in 1...N {
    let xi = a + Double(i) * (b - a) / Double(N)
    let yi = f(xi)
    if yi < min1_y {
        min1_y = yi
        min1_x = xi
    }
}

print("""
    Минимальное значение функции по методу равномерного поиска: \(min1_y),
    достигается в точке x = \(min1_x) за \(N) шагов\n\n
    """)

// Метод дихотомии

var a_var = a
var b_var = b

N = 0

while (b_var - a_var) >= epsilon {
    let x1 = (a_var + b_var) / 2.0 - delta
    let x2 = (a_var + b_var) / 2.0 + delta
    if f(x1) < f(x2) {
        b_var = x2
    } else {
        a_var = x1
    }
    N += 1
}

let min2_x = f(a_var) < f(b_var) ? a_var : b_var
let min2_y = f(min2_x)

print("""
    Минимальное значение функции по методу дихотомии: \(min2_y),
    достигается в точке x = \(min2_x) за \(N) шагов\n\n
    """)

// Метод Фибоначчи

a_var = a
b_var = b

var F1 = 1
var F2 = 1
var F = [F1, F2]

while F.last! <= Int(ceil((b - a) / epsilon)) {
    F.append(F1 + F2)
    F1 = F2
    F2 = F.last!
}

N = F.count - 1

var x1 = a_var +
            Double(F[N - 2]) / Double(F[N]) *
                (b_var - a_var)
var x2 = a_var +
            Double(F[N - 1]) / Double(F[N]) *
                (b_var - a_var)
var f1 = f(x1)
var f2 = f(x2)

var k = 1

while k < N - 1 {
    if f1 > f2 {
        a_var = x1
        x1 = x2
        f1 = f2
        x2 = a_var + Double(F[N - k - 1]) / Double(F[N - k]) * (b_var - a_var)
        f2 = f(x2)
    } else {
        b_var = x2
        x2 = x1
        f2 = f1
        x1 = a_var + Double(F[N - k - 2]) / Double(F[N - k]) * (b_var - a_var)
        f1 = f(x1)
    }
    k += 1
}

x2 = x1 + delta
if f(x1) > f(x2) {
    a_var = x1
} else {
    b_var = x2
}

let min3_x = (a_var + b_var) / 2
let min3_y = f(min3_x)

print("""
    Минимальное значение функции по методу Фибоначчи: \(min3_y),
    достигается в точке x = \(min3_x) за \(k) шагов\n\n
    """)
