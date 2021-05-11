library(rvest)

gscholar_link <- "https://scholar.google.co.uk/citations?user=EZhKKaYAAAAJ&hl=en"
readme_loc <- "README.md"

citations <- read_html(gscholar_link) %>%
  html_nodes("#gsc_rsb_st") %>%
  .[[1]] %>%
  html_table() %>%
  .[1, "All"]

# Download images in advance so we don't rely on img.shields.io at rendering time.
imgs <- list(
  cv = "https://img.shields.io/badge/CV--_.svg?style=social&logo=giphy",
  github = "https://img.shields.io/github/followers/rcallagh.svg?label=GitHub&style=social",
  twitter = "https://img.shields.io/twitter/follow/RossCallaghan?label=Twitter&style=social",
  citations = sprintf("https://img.shields.io/badge/Citations-%s-_.svg?style=social&logo=google-scholar", round(citations, digits = 1))
)

for (i in 1:length(imgs)) {
  download.file(imgs[[i]], sprintf('imgs/%s.svg', names(imgs)[[i]]), mode = 'wb')
}
