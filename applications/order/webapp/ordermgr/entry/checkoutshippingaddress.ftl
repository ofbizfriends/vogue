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
        form.action="<@ofbizUrl>updateCheckoutOptions/editcontactmech?preContactMechTypeId=POSTAL_ADDRESS&contactMechPurposeTypeId=SHIPPING_LOCATION&DONE_PAGE=checkoutshippingaddress</@ofbizUrl>";
        form.submit();
    } else if (mode == "EA") {
        // edit address
        form.action="<@ofbizUrl>updateCheckoutOptions/editcontactmech?DONE_PAGE=checkoutshippingaddress&contactMechId="+value+"</@ofbizUrl>";
        form.submit();
    }
}

function toggleBillingAccount(box) {
    var amountName = box.value + "_amount";
    box.checked = true;
    box.form.elements[amountName].disabled = false;

    for (var i = 0; i < box.form.elements[box.name].length; i++) {
        if (!box.form.elements[box.name][i].checked) {
            box.form.elements[box.form.elements[box.name][i].value + "_amount"].disabled = true;
        }
    }
}

//]]>
</script>
<#assign cart = shoppingCart!/>


<div class="col-md-12 clearfix">
    <ul class="breadcrumb">
        <li><a href="<@ofbizUrl>main</@ofbizUrl>">${uiLabelMap.CommonHome}</a>
        </li>
        <li>Checkout - ${uiLabelMap.CommonAddress}</li>
    </ul>

    <div class="box text-center">

        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <h1>Checkout - ${uiLabelMap.CommonAddress}</h1>
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
                <li class="disabled"><a href="#"><i class="fa fa-truck"></i><br>${uiLabelMap.DeliveryOption}</a>
                </li>
                <li class="disabled"><a href="#"><i class="fa fa-money"></i><br>${uiLabelMap.PaymentOtpions}</a>
                </li>
                <li class="disabled"><a href="#"><i class="fa fa-eye"></i><br>${uiLabelMap.OrderReview}</a>
                </li>
            </ul>

            <div class="content">
                
                    <h4>${uiLabelMap.OrderWhereShallWeShipIt}?</h4>
                    <input type="hidden" name="checkoutpage" value="shippingaddress"/>
                    <div class="form-group">
                        <a href="<@ofbizUrl>splitship</@ofbizUrl>" class="btn btn-default">${uiLabelMap.OrderSplitShipment}</a>
                        <a href="javascript:submitForm(document.checkoutInfoForm, 'NA', '');" class="btn btn-default">${uiLabelMap.PartyAddNewAddress}</a>
                        <#if (cart.getShipGroupSize() > 1)>
                            <div class="text-danger">${uiLabelMap.OrderNOTEMultipleShipmentsExist}</div>
                        </#if>
                    </div>
                    
                    <div class="box">
                        <table class="table">
                            <#if shippingContactMechList?has_content>
                                <tr><td colspan="2"><hr /></td></tr>
                                <#list shippingContactMechList as shippingContactMech>
                                    <#assign shippingAddress = shippingContactMech.getRelatedOne("PostalAddress", false)>
                                    <#assign checkThisAddress = (shippingContactMech_index == 0 && !cart.getShippingContactMechId()?has_content) || (cart.getShippingContactMechId()?default("") == shippingAddress.contactMechId)/>
                                    <tr>
                                        <td valign="top" width="1%" nowrap="nowrap">
                                            <input type="radio" name="shipping_contact_mech_id" value="${shippingAddress.contactMechId}"<#if checkThisAddress> checked="checked"</#if> />
                                        </td>
			                            <td valign="top" width="99%" nowrap="nowrap">
                                            <div>
                                                <#if shippingAddress.toName?has_content><b>${uiLabelMap.CommonTo}:</b>&nbsp;${shippingAddress.toName}<br /></#if>
												<#if shippingAddress.attnName?has_content><b>${uiLabelMap.PartyAddrAttnName}:</b>&nbsp;${shippingAddress.attnName}<br /></#if>
												<#if shippingAddress.address1?has_content>${shippingAddress.address1}<br /></#if>
												<#if shippingAddress.address2?has_content>${shippingAddress.address2}<br /></#if>
												<#if shippingAddress.city?has_content>${shippingAddress.city}</#if>
												<#if shippingAddress.stateProvinceGeoId?has_content><br />${shippingAddress.stateProvinceGeoId}</#if>
												<#if shippingAddress.postalCode?has_content><br />${shippingAddress.postalCode}</#if>
												<#if shippingAddress.countryGeoId?has_content><br />${shippingAddress.countryGeoId}</#if>
                                                <a href="javascript:submitForm(document.checkoutInfoForm, 'EA', '${shippingAddress.contactMechId}');" class="btn btn-default">${uiLabelMap.CommonUpdate}</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr><td colspan="2"><hr /></td></tr>
                                </#list>
                            <#else>
                                ${uiLabelMap.EcommerceDefaultShipmentMethodMsg}           
                            </#if>
                        </table>
                    </div><!-- ./box -->                        
                    <#if agreements?has_content>
                        <div class="box">
	                        <div>&nbsp;${uiLabelMap.AccountingAgreementInformation}</div>
	                        <table class="table">			                     
	                            <#if agreements.size()!=1>
	                                <tr>
	                                    <td>&nbsp;</td>
		                                <td align='left' valign='top' nowrap="nowrap">
			                                <div class='tableheadtext'>
			                                     ${uiLabelMap.OrderSelectAgreement}
			                                </div>
		                                </td>
		                                <td>&nbsp;</td>
		                                <td valign='middle'>
	                                        <div class='tabletext' valign='top'>
	                                            <select name="agreementId">
	                                                <#list agreements as agreement>
	                                                    <option value='${agreement.agreementId!}'>${agreement.agreementId} - ${agreement.description!}</option>
	                                                </#list>
	                                            </select>
	                                        </div>
	                                    </td>
	                                </tr>
	                            <#else>
	                                <#list agreements as agreement>
	                                    <input type="radio" name="agreementId" value="${agreement.agreementId!}"<#if checkThisAddress> checked="checked"</#if> />${agreement.description!} will be used for this order.
	                                </#list>
	                            </#if>
	                        </table>
                        </div>
                    </#if>      
			                
			                
			        <br />
			        <#-- Party Tax Info -->
                    <#--
                    <div>&nbsp;${uiLabelMap.PartyTaxIdentification}</div>
			                ${screens.render("component://order/widget/ordermgr/OrderEntryOrderScreens.xml#customertaxinfo")}
			        </div>
			        -->
			                                                                
            </div>

            <div class="box-footer">
                <div class="pull-left">                    
                    <a href="javascript:submitForm(document.checkoutInfoForm, 'CS', '');" class="btn btn-default"><i class="fa fa-chevron-left"></i> ${uiLabelMap.OrderBacktoShoppingCart}</a>
                </div>
                <div class="pull-right">
                    <a href="javascript:submitForm(document.checkoutInfoForm, 'DN', '');" class="btn btn-primary">${uiLabelMap.CommonNext} <i class="fa fa-chevron-right"></i></a>
                </div>
            </div>
        </form>
    </div>
    <!-- /.box -->


</div>

















