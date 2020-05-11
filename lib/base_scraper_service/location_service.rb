module BaseScraper
  class Service
    class LocationService
      def initialize(address)
        @address = address.to_s.gsub('.', '')
      end

      def extract_state
        # 1- return state abbreviation if matched with state abbreviations
        # 2- return state abbreviation if matched with state name
        # 3- otherwise return empty string
        state = us_states_hash.keys.select { |state_abbreviation| @address.upcase.include?(state_abbreviation) }.first
        return state if state.present? && @address.length != 3
        state = us_states_hash.select { |_, state| @address.include?(state) }.first&.first

        return state.to_s
      end

      def extract_country
        # 1- return country abbreviation if matched with country abbreviations
        # 2- return country abbreviation if matched with country name
        # 3- return USA if address contains a USA state
        # 4- otherwise return empty string
        country = countries_hash.keys.select { |country_abbreviation| @address.include?(country_abbreviation) }.first
        puts country, @address
        return country if country.present?
        country = countries_hash.select { |_, country_name| @address.include?(country_name) }.first&.first
        return country if country.present?

        return 'USA' if extract_state.present?

        return country.to_s
      end

      private

      def us_states_hash
        {
          'AL' => 'Alabama',
          'AK' => 'Alaska',
          'AZ' => 'Arizona',
          'AR' => 'Arkansas',
          'CA' => 'California',
          'CO' => 'Colorado',
          'CT' => 'Connecticut',
          'DE' => 'Delaware',
          'DC' => 'District Of Columbia',
          'FL' => 'Florida',
          'GA' => 'Georgia',
          'HI' => 'Hawaii',
          'ID' => 'Idaho',
          'IL' => 'Illinois',
          'IN' => 'Indiana',
          'IA' => 'Iowa',
          'KS' => 'Kansas',
          'KY' => 'Kentucky',
          'LA' => 'Louisiana',
          'ME' => 'Maine',
          'MD' => 'Maryland',
          'MA' => 'Massachusetts',
          'MI' => 'Michigan',
          'MN' => 'Minnesota',
          'MS' => 'Mississippi',
          'MO' => 'Missouri',
          'MT' => 'Montana',
          'NE' => 'Nebraska',
          'NV' => 'Nevada',
          'NH' => 'New Hampshire',
          'NJ' => 'New Jersey',
          'NM' => 'New Mexico',
          'NY' => 'New York',
          'NC' => 'North Carolina',
          'ND' => 'North Dakota',
          'OH' => 'Ohio',
          'OK' => 'Oklahoma',
          'OR' => 'Oregon',
          'PA' => 'Pennsylvania',
          'RI' => 'Rhode Island',
          'SC' => 'South Carolina',
          'SD' => 'South Dakota',
          'TN' => 'Tennessee',
          'TX' => 'Texas',
          'UT' => 'Utah',
          'VT' => 'Vermont',
          'VA' => 'Virginia',
          'WA' => 'Washington',
          'WV' => 'West Virginia',
          'WI' => 'Wisconsin',
          'WY' => 'Wyoming'
        }
      end

      def countries_hash
        {
          'AFG' => 'Afghanistan',
          'ALB' => 'Albania',
          'DZA' => 'Algeria',
          'ASM' => 'American Samoa',
          'AND' => 'Andorra',
          'AGO' => 'Angola',
          'AIA' => 'Anguilla',
          'ATA' => 'Antarctica',
          'ATG' => 'Antigua and Barbuda',
          'ARG' => 'Argentina',
          'ARM' => 'Armenia',
          'ABW' => 'Aruba',
          'AUS' => 'Australia',
          'AUT' => 'Austria',
          'AZE' => 'Azerbaijan',
          'BHS' => 'Bahamas',
          'BHR' => 'Bahrain',
          'BGD' => 'Bangladesh',
          'BRB' => 'Barbados',
          'BLR' => 'Belarus',
          'BEL' => 'Belgium',
          'BLZ' => 'Belize',
          'BEN' => 'Benin',
          'BMU' => 'Bermuda',
          'BTN' => 'Bhutan',
          'BOL' => 'Bolivia',
          'BES' => 'Bonaire, Sint Eustatius and Saba',
          'BIH' => 'Bosnia and Herzegovina',
          'BWA' => 'Botswana',
          'BVT' => 'Bouvet Island',
          'BRA' => 'Brazil',
          'IOT' => 'British Indian Ocean Territory',
          'BRN' => 'Brunei Darussalam',
          'BGR' => 'Bulgaria',
          'BFA' => 'Burkina Faso',
          'BDI' => 'Burundi',
          'CPV' => 'Cabo Verde',
          'KHM' => 'Cambodia',
          'CMR' => 'Cameroon',
          'CAN' => 'Canada',
          'CYM' => 'Cayman Islands',
          'CAF' => 'Central African Republic',
          'TCD' => 'Chad',
          'CHL' => 'Chile',
          'CHN' => 'China',
          'CXR' => 'Christmas Island',
          'CCK' => 'Cocos (Keeling) Islands',
          'COL' => 'Colombia',
          'COM' => 'Comoros',
          'COD' => 'Congo',
          'COG' => 'Congo',
          'COK' => 'Cook Islands',
          'CRI' => 'Costa Rica',
          'HRV' => 'Croatia',
          'CUB' => 'Cuba',
          'CUW' => 'Curaçao',
          'CYP' => 'Cyprus',
          'CZE' => 'Czechia',
          'CIV' => "Côte d'Ivoire",
          'DNK' => 'Denmark',
          'DJI' => 'Djibouti',
          'DMA' => 'Dominica',
          'DOM' => 'Dominican Republic',
          'ECU' => 'Ecuador',
          'EGY' => 'Egypt',
          'SLV' => 'El Salvador',
          'GNQ' => 'Equatorial Guinea',
          'ERI' => 'Eritrea',
          'EST' => 'Estonia',
          'SWZ' => 'Eswatini',
          'ETH' => 'Ethiopia',
          'FLK' => 'Falkland Islands',
          'FRO' => 'Faroe Islands',
          'FJI' => 'Fiji',
          'FIN' => 'Finland',
          'FRA' => 'France',
          'GUF' => 'French Guiana',
          'PYF' => 'French Polynesia',
          'ATF' => 'French Southern Territories',
          'GAB' => 'Gabon',
          'GMB' => 'Gambia',
          'GEO' => 'Georgia',
          'DEU' => 'Germany',
          'GHA' => 'Ghana',
          'GIB' => 'Gibraltar',
          'GRC' => 'Greece',
          'GRL' => 'Greenland',
          'GRD' => 'Grenada',
          'GLP' => 'Guadeloupe',
          'GUM' => 'Guam',
          'GTM' => 'Guatemala',
          'GGY' => 'Guernsey',
          'GIN' => 'Guinea',
          'GNB' => 'Guinea-Bissau',
          'GUY' => 'Guyana',
          'HTI' => 'Haiti',
          'HMD' => 'Heard Island and McDonald Islands',
          'VAT' => 'Holy See',
          'HND' => 'Honduras',
          'HKG' => 'Hong Kong',
          'HUN' => 'Hungary',
          'ISL' => 'Iceland',
          'IND' => 'India',
          'IDN' => 'Indonesia',
          'IRN' => 'Iran',
          'IRQ' => 'Iraq',
          'IRL' => 'Ireland',
          'IMN' => 'Isle of Man',
          'ISR' => 'Israel',
          'ITA' => 'Italy',
          'JAM' => 'Jamaica',
          'JPN' => 'Japan',
          'JEY' => 'Jersey',
          'JOR' => 'Jordan',
          'KAZ' => 'Kazakhstan',
          'KEN' => 'Kenya',
          'KIR' => 'Kiribati',
          'PRK' => "Korea",
          'KOR' => 'Korea',
          'KWT' => 'Kuwait',
          'KGZ' => 'Kyrgyzstan',
          'LAO' => "Lao People's Democratic Republic",
          'LVA' => 'Latvia',
          'LBN' => 'Lebanon',
          'LSO' => 'Lesotho',
          'LBR' => 'Liberia',
          'LBY' => 'Libya',
          'LIE' => 'Liechtenstein',
          'LTU' => 'Lithuania',
          'LUX' => 'Luxembourg',
          'MAC' => 'Macao',
          'MDG' => 'Madagascar',
          'MWI' => 'Malawi',
          'MYS' => 'Malaysia',
          'MDV' => 'Maldives',
          'MLI' => 'Mali',
          'MLT' => 'Malta',
          'MHL' => 'Marshall Islands',
          'MTQ' => 'Martinique',
          'MRT' => 'Mauritania',
          'MUS' => 'Mauritius',
          'MYT' => 'Mayotte',
          'MEX' => 'Mexico',
          'FSM' => 'Micronesia',
          'MDA' => 'Moldova',
          'MCO' => 'Monaco',
          'MNG' => 'Mongolia',
          'MNE' => 'Montenegro',
          'MSR' => 'Montserrat',
          'MAR' => 'Morocco',
          'MOZ' => 'Mozambique',
          'MMR' => 'Myanmar',
          'NAM' => 'Namibia',
          'NRU' => 'Nauru',
          'NPL' => 'Nepal',
          'NLD' => 'Netherlands',
          'NCL' => 'New Caledonia',
          'NZL' => 'New Zealand',
          'NIC' => 'Nicaragua',
          'NER' => 'Niger',
          'NGA' => 'Nigeria',
          'NIU' => 'Niue',
          'NFK' => 'Norfolk Island',
          'MNP' => 'Northern Mariana Islands',
          'NOR' => 'Norway',
          'OMN' => 'Oman',
          'PAK' => 'Pakistan',
          'PLW' => 'Palau',
          'PSE' => 'Palestine, State of',
          'PAN' => 'Panama',
          'PNG' => 'Papua New Guinea',
          'PRY' => 'Paraguay',
          'PER' => 'Peru',
          'PHL' => 'Philippines',
          'PCN' => 'Pitcairn',
          'POL' => 'Poland',
          'PRT' => 'Portugal',
          'PRI' => 'Puerto Rico',
          'QAT' => 'Qatar',
          'MKD' => 'Republic of North Macedonia',
          'ROU' => 'Romania',
          'RUS' => 'Russian Federation',
          'RWA' => 'Rwanda',
          'REU' => 'Réunion',
          'BLM' => 'Saint Barthélemy',
          'SHN' => 'Saint Helena, Ascension and Tristan da Cunha',
          'KNA' => 'Saint Kitts and Nevis',
          'LCA' => 'Saint Lucia',
          'MAF' => 'Saint Martin',
          'SPM' => 'Saint Pierre and Miquelon',
          'VCT' => 'Saint Vincent and Grenadines',
          'WSM' => 'Samoa',
          'SMR' => 'San Marino',
          'STP' => 'Sao Tome and Principe',
          'SAU' => 'Saudi Arabia',
          'SEN' => 'Senegal',
          'SRB' => 'Serbia',
          'SYC' => 'Seychelles',
          'SLE' => 'Sierra Leone',
          'SGP' => 'Singapore',
          'SXM' => 'Sint Maarten',
          'SVK' => 'Slovakia',
          'SVN' => 'Slovenia',
          'SLB' => 'Solomon Islands',
          'SOM' => 'Somalia',
          'ZAF' => 'South Africa',
          'SGS' => 'South Georgia and South Sandwich Islands',
          'SSD' => 'South Sudan',
          'ESP' => 'Spain',
          'LKA' => 'Sri Lanka',
          'SDN' => 'Sudan',
          'SUR' => 'Suriname',
          'SJM' => 'Svalbard and Jan Mayen',
          'SWE' => 'Sweden',
          'CHE' => 'Switzerland',
          'SYR' => 'Syrian Arab Republic',
          'TWN' => 'Taiwan',
          'TJK' => 'Tajikistan',
          'TZA' => 'Tanzania, United Republic of',
          'THA' => 'Thailand',
          'TLS' => 'Timor-Leste',
          'TGO' => 'Togo',
          'TKL' => 'Tokelau',
          'TON' => 'Tonga',
          'TTO' => 'Trinidad and Tobago',
          'TUN' => 'Tunisia',
          'TUR' => 'Turkey',
          'TKM' => 'Turkmenistan',
          'TCA' => 'Turks and Caicos Islands',
          'TUV' => 'Tuvalu',
          'UGA' => 'Uganda',
          'UKR' => 'Ukraine',
          'ARE' => 'United Arab Emirates',
          'GBR' => 'United Kingdom of Great Britain and Northern Ireland',
          'UMI' => 'United States Minor Outlying Islands',
          'USA' => 'United States of America',
          'URY' => 'Uruguay',
          'UZB' => 'Uzbekistan',
          'VUT' => 'Vanuatu',
          'VEN' => 'Venezuela',
          'VNM' => 'Viet Nam',
          'VGB' => 'Virgin Islands',
          'VIR' => 'Virgin Islands',
          'WLF' => 'Wallis and Futuna',
          'ESH' => 'Western Sahara',
          'YEM' => 'Yemen',
          'ZMB' => 'Zambia',
          'ZWE' => 'Zimbabwe',
          'ALA' => 'Åland Islands'
        }
      end
    end
  end
end
