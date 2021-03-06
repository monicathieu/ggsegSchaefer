## setup ----

source(here::here("data-raw", "setup.R"))

## make ggseg3d atlas ----

schaefer7_1000_3d <- make_schaefer_3d(7, 1000)

schaefer7_1000_3d <- schaefer7_1000_3d %>%
  tidyr::unnest(ggseg_3d) %>%
  as_tibble() %>%
  mutate(
    region = gsub("17Networks_|RH_|LH_", "", region),
    region = ifelse(grepl("Background", region), NA, region)
  ) %>%
  ggseg3d::as_ggseg3d_atlas()

schaefer7_1000 <- make_ggseg3d_2_ggseg(schaefer7_1000_3d,
                                      steps = 6:7,
                                      tolerance = .8,
                                      output_dir = "~/Desktop/")
plot(schaefer7_1000, show.legend = FALSE)

## write out ----
usethis::use_data(schaefer7_1000_3d,
                  schaefer7_1000,
                  overwrite = TRUE)
