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


<!-- TODO : Need formatting -->
<script type="text/javascript">
//<![CDATA[
function submitForm(form, mode, value) {
    if (mode == "DN") {
        // done action; checkout
        form.action="<@ofbizUrl>checkoutoptions</@ofbizUrl>";
        form.submit();
    } else if (mode == "CS") {
        // continue shopping
        form.action="<@ofbizUrl>updateCheckoutOptions/showcart</@ofbizUrl>";
        form.submit();
    } else if (mode == "NC") {
        // new credit card
        form.action="<@ofbizUrl>updateCheckoutOptions/editcreditcard?DONE_PAGE=checkoutpayment</@ofbizUrl>";
        form.submit();
    } else if (mode == "EC") {
        // edit credit card
        form.action="<@ofbizUrl>updateCheckoutOptions/editcreditcard?DONE_PAGE=checkoutpayment&paymentMethodId="+value+"</@ofbizUrl>";
        form.submit();
    } else if (mode == "GC") {
        // edit gift card
        form.action="<@ofbizUrl>updateCheckoutOptions/editgiftcard?paymentMethodId="+value+"</@ofbizUrl>";
        form.submit();
    } else if (mode == "NE") {
        // new eft account
        form.action="<@ofbizUrl>updateCheckoutOptions/editeftaccount?DONE_PAGE=checkoutpayment</@ofbizUrl>";
        form.submit();
    } else if (mode == "EE") {
        // edit eft account
        form.action="<@ofbizUrl>updateCheckoutOptions/editeftaccount?DONE_PAGE=checkoutpayment&paymentMethodId="+value+"</@ofbizUrl>";
        form.submit();
    }else if(mode = "EG")
    //edit gift card
        form.action="<@ofbizUrl>updateCheckoutOptions/editgiftcard?DONE_PAGE=checkoutpayment&paymentMethodId="+value+"</@ofbizUrl>";
        form.submit();
}
//]]>
$(document).ready(function(){
var issuerId = "";
    if ($('#checkOutPaymentId_IDEAL').attr('checked') == true) {
        $('#issuers').show();
        issuerId = $('#issuer').val();
        $('#issuerId').val(issuerId);
    } else {
        $('#issuers').hide();
        $('#issuerId').val('');
    }
    $('input:radio').click(function(){
        if ($(this).val() == "EXT_IDEAL") {
            $('#issuers').show();
            issuerId = $('#issuer').val();
            $('#issuerId').val(issuerId);
        } else {
            $('#issuers').hide();
            $('#issuerId').val('');
        }
    });
    $('#issuer').change(function(){
        issuerId = $(this).val();
        $('#issuerId').val(issuerId);
    });
});
</script>

 
<#assign cart = shoppingCart! />

<#import "component://ecommerce/webapp/ecommerce/order/paymentoptions.ftl" as paymentOptionMacro>

<div class="col-md-12 clearfix">
    <ul class="breadcrumb">
        <li><a href="<@ofbizUrl>main</@ofbizUrl>">${uiLabelMap.CommonHome}</a>
        </li>
        <li>Checkout - ${uiLabelMap.PaymentOtpions}</li>
    </ul>

    <div class="box text-center">

        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <h1>Checkout - ${uiLabelMap.PaymentOtpions}</h1>
            </div>
        </div>
    </div>

</div>

<div class="col-md-9 clearfix" id="checkout">
    <div class="box">
        <form method="post" name="checkoutInfoForm">
            <ul class="nav nav-pills nav-justified">
                <li class="active"><a href="#"><i class="fa fa-map-marker"></i><br>${uiLabelMap.CommonAddress}</a>
                </li>
                <li class="active"><a href="#"><i class="fa fa-truck"></i><br>${uiLabelMap.DeliveryOption}</a>
                </li>
                <li class="active"><a href="#"><i class="fa fa-money"></i><br>${uiLabelMap.PaymentOtpions}</a>
                </li>
                <li class="disabled"><a href="#"><i class="fa fa-eye"></i><br>${uiLabelMap.OrderReview}</a>
                </li>
            </ul>
            
            <div class="content">
                
                <input type="hidden" name="checkoutpage" value="payment" />
                <input type="hidden" name="BACK_PAGE" value="checkoutoptions" />
                <input type="hidden" name="issuerId" id="issuerId" value="" />
                
                <@paymentOptionMacro.paymentOptionReg />

                <#-- special billing account functionality to allow use w/ a payment method -->
                <#if productStorePaymentMethodTypeIdMap.EXT_BILLACT??>
                    <#if billingAccountList?has_content>
                        <div>
                            <select name="billingAccountId" id="billingAccountId">
                                <option value=""></option>
                                <#list billingAccountList as billingAccount>
                                    <#assign availableAmount = billingAccount.accountBalance>
                                    <#assign accountLimit = billingAccount.accountLimit>
                                    <option value="${billingAccount.billingAccountId}" <#if billingAccount.billingAccountId == selectedBillingAccountId?default("")>selected="selected"</#if>>${billingAccount.description?default("")} [${billingAccount.billingAccountId}] ${uiLabelMap.EcommerceAvailable} <@ofbizCurrency amount=availableAmount isoCode=billingAccount.accountCurrencyUomId/> ${uiLabelMap.EcommerceLimit} <@ofbizCurrency amount=accountLimit isoCode=billingAccount.accountCurrencyUomId/></option>
                                </#list>
                            </select>
                            <label for="billingAccountId">${uiLabelMap.FormFieldTitle_billingAccountId}</label>
                        </div>
                        <div>
                            <input type="text" size="5" id="billingAccountAmount" name="billingAccountAmount" value="" />
                            <label for="billingAccountAmount">${uiLabelMap.OrderBillUpTo}</label>
                        </div>
                    </#if>
                </#if>
                <#-- end of special billing account functionality -->

                <#if productStorePaymentMethodTypeIdMap.GIFT_CARD??>
                
                    <div class="form-group">
                        <input type="checkbox" id="addGiftCard" name="addGiftCard" value="Y" />
                        <input type="hidden" name="singleUseGiftCard" value="Y" />
                        <label for="addGiftCard">${uiLabelMap.AccountingUseGiftCardNotOnFile}</label>
                    </div>                    
                    <div class="row">
                        <div class="col-sm-4">
	                        <div class="form-group">
	                            <label for="giftCardNumber">${uiLabelMap.AccountingNumber}</label>
	                            <input type="text" size="15" class="form-control" id="giftCardNumber" name="giftCardNumber" value="${(requestParameters.giftCardNumber)!}" onfocus="document.getElementById('addGiftCard').checked=true;" />
	                        </div>
                        </div>
                        <#if cart.isPinRequiredForGC(delegator)>
	                        <div class="col-sm-4">
	                            <div class="form-group">
	                                <label for="giftCardPin">${uiLabelMap.AccountingPIN}</label>
                                    <input type="text" size="10" class="form-control" id="giftCardPin" name="giftCardPin" value="${(requestParameters.giftCardPin)!}" onfocus="document.getElementById('addGiftCard').checked=true;" />
	                            </div>
	                        </div>
                        </#if>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="giftCardAmount">${uiLabelMap.AccountingAmount}</label>
                                <input type="text" size="6" class="form-control" id="giftCardAmount" name="giftCardAmount" value="${(requestParameters.giftCardAmount)!}" onfocus="document.getElementById('addGiftCard').checked=true;" />
                            </div>
                        </div>
                    </div>                  
	            </#if>

	            <div>
	                <#if productStorePaymentMethodTypeIdMap.CREDIT_CARD??><a href="<@ofbizUrl>setBilling?paymentMethodType=CC&amp;singleUsePayment=Y</@ofbizUrl>" class="btn btn-link">${uiLabelMap.AccountingSingleUseCreditCard}</a></#if>
	                <#if productStorePaymentMethodTypeIdMap.GIFT_CARD??><a href="<@ofbizUrl>setBilling?paymentMethodType=GC&amp;singleUsePayment=Y</@ofbizUrl>" class="btn btn-link">${uiLabelMap.AccountingSingleUseGiftCard}</a></#if>
	                <#if productStorePaymentMethodTypeIdMap.EFT_ACCOUNT??><a href="<@ofbizUrl>setBilling?paymentMethodType=EFT&amp;singleUsePayment=Y</@ofbizUrl>" class="btn btn-link">${uiLabelMap.AccountingSingleUseEFTAccount}</a></#if>
	            </div>
	            <#-- End Payment Method Selection -->	            
            </div>                                  
        </form>
        
        
        <div class="box-footer">
            <div class="pull-left">                    
                <a href="javascript:submitForm(document.checkoutInfoForm, 'CS', '');" class="btn btn-default"><i class="fa fa-chevron-left"></i> ${uiLabelMap.OrderBacktoShoppingCart}</a>
            </div>
            <div class="pull-right">
                <a href="javascript:submitForm(document.checkoutInfoForm, 'DN', '');" class="btn btn-primary">${uiLabelMap.OrderContinueToFinalOrderReview} <i class="fa fa-chevron-right"></i></a>
            </div>
        </div>  
                
    </div><!-- ./box -->
    
</div>            
        


<div>
  <a href="javascript:submitForm(document.getElementById('checkoutInfoForm'), 'CS', '');" class="buttontextbig">${uiLabelMap.OrderBacktoShoppingCart}</a>
  <a href="javascript:submitForm(document.getElementById('checkoutInfoForm'), 'DN', '');" class="buttontextbig">${uiLabelMap.OrderContinueToFinalOrderReview}</a>
</div>
