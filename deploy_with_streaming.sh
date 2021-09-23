DATAFLOW_PROJECT="pristine-dahlia-326810"
BQ_PROJECT="pristine-dahlia-326810"
BQ_DATASET="library_app_dataset"
PUBSUB_PROJECT="pristine-dahlia-326810"
PUBSUB_SUBSCRIBTION="library_app_subscription"
REGION="us-central1"
BUCKET="library_app_bucket"
SA_FILE="$PWD/sa_key.json"
SA_ACCOUNT="dataflow-pipeline@pristine-dahlia-326810.iam.gserviceaccount.com"
JOB_NAME="dataflow-libraryapp-job"
MAX_WORKERS=1
WORKER_MACHINE_TYPE="n1-standard-2"

TEMP_LOCATION="gs://$BUCKET/tmp/"
STAGING_LOCATION="gs://$BUCKET/staging/"

ARGS="--runner=$1 
--tempLocation=$TEMP_LOCATION 
--stagingLocation=$STAGING_LOCATION 
--region=$REGION 
--enableStreamingEngine 
--numWorkers=1
--jobName=$JOB_NAME
--usePublicIps=false
--maxNumWorkers=$MAX_WORKERS
--autoscalingAlgorithm=THROUGHPUT_BASED
--project=$DATAFLOW_PROJECT 
--BQProject=$BQ_PROJECT 
--BQDataset=$BQ_DATASET 
--pubSubProject=$PUBSUB_PROJECT 
--subscription=$PUBSUB_SUBSCRIBTION
--bucket=$BUCKET
--serviceAccount=$SA_ACCOUNT
--streaming=true
--workerMachineType=$WORKER_MACHINE_TYPE"

echo $ARGS

if [ ! -f "$SA_FILE" ]; then
    echo "$SA_FILE does not exist."
    exit
fi

export GOOGLE_APPLICATION_CREDENTIALS=$SA_FILE
echo $GOOGLE_APPLICATION_CREDENTIALS

echo ./gradlew clean run -Pargs="$ARGS"

./gradlew clean run -Pargs="$ARGS"

unset GOOGLE_APPLICATION_CREDENTIALS