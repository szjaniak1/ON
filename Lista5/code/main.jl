include("./file_helpers.jl")
using .file_helpers

res_b, siz_b = read_B_file("../data/Dane16_1_1/b.txt")
# res, siz, blck_siz = read_A_file("./A.txt")
# println(res.nzval)
# println(siz)
# println(blck_siz)
println(res_b)
println(siz_b)

write_X_file("./x.txt", res_b)