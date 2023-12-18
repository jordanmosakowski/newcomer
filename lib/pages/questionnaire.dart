import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:newcomer/classes/interest.dart';

class Questionnaire extends StatefulWidget {
  const Questionnaire({super.key});

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  Interest? currentLocation;
  Interest? hometown;

  List<Interest> selectedInterests = [];

  List<Interest> townOptions = [
    Interest(id: 'town:abilene-tx', name: 'Abilene, TX'),
    Interest(id: 'town:akron-oh', name: 'Akron, OH'),
    Interest(id: 'town:albany-ny', name: 'Albany, NY'),
    Interest(id: 'town:albuquerque-nm', name: 'Albuquerque, NM'),
    Interest(id: 'town:alexandria-va', name: 'Alexandria, VA'),
    Interest(id: 'town:allen-tx', name: 'Allen, TX'),
    Interest(id: 'town:allentown-pa', name: 'Allentown, PA'),
    Interest(id: 'town:amarillo-tx', name: 'Amarillo, TX'),
    Interest(id: 'town:anaheim-ca', name: 'Anaheim, CA'),
    Interest(id: 'town:anchorage-ak', name: 'Anchorage, AK'),
    Interest(id: 'town:annarbor-mi', name: 'Ann Arbor, MI'),
    Interest(id: 'town:antioch-ca', name: 'Antioch, CA'),
    Interest(id: 'town:arlington-tx', name: 'Arlington, TX'),
    Interest(id: 'town:arlington-va', name: 'Arlington, VA'),
    Interest(id: 'town:arvada-co', name: 'Arvada, CO'),
    Interest(id: 'town:athens-ga', name: 'Athens, GA'),
    Interest(id: 'town:atlanta-ga', name: 'Atlanta, GA'),
    Interest(id: 'town:augusta-ga', name: 'Augusta, GA'),
    Interest(id: 'town:aurora-il', name: 'Aurora, IL'),
    Interest(id: 'town:aurora-co', name: 'Aurora, CO'),
    Interest(id: 'town:austin-tx', name: 'Austin, TX'),
    Interest(id: 'town:bakersfield-ca', name: 'Bakersfield, CA'),
    Interest(id: 'town:baltimore-md', name: 'Baltimore, MD'),
    Interest(id: 'town:batonrouge-la', name: 'Baton Rouge, LA'),
    Interest(id: 'town:beaumont-tx', name: 'Beaumont, TX'),
    Interest(id: 'town:bellevue-wa', name: 'Bellevue, WA'),
    Interest(id: 'town:bend-or', name: 'Bend, OR'),
    Interest(id: 'town:berkeley-ca', name: 'Berkeley, CA'),
    Interest(id: 'town:billings-mt', name: 'Billings, MT'),
    Interest(id: 'town:birmingham-al', name: 'Birmingham, AL'),
    Interest(id: 'town:boisecity-id', name: 'Boise City, ID'),
    Interest(id: 'town:boston-ma', name: 'Boston, MA'),
    Interest(id: 'town:boulder-co', name: 'Boulder, CO'),
    Interest(id: 'town:brandon-fl', name: 'Brandon, FL'),
    Interest(id: 'town:bridgeport-ct', name: 'Bridgeport, CT'),
    Interest(id: 'town:brockton-ma', name: 'Brockton, MA'),
    Interest(id: 'town:brokenarrow-ok', name: 'Broken Arrow, OK'),
    Interest(id: 'town:brownsville-tx', name: 'Brownsville, TX'),
    Interest(id: 'town:buckeye-az', name: 'Buckeye, AZ'),
    Interest(id: 'town:buffalo-ny', name: 'Buffalo, NY'),
    Interest(id: 'town:burbank-ca', name: 'Burbank, CA'),
    Interest(id: 'town:cambridge-ma', name: 'Cambridge, MA'),
    Interest(id: 'town:capecoral-fl', name: 'Cape Coral, FL'),
    Interest(id: 'town:carlsbad-ca', name: 'Carlsbad, CA'),
    Interest(id: 'town:carmel-in', name: 'Carmel, IN'),
    Interest(id: 'town:carrollton-tx', name: 'Carrollton, TX'),
    Interest(id: 'town:cary-nc', name: 'Cary, NC'),
    Interest(id: 'town:cedarrapids-ia', name: 'Cedar Rapids, IA'),
    Interest(id: 'town:centennial-co', name: 'Centennial, CO'),
    Interest(id: 'town:chandler-az', name: 'Chandler, AZ'),
    Interest(id: 'town:charleston-sc', name: 'Charleston, SC'),
    Interest(id: 'town:charlotte-nc', name: 'Charlotte, NC'),
    Interest(id: 'town:chattanooga-tn', name: 'Chattanooga, TN'),
    Interest(id: 'town:chesapeake-va', name: 'Chesapeake, VA'),
    Interest(id: 'town:chicago-il', name: 'Chicago, IL'),
    Interest(id: 'town:chico-ca', name: 'Chico, CA'),
    Interest(id: 'town:chulavista-ca', name: 'Chula Vista, CA'),
    Interest(id: 'town:cincinnati-oh', name: 'Cincinnati, OH'),
    Interest(id: 'town:clarksville-tn', name: 'Clarksville, TN'),
    Interest(id: 'town:clearwater-fl', name: 'Clearwater, FL'),
    Interest(id: 'town:cleveland-oh', name: 'Cleveland, OH'),
    Interest(id: 'town:clovis-ca', name: 'Clovis, CA'),
    Interest(id: 'town:collegestation-tx', name: 'College Station, TX'),
    Interest(id: 'town:coloradosprings-co', name: 'Colorado Springs, CO'),
    Interest(id: 'town:columbia-mo', name: 'Columbia, MO'),
    Interest(id: 'town:columbia-sc', name: 'Columbia, SC'),
    Interest(id: 'town:columbia-md', name: 'Columbia, MD'),
    Interest(id: 'town:columbus-ga', name: 'Columbus, GA'),
    Interest(id: 'town:columbus-oh', name: 'Columbus, OH'),
    Interest(id: 'town:concord-ca', name: 'Concord, CA'),
    Interest(id: 'town:concord-nc', name: 'Concord, NC'),
    Interest(id: 'town:conroe-tx', name: 'Conroe, TX'),
    Interest(id: 'town:coralsprings-fl', name: 'Coral Springs, FL'),
    Interest(id: 'town:corona-ca', name: 'Corona, CA'),
    Interest(id: 'town:corpuschristi-tx', name: 'Corpus Christi, TX'),
    Interest(id: 'town:costamesa-ca', name: 'Costa Mesa, CA'),
    Interest(id: 'town:dallas-tx', name: 'Dallas, TX'),
    Interest(id: 'town:dalycity-ca', name: 'Daly City, CA'),
    Interest(id: 'town:davenport-ia', name: 'Davenport, IA'),
    Interest(id: 'town:davie-fl', name: 'Davie, FL'),
    Interest(id: 'town:dayton-oh', name: 'Dayton, OH'),
    Interest(id: 'town:dearborn-mi', name: 'Dearborn, MI'),
    Interest(id: 'town:denton-tx', name: 'Denton, TX'),
    Interest(id: 'town:denver-co', name: 'Denver, CO'),
    Interest(id: 'town:desmoines-ia', name: 'Des Moines, IA'),
    Interest(id: 'town:detroit-mi', name: 'Detroit, MI'),
    Interest(id: 'town:downey-ca', name: 'Downey, CA'),
    Interest(id: 'town:durham-nc', name: 'Durham, NC'),
    Interest(id: 'town:eastlosangeles-ca', name: 'East Los Angeles, CA'),
    Interest(id: 'town:edinburg-tx', name: 'Edinburg, TX'),
    Interest(id: 'town:edison-nj', name: 'Edison, NJ'),
    Interest(id: 'town:elcajon-ca', name: 'El Cajon, CA'),
    Interest(id: 'town:elgin-il', name: 'Elgin, IL'),
    Interest(id: 'town:elizabeth-nj', name: 'Elizabeth, NJ'),
    Interest(id: 'town:elkgrove-ca', name: 'Elk Grove, CA'),
    Interest(id: 'town:elmonte-ca', name: 'El Monte, CA'),
    Interest(id: 'town:elpaso-tx', name: 'El Paso, TX'),
    Interest(id: 'town:enterprise-nv', name: 'Enterprise, NV'),
    Interest(id: 'town:escondido-ca', name: 'Escondido, CA'),
    Interest(id: 'town:eugene-or', name: 'Eugene, OR'),
    Interest(id: 'town:evansville-in', name: 'Evansville, IN'),
    Interest(id: 'town:everett-wa', name: 'Everett, WA'),
    Interest(id: 'town:fairfield-ca', name: 'Fairfield, CA'),
    Interest(id: 'town:fargo-nd', name: 'Fargo, ND'),
    Interest(id: 'town:fayetteville-nc', name: 'Fayetteville, NC'),
    Interest(id: 'town:fishers-in', name: 'Fishers, IN'),
    Interest(id: 'town:fontana-ca', name: 'Fontana, CA'),
    Interest(id: 'town:fortcollins-co', name: 'Fort Collins, CO'),
    Interest(id: 'town:fortlauderdale-fl', name: 'Fort Lauderdale, FL'),
    Interest(id: 'town:fortwayne-in', name: 'Fort Wayne, IN'),
    Interest(id: 'town:fortworth-tx', name: 'Fort Worth, TX'),
    Interest(id: 'town:fremont-ca', name: 'Fremont, CA'),
    Interest(id: 'town:fresno-ca', name: 'Fresno, CA'),
    Interest(id: 'town:frisco-tx', name: 'Frisco, TX'),
    Interest(id: 'town:fullerton-ca', name: 'Fullerton, CA'),
    Interest(id: 'town:gainesville-fl', name: 'Gainesville, FL'),
    Interest(id: 'town:gardengrove-ca', name: 'Garden Grove, CA'),
    Interest(id: 'town:garland-tx', name: 'Garland, TX'),
    Interest(id: 'town:gilbert-az', name: 'Gilbert, AZ'),
    Interest(id: 'town:glendale-ca', name: 'Glendale, CA'),
    Interest(id: 'town:glendale-az', name: 'Glendale, AZ'),
    Interest(id: 'town:goodyear-az', name: 'Goodyear, AZ'),
    Interest(id: 'town:grandprairie-tx', name: 'Grand Prairie, TX'),
    Interest(id: 'town:grandrapids-mi', name: 'Grand Rapids, MI'),
    Interest(id: 'town:greeley-co', name: 'Greeley, CO'),
    Interest(id: 'town:greenbay-wi', name: 'Green Bay, WI'),
    Interest(id: 'town:greensboro-nc', name: 'Greensboro, NC'),
    Interest(id: 'town:gresham-or', name: 'Gresham, OR'),
    Interest(id: 'town:hampton-va', name: 'Hampton, VA'),
    Interest(id: 'town:hartford-ct', name: 'Hartford, CT'),
    Interest(id: 'town:hayward-ca', name: 'Hayward, CA'),
    Interest(id: 'town:henderson-nv', name: 'Henderson, NV'),
    Interest(id: 'town:hesperia-ca', name: 'Hesperia, CA'),
    Interest(id: 'town:hialeah-fl', name: 'Hialeah, FL'),
    Interest(id: 'town:highlandsranch-co', name: 'Highlands Ranch, CO'),
    Interest(id: 'town:highpoint-nc', name: 'High Point, NC'),
    Interest(id: 'town:hillsboro-or', name: 'Hillsboro, OR'),
    Interest(id: 'town:hollywood-fl', name: 'Hollywood, FL'),
    Interest(id: 'town:honolulu-hi', name: 'Honolulu, HI'),
    Interest(id: 'town:houston-tx', name: 'Houston, TX'),
    Interest(id: 'town:huntingtonbeach-ca', name: 'Huntington Beach, CA'),
    Interest(id: 'town:huntsville-al', name: 'Huntsville, AL'),
    Interest(id: 'town:independence-mo', name: 'Independence, MO'),
    Interest(id: 'town:indianapolis-in', name: 'Indianapolis, IN'),
    Interest(id: 'town:inglewood-ca', name: 'Inglewood, CA'),
    Interest(id: 'town:irvine-ca', name: 'Irvine, CA'),
    Interest(id: 'town:irving-tx', name: 'Irving, TX'),
    Interest(id: 'town:jackson-ms', name: 'Jackson, MS'),
    Interest(id: 'town:jacksonville-fl', name: 'Jacksonville, FL'),
    Interest(id: 'town:jerseycity-nj', name: 'Jersey City, NJ'),
    Interest(id: 'town:joliet-il', name: 'Joliet, IL'),
    Interest(id: 'town:jurupavalley-ca', name: 'Jurupa Valley, CA'),
    Interest(id: 'town:kansascity-ks', name: 'Kansas City, KS'),
    Interest(id: 'town:kansascity-mo', name: 'Kansas City, MO'),
    Interest(id: 'town:kent-wa', name: 'Kent, WA'),
    Interest(id: 'town:killeen-tx', name: 'Killeen, TX'),
    Interest(id: 'town:knoxville-tn', name: 'Knoxville, TN'),
    Interest(id: 'town:lafayette-la', name: 'Lafayette, LA'),
    Interest(id: 'town:lakeland-fl', name: 'Lakeland, FL'),
    Interest(id: 'town:lakewood-co', name: 'Lakewood, CO'),
    Interest(id: 'town:lancaster-ca', name: 'Lancaster, CA'),
    Interest(id: 'town:lansing-mi', name: 'Lansing, MI'),
    Interest(id: 'town:laredo-tx', name: 'Laredo, TX'),
    Interest(id: 'town:lascruces-nm', name: 'Las Cruces, NM'),
    Interest(id: 'town:lasvegas-nv', name: 'Las Vegas, NV'),
    Interest(id: 'town:leaguecity-tx', name: 'League City, TX'),
    Interest(id: 'town:leessummit-mo', name: 'Lee\'s Summit, MO'),
    Interest(id: 'town:lehighacres-fl', name: 'Lehigh Acres, FL'),
    Interest(id: 'town:lewisville-tx', name: 'Lewisville, TX'),
    Interest(id: 'town:lexington-ky', name: 'Lexington, KY'),
    Interest(id: 'town:lincoln-ne', name: 'Lincoln, NE'),
    Interest(id: 'town:littlerock-ar', name: 'Little Rock, AR'),
    Interest(id: 'town:longbeach-ca', name: 'Long Beach, CA'),
    Interest(id: 'town:losangeles-ca', name: 'Los Angeles, CA'),
    Interest(id: 'town:louisville-ky', name: 'Louisville, KY'),
    Interest(id: 'town:lowell-ma', name: 'Lowell, MA'),
    Interest(id: 'town:lubbock-tx', name: 'Lubbock, TX'),
    Interest(id: 'town:lynn-ma', name: 'Lynn, MA'),
    Interest(id: 'town:macon-ga', name: 'Macon, GA'),
    Interest(id: 'town:madison-wi', name: 'Madison, WI'),
    Interest(id: 'town:manchester-nh', name: 'Manchester, NH'),
    Interest(id: 'town:mcallen-tx', name: 'McAllen, TX'),
    Interest(id: 'town:mckinney-tx', name: 'McKinney, TX'),
    Interest(id: 'town:memphis-tn', name: 'Memphis, TN'),
    Interest(id: 'town:menifee-ca', name: 'Menifee, CA'),
    Interest(id: 'town:meridian-id', name: 'Meridian, ID'),
    Interest(id: 'town:mesa-az', name: 'Mesa, AZ'),
    Interest(id: 'town:mesquite-tx', name: 'Mesquite, TX'),
    Interest(id: 'town:metairie-la', name: 'Metairie, LA'),
    Interest(id: 'town:miami-fl', name: 'Miami, FL'),
    Interest(id: 'town:miamigardens-fl', name: 'Miami Gardens, FL'),
    Interest(id: 'town:midland-tx', name: 'Midland, TX'),
    Interest(id: 'town:milwaukee-wi', name: 'Milwaukee, WI'),
    Interest(id: 'town:minneapolis-mn', name: 'Minneapolis, MN'),
    Interest(id: 'town:miramar-fl', name: 'Miramar, FL'),
    Interest(id: 'town:mobile-al', name: 'Mobile, AL'),
    Interest(id: 'town:modesto-ca', name: 'Modesto, CA'),
    Interest(id: 'town:montgomery-al', name: 'Montgomery, AL'),
    Interest(id: 'town:morenovalley-ca', name: 'Moreno Valley, CA'),
    Interest(id: 'town:murfreesboro-tn', name: 'Murfreesboro, TN'),
    Interest(id: 'town:murrieta-ca', name: 'Murrieta, CA'),
    Interest(id: 'town:nampa-id', name: 'Nampa, ID'),
    Interest(id: 'town:naperville-il', name: 'Naperville, IL'),
    Interest(id: 'town:nashville-tn', name: 'Nashville, TN'),
    Interest(id: 'town:newark-nj', name: 'Newark, NJ'),
    Interest(id: 'town:newbedford-ma', name: 'New Bedford, MA'),
    Interest(id: 'town:newbraunfels-tx', name: 'New Braunfels, TX'),
    Interest(id: 'town:newhaven-ct', name: 'New Haven, CT'),
    Interest(id: 'town:neworleans-la', name: 'New Orleans, LA'),
    Interest(id: 'town:newportnews-va', name: 'Newport News, VA'),
    Interest(id: 'town:newyork-ny', name: 'New York, NY'),
    Interest(id: 'town:norfolk-va', name: 'Norfolk, VA'),
    Interest(id: 'town:norman-ok', name: 'Norman, OK'),
    Interest(id: 'town:northcharleston-sc', name: 'North Charleston, SC'),
    Interest(id: 'town:northlasvegas-nv', name: 'North Las Vegas, NV'),
    Interest(id: 'town:oakland-ca', name: 'Oakland, CA'),
    Interest(id: 'town:oceanside-ca', name: 'Oceanside, CA'),
    Interest(id: 'town:odessa-tx', name: 'Odessa, TX'),
    Interest(id: 'town:oklahomacity-ok', name: 'Oklahoma City, OK'),
    Interest(id: 'town:olathe-ks', name: 'Olathe, KS'),
    Interest(id: 'town:omaha-ne', name: 'Omaha, NE'),
    Interest(id: 'town:ontario-ca', name: 'Ontario, CA'),
    Interest(id: 'town:orange-ca', name: 'Orange, CA'),
    Interest(id: 'town:orlando-fl', name: 'Orlando, FL'),
    Interest(id: 'town:overlandpark-ks', name: 'Overland Park, KS'),
    Interest(id: 'town:oxnard-ca', name: 'Oxnard, CA'),
    Interest(id: 'town:palmbay-fl', name: 'Palm Bay, FL'),
    Interest(id: 'town:palmdale-ca', name: 'Palmdale, CA'),
    Interest(id: 'town:paradise-nv', name: 'Paradise, NV'),
    Interest(id: 'town:pasadena-ca', name: 'Pasadena, CA'),
    Interest(id: 'town:pasadena-tx', name: 'Pasadena, TX'),
    Interest(id: 'town:paterson-nj', name: 'Paterson, NJ'),
    Interest(id: 'town:pearland-tx', name: 'Pearland, TX'),
    Interest(id: 'town:pembrokepines-fl', name: 'Pembroke Pines, FL'),
    Interest(id: 'town:peoria-il', name: 'Peoria, IL'),
    Interest(id: 'town:peoria-az', name: 'Peoria, AZ'),
    Interest(id: 'town:philadelphia-pa', name: 'Philadelphia, PA'),
    Interest(id: 'town:phoenix-az', name: 'Phoenix, AZ'),
    Interest(id: 'town:pittsburgh-pa', name: 'Pittsburgh, PA'),
    Interest(id: 'town:plano-tx', name: 'Plano, TX'),
    Interest(id: 'town:pomona-ca', name: 'Pomona, CA'),
    Interest(id: 'town:pompanobeach-fl', name: 'Pompano Beach, FL'),
    Interest(id: 'town:portland-or', name: 'Portland, OR'),
    Interest(id: 'town:portstlucie-fl', name: 'Port St. Lucie, FL'),
    Interest(id: 'town:providence-ri', name: 'Providence, RI'),
    Interest(id: 'town:provo-ut', name: 'Provo, UT'),
    Interest(id: 'town:pueblo-co', name: 'Pueblo, CO'),
    Interest(id: 'town:quincy-ma', name: 'Quincy, MA'),
    Interest(id: 'town:raleigh-nc', name: 'Raleigh, NC'),
    Interest(id: 'town:ranchocucamonga-ca', name: 'Rancho Cucamonga, CA'),
    Interest(id: 'town:reno-nv', name: 'Reno, NV'),
    Interest(id: 'town:renton-wa', name: 'Renton, WA'),
    Interest(id: 'town:rialto-ca', name: 'Rialto, CA'),
    Interest(id: 'town:richardson-tx', name: 'Richardson, TX'),
    Interest(id: 'town:richmond-va', name: 'Richmond, VA'),
    Interest(id: 'town:richmond-ca', name: 'Richmond, CA'),
    Interest(id: 'town:riorancho-nm', name: 'Rio Rancho, NM'),
    Interest(id: 'town:riverside-ca', name: 'Riverside, CA'),
    Interest(id: 'town:riverview-fl', name: 'Riverview, FL'),
    Interest(id: 'town:rochester-mn', name: 'Rochester, MN'),
    Interest(id: 'town:rochester-ny', name: 'Rochester, NY'),
    Interest(id: 'town:rockford-il', name: 'Rockford, IL'),
    Interest(id: 'town:roseville-ca', name: 'Roseville, CA'),
    Interest(id: 'town:roundrock-tx', name: 'Round Rock, TX'),
    Interest(id: 'town:sacramento-ca', name: 'Sacramento, CA'),
    Interest(id: 'town:salem-or', name: 'Salem, OR'),
    Interest(id: 'town:salinas-ca', name: 'Salinas, CA'),
    Interest(id: 'town:saltlakecity-ut', name: 'Salt Lake City, UT'),
    Interest(id: 'town:sanantonio-tx', name: 'San Antonio, TX'),
    Interest(id: 'town:sanbernardino-ca', name: 'San Bernardino, CA'),
    Interest(id: 'town:sanbuenaventura-ca', name: 'San Buenaventura, CA'),
    Interest(id: 'town:sandiego-ca', name: 'San Diego, CA'),
    Interest(id: 'town:sandysprings-ga', name: 'Sandy Springs, GA'),
    Interest(id: 'town:sanfrancisco-ca', name: 'San Francisco, CA'),
    Interest(id: 'town:sanjose-ca', name: 'San Jose, CA'),
    Interest(id: 'town:sanmateo-ca', name: 'San Mateo, CA'),
    Interest(id: 'town:santaana-ca', name: 'Santa Ana, CA'),
    Interest(id: 'town:santaclara-ca', name: 'Santa Clara, CA'),
    Interest(id: 'town:santaclarita-ca', name: 'Santa Clarita, CA'),
    Interest(id: 'town:santamaria-ca', name: 'Santa Maria, CA'),
    Interest(id: 'town:santanvalley-az', name: 'San Tan Valley, AZ'),
    Interest(id: 'town:santarosa-ca', name: 'Santa Rosa, CA'),
    Interest(id: 'town:savannah-ga', name: 'Savannah, GA'),
    Interest(id: 'town:scottsdale-az', name: 'Scottsdale, AZ'),
    Interest(id: 'town:seattle-wa', name: 'Seattle, WA'),
    Interest(id: 'town:shreveport-la', name: 'Shreveport, LA'),
    Interest(id: 'town:simivalley-ca', name: 'Simi Valley, CA'),
    Interest(id: 'town:siouxfalls-sd', name: 'Sioux Falls, SD'),
    Interest(id: 'town:southbend-in', name: 'South Bend, IN'),
    Interest(id: 'town:southfulton-ga', name: 'South Fulton, GA'),
    Interest(id: 'town:sparks-nv', name: 'Sparks, NV'),
    Interest(id: 'town:spokane-wa', name: 'Spokane, WA'),
    Interest(id: 'town:spokanevalley-wa', name: 'Spokane Valley, WA'),
    Interest(id: 'town:springfield-il', name: 'Springfield, IL'),
    Interest(id: 'town:springfield-ma', name: 'Springfield, MA'),
    Interest(id: 'town:springfield-mo', name: 'Springfield, MO'),
    Interest(id: 'town:springhill-fl', name: 'Spring Hill, FL'),
    Interest(id: 'town:springvalley-nv', name: 'Spring Valley, NV'),
    Interest(id: 'town:stgeorge-ut', name: 'St. George, UT'),
    Interest(id: 'town:stlouis-mo', name: 'St. Louis, MO'),
    Interest(id: 'town:stpaul-mn', name: 'St. Paul, MN'),
    Interest(id: 'town:stpetersburg-fl', name: 'St. Petersburg, FL'),
    Interest(id: 'town:stamford-ct', name: 'Stamford, CT'),
    Interest(id: 'town:sterlingheights-mi', name: 'Sterling Heights, MI'),
    Interest(id: 'town:stockton-ca', name: 'Stockton, CA'),
    Interest(id: 'town:sugarland-tx', name: 'Sugar Land, TX'),
    Interest(id: 'town:sunnyvale-ca', name: 'Sunnyvale, CA'),
    Interest(id: 'town:sunrisemanor-nv', name: 'Sunrise Manor, NV'),
    Interest(id: 'town:surprise-az', name: 'Surprise, AZ'),
    Interest(id: 'town:syracuse-ny', name: 'Syracuse, NY'),
    Interest(id: 'town:tacoma-wa', name: 'Tacoma, WA'),
    Interest(id: 'town:tallahassee-fl', name: 'Tallahassee, FL'),
    Interest(id: 'town:tampa-fl', name: 'Tampa, FL'),
    Interest(id: 'town:temecula-ca', name: 'Temecula, CA'),
    Interest(id: 'town:tempe-az', name: 'Tempe, AZ'),
    Interest(id: 'town:thewoodlands-tx', name: 'The Woodlands, TX'),
    Interest(id: 'town:thornton-co', name: 'Thornton, CO'),
    Interest(id: 'town:thousandoaks-ca', name: 'Thousand Oaks, CA'),
    Interest(id: 'town:toledo-oh', name: 'Toledo, OH'),
    Interest(id: 'town:topeka-ks', name: 'Topeka, KS'),
    Interest(id: 'town:torrance-ca', name: 'Torrance, CA'),
    Interest(id: 'town:tucson-az', name: 'Tucson, AZ'),
    Interest(id: 'town:tulsa-ok', name: 'Tulsa, OK'),
    Interest(id: 'town:tuscaloosa-al', name: 'Tuscaloosa, AL'),
    Interest(id: 'town:tyler-tx', name: 'Tyler, TX'),
    Interest(id: 'town:vacaville-ca', name: 'Vacaville, CA'),
    Interest(id: 'town:vallejo-ca', name: 'Vallejo, CA'),
    Interest(id: 'town:vancouver-wa', name: 'Vancouver, WA'),
    Interest(id: 'town:victorville-ca', name: 'Victorville, CA'),
    Interest(id: 'town:virginiabeach-va', name: 'Virginia Beach, VA'),
    Interest(id: 'town:visalia-ca', name: 'Visalia, CA'),
    Interest(id: 'town:waco-tx', name: 'Waco, TX'),
    Interest(id: 'town:warren-mi', name: 'Warren, MI'),
    Interest(id: 'town:washington-dc', name: 'Washington, DC'),
    Interest(id: 'town:waterbury-ct', name: 'Waterbury, CT'),
    Interest(id: 'town:westcovina-ca', name: 'West Covina, CA'),
    Interest(id: 'town:westjordan-ut', name: 'West Jordan, UT'),
    Interest(id: 'town:westminster-co', name: 'Westminster, CO'),
    Interest(id: 'town:westpalmbeach-fl', name: 'West Palm Beach, FL'),
    Interest(id: 'town:westvalleycity-ut', name: 'West Valley City, UT'),
    Interest(id: 'town:wichita-ks', name: 'Wichita, KS'),
    Interest(id: 'town:wichitafalls-tx', name: 'Wichita Falls, TX'),
    Interest(id: 'town:wilmington-nc', name: 'Wilmington, NC'),
    Interest(id: 'town:winston-salem-nc', name: 'Winston-Salem, NC'),
    Interest(id: 'town:worcester-ma', name: 'Worcester, MA'),
    Interest(id: 'town:yonkers-ny', name: 'Yonkers, NY'),
  ];

  List<Interest> interestOptions = [
    Interest(id: "travel", name: "Travel", subInterests: [
      Interest(id: "travel:beach", name: "Beach"),
      Interest(id: "travel:city", name: "City"),
      Interest(id: "travel:outdoors", name: "Outdoors"),
      Interest(id: "travel:sightseeing", name: "Sightseeing"),
      Interest(id: "travel:asia", name: "Asia"),
      Interest(id: "travel:europe", name: "Europe"),
      Interest(id: "travel:america", name: "America"),
      Interest(id: "travel:africa", name: "Africa"),
      Interest(id: "travel:australia", name: "Australia"),
    ]),
    Interest(id: "sports", name: "Sports", subInterests: [
      Interest(id: "sports:football", name: "Football", subInterests: [
        Interest(id: "sports:football:college", name: "College"),
        Interest(id: "sports:football:nfl", name: "NFL", subInterests: [
          Interest(id: "sports:football:nfl:broncos", name: "Broncos"),
          Interest(id: "sports:football:nfl:chiefs", name: "Chiefs"),
          Interest(id: "sports:football:nfl:raiders", name: "Raiders"),
          Interest(id: "sports:football:nfl:chargers", name: "Chargers"),
          Interest(id: "sports:football:nfl:cowboys", name: "Cowboys"),
          Interest(id: "sports:football:nfl:giants", name: "Giants"),
          Interest(id: "sports:football:nfl:eagles", name: "Eagles"),
          Interest(id: "sports:football:nfl:commanders", name: "Commanders"),
          Interest(id: "sports:football:nfl:bears", name: "Bears"),
          Interest(id: "sports:football:nfl:lions", name: "Lions"),
          Interest(id: "sports:football:nfl:packers", name: "Packers"),
          Interest(id: "sports:football:nfl:vikings", name: "Vikings"),
          Interest(id: "sports:football:nfl:buccaneers", name: "Buccaneers"),
          Interest(id: "sports:football:nfl:falcons", name: "Falcons"),
          Interest(id: "sports:football:nfl:panthers", name: "Panthers"),
          Interest(id: "sports:football:nfl:saints", name: "Saints"),
          Interest(id: "sports:football:nfl:cardinals", name: "Cardinals"),
          Interest(id: "sports:football:nfl:rams", name: "Rams"),
          Interest(id: "sports:football:nfl:49ers", name: "49ers"),
          Interest(id: "sports:football:nfl:seahawks", name: "Seahawks"),
          Interest(id: "sports:football:nfl:ravens", name: "Ravens"),
          Interest(id: "sports:football:nfl:bengals", name: "Bengals"),
          Interest(id: "sports:football:nfl:browns", name: "Browns"),
          Interest(id: "sports:football:nfl:steelers", name: "Steelers"),
          Interest(id: "sports:football:nfl:texans", name: "Texans"),
          Interest(id: "sports:football:nfl:colts", name: "Colts"),
          Interest(id: "sports:football:nfl:jaguars", name: "Jaguars"),
          Interest(id: "sports:football:nfl:titans", name: "Titans"),
          Interest(id: "sports:football:nfl:bills", name: "Bills"),
          Interest(id: "sports:football:nfl:dolphins", name: "Dolphins"),
          Interest(id: "sports:football:nfl:patriots", name: "Patriots"),
          Interest(id: "sports:football:nfl:jets", name: "Jets"),
        ]),
      ]),
      Interest(id: "sports:basketball", name: "Basketball", subInterests: [
        Interest(id: "sports:basketball:college", name: "College"),
        Interest(id: "sports:basketball:nba", name: "NBA"),
      ]),
      Interest(id: "sports:baseball", name: "Baseball"),
      Interest(id: "sports:soccer", name: "Soccer"),
      Interest(id: "sports:hockey", name: "Hockey"),
      Interest(id: "sports:tennis", name: "Tennis"),
      Interest(id: "sports:golf", name: "Golf"),
      Interest(id: "sports:volleyball", name: "Volleyball"),
      Interest(id: "sports:running", name: "Running"),
      Interest(id: "sports:swimming", name: "Swimming"),
      Interest(id: "sports:boxing", name: "Boxing"),
      Interest(id: "sports:mma", name: "MMA"),
    ]),
    Interest(id: "gaming", name: "Gaming", subInterests: [
      Interest(id: "gaming:pc", name: "PC"),
      Interest(id: "gaming:console", name: "Console"),
      Interest(id: "gaming:mobile", name: "Mobile"),
      Interest(id: "gaming:retro", name: "Retro"),
      Interest(id: "gaming:esports", name: "Esports", subInterests: [
        Interest(id: "gaming:esports:leagueoflegends", name: "League of Legends"),
        Interest(id: "gaming:esports:overwatch", name: "Overwatch"),
        Interest(id: "gaming:esports:valorant", name: "Valorant"),
        Interest(id: "gaming:esports:counterstrike", name: "Counter-Strike"),
        Interest(id: "gaming:esports:rocketleague", name: "Rocket League"),
        Interest(id: "gaming:esports:smashbros", name: "Smash Bros"),
        Interest(id: "gaming:esports:fortnite", name: "Fortnite"),
        Interest(id: "gaming:esports:pubg", name: "PUBG"),
        Interest(id: "gaming:esports:apexlegends", name: "Apex Legends"),
        Interest(id: "gaming:esports:starcraft", name: "Starcraft"),
        Interest(id: "gaming:esports:hearthstone", name: "Hearthstone"),
        Interest(id: "gaming:esports:worldofwarcraft", name: "World of Warcraft"),
        Interest(id: "gaming:esports:cod", name: "COD"),
      ]),
    ]),
    Interest(id: "music", name: "Music", subInterests: [
      Interest(id: "music:rock", name: "Rock"),
      Interest(id: "music:pop", name: "Pop"),
      Interest(id: "music:rap", name: "Rap"),
      Interest(id: "music:country", name: "Country"),
      Interest(id: "music:edm", name: "EDM"),
      Interest(id: "music:folk", name: "Folk"),
      Interest(id: "music:reggae", name: "Reggae"),
      Interest(id: "music:blues", name: "Blues"),
      Interest(id: "music:jazz", name: "Jazz"),
      Interest(id: "music:hiphop", name: "Hip Hop"),
      Interest(id: "music:latin", name: "Latin"),
      Interest(id: "music:christian", name: "Christian"),
    ]),
    Interest(id: "food", name: "Food", subInterests: [
      Interest(id: "food:american", name: "American"),
      Interest(id: "food:italian", name: "Italian"),
      Interest(id: "food:mexican", name: "Mexican"),
      Interest(id: "food:chinese", name: "Chinese"),
      Interest(id: "food:japanese", name: "Japanese"),
      Interest(id: "food:indian", name: "Indian"),
      Interest(id: "food:thai", name: "Thai"),
      Interest(id: "food:mediterranean", name: "Mediterranean"),
      Interest(id: "food:bbq", name: "BBQ"),
      Interest(id: "food:vegan", name: "Vegan"),
      Interest(id: "food:vegetarian", name: "Vegetarian"),
      Interest(id: "food:glutenfree", name: "Gluten Free"),
    ]),
    Interest(id: "movies", name: "Movies", subInterests: [
      Interest(id: "movies:action", name: "Action"),
      Interest(id: "movies:comedy", name: "Comedy"),
      Interest(id: "movies:romance", name: "Romance"),
      Interest(id: "movies:horror", name: "Horror"),
      Interest(id: "movies:thriller", name: "Thriller"),
      Interest(id: "movies:documentary", name: "Documentary"),
      Interest(id: "movies:scifi", name: "Sci-Fi"),
      Interest(id: "movies:animation", name: "Animation"),
      Interest(id: "movies:drama", name: "Drama"),
      Interest(id: "movies:western", name: "Western"),
      Interest(id: "movies:musical", name: "Musical"),
      Interest(id: "movies:adventure", name: "Adventure"),
      Interest(id: "movies:family", name: "Family"),
      Interest(id: "movies:war", name: "War"),
      Interest(id: "movies:crime", name: "Crime"),
      Interest(id: "movies:biography", name: "Biography"),
      Interest(id: "movies:history", name: "History"),
      Interest(id: "movies:mystery", name: "Mystery"),
      Interest(id: "movies:superhero", name: "Superhero"),
      Interest(id: "movies:disaster", name: "Disaster"),
      Interest(id: "movies:romcom", name: "Rom-Com"),
      Interest(id: "movies:christmas", name: "Christmas"),
    ]),
    Interest(id: "computers", name: "Computers", subInterests: [
      Interest(id: "computers:programming", name: "Programming", subInterests: [
        Interest(id: "computers:programming:web", name: "Web"),
        Interest(id: "computers:programming:mobile", name: "Mobile"),
        Interest(id: "computers:programming:desktop", name: "Desktop"),
        Interest(id: "computers:programming:game", name: "Game"),
        Interest(id: "computers:programming:embedded", name: "Embedded"),
        Interest(id: "computers:programming:security", name: "Security"),
        Interest(id: "computers:programming:database", name: "Database"),
        Interest(id: "computers:programming:network", name: "Network"),
        Interest(id: "computers:programming:cloud", name: "Cloud"),
        Interest(id: "computers:programming:ai", name: "AI"),
        Interest(id: "computers:programming:ml", name: "ML"),
        Interest(id: "computers:programming:iot", name: "IoT"),
        Interest(id: "computers:programming:robotics", name: "Robotics"),
        Interest(id: "computers:programming:vr", name: "VR/AR"),
        Interest(id: "computers:programming:languages", name: "Languages", subInterests: [
          Interest(id: "computers:programming:languages:ccpp", name: "C"),
          Interest(id: "computers:programming:languages:c#", name: "C#"),
          Interest(id: "computers:programming:languages:java", name: "Java"),
          Interest(id: "computers:programming:languages:javascripttypescript", name: "JavaScript/Typescript"),
          Interest(id: "computers:programming:languages:python", name: "Python"),
          Interest(id: "computers:programming:languages:php", name: "PHP"),
          Interest(id: "computers:programming:languages:ruby", name: "Ruby"),
          Interest(id: "computers:programming:languages:swift", name: "Swift"),
          Interest(id: "computers:programming:languages:go", name: "Go"),
          Interest(id: "computers:programming:languages:rust", name: "Rust"),
          Interest(id: "computers:programming:languages:sql", name: "SQL"),
          Interest(id: "computers:programming:languages:assembly", name: "Assembly"),
          Interest(id: "computers:programming:languages:htmlcss", name: "HTML/CSS"),
          Interest(id: "computers:programming:languages:dar", name: "Dart"),
        ]),
      ]),
      Interest(id: "computers:hardware", name: "Hardware", subInterests: [
        Interest(id: "computers:hardware:cpu", name: "CPU"),
        Interest(id: "computers:hardware:gpu", name: "GPU"),
        Interest(id: "computers:hardware:ram", name: "RAM"),
        Interest(id: "computers:hardware:motherboard", name: "Motherboard"),
        Interest(id: "computers:hardware:storage", name: "Storage"),
        Interest(id: "computers:hardware:power", name: "Power"),
        Interest(id: "computers:hardware:case", name: "Case"),
        Interest(id: "computers:hardware:monitor", name: "Monitor"),
        Interest(id: "computers:hardware:keyboard", name: "Keyboard"),
        Interest(id: "computers:hardware:mouse", name: "Mouse"),
        Interest(id: "computers:hardware:headset", name: "Headset"),
        Interest(id: "computers:hardware:mic", name: "Mic"),
        Interest(id: "computers:hardware:webcam", name: "Webcam"),
        Interest(id: "computers:hardware:controller", name: "Controller"),
      ]),
      Interest(id: "computers:linux", name: "Linux"),
      Interest(id: "computers:windows", name: "Windows"),
      Interest(id: "computers:mac", name: "Mac"),
      Interest(id: "computers:android", name: "Android"),
      Interest(id: "computers:ios", name: "iOS"),
    ]),
  ];

  List<Interest> flattenedInterests = [];

  @override
  void initState() {
    super.initState();
    Queue q = Queue();
    q.addAll(interestOptions);
    while(q.isNotEmpty) {
      Interest i = q.removeFirst();
      flattenedInterests.add(i);
      q.addAll(i.subInterests);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Questionnaire"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            children: [
              Text("Current Location", style: Theme.of(context).textTheme.displaySmall),
              Autocomplete<Interest>(
                displayStringForOption: (option) => option.name,
                optionsBuilder: (TextEditingValue value) {
                  if(value.text == '') {
                    return const Iterable<Interest>.empty();
                  }
                  return townOptions.where((t){
                    return t.name.toLowerCase().contains(value.text.toLowerCase());
                  });
                },
                onSelected: (selected) {
                  currentLocation = selected;
                },
              ),
              Container(height: 25),
              Text("Hometown", style: Theme.of(context).textTheme.displaySmall),
              Autocomplete<Interest>(
                displayStringForOption: (option) => option.name,
                optionsBuilder: (TextEditingValue value) {
                  if(value.text == '') {
                    return const Iterable<Interest>.empty();
                  }
                  return townOptions.where((t){
                    return t.name.toLowerCase().contains(value.text.toLowerCase());
                  });
                },
                onSelected: (selected) {
                  hometown = selected;
                },
              ),
              Container(height: 25),
              Text("Interests", style: Theme.of(context).textTheme.displaySmall),
              Wrap(
                children: interestOptions.map((interest) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: FilterChip(
                      label: Text(interest.name),
                      selected: selectedInterests.contains(interest),
                      onSelected: (selected) {
                        setState(() {
                          if(selected) {
                            selectedInterests.add(interest);
                          } else {
                            selectedInterests.remove(interest);
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              ...flattenedInterests.map((interest){
                return AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  firstChild: Container(),
                  secondChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(interest.name),
                      Wrap(
                        children: interest.subInterests.map((subInterest) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: FilterChip(
                              label: Text(subInterest.name),
                              selected: selectedInterests.contains(subInterest),
                              onSelected: (selected) {
                                setState(() {
                                  if(selected) {
                                    selectedInterests.add(subInterest);
                                  } else {
                                    selectedInterests.remove(subInterest);
                                  }
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  crossFadeState: (selectedInterests.contains(interest) && interest.subInterests.isNotEmpty) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                );
                // if(interest.subInterests.isNotEmpty) {
                //   return 
                // }
                // return Container();
              })
            ]
          ),
        ),
      )
    );
  }
}
