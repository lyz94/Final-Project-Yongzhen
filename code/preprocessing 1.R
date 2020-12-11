library(tidyverse)
library(rvest)
library(stringr)
library(purrr)
library(lubridate)


scrape_result<- function(URL){
  page <- read_xml(URL)
  date <- xml_nodes(page, "vote-date")%>%
    xml_text() %>%
    dmy()
  time <- xml_nodes(page, "vote-time")%>%
    xml_text() 
  mover <- xml_nodes(page, "mover-en")%>%
    xml_text()
  type <- xml_nodes(page, "mover-type")%>%
    xml_text()
  motion <- xml_nodes(page, "motion-en")%>%
    xml_text()
  vote <- xml_nodes(page, "member vote")%>%
    xml_text()
  mechanism <- xml_nodes(page, "vote-separate-mechanism") %>%
    xml_text()
  result <- xml_nodes(page, "overall result")%>%
    xml_text()
  dframe <- data.frame("date"=date, "time"=time, "mover"=mover, "type"=type, "motion"=motion, "vote"=vote, "separate_mechanism"= mechanism, "voting_result"=result)
  return(dframe)
  
}

result2016_17 <- c("https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20161109.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20161116.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20161123.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20161130.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20161207.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20161214.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170111.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170118.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170208.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170215.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170301.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170322.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170329.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170426.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170517.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170524.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170531.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170607.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170614.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170621.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170628.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170705.xml",
                   "https://www.legco.gov.hk/yr16-17/chinese/counmtg/voting/cm_vote_20170712.xml")

frame2016_17 <- map_dfr(result2016_17, scrape_result) 


result2017_18 <- c("https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20171018.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20171025.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20171101.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20171108.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20171115.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20171129.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20171206.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20171213.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180110.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180117.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180124.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180131.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180207.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180321.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180328.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180411.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180502.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180509.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180516.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180523.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180530.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180606.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180613.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180620.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180627.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180704.xml",
                   "https://www.legco.gov.hk/yr17-18/chinese/counmtg/voting/cm_vote_20180711.xml")

frame2017_18 <- map_dfr(result2017_18, scrape_result)

result2018_19 <- c("https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20181010.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20181024.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20181031.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20181107.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20181114.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20181121.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20181128.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20181205.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20181212.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190116.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190123.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190130.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190220.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190320.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190327.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190403.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190508.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190515.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190522.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190529.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190605.xml",
                   "https://www.legco.gov.hk/yr18-19/chinese/counmtg/voting/cm_vote_20190626.xml")

frame2018_19 <- map_dfr(result2018_19, scrape_result)


result2019_20 <- c("https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20191023.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20191127.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20191204.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20191211.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20191218.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20200115.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20200325a.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20200429.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20200506.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20200513.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20200520.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20200527.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20200603.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20200610.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20200617.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20200708.xml",
                   "https://www.legco.gov.hk/yr19-20/chinese/counmtg/voting/cm_vote_20200715.xml")

frame2019_20 <- map_dfr(result2019_20, scrape_result)


frame_all <- rbind(frame2016_17, frame2017_18, frame2018_19, frame2019_20)


frame_all$mover_edited <- sub("^(Dr|Mrs)", "", frame_all$mover)

frame_all$mover_edited <- str_to_title(frame_all$mover_edited)

frame_all$mover_edited <- str_trim(frame_all$mover_edited, side = "left")

frame_all <- frame_all %>%
  group_by(motion)%>%
  arrange(date, time)


voting_record <- frame_all %>%
  group_by(date, time, motion) %>%
  count(vote) %>%
  rename("results"="n") %>%
  spread(vote, results)

voting_record[is.na(voting_record)] = 0


voting_record <- voting_record %>%
  mutate(total = sum(Absent, Abstain, No, Present, Yes),
         attendance_rate = 1 - (Absent/total),
         attendance = sum(Abstain, No, Present, Yes),
         approval_rate = Yes/attendance) 


voting_record$attendance_rate <- round(voting_record$attendance_rate, digits = 2)
voting_record$approval_rate <- round(voting_record$approval_rate, digits = 2)
voting_record%>%
  arrange(date, time)



