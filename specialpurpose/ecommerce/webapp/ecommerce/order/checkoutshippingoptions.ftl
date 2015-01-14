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
    } else if (mode == "NA") {
        // new address
        form.action="<@ofbizUrl>updateCheckoutOptions/editcontactmech?preContactMechTypeId=POSTAL_ADDRESS&contactMechPurposeTypeId=SHIPPING_LOCATION&DONE_PAGE=checkoutoptions</@ofbizUrl>";
        form.submit();
    } else if (mode == "EA") {
        // edit address
        form.action="<@ofbizUrl>updateCheckoutOptions/editcontactmech?DONE_PAGE=checkoutshippingaddress&contactMechId="+value+"</@ofbizUrl>";
        form.submit();
    } else if (mode == "NC") {
        // new credit card
        form.action="<@ofbizUrl>updateCheckoutOptions/editcreditcard?DONE_PAGE=checkoutoptions</@ofbizUrl>";
        form.submit();
    } else if (mode == "EC") {
        // edit credit card
        form.action="<@ofbizUrl>updateCheckoutOptions/editcreditcard?DONE_PAGE=checkoutoptions&paymentMethodId="+value+"</@ofbizUrl>";
        form.submit();
    } else if (mode == "NE") {
        // new eft account
        form.action="<@ofbizUrl>updateCheckoutOptions/editeftaccount?DONE_PAGE=checkoutoptions</@ofbizUrl>";
        form.submit();
    } else if (mode == "EE") {
        // edit eft account
        form.action="<@ofbizUrl>updateCheckoutOptions/editeftaccount?DONE_PAGE=checkoutoptions&paymentMethodId="+value+"</@ofbizUrl>";
        form.submit();
    }
}

//]]>
</script>

<#import "component://ecommerce/webapp/ecommerce/order/optionsettings.ftl" as shipmentOptionsMacro>

<div class="col-md-12 clearfix">
    <ul class="breadcrumb">
        <li><a href="<@ofbizUrl>main</@ofbizUrl>">${uiLabelMap.CommonHome}</a>
        </li>
        <li>Checkout - ${uiLabelMap.DeliveryOption}</li>
    </ul>

    <div class="box text-center">

        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <h1>Checkout - ${uiLabelMap.DeliveryOption}</h1>
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
                <li class="disabled"><a href="#"><i class="fa fa-money"></i><br>${uiLabelMap.PaymentOtpions}</a>
                </li>
                <li class="disabled"><a href="#"><i class="fa fa-eye"></i><br>${uiLabelMap.OrderReview}</a>
                </li>
            </ul>
            
            <div class="content">
                
				<input type="hidden" name="checkoutpage" value="shippingoptions"/>
				<@shipmentOptionsMacro.shipmentOptions />
				
            </div>                                  
        </form>
        
        <div class="box">
            <div>${uiLabelMap.OrderEmailSentToFollowingAddresses}:</div>
            <div>                    
                <#list emailList as email>
                    ${email.infoString!}<#if email_has_next>,</#if>
                </#list>
            </div>
            <div>${uiLabelMap.OrderUpdateEmailAddress} <a href="<@ofbizUrl>viewprofile?DONE_PAGE=checkoutoptions</@ofbizUrl>" class="btn btn-default">${uiLabelMap.PartyProfile}</a>.</div>
  
                <div>${uiLabelMap.OrderCommaSeperatedEmailAddresses}:</div>
            <input type="text" class="btn btn-default " size="30" name="order_additional_emails" value="${shoppingCart.getOrderAdditionalEmails()!}"/>
        </div>
        
        
		<div class="box-footer">
		    <div class="pull-left">                    
		        <a href="javascript:submitForm(document.checkoutInfoForm, 'CS', '');" class="btn btn-default"><i class="fa fa-chevron-left"></i> ${uiLabelMap.OrderBacktoShoppingCart}</a>
		    </div>
		    <div class="pull-right">
		        <a href="javascript:submitForm(document.checkoutInfoForm, 'DN', '');" class="btn btn-primary">${uiLabelMap.CommonNext} <i class="fa fa-chevron-right"></i></a>
		    </div>
		</div>         
    </div>    
</div>                                

 
