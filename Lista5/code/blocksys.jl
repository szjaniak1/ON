module blocksys

using SparseArrays

export calculate_right_side
export gauss, gauss_LU, gauss_with_pivots, gauss_with_pivots_LU
export solve_LU, solve_LU_with_pivots, solve_gauss, solve_gauss_with_pivots

export SMatrix

SMatrix = SparseMatrixCSC{Float64, Int64}

function calculate_right_side(M::SMatrix, size::Int64, block_size::Int64)
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

function gauss(M!::SMatrix, b!::Vector{Float64}, size::Int64, block_size::Int64)
    for k in 1:size-1
        for i in k+1:min(size, k + block_size + 1)
            z = M![i, k] / M![k, k]
            M![i, k] = 0.0

            for j in k+1:min(size, k + block_size + 1)
                M![i, j] -= z * M![k, j]
            end

            b![i] -= z * b![k]
        end
    end
end

function gauss_with_pivots(M!::SMatrix, b!::Vector{Float64}, size::Int64, block_size::Int64)
    pivots = collect(1:size)

    for k in 1:size-1
        last_column = 0
        last_row = 0

        for i in k:min(size, k + block_size + 1)
            if abs(M![pivots[i], k]) > last_column
                last_column = abs(M![pivots[i], k])
                last_row = i
            end
        end

        pivots[last_row], pivots[k] = pivots[k], pivots[last_row]

        for i in k+1:min(size, k + block_size + 1)
            z = M![pivots[i], k] / M![pivots[k], k]
            M![pivots[i], k] = 0.0

            for j in k+1:min(size, k + 2 * block_size)
                M![pivots[i], j] = M![pivots[i], j] - z * M![pivots[k], j]
            end
            b![pivots[i]] = b![pivots[i]] - z * b![pivots[k]]
        end
    end

    return pivots
end

function solve_gauss(M::SMatrix, b::Vector{Float64}, size::Int64, block_size::Int64)
    result = zeros(Float64, size)

    for i in size:-1:1
        current_sum = 0
        for j in i+1:min(size, i + block_size + 2)
            current_sum += M[i, j] * result[j]
        end

        result[i] = (b[i] - current_sum) / M[i, i]
    end

    return result
end

function solve_gauss_with_pivots(M::SMatrix, b::Vector{Float64}, size::Int64, block_size::Int64, pivots::Vector{Int64})
    result = zeros(Float64, size)
    
    for k in 1:size-1
        for i in k+1:min(size, k + 2 * block_size)
            b[pivots[i]] = b[pivots[i]] - M[pivots[i], k] * b[pivots[k]]
        end
    end

    for i in size:-1:1
        current_sum = 0
        for j in i+1:min(size, i + 2 * block_size)
            current_sum += M[pivots[i], j] * result[j]
        end
        result[i] = (b[pivots[i]] - current_sum) / M[pivots[i], i]
    end

    return result
end

function gauss_LU!(U!::SMatrix, L!::SMatrix, size::Int64, block_size::Int64)
    for k in 1:size-1
        L![k, k] = 1.0
        for i in k+1:min(size, k + block_size + 1)
            z = U![i, k] / U![k, k]
            L![i, k] = z
            U![i, k] = 0.0
            for j in k+1:min(size, k + 2 * block_size)
                U![i, j] -= z *U![k, j]
            end
        end
    end
    L![size, size] = 1
end

function gauss_with_pivots_LU!(U!::SMatrix, L!::SMatrix, size::Int64, block_size::Int64)
    pivots = collect(1:size)

    for k in 1:size-1
        maximum_column_value = 0
        maximum_index = 0

        for i in k:min(size, k + block_size + 1)
            if abs(U![pivots[i], k]) > maximum_column_value
                maximum_column_value = abs(U![pivots[i], k])
                maximum_index = i
            end
        end

        pivots[maximum_index], pivots[k] = pivots[k], pivots[maximum_index]

        for i in k+1:min(size, k + block_size + 1)
            z = U![pivots[i], k] / U![pivots[k], k]

            L![pivots[i], k] = z
            U![pivots[i], k] = 0

            for j in k+1:min(size, k + 2 * block_size)
                U![pivots[i], j] = U![pivots[i], j] - z * U![pivots[k], j]
            end
        end
    end

    return pivots
end

function solve_LU(U::SMatrix, L::SMatrix, b::Vector{Float64}, size::Int64, block_size::Int64)
	forward_substitution(L, b, size, block_size)
	return backward_substitution(U, b, size, block_size)
end

function solve_LU_with_pivots()
	forward_substitution_with_pivots(L, b, size, block_size)
	return backward_substitution_with_pivots(U, b, size, block_size)
end

#Ly=b
function forward_substitution(L::SMatrix, b::Vector{Float64}, size::Int64, block_size::Int64)
    for k in 1:size-1
        for i in k+1:min(size, k + block_size + 1)
            b[i] -= L[i, k] * b[k]
        end
    end
end

#Ux=y
function backward_substitution(U::SMatrix, b::Vector{Float64}, size::Int64, block_size::Int64)
	result = zeros(Float64, size)

    for i in size:-1:1
        current_sum = 0
        for j in i+1:min(size, i + block_size)
            current_sum += U[i, j] * result[j]
        end
        result[i] = (b[i] - current_sum) / U[i, i]
    end

    return result
end

#Ly=b
function forward_substitution_with_pivots(L::SMatrix, b::Vector{Float64}, size::Int64, block_size::Int64, pivots::Vector{Int64})
    for k in 1:size-1
        for i in k+1:min(size, 2 * block_size + k + 5)
            b[pivots[i]] -= b[pivots[i]] - L[pivots[i], k] * b[pivots[k]]
        end
    end
end

#Ux=y
function backward_substitution_with_pivots(U::SMatrix, b::Vector{Float64}, size::Int64, block_size::Int64, pivots::Vector{Int64})
	result = zeros(Float64, size)

    for i in size:-1:1
        current_sum = 0
        for j in i+1:min(size, i + block_size)
            current_sum += U[pivots[i], j] * result[j]
        end
        result[i] = (b[pivots[i]] - current_sum) / U[pivots[i], i]
    end

    return result
end

end