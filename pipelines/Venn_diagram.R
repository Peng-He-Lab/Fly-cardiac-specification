BiocManager::install("ChIPpeakAnno")
library(ChIPpeakAnno)


opa <- toGRanges("~/fly_embryo_multiome/macs2/Opa/Opa_early_peaks.narrowPeak", format="narrowPeak")
suh <- toGRanges("~/fly_embryo_multiome/macs2/SuH/SuH_early_peaks.narrowPeak", format="narrowPeak")
twi <- toGRanges("~/fly_embryo_multiome/macs2/Twi/Twi_early_peaks.narrowPeak", format="narrowPeak")

ol <- findOverlapsOfPeaks(opa, suh, twi)
makeVennDiagram(ol, NameOfPeaks = c('Opa', 'SuH', 'Twi'),
                fill=c('red', 'blue', 'yellow'))
