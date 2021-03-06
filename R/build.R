#' Build a Hi-sAFe simulation or experiment
#' @description Builds a Hi-sAFe simulation or experiment (a group of simulations) - creates the folder structure and input files.
#' @return Invisibly returns a list containing the original hip object.
#' @param hip An object of class "hip". To create a hip object see \code{\link{define_hisafe}}.
#' @param files A character string of file types indicating which simulation files to build. Use "all" to write all required simulation files.
#' Otherwise, select one or more of "sim", "pld", "wth", "tree", "plt", "tec", "par", and "pro".
#' @param plot.scene Logical indicating whether \code{\link{plot_hisafe_scene}} should be used to export plots of each scene during the build.
#' @param summary.files Logical indicating whether or not to write out summary .CSV files about the experiment and each simulation during the build.
#' @param stics.diagnostics Logical indicating whether or not STICS diagnostics files should be exported in the simulation.
#' @export
#' @importFrom dplyr %>%
#' @family hisafe build functions
#' @examples
#' \dontrun{
#' # For a single Hi-sAFe simulation
#' mysim <- define_hisafe(path = "./simulations", latitude = 30)
#'
#' # Building the simulation folder structure & files:
#' build_hisafe(mysim)
#'
#' # Once a group Hi-sAFe simulations (experiment) is defined:
#' myexp <- define_hisafe(path = "./simulations", latitude = c(30,60))
#'
#' # Building the experiment folder structure & files:
#' build_hisafe(myexp)
#' }
build_hisafe <- function(hip,
                         files             = "all",
                         plot.scene        = TRUE,
                         summary.files     = TRUE,
                         stics.diagnostics = FALSE) {
  is_hip(hip, error = TRUE)
  is_TF(plot.scene)

  allowed.files <- c("sim", "pld", "wth", "tree", "plt", "tec", "par", "pro")
  if(files[1] == "all") files <- allowed.files
  if(!all(files %in% allowed.files)) stop(paste0("files argument must be 'all' or one or more of ",
                                                 paste(allowed.files, collapse = ", ")), call. = FALSE)

  EXP.PLAN <- hip$exp.plan
  dir.create(hip$path, showWarnings = FALSE, recursive = TRUE)

  if(nrow(EXP.PLAN) > 1) exp.name <- basename(hip$path)

  for(i in 1:nrow(EXP.PLAN)) {
    simu.path <- clean_path(paste0(hip$path, "/", EXP.PLAN$SimulationName[i]))
    if(dir.exists(simu.path)) stop(paste0("A simulation with the name <", EXP.PLAN$SimulationName[i], "> already exisits in this location."), call. = FALSE)
  }

  ## Write out experiment summary
  paste_together  <- function(x) unlist(purrr::map(x, paste, collapse = ";"))
  exp.plan.to.write <- dplyr::mutate_if(EXP.PLAN, is.list, paste_together)
  if(nrow(EXP.PLAN) > 1) readr::write_csv(exp.plan.to.write, clean_path(paste0(hip$path, "/", exp.name, "_exp_summary.csv")))

  ## build folder tree & input files for each simulation in experiment
  create_tibble <- function(x) {
    y <- list()
    for(i in names(x)) {
      if(length(x[[i]]) > 1){
        y[[i]] <- list(x[[i]])
      } else {
        y[[i]] <- x[[i]]
      }

    }
    return(dplyr::as_tibble(y))
  }

  hip.list <- as.list(EXP.PLAN) %>%
    purrr::pmap(list) %>%
    purrr::map(create_tibble)

  purrr::walk(hip.list,
              build_structure,
              path              = hip$path,
              profiles          = hip$profiles,
              template          = hip$template,
              files             = files,
              plot.scene        = plot.scene,
              summary.files     = summary.files,
              stics.diagnostics = stics.diagnostics)

  if(plot.scene) {
    purrr::walk2(as.list(unique(EXP.PLAN$SimulationName)),
                 as.list(clean_path(paste0(hip$path, "/", EXP.PLAN$SimulationName))),
                 plot_hisafe_scene,
                 hip = hip)
  }

  invisible(hip)
}

#' Builds the structure of a Hi-sAFe simulation
#' @description Does the heavy lifting for \code{\link{build_hisafe}}.
#' @return Invisibly returns a list containing the original hip object and supplied path.
#' @param exp.plan The exp.plan element of a "hip" object, containing a single row.
#' @param path A character string of the path to the simulation folder.
#' @param profiles A character vector of export profiles the simulation to export.
#' @param template A character string of the path to the Hi-sAFe directory structure/files to use as a template
#' (or one of the strings signaling a default template)
#' @param files A character string of file types indicating which simulation files to build. Use "all" to write all required simulation files.
#' Otherwise, select one or more of "sim", "pld", "wth", "tree", "plt", "tec", "par", and "pro".
#' @param plot.scene Logical indicating whether \code{\link{plot_hisafe_scene}} should be used to export plots of each scene during the build.
#' @param summary.files Logical indicating whether or not to write out summary .CSV files about the experiment and each simulation during the build.
#' @param stics.diagnostics Logical indicating whether or not STICS diagnostics files should be exported in the simulation.
#' @keywords internal
build_structure <- function(exp.plan, path, profiles, template, files, plot.scene, summary.files, stics.diagnostics) {

  TEMPLATE_PARAMS <- get_template_params(template)
  PARAM_NAMES     <- get_param_names(TEMPLATE_PARAMS)
  PARAM_DEFAULTS  <- get_param_vals(TEMPLATE_PARAMS, "value")
  PARAM_COMMENTED <- get_param_vals(TEMPLATE_PARAMS, "commented")

  ## Copy over folder structure & template files from Hi-sAFe template path
  ## Any newly built files below will overwrite these files
  template.dir <- clean_path(paste0(dirname(template), "/"))
  if(path == template.dir) stop("cannot build simulations within the same folder as template directory", call. = FALSE)
  copy_hisafe_template(template, path, overwrite = FALSE, new.name = exp.plan$SimulationName)
  simu.path <- clean_path(paste0(path, "/", exp.plan$SimulationName))
  if(plot.scene | summary.files) dir.create(paste0(simu.path, "/support"), showWarnings = FALSE)

  ## Write out simulation summary
  paste_together  <- function(x) unlist(purrr::map(x, paste, collapse = ";"))
  exp.plan.to.write <- dplyr::mutate_if(exp.plan, is.list, paste_together)
  if(summary.files) readr::write_csv(exp.plan.to.write, clean_path(paste0(simu.path, "/support/", exp.plan$SimulationName, "_simulation_summary.csv")))

  ## Move weather file if one was provided
  if("weatherFile" %in% names(exp.plan)) {
    dum <- file.remove(list.files(simu.path, ".wth$", full.names = TRUE))
    dum <- file.copy(exp.plan$weatherFile, simu.path)
  }

  ## Remove unused .plt files from cropSpecies
  if("mainCropSpecies" %in% names(exp.plan)){
    main.crop.used <- exp.plan$mainCropSpecies
  } else {
    main.crop.used <- PARAM_DEFAULTS$mainCropSpecies
  }
  if("interCropSpecies" %in% names(exp.plan)){
    inter.crop.used <- exp.plan$interCropSpecies
  } else {
    inter.crop.used <- PARAM_DEFAULTS$interCropSpecies
  }
  existing.plt <- list.files(paste0(simu.path, "/cropSpecies"), full.names = TRUE)
  required.plt <- paste0(simu.path, "/cropSpecies/", c(unlist(main.crop.used), unlist(inter.crop.used)))
  remove.plt   <- existing.plt[!(existing.plt %in% required.plt)]
  dum <- purrr::map(remove.plt, file.remove)

  ## Remove unused .tec files from itk
  if("mainCropItk" %in% names(exp.plan)){
    main.itk.used <- exp.plan$mainCropItk
  } else {
    main.itk.used <- PARAM_DEFAULTS$mainCropItk
  }
  if("interCropItk" %in% names(exp.plan)){
    inter.itk.used <- exp.plan$interCropItk
  } else {
    inter.itk.used <- PARAM_DEFAULTS$interCropItk
  }
  existing.itk <- list.files(paste0(simu.path, "/cropInterventions"), full.names = TRUE)
  required.itk <- paste0(simu.path, "/cropInterventions/", c(unlist(main.itk.used), unlist(inter.itk.used)))
  remove.itk   <- existing.itk[!(existing.itk %in% required.itk)]
  dum <- purrr::map(remove.itk, file.remove)

  ## Remove unused .tree files from treeSpecies
  if("tree.initialization" %in% names(exp.plan)){
    trees.used <- exp.plan$tree.initialization[[1]]$species
  } else if(PARAM_COMMENTED$tree.initialization == FALSE) {
    trees.used <- PARAM_DEFAULTS$tree.initialization[[1]]$species
  } else {
    trees.used <- NA
  }

  if(all(is.na(trees.used))) {
    num.trees <- 0
  } else {
    num.trees <- length(trees.used)
  }

  existing.tree <- list.files(paste0(simu.path, "/treeSpecies"), full.names = TRUE)
  required.tree <- paste0(simu.path, "/treeSpecies/", trees.used, ".tree")
  remove.tree   <- existing.tree[!(existing.tree %in% required.tree)]
  dum <- purrr::map(remove.tree, file.remove)

  existing.EP <- list.files(paste0(simu.path, "/exportParameters"), full.names = TRUE)
  required.EP <- paste0(simu.path, "/exportParameters/", profiles, ".pro")
  remove.EP   <- existing.EP[!(existing.EP %in% required.EP)]
  dum <- purrr::map(remove.EP, file.remove)

  ## Edit files
  params.to.edit <- names(dplyr::select(exp.plan, -SimulationName))
  sim.params.to.edit    <- params.to.edit[params.to.edit %in% PARAM_NAMES$sim]
  pld.params.to.edit    <- params.to.edit[params.to.edit %in% PARAM_NAMES$pld]
  tree.params.to.edit   <- params.to.edit[params.to.edit %in% PARAM_NAMES$tree]
  crop.params.to.edit   <- params.to.edit[params.to.edit %in% PARAM_NAMES$crop]
  tec.params.to.edit    <- params.to.edit[params.to.edit %in% PARAM_NAMES$tec]
  hisafe.params.to.edit <- params.to.edit[params.to.edit %in% PARAM_NAMES$hisafe]
  stics.params.to.edit  <- params.to.edit[params.to.edit %in% PARAM_NAMES$stics]

  ## Edit pld file
  pld.path <- list.files(simu.path, ".pld$", full.names = TRUE)
  pld      <- read_param_file(pld.path)
  pld.new  <- edit_param_file(pld, dplyr::select(exp.plan, pld.params.to.edit))
  write_param_file(pld.new, pld.path)
  dum <- file.rename(pld.path, paste0(simu.path, "/", exp.plan$SimulationName, ".pld"))

  ## Edit sim file
  sim.path <- list.files(simu.path, ".sim$", full.names = TRUE)
  sim      <- read_param_file(sim.path)
  sim.new  <- edit_param_file(sim, dplyr::select(exp.plan, sim.params.to.edit)) %>%
    edit_param_element("profileNames", paste0(c(profiles, "sti"[stics.diagnostics]), collapse = ",")) %>%
    edit_param_element("exportFrequencies", paste0(c(SUPPORTED.PROFILES$freqs[match(profiles, SUPPORTED.PROFILES$profiles)], c(1)[stics.diagnostics]), collapse = ","))
  write_param_file(sim.new, sim.path)
  dum <- file.rename(sim.path, paste0(simu.path, "/", exp.plan$SimulationName, ".sim"))

  ## Edit tree files
  tree.path <- list.files(paste0(simu.path, "/treeSpecies"), pattern = "\\.tree$", full.names = TRUE)
  for(i in tree.path) {
    tree <- read_param_file(i)
    if(length(tree.params.to.edit > 0)) {
      tree.new <- edit_param_file(tree, dplyr::select(exp.plan, tree.params.to.edit))
    } else {
      tree.new <- tree
    }
    write_param_file(tree.new, i)
  }

  ## Edit crop files
  crop.path <- list.files(paste0(simu.path, "/cropSpecies"), pattern = "\\.plt$", full.names = TRUE)
  for(i in crop.path) {
    crop <- read_param_file(i)
    if(length(crop.params.to.edit > 0)) {
      crop.new <- edit_param_file(crop, dplyr::select(exp.plan, crop.params.to.edit))
    } else {
      crop.new <- crop
    }
    write_param_file(crop.new, i)
  }

  ## Edit tec files
  tec.path <- list.files(paste0(simu.path, "/cropInterventions"), pattern = "\\.tec$", full.names = TRUE)
  for(i in tec.path) {
    tec <- read_param_file(i)
    if(length(tec.params.to.edit > 0)) {
      tec.new <- edit_param_file(tec, dplyr::select(exp.plan, tec.params.to.edit))
    } else {
      tec.new <- tec
    }
    write_param_file(tec.new, i)
  }

  ## Edit Hi-sAFe general parameters file
  hisafe.path <- paste0(simu.path, "/generalParameters/hisafe.par")
  hisafe      <- read_param_file(hisafe.path)
  hisafe.new  <- edit_param_file(hisafe, dplyr::select(exp.plan, hisafe.params.to.edit))
  write_param_file(hisafe.new, hisafe.path)

  ## Edit STICS general parameters file
  stics.path <- paste0(simu.path, "/generalParameters/stics.par")
  stics      <- read_param_file(stics.path)
  stics.new  <- edit_param_file(stics, dplyr::select(exp.plan, stics.params.to.edit))
  write_param_file(stics.new, stics.path)

  ## Delete files that are not desired
  remove_files <- function(x, y) if(!(x %in% files)) unlink(paste0(simu.path, y), recursive = TRUE)
  file.names     <- c("sim", "pld", "wth", "tree", "plt", "tec", "par", "pro")
  file.locations <- c("/*.sim", "/*.pld", "/*.wth", "/treeSpecies", "/cropSpecies",
                      "/cropInterventions", "/generalParameters", "/exportParameters")
  purrr::map2(file.names, file.locations, remove_files)

  invisible(TRUE)
}
