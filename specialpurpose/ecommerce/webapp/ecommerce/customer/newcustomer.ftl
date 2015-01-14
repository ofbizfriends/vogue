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

<#if getUsername>
<script type="text/javascript">
  //<![CDATA[
     lastFocusedName = null;
     function setLastFocused(formElement) {
         lastFocusedName = formElement.name;
         document.write.lastFocusedName;
     }
     function clickUsername() {
         if (document.getElementById('UNUSEEMAIL').checked) {
             if (lastFocusedName == "UNUSEEMAIL") {
                 jQuery('#PASSWORD').focus();
             } else if (lastFocusedName == "PASSWORD") {
                 jQuery('#UNUSEEMAIL').focus();
             } else {
                 jQuery('#PASSWORD').focus();
             }
         }
     }
     function changeEmail() {
         if (document.getElementById('UNUSEEMAIL').checked) {
             document.getElementById('USERNAME').value = jQuery('#CUSTOMER_EMAIL').val();
         }
     }
     function setEmailUsername() {
         if (document.getElementById('UNUSEEMAIL').checked) {
             document.getElementById('USERNAME').value = jQuery('#CUSTOMER_EMAIL').val();
             // don't disable, make the browser not submit the field: document.getElementById('USERNAME').disabled=true;
         } else {
             document.getElementById('USERNAME').value='';
             // document.getElementById('USERNAME').disabled=false;
         }
     }
     function hideShowUsaStates() {
		 var customerStateElement = document.getElementById('newuserform_stateProvinceGeoId');
     	 var customerCountryElement = document.getElementById('newuserform_countryGeoId');
         if (customerCountryElement.value == "USA" || customerCountryElement.value == "UMI") {
             customerStateElement.style.display = "block";
         } else {
             customerStateElement.style.display = "none";
         }
     }
   //]]>
</script>
</#if>

<#------------------------------------------------------------------------------
NOTE: all page headings should start with an h2 tag, not an H1 tag, as 
there should generally always only be one h1 tag on the page and that 
will generally always be reserved for the logo at the top of the page.

------------------------------------------------------------------------------->
<#macro fieldErrors fieldName>
    <#if errorMessageList?has_content>
        <#assign fieldMessages = Static["org.ofbiz.base.util.MessageString"].getMessagesForField(fieldName, true, errorMessageList)>    
        <#list fieldMessages as errorMsg>
            <p class="help-block"><span class="text-danger">${errorMsg}</span></p>
        </#list>
    </#if>
</#macro>
<#macro fieldErrorsMulti fieldName1 fieldName2 fieldName3 fieldName4>
    <#if errorMessageList?has_content>
        <#assign fieldMessages = Static["org.ofbiz.base.util.MessageString"].getMessagesForField(fieldName1, fieldName2, fieldName3, fieldName4, true, errorMessageList)>
        <#list fieldMessages as errorMsg>
            <p class="help-block"><span class="text-danger">${errorMsg}</span></p>
        </#list>   
    </#if>
</#macro>


<div class="box">    
    <div class="row">
	    <div class="col-md-12">    
	        <h1>${uiLabelMap.PartyRequestNewAccount}</h1>
	        <p class="lead">${uiLabelMap.PartyAlreadyHaveAccount}, <a href='<@ofbizUrl>checkLogin/main</@ofbizUrl>'>${uiLabelMap.CommonLoginHere}</a></p>
	    </div>
    </div>
    <form method="post" action="<@ofbizUrl>createcustomer${previousParams}</@ofbizUrl>" id="newuserform" name="newuserform">
        <div class="row">
	        <div class="col-md-6">            
	            <p class="help-block">${uiLabelMap.CommonFieldsMarkedAreRequired}</p>
	            <input type="hidden" name="emailProductStoreId" value="${productStoreId}"/>
	            
	            <div class="form-group">
	                <label for="USER_FIRST_NAME">${uiLabelMap.PartyFirstName}*</label>
	                <@fieldErrors fieldName="USER_FIRST_NAME"/>
	                <input type="text" class="form-control" name="USER_FIRST_NAME" id="USER_FIRST_NAME" value="${requestParameters.USER_FIRST_NAME!}" >                
	            </div>
			    <div class="form-group">
	                <label for="USER_LAST_NAME">${uiLabelMap.PartyLastName}*</label>
			        <@fieldErrors fieldName="USER_LAST_NAME"/>
	                <input type="text" class="form-control" name="USER_LAST_NAME" id="USER_LAST_NAME" value="${requestParameters.USER_LAST_NAME!}" />
			    </div>            
			    <div class="form-group">
	                <label for= "CUSTOMER_EMAIL">${uiLabelMap.PartyEmailAddress}*</label>
	                <@fieldErrors fieldName="CUSTOMER_EMAIL"/>
	                <input type="text" class="form-control" name="CUSTOMER_EMAIL" id="CUSTOMER_EMAIL" value="${requestParameters.CUSTOMER_EMAIL!}" onchange="changeEmail()" onkeyup="changeEmail()" />
			    </div>		    
			    
	            <#if createAllowPassword>
	                <div class="form-group">
	                    <label for="PASSWORD">${uiLabelMap.CommonPassword}*</label>
	                    <@fieldErrors fieldName="PASSWORD"/>
	                    <input type="password" class="form-control"  name="PASSWORD" id="PASSWORD" onfocus="setLastFocused(this);"/>
	                </div>
			
	                <div class="form-group">
	                    <label for="CONFIRM_PASSWORD">${uiLabelMap.PartyRepeatPassword}*</label>
	                    <@fieldErrors fieldName="CONFIRM_PASSWORD"/>
	                    <input type="password"  class="form-control" name="CONFIRM_PASSWORD" id="CONFIRM_PASSWORD" value="" maxlength="50"/>
	                </div>
			    <#else/>
	                <div class="form-group">
	                    <label>${uiLabelMap.PartyReceivePasswordByEmail}.</div>
	                </div>
			    </#if>		     
	                                                  
	        </div><!-- ./col-md-6 -->
	        
	        <div class="col-md-6">
	            <!-- Optional Address and Phone -->
	
	            <p class="help-block"> ${uiLabelMap.PartyShippingAddress} </p>
	            
	            <div class="form-group">
	                <label for="customerState">${uiLabelMap.PartyMobilePhone}</label>
	                <@fieldErrors fieldName="CUSTOMER_MOBILE_CONTACT"/>
	                <input type="text" class="form-control" name="CUSTOMER_MOBILE_CONTACT" value="${requestParameters.CUSTOMER_MOBILE_CONTACT!}" />
	            </div>
			    <div class="form-group">
	                <label for="CUSTOMER_ADDRESS1">${uiLabelMap.PartyAddressLine1}*</label>
	                <@fieldErrors fieldName="CUSTOMER_ADDRESS1"/>
	                <input type="text" class="form-control" name="CUSTOMER_ADDRESS1" id="CUSTOMER_ADDRESS1" value="${requestParameters.CUSTOMER_ADDRESS1!}" />
			    </div>
			
			    <div class="form-group">
	                <label for="CUSTOMER_ADDRESS2">${uiLabelMap.PartyAddressLine2}</label>
	                <@fieldErrors fieldName="CUSTOMER_ADDRESS2"/>
	                <input type="text" class="form-control" name="CUSTOMER_ADDRESS2" id="CUSTOMER_ADDRESS2" value="${requestParameters.CUSTOMER_ADDRESS2!}" />
			    </div>
			
			    <div class="row">  
				    <div class="form-group col-md-6">
		                <label for="CUSTOMER_CITY">${uiLabelMap.PartyCity}*</label>
		                <@fieldErrors fieldName="CUSTOMER_CITY"/>
		                <input type="text" class="form-control" name="CUSTOMER_CITY" id="CUSTOMER_CITY" value="${requestParameters.CUSTOMER_CITY!}" />
				    </div>
				
				    <div class="form-group col-md-6">
		                <label for="CUSTOMER_POSTAL_CODE">${uiLabelMap.PartyZipCode}*</label>
		                <@fieldErrors fieldName="CUSTOMER_POSTAL_CODE"/>
		                <input type="text" class="form-control" name="CUSTOMER_POSTAL_CODE" id="CUSTOMER_POSTAL_CODE" value="${requestParameters.CUSTOMER_POSTAL_CODE!}" />
				    </div>
			    </div>
			  
			    <div class="row">  
				    <div class="form-group col-md-6">
				        <label for="customerCountry">${uiLabelMap.CommonCountry}*</label>
				        <@fieldErrors fieldName="CUSTOMER_COUNTRY"/>
				        <select name="CUSTOMER_COUNTRY" id="newuserform_countryGeoId" class="form-control">
				            ${screens.render("component://common/widget/CommonScreens.xml#countries")}        
				            <#assign defaultCountryGeoId = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("general.properties", "country.geo.id.default")>
				            <option selected="selected" value="${defaultCountryGeoId}">
				                <#assign countryGeo = delegator.findOne("Geo",Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",defaultCountryGeoId), false)>
				                ${countryGeo.get("geoName",locale)}
				            </option>
				        </select>
				    </div>
				    
				    <div class="form-group col-md-6">
		                <label for="customerState">${uiLabelMap.PartyState}*</label>
				        <@fieldErrors fieldName="CUSTOMER_STATE"/>
				        <select name="CUSTOMER_STATE" id="newuserform_stateProvinceGeoId" class="form-control"></select>
				    </div>
			    </div>
	        
	        </div><!-- ./col-md-6 -->
	        
	        <div class="col-md-12">
                <div class="">                
                    <a href="javascript:document.getElementById('newuserform').submit()" class="btn btn-primary"> <i class="fa fa-user-md"></i> ${uiLabelMap.CommonSave}</a>
                    <a href="<@ofbizUrl>${donePage}</@ofbizUrl>" class="btn btn-default">${uiLabelMap.CommonCancel}</a>                
                </div>  	        
	        </div>
        </div>
    </form>    
</div><!-- ./box -->


<#------------------------------------------------------------------------------
To create a consistent look and feel for all buttons, input[type=submit], 
and a tags acting as submit buttons, all button actions should have a 
class name of "button". No other class names should be used to style 
button actions.
------------------------------------------------------------------------------->


<script type="text/javascript">
  //<![CDATA[
      hideShowUsaStates();
  //]]>
</script>
