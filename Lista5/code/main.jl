#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 5
=#

include("./file_helpers.jl")
include("./blocksys.jl")
using .file_helpers
using .blocksys

using SparseArrays
using Plots
using Formatting

function generate_data(start_size::Int64, end_size::Int64, block_size::Int64, step::Int64, condition::Float64)
	for size in start_size:step:end_size
		file_path = "../data/WygenerowaneDane/A" * string(size) * "_" * string(block_size) * "_" * string(condition) * ".txt"
		blockmat(size, block_size, condition, file_path)
	end
end

function plot()
	#TODO
end

function gauss_with_pivots_LU_test(M, L, b, size, block_size)
    p = gauss_with_pivots_LU!(M, L, size, block_size)
    solve_LU_with_pivots(M, L, b, size, block_size, p)
end

function gauss_with_pivots_test(M, L, b, size, block_size)
    p = gauss_with_pivots(M, b, size, block_size)
    solve_gauss_with_pivots(M, b, size, block_size, p)
end

function gauss_LU_test(M, L, b, size, block_size)
    p = gauss_LU!(M, L, size, block_size)
    solve_LU(M, L, b, size, block_size)
end

function gauss_test(M, L, b, size, block_size)
    p = gauss(M, size, block_size)
    solve_gauss(M, b, size, block_size)
end

function single_time_memory_test(file_path::String, iterations::Int, test_function::Function)
	print(file_path)
	total_time = 0
	total_memory = 0

	matrix, size, block_size = read_A_file(file_path)
	for rep in 1:iterations
		M = copy(matrix)
		b = calculate_right_side(M, size, block_size)
		L = SparseArrays.spzeros(size, size)
	    (_, time, memory) = @timed test_function(M, L, b, size, block_size)
	    total_time += time
	    total_memory += memory
	end
	mean_time = total_time / iterations
	mean_memory = total_memory / iterations
	println("size; ", replace(string(mean_time), "." => ","), "; ", replace(string(format(mean_memory)), "." => ","))

	return mean_time, mean_memory, size
end

function test(iterations::Int64, test_function::Function)
	file_paths = readdir("../data/WygenerowaneDane/", join=true)
	times = []
	memory = []
	sizes = []

	for path in file_paths
		time, mem, size = single_time_memory_test(path, iterations, test_function)
		push!(times, time)
		push!(memory, mem)
		push!(sizes, size)
	end

	return times, memory, sizes
end

generate_data(1000, 40000, 4, 1000, 10.0)

iterations = 10
times, memory, sizes = test(iterations, gauss_LU_test)
print(times)

# wypisywanie do pliku na z prawa strona
# funkcja robiaca wykresy
# dokumentacja