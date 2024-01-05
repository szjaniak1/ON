module matrix_calc

using SparseArrays

export calculate_right_side, LU
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

#co potrzba
# wypisywanie do pliku na z prawa strona
# ell gaussa
# ell gaussa z pivotem
# LU z pivotem
# funkcja spinajaca
# funkcja generujaca dane
# funkcja generujaca wyniki
# funkcja robiaca wykresy

function gauss()
	#TODO
end

function gauss_with_pivot()
	#TODO
end

function LU(U::SMatrix, L::SMatrix, b::Vector{Float64}, size::Int64, block_size::Int64)
	forward_substitution(L, b, size, block_size)
	return backward_substitution(U, b, size, block_size)
end

function LU_with_pivot()
	#TODO
end

function forward_substitution(L::SMatrix, b::Vector{Float64}, size::Int64, block_size::Int64)
    for k in 1:size-1
        for i in k+1:min(size, k + block_size + 1)
            b[i] -= L[i, k] * b[k]
        end
    end
end

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

end