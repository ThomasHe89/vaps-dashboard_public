
library(shiny)

# Home section
DescriptionTextHomeSection <- tagList(
  tags$h1("PCDB "),
  tags$h2("Political Configurations Database"),
  tags$br(),
  tags$br(),
  tags$h5("The Political Configuration Database (PCDB) is a new type of data infrastructure for political science.
          The PCDB provides an infrastructure that combines information on veto points and veto players,
          party composition of governments, parliamentary and electoral majorities of governments, as well as vote and 
          seat results in all parliamentary chambers for 34 countries from 1939 to 2016."),
  tags$br(),
  tags$h5("While most time-series cross-section studies look at country-years as their unit of analysis, in our view governmental
          configurations have a more substantial meaning. If we are interested in legislation as a mean of effecting institutional
          change, and as legislation emerges from policy processes that often extend for more than one year, we believe
          that the reform effort of a governmental configuration - and not a single year within the configuration - 
          is the most appropriate unit of analysis. In this spirit PCDB offers a database and data tables for the empirical study
          of parties, elections and governments, as well as a web interface that gives a comprehensive and accessible way to process
          all data directly online."),
  tags$br(),
  tags$h5("Currently, PCDB contains data on elections and governments for all EU and most OECD members
          for the entire post-war period. The database combines approximately 1250 parties, 572 lower house
          elections, 516 upper house elections and 83 presidential elections, with 958 cabinets in 1905
          political configurations. Updates at regular intervals will provide up-to-date empirical information
          including recent elections or changes in government. This information can be linked to various external
          data sources and offers a comphrensive new database for political science research."),
  tags$br(),
  tags$h5("The PCDB is funded by Deutsche Forschungsgemeinschaft (DFG) and based at Humboldt University Berlin. Professor Ellen M. 
          Immergut has been appointed as Scientific Programme Coordinator. For more information visit our ",
          a("website.", 
            href = "https://www.sowi.hu-berlin.de/en/lehrbereiche-en/comppol-en/index.html?set_language=en")),
  tags$br(),
  tags$br(),
  tags$p("Development version 1.0", style = "color:red")
)

# About Section

DescriptionTextAboutSection <- tagList(
  tags$h1("About"),
  tags$br(),
  tags$h2("The Program"),
  tags$br(),
  tags$h5("The Political Configuration Database (PCDB) is a new type of data infrastructure for
          political science. The PCDB provides an infrastructure that systematically combines 
          information on veto points and veto players, party composition of governments, parliamentary
          and electoral majorities of governments, as well as vote and seat results in all parliamentary
          chambers for 34 countries from 1939 to 2016. While most time-series cross-section 
          studies look at country-years as their unit of analysis, in our view governmental configurations
          have a more substantial meaning. If we are interested in legislation as a mean of effecting institutional
          change, and as legislation emerges from policy processes that often extend for more than one year, we
          believe that the reform effort of a governmental configuration - and not a single year within the configuration - 
          is the most appropriate unit of analysis. In this context PCDB offers a database and data tables for the 
          empirical study of parties, elections and governments, as well as a web interface that gives a comprehensive and
          accessible way to process all data directly online. Currently, PCDB contains data on elections and governments
          for all EU and most OECD members for the entire post-war period. The database combines approximately 1250 parties,
          572 lower house elections, 516 upper house elections and 83 presidential elections, with 958 cabinets in 1905 political
          configurations. Updates at regular intervals will provide up-to-date empirical information including recent elections
          or changes in government. This information can be linked to various external data sources and offers comphrensive new
          database for political science research."),
  tags$br(),
  tags$h2("Features"),
  tags$br(),
  tags$h5("The Political Configuration Database offers a comphrensive new database for political science research."),
  tags$ul(
    tags$li("Coverage of all EU and most OECD members for the entire post-war period"),
    tags$li("Data on 1250 parties, 572 lower house elections, 516 upper house elections in 1905 unique political
            configurations"),
    tags$li("Regular updates ensure up-to-date empirical information including recent elections
            or changes in government"),
    tags$li("Easily accessible download function"),
    tags$li("Comprehensive web interface using R shiny to process all data directly online.")),
  tags$br(),
  tags$h2("Funding"),
  tags$br(),
  tags$h5("The program is funded by the Deutsche Forschungsgesellschaft (DFG). More information about the
          Deutsche Forschungsgesellschaft can be found on the ",
          a("DFG website.", 
            href = "http://dfg.de/en/index.jsp")),
  tags$br(),
  tags$h2("Contact"),
  tags$br(),
  tags$h5("The PCDB is based at the department of Comparative Politics of Humboldt University Berlin. Professor Ellen M. 
          Immergut has been appointed as Scientific Programme Coordinator. For more information about Comparative Politics
          at Humboldt University visit our ",
          a("website.", 
            href = "https://www.sowi.hu-berlin.de/en/lehrbereiche-en/comppol-en/index.html?set_language=en")),
  tags$br()
)


# Configuration Events 
# 
# The configuration events data table sequences changes in the political-institutional configurations of a country by start date.
# A new political configuration is recorded when one of the following changes occurs:
#   - a change in cabinet composition (rows in Cabinet table, denoted by cabinet ID)
# - a change in lower house composition (rows in Lower House table , denoted by lower house ID)
# - a change in upper house composition, if an upper house exists in country's political system (rows in Upper House table, denoted by upper house ID)
# - a change in presidency, if president exists in country's political system (rows in table Presidential Election, identified by variable presidential election ID)
# - a change in a veto institutions constitutional entitlement of veto rights (i.e., change in veto power of one out of seven veto institutions recorded per country in Veto Points table)

DescriptionTextConfigurationEvents <- tagList(
  tags$h2("Configuration Events"),
  tags$hr(),
  tags$h4("The configuration events data table sequences changes in the political-institutional configurations of a country by start date."),
  tags$h5("A new political configuration is recorded when one of the following changes occurs:"),
  tags$ul(  # open unordered list
    tags$li("a change in cabinet composition (rows in table Cabinet, identified by variable cab_id)"),
    tags$li("a change in lower house composition (rows in rable Lower House, identified by variable lh_id)"),
    tags$li("a change in upper house composition, if an upper house exists in country's political system (rows in table Upper House, identified by variable uh_id)"),
    tags$li("a change in presidency, if president exists in country's political system (rows in table Presidential Election, identified by variable prselc_id)"),
    tags$li("a change in a veto institutions constitutional entitlment of veto rights (i.e., change in veto power of one out of seven veto institutions recorded per country in table Veto Points)")
  ), # close unordered list
  tags$hr()
)


# Country


# Cabinet 
# 
# The cabinet data table contains information on cabinet configurations.
# A new cabinet is enlisted if one of the following events took place:
#   
# - a change in coalition composition at the party-level.
# - a change in the head of government.
# - a new government formation after general legislative elections (does not apply to presidential systems).

DescriptionTextCabinet <- tagList(
  tags$h2("Cabinets"),
  tags$hr(),
  tags$h4("The cabinet data table contains information on cabinet configurations."),
  tags$h5("A new cabinet is enlisted if one of the following events took place:"),
  tags$ul(  # open unordered list
    tags$li("a change in coalition composition at the party-level"),
    tags$li("a change in the head of government"),
    tags$li("a new government formation after general legislative elections (does not apply to presidential systems)")
  ), # close unordered list
  tags$hr()
)


# Cabinet Portfolios
# 
# The cabinet portfolios data table provides information on parties in cabinets, where a  
# cabinet portfolio is defined as the composition of a cabinet at the party-level. 
# A new cabinet portfolio is recorded for each new cabinet (see Cabinet table), that is when one of the following changes occurs:
#   
# - a change in coalition composition at the party-level.
# - a change in head of government.
# - a new government formation after general legislative elections (not in presidential systems).

DescriptionTextCabinetPortfolios <- tagList(
  tags$h2("Cabinet Portfolios"),
  tags$hr(),
  tags$h4("The cabinet portfolios data table provides information on parties in cabinets, where a cabinet portfolio is defined as the composition of a cabinet at the party-level."),
  tags$h5("A new cabinet portfolio is recorded for each new cabinet (see Cabinet table), that is when one of the following changes occurs:"),
  tags$ul(  # open unordered list
    tags$li("a change in coalition composition at the party-level"),
    tags$li("a change in the head of government"),
    tags$li("a new government formation after general legislative elections (does not apply to presidential systems)")
  ), # close unordered list
  tags$hr()
)

# Lower House 
# 
# The lower house data table provides information on lower houses. Rows are compositions of lower
# houses, denoted by a lower house identifier (lh_id). A new lower house configuration is included when:
#   
#   - a change in seat composition through legislative elections,
# - a change in seat composition mergers or splits in factions during the legislature.
# 
# When enlistment is due to the latter event, no lower house election identifier (lhelc_id) is recorded.
# Otherwise, each lower house corresponds to a lower house election.

DescriptionTextLowerHouse <- tagList(
  tags$h2("Lower Houses"),
  tags$hr(),
  tags$h4("The lower house data table provides information on lower houses."),
  tags$h5("Rows are compositions of lower houses, denoted by a lower house identifier (lh_id). A new lower house configuration is included when:"),
  tags$ul(  # open unordered list
    tags$li("a change in seat composition through legislative elections"),
    tags$li(" a change in seat composition mergers or splits in factions during the legislature")
  ), # close unordered list
  tags$h6("When enlistment is due to the latter event, no lower house election identifier (lhelc_id) is recorded. Otherwise, each lower house corresponds to a lower house election."),
  tags$hr()
)


# Lower House Election 
# 
# The lower house election data table provides information on lower house elections. Rows are lower house
# elections, uniquely  identified by lower house election identifier (lhelc_id).
# It is noteworthy that each lower house election corresponds
# to a lower house configuration (see lower house data).


DescriptionTextLHElection <- tagList(
  tags$h2("Lower House Elections"),
  tags$hr(),
  tags$h4("The lower house election data table provides information on lower house elections."),
  tags$h5("Rows are lower house elections, uniquely identified by lower house election identifier (lhelc_id). Each lower house election corresponds to a lower house configuration (see lower house data)."),
  tags$hr()
)

# Lower House Vote Results
# 
# The lower house vote results data table contains data on the distribution of votes in lower house elections at the
# party-level. Rows are the parties, denoted by a party identifier (pty_id), and their respective vote
# results in a given lower house election, denoted by a lower house identifier (lhelc_id).

DescriptionTextLHVoteResults <- tagList(
  tags$h2("Lower House Vote Results"),
  tags$hr(),
  tags$h4("The lower house vote results data table contains data on the distribution of votes in lower house elections at the party-level."),
  tags$h5("Rows are the parties, denoted by a party identifier (pty_id), and their respective vote results in a given lower house election, denoted by a lower house identifier (lhelc_id)."),
  tags$hr()
)

# Lower House Seat Results
# 
# The lower house seat results data tabel contains data on the distribution of seats in the lower house at the
# party-level. Rows are parties, denoted by a party identifier (pty_id), and their respective seat
# results in a given lower house election (lh_id).


DescriptionTextLHSeatResults <- tagList(
  tags$h2("Lower House Seat Results"),
  tags$hr(),
  tags$h4("The lower house seat results data tabel contains data on the distribution of seats in the lower house at the party-level."),
  tags$h5(" Rows are parties, denoted by a party identifier (pty_id), and their respective seats results in a given lower house (lh_id)."),
  tags$hr()
)

# Upper House
# 
# The upper house data table provides general information on upper houses. Rows are compositions of upper houses, denoted by
# an upper house identifier (uh_id) as well as a unique combinations of country ID (ctr_id) and start date (uh_sdate).
# A new upper house composition is included when:
#   
#   -- a change in the composition through legislative elections,
# -- a change in the composition through mergers or splits in factions during the legislature.
# 
# Note that Information is only provided for countries with bicameral systems.

DescriptionTextUpperHouse <- tagList(
  tags$h2("Upper Houses"),
  tags$hr(),
  tags$h4("The upper house data table provides general information on upper houses."),
  tags$h5("Rows are compositions of upper houses, denoted by an upper house identifier (uh_id) as well as a unique combinations of country ID (ctr_id) and start date (uh_sdate). A new upper house configuration is included when:"),
  tags$ul(  # open unordered list
    tags$li("a change in the composition through legislative elections"),
    tags$li("a change in the composition through mergers or splits in factions during the legislature")
  ), # close unordered list
  tags$h5("Note that information is only provided for countries with bicameral systems."),
  tags$hr()
)

# Upper House Election
# 
# The upper house election data table includes information on upper house elections. Rows report ˙pper 
# house elections, denoted by an upper house elction identifier (uhelc_id) as well as a unique combinations of 
# country ID (ctr_id) and election date (uhelc_date).
# 
# Information is only provided for countries with bicameral systems.

DescriptionTextUHElection <- tagList(
  tags$h2("Upper House Elections"),
  tags$hr(),
  tags$h4("The upper house election data table includes information on upper house elections."),
  tags$h5("Rows are compositions of upper houses elections, denoted by an upper house elction identifier (uhelc_id) as well as a unique combinations of country ID (ctr_id) and election date (uhelc_date)."),
  tags$h5("Note that information is only provided for countries with bicameral systems."),
  tags$hr()
)

# Upper House Seat Results
# 
# The upper house seat results data table compiles data on the seat composition in upper houses at the party-level.
# Rows are parties, denoted by party identifier (pty_id), and their respective seat results in a given upper house (uh_id).
# 
# Information is only provided for countries with bicameral systems.

DescriptionTextUHSeatResults <- tagList(
  tags$h2("Upper House Seat Results"),
  tags$hr(),
  tags$h4("The upper house seat results data table compiles data on the seat composition in upper houses at the party-level."),
  tags$h5("Rows are parties, denoted by party identifier (pty_id), and their respective seat results in a given upper house (uh_id)."),
  tags$h5("Note that information is only provided for countries with bicameral systems."),
  tags$hr()
)

# Presidential Electiion
# 
# The presidential election data table contains general information on presidential elections. Rows are presidential elections,
# denoted by an identifier (prselc_id) as well as a unique combinations of country ID (ctr_id) and election date (prselc_date.)
# Note that information is only provided for countries with presidential systems.

DescriptionTextPresidentialElections <- tagList(
  tags$h2("Presidential Elections"),
  tags$hr(),
  tags$h4("The presidential election data table contains general information on presidential elections."),
  tags$h5("Rows are presidential elections, denoted by an identifier (prselc_id) as well as a unique combinations of country ID (ctr_id) and election date (prselc_date)."),
  tags$h5("Note that information is only provided for countries with presidential systems."),
  tags$hr()
)

# Presidential Election Vote Results
# 
# The presidential election vote results data table provides data on vote results in presidential elections at the candidate-level.
# Rows are the candidates running in (the multiple rounds of) an election, denoted by an identifier (prsvres_id) as well as a unique 
# combinations of presidential election ID (prselc_id), election round (prselc_rnd) and a candidate's party (prselc_cnd_pty).


DescriptionTextPresidentialElectionVoteResults <- tagList(
  tags$h2("Presidential Election Vote Results"),
  tags$hr(),
  tags$h4("The presidential election vote results data table provides data on vote results in presidential elections at the candidate-level."),
  tags$h5("Rows are presidential elections, denoted by an identifier (prselc_id) as well as a unique combinations of country ID (ctr_id) and election date (prselc_date)."),
  tags$h5("Note that information is only provided for countries with presidential systems."),
  tags$hr()
)


# Veto Points
# 
# The veto points data table contains information on potential veto points in a countryís political
# system, including the type of institution and the time period of its existence as a veto point.
# Rows are a country's different institutions, denoted by an identifier (vto_id) as well as a unique combination
# of country ID (ctr_id), institution's type (vto_inst_typ) and start date (vto_inst_sdate).
# 
# 
# 
# ### Party
# Party
# 
# The party data table provides general information on parties. Rows are parties within countries, denoted by a unique
# combinations of country ID (ctr_id) and a party identifier (pty_id).
# 
# 
# 
# ### Electoral Alliances
# Electoral Aliiances
# 
# The electoral alliances data table provides information on electoral alliances, indicating
# parties forming an electoral alliance. Parties listed in the party data table that are
# recorded as electoral alliances are listed in with their respective party ID (pty_id).
# Parties that constitute an electoral alliance are enumerated by a counter (pty_eal_nbr).
# There occur as many rows for each electoral alliance as stated by the counter.
# The elctoral alliance identifier (pty_eal_id), records the party IDs of parties forming an electoral
# alliance. Combinations of electoral alliance pty_eal_id) and enumerator of party
# in electoral alliance (pty_eal_nbr) are unique within countries.
# 


