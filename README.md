# Final-Project-Yongzhen
This project is for the final practice for the Computational Social Science, a data analysis of legislative behavior.

## Short Description
This code analysis is about the motion and voting behavior in the 6th Legislative Council of Hong Kong SAR (2016-2020). Including frequencies of raising different types of motions (motions, amendments and bills) by different years, affiliations, and topics. Also, I focus on the relation between attendance rate of voting and approval rate.

## Dependencies
R, 3.6.1
Packages: tidyverse, ggplot2, stringr, lubridate, rvest, purrr

## Files
1. Narrative.Rmd: a 12-page narrative of the project, background, coding process, and some found questions.
2. Narrative.pdf: a knitted pdf of Narrative.Rmd
3. Slides: Lightning talk slides.

## Code
1. Preprocessing 1: Data collection from the official website of the Hong Kong Legislative Council, including the date, time, movers, title of motions, and voting results. 
2. Preprocessing 2: Data collection from the wikipedia open source website about the members list of the Legislative Council and there joined parties, with extra self-coding of their affiliations. 
3. Processing Code: Data cleaning of member information and voting behavior, and catagorization of different types of motions.
4. Code of Analysis: Codes for analysing the data after processing.

## Refined and Produced Data
1. bills: Motions of Bills and related amendments, with the voting results.
2. voting: Voting results of each motion in the 6th term Legislative Council.
3. Type of motions: Edited data with attaching the information of type of motions, with 967 results; as some motions are reasonably double categorized.
4. Pure record of motions: Edited data of all motions in the 6th term of Legislative Council, with 960 results. 

## Results
affiliation_freq: frequency of motion in the legislative council, categorized by party affiliation.
party_freq: frequency of motion in the legislative council, categorized by separate parties.
motion_type: frequency of motions in the legislative council, categorized by type of bills, year, and affiliations.
Bill Passing-1: attendance and approval rates of each bill and related amendments in the 6th Legco (1).
Bill Passing-2: attendance and approval rates of each bill and related amendments in the 6th Legco (2).
billanalysis4: attendance and approval rates of bills and related amendments, categorized by year.
motions by year: attendance and approval rates of all motions, categorized by year.
frequency of amendments of bills: frequency of motion of bills and related amendments in the legislative council without categorization.
motions in the 6th term: raw graph of the attendance rate and the approval rate of all motions in the 6th Legco.
motions without separate mechanism: graph of the attendance rate and the approval rate of motions without special voting mechanism in the 6th Legco.
motions (except bills): graph of the attendance rate and the approval rate of motions (except bills) in the 6th Legco.
relation between approval rate and attendance rate of passing bills: fitted relation of attendance and approval rates of bills and related amendments.

