#' Model Class Evaluation
#'
#' Provides n and frequency of each class and post prob of classes.
#' Also plots the model results using lcplot function
#' @param df data frame used to produce model. lcpred output
#' @param model lcmem output to evaluate
#' @param age string of age variable
#' @param ... arguments to base plots (eg. main = "Title")
#' @return kable output providing class analysis and plot output
#' @export


keval <- function(df, model, age, ...){
  sub <- paste0("k = ", model$parameters$k, "; Random = ", model$parameters$random,
                "; idiag = ", model$parameters$idiag, "; nwg = ", model$parameters$nwg)
  lcplot(df = df,
         model = model$model,
         age = age,
         sub = sub,
         ...)
  print(kableExtra::kable(ksum(model$model),caption = sub) %>%
          kableExtra::kable_styling("striped", full_width = F))
}

#' Model Class Evaluation for Each Model in List
#'
#' Provides n and frequency of each class and post prob of classes.
#' Also plots the model results using lcplot function
#' @param df data frame used to produce model. lcpred output
#' @param model_list List of lcmem output to evaluate
#' @param age string of age variable
#' @param ... arguments to base plots (eg. main = "Title")
#' @return kable output providing class analysis and plot output
#' @note if you are using RMarkdown and want to output the kable output to html set
#'   resutls = "asis"
#' @details each plot and table will be accompanied by default by a string specifying k, random, idiag, and nwg
#'   to identify each model
#' @export


keval_apply <- function(df, model_list, age, ...){
  for(i in 1:length(model_list)){
    sub <- paste0("Model Number = ", i, "; k = ", model_list[[i]]$parameters$k, "; Random = ", model_list[[i]]$parameters$random,
                  "; idiag = ", model_list[[i]]$parameters$idiag, "; nwg = ", model_list[[i]]$parameters$nwg)
    lcplot(df = df,
           model = model_list[[i]]$model,
           age = age,
           sub = sub,
           ...)
    print(kableExtra::kable(ksum(model_list[[i]]$model),caption = sub) %>%
            kableExtra::kable_styling("striped", full_width = F))
  }
}


#' Model Class Evaluation Table
#'
#' Creates Dataframe evaluating each class of an hlme model
#' @param model hlme model object
#' @return data frame with mean of post probability values, n, frequency.
#' @export


ksum <- function(model){
  n <- NULL
  mopp <- model$pprob
  mopp_sum <- mopp %>%
    dplyr::group_by(class) %>%
    dplyr::summarise(n = dplyr::n(), dplyr::across(dplyr::starts_with("prob"), ~round(mean(.x), digits = 4))) %>%
    dplyr::mutate(freq = n/sum(n))
  return(mopp_sum)
}
