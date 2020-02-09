l1 = c("a", "b", "c")
l2 = c(1,2,3)
df = data.frame("col1" = l1, "col2" = l2)
# can put this in here
#
vectors <- I(list(c(1,2,3,4,5), c(4,5,6), c(7,8,9)))
df$new <- vectors
