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

<#if party??>
	<div class="col-md-12 clearfix">
	    <div class="box text-center">
	        <div class="row">
	            <div class="col-sm-10 col-sm-offset-1">
	                <h1>
	                <#if person??>
			          ${person.personalTitle!}
			          ${person.firstName!}
			          ${person.middleName!}
			          ${person.lastName!}
			          ${person.suffix!}
			        <#else>
			          "${uiLabelMap.PartyNewUser}"
			        </#if>
	                </h1>
	                   
		            <a href="<@ofbizUrl>editperson</@ofbizUrl>" class="btn btn-default">
		               <#if person??>${uiLabelMap.CommonUpdate}<#else>${uiLabelMap.CommonCreate}</#if>
		            </a>
	                <a href="<@ofbizUrl>changepassword</@ofbizUrl>" class="btn btn-default">${uiLabelMap.PartyChangePassword}</a>
	                
	            </div>
	        </div>
	    </div>
	</div>
	<#-- Main Heading -->
	
	<div class="col-md-9">
	
	    <#if (productStore.enableDigProdUpload)! == "Y">
	        <a href="<@ofbizUrl>digitalproductlist</@ofbizUrl>" class="btn btn-default">${uiLabelMap.EcommerceDigitalProductUpload}</a>
	    </#if>
		
	    <@contactDetails />
	    
	    <#--    
	    <@paymentDetails />
	    -->
	    <#-- ============================================================= -->
		<#--
		<div class="screenlet">
		  <h3>${uiLabelMap.PartyTaxIdentification}</h3>
		  <div class="screenlet-body">
		    <form method="post" action="<@ofbizUrl>createCustomerTaxAuthInfo</@ofbizUrl>" name="createCustTaxAuthInfoForm">
		      <div>
		      <input type="hidden" name="partyId" value="${party.partyId}"/>
		      ${screens.render("component://order/widget/ordermgr/OrderEntryOrderScreens.xml#customertaxinfo")}
		      <input type="submit" value="${uiLabelMap.CommonAdd}" class="btn btn-default btn-sm"/>
		      </div>
		    </form>
		  </div>
		</div>
		
		<@storeSurveys />
		
		-->
	
	</div><!-- ./col-md-9 -->
	
	<div class="col-md-3">
	
	    <@loyaltyPoints />
	</div><!-- ./col-md-3 -->
<#else>
    <h3>${uiLabelMap.PartyNoPartyForCurrentUserName}: ${userLogin.userLoginId}</h3>
</#if>



<#macro contactDetails >

    <div class="box">        
        <#-- ============================================================= -->
        
        <h3>
            ${uiLabelMap.PartyContactInformation}
	        <span class="pull-right">
	           <a href="<@ofbizUrl>editcontactmech</@ofbizUrl>" class="btn btn-default">${uiLabelMap.CommonCreateNew}</a>
	        </span>
        </h3>
        
        <#if partyContactMechValueMaps?has_content>
            <#list partyContactMechValueMaps as partyContactMechValueMap>   
                <hr/>
                <#assign contactMech = partyContactMechValueMap.contactMech! />
                <#assign contactMechType = partyContactMechValueMap.contactMechType! />
                <#assign partyContactMech = partyContactMechValueMap.partyContactMech! />

                <p class="text-muted">
                    ${contactMechType.get("description",locale)}
                </p>
                
                <#list partyContactMechValueMap.partyContactMechPurposes! as partyContactMechPurpose>
                    <#assign contactMechPurposeType = partyContactMechPurpose.getRelatedOne("ContactMechPurposeType", true) />
                    <div>
                        <#if contactMechPurposeType??>
                            ${contactMechPurposeType.get("description",locale)}
                            <#if contactMechPurposeType.contactMechPurposeTypeId == "SHIPPING_LOCATION" && (profiledefs.defaultShipAddr)?default("") == contactMech.contactMechId>
                                <span class="btn btn-linkdisabled">${uiLabelMap.EcommerceIsDefault}</span>
                            <#elseif contactMechPurposeType.contactMechPurposeTypeId == "SHIPPING_LOCATION">
                                <p>
	                                <form name="defaultShippingAddressForm" method="post" action="<@ofbizUrl>setprofiledefault/viewprofile</@ofbizUrl>">
	                                    <input type="hidden" name="productStoreId" value="${productStoreId}" />
	                                    <input type="hidden" name="defaultShipAddr" value="${contactMech.contactMechId}" />
	                                    <input type="hidden" name="partyId" value="${party.partyId}" />
	                                    <input type="submit" value="${uiLabelMap.EcommerceSetDefault}" class="btn btn-inverse btn-sm" />
	                                </form>
                                </p>
                            </#if>
                        <#else>
                            ${uiLabelMap.PartyPurposeTypeNotFound}: "${partyContactMechPurpose.contactMechPurposeTypeId}"
                        </#if>
                        <#if partyContactMechPurpose.thruDate??>(${uiLabelMap.CommonExpire}:${partyContactMechPurpose.thruDate.toString()})</#if>
                    </div>
                </#list>
                <#if contactMech.contactMechTypeId! = "POSTAL_ADDRESS">
                    <#assign postalAddress = partyContactMechValueMap.postalAddress! />
                    <div>
                        <#if postalAddress??>
                            <#if postalAddress.toName?has_content>${uiLabelMap.CommonTo}: ${postalAddress.toName}<br /></#if>
                            <#if postalAddress.attnName?has_content>${uiLabelMap.PartyAddrAttnName}: ${postalAddress.attnName}<br /></#if>
                            ${postalAddress.address1}<br />
                            <#if postalAddress.address2?has_content>${postalAddress.address2}<br /></#if>
                            ${postalAddress.city}<#if postalAddress.stateProvinceGeoId?has_content>,&nbsp;${postalAddress.stateProvinceGeoId}</#if>&nbsp;${postalAddress.postalCode!}
                            <#if postalAddress.countryGeoId?has_content><br />${postalAddress.countryGeoId}</#if>
                            <#if (!postalAddress.countryGeoId?has_content || postalAddress.countryGeoId! = "USA")>
                                <#assign addr1 = postalAddress.address1! />
                                <#if (addr1.indexOf(" ") > 0)>
                                    <#assign addressNum = addr1.substring(0, addr1.indexOf(" ")) />
                                    <#assign addressOther = addr1.substring(addr1.indexOf(" ")+1) />
                                    <a target="_blank" href="${uiLabelMap.CommonLookupWhitepagesAddressLink}" class="btn btn-link">(${uiLabelMap.CommonLookupWhitepages})</a>
	                            </#if>
	                        </#if>
	                    <#else>
	                        ${uiLabelMap.PartyPostalInformationNotFound}.
	                    </#if>
                    </div>
                <#elseif contactMech.contactMechTypeId! = "TELECOM_NUMBER">
                    <#assign telecomNumber = partyContactMechValueMap.telecomNumber!>
                    <div>
	                    <#if telecomNumber??>
	                        ${telecomNumber.countryCode!}
	                        <#if telecomNumber.areaCode?has_content>${telecomNumber.areaCode}-</#if>${telecomNumber.contactNumber!}
	                        <#if partyContactMech.extension?has_content>ext&nbsp;${partyContactMech.extension}</#if>
	                        <#if (!telecomNumber.countryCode?has_content || telecomNumber.countryCode = "011")>
	                            <a target="_blank" href="${uiLabelMap.CommonLookupAnywhoLink}" class="linktext">${uiLabelMap.CommonLookupAnywho}</a>
	                            <a target="_blank" href="${uiLabelMap.CommonLookupWhitepagesTelNumberLink}" class="linktext">${uiLabelMap.CommonLookupWhitepages}</a>
	                        </#if>
	                    <#else>
	                        ${uiLabelMap.PartyPhoneNumberInfoNotFound}.
	                    </#if>
                    </div>
                <#elseif contactMech.contactMechTypeId! = "EMAIL_ADDRESS">
                    ${contactMech.infoString}                    
                <#elseif contactMech.contactMechTypeId! = "WEB_ADDRESS">
                    <div>
                        ${contactMech.infoString}
                        <#assign openAddress = contactMech.infoString! />
                        <#if !openAddress.startsWith("http") && !openAddress.startsWith("HTTP")><#assign openAddress = "http://" + openAddress /></#if>
                        <a target="_blank" href="${openAddress}" class="linktext">(${uiLabelMap.CommonOpenNewWindow})</a>
                    </div>
                <#else>
                    ${contactMech.infoString!}
                </#if>
                <div>(${uiLabelMap.CommonUpdated}:&nbsp;${partyContactMech.fromDate.toString()})</div>
                <#if partyContactMech.thruDate??><div>${uiLabelMap.CommonDelete}:&nbsp;${partyContactMech.thruDate.toString()}</div></#if>
                
                <p>
                    <form name= "deleteContactMech_${contactMech.contactMechId}" method= "post" action= "<@ofbizUrl>deleteContactMech</@ofbizUrl>">
                        <div class="btn-group">
                            <input type= "hidden" name= "contactMechId" value= "${contactMech.contactMechId}"/>
                            <a href="<@ofbizUrl>editcontactmech?contactMechId=${contactMech.contactMechId}</@ofbizUrl>" class="btn btn-default btn-sm">${uiLabelMap.CommonUpdate}</a>
                            <a href='javascript:document.deleteContactMech_${contactMech.contactMechId}.submit()' class="btn btn-default btn-sm">${uiLabelMap.CommonExpire}</a>
                        </div>
                    </form>
                </p>                              
            </#list>
        <#else>
            <label>${uiLabelMap.PartyNoContactInformation}.</label><br />
        </#if>      
    </div><!-- ./box -->
</#macro>

<#macro paymentDetails >

<div class="screenlet">
  <div class="boxlink">
    <a href="<@ofbizUrl>editcreditcard</@ofbizUrl>" class="submenutext">${uiLabelMap.PartyCreateNewCreditCard}</a><a href="<@ofbizUrl>editgiftcard</@ofbizUrl>" class="submenutext">${uiLabelMap.PartyCreateNewGiftCard}</a><a href="<@ofbizUrl>editeftaccount</@ofbizUrl>" class="submenutextright">${uiLabelMap.PartyCreateNewEftAccount}</a>
  </div>
  <h3>${uiLabelMap.AccountingPaymentMethodInformation}</h3>
  <div class="screenlet-body">
    <table width="100%" border="0" cellpadding="1">
      <tr>
        <td>
          <#if paymentMethodValueMaps?has_content>
          <table width="100%" cellpadding="2" cellspacing="0" border="0">
            <#list paymentMethodValueMaps as paymentMethodValueMap>
              <#assign paymentMethod = paymentMethodValueMap.paymentMethod! />
              <#assign creditCard = paymentMethodValueMap.creditCard! />
              <#assign giftCard = paymentMethodValueMap.giftCard! />
              <#assign eftAccount = paymentMethodValueMap.eftAccount! />
              <tr>
                <#if paymentMethod.paymentMethodTypeId! == "CREDIT_CARD">
                <td valign="top">
                  <div>
                    ${uiLabelMap.AccountingCreditCard}:
                    <#if creditCard.companyNameOnCard?has_content>${creditCard.companyNameOnCard}&nbsp;</#if>
                    <#if creditCard.titleOnCard?has_content>${creditCard.titleOnCard}&nbsp;</#if>
                    ${creditCard.firstNameOnCard}&nbsp;
                    <#if creditCard.middleNameOnCard?has_content>${creditCard.middleNameOnCard}&nbsp;</#if>
                    ${creditCard.lastNameOnCard}
                    <#if creditCard.suffixOnCard?has_content>&nbsp;${creditCard.suffixOnCard}</#if>
                    &nbsp;${Static["org.ofbiz.party.contact.ContactHelper"].formatCreditCard(creditCard)}
                    <#if paymentMethod.description?has_content>(${paymentMethod.description})</#if>
                    <#if paymentMethod.fromDate?has_content>(${uiLabelMap.CommonUpdated}:&nbsp;${paymentMethod.fromDate.toString()})</#if>
                    <#if paymentMethod.thruDate??>(${uiLabelMap.CommonDelete}:&nbsp;${paymentMethod.thruDate.toString()})</#if>
                  </div>
                </td>
                <td>&nbsp;</td>
                <td align="right" valign="top">
                  <a href="<@ofbizUrl>editcreditcard?paymentMethodId=${paymentMethod.paymentMethodId}</@ofbizUrl>" class="button">
                            ${uiLabelMap.CommonUpdate}</a>
                </td>
                <#elseif paymentMethod.paymentMethodTypeId! == "GIFT_CARD">
                  <#if giftCard?has_content && giftCard.cardNumber?has_content>
                    <#assign giftCardNumber = "" />
                    <#assign pcardNumber = giftCard.cardNumber />
                    <#if pcardNumber?has_content>
                      <#assign psize = pcardNumber?length - 4 />
                      <#if (0 < psize)>
                        <#list 0 .. psize-1 as foo>
                          <#assign giftCardNumber = giftCardNumber + "*" />
                        </#list>
                         <#assign giftCardNumber = giftCardNumber + pcardNumber[psize .. psize + 3] />
                      <#else>
                         <#assign giftCardNumber = pcardNumber />
                      </#if>
                    </#if>
                  </#if>

                  <td valign="top">
                    <div>
                      ${uiLabelMap.AccountingGiftCard}: ${giftCardNumber}
                      <#if paymentMethod.description?has_content>(${paymentMethod.description})</#if>
                      <#if paymentMethod.fromDate?has_content>(${uiLabelMap.CommonUpdated}:&nbsp;${paymentMethod.fromDate.toString()})</#if>
                      <#if paymentMethod.thruDate??>(${uiLabelMap.CommonDelete}:&nbsp;${paymentMethod.thruDate.toString()})</#if>
                    </div>
                  </td>
                  <td >&nbsp;</td>
                  <td align="right" valign="top">
                    <a href="<@ofbizUrl>editgiftcard?paymentMethodId=${paymentMethod.paymentMethodId}</@ofbizUrl>" class="button">
                            ${uiLabelMap.CommonUpdate}</a>
                  </td>
                  <#elseif paymentMethod.paymentMethodTypeId! == "EFT_ACCOUNT">
                  <td valign="top">
                    <div>
                      ${uiLabelMap.AccountingEFTAccount}: ${eftAccount.nameOnAccount!} - <#if eftAccount.bankName?has_content>${uiLabelMap.AccountingBank}: ${eftAccount.bankName}</#if> <#if eftAccount.accountNumber?has_content>${uiLabelMap.AccountingAccount} #: ${eftAccount.accountNumber}</#if>
                      <#if paymentMethod.description?has_content>(${paymentMethod.description})</#if>
                      <#if paymentMethod.fromDate?has_content>(${uiLabelMap.CommonUpdated}:&nbsp;${paymentMethod.fromDate.toString()})</#if>
                      <#if paymentMethod.thruDate??>(${uiLabelMap.CommonDelete}:&nbsp;${paymentMethod.thruDate.toString()})</#if>
                    </div>
                  </td>
                  <td>&nbsp;</td>
                  <td align="right" valign="top">
                    <a href="<@ofbizUrl>editeftaccount?paymentMethodId=${paymentMethod.paymentMethodId}</@ofbizUrl>" class="button">
                            ${uiLabelMap.CommonUpdate}</a>
                  </td>
                </#if>
                <td align="right" valign="top">
                 <a href="<@ofbizUrl>deletePaymentMethod/viewprofile?paymentMethodId=${paymentMethod.paymentMethodId}</@ofbizUrl>" class="button">
                        ${uiLabelMap.CommonExpire}</a>
                </td>
                <td align="right" valign="top">
                  <#if (profiledefs.defaultPayMeth)?default("") == paymentMethod.paymentMethodId>
                    <span class="btn btn-linkdisabled">${uiLabelMap.EcommerceIsDefault}</span>
                  <#else>
                    <form name="defaultPaymentMethodForm" method="post" action="<@ofbizUrl>setprofiledefault/viewprofile</@ofbizUrl>">
                      <input type="hidden" name="productStoreId" value="${productStoreId}" />
                      <input type="hidden" name="defaultPayMeth" value="${paymentMethod.paymentMethodId}" />
                      <input type="hidden" name="partyId" value="${party.partyId}" />
                      <input type="submit" value="${uiLabelMap.EcommerceSetDefault}" class="btn btn-default" />
                    </form>
                  </#if>
                </td>
              </tr>
            </#list>
          </table>
          <#else>
            ${uiLabelMap.AccountingNoPaymentMethodInformation}.
          </#if>
        </td>
      </tr>
    </table>
  </div>
</div>


</#macro>

<#macro digitalContent >
     




<#-- ============================================================= -->
<div class="screenlet">
  <h3>${uiLabelMap.EcommerceFileManager}</h3>
  <div class="screenlet-body">
    <table width="100%" border="0" cellpadding="1">
      <#if partyContent?has_content>
        <#list partyContent as contentRole>
        <#assign content = contentRole.getRelatedOne("Content", false) />
        <#assign contentType = content.getRelatedOne("ContentType", true) />
        <#assign mimeType = content.getRelatedOne("MimeType", true)! />
        <#assign status = content.getRelatedOne("StatusItem", true) />
          <tr>
            <td><a href="<@ofbizUrl>img/${content.contentName!}?imgId=${content.dataResourceId!}</@ofbizUrl>" class="button">${content.contentId}</a></td>
            <td>${content.contentName!}</td>
            <td>${(contentType.get("description",locale))!}</td>
            <td>${(mimeType.description)!}</td>
            <td>${(status.get("description",locale))!}</td>
            <td>${contentRole.fromDate!}</td>
            <td align="right">
              <form name="removeContent_${contentRole.contentId}" method="post" action="removePartyAsset">
                <input name="partyId" type="hidden" value="${userLogin.partyId}"/>
                <input name="contentId" type="hidden" value="${contentRole.contentId}"/>
                <input name="roleTypeId" type="hidden" value="${contentRole.roleTypeId}"/>
              </form>
              <a href="<@ofbizUrl>img/${content.contentName!}?imgId=${content.dataResourceId!}</@ofbizUrl>" class="button">${uiLabelMap.CommonView}</a>
              <a href="javascript:document.removeContent_${contentRole.contentId}.submit();" class="button">${uiLabelMap.CommonRemove}</a>
            </td>
          </tr>
        </#list>
      <#else>
         <tr><td>${uiLabelMap.EcommerceNoFiles}</td></tr>
      </#if>
    </table>
    <div>&nbsp;</div>
    <label>${uiLabelMap.EcommerceUploadNewFile}</label>
    <div>
      <form method="post" enctype="multipart/form-data" action="<@ofbizUrl>uploadPartyContent</@ofbizUrl>">
      <div>
        <input type="hidden" name="partyId" value="${party.partyId}"/>
        <input type="hidden" name="dataCategoryId" value="PERSONAL"/>
        <input type="hidden" name="contentTypeId" value="DOCUMENT"/>
        <input type="hidden" name="statusId" value="CTNT_PUBLISHED"/>
        <input type="hidden" name="roleTypeId" value="OWNER"/>
        <input type="file" name="uploadedFile" size="50" class="inputBox"/>
        <select name="partyContentTypeId" class="selectBox">
          <option value="">${uiLabelMap.PartySelectPurpose}</option>
          <#list partyContentTypes as partyContentType>
            <option value="${partyContentType.partyContentTypeId}">${partyContentType.get("description", locale)?default(partyContentType.partyContentTypeId)}</option>
          </#list>
        </select>
        <select name="mimeTypeId" class="selectBox">
          <option value="">${uiLabelMap.PartySelectMimeType}</option>
          <#list mimeTypes as mimeType>
            <option value="${mimeType.mimeTypeId}">${mimeType.get("description", locale)?default(mimeType.mimeTypeId)}</option>
          </#list>
        </select>
        <input type="submit" value="${uiLabelMap.CommonUpload}" class="btn btn-default btn-sm"/>
        </div>
      </form>
    </div>
  </div>
</div>
</#macro>

<#macro storeSurveys >

	<#-- ============================================================= -->
	<#if surveys?has_content>
	<div class="screenlet">
	  <h3>${uiLabelMap.EcommerceSurveys}</h3>
	  <div class="screenlet-body">
	    <table width="100%" border="0" cellpadding="1">
	      <#list surveys as surveyAppl>
	        <#assign survey = surveyAppl.getRelatedOne("Survey", false) />
	        <tr>
	          <td>&nbsp;</td>
	          <td valign="top"><div>${survey.surveyName!}&nbsp;-&nbsp;${survey.description!}</div></td>
	          <td>&nbsp;</td>
	          <td valign="top">
	            <#assign responses = Static["org.ofbiz.product.store.ProductStoreWorker"].checkSurveyResponse(request, survey.surveyId)?default(0)>
	            <#if (responses < 1)>${uiLabelMap.EcommerceNotCompleted}<#else>${uiLabelMap.EcommerceCompleted}</#if>
	          </td>
	          <#if (responses == 0 || survey.allowMultiple?default("N") == "Y")>
	            <#assign surveyLabel = uiLabelMap.EcommerceTakeSurvey />
	            <#if (responses > 0 && survey.allowUpdate?default("N") == "Y")>
	              <#assign surveyLabel = uiLabelMap.EcommerceUpdateSurvey />
	            </#if>
	            <td align="right"><a href="<@ofbizUrl>takesurvey?productStoreSurveyId=${surveyAppl.productStoreSurveyId}</@ofbizUrl>" class="button">${surveyLabel}</a></td>
	          <#else>
	          &nbsp;
	          </#if>
	        </tr>
	      </#list>
	    </table>
	  </div>
	</div>
	</#if>
</#macro>

<#macro loyaltyPoints >

<div class="panel panel-default sidebar-menu">

        <div class="panel-heading">
            <h3 class="panel-title">${uiLabelMap.EcommerceLoyaltyPoints}</h3>
        </div>

        <div class="panel-body">
            <#if monthsToInclude?? && totalSubRemainingAmount?? && totalOrders??>
                <label>${uiLabelMap.EcommerceYouHave} ${totalSubRemainingAmount} ${uiLabelMap.EcommercePointsFrom} ${totalOrders} ${uiLabelMap.EcommerceOrderInLast} ${monthsToInclude} ${uiLabelMap.EcommerceMonths}</label>            
            </#if>
        </div>
    </div>           
</#macro>