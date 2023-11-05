#=
Szymon Janiak 268514
Obliczenia Naukowe
Lista 2, zadanie 4
=#

using Plots
using Polynomials
using LaTeXStrings
using LinearAlgebra

coefficents = [1.0, -210.0, 20615.0, -1256850.0, 53327946.0, -1672280820.0, 40171771630.0, -756111184500.0, 11310276995381.0, -135585182899530.0,
      1307535010540395.0, -10142299865511450.0, 63030812099294896.0, -311333643161390640.0, 1206647803780373360.0, -3599979517947607200.0,
      8037811822645051776.0, -12870931245150988800.0, 13803759753640704000.0, -8752948036761600000.0, 2432902008176640000.0]

coefficents2 = [1.0, -210.0-(2^(-23)), 20615.0, -1256850.0, 53327946.0, -1672280820.0, 40171771630.0, -756111184500.0, 11310276995381.0, -135585182899530.0,
      1307535010540395.0, -10142299865511450.0, 63030812099294896.0, -311333643161390640.0, 1206647803780373360.0, -3599979517947607200.0,
      8037811822645051776.0, -12870931245150988800.0, 13803759753640704000.0, -8752948036761600000.0, 2432902008176640000.0]

function p(x)
	return (x − 20)*(x − 19)*(x − 18)*(x − 17)*(x − 16)*(x − 15)*(x − 14)*(x − 13)*(x − 12)*(x − 11)*(x − 10)*(x − 9)*(x − 8)*(x − 7)*(x − 6)*(x − 5)*(x − 4)*(x − 3)*(x − 2)*(x − 1)
end

reverse!(coefficents)
reverse!(coefficents2)
P1 = Polynomial(coefficents)
P2 = Polynomial(coefficents2)

rs1 = roots(P1)
rs2 = roots(P2)

a1 = zeros(20)
a2 = zeros(20)
b1 = zeros(20)
b2 = zeros(20)
c1 = zeros(20)
c2 = zeros(20)

for k in 1:20
    a1[k] = norm(P1(rs1[k]))
    a2[k] = norm(P2(rs2[k]))
    b1[k] = norm(p(rs1[k]))
    b2[k] = norm(p(rs2[k]))
    c1[k] = norm(rs1[k] - k)
    c2[k] = norm(rs2[k] - k)
end

x_values = range(1, 20, length=20)
plot(x_values, [a1, a2], marker=(:circle,5), label=["a" "b"])
title!(L"$|P(z_k)|$")
savefig("graphs/4.1.png")

plot(x_values, [b1, b2], marker=(:circle,5), label=["a" "b"])
title!(L"$|p(z_k)|$")
savefig("graphs/4.2.png")  

plot(x_values, [c1, c2], marker=(:circle,5), label=["a" "b"])
title!(L"$|z_k - k)|$")
savefig("graphs/4.3.png")