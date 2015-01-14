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
<script language="javascript" type="text/javascript">
function submitForm(form) {
   form.submit();
}
</script>
<div class="box">
    <div class="btn-group">
	    <a class="btn btn-default" href="<@ofbizUrl>setCustomer</@ofbizUrl>" <#if callSubmitForm??>onclick="javascript:submitForm(document.${parameters.formNameValue!});"</#if>>Personal Info</a>
	    <#if (enableShippingAddress)??>
	        <a class="btn btn-default" href="<@ofbizUrl>setShipping</@ofbizUrl>" <#if callSubmitForm??>onclick="javascript:submitForm(document.${parameters.formNameValue!});"</#if>>Shipping Address</a>
	    <#else>
	        <span class="btn btn-default" disabled="disabled">Shipping Address</span>
	    </#if>
	    <#if (enableShipmentMethod)??>
	        <a class="btn btn-default" href="<@ofbizUrl>setShipOptions</@ofbizUrl>" <#if callSubmitForm??>onclick="javascript:submitForm(document.${parameters.formNameValue!});"</#if>>Shipping Options</a>
	    <#else>
	        <span class="btn btn-default" disabled="disabled">Shipping Options</span>
	    </#if>
	    <#if (enablePaymentOptions)??>
	        <a class="btn btn-default" href="<@ofbizUrl>setPaymentOption</@ofbizUrl>" <#if callSubmitForm??>onclick="javascript:submitForm(document.${parameters.formNameValue!});"</#if>>Payment Options</a>
	    <#else>
	        <span class="btn btn-default" disabled="disabled">Payment Options</span>
	    </#if>
	    <#if (enablePaymentInformation)??>
	        <a class="btn btn-default" href="<@ofbizUrl>setPaymentInformation?paymentMethodTypeId=${requestParameters.paymentMethodTypeId!}</@ofbizUrl>" <#if callSubmitForm??>onclick="javascript:submitForm(document.${parameters.formNameValue!});"</#if>>Payment Information</a>
	    <#else>
	        <span class="btn btn-default" disabled="disabled">Payment Information</span>
	    </#if>
	    <#if (enableReviewOrder)??>
	        <a class="btn btn-default" href="<@ofbizUrl>reviewOrder</@ofbizUrl>" <#if callSubmitForm??>onclick="javascript:submitForm(document.${parameters.formNameValue!});"</#if>>Review Order</a>
	    <#else>
	        <span class="btn btn-default" disabled="disabled">Review Order</span>
	    </#if>
    </div>
</div>
