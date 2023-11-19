#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 3, tester
=#

using TerminalMenus

include("./methods_module.jl")
using .methods

function func(x::Float64)
	return 3 * x^2
end

function func_prime(x::Float64)
	return 6*x
end

const options = ["newton_method", "bisection_method", "secant_method"]
menu = RadioMenu(options, pagesize = 3)
choice = request("Choose the method to test", menu)
println(choice)
println("Enter epsilon value")
num = readline()
epsilon::Float64 = parse(Float64, num)
println("Enter delta value")
num = readline()
delta::Float64 = parse(Float64, num)

if choice == 1
	println("Enter x0")
	num = readline()
	x0::Float64 = parse(Float64, num)
	println("Enter maxit")
	num = readline()
	maxit::UInt64 = parse(UInt64, num)
	r, val, it, err = newton_method(func, func_prime, x0, delta, epsilon, maxit)
	println("----newton_method----\n",
		"r = ", r, "\n",
		"f(r) = ", val, "\n",
		"it = ", it, "\n",
		newton_error_codes[err + 1])
elseif choice == 2
	println("Enter a")
	num = readline()
	a::Float64 = parse(Float64, num)
	println("Enter b")
	num = readline()
	b::Float64 = parse(Float64, num)
	r, val, it, err = bisection_method(func, a, b, delta, epsilon)
	println("----bisection_method----\n",
		"r = ", r, "\n",
		"f(r) = ", val, "\n",
		"it = ", it, "\n",
		bisection_error_codes[err + 1])
else
	println("Enter x0")
	num = readline()
	x0::Float64 = parse(Float64, num)
	println("Enter x1")
	num = readline()
	x1::Float64 = parse(Float64, num)
	println("Enter maxit")
	num = readline()
	maxit::UInt64 = parse(UInt64, num)
	r, val, it, err = secant_method(func, x0, x1, delta, epsilon, maxit)
	println("----secant_method----\n",
		"r = ", r, "\n",
		"f(r) = ", val, "\n",
		"it = ", it, "\n",
		secant_error_codes[err + 1])
end