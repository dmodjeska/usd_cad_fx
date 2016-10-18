## Abstract

Anecdotally,	fluctuations	in	the	exchange	rate	between	Canadian	and	US	dollars	are	influenced	by	commodity	prices	
and	economic	factors.	This	report	presents a	model	combining those	influences. A multiple	regression	model	using	
oil	futures	open	price,	gold	price,	and	Canadian	GDP	is	found	useful	in	explaining the	variability	in USD/CAD	FX rate.

## Introduction

Foreign exchange	(FX)	allows	goods	and	services	to	move around	the	world.	The	FX	market	is	global	and	decentralized. It	is	the	world’s	largest	market,	with	the	main	participants	being	large	banks.

The	FX	market’s three	main	participants’	are traders,	corporate	CFO’s,	and	governments.	For	traders,	rates	support
hedging	risk, pursuing profits, pricing	FX derivatives, and	algorithmic	trading.	For	CFO’s,	rates	support	assessing	risk	
and	cross-border	ventures.	For	governments,	rates	support	budgeting	and	setting	monetary	policy.

Given	the criticality of	FX	rates to the	global	economy,	and	the	sizeable profit-making	opportunities,	both	explanation and	prediction	are	interesting	and	valuable.	Explanation offers the	promise	of	helping with	key	tasks	above. Prediction offers	more	-- the	allure of	profit-making.	This report	aims to	create	an	explanation	model	that	will	form a	foundation for	our	aspirational goal	of prediction.	(Prediction	is	a	bit	harder.)

This	report will	focus	on	the	exchange	rate	between	US	and	Canadian	dollars (USD	and	CAD).	The	US	is	a	major	trading
partner	for	much	of	the	world,	and	the	USD	is	often	seen as	the	benchmark	currency	in	global	markets.	The	Canadian
dollar	is	a	commodity	currency	with	high	volatility	and	trading	volume.	This	is	attractive	to	traders	as	there	is	
liquidity	and	profit	potential.	(Also,	the	US	is	Canada’s	largest	trading	partner.)

## Conclusion

This	study	has	validated	our three	hypotheses:	that	each	of	oil	price,	gold	price,	and	Canadian	GDP	will	explain	a	significant amount	of	the	variability	in	exchange	rate	between	the	US	and	Canadian	dollars,	after	accounting	for	other	 variables	in	the	model.	The	result	is	a	multiple	regression	model	with	three	predictors:	oil	futures	open	price (with	 linear	and	quadratic	terms),	gold	spot	price,	and	Canadian	GDP.	In	addition	to	each	of	these	predictors	being	useful	individually,	the	overall	model	explains	approximately	93%	of	the	variability	in	USD/CAD	FX	rate.	

As	expected,	this	study	validated	the	public	view	of	Canada’s	as	a	resource-based	economy,	particularly	focused	on oil.	In	our	analysis,	a	simple	linear	regression	model	with	a	single	predictor	– oil	price	– accounted	for	approximately	 67%	of	the	variability	in	USD/CAD	FX	rate.	Despite	the	importance	of	oil	as	a	predictor,	however,	other	factors	 strongly	affect	the	USD/CAD	FX	rate,	as	shown	by	our	final	model.	

Several	surprises	arose	during	this	analysis:

1. The	oil	futures	open	price	turned	out	to	be	a	more	powerful	predictor	than	the	oil	spot	price.	It	appears	that traders	embed	additional	knowledge	about	market	conditions	in	futures	pricing,	relative	to	spot	pricing.

2. The	collinearity	of	possible	predictors	was	very	high.	This	finding	gives	an	impression	of	a	financial	market	
with	substantial,	overlapping,	and	mutually	reinforcing	information.	The	anecdotal	volatility	and	complexity	
of	these	markets	seems	to	be	reflected	in	the	data	available	for	analysis.

3. Relative	to	the	large	number	of	predictors	available,	a	small	model	explained much of	the	variability	in	
USD/CAD	FX	rate.	The	final	model	contained	only	three	predictors (one	with	linear	and	quadratic	terms).
In	an	analysis	of this	size,	problems	naturally	arose.	For	the	most	part,	we	were	able	to	address	these	problems	effectively.

Opportunities	remain	for	detailed	follow-up	and	future	analysis.

1. The	source	data	contained	mixed	frequencies,	both	daily	and	quarterly.	FX rates	and	commodity	prices	are	
available	daily,	while	government	statistics	such	as	GDP	are	released	monthly	or	quarterly.	A	simple	fill	of	
GDP data	over	each	period	was	found	useful	in	our	modeling.	(Interpolation	matches the	situational	
knowledge of	traders	less	well,	so	that	approach	was	avoided here.)		In	general, we	would expect	the	FX	
market’s	reaction	to	fresh GDP	data	to	be	greatest early	in a release	cycle,	while shrinking	in	the	lag	days	after
a	release. The	interaction	of	GDP	and	lag	days	expressed	as	a beta	polynomial	weighting	function could	
be	used	to	model	the	decaying	influence	of	GDP between	releases (Armesto,	Engemann,	&	Owyang,	2010).		

2. The	number	of	potential	predictors	available	for	analyzing	foreign	exchange	rates	is	large.	Sources	include	
industry,	markets,	and	governments.		Techniques	exist	for	winnowing	down	a	potentially	large	predictor	set,	
some	of	which	were	used	in	our	modeling.	Such	techniques	include	correlation	matrices,	scatterplot	matrices,
stepwise	regression,	and	nested	F-tests. None	of	these	techniques	proved	sufficient	in	isolation,	but	the	
combination	was	able	to	direct	our	predictor	exploration	toward	productive	avenues.

If	approaching	this	analysis	again,	we	would	probably	make	a	few	modifications	to	our	approach.	First,	we	would	
consider	a	broader	range	of	commodity	indices,	both	energy	and	otherwise.	Second,	we	would	explore	techniques	
for	reconciling	data	with	different frequencies,	possibly	embedding	a	specialized	technique	inside	a	more	general	
regression	approach.	Finally,	we	would	survey	the	range	of	available	predictors	more	systematically,	in	order	to	assemble as	much	of	the	data	set	as	possible	early	in	the	analysis	process,	to	avoid	redundant	“data	wrangling”.

There	are	promising	avenues	for	future	research.	First,	opportunities	exist to	consider	new	time relationships	among	
predictors	and	foreign	exchange	rates.	Opportunities	include	validating	prediction	on	daily,	monthly,	and	quarterly	
frequencies	with	rolling	windows.	In	a	similar	vein,	seasonality	may	have	an impact	on	FX	rates.	Second,	other	national economies	have	characteristics	broadly	similar	to	Canada’s.	Two	countries	of	interest are	Australia	and	Sweden.
Each	has	an	economy	with	a	substantial	resources	component,	as	well	as	advanced	industrial	and	service	sectors.
This	results	in	reliable,	plentiful,	and	public	data	for	research.

## Data	Sources

* **FX	Rates**: US	Federal	Reserve, https://www.federalreserve.gov/releases/h10/hist/
* **CAN	FX Futures**: Quandl, https://www.quandl.com/data/CHRIS/CME_CD2
* **US	Federal	Debt**: US	Treasury, http://www.treasurydirect.gov/NP/debt/search?startMonth=01&startDay=01&startYear=2006&endMonth=01&endDay=01&endYear=2016
* **US GDP**: US	Bureau	of	Economic	Analysis, http://www.bea.gov/national/pdf/nipaguid.pdf
* **US	Interest	Rates**: Federal	Reserve	Bank	of	St.	Louis, https://research.stlouisfed.org/fred2/series/USDONTD156N
* **CAN	Federal	Debt**: Statistics Canada, http://www.statcan.gc.ca/
* **CAD	GDP**: Statistics Canada, http://www.statcan.gc.ca/
* **US	Interest	Rates**: Federal	Reserve	Bank	of	St.	Louis, https://research.stlouisfed.org
* **Oil	Spot	Price**: US	Energy	Information	Administration, https://www.eia.gov/dnav/pet/pet_pri_spt_s1_d.htm
* **Oil	Futures	Price**: US	Energy	Information	Administration, https://www.eia.gov/dnav/pet/pet_pri_fut_s1_d.htm
* **Gold	Spot	Price**: Quandl, https://www.quandl.com/collections/markets/gold
* **Gold	Futures	Price**: Quandl, www.quandl.com

## Project Files


* [USD_CAD_FX_Report.docx](USD_CAD_FX_Report.docx), [USD_CAD_FX_Report.pdf](USD_CAD_FX_Report.pdf) - project report
* [usd_cad_fx_analysis.R](usd_cad_fx_analysis.R) - R script for exploratory analysis
* [usd_cad_fx_analysis_1.spv](usd_cad_fx_analysis_1.spv), [usd_cad_fx_analysis_2.spv](usd_cad_fx_analysis_2.spv), [usd_cad_fx_stepwise_regression.spv](usd_cad_fx_stepwise_regression.spv) - output files from analysis in SPSS
* [usd_cad_fx_data.csv](usd_cad_fx_data.csv), [usd_cad_fx_data_filled.csv](usd_cad_fx_data_filled.cs) - analysis data in CSV format
* [usd_cad_fx_data.sav](usd_cad_fx_data.sav) - analysis data in SPSS format
