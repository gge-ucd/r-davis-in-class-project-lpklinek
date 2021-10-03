a = 1
a <- 1
a <- 2
letters

(number_vector = c(2, 26, 2000)) # creating a vector, concatenating a list of numbers to it
number_vector[c(2)] # indexing or subsetting the second item in the vector
number_vector = c(number_vector,54) # adding a number onto the end of the vector
number_vector = c(20, number_vector) # adding a number onto the beginning of the vector

# vector: list of values -- could be numbers or characters
# strings: list of letters?

a_string <- c("string")
b_string <- c("a", "b", "c") # need commas between string items

# data frame --> vectors in columns, an object in R 
data.frame(b_string) # putting b_string into a data frame
data.frame(a_string, b_string) #adding multiple columns


data.frame(A=a_string, B=b_string) # naming columns

test_list = list('hello') # creating the list
test_list[1] # indexing the first item in the list
test_list = c(test_list, 'hi') # adding another item to the list
df = data.frame(b_string) # creating a dataframe named df
test_list[[3]] = df # adding the new df to the list (as the third object)
test_list
