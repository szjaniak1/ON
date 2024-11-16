#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 2, zadanie 3
=#

using LinearAlgebra

include("hilb.jl")
include("matcond.jl")

function right_side(a, x)
    return a * x
end

function gaussian_elimination(a, b)
    return a \ b
end

function func(a, b)
    return inv(a) * b
end

function hilbert(size)
    matrix = hilb(size)
    x = ones(size)
    b = right_side(matrix, x)

    gauss = gaussian_elimination(matrix, b)
    inverse = func(matrix, b)
    println("$size & $(rank(matrix)) & $(cond(matrix)) & $(norm(inverse - x)/norm(x)) & $(norm(gauss - x)/norm(x))\\\\ \n\\hline")
end

function random_matrix(n, c)
    matrix = matcond(n, c)
    x = ones(n)
    b = right_side(matrix, x)

    gauss = gaussian_elimination(matrix, b)
    inverse = func(matrix, b)

    println("$n & $(rank(matrix)) & $(cond(matrix)) & $(norm(inverse - x)/norm(x)) & $(norm(gauss - x)/norm(x))\\\\ \n\\hline")
end

for i in 1:2:30
    hilbert(i)
end

sizes = [5, 10, 20]
conds = [1.0, 10.0, 10^3, 10^7, 10^12, 10^16]

for size in sizes
    for cond in conds
        random_matrix(size, cond)
    end
end