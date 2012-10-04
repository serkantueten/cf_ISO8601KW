<!---
Hallo serkan :-)
--->
<cfcomponent>


	<cffunction
		name="getISOWeekNum"
		access="public"
		returntype="numeric"
		hint="Kalenderwoche nach ISO 8601."
		>

		<!---
			http://www.c-plusplus.de/forum/262106
		--->

		<cfargument
			name="date"
			type="date"
			required="true"
			hint="Datum wovon du die KW willst."
			/>

		<!---
			Determine its Day of Week, D
			dayOfWeek = 1 + ((int)dt.DayOfWeek + 1+5) % 7; // Mon=1 to Sun=7

			2 steht für Montag (Sonntag = 1).
			http://www.bennadel.com/blog/693-Simple-ColdFusion-Calendar-Month-Display-With-Monday-As-First-Day-Of-Week.htm
		--->
		<cfset var myDayOfWeek = ( ( DayOfWeek( ARGUMENTS.date ) + ( 7 - 2 ) ) MOD 7 ) + 1 />

		<!---
			Use that to move to the nearest Thursday (-3..+3 days)
			DateTime NearestThu = dt.AddDays(4 - dayOfWeek);
		--->
		<cfset var myNearestThu = dateAdd( 'd' , 4 - myDayOfWeek , ARGUMENTS.date ) />

		<!---
			Note the year of that date, Y
			year = NearestThu.Year;
		--->
		<cfset var myYear = year( myNearestThu ) />

		<!---
			Obtain January 1 of that year.
			DateTime Jan1 = new DateTime(year, 1, 1);
		--->
		<cfset var myJan1 = createDate( myYear , 1 , 1 ) />

		<!---
			Get the Ordinal Date of that Thursday, DDD of YYYY-DDD
			TimeSpan ts = NearestThu.Subtract(Jan1);
		--->
		<cfset myOrdinalDate = dayOfYear( myNearestThu ) />

		<!---
			Then W is 1 + (DDD-1) div 7
			week = 1 + ts.Days / 7; // Count of Thursdays
		--->
		<cfset myWeek = int( 1 + ( myOrdinalDate - 1 ) / 7 ) />


		<cfreturn myWeek />

	</cffunction>


</cfcomponent>
