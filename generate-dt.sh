RED='\033[0;31m'
printf "${RED} Make sure you have replace utils/api.json from Swagger /v2/api-docs"

spectacle --disable-js --target-dir tmp utils/api.json > /dev/null 2>&1
wkhtmltopdf tmp/index.html api.pdf > /dev/null 2>&1

echo 'Input range of pages you want to separate form api.pdf'
read -p 'First Page ' firstPage
read -p 'Last Page ' lastPage
mkdir tmpPdf
pdfseparate -f $1 -l $2 api.pdf tmpPdf/page%d.pdf

pdfunite tmpPdf/* tmpPdf/DT_API.pdf > /dev/null 2>&1

read -p 'Name of project: ' projectName
pdfunite utils/DT_COVER.pdf tmpPdf/DT_API.pdf DT.DT.APP.IMEDIADOR-${projectName}.pdf > /dev/null 2>&1

rm -rf api.pdf
rm -rf tmp
rm -rf tmpPdf