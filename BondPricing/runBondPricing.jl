using BondPricing, Dates

bond = Bond("TESTBOND2", 0.04, Date(2028, 8, 15), 2)
as_of_date = Date(2018, 8, 15)
@show payment_schedule(bond, as_of_date)


bond = Bond("9128284V9", 0.02875, Date(2028, 8, 15), 2)
as_of_date = Date(2018, 8, 15)
@show payment_schedule(bond, as_of_date, 0.02875)
@show price(bond, as_of_date, 0.02875)

bond = Bond("9128284V9", 0.02875, Date(2028, 8, 15), 2)

as_of_date = Date(2018, 11, 22)

@show cash_flow(bond, as_of_date, 0.03067)

bond = Bond("9128284V9", 0.02875, Date(2028, 8, 15), 2)
as_of_date = Date(2018, 11, 22)
@show clean_price(bond, as_of_date, 0.03067)
