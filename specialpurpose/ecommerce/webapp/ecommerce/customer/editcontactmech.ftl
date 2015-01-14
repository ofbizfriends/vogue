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
<div class="col-md-12 clearfix">
    <ul class="breadcrumb">
        <li><a href="<@ofbizUrl>main</@ofbizUrl>">${uiLabelMap.CommonHome}</a>
        </li>
        <li>${uiLabelMap.CommonAddress}</li>
    </ul>

    <div class="box text-center">
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <h1>${uiLabelMap.CommonAddress}</h1>
            </div>
        </div>
    </div>
</div>

<div class="col-md-9 clearfix">
    <div class="box">
    

	<#if canNotView>
        <h3>${uiLabelMap.PartyContactInfoNotBelongToYou}.</h3>
        <a href="<@ofbizUrl>${donePage}</@ofbizUrl>" class="btn btn-default"> <i class="fa fa-chevron-left"></i> ${uiLabelMap.CommonBack}</a>
	<#else>
        <#if !contactMech??>
		    <#-- When creating a new contact mech, first select the type, then actually create -->
		    <#if !requestParameters.preContactMechTypeId?? && !preContactMechTypeId??>
		    <h2>${uiLabelMap.PartyCreateNewContactInfo}</h2>
		    <form method="post" action='<@ofbizUrl>editcontactmechnosave</@ofbizUrl>' name="createcontactmechform">
	            <div class="form-group">
	                <label>${uiLabelMap.PartySelectContactType}</label>
		        
		            <select name="preContactMechTypeId" class='selectBox'>
	                    <#list contactMechTypes as contactMechType>
		                   <option value='${contactMechType.contactMechTypeId}'>${contactMechType.get("description",locale)}</option>
	                    </#list>
		            </select>
		            <a href="javascript:document.createcontactmechform.submit()" class="btn btn-default">${uiLabelMap.CommonCreate}</a>
	            </div>
	        </form>
		    <#-- <p><h3>ERROR: Contact information with ID "${contactMechId}" not found!</h3></p> -->
	    </#if>
    </#if>
	
    <#if contactMechTypeId??>
        <#if !contactMech??>
            <h2>${uiLabelMap.PartyCreateNewContactInfo}</h2>
            <form method="post" action='<@ofbizUrl>${reqName}</@ofbizUrl>' name="editcontactmechform" id="editcontactmechform">
                <input type='hidden' name='contactMechTypeId' value='${contactMechTypeId}' />
                <#if contactMechPurposeType??>
                    <div>(${uiLabelMap.PartyNewContactHavePurpose} "${contactMechPurposeType.get("description",locale)!}")</div>
                </#if>
                <#if cmNewPurposeTypeId?has_content><input type='hidden' name='contactMechPurposeTypeId' value='${cmNewPurposeTypeId}' /></#if>
                <#if preContactMechTypeId?has_content><input type='hidden' name='preContactMechTypeId' value='${preContactMechTypeId}' /></#if>
                <#if paymentMethodId?has_content><input type='hidden' name='paymentMethodId' value='${paymentMethodId}' /></#if>
        <#else>
            <h2>${uiLabelMap.PartyEditContactInfo}</h2>      
            <p>${uiLabelMap.PartyContactPurposes}</p>
	        <#list partyContactMechPurposes! as partyContactMechPurpose>
                <#assign contactMechPurposeType = partyContactMechPurpose.getRelatedOne("ContactMechPurposeType", true) />
                <#if contactMechPurposeType??>
                    ${contactMechPurposeType.get("description",locale)}
                <#else>
                    ${uiLabelMap.PartyPurposeTypeNotFound}: "${partyContactMechPurpose.contactMechPurposeTypeId}"
                </#if>
                (${uiLabelMap.CommonSince}:${partyContactMechPurpose.fromDate.toString()})
                <#if partyContactMechPurpose.thruDate??>(${uiLabelMap.CommonExpires}:${partyContactMechPurpose.thruDate.toString()})</#if>
                <form name="deletePartyContactMechPurpose_${partyContactMechPurpose.contactMechPurposeTypeId}" method="post" action="<@ofbizUrl>deletePartyContactMechPurpose</@ofbizUrl>">
                    <div class="form-group">
                        <input type="hidden" name="contactMechId" value="${contactMechId}"/>
                        <input type="hidden" name="contactMechPurposeTypeId" value="${partyContactMechPurpose.contactMechPurposeTypeId}"/>
						<input type="hidden" name="fromDate" value="${partyContactMechPurpose.fromDate}"/>
						<input type="hidden" name="useValues" value="true"/>
                        <a href='javascript:document.deletePartyContactMechPurpose_${partyContactMechPurpose.contactMechPurposeTypeId}.submit()' class='btn btn-default'>${uiLabelMap.CommonDelete}</a>
                    </div>
                </form> 
            </#list>
            <#if purposeTypes?has_content>
                <form method="post" action='<@ofbizUrl>createPartyContactMechPurpose</@ofbizUrl>' name='newpurposeform'>
                    <div class="form-group">
                        <input type="hidden" name="contactMechId" value="${contactMechId}"/>
	                    <input type="hidden" name="useValues" value="true"/>
	                    <select name='contactMechPurposeTypeId' class='selectBox'>
                            <option></option>
	                        <#list purposeTypes as contactMechPurposeType>
                                <option value='${contactMechPurposeType.contactMechPurposeTypeId}'>${contactMechPurposeType.get("description",locale)}</option>
	                        </#list>
                        </select>
                    </div>
                </form>
	            <div>
                    <a href='javascript:document.newpurposeform.submit()' class='btn btn-default'>${uiLabelMap.PartyAddPurpose}</a>
                </div>      
            </#if>
	            	          	        
	        <form method="post" action='<@ofbizUrl>${reqName}</@ofbizUrl>' name="editcontactmechform" id="editcontactmechform">          
                <input type="hidden" name="contactMechId" value='${contactMechId}' />
                <input type="hidden" name="contactMechTypeId" value='${contactMechTypeId}' />
	    </#if>
	
	    <#if contactMechTypeId = "POSTAL_ADDRESS">
            <div class="form-group">
                <label>${uiLabelMap.PartyToName}</label>
	            <input type="text" class='form-control' size="30" maxlength="60" name="toName" value="${postalAddressData.toName!}" />
	        
            </div>
            <div class="form-group">
	            <label>${uiLabelMap.PartyAddressLine1} *</label>
	            <input type="text" class='form-control' size="30" maxlength="30" name="address1" value="${postalAddressData.address1!}" />
	            
            </div>
	        <div class="form-group">
	           <label>${uiLabelMap.PartyAddressLine2}</label>
	           <input type="text" class='form-control' size="30" maxlength="30" name="address2" value="${postalAddressData.address2!}" />
	        </div>
            <div class="form-group">
                <label>${uiLabelMap.PartyCity}*</label>
	            <input type="text" class='form-control' size="30" maxlength="30" name="city" value="${postalAddressData.city!}" />
	        </div>
            
            <div class="form-group">   
                <label>${uiLabelMap.CommonCountry}</label>
                <select name="countryGeoId" id="editcontactmechform_countryGeoId" class="form-control">
                    ${screens.render("component://common/widget/CommonScreens.xml#countries")}        
                    <#if (postalAddress??) && (postalAddress.countryGeoId??)>
                        <#assign defaultCountryGeoId = postalAddress.countryGeoId>
                    <#else>
                        <#assign defaultCountryGeoId = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("general.properties", "country.geo.id.default")>
                    </#if>
                    <option selected="selected" value="${defaultCountryGeoId}">
                        <#assign countryGeo = delegator.findOne("Geo",Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",defaultCountryGeoId), false)>
                        ${countryGeo.get("geoName",locale)}
                    </option>
                </select>
            </div>	      
            <div class="form-group">
                <label> ${uiLabelMap.PartyState}</label>
	            <select name="stateProvinceGeoId" class="form-control" id="editcontactmechform_stateProvinceGeoId"></select>
	        </div>
	            
            <div class="form-group">
                <label>${uiLabelMap.PartyZipCode}*</label>
                <input type="text" class='form-control' size="12" maxlength="10" name="postalCode" value="${postalAddressData.postalCode!}" />
	        </div>
        <#elseif contactMechTypeId = "TELECOM_NUMBER">
            <div class="form-group">
                <label>${uiLabelMap.PartyPhoneNumber}</label>
                <input type="text" class='form-control' size="15" maxlength="15" name="contactNumber" value="${telecomNumberData.contactNumber!}" />
	        
            </div>
        <#elseif contactMechTypeId = "EMAIL_ADDRESS">
            <div class="form-group">
                <label>${uiLabelMap.PartyEmailAddress}*</label>
	            <input type="text" class='form-control' size="60" maxlength="255" name="emailAddress" value="<#if tryEntity>${contactMech.infoString!}<#else>${requestParameters.emailAddress!}</#if>" />
	        </div>	     
	    <#else>
            <div class="form-group">
                <label>${contactMechType.get("description",locale)!}*</label>
	            <input type="text" class='form-control' size="60" maxlength="255" name="infoString" value="${contactMechData.infoString!}" />
	        </div>
	      
	    </#if>
		    </form>
			  
			
		        <a href="<@ofbizUrl>${donePage}</@ofbizUrl>" class="btn btn-default">${uiLabelMap.CommonGoBack}</a>
		        <a href="javascript:document.editcontactmechform.submit()" class="btn btn-default">${uiLabelMap.CommonSave}</a>
			<#else>    
			    <a href="<@ofbizUrl>${donePage}</@ofbizUrl>" class="button">${uiLabelMap.CommonGoBack}</a>
			</#if>
		</#if>
    </div><!-- ./box -->    
</div>
