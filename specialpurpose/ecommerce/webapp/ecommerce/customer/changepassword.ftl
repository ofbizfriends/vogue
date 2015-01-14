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

<div class="col-md-12">
    <ul class="breadcrumb">
        <li><a href="<@ofbizUrl>main</@ofbizUrl>" class="linktext">${uiLabelMap.CommonHome}</a>
        </li>
        <li>My account</li>
    </ul>


    <div class="box text-center">

        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <h1>My account</h1>
                <p class="lead">Change your personal details or your password here.</p>                
            </div>
        </div>
    </div>

</div>

<div class="col-md-9 clearfix" id="customer-account">
    <div class="box clearfix">

        <h3>
            ${uiLabelMap.PartyChangePassword}
            <span class="pull-right"><a id="CommonGoBack1" href="<@ofbizUrl>${donePage}</@ofbizUrl>" class="btn btn-default">${uiLabelMap.CommonGoBack}</a></span>
        </h3>

        <form id="changepasswordform" method="post" action="<@ofbizUrl>updatePassword/${donePage}</@ofbizUrl>">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="currentPassword">${uiLabelMap.PartyOldPassword}*</label>
                        <input type="password" class="form-control" name="currentPassword" id="currentPassword" maxlength="20" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="newPassword">${uiLabelMap.PartyNewPassword}</label>
                        <input type="password" class='form-control' name="newPassword" id="newPassword" maxlength="20" />*
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="newPasswordVerify">${uiLabelMap.PartyNewPasswordVerify}*</label>
                        <input type="password" class='form-control' name="newPasswordVerify" id="newPasswordVerify" maxlength="20" />
                    </div>
                </div>
            </div>
            <!-- /.row -->
            <div class="form-group">
                <label for="passwordHint">${uiLabelMap.PartyPasswordHint}</label>
                <input type="text" class="form-control" maxlength="100" name="passwordHint" id="passwordHint" value="${userLoginData.passwordHint!}" />
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Save new password</button>
            </div>
        </form>

    </div>
</div>               