
library(keras)

# Check where Python's looked for
#reticulate::py_config()
#reticulate::install_miniconda()

library(decryptr)
library(decryptrModels)
args=(commandArgs(TRUE))
model <- load_model("./rfb.hdf5", labs = c(letters, 0:9))
captcha <- read_captcha(args[1])
letras <- decrypt(captcha, model)
cat(letras)
