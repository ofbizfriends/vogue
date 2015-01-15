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

<#if product??>

    <#-- variable setup -->
    <#if backendPath?default("N") == "Y">
        <#assign productUrl><@ofbizCatalogUrl productId=product.productId productCategoryId=categoryId/></#assign>
    <#else>
        <#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>
    </#if>

    <#if requestAttributes.productCategoryMember??>
        <#assign prodCatMem = requestAttributes.productCategoryMember>
    </#if>
    <#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")!>
    <#assign largeImageUrl = productContentWrapper.get("LARGE_IMAGE_URL")!>
    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage-small.jpg"></#if>
    <#if !largeImageUrl?string?has_content><#assign largeImageUrl = "/images/defaultImage.jpg"></#if>
    <#-- end variable setup -->
    <#assign productInfoLinkId = "productInfoLink">
    <#assign productInfoLinkId = productInfoLinkId + product.productId/>
    <#assign productDetailId = "productDetailId"/>
    <#assign productDetailId = productDetailId + product.productId/>    

    
    
    <div class="modal fade" id="${product.productId!}-modal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-body">

                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>

                    <div class="row quick-view product-main">
                        <div class="col-sm-6">
                            <div class="quick-view-main-image">
                                <img src="<@ofbizContentUrl>${contentPathPrefix!}${largeImageUrl}</@ofbizContentUrl>" alt="" class="img-responsive">
                            </div>
                            <#if price.isSale?? && price.isSale>
                                <div class="ribbon ribbon-quick-view sale">
                                    <div class="theribbon">SALE</div>
                                    <div class="ribbon-background"></div>
                                </div>
                            </#if>
                            <!-- /.ribbon -->
                            <#--
                            <div class="ribbon ribbon-quick-view new">
                                <div class="theribbon">NEW</div>
                                <div class="ribbon-background"></div>
                            </div>
                            -->
                            <!-- /.ribbon -->

                            <#--
                            <div class="row thumbs">
                                <div class="col-xs-4">
                                    <a href="img/detailbig1.jpg" class="thumb active">
                                        <img src="img/detailsquare.jpg" alt="" class="img-responsive">
                                    </a>
                                </div>
                                <div class="col-xs-4">
                                    <a href="img/detailbig2.jpg" class="thumb">
                                        <img src="img/detailsquare2.jpg" alt="" class="img-responsive">
                                    </a>
                                </div>
                                <div class="col-xs-4">
                                    <a href="img/detailbig3.jpg" class="thumb">
                                        <img src="img/detailsquare3.jpg" alt="" class="img-responsive">
                                    </a>
                                </div>
                            </div>
                            -->

                        </div>
                        <div class="col-sm-6">

                            <h2>${productContentWrapper.get("PRODUCT_NAME")!}</h2>

                            <p class="text-muted text-small text-center">${productContentWrapper.get("DESCRIPTION")!} <#if daysToShip??>&nbsp;-&nbsp;${uiLabelMap.ProductUsuallyShipsIn} <b>${daysToShip}</b> ${uiLabelMap.CommonDays}!</#if> </p>

                            <#-- Display category-specific product comments -->
                            <#if prodCatMem?? && prodCatMem.comments?has_content>
                                <p>${prodCatMem.comments}</p>
                            </#if>

          
                                                        
                            <div class="box">
                                <form>
                                    <#if sizeProductFeatureAndAppls?has_content>
                                        <div class="sizes"> 
                                            <h3>                                            
                                                <#if (sizeProductFeatureAndAppls?size == 1)>
                                                    ${uiLabelMap.SizeAvailableSingle}:
                                                <#else>
                                                    ${uiLabelMap.SizeAvailableMultiple}:
                                                </#if>                                          
                                            </h3>
    
                                            <#list sizeProductFeatureAndAppls as sizeProductFeatureAndAppl>
                                                <label >
                                                    <a href="#">${sizeProductFeatureAndAppl.abbrev?default(sizeProductFeatureAndAppl.description?default(sizeProductFeatureAndAppl.productFeatureId))}<#if sizeProductFeatureAndAppl_has_next>,</#if></a>
                                                </label>
                                            </#list>    
                                        </div>
                                    </#if>
    
    

                                    <p class="text-center price">
                                    
                                    
                                        <#if totalPrice??>
                                            <span class='basePrice'><@ofbizCurrency amount=totalPrice isoCode=totalPrice.currencyUsed/></span>
                                        <#else>
                                            <#if price.competitivePrice?? && price.price?? && price.price?double < price.competitivePrice?double>
                                                ${uiLabelMap.ProductCompareAtPrice}: <span class='basePrice'><@ofbizCurrency amount=price.competitivePrice isoCode=price.currencyUsed/></span>
                                            </#if>
                                            <#if price.listPrice?? && price.price?? && price.price?double < price.listPrice?double>
                                              <del><@ofbizCurrency amount=price.listPrice isoCode=price.currencyUsed/></del>
                                            </#if>
                                                                                     
                                              <#if (price.price?default(0) > 0 && product.requireAmount?default("N") == "N")>
                                                <#if "Y" = product.isVirtual!> ${uiLabelMap.CommonFrom} </#if><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/>
                                              </#if>
                                            
                                        </#if>
                                        
                                        
                                        <#-- show price details ("showPriceDetails" field can be set in the screen definition) -->
                                        <#if (showPriceDetails?? && showPriceDetails?default("N") == "Y")>
                                            <#if price.orderItemPriceInfos??>
                                                <#list price.orderItemPriceInfos as orderItemPriceInfo>
                                                    <div>${orderItemPriceInfo.description!}</div>
                                                </#list>
                                            </#if>
                                        </#if>                                                                          
                                    </p><!-- ./price -->
                                    
                                    <p class="text-center save">
                                        <#if price.listPrice?? && price.price?? && price.price?double < price.listPrice?double>                                              
                                            <#assign priceSaved = price.listPrice?double - price.price?double>
                                            <#assign percentSaved = (priceSaved?double / price.listPrice?double) * 100>
                                                ${uiLabelMap.OrderSave} <span class="basePrice"><@ofbizCurrency amount=priceSaved isoCode=price.currencyUsed/> (${percentSaved?int}%)</span>
                                        </#if>                                    
                                    </p>

                                    <p class="text-center">
                                                                            
                                          <#-- check to see if introductionDate hasn't passed yet -->
                                          <#if product.introductionDate?? && nowTimestamp.before(product.introductionDate)>
                                            <div style="color: red;">${uiLabelMap.ProductNotYetAvailable}</div>
                                          <#-- check to see if salesDiscontinuationDate has passed -->
                                          <#elseif product.salesDiscontinuationDate?? && nowTimestamp.after(product.salesDiscontinuationDate)>
                                            <div style="color: red;">${uiLabelMap.ProductNoLongerAvailable}</div>
                                          <#-- check to see if it is a rental item; will enter parameters on the detail screen-->
                                          <#elseif product.productTypeId! == "ASSET_USAGE">
                                            <a href="${productUrl}" class="btn btn-primary">${uiLabelMap.OrderMakeBooking}...</a>
                                          <#-- check to see if it is an aggregated or configurable product; will enter parameters on the detail screen-->
                                          <#elseif product.productTypeId! == "AGGREGATED" || product.productTypeId! == "AGGREGATED_SERVICE">
                                            <a href="${productUrl}" class="btn btn-primary">${uiLabelMap.OrderConfigure}...</a>
                                          <#-- check to see if the product is a virtual product -->
                                          <#elseif product.isVirtual?? && product.isVirtual == "Y">
                                            <a href="${productUrl}" class="btn btn-primary">${uiLabelMap.OrderChooseVariations}...</a>
                                          <#-- check to see if the product requires an amount -->
                                          <#elseif product.requireAmount?? && product.requireAmount == "Y">
                                            <a href="${productUrl}" class="btn btn-primary">${uiLabelMap.OrderChooseAmount}...</a>
                                          <#elseif product.productTypeId! == "ASSET_USAGE_OUT_IN">
                                            <a href="${productUrl}" class="btn btn-primary">${uiLabelMap.OrderRent}...</a>
                                          <#else>
                                            <form method="post" action="<@ofbizUrl>additem</@ofbizUrl>" name="the${requestAttributes.formNamePrefix!}${requestAttributes.listIndex!}form" style="margin: 0;">
                                              <input type="hidden" name="add_product_id" value="${product.productId}"/>
                                              <input type="hidden" size="5" name="quantity" value="1"/>
                                              <input type="hidden" name="clearSearch" value="N"/>
                                              <input type="hidden" name="mainSubmitted" value="Y"/>
                                              <a href="javascript:document.the${requestAttributes.formNamePrefix!}${requestAttributes.listIndex!}form.submit()" class="btn btn-primary"><i class="fa fa-shopping-cart"></i>${uiLabelMap.OrderAddToCart}</a>
                                            <#if mainProducts?has_content>
                                                <input type="hidden" name="product_id" value=""/>
                                                <select name="productVariantId" onchange="javascript:displayProductVirtualId(this.value, '${product.productId}', this.form);">
                                                    <option value="">Select Unit Of Measure</option>
                                                    <#list mainProducts as mainProduct>
                                                        <option value="${mainProduct.productId}">${mainProduct.uomDesc} : ${mainProduct.piecesIncluded}</option>
                                                    </#list>
                                                </select>
                                                <div style="display: inline-block;">
                                                    <strong><span id="product_id_display"> </span></strong>
                                                    <strong><span id="variant_price_display"> </span></strong>
                                                </div>
                                            </#if>
                                            </form>
                                            
                                              <#if prodCatMem?? && prodCatMem.quantity?? && 0.00 < prodCatMem.quantity?double>
                                                <form method="post" action="<@ofbizUrl>additem</@ofbizUrl>" name="the${requestAttributes.formNamePrefix!}${requestAttributes.listIndex!}defaultform" style="margin: 0;">
                                                  <input type="hidden" name="add_product_id" value="${prodCatMem.productId!}"/>
                                                  <input type="hidden" name="quantity" value="${prodCatMem.quantity!}"/>
                                                  <input type="hidden" name="clearSearch" value="N"/>
                                                  <input type="hidden" name="mainSubmitted" value="Y"/>
                                                  <a href="javascript:document.the${requestAttributes.formNamePrefix!}${requestAttributes.listIndex!}defaultform.submit()" class="btn btn-primary">${uiLabelMap.CommonAddDefault}(${prodCatMem.quantity?string.number}) ${uiLabelMap.OrderToCart}</a>
                                                </form>
                                                <#assign productCategory = delegator.findOne("ProductCategory", Static["org.ofbiz.base.util.UtilMisc"].toMap("productCategoryId", prodCatMem.productCategoryId), false)/>
                                                <#if productCategory.productCategoryTypeId != "BEST_SELL_CATEGORY">
                                                    <form method="post" action="<@ofbizUrl>additem</@ofbizUrl>" name="the${requestAttributes.formNamePrefix!}${requestAttributes.listIndex!}defaultform" style="margin: 0;">
                                                      <input type="hidden" name="add_product_id" value="${prodCatMem.productId!}"/>
                                                      <input type="hidden" name="quantity" value="${prodCatMem.quantity!}"/>
                                                      <input type="hidden" name="clearSearch" value="N"/>
                                                      <input type="hidden" name="mainSubmitted" value="Y"/>
                                                      <a href="javascript:document.the${requestAttributes.formNamePrefix!}${requestAttributes.listIndex!}defaultform.submit()" class="btn btn-primary">${uiLabelMap.CommonAddDefault}(${prodCatMem.quantity?string.number}) ${uiLabelMap.OrderToCart}</a>
                                                    </form>
                                                </#if>
                                              </#if>
                                          </#if>
                                                                            

                                    </p>


                                </form>
                            </div><!-- /.box  features -->
                        

                            <div class="quick-view-social">
                                <h4>Show it to your friends</h4>
                                <p>
                                    <a href="#" class="external facebook" data-animate-hover="pulse"><i class="fa fa-facebook"></i></a>
                                    <a href="#" class="external gplus" data-animate-hover="pulse"><i class="fa fa-google-plus"></i></a>
                                    <a href="#" class="external twitter" data-animate-hover="pulse"><i class="fa fa-twitter"></i></a>
                                    <a href="#" class="email" data-animate-hover="pulse"><i class="fa fa-envelope"></i></a>
                                </p>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!--/.modal-dialog-->
    </div>
    
    
    
    
    
    
    
    
    <div class="col-md-3 col-sm-4">    
        <div class="product">
            <div class="image" style="height: 255px;">
                <a href="${productUrl}">
                    <img src="<@ofbizContentUrl>${contentPathPrefix!}${smallImageUrl}</@ofbizContentUrl>" alt="Small Image" class="img-responsive image1">
                </a>
                <div class="quick-view-button">
                    <a href="#" data-toggle="modal" data-target="#${product.productId!}-modal" class="btn btn-default btn-sm">Quick view</a>
                </div>
            </div>
            <!-- /.image -->
            <div class="text">
                <h3><a href="${productUrl}">${productContentWrapper.get("PRODUCT_NAME")!}</a></h3>
                
                <p class="price">
                    
                    
                    <#if totalPrice??>
                        <@ofbizCurrency amount=totalPrice isoCode=totalPrice.currencyUsed/>
                        
                    <#else>                        
                        <#if price.listPrice?? && price.price?? && price.price?double < price.listPrice?double>
                        <del><@ofbizCurrency amount=price.listPrice isoCode=price.currencyUsed/></del>
                        </#if>
                        
                        
                        <#if (price.price?default(0) > 0 && product.requireAmount?default("N") == "N")>
                            <#if "Y" = product.isVirtual!> ${uiLabelMap.CommonFrom} </#if><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/>
                        <#else>
                            ${uiLabelMap.OrderChooseVariations}...
                        </#if>
                                                
                    </#if>                    
                    
                </p><!-- ./price -->                
                
                
                
                
                
                
                
            </div>
            <!-- /.text -->
            
            <#if price.isSale?? && price.isSale>
                <div class="ribbon sale">
                    <div class="theribbon">SALE</div>
                    <div class="ribbon-background"></div>
                </div>          
            </#if>
        </div>
        <!-- /.product -->      
    </div>    

<#else>
&nbsp;${uiLabelMap.ProductErrorProductNotFound}.<br />
</#if>
