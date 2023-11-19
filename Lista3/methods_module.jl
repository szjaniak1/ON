#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 3, zadanie 1, 2, 3
=#

module methods

export bisection_method, newton_method, secant_method
export bisection_error_codes, newton_error_codes, secant_error_codes
export fl

fl = Float64
NEAR_ZERO = 2^(-2.0^32)

const bisection_error_codes = ["no error", "function doesnt change sign in the [a, b] interval"]
const newton_error_codes = ["convergent method", "the required accuracy was not achieved in the maxit iteration", "derivative close to zero"]
const secant_error_codes = ["convergent method", "the required accuracy was not achieved in the maxit iteration"]

function newton_method(f::Function, pf::Function, x0::Float64, delta::Float64, epsilon::Float64, maxit::UInt64)
	err::UInt8 = 0
	it::UInt64 = 0
	x1::Float64 = 0.0
	val::Float64 = f(x0)
	val_prime::Float64 = 0.0

	if abs(val) < epsilon
		return x0, val, it, err
	end

	xn::Float64 = x0
	xn1::Float64 = x0
	for it in 1:maxit
		val_prime = pf(xn)
		xn1 = xn - (val / val_prime)
		val = f(xn1)

		if abs(val_prime) <= NEAR_ZERO || isinf(abs(val_prime))
			err = 2
			return xn, f(xn), it, err
		end

		if abs(xn1 - xn) < delta || abs(val) < epsilon
			return xn1, val, it, err
		end

		xn = xn1
	end

	err = 1
	return xn1, val, it, err
end

function bisection_method(f::Function, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
	err::UInt8 = 0
	it::UInt64 = 0
	val::Float64 = 0.0
	e::Float64 = b - a
	r::Float64 = (1 / 2)  * (a + b)

	u::Float64 = f(a)
	v::Float64 = f(b)
	if sign(u) == sign(v)
		err = 1
		return r, val, it, err
	end

	while abs(e) > epsilon && abs(f(r)) > delta
		e = e / 2
		r = a + e
		val = f(r)
		it = it + 1

		if abs(e) < delta || abs(val) < epsilon
			return r, val, it, err
		end

		if sign(val) != sign(u)
			b = r
			v = val
		else
			a = r
			u = val
		end
	end

	return r, val, it, err
end

function secant_method(f::Function, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::UInt64)
	err::UInt8 = 0
	it::UInt64 = 0
	val::Float64 = f(x0)
	val_next::Float64 = f(x1)
	a::Float64 = x0
	b::Float64 = x1

	for it in 0:maxit
		if abs(val) > abs(val_next)
			a, b = b, a
			val, val_next = val_next, val
		end

		d = (b - a) / (val_next - val)
		b = a
		val_next = val

		a = a - d * val
		val = f(a)

		if abs(val) < epsilon || abs(b - a) < delta
			return a, val, it, err
		end
	end

	err = 1
	return a, val, it, err
end

end