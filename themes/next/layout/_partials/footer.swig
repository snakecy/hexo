<script async src="//dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-heart"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
</div>

<div class="powered-by">
  {{ __('footer.powered', '<a class="theme-link" href="http://hexo.io">Hexo</a>') }}
</div>

<div class="theme-info">
  {{ __('footer.theme') }} -
  <a class="theme-link" href="https://github.com/iissnan/hexo-theme-next">
    NexT.{{ theme.scheme }}
  </a>
</div>

<span id="busuanzi_container_site_pv">
  &nbsp; | &nbsp; <span id="busuanzi_value_site_pv"></span> hits from
</span>

<span id="busuanzi_container_site_uv"> <span id="busuanzi_value_site_uv"></span> vistors
</span>

{% block footer %}{% endblock %}
