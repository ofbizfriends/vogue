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


<div class="navbar navbar-default navbar-fixed-top yamm" role="navigation" id="navbar">
    <div class="container">
        <div class="navbar-header">

            <a class="navbar-brand home" href="/ecommerce">
            
			    <#if sessionAttributes.overrideLogo?has_content>
			        <img src="<@ofbizContentUrl>${sessionAttributes.overrideLogo}</@ofbizContentUrl>" alt="Logo" class="hidden-xs hidden-sm"/>
			    <#elseif catalogHeaderLogo?has_content>
			        <img src="<@ofbizContentUrl>${catalogHeaderLogo}</@ofbizContentUrl>" alt="Logo" class="hidden-xs hidden-sm"/>
			    <#elseif layoutSettings.VT_HDR_IMAGE_URL?has_content>
			        <img src="<@ofbizContentUrl>${layoutSettings.VT_HDR_IMAGE_URL.get(0)}</@ofbizContentUrl>" alt="Logo" class="hidden-xs hidden-sm"/>
			    </#if>                            
                <img src="/images/ofbiz_logo-small.gif" alt="Minimal logo" class="visible-xs visible-sm"><span class="sr-only">Minimal - go to homepage</span>
            </a>
            <div class="navbar-buttons">
                <button type="button" class="navbar-toggle btn-primary" data-toggle="collapse" data-target="#navigation">
                    <span class="sr-only">Toggle navigation</span>
                    <i class="fa fa-align-justify"></i>
                </button>                
                <a class="btn btn-primary navbar-toggle" href="<@ofbizUrl>view/showcart</@ofbizUrl>">
                    <i class="fa fa-shopping-cart"></i>  <span class="hidden-xs">3 items in cart</span>
                </a>
                <button type="button" class="navbar-toggle btn-default" data-toggle="collapse" data-target="#search">
                    <span class="sr-only">Toggle search</span>
                    <i class="fa fa-search"></i>
                </button>
                <#if sessionAttributes.userLogin?has_content && sessionAttributes.userLogin.userLoginId != "anonymous">
	                <button type="button" class="navbar-toggle btn-default" data-toggle="modal" data-target="#user-modal">
                        <span class="sr-only">User login</span>
                        <i class="fa fa-user"></i>
                    </button>
                <#else>
                    <button type="button" class="navbar-toggle btn-default" data-toggle="modal" data-target="#login-modal">
                        <span class="sr-only">User login</span>
                        <i class="fa fa-lock"></i>
                    </button>
	                                	                
                </#if>

            </div>
        </div>
        <!--/.navbar-header -->

        ${screens.render("component://ecommerce/widget/CartScreens.xml#microcart")}
        
        <!--/.nav-collapse -->

        <div class="navbar-collapse collapse right">
            <button type="button" class="btn navbar-btn btn-default" data-toggle="collapse" data-target="#search">
                <span class="sr-only">Toggle search</span>
                <i class="fa fa-search"></i>
            </button>
        </div>

        <div class="navbar-collapse collapse right">
            <#if sessionAttributes.userLogin?has_content && sessionAttributes.userLogin.userLoginId != "anonymous">
                <button type="button" class="btn navbar-btn btn-default" data-toggle="modal" data-target="#user-modal">
	                <span class="sr-only">Toggle user</span>
	                <i class="fa fa-user"></i>
	            </button>
            <#else>
                <button type="button" class="btn navbar-btn btn-default" data-toggle="modal" data-target="#login-modal">
                    <span class="sr-only">User login</span>
                    <i class="fa fa-lock"></i>
                </button>                             
            </#if>
        </div>

        <div class="collapse clearfix" id="search">
            ${screens.render("component://ecommerce/widget/CatalogScreens.xml#keywordsearchbox")}            
        </div>
        <!--/.nav-collapse -->


        <div class="navbar-collapse collapse" id="navigation">

            <ul class="nav navbar-nav navbar-left">
                
                ${screens.render("component://ecommerce/widget/CatalogScreens.xml#productCatalogNav")}                
                
                
            </ul>

        </div>
        <!--/.nav-collapse -->


    </div>


</div>

<#if sessionAttributes.userLogin?has_content && sessionAttributes.userLogin.userLoginId != "anonymous">
	<!-- *** USER MODAL *** -->
	
	<div class="modal fade" id="user-modal" tabindex="-1" role="dialog" aria-labelledby="Login" aria-hidden="true">
	    <div class="modal-dialog modal-sm">
	
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="User">
	                    <#if sessionAttributes.autoName?has_content>
	                      ${uiLabelMap.CommonWelcome}&nbsp;${sessionAttributes.autoName?html}!                    
	                    <#else/>
	                      ${uiLabelMap.CommonWelcome}!
	                    </#if>
	                </h4>
	            </div>
	            <div class="modal-body">
	                <p class="text-muted"><a href="<@ofbizUrl>viewprofile</@ofbizUrl>" class="linktext"><strong>${uiLabelMap.CommonProfile}</strong></a></p>
	                <hr/>
	                <p class="text-muted"><a href="<@ofbizUrl>orderhistory</@ofbizUrl>">${uiLabelMap.EcommerceOrderHistory}</a></p>
	                <hr/>
	                <p class="text-muted"><a href="<@ofbizUrl>editShoppingList</@ofbizUrl>">${uiLabelMap.EcommerceShoppingLists}</a></p>
	                <hr/>
                    <p class="text-muted"><a href="<@ofbizUrl>autoLogout</@ofbizUrl>" class="linktext"><strong>${uiLabelMap.CommonLogout}</strong></a></p>
                    
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- *** USER MODAL END *** -->

<#else>
	<!-- *** LOGIN MODAL *** -->
	
	<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="Login" aria-hidden="true">
	    <div class="modal-dialog modal-sm">
	
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="Login">Login</h4>
	            </div>
	            <div class="modal-body">
	                <form action="<@ofbizUrl>login</@ofbizUrl>" method="post">
	                    <div class="form-group">
	                        <input type="text" class="form-control" id="email" placeholder="${uiLabelMap.CommonEmail}" name="USERNAME">
	                    </div>
	                    <div class="form-group">
	                        <input type="password" class="form-control" id="password" name="PASSWORD" placeholder="${uiLabelMap.CommonPassword}">
	                    </div>
	
	                    <p class="text-center">
	                        <button class="btn btn-primary"><i class="fa fa-sign-in"></i> ${uiLabelMap.CommonLogin}</button>
	                    </p>
	
	                </form>         
	
	                <p class="text-center text-muted">Not registered yet?</p>
	                <p class="text-center text-muted"><a href="<@ofbizUrl>newcustomer</@ofbizUrl>"><strong>${uiLabelMap.EcommerceRegister}</strong></a>!</p> 
	                <p>It is easy and done in 1&nbsp;minute and gives you access to special discounts and much more!</p>
	
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- *** LOGIN MODAL END *** -->
</#if>
<!-- ./header -->

