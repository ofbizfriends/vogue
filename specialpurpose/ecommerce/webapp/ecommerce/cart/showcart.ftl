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
//<![CDATA[
function toggle(e) {
    e.checked = !e.checked;
}
function checkToggle(e) {
    var cform = document.cartform;
    if (e.checked) {
        var len = cform.elements.length;
        var allchecked = true;
        for (var i = 0; i < len; i++) {
            var element = cform.elements[i];
            if (element.name == "selectedItem" && !element.checked) {
                allchecked = false;
            }
            cform.selectAll.checked = allchecked;
        }
    } else {
        cform.selectAll.checked = false;
    }
}
function toggleAll(e) {
    var cform = document.cartform;
    var len = cform.elements.length;
    for (var i = 0; i < len; i++) {
        var element = cform.elements[i];
        if (element.name == "selectedItem" && element.checked != e.checked) {
            toggle(element);
        }
    }
}
function removeSelected() {
    var cform = document.cartform;
    cform.removeSelected.value = true;
    cform.submit();
}
function addToList() {
    var cform = document.cartform;
    cform.action = "<@ofbizUrl>addBulkToShoppingList</@ofbizUrl>";
    cform.submit();
}
function gwAll(e) {
    var cform = document.cartform;
    var len = cform.elements.length;
    var selectedValue = e.value;
    if (selectedValue == "") {
        return;
    }

    var cartSize = ${shoppingCartSize};
    var passed = 0;
    for (var i = 0; i < len; i++) {
        var element = cform.elements[i];
        var ename = element.name;
        var sname = ename.substring(0,16);
        if (sname == "option^GIFT_WRAP") {
            var options = element.options;
            var olen = options.length;
            var matching = -1;
            for (var x = 0; x < olen; x++) {
                var thisValue = element.options[x].value;
                if (thisValue == selectedValue) {
                    element.selectedIndex = x;
                    passed++;
                }
            }
        }
    }
    if (cartSize > passed && selectedValue != "NO^") {
        showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.EcommerceSelectedGiftWrap}");
    }
    cform.submit();
}
//]]>
</script>

<script type="text/javascript">
//<![CDATA[
function setAlternateGwp(field) {
  window.location=field.value;
};
//]]>
</script>
<div class="row">
	<div class="col-md-12">
		<div class="box text-center">
		    <div class="row">
		        <div class="col-sm-10 col-sm-offset-1">
		            <h1>${uiLabelMap.PageTitleShoppingCart}</h1>
		            <p class="text-muted">
			            <#if shoppingCartSize?has_content>
			                You currently have ${shoppingCartSize} item(s) in your cart.
			            <#else>
			                ${uiLabelMap.EcommerceYourShoppingCartEmpty}                                
			            </#if>
		            </p>
		        </div>
		    </div>
		</div>
	</div>
</div>
<#assign fixedAssetExist = shoppingCart.containAnyWorkEffortCartItems() /> <#-- change display format when rental items exist in the shoppingcart -->



<div class="row">
	<div class="col-md-9" id="basket">
	    <div class="box">
		    
	        <#if (shoppingCartSize > 0)>
                <@showShoppingCart />
            <#else>
                <h4>${uiLabelMap.EcommerceYourShoppingCartEmpty}</h4>                
	        </#if>	
	        
            <div class="box-footer">
                <#if ((sessionAttributes.lastViewedProducts)?has_content && sessionAttributes.lastViewedProducts?size > 0)>
                  <#assign continueLink = "/product?product_id=" + sessionAttributes.lastViewedProducts.get(0) />
                <#else>
                  <#assign continueLink = "/main" />
                </#if>
                <div class="pull-left">
                    <a href="<@ofbizUrl>${continueLink}</@ofbizUrl>" class="btn btn-default"><i class="fa fa-chevron-left"></i> ${uiLabelMap.EcommerceContinueShopping}</a>
                </div>
                <div class="pull-right">
                    <#if (shoppingCartSize > 0)>                    
                        <a href="<@ofbizUrl>checkoutoptions</@ofbizUrl>" class="btn btn-primary">${uiLabelMap.OrderCheckout} <i class="fa fa-chevron-right"></i></a>
                    <#else>
                        <span class="btn btn-default" disabled="disabled">${uiLabelMap.OrderCheckout}</span>                                 
                    </#if>
                </div>                
            </div><!-- ./box-footer  navigation -->	                                            
	    </div><!-- /.box -->	    
	    

		      
		<@associatedProducts />  
		
		
		      
	</div><!-- ./basket -->
    <div class="col-md-3">
    
        <#if (shoppingCartSize?default(0) > 0)>
            ${screens.render("component://ecommerce/widget/CartScreens.xml#promoUseDetailsInline")}                         
        </#if>    
        <div>
            <h4>${uiLabelMap.ProductPromoCodes}</h4>
        </div>
        <div>
            <div>
                <form method="post" action="<@ofbizUrl>addpromocode<#if requestAttributes._CURRENT_VIEW_?has_content>/${requestAttributes._CURRENT_VIEW_}</#if></@ofbizUrl>" name="addpromocodeform">
                    <div class="input-group">
	                    <input type="text" class="form-control" size="15" name="productPromoCodeId" value="" />
	                    <span class="input-group-btn">
	                       <input type="submit" class="btn btn-default" value="${uiLabelMap.OrderAddCode}" />
	                    </span>
	                    <#assign productPromoCodeIds = (shoppingCart.getProductPromoCodesEntered())! />
	                    <#if productPromoCodeIds?has_content>
	                        ${uiLabelMap.ProductPromoCodesEntered}
	                        <ul>
	                        <#list productPromoCodeIds as productPromoCodeId>
	                            <li>${productPromoCodeId}</li>
	                        </#list>
	                        </ul>
	                    </#if>
                    </div>
                </form>
            </div>
        </div>    
        <hr/>
        
		<#if showPromoText?? && showPromoText>
			<div>
			    <div>
			        <h4>${uiLabelMap.OrderSpecialOffers}</h4>
			    </div>
			    <div>
			        <#-- show promotions text -->
			        
			        <#list productPromos as productPromo>
			            <p><a href="<@ofbizUrl>showPromotionDetails?productPromoId=${productPromo.productPromoId}</@ofbizUrl>" class="linktext">[${uiLabelMap.CommonDetails}]</a>${StringUtil.wrapString(productPromo.promoText!)}</p>
			        </#list>
			        
			        <div><a href="<@ofbizUrl>showAllPromotions</@ofbizUrl>" class="button">${uiLabelMap.OrderViewAllPromotions}</a></div>
			    </div>
			</div>
		</#if>        
    </div><!-- ./col-md-3 -->    
</div><!-- ./row -->	
	
	
<!-- Internal cart info: productStoreId=${shoppingCart.getProductStoreId()!} locale=${shoppingCart.getLocale()!} currencyUom=${shoppingCart.getCurrency()!} userLoginId=${(shoppingCart.getUserLogin().getString("userLoginId"))!} autoUserLogin=${(shoppingCart.getAutoUserLogin().getString("userLoginId"))!} -->	
	
<#macro showShoppingCart >
    <form method="post" action="<@ofbizUrl>modifycart</@ofbizUrl>" name="cartform">
        <input type="hidden" name="removeSelected" value="false" />
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th></th>
                        <th scope="row">${uiLabelMap.OrderProduct}</th>
                        <#if asslGiftWraps?has_content && productStore.showCheckoutGiftOptions! != "N">>
                            <th scope="row">
                            <select class="selectBox" name="GWALL" onchange="javascript:gwAll(this);">
                                <option value="">${uiLabelMap.EcommerceGiftWrapAllItems}</option>
                                <option value="NO^">${uiLabelMap.EcommerceNoGiftWrap}</option>
                                <#list allgiftWraps as option>
                                    <option value="${option.productFeatureId}">${option.description} : ${option.defaultAmount?default(0)}</option>
                                </#list>
                            </select>
                        <#else>
                            <th scope="row">&nbsp;</th>
                        </#if>
                        <#if fixedAssetExist == true>
                            <td>
                                <table>
                                    <tr>
                                        <td>- ${uiLabelMap.EcommerceStartDate} -</td>
                                        <td>- ${uiLabelMap.EcommerceNbrOfDays} -</td>
                                    </tr>
                                    <tr>
                                        <td >- ${uiLabelMap.EcommerceNbrOfPersons} -</td>
                                        <td >- ${uiLabelMap.CommonQuantity} -</td>
                                    </tr>
                                </table>
                            </td>
                        <#else>
                            <th scope="row">${uiLabelMap.CommonQuantity}</th>
                        </#if>
                        <th scope="row">${uiLabelMap.EcommerceUnitPrice}</th>
                        <th scope="row">${uiLabelMap.EcommerceAdjustments}</th>
                        <th scope="row">${uiLabelMap.EcommerceItemTotal}</th>
                        <th scope="row"><input type="checkbox" name="selectAll" value="0" onclick="javascript:toggleAll(this);" /></th>
                    </tr>                           
                </thead>
                <tbody>                         
                    <#assign itemsFromList = false />
                    <#assign promoItems = false />
                    <#list shoppingCart.items() as cartLine>
            
                        <#assign cartLineIndex = shoppingCart.getItemIndex(cartLine) />
                        <#assign lineOptionalFeatures = cartLine.getOptionalProductFeatures() />
                        <#-- show adjustment info -->
                        <#list cartLine.getAdjustments() as cartLineAdjustment>
                            <!-- cart line ${cartLineIndex} adjustment: ${cartLineAdjustment} -->
                        </#list>
            
                        <tr id="cartItemDisplayRow_${cartLineIndex}">
                            <td>
                                <#if cartLine.getShoppingListId()??>
                                  <#assign itemsFromList = true />
                                  <a href="<@ofbizUrl>editShoppingList?shoppingListId=${cartLine.getShoppingListId()}</@ofbizUrl>" class="linktext">L</a>&nbsp;&nbsp;
                                <#elseif cartLine.getIsPromo()>
                                  <#assign promoItems = true />
                                  <a href="<@ofbizUrl>view/showcart</@ofbizUrl>" class="button">P</a>&nbsp;&nbsp;
                                <#else>
                                  &nbsp;
                                </#if>
                            </td>
                            <td>
                                <#if cartLine.getProductId()??>
                                    <#-- product item -->
                                    <#-- start code to display a small image of the product -->
                                    <#if cartLine.getParentProductId()??>
                                      <#assign parentProductId = cartLine.getParentProductId() />
                                    <#else>
                                      <#assign parentProductId = cartLine.getProductId() />
                                    </#if>
                                    <#assign smallImageUrl = Static["org.ofbiz.product.product.ProductContentWrapper"].getProductContentAsText(cartLine.getProduct(), "SMALL_IMAGE_URL", locale, dispatcher)! />
                                    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg" /></#if>
                                    <#if smallImageUrl?string?has_content>
                                      <a href="<@ofbizCatalogAltUrl productId=parentProductId/>">
                                        <img src="<@ofbizContentUrl>${requestAttributes.contentPathPrefix!}${smallImageUrl}</@ofbizContentUrl>" alt="Product Image" class="imageborder" />
                                      </a>
                                    </#if>
                                    <#-- end code to display a small image of the product -->
                                    <#-- ${cartLineIndex} - -->
                                    <a href="<@ofbizCatalogAltUrl productId=parentProductId/>" class="linktext">
                                    ${cartLine.getName()!}</a> : ${cartLine.getDescription()!}
                                    <#-- For configurable products, the selected options are shown -->
                                    <#if cartLine.getConfigWrapper()??>
                                       <#assign selectedOptions = cartLine.getConfigWrapper().getSelectedOptions()! />
                                       <#if selectedOptions??>
                                           <div>&nbsp;</div>
                                           <#list selectedOptions as option>
                                               <div>
                                                   ${option.getDescription()}
                                               </div>
                                           </#list>
                                       </#if>
                                    </#if>
            
                                    <#-- if inventory is not required check to see if it is out of stock and needs to have a message shown about that... -->
                                    <#assign itemProduct = cartLine.getProduct() />
                                    <#assign isStoreInventoryNotRequiredAndNotAvailable = Static["org.ofbiz.product.store.ProductStoreWorker"].isStoreInventoryRequiredAndAvailable(request, itemProduct, cartLine.getQuantity(), false, false) />
                                    <#if isStoreInventoryNotRequiredAndNotAvailable && itemProduct.inventoryMessage?has_content>
                                       (${itemProduct.inventoryMessage})
                                    </#if>                  
                                <#else>
                                    <#-- this is a non-product item -->
                                    ${cartLine.getItemTypeDescription()!}: ${cartLine.getName()!}
                                </#if>
                                <#assign attrs = cartLine.getOrderItemAttributes()/>
                                <#if attrs?has_content>
                                   <#assign attrEntries = attrs.entrySet()/>
                                   <ul>
                                       <#list attrEntries as attrEntry>
                                           <li>
                                               ${attrEntry.getKey()} : ${attrEntry.getValue()}
                                           </li>
                                       </#list>
                                   </ul>
                                </#if>
                                <#if (cartLine.getIsPromo() && cartLine.getAlternativeOptionProductIds()?has_content)>
                                <#-- Show alternate gifts if there are any... -->
                                <div class="tableheadtext">${uiLabelMap.OrderChooseFollowingForGift}:</div>
                                    <select name="dummyAlternateGwpSelect${cartLineIndex}" onchange="setAlternateGwp(this);" class="selectBox">
                                       <option value="">- ${uiLabelMap.OrderChooseAnotherGift} -</option>
                                       <#list cartLine.getAlternativeOptionProductIds() as alternativeOptionProductId>
                                           <#assign alternativeOptionName = Static["org.ofbiz.product.product.ProductWorker"].getGwpAlternativeOptionName(dispatcher, delegator, alternativeOptionProductId, requestAttributes.locale) />
                                           <option value="<@ofbizUrl>setDesiredAlternateGwpProductId?alternateGwpProductId=${alternativeOptionProductId}&alternateGwpLine=${cartLineIndex}</@ofbizUrl>">${alternativeOptionName?default(alternativeOptionProductId)}</option>
                                       </#list>
                                    </select>
                                </#if>
                            </td>
            
                            <#-- gift wrap option -->
                            <#assign showNoGiftWrapOptions = false />
                            <td >
                                <#assign giftWrapOption = lineOptionalFeatures.GIFT_WRAP! />
                          <#assign selectedOption = cartLine.getAdditionalProductFeatureAndAppl("GIFT_WRAP")! />
                          <#if giftWrapOption?has_content>
                            <select class="selectBox" name="option^GIFT_WRAP_${cartLineIndex}" onchange="javascript:document.cartform.submit()">
                              <option value="NO^">${uiLabelMap.EcommerceNoGiftWrap}</option>
                              <#list giftWrapOption as option>
                                <option value="${option.productFeatureId}" <#if ((selectedOption.productFeatureId)?? && selectedOption.productFeatureId == option.productFeatureId)>selected="selected"</#if>>${option.description} : ${option.amount?default(0)}</option>
                              </#list>
                            </select>
                          <#elseif showNoGiftWrapOptions>
                            <select class="selectBox" name="option^GIFT_WRAP_${cartLineIndex}" onchange="javascript:document.cartform.submit()">
                              <option value="">${uiLabelMap.EcommerceNoGiftWrap}</option>
                            </select>
                          <#else>
                            &nbsp;
                          </#if>
                        </td>
                        <#-- end gift wrap option -->
            
                        <td>
                            <#if cartLine.getIsPromo() || cartLine.getShoppingListId()??>
                                   <#if fixedAssetExist == true>
                                    <#if cartLine.getReservStart()??>
                                        <table >
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>${cartLine.getReservStart()?string("yyyy-mm-dd")}</td>
                                                <td>${cartLine.getReservLength()?string.number}</td></tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>${cartLine.getReservPersons()?string.number}</td>
                                                <td>
                                    <#else>
                                        <table >
                                            <tr>
                                                <td >--</td>
                                                <td>--</td>
                                            </tr>
                                            <tr>
                                                <td>--</td>
                                                <td>    
                                    </#if>
                                    ${cartLine.getQuantity()?string.number}</td></tr></table>
                                <#else><#-- fixedAssetExist -->
                                    ${cartLine.getQuantity()?string.number}
                                </#if>
                            <#else><#-- Is Promo or Shoppinglist -->
                                   <#if fixedAssetExist == true><#if cartLine.getReservStart()??><table><tr><td>&nbsp;</td><td><input type="text" class="form-control" size="10" name="reservStart_${cartLineIndex}" value=${cartLine.getReservStart()?string}/></td><td><input type="text" class="form-control" size="2" name="reservLength_${cartLineIndex}" value="${cartLine.getReservLength()?string.number}"/></td></tr><tr><td>&nbsp;</td><td><input type="text" class="form-control" size="3" name="reservPersons_${cartLineIndex}" value=${cartLine.getReservPersons()?string.number} /></td><td><#else>
                                       <table><tr><td>--</td><td>--</td></tr><tr><td>--</td><td></#if>
                                    <input size="6" class="form-control" type="text" name="update_${cartLineIndex}" value="${cartLine.getQuantity()?string.number}" /></td></tr></table>
                                <#else><#-- fixedAssetExist -->
                                    <input size="6" class="form-control" type="text" name="update_${cartLineIndex}" value="${cartLine.getQuantity()?string.number}" />
                                </#if>
                            </#if>
                        </td>
                        <td><@ofbizCurrency amount=cartLine.getDisplayPrice() isoCode=shoppingCart.getCurrency()/></td>
                        <td><@ofbizCurrency amount=cartLine.getOtherAdjustments() isoCode=shoppingCart.getCurrency()/></td>
                        <td><@ofbizCurrency amount=cartLine.getDisplayItemSubTotal() isoCode=shoppingCart.getCurrency()/></td>
                        <td><#if !cartLine.getIsPromo()><input type="checkbox" name="selectedItem" value="${cartLineIndex}" onclick="javascript:checkToggle(this);" /><#else>&nbsp;</#if></td>
                      </tr>
                    </#list>
                </tbody>
                <tfoot>
                    <#if shoppingCart.getAdjustments()?has_content>
                        <tr>
                          <td colspan="5"></td> 
                          <td>${uiLabelMap.CommonSubTotal}:</td>
                          <td colspan="2"><@ofbizCurrency amount=shoppingCart.getDisplaySubTotal() isoCode=shoppingCart.getCurrency()/></td>
                          
                        </tr>
                        <#if (shoppingCart.getDisplayTaxIncluded() > 0.0)>
                          <tr>
                            <td colspan="5"></td>
                            <td>${uiLabelMap.OrderSalesTaxIncluded}:</td>
                            <td colspan="2"><@ofbizCurrency amount=shoppingCart.getDisplayTaxIncluded() isoCode=shoppingCart.getCurrency()/></td>
                            
                          </tr>
                        </#if>
                        <#list shoppingCart.getAdjustments() as cartAdjustment>
                          <#assign adjustmentType = cartAdjustment.getRelatedOne("OrderAdjustmentType", true) />
                          <tr>
                            <td colspan="5"></td>   
                            <td>
                                ${uiLabelMap.EcommerceAdjustment} - ${adjustmentType.get("description",locale)!}
                                <#if cartAdjustment.productPromoId?has_content><a href="<@ofbizUrl>showPromotionDetails?productPromoId=${cartAdjustment.productPromoId}</@ofbizUrl>" class="button">${uiLabelMap.CommonDetails}</a></#if>:
                            </td>
                            <td colspan="2"><@ofbizCurrency amount=Static["org.ofbiz.order.order.OrderReadHelper"].calcOrderAdjustment(cartAdjustment, shoppingCart.getSubTotal()) isoCode=shoppingCart.getCurrency()/></td>
                            
                          </tr>
                        </#list>
                    </#if>                      
                    <tr>
                        <td colspan="5"></th>
                        <td>${uiLabelMap.EcommerceCartTotal}:</td>
                        <td colspan="2"><@ofbizCurrency amount=shoppingCart.getDisplayGrandTotal() isoCode=shoppingCart.getCurrency()/></td>                                
                    </tr>
                    
                                                                    
                </tfoot>
            </table>
   
   
                <div class="btn-group pull-right">                    
                <#if (shoppingCartSize > 0)>
                    <a href="javascript:document.cartform.submit();" class="btn btn-default"><i class="fa fa-refresh"></i> ${uiLabelMap.EcommerceRecalculateCart}</a>
                    <a href="<@ofbizUrl>emptycart</@ofbizUrl>" class="btn btn-default"> <i class="fa fa-close"></i> ${uiLabelMap.EcommerceEmptyCart}</a>
                    <a href="javascript:removeSelected();" class="btn btn-default"> <i class="fa fa-trash-o"></i> ${uiLabelMap.EcommerceRemoveSelected}</a>
                <#else>
                    <span class="btn btn-default" disabled="disabled"> <i class="fa fa-refresh"></i> ${uiLabelMap.EcommerceRecalculateCart}</span>
                    <span class="btn btn-default" disabled="disabled"> <i class="fa fa-close"></i> ${uiLabelMap.EcommerceEmptyCart}</span>
                    <span class="btn btn-default" disabled="disabled"><i class="fa fa-trash-o"></i> ${uiLabelMap.EcommerceRemoveSelected}</span>
                </#if>                    
            </div>     
   
            </div>
        <!-- /.table-responsive -->
                    
   </form>
</#macro>

<#macro associatedProducts >    
	<#if associatedProducts?has_content>
	
        <div class="row">
            <div class="col-md-3">
                <div class="box">
                    <h3>You may also like these products</h3>
                </div>
            </div>	
	
			<div>
			    <div>
			        <h2>${uiLabelMap.EcommerceYouMightAlsoIntrested}:</h2>
			    </div>
			    <div>
			        <#-- random complementary products -->
			        <#list associatedProducts as assocProduct>
			            <div>
			                ${setRequestAttribute("optProduct", assocProduct)}
			                ${setRequestAttribute("listIndex", assocProduct_index)}
			                ${screens.render("component://ecommerce/widget/CatalogScreens.xml#productTile")}
			            </div>
			        </#list>
			    </div>
			</div>
        </div>			
	</#if>
</#macro>