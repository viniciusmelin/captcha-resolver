
library(keras)


# Check where Python's looked for
# reticulate::py_config()

library(decryptr)
library(decryptrModels)
args = commandArgs(trailingOnly=TRUE)
model <- load_model("./bradesco.hdf5", labs = c(letters, 0:9))
captcha <- read_captcha('./download.png')
letras = decrypt(captcha, model)
cat(letras)

