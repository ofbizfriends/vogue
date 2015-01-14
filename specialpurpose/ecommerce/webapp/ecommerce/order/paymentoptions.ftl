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

<div class="col-md-6">
    <h3>${uiLabelMap.AccountingPaymentInformation}</h3>
    <#-- initial screen show a list of options -->
    <form id="editPaymentOptions" method="post" action="<@ofbizUrl>setPaymentInformation</@ofbizUrl>" name="${parameters.formNameValue}">

	    <#if productStorePaymentMethodTypeIdMap.GIFT_CARD??>
	        <div class="form-group">
	            <input type="checkbox" name="addGiftCard" value="Y" <#if addGiftCard?? && addGiftCard == "Y">checked="checked"</#if> />
	            <label for="addGiftCard">${uiLabelMap.AccountingCheckGiftCard}</label>
	        </div>
	        <hr/>
	    </#if>        
        <@paymentOptionReg /> 
        <div class="form-group">
            <input type="submit" class="btn btn-default" value="${uiLabelMap.CommonContinue}"/>
        </div>        
    </form>
</div>

<#macro paymentOptionReg >
    <#if productStorePaymentMethodTypeIdMap.EXT_OFFLINE??>
        <div class="form-group">
            <input type="radio" id="paymentMethodTypeId_EXT_OFFLINE" name="paymentMethodTypeId" value="EXT_OFFLINE" <#if paymentMethodTypeId?? && paymentMethodTypeId == "EXT_OFFLINE">checked="checked"</#if> />
            <label for="paymentMethodTypeId_EXT_OFFLINE">${uiLabelMap.OrderPaymentOfflineCheckMoney}</label>
        </div>
    </#if>
    <#if productStorePaymentMethodTypeIdMap.CREDIT_CARD??>
        <div class="form-group">
            <input type="radio" id="paymentMethodTypeId_CREDIT_CARD" name="paymentMethodTypeId" value="CREDIT_CARD" <#if paymentMethodTypeId?? && paymentMethodTypeId == "CREDIT_CARD">checked="checked"</#if> />
            <label for="paymentMethodTypeId_CREDIT_CARD">${uiLabelMap.AccountingVisaMastercardAmexDiscover}</label>
        </div>
    </#if>
    <#if productStorePaymentMethodTypeIdMap.EFT_ACCOUNT??>
        <div class="form-group">
            <input type="radio" id="paymentMethodTypeId_EFT_ACCOUNT" name="paymentMethodTypeId" value="EFT_ACCOUNT" <#if paymentMethodTypeId?? && paymentMethodTypeId == "EFT_ACCOUNT">checked="checked"</#if> />
            <label for="paymentMethodTypeId_EFT_ACCOUNT">${uiLabelMap.AccountingAHCElectronicCheck}</label>
        </div>
    </#if>
    <#if productStorePaymentMethodTypeIdMap.EXT_PAYPAL??>
        <div class="form-group">
            <input type="radio" id="paymentMethodTypeId_EXT_PAYPAL" name="paymentMethodTypeId" value="EXT_PAYPAL" <#if paymentMethodTypeId?? && paymentMethodTypeId == "EXT_PAYPAL">checked="checked"</#if> />
            <label for="paymentMethodTypeId_EXT_PAYPAL">${uiLabelMap.AccountingPayWithPayPal}</label>
        </div>
    </#if>
    
    <#--  options available to authenticated users only -->
    <#if sessionAttributes.userLogin?has_content && sessionAttributes.userLogin.userLoginId != "anonymous">
    
        <#if productStorePaymentMethodTypeIdMap.EXT_COD??>
            <div class="form-group">
                  <input type="radio" id="checkOutPaymentId_COD" name="checkOutPaymentId" value="EXT_COD" <#if "EXT_COD" == checkOutPaymentId>checked="checked"</#if> />
                  <label for="checkOutPaymentId_COD">${uiLabelMap.OrderCOD}</label>
            </div>
        </#if>
        <#if productStorePaymentMethodTypeIdMap.EXT_WORLDPAY??>
            <div class="form-group">
                  <input type="radio" id="checkOutPaymentId_WORLDPAY" name="checkOutPaymentId" value="EXT_WORLDPAY" <#if "EXT_WORLDPAY" == checkOutPaymentId>checked="checked"</#if> />
                  <label for="checkOutPaymentId_WORLDPAY">${uiLabelMap.AccountingPayWithWorldPay}</label>
            </div>
        </#if>
        <#if productStorePaymentMethodTypeIdMap.EXT_IDEAL??>
            <div>
                <input type="radio" id="checkOutPaymentId_IDEAL" name="checkOutPaymentId" value="EXT_IDEAL" <#if "EXT_IDEAL" == checkOutPaymentId>checked="checked"</#if> />
                <label for="checkOutPaymentId_IDEAL">${uiLabelMap.AccountingPayWithiDEAL}</label>
            </div>              
            <div id="issuers">
                <div><label >${uiLabelMap.AccountingBank}</label></div>
                <select name="issuer" id="issuer">
                    <#if issuerList?has_content>
                        <#list issuerList as issuer>
                            <option value="${issuer.getIssuerID()}" >${issuer.getIssuerName()}</option>
                        </#list>
                    </#if>
                </select>
            </div>
        </#if>
    </#if>
    
    
    <#if !paymentMethodList?has_content>
        <div>
            <strong>${uiLabelMap.AccountingNoPaymentMethods}.</strong>
        </div>
    <#else>
        <#list paymentMethodList as paymentMethod>
            <#if paymentMethod.paymentMethodTypeId == "GIFT_CARD">
                <#if productStorePaymentMethodTypeIdMap.GIFT_CARD??>
                    <#assign giftCard = paymentMethod.getRelatedOne("GiftCard", false) />

                    <#if giftCard?has_content && giftCard.cardNumber?has_content>
                        <#assign giftCardNumber = "" />
                        <#assign pcardNumber = giftCard.cardNumber />
                        <#if pcardNumber?has_content>
                            <#assign psize = pcardNumber?length - 4 />
                            <#if 0 &lt; psize>
                                <#list 0 .. psize-1 as foo>
                                    <#assign giftCardNumber = giftCardNumber + "*" />
                                </#list>
                                <#assign giftCardNumber = giftCardNumber + pcardNumber[psize .. psize + 3] />
                            <#else>
                                <#assign giftCardNumber = pcardNumber />
                            </#if>
                        </#if>
                    </#if>

                    <div>
                        <input type="checkbox" id="checkOutPayment_${paymentMethod.paymentMethodId}" name="checkOutPaymentId" value="${paymentMethod.paymentMethodId}" <#if cart.isPaymentSelected(paymentMethod.paymentMethodId)>checked="checked"</#if> />
                        <label for="checkOutPayment_${paymentMethod.paymentMethodId}">${uiLabelMap.AccountingGift}:${giftCardNumber}</label>
                        <#if paymentMethod.description?has_content>(${paymentMethod.description})</#if>
                        <a href="javascript:submitForm(document.getElementById('checkoutInfoForm'), 'EG', '${paymentMethod.paymentMethodId}');" class="button">${uiLabelMap.CommonUpdate}</a>
                        <strong>${uiLabelMap.OrderBillUpTo}:</strong> <input type="text" size="5" class="inputBox" name="amount_${paymentMethod.paymentMethodId}" value="<#if (cart.getPaymentAmount(paymentMethod.paymentMethodId)?default(0) > 0)>${cart.getPaymentAmount(paymentMethod.paymentMethodId)?string("##0.00")}</#if>" />
                    </div>
                </#if>
            <#elseif paymentMethod.paymentMethodTypeId == "CREDIT_CARD">
                <#if productStorePaymentMethodTypeIdMap.CREDIT_CARD??>
                    <#assign creditCard = paymentMethod.getRelatedOne("CreditCard", false) />
                    <div>
                        <input type="checkbox" id="checkOutPayment_${paymentMethod.paymentMethodId}" name="checkOutPaymentId" value="${paymentMethod.paymentMethodId}" <#if cart.isPaymentSelected(paymentMethod.paymentMethodId)>checked="checked"</#if> />
                        <label for="checkOutPayment_${paymentMethod.paymentMethodId}">CC:${Static["org.ofbiz.party.contact.ContactHelper"].formatCreditCard(creditCard)}</label>
                        <#if paymentMethod.description?has_content>(${paymentMethod.description})</#if>
                        <a href="javascript:submitForm(document.getElementById('checkoutInfoForm'), 'EC', '${paymentMethod.paymentMethodId}');" class="button">${uiLabelMap.CommonUpdate}</a>
                        <label for="amount_${paymentMethod.paymentMethodId}"><strong>${uiLabelMap.OrderBillUpTo}:</strong></label><input type="text" size="5" class="inputBox" id="amount_${paymentMethod.paymentMethodId}" name="amount_${paymentMethod.paymentMethodId}" value="<#if (cart.getPaymentAmount(paymentMethod.paymentMethodId)?default(0) > 0)>${cart.getPaymentAmount(paymentMethod.paymentMethodId)?string("##0.00")}</#if>" />
                    </div>
                </#if>
            <#elseif paymentMethod.paymentMethodTypeId == "EFT_ACCOUNT">
                <#if productStorePaymentMethodTypeIdMap.EFT_ACCOUNT??>
                    <#assign eftAccount = paymentMethod.getRelatedOne("EftAccount", false) />
                    <div>
                        <input type="radio" id="checkOutPayment_${paymentMethod.paymentMethodId}" name="checkOutPaymentId" value="${paymentMethod.paymentMethodId}" <#if paymentMethod.paymentMethodId == checkOutPaymentId>checked="checked"</#if> />
                        <label for="checkOutPayment_${paymentMethod.paymentMethodId}">${uiLabelMap.AccountingEFTAccount}:${eftAccount.bankName!}: ${eftAccount.accountNumber!}</label>
                        <#if paymentMethod.description?has_content><p>(${paymentMethod.description})</p></#if>
                        <a href="javascript:submitForm(document.getElementById('checkoutInfoForm'), 'EE', '${paymentMethod.paymentMethodId}');" class="button">${uiLabelMap.CommonUpdate}</a>
                    </div>
                </#if>
            </#if>
        </#list>
    </#if>    
    
</#macro>