function rangeDopplerDFTmtx = RangeDopplerDFT(ADCdata2d, Fr, Fd)
    rangeDopplerDFTmtx = Fr * ADCdata2d * transpose(Fd);    
end