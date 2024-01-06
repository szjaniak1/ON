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
using Plots.PlotMeasures
using Formatting

function generate_data(start_size::Int64, end_size::Int64, block_size::Int64, step::Int64, condition::Float64)
	for size in start_size:step:end_size
		file_path = "../data/WygenerowaneDane/A" * string(size) * "_" * string(block_size) * "_" * string(condition) * ".txt"
		blockmat(size, block_size, condition, file_path)
	end
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
    p = gauss(M, b, size, block_size)
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
	println(" size; ", replace(string(mean_time), "." => ","), "; ", replace(string(format(mean_memory)), "." => ","))

	return mean_time, mean_memory, size
end

function test(iterations::Int64, test_function::Function)
	file_paths = readdir("../data/WygenerowaneDane/", join=true)
	times::Vector{Float64} = []
	memory::Vector{Int64} = []
	sizes::Vector{Int64} = []

	for path in file_paths
		time, mem, size = single_time_memory_test(path, iterations, test_function)
		push!(times, time)
		push!(memory, mem)
		push!(sizes, size)
	end

	return times, memory, sizes
end

# start_c::Int64 = 10000
# end_c::Int64 = 40000
# step::Int64 = 1000
# generate_data(start_c, end_c, 4, step, 10.0)

# iterations = 30
# times1, memory1, = test(iterations, gauss_LU_test)
# times2, memory2, = test(iterations, gauss_test)
# times3, memory3, = test(iterations, gauss_with_pivots_test)
# times4, memory4, = test(iterations, gauss_with_pivots_LU_test)
# siz = range(start_c, end_c, length = 31)
# plot!(siz, [times1, times2, times3, times4], marker=(:circle,5), label=["LU", "gauss", "gauss_with_pivots", "LU_with_pivots"], left_margin = 10mm)
# title!("times_comparison")
# savefig("../graphs/times_comparison.png")

# plot!(siz, [memory1, memory2, memory3, memory4], marker=(:circle,5), label=["LU", "gauss", "gauss_with_pivots", "LU_with_pivots"], left_margin = 10mm)
# title!("memory_comparison")
# savefig("../graphs/memory_comparison.png")

file_path = "../data/Dane16/A.txt"
M, size, block_size = read_A_file(file_path)
b = calculate_right_side(M, size, block_size)
L = SparseArrays.spzeros(size, size)
p = gauss_LU!(M, L, size, block_size)
solution = solve_LU(M, L, b, size, block_size)
println(solution)

# wypisywanie do pliku na z prawa strona
# blocksys do poprawy
# wykresy
# tester
# dokumentacja