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


<form name="keywordsearchform" id="keywordsearchbox_keywordsearchform" method="post" action="<@ofbizUrl>keywordsearch</@ofbizUrl>" class="navbar-form" role="search">
      
    <input type="hidden" name="VIEW_SIZE" value="10" />
    <input type="hidden" name="PAGING" value="Y" />
    <input type="hidden" name="SEARCH_OPERATOR" value="OR" />
        
    <div class="input-group">
        <#if 0 &lt; otherSearchProdCatalogCategories?size>
            <select name="SEARCH_CATEGORY_ID" size="1">
                <option value="${searchCategoryId!}">${uiLabelMap.ProductEntireCatalog}</option>
                <#list otherSearchProdCatalogCategories as otherSearchProdCatalogCategory>
                    <#assign searchProductCategory = otherSearchProdCatalogCategory.getRelatedOne("ProductCategory", true)>
                    <#if searchProductCategory??>
                        <option value="${searchProductCategory.productCategoryId}">${searchProductCategory.description?default("No Description " + searchProductCategory.productCategoryId)}</option>
                    </#if>
                </#list>
            </select>          
        <#else>
            <input type="hidden" name="SEARCH_CATEGORY_ID" value="${searchCategoryId!}" />
        </#if>    
        
        
        <input type="text" name="SEARCH_STRING" class="form-control" placeholder="Search" value="${requestParameters.SEARCH_STRING!}" >  
        
        <span class="input-group-btn">                        
            <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i></button>         
        </span>            
    </div>      
</form>
  