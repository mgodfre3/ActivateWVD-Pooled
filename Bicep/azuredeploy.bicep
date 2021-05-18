

//Parameters
param location string=resourceGroup().location
param nameprefix string='ActivateWVD_'

//Define Azure Files deployment parameters
param storageaccountlocation string = resourceGroup().location

@minLength(3)
@maxLength(14)
param storageaccountName string = 'activatewvdsa'

param storageaccountkind string = 'FileStorage'
param storageaccountglobalRedundancy string = 'Premium_ZRS'
param fileshareFolderName string = 'profilecontainers'


//Define WVD deployment parameters
param hostpoolName string = 'ActivateWVD_SHP'
param hostpoolFriendlyName string = 'ActivateWVD-HostPool'
param appgroupName string = 'ActivateWVD-AppGroup'
param appgroupNameFriendlyName string = 'ActivateWVD-AppGroup'
param workspaceName string = 'ActivateWVD'
param workspaceNameFriendlyName string = 'ActivateWVD'
param preferredAppGroupType string = 'Desktop'
param wvdbackplanelocation string = 'EastUS2'
param hostPoolType string = 'pooled'
param loadBalancerType string = 'BreadthFirst'
param logAnalyticsWorkspaceName string = 'ActivateWVD-LAW'
param logAnalyticsWorkspaceSku string = ''
param logAnalyticsResourceGroup string = resourceGroup().name
param logAnalyticslocation string = resourceGroup().location


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
    storgeaccountglobalRedundancy : storageaccountglobalRedundancy
    fileshareFolderName : fileshareFolderName
  }
}

//Create Azure Log Analytics Workspace
module wvdmonitor 'Modules/DeployLogAnalytics.bicep' = {
  name : 'LAWorkspace'
  params: {
    logAnalyticsWorkspaceName : logAnalyticsWorkspaceName
    logAnalyticslocation : logAnalyticslocation
    logAnalyticsWorkspaceSku : logAnalyticsWorkspaceSku
    logAnalyticsResourceGroup : logAnalyticsResourceGroup
    hostpoolName:hostpoolName
    workspaceName:workspaceName
  }
}
