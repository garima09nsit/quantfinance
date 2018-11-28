JMG Final Run - Bond Valuation
We now graduate to doing something really serious... I mean, really really serious things that are relevant to our business - bond valuation. By the end of this week, you will know how to price a vanilla bond and be able to challenge the QARM team's calculation if they ever get it wrong! ^_^

Part 1 - Payment Schedule
When valuating fixed income instruments, we must first identify future cash flows. Today's challenge is to build a payment schedule for a bond.

Create a new Julia package called BondPricing (or Python module) for this marathon

Define a struct (or class in Python) with

cusip
coupon (e.g. 0.03 means 3%)
maturity date
coupon frequency (e.g. 2 means semi-annual)
Write a function payment_schedule(bond, as_of_date) that returns a DataFrame with the following columns:

date: date of the cash flow
amount: coupon payment, or coupon+principal for the last payment
days: number of days between as of date and payment date
Requirements:

Your code must be able to handle coupon frequency of 1, 2, 4, and 12.
Notes:

You can assume par amount of \$1,000 (e.g. you get \\$20 for every period for a 4% semi-annual coupon bond)
Typically, a semi-annual coupon bond will pay coupon every 6 months on the same day of month. For example, a bond maturing on 15-Aug-2028 will make coupon payments on 15-Feb and 15-Aug.
Submit your solution by running the following code:

bond = Bond("TESTBOND2", 0.04, Date(2028, 8, 15), 2)
as_of_date = Date(2018, 8, 15)
@show payment_schedule(bond, as_of_date)
The reuslt should look like this:

│ Row │ date       │ amount  │ days  │
├─────┼────────────┼─────────┼───────┤
│ 1   │ 2019-02-15 │ 20.0    │ 184   │
│ 2   │ 2019-08-15 │ 20.0    │ 365   │
│ 3   │ 2020-02-15 │ 20.0    │ 549   │
...
│ 19  │ 2028-02-15 │ 20.0    │ 3471  │
│ 20  │ 2028-08-15 │ 1020.0  │ 3653  │
Just FYI:

In many cases, we are not so certain about future cash flows. For example, for a mortgage-backed security, the borrower may prepay the loan and we end up receiving more cash than expected. Likewise, a corporate bond may be called before maturity date.

In practice, if the payment date falls on a weekend or holiday then it needs to be adjusted to the following buisness date but for this exercise we can ignore that.

Part 2 - Pricing Technique
A bond is valued as how investors perceives to obtain a certain yield. Hence, the price of a bond is simply the net present value of all future cash flows discounted back to today based on an internal rate of return called yield to maturity.

For a bond that pays annual coupon: $$
PV = \frac{C}{(1 + r)^1} + \frac{C}{(1 + r)^2} + ... + \frac{C + P}{(1 + r)^n}
$$

where  $C$ = coupon,  $P$ = principal, $r$ = yield to maturity, $n$ = number of periods

To calculate $PV$ for a bond with semi-annual coupon (coupon frequency = 2), several adjustments must be made:

$C$ is divided by 2
$r$ is divided by 2
$n$ is multiplied by 2 (so we have twice the number of terms than an annual coupon bond)
The $\frac{1}{(1 + r)^t}$ term in the above formula is called discount factor.

Task

Enhance the function payment_schedule(bond::Bond, as_of_date::Date, yield::Float64) to accept yield as a new argument. Now, it must return the following columns:

date: date of the cash flow
amount: coupon payment, or coupon+principal for the last payment
days: number of days between the as of date and the payment date
(new) discount_factor: discount factor for the period
(new) value: present value of the cash flow, which is simply amount multipled by discount factor
Write a new function price(bond::Bond, as_of_date::Date, yield::Float64) that returns the price of the bond, as calculated below. You can assume par amount of \$1,000 and round the result to 8 decimal places.

$$
Price = \frac{PV}{ParAmount} * 100
$$
Test your code with the following:

bond = Bond("9128284V9", 0.02875, Date(2028, 8, 15), 2)
as_of_date = Date(2018, 8, 15)
@show payment_schedule(bond, as_of_date, 0.02875)
@show price(bond, as_of_date, 0.02875)
The result should look like:

│ Row │ date       │ amount  │ days  │ discount_factor │ value   │
├─────┼────────────┼─────────┼───────┼─────────────────┼─────────┤
│ 1   │ 2019-02-15 │ 14.375  │ 184   │ 0.985829        │ 14.1713 │
│ 2   │ 2019-08-15 │ 14.375  │ 365   │ 0.971858        │ 13.9705 │
│ 3   │ 2020-02-15 │ 14.375  │ 549   │ 0.958086        │ 13.7725 │
...
price(bond, as_of_date, 0.02875) = 100.0
Part 3 - Full Price
We had a problem in yesterday's implementation. The formula assumes that the valuation date falls on a coupon date (or the issue date) because we discount the cash flows using full periods (1, 2, ..., $n$). In practice, the valuation date is likely sometime in between coupon dates.

To make it correct, we must adjust the discount factors to reflect partial periods.

First, let's define $$
w = \frac{DaysFromValuationDateToNextCouponDate}{DaysInCouponPeriod}
$$

Then, the exponents for the $PV$ formula is adjusted as follows: $$
PV = \frac{C}{(1 + r)^{w}} + \frac{C}{(1 + r)^{1 + w}} + ... + \frac{C + P}{(1 + r)^{n - 1 + w}}
$$

The Task

Enhance your payment_schedule function to include period column and adjust discount_factor properly. Test your code with the following bond.

bond = Bond("9128284V9", 0.02875, 2028-08-15, 2)

as_of_date = Date(2018, 11, 22) 

cash_flow(bond, as_of_date, 0.03067) = 20×6 DataFrame
│ Row │ date       │ amount  │ days  │ discount_factor │ value   │ period   │
├─────┼────────────┼─────────┼───────┼─────────────────┼─────────┼──────────┤
│ 1   │ 2019-02-15 │ 14.375  │ 85    │ 0.992994        │ 14.2743 │ 0.461957 │
│ 2   │ 2019-08-15 │ 14.375  │ 266   │ 0.977997        │ 14.0587 │ 1.46196  │
│ 3   │ 2020-02-15 │ 14.375  │ 450   │ 0.963226        │ 13.8464 │ 2.46196  │
...
Part 4 - Clean Price
The clean price of a bond is simply the full price minus the accrued interest portion. So how do you calculate accrued interest?

$$
AccruedInterest = \frac{DaysAccrued}{DaysInCouponPeriod} * Coupon
$$
The Task

Refactor the price function that returns a tuple of full price and clean price.

bond = Bond("9128284V9", 0.02875, Date(2028, 8, 15), 2)
as_of_date = Date(2018, 11, 22)
price(bond, as_of_date, 0.03067) = (full_price = 99.16592299, clean_price = 98.39248549)
