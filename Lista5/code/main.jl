include("./file_helpers.jl")
include("./blocksys.jl")
using .file_helpers
using .blocksys

using SparseArrays
using Plots

function generate_data(start_size::Int64, end_size::Int64, block_size::Int64, step::Int64, condition::Float64)
	for size in start_size:step:end_size
		file_path = "../data/WygenerowaneDane/A" * string(size) * "_" * string(block_size) * "_" * string(condition) * ".txt"
		blockmat(size, block_size, condition, file_path)
	end
end

function plot()
	#TODO
end

function test()
	#TODO
end

# vec_b, siz_b = read_B_file("../data/Dane500000_1_1/b.txt")
# matrix, size, block_size = read_A_file("../data/Dane500000_1_1/A.txt")
# L = SparseArrays.spzeros(size, size)
# print(L.nzval)
generate_data(100, 116, 4, 4, 10.0)
# solution = LU(matrix, L, vec_b, size, block_size)
# write_X_file("./x.txt", solution)









# wypisywanie do pliku na z prawa strona
# funkcja generujaca dane
# funkcja generujaca wyniki
# funkcja robiaca wykresy