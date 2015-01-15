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

<#if productCategoryList?has_content>

    <div class="box text-center">
        <h3 class="text-uppercase">Popular Categories</h3>
        <h4 class="text-muted"><span class="accent">Hot selling, Exclusive</span> and more </h4>
    </div>
    
    
    
       
    <#list productCategoryList as childCategoryList>
        <div class="row categories">                   
            <#assign cateCount = 0/>
            <#list childCategoryList as productCategory>
                    <div class="col-md-3 col-sm-4">
                   <#if (cateCount > 2)>
                        <tr>
                        <#assign cateCount = 0/>
                   </#if>
                   <#assign productCategoryId = productCategory.productCategoryId/>
                   <#assign categoryImageUrl = "/images/defaultImage.jpg">
                   <#assign productCategoryMembers = delegator.findByAnd("ProductCategoryAndMember", Static["org.ofbiz.base.util.UtilMisc"].toMap("productCategoryId", productCategoryId), Static["org.ofbiz.base.util.UtilMisc"].toList("-quantity"), false)>
                   <#if productCategory.categoryImageUrl?has_content>
                        <#assign categoryImageUrl = productCategory.categoryImageUrl/>
                   <#elseif productCategoryMembers?has_content>
                        <#assign productCategoryMember = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(productCategoryMembers)/>
                        <#assign product = delegator.findOne("Product", Static["org.ofbiz.base.util.UtilMisc"].toMap("productId", productCategoryMember.productId), false)/>
                        <#if product.smallImageUrl?has_content>
                            <#assign categoryImageUrl = product.smallImageUrl/>
                        </#if>
                   </#if>
                    
                        <div class="productsummary">
                            <div class="smallimage">
                                <a href="<@ofbizCatalogAltUrl productCategoryId=productCategoryId/>">
                                    <img alt="Small Image" src="${categoryImageUrl}" class="img-responsive">
                                </a>
                            </div>                            
                            <div class="categoryTile">
	                            <div class="productbuy">
	                                <h4><a href="<@ofbizCatalogAltUrl productCategoryId=productCategoryId/>">${productCategory.categoryName!productCategoryId}</a></h4>
	                            </div>
	                            <div class="productinfo">
	                                
	                                <#if productCategoryMembers??>
	                                    <#assign i = 0/>
	                                    <#list productCategoryMembers as productCategoryMember>
	                                        <#if (i > 2)>
	                                            <#if productCategoryMembers[i]?has_content>
	                                                <p>
	                                                <a class="linktext" href="<@ofbizCatalogAltUrl productCategoryId=productCategoryId/>">
	                                                    <span>More...</span>
	                                                </a>
	                                                </p>
	                                            </#if>
	                                            <#break>
	                                        </#if>
	                                        <#if productCategoryMember?has_content>
	                                            <#assign product = delegator.findOne("Product", Static["org.ofbiz.base.util.UtilMisc"].toMap("productId", productCategoryMember.productId), false)>
	                                            
	                                            <div class="browsecategorytext">
	                                                <a class="linktext" href="<@ofbizCatalogAltUrl productCategoryId="PROMOTIONS" productId="${product.productId}"/>">
	                                                    ${product.productName!product.productId}
	                                                </a>
	                                            </div>
	                                            
	                                        </#if>
	                                        <#assign i = i+1/>
	                                    </#list>
	                                </#if>
	                                
	                            </div>
                            </div>
                        </div>
                    
                    <#assign cateCount = cateCount + 1/>
                </div> <!-- ./col-md-4  -->                    
            </#list>                        
        </div><!-- ./row categories -->
    </#list>

    
</#if>
