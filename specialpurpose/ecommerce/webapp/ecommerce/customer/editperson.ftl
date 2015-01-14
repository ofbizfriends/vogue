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



<#if personData??>
    <div class="col-md-12 clearfix">
        <div class="box text-center">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1">
                    <h1>
                    <#if person??>
                      ${personData.personalTitle!}
                      ${personData.firstName!}
                      ${personData.middleName!}
                      ${personData.lastName!}
                      ${personData.suffix!}
                    <#else>
                      "${uiLabelMap.PartyNewUser}"
                    </#if>
                    </h1>
                </div>
            </div>
        </div>
    </div>
</#if>    

<div class="col-md-9 clearfix">
    <div class="box">
        <#if person??>
            <h2>${uiLabelMap.PartyEditPersonalInformation}</h2>
		    <form id="editpersonform1" method="post" action="<@ofbizUrl>updatePerson</@ofbizUrl>" name="editpersonform">    
		<#else>
            <h2>${uiLabelMap.PartyAddNewPersonalInformation}</h2>
		    <form id="editpersonform2" method="post" action="<@ofbizUrl>createPerson/${donePage}</@ofbizUrl>" name="editpersonform">
		</#if>
                <input type="hidden" name="partyId" value="${person.partyId!}" />
                		        
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="firstname">${uiLabelMap.PartyFirstName}*</label>
                            <input type="text" class='form-control' size="30" maxlength="30" name="firstName" value="${personData.firstName!}"/>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="lastname">${uiLabelMap.PartyLastName}*</label>
                            <input type="text" class='form-control' size="30" maxlength="30" name="lastName" value="${personData.lastName!}"/>
                        </div>
                    </div>
                </div>		  		    
            </form>
            
	        <div class="box-footer">
	            <div class="pull-left">
	                <a href='<@ofbizUrl>${donePage}</@ofbizUrl>' class="btn btn-default"><i class="fa fa-chevron-left"></i> ${uiLabelMap.CommonGoBack}</a>
	                <a id="editpersonform3" href="javascript:document.editpersonform.submit()" class="btn btn-primary"><i class="fa fa-save"></i> ${uiLabelMap.CommonSave}</a>
	            </div>
	        </div>                            
    </div><!-- ./box -->
</div><!-- ./col-md-9 -->
