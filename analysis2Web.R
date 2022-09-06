orddf = read.csv("web_df.csv", sep = ';',  fileEncoding="UTF-8-BOM", head = TRUE)
View(orddf)

needed_columns <-c(2, 4, 18)
orders_df_clean <- orddf[needed_columns]