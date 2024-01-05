include("./matrixgen.jl")
using .matrixgen

using SparseArrays

function read_A_file(file_path::String)
	file = open(file_path, "r")

	size, block_size = parse.(Int64, split(readline(file), ' '))
	rows = []
	columns = []
	values = []

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

	result = []
	size = parse(Int64, readline(file))

	while !eof(file)
		val = parse(Float64, readline(file))
		push!(result, val)
	end

	close(file)
	return result, size
end

res_b, siz_b = read_B_file("../data/Dane16_1_1/b.txt")
# res, siz, blck_siz = read_A_file("./A.txt")
# println(res.nzval)
# println(siz)
# println(blck_siz)
println(res_b)
println(siz_b)