<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->
<#assign searchOptionsHistoryList = Static["org.ofbiz.product.product.ProductSearchSession"].getSearchOptionsHistoryList(session)/>
<#assign currentCatalogId = Static["org.ofbiz.product.catalog.CatalogWorker"].getCurrentCatalogId(request)/>

<#assign categoryName = categoryContentWrapper.get("CATEGORY_NAME")!/>
<#assign categoryDescription = categoryContentWrapper.get("DESCRIPTION")!/>


<div class="box text-center">
    <#if categoryName?has_content>
        <h3 class="text-uppercase">${categoryName}</h3>
    </#if>
    <#if categoryDescription?has_content>           
        <h4 class="text-muted">${categoryDescription}</h4>
    </#if>
    <#if longDescription?has_content>
        <p class="text-muted">${longDescription}</p>
    </#if>              
</div>    


<div class="row">
    <div class="col-md-3 col-xs-12" id="sidebar" >
        
        <@advancesearchform />
        
        
        <#if searchConstraintStrings?has_content>
            <div class="box">
                <h4>${uiLabelMap.ProductLastSearch}</h4>
                <p class="text-muted">${uiLabelMap.ProductSortedBy}: ${searchSortOrderString}</p>        
                <#list searchConstraintStrings as searchConstraintString>
                    <div>${searchConstraintString}</div>
                </#list>                        
            </div>
        </#if>
        
        
    </div><!-- ./sidebar -->
    
    <div class="col-md-9 col-xs-12" id="categorycontent">
    
        <@searchhistory />
        
    </div><!-- ./categorycontent -->
</div>

<#macro advancesearchform >
    <form name="advtokeywordsearchform" method="post" action="<@ofbizUrl>keywordsearch</@ofbizUrl>">
        <input type="hidden" name="VIEW_SIZE" value="10"/>
        <input type="hidden" name="PAGING" value="Y"/>
        <input type="hidden" name="SEARCH_CATALOG_ID" value="${currentCatalogId}" />

        <div class="form-group">
            <label>${uiLabelMap.ProductKeywords}</label>
            <input type="text" name="SEARCH_STRING" size="32" value="${requestParameters.SEARCH_STRING!}" class="form-control" />                        
        </div>

        <div class="form-group">
            <label class="radio-inline">
                <input type="radio" name="SEARCH_OPERATOR" value="OR" <#if searchOperator == "OR">checked="checked"</#if> />
                ${uiLabelMap.CommonAny}
            </label>
            <label class="radio-inline">
                <input type="radio" name="SEARCH_OPERATOR" value="AND" <#if searchOperator == "AND">checked="checked"</#if> />
                ${uiLabelMap.CommonAll}
            </label>
        </div>          
        <#if searchCategory?has_content>
            <input type="hidden" name="SEARCH_CATEGORY_ID" value="${searchCategoryId!}"/>
            <div class="form-group">
                <label>${uiLabelMap.ProductIncludeSubCategories}</label>
                <div>
                    <label class="radio-inline">
                        <input type="radio" name="SEARCH_SUB_CATEGORIES" value="Y" checked="checked"/>
                        ${uiLabelMap.CommonYes}
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="SEARCH_SUB_CATEGORIES" value="N"/>
                        ${uiLabelMap.CommonNo} 
                    </label>
                </div>            
            </div>
        </#if>
        <#list productFeatureTypeIdsOrdered as productFeatureTypeId>
            <#assign findPftMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("productFeatureTypeId", productFeatureTypeId)>
            <#assign productFeatureType = delegator.findOne("ProductFeatureType", findPftMap, true)>
            <#assign productFeatures = productFeaturesByTypeMap[productFeatureTypeId]>
            <div class="form-group">
                <label>${(productFeatureType.get("description",locale))!}</label>
                
	            <select name="pft_${productFeatureTypeId}" class="form-control">
                    <option value="">- ${uiLabelMap.CommonSelectAny} -</option>
                    <#list productFeatures as productFeature>
                        <option value="${productFeature.productFeatureId}">${productFeature.description?default(productFeature.productFeatureId)}</option>
                    </#list>
	            </select>        
            </div>
        </#list>
        <div class="form-group">
            <label>${uiLabelMap.ProductSortedBy}</label>
      
            <select name="sortOrder" class="form-control">
                <option value="SortKeywordRelevancy">${uiLabelMap.ProductKeywordRelevancy}</option>
	            <option value="SortProductField:productName">${uiLabelMap.ProductProductName}</option>
	            <option value="SortProductField:totalQuantityOrdered">${uiLabelMap.ProductPopularityByOrders}</option>
	            <option value="SortProductField:totalTimesViewed">${uiLabelMap.ProductPopularityByViews}</option>
	            <option value="SortProductField:averageCustomerRating">${uiLabelMap.ProductCustomerRating}</option>
	            <option value="SortProductPrice:LIST_PRICE">${uiLabelMap.ProductListPrice}</option>
	            <option value="SortProductPrice:DEFAULT_PRICE">${uiLabelMap.ProductDefaultPrice}</option>
                <#if productFeatureTypes?? && productFeatureTypes?has_content>
                    <#list productFeatureTypes as productFeatureType>
                        <option value="SortProductFeature:${productFeatureType.productFeatureTypeId}">${productFeatureType.description?default(productFeatureType.productFeatureTypeId)}</option>
                    </#list>
                </#if>
            </select>
        </div>
        <div class="form-group">            
            <div>
	            <label class="radio-inline">
	                <input type="radio" name="sortAscending" value="Y" checked="checked"/>
	                ${uiLabelMap.EcommerceLowToHigh} 
	            </label>
	            <label class="radio-inline">
	                <input type="radio" name="sortAscending" value="N"/>
	                 ${uiLabelMap.EcommerceHighToLow}
	            </label>
            </div>
        </div>
        <div class="form-group">            
            <div>
                <label class="radio-inline">
                    <input type="radio" name="clearSearch" value="Y" checked="checked"/>
                     ${uiLabelMap.ProductNewSearch}
                </label>
                <label class="radio-inline">
                    <input type="radio" name="clearSearch" value="N"/>
                     ${uiLabelMap.CommonRefineSearch}
                </label>                    
            </div>            
        </div>        
        <div class="form-group">
      
            <a href="javascript:document.advtokeywordsearchform.submit()" class="btn btn-default btn-block">${uiLabelMap.CommonFind}</a>
        </div>
    </form>
</#macro>


<#macro searchhistory >
    <#if searchOptionsHistoryList?has_content>
    

        <h3>${uiLabelMap.OrderLastSearches}...
	        <span class="pull-right">
	            <a href="<@ofbizUrl>clearSearchOptionsHistoryList</@ofbizUrl>" class="btn btn-default">${uiLabelMap.OrderClearSearchHistory}</a>	            
	        </span>
        </h3>        
    <#list searchOptionsHistoryList as searchOptions>
        <#-- searchOptions type is ProductSearchSession.ProductSearchOptions -->
        <div class="box">
            <h6>${uiLabelMap.EcommerceSearchNumber}${searchOptions_index + 1}
                <a href="<@ofbizUrl>setCurrentSearchFromHistoryAndSearch?searchHistoryIndex=${searchOptions_index}&amp;clearSearch=N</@ofbizUrl>" class="btn btn-link">${uiLabelMap.CommonSearch}</a>
                <a href="<@ofbizUrl>setCurrentSearchFromHistory?searchHistoryIndex=${searchOptions_index}</@ofbizUrl>" class="btn btn-link">${uiLabelMap.CommonRefine}</a>
            </h6>
        
            <#assign constraintStrings = searchOptions.searchGetConstraintStrings(false, delegator, locale)>
            <#list constraintStrings as constraintString>
                <div>&nbsp;-&nbsp;${constraintString}</div>
            </#list>
            <#if searchOptions_has_next>
          
            </#if>
        </div>
    </#list>
  </#if>
</#macro>