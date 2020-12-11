


scrape_name <- function(U2){
  page <- read_html(U2)
  name <- html_nodes(page, ".fn a") %>%
    html_text()
  info <- data.frame("name"= name)
  return(info)
}

member <- scrape_name("https://en.wikipedia.org/wiki/6th_Legislative_Council_of_Hong_Kong")

scrape_party <- function(U2){
  page <- read_html(U2)
  party <- html_nodes(page, "td:nth-child(6) a") %>%
    html_text()
  info <- data.frame("party"= party)
  return(info)
}
 
party <- scrape_party("https://en.wikipedia.org/wiki/6th_Legislative_Council_of_Hong_Kong")
 
party <- unlist(party)
party <- party[-c(11, 14, 19, 30, 32, 38)]
party <- as.vector(party)
party <- data.frame(party)

members <- cbind(member, party)

capitalized_names <- members %>%
  select(name) %>%
  unlist() %>%
  str_to_title() %>%
  data.frame(Capitalized)
 
members <- members %>%
  add_column(Capitalized)

members$affiliation = ifelse(members$party %in% c("BPA", "Liberal", "DAB", "FTU", "NPP", "New Forum","FLU"), "Government",
                             ifelse(members$party %in% c("Prof Commons", "Civic", "LSD", "Democratic", "People Power", "Labour", "Civic Passion", "Demosisto", "Youngspiration", "Neo Democrats", "NWSC", "PTU"), "Opposition",
                                    ifelse(members$Capitalized %in% c("Joseph Lee", "Eddie Chu", "Shiu Ka-Chun", "Yiu Chung-Yim", "Lau Siu-Lai", "Au Nok-Hin"), "Opposition",
                                           ifelse(members$Capitalized %in% c("Chan Kin-Por", "Paul Tse", "Yiu Si-Wing", "Martin Liao", "Jimmy Ng", "Junius Ho", "Chan Chun-ying", "Tony Tse", "Chan Hoi-Yan","Chan Chun-Ying"), "Government",
                                                  "Centrist"))))


members$Capitalized[45]="Chu Hoi-Dick"
members$Capitalized[41]="Ir Dr Lo Wai-Kwok"
members$Capitalized[24]="Charles Peter Mok"

members <- members %>%
  group_by(affiliation, party) %>%
  arrange (party)



