# Global HLA class I frequencies and predicted binding affinities to HIV peptides

The visualizations and data showcased in this app are an effort to present and summarize the interaction between the Human Leucocyte Antigen (HLA) class I alleles and HIV viral subtypes.

We provide our results on imputed HLA alleles and their predicted binding affinity to HIV peptides as represented in the global START cohort from the [INSIGHT Consortium](http://insight.ccbr.umn.edu/).

## Reference
If you use any of the results or data in this web application please cite the corresponding article:

Zucco, A.G. et al. (2022). Associations of functional HLA class I nodes to HIV viral load in a heterogeneous cohort. Unpublished manuscript.

**Abstract:**

> Human Leucocyte Antigen (HLA) class I alleles are the main host genetic factors involved in the control of HIV-1 viral load (VL) but HLA genetic and geographical diversity have challenged association studies. We used machine learning methods on host genetic data (2,546 HIV+ participants) from a heterogeneous cohort to impute HLA alleles and predict immunopeptidomes. Binding affinities of HLA to HIV peptide k-mers derived from 2,079 samples of host-paired viral genomes ascertained by targeted amplicon sequencing were predicted. These immunopeptidomes were used to functionally group HLA alleles by their propensity to bind similar HIV-derived peptides using consensus clustering. We tested associations of these groups to VL, identifying four functional clades of 30 HLA alleles accounting for 11.4% variability in VL. The results demonstrate that HLA functionality is distributed continuously across geographies while allele frequencies are not. Hence, projection of HLA genotypes to functional space allows for the study of the HLA system in heterogeneous cohorts prone to genotypic sparsity. We highlight the utility of this method as a common resource even in studies without paired host-viral genetics by showing only a slight power reduction when employing synthetic immunopeptidomes. The outlined computational approach provides a robust and efficient way to incorporate HLA function and peptide diversity from sequencing data facilitating clinical association studies with diverse cohorts.

## Data Sources

To facilitate open-access to our results and non-sensitive data please visit [Downloads].
The raw data of this project correspond to patients living with HIV hence the need for confidentiality. Access to the [START trial](http://insight.ccbr.umn.edu/start/) data can be requested to the [INSIGHT Consortium](http://insight.ccbr.umn.edu/). This project has been conducted as a collaboration between INSIGHT and the Centre of Excellence for Personalised Medicine of Infectious complications in immune deficiency ([PERSIMUNE](http://www.persimune.dk/)).

## License

This work is completely free and open for academic use and furthering research in human immunology and infectious disease; provided full attribution is given.

## Acknowledgments

We would like to thank all participants in the START trial and all trial investigators. See [N Engl J Med 2015; 373:795–807(20)](https://www.nejm.org/doi/full/10.1056/nejmoa1506816) for the complete list of START investigators. 

Many thanks to the authors and maintainers of all of the R packages used to make this app. A great thanks goes to Sean Angiolillo who wrote the original code and from whom this project was forked (see the original blog post [here](https://blog.socialcops.com/technology/data-science/comparative-thematic-mapping/)).
