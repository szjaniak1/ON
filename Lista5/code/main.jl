include("./file_helpers.jl")
include("./blocksys.jl")
using .file_helpers
using .blocksys

using SparseArrays

vec_b, siz_b = read_B_file("../data/Dane500000_1_1/b.txt")
matrix, size, block_size = read_A_file("../data/Dane500000_1_1/A.txt")
L = SparseArrays.spzeros(size, size)
print(L.nzval)
# solution = LU(matrix, L, vec_b, size, block_size)
# write_X_file("./x.txt", solution)











#co potrzba
# wypisywanie do pliku na z prawa strona
# funkcja spinajaca
# funkcja generujaca dane
# funkcja generujaca wyniki
# funkcja robiaca wykresy