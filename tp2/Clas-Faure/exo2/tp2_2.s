.global func_s

func_s:
	flds g
	flds e
	fsubrp
	flds f
	fdivrp
	fstps a
	flds b
	flds d
	fmulp
	flds c
	fsubrp
	fstps h
	flds f
	flds g
	fsubrp
	flds h
	fdivp
	flds e
    faddp
    flds a
    fmulp
    fstps a

	ret
