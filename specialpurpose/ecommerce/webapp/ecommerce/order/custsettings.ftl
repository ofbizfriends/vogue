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
    <h3>${uiLabelMap.EcommerceYourNamePhoneAndEmail}</h3>
	<form id="editCustomerNamePhoneAndEmail" name="${parameters.formNameValue}" method="post" action="<@ofbizUrl>processCustomerSettings</@ofbizUrl>">
	    <input type="hidden" name="partyId" value="${parameters.partyId!}"/>    
	    <div class="form-group">
	        <label for="firstName">${uiLabelMap.PartyFirstName}*</label>
	        <input type="text" class="form-control" name="firstName" value="${parameters.firstName!}" /> 
	    </div>
	    
	    <div class="form-group">
            <label for="lastName">${uiLabelMap.PartyLastName}*</label>
            <input type="text" class="form-control" name="lastName" value="${parameters.lastName!}" /> 
	    </div>
        <div class="form-group">
            <label for="lastName">${uiLabelMap.PartyContactNumber}</label>
            <input type="text" class="form-control" name="homeContactNumber" value="${parameters.homeContactNumber!}" />            
        </div>
        <div class="form-group">
            <label for="lastName">${uiLabelMap.PartyEmailAddress}*</label>     
            <input type="hidden" name="emailContactMechId" value="${parameters.emailContactMechId!}"/>       
            <input type="text" class="form-control" name="emailAddress" value="${parameters.emailAddress!}"/> *
        </div>        	    
	    <div class="form-group">
            <input type="submit" class="btn btn-default" value="${uiLabelMap.CommonContinue}"/>
        </div>
	</form>
</div>
<br/>