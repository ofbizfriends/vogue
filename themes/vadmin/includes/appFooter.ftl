
<div id="toTop" style="display: block;">
  <i class="fa fa-angle-up"></i>
</div>
<div id="footer">
    <div class="">
    <!-- .items-footer -->
      <div class="row clearfix items-footer">
        <div class="col-xs-12 col-sm-6 col-md-8 col-lg-8 menu">
          <h4>More @ VOGUE</h4>
          <ul class="list-unstyled">
            <li><a href="/" >Home</a></li>
            <#--
            <li><a href="/about.html" >About</a></li>
            -->
          </ul>
        </div>
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
          <h4>Need Help?</h4>
          <div class="row">
            <div class="col-xs-6">
                <p><i class="fa fa-envelope"></i> ${email?default("team@kenolisystems.com")}  </p>                
            </div>
            <div class="col-xs-6">
                <p><i class="fa fa-phone"></i> ${telephone?default("81053 02975")}  </p>                
            </div>
          </div>
        </div>
      </div><#-- /.items-footer -->
    </div><#-- ./container -->
    <div class="">      
      <!-- .copyright -->
      <div class="row clearfix copyright">
        <!-- .social-icon -->
        <div class="col-xs-12 col-sm-6 col-md-8 col-lg-8 social-icon">
          <ul class="list-unstyled list-inline">
            <li><a href="https://www.facebook.com/ohealth.com" target="_BLANK"><i class="fa fa-facebook bigger-150"></i></a></li>            
            <#--
            <li><a href="#" target="_BLANK" ><i class="fa fa-google-plus bigger-150"></i></a></li>
            -->
            <li><a href="http://www.youtube.com/user/ohealth" target="_BLANK"><i class="fa fa-youtube bigger-150"></i></a></li>
          </ul>
        </div><!-- /.social-icon -->
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4 copyright-text">
          <p ><strong>VOGUE</strong> &copy; ${nowTimestamp?string("yyyy")} . Powered by <a href="http://www.kenolisystems.com" target="_blank">VOGUE</a></p>
        </div>
      </div><!-- /.copyright -->
    </div>
  </div>