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

function generate_data(start_size::Int, end_size::Int, block_size::Int, step::Int, condition::Float64)
	for size in start_size:step:end_size
		file_path = "../data/WygenerowaneDane/A" * string(size) * "_" * string(block_size) * "_" * string(condition) * ".txt"
		blockmat(size, block_size, condition, file_path)
	end
end

function LU_with_pivots_test(M, b, size, block_size)
    solve_LU_with_pivots(M, b, size, block_size)
end

function gauss_with_pivots_test(M, b, size, block_size)
    solve_gauss_with_pivots(M, b, size, block_size)
end

function LU_test(M, b, size, block_size)
    solve_LU(M, b, size, block_size)
end

function gauss_test(M, b, size, block_size)
    solve_gauss(M, b, size, block_size)
end

function plot_times(siz, times1, times2, times3, times4)
	plot(siz, [times1, times2, times3, times4], marker=(:circle,5), title="times_comparison", label=["LU" "gauss" "gauss_with_pivots" "LU_with_pivots"], left_margin = 10mm, bottom_margin=5mm, xlabel="size")
	savefig("../graphs/times_comparison.png")
end

function plot_memory(siz, memory1, memory2, memory3, memory4)
	plot(siz, [memory1, memory2, memory3, memory4], marker=(:circle,5), title="memory_comparison", label=["LU" "gauss" "gauss_with_pivots" "LU_with_pivots"], left_margin = 15mm, bottom_margin=5mm, xlabel="size")
	savefig("../graphs/memory_comparison.png")
end

function single_time_memory_test(file_path::String, iterations::Int, test_function::Function)
	print(file_path)
	total_time = 0
	total_memory = 0

	matrix, size, block_size = read_A_file(file_path)
	for rep in 1:iterations
		M = copy(matrix)
		b = calculate_right_side(M, size, block_size)
	    (_, time, memory) = @timed test_function(M, b, size, block_size)
	    total_time += time
	    total_memory += memory
	end
	mean_time = total_time / iterations
	mean_memory = total_memory / iterations
	println(" size; ", replace(string(mean_time), "." => ","), "; ", replace(string(format(mean_memory)), "." => ","))

	return mean_time, mean_memory, size
end

function test(iterations::Int, test_function::Function)
	file_paths = readdir("../data/WygenerowaneDane/", join=true)
	times::Vector{Float64} = []
	memory::Vector{Int} = []
	sizes::Vector{Int} = []

	for path in file_paths
		time, mem, size = single_time_memory_test(path, iterations, test_function)
		push!(times, time)
		push!(memory, mem)
		push!(sizes, size)
	end

	return times, memory, sizes
end

start_c::Int = 10000
end_c::Int = 40000
step::Int = 1000
# generate_data(start_c, end_c, 4, step, 1.0)

iterations = 30
times1, memory1, = test(iterations, LU_test)
times2, memory2, = test(iterations, gauss_test)
times3, memory3, = test(iterations, gauss_with_pivots_test)
times4, memory4, = test(iterations, LU_with_pivots_test)
siz = range(start_c, end_c, length = 31)

plot_times(siz, times1, times2, times3, times4)

plot_memory(siz, memory1, memory2, memory3, memory4)

# file_path = "../data/Dane16/A.txt"
# M, size, block_size = read_A_file(file_path)
# b = calculate_right_side(M, size, block_size)
# p = gauss_with_pivots(M, b, size, block_size)
# solution = solve_gauss_with_pivots(M, b, size, block_size, p)
# print(solution)
# write_X_file_with_error("./x.txt", solution, size)