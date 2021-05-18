//Parameters
param location string=resourceGroup().location
param nameprefix string='ActivateWVD_'

//Define Azure Files deployment parameters
param storageaccountlocation string = resourceGroup().location

@minLength(3)
@maxLength(11)
param storagePrefix string='SA'
param storageaccountName string = '${nameprefix}${storagePrefix}'

param storageaccountkind string = 'FileStorage'
param storgeaccountglobalRedundancy string = 'Premium_ZRS'
param fileshareFolderName string = 'profilecontainers'


//Create Virtual Network for WVD Pools
module stg 'Modules/CreateVNet.bicep'={
name:'CreatevNet'
}



//Create WVD Azure File Services and FileShare`
module wvdFileServices 'Modules/CreateStorage.bicep'  = {
  name: 'wvdFileServices'
  params: {
    storageaccountlocation : storageaccountlocation
    storageaccountName : storageaccountName
    storageaccountkind : storageaccountkind
    storgeaccountglobalRedundancy : storgeaccountglobalRedundancy
    fileshareFolderName : fileshareFolderName
  }
}
