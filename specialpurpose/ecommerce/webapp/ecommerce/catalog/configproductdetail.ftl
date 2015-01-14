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
<#-- variable setup -->
<#assign productContentWrapper = productContentWrapper!>
<#assign price = priceMap!>
<#-- end variable setup -->

<#-- virtual product javascript -->
${virtualJavaScript!}
<script language="JavaScript" type="text/javascript">
<!--
    var detailImageUrl = null;
     function setAddProductId(name) {
        document.addform.add_product_id.value = name;
        if (document.addform.quantity == null) return;
        if (name == 'NULL' || isVirtual(name) == true) {
            document.addform.quantity.disabled = true;
        } else {
            document.addform.quantity.disabled = false;
        }
     }
     function isVirtual(product) {
        var isVirtual = false;
        <#if virtualJavaScript??>
        for (i = 0; i < VIR.length; i++) {
            if (VIR[i] == product) {
                isVirtual = true;
            }
        }
        </#if>
        return isVirtual;
     }

    function addItem() {
        document.configform.action = document.addform.action;
        document.configform.quantity.value = document.addform.quantity.value;
        document.configform.submit();
    }
    function verifyConfig() {
        document.configform.submit();
    }

    function popupDetail() {
        var defaultDetailImage = "${firstDetailImage?default(mainDetailImageUrl?default("_NONE_"))}";
        if (defaultDetailImage == null || defaultDetailImage == "null" || defaultDetailImage == "") {
            defaultDetailImage = "_NONE_";
        }

        if (detailImageUrl == null || detailImageUrl == "null") {
            detailImageUrl = defaultDetailImage;
        }

        if (detailImageUrl == "_NONE_") {
            hack = document.createElement('span');
            hack.innerHTML="${uiLabelMap.CommonNoDetailImageAvailableToDisplay}";
            showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonNoDetailImageAvailableToDisplay}");
            return;
        }
        detailImageUrl = detailImageUrl.replace(/\&\#47;/g, "/");
        popUp("<@ofbizUrl>detailImage?detail=" + detailImageUrl + "</@ofbizUrl>", 'detailImage', '400', '550');
    }

    function toggleAmt(toggle) {
        if (toggle == 'Y') {
            changeObjectVisibility("add_amount", "visible");
        }

        if (toggle == 'N') {
            changeObjectVisibility("add_amount", "hidden");
        }
    }

    function findIndex(name) {
        for (i = 0; i < OPT.length; i++) {
            if (OPT[i] == name) {
                return i;
            }
        }
        return -1;
    }

    function getList(name, index, src) {
        currentFeatureIndex = findIndex(name);

        if (currentFeatureIndex == 0) {
            // set the images for the first selection
            if (IMG[index] != null) {
                if (document.images['mainImage'] != null) {
                    document.images['mainImage'].src = IMG[index];
                    detailImageUrl = DET[index];
                }
            }

            // set the drop down index for swatch selection
            document.forms["addform"].elements[name].selectedIndex = (index*1)+1;
        }

        if (currentFeatureIndex < (OPT.length-1)) {
            // eval the next list if there are more
            var selectedValue = document.forms["addform"].elements[name].options[(index*1)+1].value;
            eval("list" + OPT[(currentFeatureIndex+1)] + selectedValue + "()");

            // set the product ID to NULL to trigger the alerts
            setAddProductId('NULL');
        } else {
            // this is the final selection -- locate the selected index of the last selection
            var indexSelected = document.forms["addform"].elements[name].selectedIndex;

            // using the selected index locate the sku
            var sku = document.forms["addform"].elements[name].options[indexSelected].value;

            // set the product ID
            setAddProductId(sku);

            // check for amount box
            toggleAmt(checkAmtReq(sku));
        }
    }
 //-->
 </script>

<script language="JavaScript" type="text/javascript">
<!--

jQuery(document).ready(function () {
    jQuery('#configFormId').change(getConfigDetails)
});

function getConfigDetails(event) {
        jQuery.ajax({
            url: '<@ofbizUrl>getConfigDetailsEvent</@ofbizUrl>',
            type: 'POST',
            data: jQuery('#configFormId').serialize(),
            success: function(data) {
                  var totalPrice = data.totalPrice;
                  var configId = data.configId;
                  document.getElementById('totalPrice').innerHTML = totalPrice;
                  document.addToShoppingList.configId.value = configId;
                  event.stop();
            }
        });
}

-->
</script>

<#import "component://ecommerce/webapp/ecommerce/catalog/productdetail.ftl" as productDetailMacro>

<div id="productdetail" class="row">

    <@productDetailMacro.nextPreviousCat />
    
    
    
    <div id="productMain">
        <div class="col-md-5 col-xs-12">
            <@productDetailMacro.displayProductImages/>
        </div> <!-- ./col-md-5 -->
        
        
        <div class="col-md-7 col-xs-12">                
            <h2>${productContentWrapper.get("PRODUCT_NAME")!}</h2>
            <p class="text-muted">${productContentWrapper.get("DESCRIPTION")!}</p>            
            
            <div class="box">
                <@productDetailMacro.displayProductFeatures />
                
                <div class="row">
                    <div class="col-md-6">
                        <@productConfigurator />
                    </div>
                </div>
                <br/>
                <@displayPriceDetails />
                <br/> 
                <div class="row">
                    <div class="col-md-6">
                        <@productDetailMacro.addItemForm />
                    </div>
                </div>                                   
                
                
            </div><!-- ./box -->
            <br/>
            <@productDetailMacro.showVirtualProductSwatch />
            <br/>
            <@productDetailMacro.shoppingList />
            <br/>
            <@productDetailMacro.showTellAFriend />
            
        </div><!-- ./col-md-7 -->
    </div><!-- ./productMain -->
</div><!-- ./productDetail -->    

<br/>



<@productDetailMacro.productDetailDesc />




<#macro displayPriceDetails>
    <#-- for prices:
              - if totalPrice is present, use it (totalPrice is the price calculated from the parts)
              - if price < competitivePrice, show competitive or "Compare At" price
              - if price < listPrice, show list price
              - if price < defaultPrice and defaultPrice < listPrice, show default
              - if isSale show price with salePrice style and print "On Sale!"
    -->
    <#if totalPrice??>
        <p class="price">${uiLabelMap.ProductAggregatedPrice}: <span id='totalPrice' class='basePrice'><@ofbizCurrency amount=totalPrice isoCode=totalPrice.currencyUsed/></span></p>
    <#else>
        <#if price.competitivePrice?? && price.price?? && price.price < price.competitivePrice>
            <div>${uiLabelMap.ProductCompareAtPrice}: <span class='basePrice'><@ofbizCurrency amount=price.competitivePrice isoCode=price.currencyUsed/></span></div>
        </#if>
        <#if price.listPrice?? && price.price?? && price.price < price.listPrice>
            <div>${uiLabelMap.ProductListPrice}: <span class='basePrice'><@ofbizCurrency amount=price.listPrice isoCode=price.currencyUsed/></span></div>
        </#if>
        <#if price.listPrice?? && price.defaultPrice?? && price.price?? && price.price < price.defaultPrice && price.defaultPrice < price.listPrice>
            <div>${uiLabelMap.ProductRegularPrice}: <span class='basePrice'><@ofbizCurrency amount=price.defaultPrice isoCode=price.currencyUsed/></span></div>
        </#if>
        <div>
            <#if price.isSale?? && price.isSale>
                <span class='salePrice'>${uiLabelMap.OrderOnSale}!</span>
                <#assign priceStyle = "salePrice">
            <#else>
                <#assign priceStyle = "regularPrice">
            </#if>
            ${uiLabelMap.OrderYourPrice}: <#if "Y" = product.isVirtual!> from </#if><span class='${priceStyle}'><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/></span>

        </div>
        <#if price.listPrice?? && price.price?? && price.price < price.listPrice>
            <#assign priceSaved = price.listPrice - price.price>
            <#assign percentSaved = (priceSaved / price.listPrice) * 100>
            <div>${uiLabelMap.OrderSave}: <span class="basePrice"><@ofbizCurrency amount=priceSaved isoCode=price.currencyUsed/> (${percentSaved?int}%)</span></div>
        </#if>
    </#if>

    <#-- Included quantities/pieces -->
    <#if product.quantityIncluded?? && product.quantityIncluded != 0>
        <div>${uiLabelMap.OrderIncludes}:
            ${product.quantityIncluded!}
            ${product.quantityUomId!}
        </div>
    </#if>
    <#if product.piecesIncluded?? && product.piecesIncluded?long != 0>
        <div>${uiLabelMap.OrderPieces}:
            ${product.piecesIncluded}
        </div>
    </#if>
    <#if daysToShip??>
        <div>${uiLabelMap.ProductUsuallyShipsIn} ${daysToShip} ${uiLabelMap.CommonDays}</div>
    </#if>
</#macro>

<#macro addItemForm>
    <div id="addItemForm">
	    <form method="post" action="<@ofbizUrl>additem<#if requestAttributes._CURRENT_VIEW_??>/${requestAttributes._CURRENT_VIEW_}</#if></@ofbizUrl>" name="addform" >
	        <#assign inStock = true>
	        <#-- Variant Selection -->
	        <#if product.isVirtual?? && product.isVirtual?upper_case == "Y">
	            <#if variantTree?? && 0 < variantTree.size()>
	                <#list featureSet as currentType>
	                    <div>
	                        <select name="FT${currentType}" onchange="javascript:getList(this.name, (this.selectedIndex-1), 1);" class="form-control">
	                            <option>${featureTypes.get(currentType)}</option>
	                        </select>
	                    </div>
	                </#list>
	                <input type='hidden' name="product_id" value='${product.productId}' />
	                <input type='hidden' name="add_product_id" value='NULL' />
	            <#else>
	                <input type='hidden' name="product_id" value='${product.productId}' />
	                <input type='hidden' name="add_product_id" value='NULL' />
	                <div class='tabletext'><b>${uiLabelMap.ProductItemOutOfStock}.</b></div>
	                <#assign inStock = false>
	            </#if>
	        <#else>
	            <input type='hidden' name="product_id" value='${product.productId}' />
	            <input type='hidden' name="add_product_id" value='${product.productId}' />
	            <#if productNotAvailable??>
	                <#assign isStoreInventoryRequired = Static["org.ofbiz.product.store.ProductStoreWorker"].isStoreInventoryRequired(request, product)>
	                <#if isStoreInventoryRequired>
	                    <div class='tabletext'><b>${uiLabelMap.ProductItemOutOfStock}.</b></div>
	                    <#assign inStock = false>
	                <#else>
	                    <div class='tabletext'><b>${product.inventoryMessage!}</b></div>
	                </#if>
	            </#if>
	        </#if>
	        
	        <#-- check to see if introductionDate hasn't passed yet -->
	        <#if product.introductionDate?? && nowTimestamp.before(product.introductionDate)>
	            
	            <div class='tabletext' style='color: red;'>${uiLabelMap.ProductProductNotYetMadeAvailable}.</div>
	            <#-- check to see if salesDiscontinuationDate has passed -->
	        <#elseif product.salesDiscontinuationDate?? && nowTimestamp.after(product.salesDiscontinuationDate)>
	            <div class='tabletext' style='color: red;'>${uiLabelMap.ProductProductNoLongerAvailable}.</div>
	            <#-- check to see if the product requires inventory check and has inventory -->
	        <#else>
	            <#if inStock>
	                <#if product.requireAmount?default("N") == "Y">
	                <#assign hiddenStyle = "visible">
	            <#else>
	                <#assign hiddenStyle = "hidden">
	            </#if>
	            <div id="add_amount" class="${hiddenStyle}">
	                <span style="white-space: nowrap;"><b>Amount:</b></span>&nbsp;
	                <input type="text" size="5" name="add_amount" value="" />
	            </div>
	            <#if !configwrapper.isCompleted()>
	                <div>[${uiLabelMap.EcommerceProductNotConfigured}]&nbsp;
	                <input type="hidden" size="5" name="quantity" value="0" disabled="disabled" /></div>
	            <#else>
	                <a href="javascript:addItem()" class="btn btn-primary"> <i class="fa fa-shopping-cart"></i> ${uiLabelMap.OrderAddToCart}</a>
	                <input type="hidden" size="5" name="quantity" value="1" />
	                <#if minimumQuantity?? &&  minimumQuantity &gt; 0>
	                    Minimum order quantity is ${minimumQuantity}.
	                </#if>
	            </#if>
	        </#if>
	        <#if requestParameters.category_id??>
	            <input type='hidden' name='category_id' value='${requestParameters.category_id}' />
	        </#if>
	    </#if>
	    </form>
    </div>
</#macro>
<#macro productConfigurator>
    <#-- Product Configurator -->
    <form name="configform" id="configFormId" method="post" action="<@ofbizUrl>product<#if requestAttributes._CURRENT_VIEW_??>/${requestAttributes._CURRENT_VIEW_}</#if></@ofbizUrl>">
        <input type='hidden' name='add_product_id' value='${product.productId}' />
        <input type='hidden' name='add_category_id' value='' />
        <input type='hidden' name='quantity' value='1' />

        <input type='hidden' name='product_id' value='${product.productId}' />
        
        <p><a href="javascript:verifyConfig();" class="btn btn-default">${uiLabelMap.OrderVerifyConfiguration}</a></p>
        
        
            
            <#assign counter = 0>
            <#assign questions = configwrapper.questions>
            <#list questions as question>
                        <p>${question.question}</p>
                        <div>
	                        <#if question.isFirst()>
	                            <a name='#${question.getConfigItem().getString("configItemId")}'></a>
	                            <div>${question.description!}</div>
	                            <#assign instructions = question.content.get("INSTRUCTIONS")!>
	                            <#if instructions?has_content>
	                                <a href="javascript:showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${instructions}");" class="btn btn-primary">Instructions</a>
	                            </#if>
	                            <#assign image = question.content.get("IMAGE_URL")!>
	                            <#if image?string?has_content>
	                                <img src='<@ofbizContentUrl>${contentPathPrefix!}${image!}</@ofbizContentUrl>' vspace='5' hspace='5' class='cssImgXLarge' align='left' alt="" />
	                            </#if>
	                        <#else>
	                            <div><a href='#${question.getConfigItem().getString("configItemId")}' class="btn btn-primary">Details</a></div>
	                        </#if>
                        </div>
                
                        <div>
                        <#if question.isStandard()>
                            <#-- Standard item: all the options are always included -->
                            <#assign options = question.options>
                            <#list options as option>
                                <div>${option.description} <#if !option.isAvailable()> (*)</#if></div>
                            </#list>
                        <#else>
                            <#if question.isSingleChoice()>
                                <#-- Single choice question -->
                                <#assign options = question.options>
                                <#assign selectedOption = question.getSelected()!>
                                <#assign selectedPrice = 0.0>
                                <#if selectedOption?has_content>
                                    <#assign selectedPrice = selectedOption.getPrice()>
                                </#if>
                                <#-- The single choice input can be implemented with radio buttons or a select field -->
                                <#if renderSingleChoiceWithRadioButtons?? && "Y" == renderSingleChoiceWithRadioButtons>
                                    <#-- This is the radio button implementation -->
                                    <#if !question.isMandatory()>
                                        <div><input type="radio" name='${counter}' value='<#if !question.isSelected()>checked</#if>' /> No option</div>
                                    </#if>
                                    <#assign optionCounter = 0>
                                    <#list options as option>
                                        <#assign componentCounter = 0>
                                        <#if showOffsetPrice?? && "Y" == showOffsetPrice>
                                            <#assign shownPrice = option.price - selectedPrice>
                                        <#else>
                                            <#assign shownPrice = option.price>
                                        </#if>
                                        <#-- Render virtual compoennts -->
                                        <#if option.hasVirtualComponent()>
                                            <div >
                                                <input type='radio' name='${counter}' id="${counter}_${optionCounter}" value='${optionCounter}' onclick="javascript:checkOptionVariants('${counter}_${optionCounter}');" />
                                                ${option.description} <#if !option.isAvailable()> (*)</#if>
                                                <#assign components = option.getComponents()>
                                                <#list components as component>
                                                    <#if (option.isVirtualComponent(component))>
                                                        ${setRequestAttribute("inlineProductId", component.productId)}
                                                        ${setRequestAttribute("inlineCounter", counter+ "_" +optionCounter + "_"+componentCounter)}
                                                        ${setRequestAttribute("addJavaScript", componentCounter)}
                                                        ${screens.render(inlineProductDetailScreen)}
                                                        <#assign componentCounter = componentCounter + 1>
                                                    </#if>
                                                </#list>
                                            </div>
                                        <#else>
                                            <div>
                                                <input type="radio" name='${counter}' value='${optionCounter}' <#if option.isSelected() || (!question.isSelected() && optionCounter == 0 && question.isMandatory())>checked="checked"</#if> />
                                                ${option.description}&nbsp;
                                                <#if (shownPrice > 0)>+<@ofbizCurrency amount=shownPrice isoCode=price.currencyUsed/>&nbsp;</#if>
                                                <#if (shownPrice < 0)>-<@ofbizCurrency amount=(-1*shownPrice) isoCode=price.currencyUsed/>&nbsp;</#if>
                                                <#if !option.isAvailable()>(*)</#if>
                                            </div>
                                        </#if>
                                        <#assign optionCounter = optionCounter + 1>
                                    </#list>
                                <#else>
                                    <#-- And this is the select box implementation -->
                                    <select name='${counter}' class="form-control">
                                        <#if !question.isMandatory()>
                                            <option value=''>---</option>
                                        </#if>
                                        <#assign options = question.options>
                                        <#assign optionCounter = 0>
                                        <#list options as option>
                                            <#if showOffsetPrice?? && "Y" == showOffsetPrice>
                                                <#assign shownPrice = option.price - selectedPrice>
                                            <#else>
                                                <#assign shownPrice = option.price>
                                            </#if>
                                            <#if option.isSelected()>
                                                <#assign optionCounter = optionCounter + 1>
                                            </#if>
                                            <option value='${optionCounter}' <#if option.isSelected()>selected="selected"</#if>>
                                                ${option.description}&nbsp;
                                                <#if (shownPrice > 0)>+<@ofbizCurrency amount=shownPrice isoCode=price.currencyUsed/>&nbsp;</#if>
                                                <#if (shownPrice < 0)>-<@ofbizCurrency amount=(-1*shownPrice) isoCode=price.currencyUsed/>&nbsp;</#if>
                                                <#if !option.isAvailable()> (*)</#if>
                                            </option>
                                            <#assign optionCounter = optionCounter + 1>
                                        </#list>
                                    </select>
                                </#if>
                            <#else>
                                <#-- Multi choice question -->
                                <#assign options = question.options>
                                <#assign optionCounter = 0>
                                <#list options as option>
                                    <#assign componentCounter = 0>
                                    <#-- Render virtual compoennts -->
                                    <#if option.hasVirtualComponent()>
                                        <div >
                                            <input type='CHECKBOX' name='${counter}' id="${counter}_${optionCounter}" value='${optionCounter}' onclick="javascript:checkOptionVariants('${counter}_${optionCounter}');" />
                                            ${option.description} <#if !option.isAvailable()> (*)</#if>
                                            <#assign components = option.getComponents()>
                                            <#list components as component>
                                                <#if (option.isVirtualComponent(component))>
                                                    ${setRequestAttribute("inlineProductId", component.productId)}
                                                    ${setRequestAttribute("inlineCounter", counter+ "_" +optionCounter + "_"+componentCounter)}
                                                    ${setRequestAttribute("addJavaScript", componentCounter)}
                                                    ${screens.render(inlineProductDetailScreen)}
                                                    <#assign componentCounter = componentCounter + 1>
                                                </#if>
                                            </#list>
                                        </div>
                                    <#else>
                                        <div>
                                            <input type='CHECKBOX' name='${counter}' value='${optionCounter}' <#if option.isSelected()>checked="checked"</#if> />
                                            ${option.description} +<@ofbizCurrency amount=option.price isoCode=price.currencyUsed/><#if !option.isAvailable()> (*)</#if>
                                        </div>
                                    </#if>
                                    <#assign optionCounter = optionCounter + 1>
                                </#list>
                            </#if>
                        </#if>
                    </div
                <#assign counter = counter + 1>
            </#list>
        
    </form>
</#macro>