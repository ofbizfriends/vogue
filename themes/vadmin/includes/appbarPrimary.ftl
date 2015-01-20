<#--

-->

<#if (requestAttributes.externalLoginKey)?exists><#assign externalKeyParam = "?externalLoginKey=" + requestAttributes.externalLoginKey?if_exists></#if>
<#if (externalLoginKey)?exists><#assign externalKeyParam = "?externalLoginKey=" + externalLoginKey?if_exists></#if>
<#assign ofbizServerName = application.getAttribute("_serverId")?default("default-server")>
<#assign contextPath = request.getContextPath()>
<#assign displayApps = Static["org.ofbiz.base.component.ComponentConfig"].getAppBarWebInfos(ofbizServerName, "main")>
<#assign displaySecondaryApps = Static["org.ofbiz.base.component.ComponentConfig"].getAppBarWebInfos(ofbizServerName, "secondary")>

<#if applicationMenuName?has_content>
	<#assign appModelMenu = Static["org.ofbiz.widget.menu.MenuFactory"].getMenuFromLocation(applicationMenuLocation,applicationMenuName)>
	<#if appModelMenu.getModelMenuItemByName(headerItem)??>
	  <#if headerItem!="main">
	    <#assign show_last_menu = true>
	  </#if>
	</#if>
</#if>
<#if parameters.portalPageId?exists && !appModelMenu.getModelMenuItemByName(headerItem)?exists>
  <#assign show_last_menu = true>
</#if>




<#if person?has_content>
  <#assign userName = person.firstName?if_exists>
<#elseif partyGroup?has_content>
  <#assign userName = partyGroup.groupName?if_exists>
<#elseif userLogin?exists>
  <#assign userName = userLogin.userLoginId>
<#else>
  <#assign userName = "">
</#if>
<#if defaultOrganizationPartyGroupName?has_content>
  <#assign orgName = " - " + defaultOrganizationPartyGroupName?if_exists>
<#else>
  <#assign orgName = "">
</#if>


<#if layoutSettings.headerImageLinkUrl?exists>
  <#assign logoLinkURL = "${layoutSettings.headerImageLinkUrl}">
<#else>
  <#assign logoLinkURL = "${layoutSettings.commonHeaderImageLinkUrl}">
</#if>
<#assign organizationLogoLinkURL = "${layoutSettings.organizationLogoLinkUrl?if_exists}">




<div id="header" class="header navbar navbar-default navbar-vadmin navbar-fixed-top">
    <div class="container-fluid" id="navbar-container">
        <!-- begin mobile sidebar expand / collapse button -->
        <div class="navbar-header">

            <a href="<@ofbizUrl>${logoLinkURL}</@ofbizUrl>" class="navbar-brand">                
                <#if layoutSettings.headerImageUrl?exists>
                    <#assign headerImageUrl = layoutSettings.headerImageUrl>
                <#elseif layoutSettings.commonHeaderImageUrl?exists>
                    <#assign headerImageUrl = layoutSettings.commonHeaderImageUrl>
                <#elseif layoutSettings.VT_HDR_IMAGE_URL?exists>
                    <#assign headerImageUrl = layoutSettings.VT_HDR_IMAGE_URL.get(0)>
                </#if>
                <#if headerImageUrl?exists>
                    <#if organizationLogoLinkURL?has_content>
                        <div id="org-logo-area"><img alt="${layoutSettings.companyName}" src="<@ofbizContentUrl>${StringUtil.wrapString(organizationLogoLinkURL)}</@ofbizContentUrl>"></div>
                    <#else>
                        
                        <div id="logo-area">
                            
                            <img src="/images/ofbiz_logo.gif" />
                            
                            
                            <#--
                            <img src="${headerImageUrl}" alt="kenolisystems.com"/>
                            -->
                        </div>
                        
                        
                        
                        
                    </#if>
                </#if> 
            </a><#--/.brand-->
            <button type="button" class="navbar-toggle" data-click="sidebar-toggled">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div><#-- ./nav-header -->
        <!-- end mobile sidebar expand / collapse button -->
        
        
            
            <!-- begin header navigation right -->              
            <ul class="nav navbar-nav navbar-right" >
                <li class="dropdown">
                    <a href="javascript:;" data-toggle="dropdown" class="dropdown-toggle f-s-14" aria-expanded="true">
                        <i class="fa fa-th"></i> Applications
                        
                    </a>
                    <ul class="dropdown-menu media-list pull-right animated fadeInDown">                        
		                <#-- apps list -->
		                <#list displayApps as display>
		                    <#assign thisApp = display.getContextRoot()>
		                    <#assign permission = true>
		                    <#assign selected = false>
		                    <#assign permissions = display.getBasePermission()>
		                    <#list permissions as perm>
		                        <#if (perm != "NONE" && !security.hasEntityPermission(perm, "_VIEW", session))>
		                            <#-- User must have ALL permissions in the base-permission list -->
		                            <#assign permission = false>
		                        </#if>
		                    </#list>
		                    <#if permission == true>
		                        <#if thisApp == contextPath || contextPath + "/" == thisApp>
		                            <#assign selected = true>
		                        </#if>
		                        <#assign thisApp = StringUtil.wrapString(thisApp)>
		                        <#assign thisURL = thisApp>
		                        <#if thisApp != "/">
		                            <#assign thisURL = thisURL + "/control/main">
		                        </#if>
		                        <#if layoutSettings.suppressTab?exists && display.name == layoutSettings.suppressTab>
		                          <#-- do not display this component-->
		                        <#else>		                        
		                            <li class=" media <#if selected> active </#if>" >
		                                <a href="${thisURL + externalKeyParam}" title="${uiLabelMap[display.description]}">                                                                                   
                                            <div class="media-left"><i class="fa fa-chevron-right media-object bg-grey-darker"></i></div>
                                            <div class="media-body">
                                                <h5 class="media-heading">${display.title?upper_case}</h5>                                                
                                            </div>		                                                                                                                                                                                                           
		                                </a>
		                            </li>		                            
		                        </#if>
		                    </#if>
		                </#list>  
	                </ul>      
                </li>     
                <#-- ./apps-list -->
                
                
                <#-- organizations-list -->
                
                <#if relatedOrgList?has_content>
                    <li class="dropdown">
                        <a href="javascript:;" data-toggle="dropdown" class="dropdown-toggle f-s-14">
                            <#if orgGroup?has_content>
                            
                                    <i class="fa fa-h-square"></i>        ${orgGroup.groupName?if_exists}   
			                            
                                    <i class="fa fa-caret-down"></i>
                            </#if>
                            
                            
                        </a>
                        
                        <ul class="dropdown-menu media-list pull-right animated fadeInDown">
                            <li class="dropdown-header">Related Organizations</li>
			                <#list relatedOrgList as partyGroupRel>             
				                <li class="media">
	                                <a href="<@ofbizUrl>main?orgid=${partyGroupRel.partyId?if_exists}&search=Y</@ofbizUrl>">
	                                    <div class="pull-left media-object bg-green"><i class="fa fa-h-square"></i></div>
	                                    <div class="media-body">
	                                        <h6 class="media-heading">${partyGroupRel.groupName?if_exists}</h6>
	                                        <div class="text-muted">${partyGroupRel.relationship?if_exists}</div>
	                                    </div>
	                                </a>
	                            </li>
				                
			                </#list>
			            </ul>
                    
                    
                    </li>
                </#if>
                <#-- ./organization-list -->
                
                
                   
	            <#if userLogin?has_content>  <#-- DO NOT show menu items unless the user has logged in.-->
	                <li class="dropdown navbar-user">
	                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
	                        <#--
	                        <img class="nav-user-photo" src="/vadmin/images/avatar.png" alt="${userName}'s Photo">
	                        -->
	                        <span id="user_info" >
	                            <small>Hi,</small>
	                            ${userName}
	                            <i class="fa fa-caret-down"></i>
	                        </span>
		                    
	                    </a>
	
	                        <ul class="dropdown-menu" id="user_menu">
	                            <#--
	                            <li>
	                                <a href="#">
	                                    <i class="fa fa-cog"></i>
	                                    Settings
	                                </a>
	                            </li>
	                            -->
	                            <li>
	                                <a href="/profile/control/main${externalKeyParam}">
	                                    <i class="fa fa-home"></i> Home
	                                </a>
	                            </li>
	    
	                            <li class="divider"></li>
	                            
	                            <li>
                                    <a href="/profile/control/viewprofile${externalKeyParam}">
                                        <i class="fa fa-user"></i> Profile
                                    </a>
                                </li>
        
                                <li class="divider"></li>
	                            
	                            <li>
		                            <a href="<@ofbizUrl>passwordChange</@ofbizUrl>">
		                                <i class="fa fa-exchange"></i>
		                                Change Password
		                            </a>
		                        </li>
		                        
		                        <li class="divider"></li>
		                         
	                            <li>
	                                <a href="<@ofbizUrl>logout</@ofbizUrl>">
	                                    <i class="fa fa-off"></i>
	                                    ${uiLabelMap.CommonLogout}
	                                </a>
	                            </li>
	                        </ul>                    
	                </li>
	            <#else>                             
	                <li class="leaf active">
	                    <a href="/profile/control/main" class="user-menu">
	                        <i class="fa fa-unlock"></i>
	                        LOGIN
	                    </a>
	                </li>                               
	            </#if>
            </ul><#--/.vadmin-nav-->
            <!-- end header navigation right -->
            
        
    </div><#--/.navbar-container-->
</div>
