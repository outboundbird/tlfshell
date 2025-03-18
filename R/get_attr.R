get_attr <- function(x){
  function(name){
    attr(x, name)
  }
}

var_attr <- get_attr(var)
var_attr("n")

bmk_attr <- get_attr(bmk)

chg_attr <- get_attr(chg)
