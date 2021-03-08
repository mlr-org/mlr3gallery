FROM trestletech/plumber

RUN R -e 'install.packages(c("data.table", "mlr3", "mlr3misc", "mlr3pipelines"))'

RUN mkdir /data
COPY gl.rds /data
COPY feature_info.rds /data
COPY fix_feature_types.R /data
COPY predict_gl.R /data
WORKDIR /data

EXPOSE 1030
ENTRYPOINT ["R", "-e", \
    "r = plumber::plumb('/data/predict_gl.R'); r$run(port = 1030, host = '0.0.0.0')"]
