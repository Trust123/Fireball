<dl class="images">
	<dt><label for="images">{lang}cms.acp.content.type.de.codequake.cms.content.type.gallery.images{/lang}</label></dt>
	<dd>
		<div id="filePicker">
			<ul class="formAttachmentList clearfix"></ul>
			<span class="button small">{lang}cms.acp.file.picker{/lang}</span>
		</div>
	</dd>
</dl>

<script data-relocate="true">
	//<![CDATA[
	$(function () {
		WCF.Language.addObject({
			'wcf.global.button.upload': '{lang}wcf.global.button.upload{/lang}'
		});

		new CMS.ACP.File.Preview();
		new CMS.ACP.File.Picker($('#filePicker > .button'), 'contentData[imageIDs]', {
			{if $imageList|isset}
				{implode from=$imageList item='image'}
					{@$image->fileID}: {
						fileID: {@$image->fileID},
						title: '{$image->getTitle()}',
						formattedFilesize: '{@$image->filesize|filesize}'
					}
				{/implode}
			{/if}
		}, { multiple: true, fileType: 'image' });
	});
	//]]>
</script>
