struct Bond
    cusip::String  # e.g. P_104_B_17
    coupon::Float64
    maturityDate::Date
    couponFrequency::Int8
end

function payment_schedule(bond, as_of_date)
    if bond.maturityDate < as_of_date
        return nothing
    else
        par_value=1000
        frequency=Dict(1=>Month(12),2=>Month(6),4=>Month(3),12=>Month(1))
        date=bond.maturityDate
        coupon = bond.coupon*par_value/bond.couponFrequency
        while date > as_of_date
            date-=frequency[bond.couponFrequency]
        end
        schedule= DataFrame(date=Date[],amount=Float64[],days=Day[])
        while date != bond.maturityDate
            push!(schedule,[date+=frequency[bond.couponFrequency],coupon,(date-as_of_date)])
        end
        schedule[end,:amount]=par_value+coupon
    end
    schedule
end


function payment_schedule(bond::Bond, as_of_date::Date, yield::Float64)
    if bond.maturityDate < as_of_date
        return nothing
    else
        par_value=1000
        frequency=Dict(1=>Month(12),2=>Month(6),4=>Month(3),12=>Month(1))
        date=bond.maturityDate
        coupon = bond.coupon*par_value/bond.couponFrequency
        rate = yield/bond.couponFrequency
        while date > as_of_date
            date-=frequency[bond.couponFrequency]
        end
        schedule= DataFrame(date=Date[],amount=Float64[],days=Day[],discount_factor=Float64[],value=Float64[])
        row=0
        while date != bond.maturityDate
            df=(1/(1+rate)^(row+=1))
            push!(schedule,[date+=frequency[bond.couponFrequency],coupon,(date-as_of_date),df,coupon*df])
        end
        schedule[end,:amount]=par_value+coupon
        schedule[end,:value]=schedule[end,:amount]*schedule[end,:discount_factor]
    end
    schedule
end

function cash_flow(bond::Bond, as_of_date::Date, yield::Float64)
    if bond.maturityDate < as_of_date
        return nothing
    else
        par_value=1000
        frequency=Dict(1=>Month(12),2=>Month(6),4=>Month(3),12=>Month(1))
        date=bond.maturityDate
        coupon = bond.coupon*par_value/bond.couponFrequency
        rate = yield/bond.couponFrequency
        while date > as_of_date
            date-=frequency[bond.couponFrequency]
        end
        schedule= DataFrame(date=Date[],amount=Float64[],days=Day[],discount_factor=Float64[],value=Float64[],period=Float64[])
        w=((date+frequency[bond.couponFrequency])-as_of_date)
        current_days = ((date+frequency[bond.couponFrequency])-as_of_date)
        days_in_coupon_period = (date+frequency[bond.couponFrequency]) - date
        w = current_days/days_in_coupon_period
        row=-1
        while date != bond.maturityDate
            period=w +(row+=1)
            df = (1/(1+rate)^period)
            push!(schedule,[date+=frequency[bond.couponFrequency],coupon,(date-as_of_date),df,coupon*df, period])
        end
        schedule[end,:amount]=par_value+coupon
        schedule[end,:value]=schedule[end,:amount]*schedule[end,:discount_factor]
    end
    schedule
end
