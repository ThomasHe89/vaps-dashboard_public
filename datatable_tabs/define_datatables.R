#########################################################################
### Title:  Example of multiple tabs that output table data
###
### Author: Hauke Licht
### Data:   August 4, 2016
### produced under R version 3.2.3

library(R.cache)

# IMPORTANT: Set working directory to local 'vaps-dashboard_public' directory first
if ( Sys.info()["user"] == "lichthau" ) { setwd("~/Documents/Humboldt/Electoral_Vulnerability/Projects/vaps-dashboard_public")
} else if ( Sys.info()["user"] == "johndoe" ) { setwd("")
} else if ( Sys.info()["user"] == "mio-mio1" ) { setwd("")
} else warning("Sorry, but could not find path to 'vaps-dashboard_public' directory.")

if ( sub(".*/","",getwd()) == "vaps-dashboard_public" ) {
  
  setCacheRootPath(path=getwd()) 
  # load cached data list
  allPCDBObjects <- loadCache(key=list("PCDB","data"))   # key is PCDB + data
  # retrieve data from list
  for ( o in seq_along(allPCDBObjects) ) { seq_along(allPCDBObjects)
    assign(names(allPCDBObjects)[ o ], allPCDBObjects[[ o ]])
  }; rm(o)
  # ... and there we go        
} else warning("Cannot load cached data. Please setwd() to vaps-dashboard_public directory!")

# (a) produce data tables of interest (pseudo code):
#       i) merge country information, aggregate indicators, etc on table of interest by ctr_id
#      ii) subset such that only variables are kept that are meant to be publically available
#     iii) order by columns that uniquely identify observtions in table (e.g. ctr_id and *_sdate)
#      iv) remove superflous character snipets from columns that contain text
#
# (b) define list of variables in data table (for optional choices in column selector (checkboxGroupInput) in user interface)

  # ... using function that returns list with column names as elements and labels as 
  # element names for a given input sting that is a table name (in global environemnt)
  get_var_labels <- function( table.name ) {
    l <- as.list( unlist(colLabsList)[ match( names(get( table.name )),unlist(colLabsList)) ] )
    names(l) <- sub(".*[.]", "", names(l))
    l
  }


### DATATABLES ### 
  # Country
  country_table <- country
  
    # remove chunk from columns containing text/character
    clean_up_column <- ColumnsInTables[ColumnsInTables$table_name=="country" & ColumnsInTables$data_type %in% c("character varying", "text"), "column_name"]
    
    for (c in seq_along(clean_up_column)) { country_table[, c ] <- gsub("\t|\t[.| ]","", country_table[, c ] ) }
    
    # define list of variable choices for data table input/output
    var_choices_country_table <- get_var_labels("country_table")
    
    
  # Cabinet
  cabinet_table <- merge(country[,1:3],cabinet,by="ctr_id",all.y=T)
  cabinet_table <- cabinet_table[, setdiff(colnames(cabinet_table),c("cab_nxt_id","cab_prv_id","cab_valid_sdate"))]
  
    # order table by ctr_id and sdate
    cabinet_table <- cabinet_table[order(cabinet_table$ctr_id, cabinet_table$cab_sdate), ]
    
    # remove chunk from columns containing text/character
    clean_up_column <- ColumnsInTables[ColumnsInTables$table_name=="cabinet" & ColumnsInTables$data_type %in% c("character varying", "text"), "column_name"]
    
    for (c in seq_along(clean_up_column)) { cabinet_table[, c ] <- gsub("\t|\t[.| ]","", cabinet_table[, c ] ) }
    
    # define list of variable choices for data table input/output
    var_choices_cabinet_table <- get_var_labels("cabinet_table")
    
  
  # Cabinet Portfolios
  cabinet_portfolios_table <- merge(country[,1:3],cabinet,by="ctr_id",all.y=T)
  cabinet_portfolios_table <- merge(cabinet_portfolios_table,cabinet_portfolios,by="cab_id",all.y=T)
  cabinet_portfolios_table <- merge(cabinet_portfolios_table,party[,c("pty_id","pty_abr","pty_n_en")],by="pty_id",all.x=T)
  
  cabinet_portfolios_table <- cabinet_portfolios_table[, c("ptf_id","ctr_id", "ctr_n","ctr_ccode","cab_id","cab_sdate","pty_id","pty_abr","pty_n_en","pty_cab","pty_cab_hog","cab_hog_n","pty_cab_sup","pty_cab_sts", "ptf_cmt","ptf_src")]
  
  # order table by ctr_id and sdate
  cabinet_portfolios_table <- cabinet_portfolios_table[order(cabinet_portfolios_table$ptf_id), ]
  
  # remove chunk from columns containing text/character
  clean_up_column <- ColumnsInTables[(ColumnsInTables$table_name=="cabinet_portfolio" | ColumnsInTables$table_name=="party") 
                                     & ColumnsInTables$data_type %in% c("character varying", "text"), "column_name"]
  
  for (c in seq_along(clean_up_column)) { cabinet_portfolios_table[, c ] <- gsub("\t|\t[.| ]","", cabinet_portfolios_table[, c ] ) }  
  
  # define list of variable choices for data table input/output
  var_choices_cabinet_portfolios_table <- get_var_labels("cabinet_portfolios_table")
  
  
  # Lower House
  lower_house_table <- merge(country[,1:3],lower_house,by="ctr_id",all.y=T)
  lower_house_table <- lower_house_table[, setdiff(colnames(lower_house_table),c("lh_prv_id", "lh_nxt_id", "lh_enpp", "lh_valid_sdate"))]
  lower_house_table <- merge(lower_house_table,view_lh_enpp_minfrag,by="lh_id",all.x=T)
  lower_house_table <- merge(lower_house_table,view_lh_enpp_maxfrag,by="lh_id",all.x=T)
  lower_house_table <- merge(lower_house_table,view_lh_vola_sts,by="lh_id",all.x=T)
  lower_house_table <- merge(lower_house_table,view_lh_volb_sts,by="lh_id",all.x=T)
  
  # order table by ctr_id and sdate
  lower_house_table <- lower_house_table[order(lower_house_table$ctr_id, lower_house_table$lh_sdate), ]
  
  # remove chunk from columns containing text/character
  clean_up_column <- ColumnsInTables[ColumnsInTables$table_name=="lower_house" & ColumnsInTables$data_type %in% c("character varying", "text"), "column_name"]
  
  for (c in seq_along(clean_up_column)) {  lower_house_table[, c ] <- gsub("\t|\t[.| ]","", lower_house_table[, c ] ) }
  
  # define list of variable choices for data table input/output
  var_choices_lower_house_table <- get_var_labels("lower_house_table")
  
  
  # LH Election
  lh_election_table <- merge(country[,1:3],lh_election,by="ctr_id",all.y=T)
  lh_election_table <- lh_election_table[, setdiff(colnames(lh_election_table), c("lhelc_lsq", "lhelc_vola_sts", "lhelc_volb_sts", "lhelc_vola_vts", "lhelc_volb_vts", "lhelc_prv_id", "lhelc_nxt_id", "lhelc_valid_date"))]
  lh_election_table <- merge(lh_election_table,view_lhelc_lsq[,-2] ,by="lhelc_id",all.x=T)
  lh_election_table <- merge(lh_election_table,view_lhelc_vola_vts[,-1] ,by="lhelc_id",all.x=T)
  lh_election_table <- merge(lh_election_table,view_lhelc_volb_vts[,-1] ,by="lhelc_id",all.x=T)
  
  # order table by ctr_id and sdate
  lh_election_table <- lh_election_table[order(lh_election_table$ctr_id, lh_election_table$lhelc_date), ]
  
  # remove chunk from columns containing text/character
  clean_up_column <- ColumnsInTables[ColumnsInTables$table_name=="lh_election" & ColumnsInTables$data_type %in% c("character varying", "text"), "column_name"]
  
  for (c in seq_along(clean_up_column)) { lh_election_table[, c ] <- gsub("\t|\t[.| ]","", lh_election_table[, c ] ) }
  
  # define list of variable choices for data table input/output
  var_choices_lh_election_table <- get_var_labels("lh_election_table")
  
  
  # Upper House
  upper_house_table <- merge(country[,1:3],upper_house,by="ctr_id",all.y=T) 
  upper_house_table <- upper_house_table[, setdiff(colnames(upper_house_table), c("uh_prv_id", "uh_valid_sdate"))]
  
  # order table by ctr_id and sdate
  upper_house_table <- upper_house_table[order(upper_house_table$ctr_id, upper_house_table$uh_sdate), ]
  
  # remove chunk from columns containing text/character
  clean_up_column <- ColumnsInTables[ColumnsInTables$table_name=="upper_house" & ColumnsInTables$data_type %in% c("character varying", "text"), "column_name"]
  
  for (c in seq_along(clean_up_column)) { upper_house_table[, c ] <- gsub("\t|\t[.| ]","", upper_house_table[, c ] ) }
  
  # define list of variable choices for data table input/output
  var_choices_upper_house_table <- get_var_labels("upper_house_table")
  
  
  # UH Election (currently missing in beta_version schema !!! )
  
  # Presdiential Election
  presidential_election_table <- merge(country[,1:3],presidential_election,by="ctr_id",all.y=T)
  presidential_election_table <- presidential_election_table[, setdiff(colnames(presidential_election_table), c("prselc_prv_id", "prselc_valid_date", "prs_valid_sdate"))]
  
  # order table by ctr_id and sdate
  presidential_election_table <- presidential_election_table[order(presidential_election_table$ctr_id, presidential_election_table$prselc_date), ]
  
  # remove chunk from columns containing text/character
  clean_up_column <- ColumnsInTables[ColumnsInTables$table_name=="presidential_election" & ColumnsInTables$data_type %in% c("character varying", "text"), "column_name"]
  
  for (c in seq_along(clean_up_column)) { presidential_election_table[, c ] <- gsub("\t|\t[.| ]","", presidential_election_table[, c ] ) }
  
  # define list of variable choices for data table input/output
  var_choices_presidential_election_table <- get_var_labels("presidential_election_table")  # 'prs_src' currently missing in codebook
  
  
  # Veto Points
  veto_points_table <- merge(country[,1:3],veto_points,by="ctr_id",all.y=T)
  
  # order table by ctr_id and sdate
  veto_points_table <- veto_points_table[order(veto_points_table$ctr_id, veto_points_table$vto_id), ]
  
  # remove chunk from columns containing text/character
  clean_up_column <- ColumnsInTables[ColumnsInTables$table_name=="veto_points" & ColumnsInTables$data_type %in% c("character varying", "text"), "column_name"]
  
  for (c in seq_along(clean_up_column)) { veto_points_table[, c ] <- gsub("\t|\t[.| ]","", veto_points_table[, c ] ) }
  
  # define list of variable choices for data table input/output
  var_choices_veto_points_table <- get_var_labels("veto_points_table")  
  
  
  # Party
  party_table <- merge(country[,1:3],party,by="ctr_id",all.y=T)
  party_table <- party_table[, setdiff(colnames(party_table), "pty_eal_id")]
  
  # order table by ctr_id and sdate
  party_table <- party_table[order(party_table$ctr_id, party_table$pty_id), ]
  
  # remove chunk from columns containing text/character
  clean_up_column <- ColumnsInTables[ColumnsInTables$table_name=="party" & ColumnsInTables$data_type %in% c("character varying", "text"), "column_name"]
  
  for (c in seq_along(clean_up_column)) { party_table[, c ] <- gsub("\t|\t[.| ]","", party_table[, c ] ) }
  
  # define list of variable choices for data table input/output
  var_choices_party_table <- get_var_labels("party_table")  
  
  
  # Configuration Events
  configuration_events_table <- merge(country[,1:3],mv_configuration_events,by="ctr_id",all.y=T)
  configuration_events_table <- configuration_events_table[, setdiff(colnames(configuration_events_table), c("type_of_change"))]
  
  # order table by ctr_id and sdate
  configuration_events_table <- configuration_events_table[order(configuration_events_table$ctr_id, configuration_events_table$sdate), ]
  
  # remove chunk from columns containing text/character
  clean_up_column <- ColumnsInTables[ColumnsInTables$table_name=="mv_configuration_events" & ColumnsInTables$data_type %in% c("character varying", "text"), "column_name"]
  
  for (c in seq_along(clean_up_column)) { configuration_events_table[, c ] <- gsub("\t|\t[.| ]","", configuration_events_table[, c ] ) }
  
  # define list of variable choices for data table input/output
  var_choices_configuration_events_table <- get_var_labels("configuration_events_table")  

