install.packages('tidyverse')
library(tidyverse)
install.packages('tidyr')
library(tidyr)
library(MASS)
install.packages('dplyr')
library(dplyr)
dplyr::select
d = read.csv('ALL_SCORES_AND_CORS_6.22.21.csv')
colnames(d)

# Outcome measures of interest include: WAB AQ, DCT Main Ideas, DCT Details, WAIS, PPTT, WAB AV sub
d$aq_lesreg <- residuals(lm(d$aphasia_quotient ~ d$TLV))
d$dctMI_lesreg<- residuals(lm(d$dct_main_ideas_total ~ d$TLV))
d$dctD_lesreg<- residuals(lm(d$dct_details_total ~ d$TLV))
d$wais_lesreg<- residuals(lm(d$wais_score_ne ~ d$TLV))
d$pptt_lesreg <- residuals(lm(d$pyramid_palm_tree_total ~ d$TLV))
d$AV_lesreg <- residuals(lm(d$auditory_verbal_comprehension_score ~ d$TLV))

colnames(d)


eb = d %>%
  select(1,3:31, 43:48)
custom = d %>%
  select(1,19:31,33:48)

colnames(eb)


x <- lm(aq_lesreg ~ LH21_resid + LH22_resid + LH38_resid + LH35_resid + LH36_resid + LH39_resid + LH18_resid + LH19_resid, 
        data = eb)
x <- lm(aphasia_quotient ~ LH21_resid + LH22_resid + LH38_resid + LH35_resid + LH36_resid + LH39_resid + LH18_resid + LH19_resid, 
        data = eb)
x <- lm(dctMI_lesreg ~ LH21_resid + LH22_resid + LH38_resid + LH35_resid + LH36_resid + LH39_resid + LH18_resid + LH19_resid, 
        data = eb)
x <- lm(dct_main_ideas_total ~ LH21_resid + LH22_resid + LH38_resid + LH35_resid + LH36_resid + LH39_resid + LH18_resid + LH19_resid, 
        data = eb)
x <- lm(dctD_lesreg ~ LH21_resid + LH22_resid + LH38_resid + LH35_resid + LH36_resid + LH39_resid + LH18_resid + LH19_resid, 
        data = eb)
x <- lm(dct_details_total ~ LH21_resid + LH22_resid + LH38_resid + LH35_resid + LH36_resid + LH39_resid + LH18_resid + LH19_resid, 
        data = eb)
x <- lm(eb$naming_word_finding_score ~ LH21_resid + LH22_resid + LH38_resid + LH35_resid + LH36_resid + LH39_resid + LH18_resid + LH19_resid, 
        data = eb)
x <- lm(auditory_verbal_comprehension_score ~ LH21_resid + LH22_resid + LH38_resid + LH35_resid + LH36_resid + LH39_resid + LH18_resid + LH19_resid, 
        data = eb)

x <- lm(aq_lesreg ~ RH21 + RH22 + RH38 + RH35 + RH36 + RH39 + RH18 + RH19, 
        data = eb)
x <- lm(aphasia_quotient ~ RH21 + RH22 + RH38 + RH35 + RH36 + RH39 + RH18 + RH19, 
        data = eb)
x <- lm(dctMI_lesreg ~ RH21 + RH22 + RH38 + RH35 + RH36 + RH39 + RH18 + RH19, 
        data = eb)
x <- lm(dct_main_ideas_total ~ RH21 + RH22 + RH38 + RH35 + RH36 + RH39 + RH18 + RH19, 
        data = eb)
x <- lm(dctD_lesreg ~ RH21 + RH22 + RH38 + RH35 + RH36 + RH39 + RH18 + RH19, 
        data = eb)
x <- lm(dct_details_total ~ RH21 + RH22 + RH38 + RH35 + RH36 + RH39 + RH18 + RH19, 
        data = eb)
x <- lm(eb$naming_word_finding_score ~ RH21 + RH22 + RH38 + RH35 + RH36 + RH39 + RH18 + RH19, 
        data = eb)
x <- lm(auditory_verbal_comprehension_score ~ RH21 + RH22 + RH38 + RH35 + RH36 + RH39 + RH18 + RH19, 
        data = eb)

### GOING TO REPORT THE BELOW STUFF FOR DISSERTATION! USING THESE TO WRITE UP FOR SURE
colnames(custom)

x <- lm(aphasia_quotient ~ TLV + calcarineLH_STDRESID + infFrontalTriLH_STDRESID + precentralLH_STDRESID + suptempgyrLH_STDRESID, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)

summary(step.model)
custom$resid <- predict(step.model)

tiff("AQ_custom_lhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = aphasia_quotient)) +
         geom_point(cex = 3) +
        geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("WAB-AQ Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
    axis.title.x = element_text(color="black", size=14, face="bold"),
    axis.title.y = element_text(color="black", size=14, face="bold"),
    axis.text.x = element_text(face="bold", color="#993333", 
                                size=14),
     axis.text.y = element_text(face="bold", color="#993333", 
                                size=14))
dev.off()

x <- lm(dct_main_ideas_total ~ TLV+calcarineLH_STDRESID + infFrontalTriLH_STDRESID + precentralLH_STDRESID + suptempgyrLH_STDRESID, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("dctmain_custom_lhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = dct_main_ideas_total)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("DCT Main Ideas Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()

x <- lm(dct_details_total ~ TLV + calcarineLH_STDRESID + infFrontalTriLH_STDRESID + precentralLH_STDRESID + suptempgyrLH_STDRESID, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)

tiff("dctdetails_custom_lhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = dct_details_total)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("DCT Details Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()

x <- lm(auditory_verbal_comprehension_score ~ TLV + calcarineLH_STDRESID + infFrontalTriLH_STDRESID + precentralLH_STDRESID + suptempgyrLH_STDRESID, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("avcomp_custom_lhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = auditory_verbal_comprehension_score)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("WAB-AV Subscore Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()

x <- lm(aphasia_quotient ~ TLV + calcarineRH + intraparietal + rhangular + rightcerebellum + supfrontal + suptempgyr, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("aq_custom_rhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = aphasia_quotient)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("WAB-AQ Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()
x <- lm(dct_main_ideas_total ~ TLV + calcarineRH + intraparietal + rhangular + rightcerebellum + supfrontal + suptempgyr, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("dctmain_custom_rhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = dct_main_ideas_total)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("DCT Main Ideas Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()

x <- lm(dct_details_total ~ TLV + calcarineRH + intraparietal + rhangular + rightcerebellum + supfrontal + suptempgyr, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)

tiff("dctdetails_custom_rhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = dct_details_total)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("DCT Details Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()

x <- lm(auditory_verbal_comprehension_score ~ TLV + calcarineRH + intraparietal + rhangular + rightcerebellum + supfrontal + suptempgyr, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("avcomp_custom_rhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = auditory_verbal_comprehension_score)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("WAB-AV Subscore Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()


### Speech production measures that are signif
x <- lm(custom$spontaneous_speech_score ~ TLV + calcarineRH + intraparietal + rhangular + rightcerebellum + supfrontal + suptempgyr, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("ss_custom_rhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = spontaneous_speech_score)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("Spont. Speech Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()

x <- lm(custom$repetition_score ~ calcarineRH + intraparietal + rhangular + rightcerebellum + supfrontal + suptempgyr, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("rep_custom_rhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = repetition_score)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("Repetition Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()


x <- lm(repetition_score ~ TLV+ calcarineLH_STDRESID + infFrontalTriLH_STDRESID + precentralLH_STDRESID + suptempgyrLH_STDRESID, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("rep_custom_lhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = repetition_score)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("Repetition Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()

x <- lm(custom$naming_word_finding_score ~ TLV+ calcarineLH_STDRESID + infFrontalTriLH_STDRESID + precentralLH_STDRESID + suptempgyrLH_STDRESID, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("naming_custom_lhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = naming_word_finding_score)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("Naming Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()

x <- lm(naming_word_finding_score ~ TLV + calcarineRH + intraparietal + rhangular + rightcerebellum + supfrontal + suptempgyr, data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("naming_custom_rhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = naming_word_finding_score)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("Naming Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()



#### changing >90% to NA values
View(custom)
l = read.csv('ALL_SCORES_NAs6.24.21.csv')
colnames(l)
View(l)
n = l %>%
  select(1,19:31,51:54)
n$suptempgyrRESIDNA
colnames(l)

x <- lm(l$dct_details_total ~ TLV + infFrontalTriRESIDNA + precentralRESIDNA + 
          suptempgyrRESIDNA + calcarineLHRESIDNA, data = l, na.action = na.omit)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
r <- predict(step.model)
r$participant <- 
#tiff("naming_custom_rhresid.tiff", units="in", width=5, height=5, res=300)
ggplot(l, aes(x = resid, y = dct_details_total)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("DCT Details Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()

cor.test(l$dct_details_total, l$suptempgyrRESIDNA)
cor.test(l$dct_details_total, l$suptempgyrRESIDNA)
cor.test(l$dct_details_total, l$suptempgyrRESIDNA)
cor.test(l$dct_details_total, l$suptempgyrRESIDNA)

#########
##update: big model with no na values for all regions without 1.0 damage for pwa
##lm for the values with 1.0 damage (used as na values) with tlv and mpo-- framed as exploratory
colnames(custom)

x <- lm(custom$aphasia_quotient ~ TLV + MPS + precentralLH_STDRESID + calcarineLH_STDRESID +
          calcarineRH + intraparietal + rhangular + rightcerebellum + supfrontal + suptempgyr, 
        data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("BIGaq_custom_rhresid.tiff", units="in", width=5, height=5, res=300)
a<-ggplot(custom, aes(x = resid, y = aphasia_quotient)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("WAB-AQ Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()

x <- lm(custom$dct_main_ideas_total ~ TLV + MPS + precentralLH_STDRESID + calcarineLH_STDRESID +
          calcarineRH + intraparietal + rhangular + rightcerebellum + supfrontal + suptempgyr, 
        data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("BIGdctMain_custom_rhresid.tiff", units="in", width=5, height=5, res=300)
b<-ggplot(custom, aes(x = resid, y = dct_main_ideas_total)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("DCT Main Ideas Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()


x <- lm(custom$dct_details_total ~ TLV + MPS + precentralLH_STDRESID + calcarineLH_STDRESID +
          calcarineRH + intraparietal + rhangular + rightcerebellum + supfrontal + suptempgyr, 
        data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("BIGdctDetails_custom_rhresid.tiff", units="in", width=5, height=5, res=300)
c<-ggplot(custom, aes(x = resid, y = dct_details_total)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("DCT Details Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()


x <- lm(custom$auditory_verbal_comprehension_score ~ TLV + MPS + precentralLH_STDRESID + calcarineLH_STDRESID +
          calcarineRH + intraparietal + rhangular + rightcerebellum + supfrontal + suptempgyr, 
        data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("BIGavc_custom_rhresid.tiff", units="in", width=5, height=5, res=300)
d<-ggplot(custom, aes(x = resid, y = auditory_verbal_comprehension_score)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("WAB Comp. Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()

install.packages('ggpubr')
library(ggpubr)
tiff("Bigmodelplots_custom_resid.tiff", units="in", width=12, height=10, res=300)
ggarrange(a, b, c, d,  
          labels = c("A.", "B.", "C.", "D."),
          ncol = 2, nrow = 2)
dev.off()


x <- lm(custom$spontaneous_speech_score ~ TLV + MPS + precentralLH_STDRESID + calcarineLH_STDRESID +
          calcarineRH + intraparietal + rhangular + rightcerebellum + supfrontal + suptempgyr, 
        data = custom)
step.model <- stepAIC(x, direction = "both", 
                      trace = FALSE)
summary(step.model)
custom$resid <- predict(step.model)
tiff("BIGspontspeech_custom_resid.tiff", units="in", width=5, height=5, res=300)
ggplot(custom, aes(x = resid, y = spontaneous_speech_score)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("Spont. Speech Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()


colnames(l)
#### Investigating LH stg and LH IFG alone (na.omit)
stg <- l %>%
  filter(suptempgyrRESIDNA != "NA")
#WAB AQ NOT SIGNIFICANT (P=.07)
m1 <- lm(stg$aphasia_quotient ~ TLV + MPS + suptempgyrRESIDNA, data = stg)
summary(m1)
step.model <- stepAIC(m1, direction = "both", 
                      trace = FALSE)
summary(step.model)
stg$resid <- predict(step.model)
#tiff("BIGspontspeech_custom_resid.tiff", units="in", width=5, height=5, res=300)
aqs <- ggplot(stg, aes(x = resid, y = aphasia_quotient)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("WAB AQ Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))
dev.off()

m1 <- lm(stg$dct_main_ideas_total ~ TLV + MPS + suptempgyrRESIDNA, data = stg)
summary(m1)
step.model <- stepAIC(m1, direction = "both", 
                      trace = FALSE)
summary(step.model)
stg$resid <- predict(step.model)
#tiff("BIGspontspeech_custom_resid.tiff", units="in", width=5, height=5, res=300)
dctms <- ggplot(stg, aes(x = resid, y = dct_main_ideas_total)) +
  geom_point(cex = 3) +
  geom_abline(color = "darkblue", cex = 1.5) +
  ggtitle("DCT Main Ideas Actual vs Predicted Values") +
  xlab("Predicted") + ylab("Actual") +
  theme(plot.title = element_text(color="black", size=14, face="bold.italic"),
        axis.title.x = element_text(color="black", size=14, face="bold"),
        axis.title.y = element_text(color="black", size=14, face="bold"),
        axis.text.x = element_text(face="bold", color="#993333", 
                                   size=14),
        axis.text.y = element_text(face="bold", color="#993333", 
                                   size=14))

m1 <- lm(stg$dct_details_total ~ TLV + MPS + suptempgyrRESIDNA, data = stg)
summary(m1)
step.model <- stepAIC(m1, direction = "both", 
                      trace = FALSE)
summary(step.model)

m1 <- lm(stg$spontaneous_speech_score ~ TLV + MPS + suptempgyrRESIDNA, data = stg)
summary(m1)
step.model <- stepAIC(m1, direction = "both", 
                      trace = FALSE)
summary(step.model)

m1 <- lm(stg$auditory_verbal_comprehension_score ~ TLV + MPS + suptempgyrRESIDNA, data = stg)
summary(m1)
step.model <- stepAIC(m1, direction = "both", 
                      trace = FALSE)
summary(step.model)


m1 <- lm(stg$wais_score_ne ~ TLV + MPS + suptempgyrRESIDNA, data = stg)
summary(m1)
step.model <- stepAIC(m1, direction = "both", 
                      trace = FALSE)
summary(step.model)

install.packages('ggpubr')
library(ggpubr)
tiff("lhSTGplots_custom_resid.tiff", units="in", width=12, height=5, res=300)
ggarrange(aqs, dctms, 
          labels = c("A.", "B."),
          ncol = 2, nrow = 1)
dev.off()

l$infFrontalTriRESIDNA
### IFG now
ifg <- l %>%
  filter(infFrontalTriRESIDNA != "NA")
m1 <- lm(ifg$aphasia_quotient ~ TLV + MPS + infFrontalTriRESIDNA, data = ifg)
summary(m1)
step.model <- stepAIC(m1, direction = "both", 
                      trace = FALSE)
summary(step.model)

m1 <- lm(ifg$dct_main_ideas_total ~ TLV + MPS + infFrontalTriRESIDNA, data = ifg)
summary(m1)
step.model <- stepAIC(m1, direction = "both", 
                      trace = FALSE)
summary(step.model)


m1 <- lm(ifg$dct_details_total ~ TLV + MPS + infFrontalTriRESIDNA, data = ifg)
summary(m1)
step.model <- stepAIC(m1, direction = "both", 
                      trace = FALSE)
summary(step.model)

m1 <- lm(ifg$repetition_score ~ TLV + MPS + infFrontalTriRESIDNA, data = ifg)
summary(m1)
step.model <- stepAIC(m1, direction = "both", 
                      trace = FALSE)
summary(step.model)


#####Whole brain ttest between groups
t <- read.csv("ttest_wholebrain_controlsvspwa.csv")
t_c <- t %>%
  filter(group ==2)
t_a <- t %>%
  filter(group ==1)

r = t.test(t_c$largerisc, t_a$largerisc)
summary(r)
r
