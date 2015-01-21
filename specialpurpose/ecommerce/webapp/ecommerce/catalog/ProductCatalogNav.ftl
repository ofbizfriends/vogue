


<#if completedTree?has_content>
    
	<#list completedTree as root>	
            
            <li class="dropdown yamm-fw">
                <#if root.child?has_content>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><#if root.categoryName?has_content>${root.categoryName}<#else>${root.productCategoryId?if_exists}</#if>  <b class="caret"></b></a>
                <#else>
                    <a href="<@ofbizCatalogUrl currentCategoryId=root.productCategoryId previousCategoryId=root.primaryParentCategoryId/>"><#if root.categoryName?has_content>${root.categoryName}<#else>${root.productCategoryId?if_exists}</#if> </a>
                </#if>
                <ul class="dropdown-menu">

                    <li>
                        <div class="yamm-content">
                            <#if root.child?has_content>
	                            <div class="row">
	                                <div class="col-sm-3">
	                                    <#assign imageUrl = root.categoryImageUrl?default('/images/nocontentfound.png')/>
	                                    <a href="<@ofbizCatalogUrl currentCategoryId=root.productCategoryId previousCategoryId=root.primaryParentCategoryId/>"> 
	                                       <img class="img-responsive" src="<@ofbizContentUrl>${imageUrl}</@ofbizContentUrl>" alt="${titleText?default("Link Image")}"/>
	                                    </a>
	                                </div>
	                                <#list root.child as firstChildCat>
		                                <div class="col-sm-3">	  
		                                    <a href="<@ofbizCatalogUrl currentCategoryId=firstChildCat.productCategoryId previousCategoryId=root.productCategoryId/>">                                   
		                                      <h3><#if firstChildCat.categoryName?has_content>${firstChildCat.categoryName}<#else>${firstChildCat.productCategoryId?if_exists}</#if></h3>
		                                    </a>
		                                    <#if root.child?has_content>
		                                        <ul>
                                                    <#list firstChildCat.child as secondChildCat>			                                    				                                   
				                                        <li>
				                                            <a href="<@ofbizCatalogUrl currentCategoryId=secondChildCat.productCategoryId previousCategoryId=firstChildCat.productCategoryId/>">
				                                                <#if secondChildCat.categoryName?has_content>${secondChildCat.categoryName}<#else>${secondChildCat.productCategoryId?if_exists}</#if>
				                                            </a>
				                                        </li>				                                    
				                                    </#list>
				                                </ul>        
		                                    </#if>
		                                </div>
	                                </#list>	                                
	                            </div>
                            </#if>
                        </div>
                        <div class="footer clearfix hidden-xs">                            
                            <#--
                            <div class="buttons pull-right">
                                <a href="#" class="btn btn-default"><i class="fa fa-tags"></i> Sales</a>
                                <a href="#" class="btn btn-default"><i class="fa fa-star-o"></i> Favourites</a>
                                <a href="#" class="btn btn-default"><i class="fa fa-globe"></i> Brands</a>
                            </div>
                            -->
                            <a href="<@ofbizCatalogUrl currentCategoryId=root.productCategoryId?if_exists previousCategoryId=root.primaryParentCategoryId?if_exists/>">                                
                                <h4 class="pull-left"><#if root.categoryName?has_content>${root.categoryName}<#else>${root.productCategoryId?if_exists}</#if> </h4>
                            </a>
                        </div>

                    </li>
                </ul>
            </li>	    
	</#list>                	                
</#if>                
                
                
                