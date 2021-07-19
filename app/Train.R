library(keras)
library(decryptr)

captchas <- list.files("captchas/", full.names = TRUE, pattern = ".*png") %>%
  read_captcha(ans_in_path = TRUE, vocab = c(letters, 0:9)) %>%
  join_captchas()

set.seed(902192)
i <- sample.int(captchas$n, 10000)

train <- list(y = captchas$y[i,,,drop = FALSE], x = captchas$x[i,,,,drop = FALSE])
test <- list(y = captchas$y[-i,,,drop = FALSE], x = captchas$x[-i,,,,drop = FALSE])

model <- keras_model_sequential()
model %>%
  layer_conv_2d(
    input_shape = dim(train$x)[-1],
    filters = 16,
    kernel_size = c(5, 5),
    padding = "same",
    activation = "relu") %>%
  layer_max_pooling_2d() %>%
  layer_conv_2d(
    filters = 32,
    kernel_size = c(5, 5),
    padding = "same",
    activation = "relu") %>%
  layer_max_pooling_2d() %>%
  layer_conv_2d(
    filters = 64,
    kernel_size = c(5, 5),
    padding = "same",
    activation = "relu") %>%
  layer_max_pooling_2d() %>%
  layer_flatten() %>%
  layer_dense(units = 256) %>%
  layer_dropout(.1) %>%
  layer_dense(units = prod(dim(train$y)[-1])) %>%
  layer_reshape(target_shape = dim(train$y)[-1]) %>%
  layer_activation("softmax")


model %>%
  compile(
    optimizer = "adam",
    loss = "categorical_crossentropy",
    metrics = "accuracy")

model %>%
  fit(
    x = train$x,
    y = train$y,
    batch_size = 32,
    epochs = 20,
    shuffle = TRUE,
    validation_data = list(test$x, test$y)
  )

save_model_hdf5(model, "bradesco.hdf5")

