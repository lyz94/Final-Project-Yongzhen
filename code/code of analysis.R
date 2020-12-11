frame_motion <- frame_motion %>%
  left_join(members, by=c("mover"="Capitalized")) 

frame_motion[is.na(frame_motion)] <- "Official"

frame_motion %>%
  group_by(year) %>%
  count(affiliation)

 
motion_record <- frame_motion %>%
  select(year, affiliation, party, mover) %>%
  group_by(year) %>%
  add_count(affiliation, name="freq_affi_motions")%>%
  group_by(year, affiliation) %>%
  add_count(mover, name = "motions") %>%
  add_count(party, name = "freq_party_motions") %>%
  arrange(year) 

party_record <- motion_record %>%
  select(year, affiliation, party, freq_party_motions)%>%
  arrange(year, desc(freq_party_motions))

 
affi_record <- motion_record %>%
  select(year, affiliation, freq_affi_motions)%>%
  arrange(year, desc(freq_affi_motions))
 
party_freq <- ggplot(party_record, aes(x=party, y=freq_party_motions, fill=affiliation))+
  geom_col(position="dodge")+
  labs(title = "Motion Frequency of the 6th Hong Kong Legislative Council(By Parties)", x="year", y="frequency of motion")+
  scale_fill_manual("Affiliations", values=c("Centrist"="green", "Government"="blue", "Opposition"="orange", "Official"="red"))+
  coord_flip()+
  facet_grid(rows = vars(year), scales = "free_y",
             space = "free_y")

ggsave("party_freq.png", plot = party_freq)

affil_freq <- ggplot(affi_record, aes(x=year, y=freq_affi_motions, fill=affiliation))+
  geom_col(position="dodge")+
  coord_cartesian()+
  labs(title = "Motion Frequency of the 6th Hong Kong Legislative Council(By affiliation)", x="year", y="frequency of motion")+
  scale_fill_manual("Affiliations", values=c("Centrist"="green", "Government"="blue", "Opposition"="orange", "Official"="red"))

ggsave("affiliation_freq.png", plot = affil_freq)

mo_type_record <- frame_edited %>%
  select(year, affiliation, party, motion_type) %>%
  group_by(year, affiliation) %>%
  add_count(motion_type, name="affi_motion_type")%>%
  arrange(year)

mo_type <- ggplot(mo_type_record, aes(x=motion_type, y=affi_motion_type, fill=affiliation))+
  geom_col(position="dodge")+
  labs(title = "Motion type of the 6th Hong Kong Legislative Council(By Parties)", x="year", y="frequency of motion")+
  scale_fill_manual("Affiliations", values=c("Centrist"="green", "Government"="blue", "Opposition"="orange", "Official"="red"))+
  coord_flip()+
  facet_grid(rows = vars(year), scales = "free_y",
             space = "free_y")

ggsave("motion_type.png", mo_type)

bills <- bills %>%
  group_by(subtitle) %>%
  add_count(name = "bill_frequency") %>%
  group_by(subtitle) %>%
  add_count(affiliation, name = "affi_frequency")


bill_freq <- bills %>%
  filter(bill_frequency > 5) %>%
  ggplot (aes(x= subtitle, y= affi_frequency, fill=affiliation))+
  geom_col(position = "dodge")+
  coord_fixed(ratio=10)+
  theme(axis.text = element_text(size = 3),
        aspect.ratio = 3/10,
        legend.text = element_text(size=3),
        legend.title = element_text(size=3),
        axis.title = element_text(size=4),
        plot.title = element_text(size=6),
        legend.key.size = unit(0.3, "cm"))+
  labs(title="Amendments Regarding Bill Debating", x="Bills on the 6th Legislative Council", y="Frequency of Amendments")+
  scale_fill_manual("Affiliations", values=c("Centrist"="green", "Government"="blue", "Opposition"="orange", "Official"="red"))+
  coord_flip()
bill_freq

ggsave("frequency of amendments of bills.jpeg", bill_freq)

bills %>%
  left_join(voting_record, by=c("date", "time", "motion")) 


bill_anal_1 <- bills %>%
  filter(bill_frequency > 15) %>%
  ggplot (aes(x= attendance_rate, y= approval_rate, color=affiliation, size = separate_mechanism, shape = voting_result))+
  geom_point()+
  coord_fixed(ratio=2/3)+
  scale_color_manual("Affiliation", values = c("Centrist"="green", "Government"="blue", "Opposition"="orange", "Official"="red"))+
  scale_size_manual("Separate Mechanism", values = c("No" = 1, "Yes"= 2))+
  scale_shape_manual("Voting Result", values = c("Negatived"=17, "Passed"=19))+
  theme(strip.text = element_text(size = 5))+
  labs(title="Attendance and Approval of Bills and Amendments", x="Attendance Rate", y="Approval Rate")+
  facet_wrap(~subtitle)

ggsave("Bill Passing-1.png", bill_anal_1)


bill_anal_2 <- bills %>%
  filter(bill_frequency < 15, bill_frequency > 5) %>%
  ggplot (aes(x= attendance_rate, y= approval_rate, color=affiliation, shape = voting_result))+
  geom_point(size = 2)+
  scale_color_manual("Affiliation", values = c("Centrist"="green", "Government"="blue", "Opposition"="orange", "Official"="red"))+
  scale_shape_manual("Voting Result", values = c("Negatived"=17, "Passed"=19))+
  theme(strip.background = element_blank(),
        strip.text = element_text(size=3),
        aspect.ratio = 2/3)+
  labs(title="Attendance and Approval of Bills and Amendments", x="Attendance Rate", y="Approval Rate")+
  facet_wrap(~subtitle)

ggsave("Bill Passing-2.png", bill_anal_2)


bill_anal_3 <- bills %>%
  filter(bill_frequency>0) %>%
  ggplot (aes(x= attendance_rate, y= approval_rate, color=affiliation, size = separate_mechanism, shape = voting_result))+
  geom_point()+
  coord_fixed(ratio=1/2)+
  geom_smooth(method = lm)+
  scale_color_manual("Affiliation", values = c("Centrist"="green", "Government"="blue", "Opposition"="orange", "Official"="red"))+
  scale_size_manual("Separate Mechanism", values = c("No" = 1, "Yes"=2))+
  scale_shape_manual("Voting Result", values = c("Negatived"=17, "Passed"=19))+
  labs(title="Attendance and Approval of Bills and Related Amendments", x="Attendance Rate", y="Approval Rate")

ggsave("relation between approval rate and attendance rate of passing bills.png", bill_anal_3)


bill_anal_4 <- bills %>%
  filter(bill_frequency>0) %>%
  ggplot(aes(x= attendance_rate, y= approval_rate, color=affiliation, shape = voting_result))+
  geom_point()+
  labs(title="Attendance and Approval of Bills and Related Amendments (By year)", x="Attendance Rate", y="Approval Rate")+
  scale_color_manual("Affiliation", values = c("Centrist"="green", "Government"="blue", "Opposition"="orange", "Official"="red"))+
  scale_shape_manual("Voting Result", values = c("Negatived"=17, "Passed"=19))+
  geom_smooth(method= lm)+
  facet_wrap(~year)

ggsave("billanalysis4.png", bill_anal_4)


frame_edited <- frame_edited %>%
  left_join(voting_record, by=c("date", "time", "motion")) %>%
  arrange(date, time)

 
motion_anal_1 <- frame_edited %>%
  ggplot(aes(x= attendance_rate, y= approval_rate, color=affiliation, shape = voting_result))+
  geom_point()+
  coord_fixed(ratio=1/2.4)+
  labs(title="Attendance and Approval of All Motions (By year)", x="Attendance Rate", y="Approval Rate")+
  scale_color_manual("Affiliation", values = c("Centrist"="green", "Government"="blue", "Opposition"="orange", "Official"="red"))+
  scale_shape_manual("Voting Result", values = c("Negatived"=17, "Passed"=19))+
  facet_wrap(~year)

ggsave("motions by year.png", motion_anal_1)


motion_anal_2 <- frame_edited %>%
  filter(motion_type == "amendment" | motion_type == "motion" | motion_type =="resolution" | motion_type == "others") %>%
  ggplot(aes(x= attendance_rate, y= approval_rate, color=affiliation, size = separate_mechanism, shape = voting_result))+
  geom_point()+
  coord_fixed(ratio=1/2.4)+
  scale_color_manual("Affiliation", values = c("Centrist"="green", "Government"="blue", "Opposition"="orange", "Official"="red"))+
  scale_size_manual("Separate Mechanism", values = c("No" = 1, "Yes"=2.5))+
  scale_shape_manual("Voting Result", values = c("Negatived"=17, "Passed"=19))+
  labs(title="Attendance and Approval of Motions Except Bills", x="Attendance Rate", y="Approval Rate")

ggsave("motions(except bills).png", motion_anal_2)


motion_anal_3 <- frame_edited %>%
  ggplot(aes(x= attendance_rate, y= approval_rate, color=affiliation, size = separate_mechanism, shape = voting_result))+
  geom_point()+
  coord_fixed(ratio=1/2.4)+
  scale_color_manual("Affiliation", values = c("Centrist"="green", "Government"="blue", "Opposition"="orange", "Official"="red"))+
  scale_size_manual("Separate Mechanism", values = c("No" = 1, "Yes"=2.5))+
  scale_shape_manual("Voting Result", values = c("Negatived"=17, "Passed"=19))+
  labs(title="Attendance and Approval of All Motions", x="Attendance Rate", y="Approval Rate")

ggsave("motions in the 6th term.png", motion_anal_3)



motion_anal_4 <- frame_edited %>%
  filter(separate_mechanism == "No") %>%
  ggplot(aes(x= attendance_rate, y= approval_rate, color=affiliation, shape = voting_result))+
  geom_point()+
  coord_fixed(ratio=1/2.4)+
  scale_color_manual("Affiliation", values = c("Centrist"="green", "Government"="blue", "Opposition"="orange", "Official"="red"))+
  scale_shape_manual("Voting Result", values = c("Negatived"=17, "Passed"=19))+
  labs(title="Attendance and Approval of All Motions", x="Attendance Rate", y="Approval Rate")

ggsave("motions without separate mechanism.png", motion_anal_4)


write.csv(voting_record, "voting.csv")
write.csv(frame_edited, "type of motions.csv")
write.csv(bills, "bills.csv")
write.csv(frame_motion, "pure record of motions.csv")


