#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 5, modul do obslugi plikow
=#

include("./matrixgen.jl")
using .matrixgen

module file_helpers

export read_A_file, read_B_file, write_X_file, write_X_file_with_error

using SparseArrays
using DelimitedFiles
using LinearAlgebra

"""
reads "A" file with given nodes of the matrix

Parameters:
@file_path - path of the "A" file to be read

no return
"""
function read_A_file(file_path::String)
	file = open(file_path, "r")

	size, block_size = parse.(Int, split(readline(file), ' '))
	rows::Vector{Int} = []
	columns::Vector{Int} = []
	values::Vector{Float64} = []

	while !eof(file)
		i, j, val = split(readline(file), ' ')
		push!(rows, parse(Int, i))
		push!(columns, parse(Int, j))
		push!(values, parse(Float64, val))
  	end

	close(file)
	matrix = sparse(rows, columns, values)
	return matrix, size, block_size
end

"""
reads "b" file with vector

Parameters:
@file_path - path of the "b" file to be read

no return
"""
function read_B_file(file_path::String)
	file = open(file_path, "r")

	result::Vector{Float64} = []
	size = parse(Int, readline(file))

	while !eof(file)
		val = parse(Float64, readline(file))
		push!(result, val)
	end

	close(file)
	return result, size
end

"""
writes vector of results to an "x" file

Parameters:
@file_path - path of the "x" file to be written
@results - vector of Float64 results

no return
"""
function write_X_file(file_path::String, results::Vector{Float64})
	writedlm(file_path, results)
end

"""
writes vector of results to an "x" file with calculated error
(real result should be a vector of ones)

Parameters:
@file_path - path of the "x" file to be written
@results - vector of Float64 results
@size - size of the vector of results

no return
"""
function write_X_file_with_error(file_path::String, results::Vector{Float64}, size::Int)
	real_values = ones(size)
	error = norm(real_values - results) / norm(results)
	pushfirst!(results, error)
	writedlm(file_path, results)
end

end