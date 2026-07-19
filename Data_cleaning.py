from pyspark.sql import SparkSession
from pyspark.sql.functions import col, trim, initcap, to_date, coalesce, when

spark = (
    SparkSession.builder
    .appName("DataCleaningProject")
    .config("spark.hadoop.fs.s3a.impl","org.apache.hadoop.fs.s3a.S3AFileSystem")
    .config("spark.hadoop.fs.s3a.aws.credentials.provider",
            "com.amazonaws.auth.InstanceProfileCredentialsProvider")
    .getOrCreate()
)

def parse_multi_date(column_name):
    c = col(column_name)
    return coalesce(
        to_date(c,"yyyy-MM-dd"),
        to_date(c,"yyyy/MM/dd"),
        to_date(c,"dd-MM-yyyy"),
        to_date(c,"dd/MM/yyyy")
    )

orders_df = spark.read.option("header",True).option("inferSchema",True).csv(
    "s3a://sachin-data-cleaning-project/orders/orders_uncleaned.csv"
)
shop_df = spark.read.option("header",True).option("inferSchema",True).csv(
    "s3a://sachin-data-cleaning-project/shop/shop_uncleaned.csv"
)

orders_before=orders_df.count()
shop_before=shop_df.count()

orders_df=orders_df.dropDuplicates(["order_id"])
for c,t in orders_df.dtypes:
    if t=="string":
        orders_df=orders_df.withColumn(c,trim(col(c)))

orders_df=(orders_df
 .withColumn("city",initcap(col("city")))
 .withColumn("product_name",when(col("product_name").isNull(),"Unknown Product").otherwise(initcap(col("product_name"))))
 .withColumn("order_date",parse_multi_date("order_date"))
 .withColumn("unit_price",col("unit_price").cast("double"))
)

orders_df=orders_df.withColumn(
"reject_reason",
when(col("order_id").isNull(),"Missing Order ID")
.when(col("order_date").isNull(),"Invalid Date")
.when(col("quantity").isNull(),"Missing Quantity")
.when(col("quantity")<=0,"Invalid Quantity")
.when(col("unit_price").isNull(),"Invalid Price")
.when(col("unit_price")<=0,"Negative Price")
)

orders_invalid=orders_df.filter(col("reject_reason").isNotNull())
orders_clean=orders_df.filter(col("reject_reason").isNull()).drop("reject_reason")

shop_df=shop_df.dropDuplicates(["shop_id"])
for c,t in shop_df.dtypes:
    if t=="string":
        shop_df=shop_df.withColumn(c,trim(col(c)))

shop_df=(shop_df.fillna({
"shop_name":"Unknown Shop",
"manager_name":"Not Assigned",
"shop_category":"Unknown"})
.withColumn("city",initcap(col("city")))
.withColumn("shop_name",initcap(col("shop_name")))
.withColumn("opened_date",parse_multi_date("opened_date"))
)

shop_df=shop_df.withColumn(
"reject_reason",
when(col("shop_id").isNull(),"Missing Shop ID")
.when(col("opened_date").isNull(),"Invalid Opened Date")
)

shop_invalid=shop_df.filter(col("reject_reason").isNotNull())
shop_clean=shop_df.filter(col("reject_reason").isNull()).drop("reject_reason")

print("Orders Before:",orders_before)
print("Orders After :",orders_clean.count())
print("Orders Reject:",orders_invalid.count())
print("Shop Before  :",shop_before)
print("Shop After   :",shop_clean.count())
print("Shop Reject  :",shop_invalid.count())

orders_clean.write \
    .mode("overwrite") \
    .parquet("s3a://sachin-after-data-cleaned/orders/")

shop_clean.write \
    .mode("overwrite") \
    .parquet("s3a://sachin-after-data-cleaned/shop/")

orders_invalid.coalesce(1).write \
    .mode("overwrite") \
    .option("header", True) \
    .csv("s3a://sachin-invalid-rejected-files/sachin-orders-rejected/")

shop_invalid.coalesce(1).write \
    .mode("overwrite") \
    .option("header", True) \
    .csv("s3a://sachin-invalid-rejected-files/sachin-shop-rejected/")

print("Data Cleaning Completed Successfully")
spark.stop()
