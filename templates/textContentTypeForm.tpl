﻿<dl class="wide">
	<dt><label for="text">{lang}cms.acp.content.type.de.codequake.cms.content.type.text.text{/lang}</label></dt>
	<dd>
		<textarea name="contentData[text]" id="text">{$i18nPlainValues['text']}</textarea>

		{include file='wysiwyg'}
		{include file='wysiwygI18n' elementIdentifier='text' forceSelection=false}
	</dd>
</dl>

