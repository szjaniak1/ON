include("./file_helpers.jl")
include("./matrix_calc.jl")
using .file_helpers
using .matrix_calc

using SparseArrays

vec_b, siz_b = read_B_file("../data/Dane16_1_1/b.txt")
matrix, size, block_size = read_A_file("../data/Dane16_1_1/A.txt")
L = SparseArrays.spzeros(size, size)
solution = LU(matrix, L, vec_b, size, block_size)
write_X_file("./x.txt", solution)