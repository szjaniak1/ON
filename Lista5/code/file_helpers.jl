#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 5, modul do obslugi plikow
=#

include("./matrixgen.jl")
using .matrixgen

module file_helpers

export read_A_file, read_B_file, write_X_file

using SparseArrays
using DelimitedFiles

function read_A_file(file_path::String)
	file = open(file_path, "r")

	size, block_size = parse.(Int64, split(readline(file), ' '))
	rows::Vector{Int64} = []
	columns::Vector{Int64} = []
	values::Vector{Float64} = []

	while !eof(file)
		i, j, val = split(readline(file), ' ')
		push!(rows, parse(Int64, i))
		push!(columns, parse(Int64, j))
		push!(values, parse(Float64, val))
  	end

	close(file)
	matrix = sparse(rows, columns, values)
	return matrix, size, block_size
end

function read_B_file(file_path::String)
	file = open(file_path, "r")

	result::Vector{Float64} = []
	size = parse(Int64, readline(file))

	while !eof(file)
		val = parse(Float64, readline(file))
		push!(result, val)
	end

	close(file)
	return result, size
end

function write_X_file(file_path::String, results::Vector{Float64})
	writedlm(file_path, results)
end

end