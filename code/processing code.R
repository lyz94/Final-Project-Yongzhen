frame_motion <- frame_all %>%
  
  select(date, time, mover_edited, type, motion, separate_mechanism, voting_result) %>%
  
  distinct() %>%
  rename("mover"="mover_edited")%>%
  
  mutate_if(is.character, as.factor) %>%
  arrange(date, time) %>%
  
  mutate(year=year(date))


frame_edited <- frame_motion %>%
  left_join(members, by =c("mover"="Capitalized")) %>%
  select(-name) %>%
  arrange(date) %>%
  mutate(year=year(date)) 


frame_edited[is.na(frame_edited)] <- "Official"

frame_edited <- frame_edited %>%
  mutate_if(is.character, as.factor) 


motion <- data.frame(motion = str_which(frame_edited$motion, "^MOTION|^\"MOTION|^FIRST|^SECOND|^THIRD|AMENDING"), motion_type = rep("motion", times=length(str_which(frame_edited$motion, "^MOTION|^\"MOTION|^FIRST|^SECOND|^THIRD|AMENDING"))))


amendment <- data.frame(motion = str_which(frame_edited$motion, "^AMENDMENT"), motion_type = rep("amendment", times=length(str_which(frame_edited$motion, "^AMENDMENT"))))


bill <- data.frame(motion = str_which(frame_edited$motion, "BILL"), motion_type = rep("bill", times=length(str_which(frame_edited$motion, "BILL"))))


resolution <- data.frame(motion = str_which(frame_edited$motion, "^PROPOSED"), motion_type = rep("resolution", times=length(str_which(frame_edited$motion, "^PROPOSED"))))


motions <- rbind(motion, amendment, bill, resolution)

frame_edited$id <- seq.int(nrow(frame_edited))

frame_edited <- frame_edited %>%
  left_join(motions, by =c("id"= "motion"))

frame_edited <- frame_edited %>%
  arrange(desc(motion_type))

frame_edited$motion_type[c(958,959,960,961)]= "resolution"
frame_edited$motion_type[c(964,965,966,967)]= "motion"
frame_edited$motion_type[c(962,963)]= "others"

frame_edited$motion_type <- as.factor(frame_edited$motion_type)

frame_edited %>%
  arrange(motion_type)

frame_edited %>%
  select (motion, motion_type, id) %>%
  count (id, motion) %>%
  mutate(duplicate = ifelse(n>1, TRUE, FALSE)) %>%
  filter(duplicate == TRUE)

frame_motion <- frame_motion %>%
  left_join(voting_record, by =c("date", "time", "motion")) 

frame_motion %>%
  arrange(date, time)

bills <- frame_edited %>%
  filter(motion_type == "bill") %>%
  mutate(subtitle = str_extract(motion, "^[^-]+")) %>%
  arrange(date) 






