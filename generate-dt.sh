RED='\033[0;31m'
NC='\033[0m' # No Color
printf "${RED} Make sure you have replace utils/api.json from Swagger /v2/api-docs\n"

spectacle --disable-js --target-dir tmp utils/api.json > /dev/null 2>&1
wkhtmltopdf tmp/index.html api.pdf > /dev/null 2>&1

printf "${NC} Input range of pages you want to separate from api.pdf\n"
read -p 'First Page ' firstPage
read -p 'Last Page ' lastPage
mkdir tmpPdf
pdfseparate -f $firstPage -l $lastPage api.pdf tmpPdf/page%d.pdf

pdfunite tmpPdf/* tmpPdf/DT_API.pdf > /dev/null 2>&1

read -p 'Name of project: ' projectName
pdfunite utils/DT_COVER.pdf tmpPdf/DT_API.pdf DT.DT.APP.IMEDIADOR-${projectName}.pdf > /dev/null 2>&1

rm -rf api.pdf
rm -rf tmp
rm -rf tmpPdf