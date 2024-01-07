#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 5, modul bloksys
=#

module blocksys

using SparseArrays

export calculate_right_side
export solve_LU, solve_LU_with_pivots, solve_gauss, solve_gauss_with_pivots

export SMatrix

SMatrix = SparseMatrixCSC{Float64, Int}

"""
calculates "b" right side of the equation based on the matrix
equation: Ax = b, x = [1, 1, ..., 1]

Parameters:
@M - SparseMatrix with no "zero" nodes
@size - size of the matrix
@block_size - size of submatrixes in matrix

return: calculated vector "b" of Float64
"""
function calculate_right_side(M::SMatrix, size::Int, block_size::Int)
	result = zeros(Float64, size)

	for i in 1:size
		start_c = convert(Int64, max(i - (2 + block_size), 1))
		end_c = convert(Int64, min(i + block_size, size))

		for j in start_c:end_c
			result[i] += M[i, j]
		end
	end

	return result
end


"""
solves set of linear equations using gaussian elimination method

Parameters:
@A - SparseMatrix
@b - vector of right side
@size - size of matrix A
@block_size - size of submatrixes of A

return: result of the equation
"""
function solve_gauss(A::SMatrix, b::Vector{Float64}, size::Int, block_size::Int)
    gauss(A, b, size, block_size)
    result = zeros(Float64, size)

    result[size] = b[size] / A[size, size]
    for i in size : -1 : 1
        result[i] = b[i]
        for j in i + 1 : min(size, i + block_size)
            result[i] -= A[i, j] * result[j]
        end

        result[i] /= A[i, i]
    end

    return result
end


"""
solves set of linear equations using gaussian elimination method with partial choice

Parameters:
@A - SparseMatrix
@b - vector of right side
@size - size of matrix A
@block_size - size of submatrixes of A

return: result of the equation
"""
function solve_gauss_with_pivots(A::SMatrix, b::Vector{Float64}, size::Int, block_size::Int)
    pivots = gauss_with_pivots(A, b, size, block_size)
    result = zeros(Float64, size)
    
    result[size] = b[pivots[size]] / A[pivots[size], size]
    for i in size - 1 : -1 : 1
        result[i] = b[pivots[i]]
        for j in i + 1 : min(size, i + block_size)
            result[i] -= A[pivots[i], j] * result[j]
        end
        result[i] /= A[pivots[i], i]
    end

    return result
end


"""
solves set of linear equations using LU decomposition

Parameters:
@LU - SparseMatrix
@b - vector of right side
@size - size of matrix LU
@block_size - size of submatrixes of LU

return: result of the equation
"""
function solve_LU(LU::SMatrix, b::Vector{Float64}, size::Int, block_size::Int)
    LU_decmp(LU, size, block_size) # decompose into LU matrix

    # Lz = b
    for k in 1 : size - 1
        for i in k + 1 : min(size, k + block_size - (k % block_size))
            b[i] -= LU[i, k] * b[k]
        end
    end

    # Ux = z
    result = zeros(Float64, size)
    for i in size : -1 : 1
        result[i] = b[i]
        for j in i + 1 : min(size, block_size + i)
            result[i] -= LU[i, j] * result[j]
        end
        result[i] /= LU[i, i]
    end
    return result
end


"""
solves set of linear equations using LU decomposition with partial choice

Parameters:
@LU - SparseMatrix
@b - vector of right side
@size - size of matrix LU
@block_size - size of submatrixes of LU

return: result of the equation
"""
function solve_LU_with_pivots(LU::SMatrix, b::Vector{Float64}, size::Int, block_size::Int)
    pivots = LU_with_pivots(LU, size, block_size)
    result = zeros(Float64, size)

    for i in 2 : size
        for j in max(1, pivots[i] - ((pivots[i] - 1) % block_size) - 1) : i - 1 # first column
            b[pivots[i]] -= LU[pivots[i], j] * b[pivots[j]]
        end
    end

    result[size] = b[pivots[size]] / LU[pivots[size], size]

    for i in size : -1 : 1
        result[i] = b[pivots[i]]

        for j in i + 1 : min(size, 2 * block_size + i) # last column
            result[i] -= LU[pivots[i], j] * result[j]
        end

        result[i] /= LU[pivots[i], i]
    end

    return result
end


function gauss(A::SMatrix, b::Vector{Float64}, size::Int, block_size::Int)
    # Iteration trough columns
    for k in 1 : size - 1
        for i in k + 1 : min(size, k + block_size - (k % block_size)) # Elements to eliminate in current column
            z = A[i, k] / A[k, k] # element to eliminate / current element on diagona
            A[i, k] = 0.0

            # Iteration trough columns
            for j in k + 1 : min(size, k + block_size)
                A[i, j] -= z * A[k, j]
            end

            b[i] -= z * b[k]
        end
    end
end


function gauss_with_pivots(A::SMatrix, b::Vector{Float64}, size::Int, block_size::Int)
    pivots = [1:size;]

    for k in 1 : size - 1
        bound = min(size, k + block_size - (k % block_size))
        j = reduce((x, y) -> abs(A[pivots[x], k]) >= abs(A[pivots[y], k]) ? x : y, k : bound)

        pivots[k], pivots[j] = pivots[j], pivots[k]

        for i in k + 1 : bound
            z = A[pivots[i], k] / A[pivots[k], k]
            A[pivots[i], k] = 0.0

            for j in k + 1 : min(size, 2 * block_size + k) # last column
                A[pivots[i], j] -= z * A[pivots[k], j]
            end

            b[pivots[i]] -= z * b[pivots[k]]
        end
    end

    return pivots
end


function LU_decmp(A::SMatrix, size::Int, block_size::Int)
    for k in 1 : size - 1
        for i in k + 1 : min(size, k + block_size - (k % block_size)) # bottom row
            try
                m = A[i, k] / A[k, k]
                A[i, k] = m

                for j in k+1 : min(size, block_size + k) # last column
                    A[i, j] -= m * A[k, j]
                end

            catch err
                error("Zero value on the diagonal of A at index ($k, $k)")

            end            
        end
    end
end


function LU_with_pivots(A::SMatrix, size::Int, block_size::Int)
    pivots = [1 : size;]

    for k in 1 : size - 1
        bound = min(size, k + block_size - (k % block_size))
        j = reduce((x, y) -> abs(A[pivots[x], k]) >= abs(A[pivots[y], k]) ? x : y, k : bound)

        pivots[k], pivots[j] = pivots[j], pivots[k]

        for i in k + 1 : bound
            z = A[pivots[i], k] / A[pivots[k], k]
            A[pivots[i], k] = z

            for j in k + 1 : min(size, 2 * block_size + k)
                A[pivots[i], j] -= z * A[pivots[k], j]
            end
        end
    end

    return pivots
end


end