% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/interpretGeno.R
\name{test_rules_amrfp}
\alias{test_rules_amrfp}
\title{Interpret AMRFinderPlus Genotypes Using Quantitative Rules}
\usage{
test_rules_amrfp(geno_table, rules, species)
}
\arguments{
\item{geno_table}{A data frame containing AMRFinderPlus genotype output. Must include columns
\verb{Gene symbol}, \verb{Element subtype}, and \code{Name}.}

\item{rules}{A data frame of interpretation rules, typically derived from quantitative genotype-phenotype
associations. Must include columns \code{nodeID}, \code{mutation}, \code{organism}, \verb{clinical category}, and \code{phenotype}.}

\item{species}{A character string specifying the species of interest (in GTDB format, e.g 's_Escherichia coli',
see https://gtdb.ecogenomic.org/). Only rules for this species will be applied.}
}
\value{
A data frame with phenotype and clinical category calls for each strain (\code{Name}).
The result includes concatenated genotype labels and the interpretation results from applying the rules.
}
\description{
This function interprets AMRFinderPlus genotype data using a set of rules generated from quantitative data,
producing phenotype and clinical category calls for each strain. It is intended for internal validation and
exploration of rule sets derived from genotype-phenotype correlation analyses (i.e. using \code{makerules}).
It is \strong{not} suitable for line-by-line genotype annotation or for generating complete AMR reports.
}
\details{
Mutations are reformatted to match the expected format used in rule definitions.
This function assumes that rules are flat (i.e., not hierarchical). It is not compatible with manually
defined rule sets that use hierarchical \code{nodeID}s.
}
\examples{
\dontrun{
# apply the rules to generate S/I/R and wildtype/nonwildtype calls
calls <- test_rules_amrfp(geno_table = my_genotypes, rules = my_rules, species = "s_Escherichia coli")

# compare these calls to the AST data phenotypes in a separate dataframe, `pheno_table` with SIR phenotypes in `pheno`
calls_vs_pheno <- calls \%>\% left_join(pheno_table, join_by(Name==id))
calls_vs_pheno \%>\% group_by(pheno, category) \%>\% count() \%>\% filter(pheno \%in\% c("S", "I", "R")) 
}

}
\seealso{
\code{\link{convert_mutation}}, \code{\link{getCall}}
}
