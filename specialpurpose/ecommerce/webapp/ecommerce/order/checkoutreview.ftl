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

<script language="JavaScript" type="text/javascript">
<!--
    var clicked = 0;
    function processOrder() {
        if (clicked == 0) {
            clicked++;
            //window.location.replace("<@ofbizUrl>processorder</@ofbizUrl>");
            document.${parameters.formNameValue}.processButton.value="${uiLabelMap.OrderSubmittingOrder}";
            document.${parameters.formNameValue}.processButton.disabled=true;
            document.${parameters.formNameValue}.submit();
        } else {
            showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.YoureOrderIsBeingProcessed}");
        }
    }
// -->
</script>


<div class="col-md-12 clearfix">
    <ul class="breadcrumb">
        <li><a href="<@ofbizUrl>main</@ofbizUrl>">${uiLabelMap.CommonHome}</a>
        </li>
        <li>Checkout - ${uiLabelMap.OrderReview}</li>
    </ul>

    <div class="box text-center">

        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <h1>Checkout - ${uiLabelMap.OrderFinalCheckoutReview}</h1>
            </div>
        </div>
    </div>

</div>

<div class="col-md-9 clearfix" id="checkout">
    <div class="box">        
        <ul class="nav nav-pills nav-justified">
            <li class="active"><a href="#"><i class="fa fa-map-marker"></i><br>${uiLabelMap.CommonAddress}</a>
            </li>
            <li class="active"><a href="#"><i class="fa fa-truck"></i><br>${uiLabelMap.DeliveryOption}</a>
            </li>
            <li class="active"><a href="#"><i class="fa fa-money"></i><br>${uiLabelMap.PaymentOtpions}</a>
            </li>
            <li class="active"><a href="#"><i class="fa fa-eye"></i><br>${uiLabelMap.OrderReview}</a>
            </li>
        </ul>
        
        <div class="content">
            <#if !isDemoStore?? && isDemoStore><p>${uiLabelMap.OrderDemoFrontNote}.</p></#if>
        
            <#if cart?? && 0 < cart.size()>
                ${screens.render("component://ecommerce/widget/OrderScreens.xml#orderheader")}
                <br />
                ${screens.render("component://ecommerce/widget/OrderScreens.xml#orderitems")}
                <br/>                
                <div class="box-footer">
                    <div class="pull-right">
	                    <form type="post" action="<@ofbizUrl>processorder</@ofbizUrl>" name="${parameters.formNameValue}">
	                        <#if (requestParameters.checkoutpage)?has_content>
	                            <input type="hidden" name="checkoutpage" value="${requestParameters.checkoutpage}" />
	                        </#if>
	                        <#if (requestAttributes.issuerId)?has_content>
	                            <input type="hidden" name="issuerId" value="${requestAttributes.issuerId}" />
	                        </#if>
	                            <input type="button" name="processButton" value="${uiLabelMap.OrderSubmitOrder}" onclick="processOrder();" class="btn btn-primary" />
	                    </form>
                    </div>                    
                </div>
            <#else>
                <h3>${uiLabelMap.OrderErrorShoppingCartEmpty}.</h3>
            </#if>
        </div>
    </div><!-- ./box -->
</div>                        



















