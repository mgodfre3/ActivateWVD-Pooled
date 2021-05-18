//Define Azure Files parmeters
param storageaccountlocation string = resourceGroup().location
param storageaccountName string
param storageaccountkind string

@allowed([
'Premium_LRS'
'Premium_ZRS'
])
param storgeaccountglobalRedundancy string = 'Premium_ZRS'
param fileshareFolderName string = 'profilecontainers'

//Concat FileShare
var filesharelocation = '${sa.name}/default/${fileshareFolderName}'

//Create Storage account
resource sa 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
  name : storageaccountName
  location : storageaccountlocation
  kind : storageaccountkind
  sku: {
    name: storgeaccountglobalRedundancy
  }
}

//Create FileShare
resource fs 'Microsoft.Storage/storageAccounts/fileServices/shares@2020-08-01-preview' = {
  name :  filesharelocation
}
