gid_to_coords <- function(gid){
  # returns coords from gid in gid format
  # x, y where south west is 1, 1
  # again complicated by stupid prio not following standard matrix notation
  gid <- gid - 1
  y <- gid %/% 720
  x <- gid %% 720
  x <- x + 1
  y <- y + 1
  return(c(x, y))
}

coords_to_gid <- function(coords){
  # takes coords and turns into gid
  return(coords[1] + (coords[2]-1)*720)
}

enforce_periodic_boundaries <- function(gid){
  coords <- gid_to_coords(gid)
  coords <- periodic_boundary_conditions(coords)
  gid <- coords_to_gid(coords)
  return(gid)
}

periodic_boundary_conditions <- function(coords){
  # enforces periodic boundary conditions
  # TODO: double check this
  if (coords[1] > 720){
    coords[1] <- coords[1] - 720
  }
  if (coords[1] < 1){
    coords[1] <- coords[1] + 720
  }
  if (coords[2] > 360){
    coords[2] <- coords[2] - 360
  }
  if (coords[2] < 1){
    coords[2] <- coords[2] + 360
  }
  return(coords)
}


border_overlap_check <- function(gid, order){
  # can be either close on top bottom, or left right, or both. 
  # grid is 720 lengthwise
  # 360 height 
  # bottom left is origin (this is a genuinely awful idea)
  
}

h_bound_check <- function(gid, bounds){
  # enforces periodic boundary conditions on the lags.
  coords <- gid_to_coords(gid)
  x_coords <- coords[1] + bounds
  
}

lag_neighbours <- function(gid, order){
  # function to find list of gids included in lag.
  # at current we remove all negative indices
  # THIS MEANS THAT OVERLAPS ARE NOT CONSIDERED BY DEFINITION i.e edge cases where adjaceny could be between 1 and 720
  # are not considered.
  d <- 2 * order + 1
  # First check if lag will overlap with border
  
  
  horizontal_bounds <- c(-order : order)
  
  vertical_bounds <- seq(-order * 720 , 720 * order, by = 720) # for increments of prio grid size.
  mesh = meshgrid(horizontal_bounds, vertical_bounds)
  # print(mesh$x)
  # print(mesh$y)
  ans <- c(gid + mesh$x + mesh$y) # turns into list
  for (i in 1:length(ans)){
    ans[i] <- enforce_periodic_boundaries(ans[i]) # enforces boundary conditions and corrects - makes periodic. 
  }
  # remove the center gid - do not include in the lag.
  ans <- ans[ans != gid]
  return(ans)
}
