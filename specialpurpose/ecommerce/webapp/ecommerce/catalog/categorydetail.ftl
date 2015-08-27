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

<script type="text/javascript">
	function loadCategory(id, parentCategoryStr) {
	    var checkUrl = '<@ofbizUrl>productCategoryList</@ofbizUrl>';
        if(checkUrl.search("http"))
            var ajaxUrl = '<@ofbizUrl>productCategoryList</@ofbizUrl>';
        else
            var ajaxUrl = '<@ofbizUrl>productCategoryListSecure</@ofbizUrl>';

	    //jQuerry Ajax Request
	    jQuery.ajax({
	        url: ajaxUrl,
	        type: 'POST',
	        data: {"category_id" : id, "parentCategoryStr" : parentCategoryStr},
	        error: function(msg) {
	            alert("An error occured loading content! : " + msg);
	        },
	        
	        beforeSend: function() {
	            $('#loading').show();
	        },
	        
	        
	        success: function(msg) {
	            jQuery('#categoryview').html(msg);
	        }
	    });
	 }
	
	
	function loadCategoryByPaginate(info) {
	    var str = info.split('~');
	    var checkUrl = '<@ofbizUrl>categoryAjaxFired</@ofbizUrl>';
	    if(checkUrl.search("http"))
	        var ajaxUrl = '<@ofbizUrl>categoryAjaxFired</@ofbizUrl>';
	    else
	        var ajaxUrl = '<@ofbizUrl>categoryAjaxFiredSecure</@ofbizUrl>';
	        
	    //jQuerry Ajax Request
	    jQuery.ajax({
	        url: ajaxUrl,
	        type: 'POST',
	        data: {"category_id" : str[0], "VIEW_SIZE" : str[1], "VIEW_INDEX" : str[2]},
	        error: function(msg) {
	            alert("An error occurred loading content! : " + msg);
	        },
	        success: function(msg) {
	            jQuery('#categorycontent').html(msg);
	        }
	    });
	}
</script>

<#if productCategory??>
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
        <div id="loading">
		    <img class="loading" src='/images/ajax_loader_orange_64.gif' />    
		</div>   
    </div>    


    <#if showsidebar?default("Y") == "Y"> 
	    <div class="row">
	        <div class="col-md-3 col-xs-12" id="sidebar" >

	            ${screens.render("component://ecommerce/widget/CatalogScreens.xml#sidedeepcategory")}
                   
	            <#if hasQuantities??>
	                <form method="post" action="<@ofbizUrl>addCategoryDefaults<#if requestAttributes._CURRENT_VIEW_??>/${requestAttributes._CURRENT_VIEW_}</#if></@ofbizUrl>" name="thecategoryform" style='margin: 0;'>
	                    <input type='hidden' name='add_category_id' value='${productCategory.productCategoryId}'/>
	                    <#if requestParameters.product_id??><input type='hidden' name='product_id' value='${requestParameters.product_id}'/></#if>
				        <#if requestParameters.category_id??><input type='hidden' name='category_id' value='${requestParameters.category_id}'/></#if>
				        <#if requestParameters.VIEW_INDEX??><input type='hidden' name='VIEW_INDEX' value='${requestParameters.VIEW_INDEX}'/></#if>
				        <#if requestParameters.SEARCH_STRING??><input type='hidden' name='SEARCH_STRING' value='${requestParameters.SEARCH_STRING}'/></#if>
				        <#if requestParameters.SEARCH_CATEGORY_ID??><input type='hidden' name='SEARCH_CATEGORY_ID' value='${requestParameters.SEARCH_CATEGORY_ID}'/></#if>
				        <a href="javascript:document.thecategoryform.submit()" class="btn btn-link"><span style="white-space: nowrap;">${uiLabelMap.ProductAddProductsUsingDefaultQuantities}</span></a>
	                </form>
	            </#if>            
	            <#assign longDescription = categoryContentWrapper.get("LONG_DESCRIPTION")!/>
			    <#assign categoryImageUrl = categoryContentWrapper.get("CATEGORY_IMAGE_URL")!/>
			    <#if categoryImageUrl?string?has_content || longDescription?has_content>
	                <div>
	                    <#if categoryImageUrl?string?has_content>
				          <#assign height=100/>
				          <img src='<@ofbizContentUrl>${categoryImageUrl}</@ofbizContentUrl>' vspace='5' hspace='5' align='left' class='cssImgLarge' />
	                    </#if>        
	                </div>
	            </#if>        
	        
	            <#if productCategoryLinkScreen?has_content && productCategoryLinks?has_content>
	                <div class="box">
				        <#list productCategoryLinks as productCategoryLink>
				            ${setRequestAttribute("productCategoryLink",productCategoryLink)}
				            ${screens.render(productCategoryLinkScreen)}
				        </#list>
	                </div>
	            </#if>
                
                   
                <#-- search -->
                <#if searchInCategory?default("Y") == "Y">
                    <a href="<@ofbizUrl>advancedsearch?SEARCH_CATEGORY_ID=${productCategory.productCategoryId}</@ofbizUrl>" class="btn btn-default">${uiLabelMap.ProductSearchInCategory}</a>
                </#if>	
	        
	        </div><!-- ./sidebar -->
	        
	        <div class="col-md-9 col-xs-12" id="categorycontent">
	        
	            <@listCategoryMembers />
	            
	        </div><!-- ./categorycontent -->
	    </div>
    <#else>
        <@listCategoryMembers />
    </#if>	    

</#if>

<#macro listCategoryMembers>
	<#if productCategoryMembers?has_content>
	    <#-- Pagination -->
	    <#if 12 < productCategoryMembers?size> 
		    <#if paginateEcommerceStyle??>
		        <@paginationControls/>
		    <#else>
		        <#include "component://common/webcommon/includes/htmlTemplate.ftl"/>
		        <#assign commonUrl = "category?category_id="+ (parameters.category_id!) + "&"/>
		        <#--assign viewIndex = viewIndex - 1/-->
		        <#assign viewIndexFirst = 0/>
		        <#assign viewIndexPrevious = viewIndex - 1/>
		        <#assign viewIndexNext = viewIndex + 1/>
		        <#assign viewIndexLast = Static["org.ofbiz.base.util.UtilMisc"].getViewLastIndex(listSize, viewSize) />
		        <#assign messageMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("lowCount", lowIndex, "highCount", highIndex, "total", listSize)/>
		        <#assign commonDisplaying = Static["org.ofbiz.base.util.UtilProperties"].getMessage("CommonUiLabels", "CommonDisplaying", messageMap, locale)/>
		        <@nextPrev commonUrl=commonUrl ajaxEnabled=false javaScriptEnabled=false paginateStyle="pagination" paginateFirstStyle="nav-first" viewIndex=viewIndex highIndex=highIndex listSize=listSize viewSize=viewSize ajaxFirstUrl="" firstUrl="" paginateFirstLabel="" paginatePreviousStyle="nav-previous" ajaxPreviousUrl="" previousUrl="" paginatePreviousLabel="" pageLabel="" ajaxSelectUrl="" selectUrl="" ajaxSelectSizeUrl="" selectSizeUrl="" commonDisplaying=commonDisplaying paginateNextStyle="nav-next" ajaxNextUrl="" nextUrl="" paginateNextLabel="" paginateLastStyle="nav-last" ajaxLastUrl="" lastUrl="" paginateLastLabel="" paginateViewSizeLabel="" />
		    </#if>
	    </#if>
	    
	    <div class="row products">
	        <#--
	        <#if categoryImageUrl?string?has_content>
	            <img style="position: relative; margin-top: ${height}px;"> </img>
	        </#if>
	        -->      
	    
	        <#list productCategoryMembers as productCategoryMember>
	          
	            ${setRequestAttribute("optProductId", productCategoryMember.productId)}
	            ${setRequestAttribute("productCategoryMember", productCategoryMember)}
	            ${setRequestAttribute("listIndex", productCategoryMember_index)}
	            ${screens.render(productsummaryScreen)}
	          
	        </#list>
	
	    </div>
	    <#if 12 < productCategoryMembers?size>
		    <#if paginateEcommerceStyle??>
		        <@paginationControls/>
		    </#if>
	    </#if>
	<#else>
	    <hr />
	    <div>${uiLabelMap.ProductNoProductsInThisCategory}</div>
	</#if>
</#macro>

<#macro paginationControls>
    <#assign viewIndexMax = Static["java.lang.Math"].ceil((listSize)?double / viewSize?double)>
      <#if (viewIndexMax?int > 0)>
        <div class="product-prevnext">
            <select name="pageSelect" onchange="loadCategoryByPaginate(this[this.selectedIndex].value);">
                <option value="#">${uiLabelMap.CommonPage} ${viewIndex?int + 1} ${uiLabelMap.CommonOf} ${viewIndexMax}</option>
                <#if (viewIndex?int > 1)>
                    <#list 1..viewIndexMax as curViewNum>
                         <option value="${productCategoryId}~${viewSize}~${curViewNum-1?int}">${uiLabelMap.CommonGotoPage} ${curViewNum}</option>
                    </#list>
                </#if>
            </select>
            <#-- End Page Select Drop-Down -->
            <#if (viewIndex?int > 0)>
                <a href="javascript: void(0);" onclick="loadCategoryByPaginate('${productCategoryId}~${viewSize}~${viewIndex?int - 1}');" class="btn btn-link">${uiLabelMap.CommonPrevious}</a> |
            </#if>
            <#if ((listSize?int - viewSize?int) > 0)>
                <span>${lowIndex} - ${highIndex} ${uiLabelMap.CommonOf} ${listSize}</span>
            </#if>
            <#if highIndex?int < listSize?int>
             | <a href="javascript: void(0);" onclick="loadCategoryByPaginate('${productCategoryId}~${viewSize}~${viewIndex?int + 1}');" class="btn btn-link">${uiLabelMap.CommonNext}</a>
            </#if>
        </div>
    </#if>
</#macro>