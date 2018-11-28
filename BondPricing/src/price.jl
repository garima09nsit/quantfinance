
function price(bond::Bond, as_of_date::Date, yield::Float64)
    df = payment_schedule(bond,as_of_date,yield)
    par_value=1000
    price = sum(df[:value])*100/par_value
    round(price, digits=4)
end


function clean_price(bond::Bond, as_of_date::Date, yield::Float64)
    df = cash_flow(bond,as_of_date,yield)
    par_value=1000
    price = sum(df[:value])*100/par_value
    accrued = ((1-df[1,:period])*df[1,:amount])*100/par_value
    (full_price=price, clean_price=(price-accrued))
end
