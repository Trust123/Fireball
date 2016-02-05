﻿<div id="pageAddForm">
<script data-relocate="true" src="{@$__wcf->getPath('cms')}acp/js/CMS.ACP{if !ENABLE_DEBUG_MODE}.min{/if}.js"></script>
<script data-relocate="true">
	//<![CDATA[
	$(function() {
		WCF.TabMenu.init();
		{if $action == 'add'}
			$('#createMenuItem').click(function() {
				$('#menuItemID').parents('dl:eq(0)').toggle();
			});
		{/if}

		$('#enableDelayedDeactivation, #enableDelayedPublication').click(function() {
			var $toggleContainerID = $(this).data('toggleContainer');
			$('#'+ $toggleContainerID).toggle();
		});
		WCF.Language.addObject({
			'cms.acp.page.alias.preview': '{lang}fireball.acp.page.alias.preview{/lang}',
		});
		new CMS.ACP.Page.Alias.Preview('#alias', '#parentID', '{link application="cms" controller="Page" alias="123456789" forceFrontend=true}{/link}');

	});
	//]]>
</script>
<div class="tabMenuContainer" data-active="" data-store="activeTabMenuItem">
		<nav class="tabMenu">
			<ul>
				<li><a href="{@$__wcf->getAnchor('general')}">{lang}fireball.acp.page.general{/lang}</a></li>
				<li><a href="{@$__wcf->getAnchor('display')}">{lang}fireball.acp.page.display{/lang}</a></li>
				<li><a href="{@$__wcf->getAnchor('userPermissions')}">{lang}fireball.acp.page.userPermissions{/lang}</a></li>
				{event name='tabMenuTabs'}
			</ul>
		</nav>

		<div id="general" class="container containerPadding tabMenuContent">
			<fieldset>
				<legend>{lang}wcf.global.form.data{/lang}</legend>

				<dl>
					<dt><label for="title">{lang}wcf.global.title{/lang}</label></dt>
					<dd>
						<input type="text" id="title" name="title" value="{$title}" class="long" required="required" />
						{*include file='multipleLanguageInputJavascript' elementIdentifier='title' forceSelection=true*}
					</dd>
				</dl>

				<dl>
					<dt><label for="alias">{lang}fireball.acp.page.alias{/lang}</label></dt>
					<dd>
						<input type="text" id="alias" name="alias" value="{$alias}" class="long" />

						<small>{lang}fireball.acp.page.alias.description{/lang}</small>
						<small class="jsAliasPreview"></small>
					</dd>
				</dl>

				<dl>
					<dt><label for="description">{lang}fireball.acp.page.general.description{/lang}</label></dt>
					<dd>
						<textarea id="description" name="description" rows="5" cols="40" class="long">{$description}</textarea>
						{*include file='multipleLanguageInputJavascript' elementIdentifier='description' forceSelection=false*}
					</dd>
				</dl>

				{if $action == 'add'}
					<dl>
						<dt class="reversed"><label for="createMenuItem">{lang}fireball.acp.page.general.createMenuItem{/lang}</label></dt>
						<dd>
							<input type="checkbox" id="createMenuItem" name="createMenuItem"{if $createMenuItem} checked="checked"{/if} />
							<small>{lang}fireball.acp.page.general.createMenuItem.description{/lang}</small>
						</dd>
					</dl>
				{/if}

				{event name='dataFields'}
			</fieldset>

			<fieldset>
				<legend>{lang}fireball.acp.page.meta{/lang}</legend>

				<dl>
					<dt><label for="metaDescription">{lang}fireball.acp.page.meta.description{/lang}</label></dt>
					<dd>
						<textarea id="metaDescription" name="metaDescription" rows="5" cols="40" class="long">{$metaDescription}</textarea>
						<small>{lang}fireball.acp.page.meta.description.description{/lang}</small>

						{*include file='multipleLanguageInputJavascript' elementIdentifier='metaDescription' forceSelection=false*}
					</dd>
				</dl>

				<dl>
					<dt><label for="metaKeywords">{lang}fireball.acp.page.meta.keywords{/lang}</label></dt>
					<dd>
						<input type="text" id="metaKeywords" name="metaKeywords" value="{$metaKeywords}" class="long" />
						{*include file='multipleLanguageInputJavascript' elementIdentifier='metaKeywords' forceSelection=false*}
					</dd>
				</dl>

				<dl>
					<dt class="reversed"><label for="allowIndexing">{lang}fireball.acp.page.meta.allowIndexing{/lang}</label></dt>
					<dd>
						<input type="checkbox" id="allowIndexing" name="allowIndexing"{if $allowIndexing} checked="checked"{/if} />
					</dd>
				</dl>

				{event name='metaFields'}
			</fieldset>

			<fieldset>
				<legend>{lang}fireball.acp.page.position{/lang}</legend>

				{hascontent}
					<dl>
						<dt><label for="parentID">{lang}fireball.acp.page.general.parentID{/lang}</label></dt>
						<dd>
							<select id="parentID" name="parentID">
								<option value="0" {if $parentID == 0} selected="selected"{/if} data-alias="">{lang}wcf.global.noSelection{/lang}</option>
								{content}
									{foreach from=$pageList item=$node}
										<option data-alias="{$node->getAlias()}"{if $node->pageID == $parentID} selected="selected"{/if} value="{@$node->pageID}">{@"&nbsp;&nbsp;&nbsp;&nbsp;"|str_repeat:$pageList->getDepth()}{$node->getTitle()}</option>
									{/foreach}
								{/content}
							</select>
						</dd>
					</dl>
				{/hascontent}

				<dl>
					<dt><label for="showOrder">{lang}fireball.acp.page.position{/lang}</label></dt>
					<dd>
						<input type="number" id="showOrder" name="showOrder" value="{$showOrder}" class="tiny" min="0" />
						<small>{lang}fireball.acp.page.position.description{/lang}</small>
					</dd>
				</dl>

				<dl>
					<dt class="reversed"><label for="invisible">{lang}fireball.acp.page.position.invisible{/lang}</label></dt>
					<dd>
						<input type="checkbox" name="invisible" id="invisible" value="1"{if $invisible} checked="checked"{/if} />
						<small>{lang}fireball.acp.page.position.invisible.description{/lang}</small>
					</dd>
				</dl>

				{event name='positionFields'}
			</fieldset>

			<fieldset>
				<legend>{lang}fireball.acp.page.publication{/lang}</legend>

				<dl>
					<dt class="reversed"><label for="enableDelayedPublication">{lang}fireball.acp.page.publication.enableDelayedPublication{/lang}</label></dt>
					<dd>
						<input type="checkbox" id="enableDelayedPublication" name="enableDelayedPublication" value="1"{if $enableDelayedPublication} checked="checked"{/if} data-toggle-container="publicationDateContainer" />
					</dd>
				</dl>

				<dl id="publicationDateContainer"{if !$enableDelayedPublication} style="display: none"{/if}>
					<dt><label for="publicationDate">{lang}fireball.acp.page.publication.publicationDate{/lang}</label></dt>
					<dd>
						<input type="datetime" id="publicationDate" name="publicationDate" class="medium" value="{$publicationDate}" />
					</dd>
				</dl>

				<dl>
					<dt class="reversed"><label for="enableDelayedDeactivation">{lang}fireball.acp.page.publication.enableDelayedDeactivation{/lang}</label></dt>
					<dd>
						<input type="checkbox" id="enableDelayedDeactivation" name="enableDelayedDeactivation" value="1"{if $enableDelayedDeactivation} checked="checked"{/if} data-toggle-container="deactivationDateContainer" />
					</dd>
				</dl>

				<dl id="deactivationDateContainer"{if !$enableDelayedDeactivation} style="display: none"{/if}>
					<dt><label for="deactivationDate">{lang}fireball.acp.page.publication.deactivationDate{/lang}</label></dt>
					<dd>
						<input type="datetime" id="deactivationDate" name="deactivationDate" class="medium" value="{$deactivationDate}" />
						
					</dd>
				</dl>

				{event name='publicationFields'}
			</fieldset>

			<fieldset>
				<legend>{lang}fireball.acp.page.settings{/lang}</legend>

				<dl class="formError"{if $action == 'add' && $createMenuItem} style="display: none"{/if}>
					<dt><label for="menuItemID">{lang}fireball.acp.page.settings.menuItemID{/lang}</label></dt>
					<dd>
						<select id="menuItemID" name="menuItemID">
							<option value="0">{lang}wcf.global.noSelection{/lang}</option>
							{foreach from=$menuItems item=menuItem}
								<option value="{@$menuItem->menuItemID}"{if $menuItemID == $menuItem->menuItemID} selected="selected"{/if}>{$menuItem->menuItem|language}</option>
								{foreach from=$menuItem item=childMenuItem}
									<option value="{@$childMenuItem->menuItemID}"{if $menuItemID == $childMenuItem->menuItemID} selected="selected"{/if}>&nbsp;&nbsp;&nbsp;&nbsp;{$childMenuItem->menuItem|language}</option>
								{/foreach}
							{/foreach}
						</select>
						
						<small>{lang}fireball.acp.page.settings.menuItemID.description{/lang}</small>
					</dd>
				</dl>

				<dl>
					<dt class="reversed"><label for="isCommentable">{lang}fireball.acp.page.settings.isCommentable{/lang}</label></dt>
					<dd>
						<input type="checkbox" name="isCommentable" id="isCommentable" value="1"{if $isCommentable == 1} checked="checked"{/if} />
						<small>{lang}fireball.acp.page.settings.isCommentable.description{/lang}</small>
					</dd>
				</dl>

				<dl>
					<dt class="reversed"><label for="availableDuringOfflineMode">{lang}fireball.acp.page.settings.availableDuringOfflineMode{/lang}</label></dt>
					<dd>
						<input type="checkbox" name="availableDuringOfflineMode" id="availableDuringOfflineMode" value="1"{if $availableDuringOfflineMode} checked="checked"{/if} />
					</dd>
				</dl>

				<dl>
					<dt class="reversed"><label for="allowSubscribing">{lang}fireball.acp.page.settings.allowSubscribing{/lang}</label></dt>
					<dd>
						<input type="checkbox" id="allowSubscribing" name="allowSubscribing"{if $allowSubscribing} checked="checked"{/if} />
						<small>{lang}fireball.acp.page.settings.allowSubscribing.description{/lang}</small>
					</dd>
				</dl>

				{event name='settingsFields'}
			</fieldset>

			{event name='fieldsets'}
		</div>

		<div id="display" class="container containerPadding tabMenuContent">
			<fieldset>
				<legend>{lang}fireball.acp.page.display{/lang}</legend>

				<dl>
					<dt><label for="styleID">{lang}fireball.acp.page.styleID{/lang}</label></dt>
					<dd>
						<select id="styleID" name="styleID">
							<option value="0">{lang}wcf.global.noSelection{/lang}</option>
							{htmlOptions options=$availableStyles selected=$styleID}
						</select>
						<small>{lang}fireball.acp.page.styleID.description{/lang}</small>
					</dd>
				</dl>

				{hascontent}
					<dl>
						<dt>{lang}fireball.acp.page.stylesheets{/lang}</dt>
						<dd>
							{content}
								{htmlCheckboxes name='stylesheetIDs' options=$stylesheetList selected=$stylesheetIDs}
							{/content}
							
							<small>{lang}fireball.acp.page.stylesheets.description{/lang}</small>
						</dd>
					</dl>
				{/hascontent}

				{event name='displayFields'}
			</fieldset>

			<fieldset>
				<legend>{lang}fireball.acp.page.display.settings{/lang}</legend>

				<dl>
					<dt><label for="sidebarOrientation">{lang}fireball.acp.page.display.settings.sidebarOrientation{/lang}</label></dt>
					<dd>
						<select id="sidebarOrientation" name="sidebarOrientation">
							<option value="right"{if $sidebarOrientation =="right"} selected="selected"{/if}>{lang}fireball.acp.page.display.settings.sidebarOrientation.right{/lang}</option>
							<option value="left"{if $sidebarOrientation =="left"} selected="selected"{/if}>{lang}fireball.acp.page.display.settings.sidebarOrientation.left{/lang}</option>
						</select>
					</dd>
				</dl>

				{event name='displaySettingsFields'}
			</fieldset>

			{event name='afterDisplayFieldsets'}
		</div>

		<div id="userPermissions" class="container containerPadding tabMenuContent">
			<fieldset>
				<legend>{lang}wcf.acl.permissions{/lang}</legend>

				<dl id="userPermissionsContainer" class="wide">
					<dd></dd>
				</dl>
			</fieldset>

			{event name='afterPermissionsFieldsets'}
		</div>

		{event name='tabMenuContents'}
	</div>

	<div class="formSubmit">
		<input type="submit" value="{lang}wcf.global.button.submit{/lang}" />
		{@SECURITY_TOKEN_INPUT_TAG}
	</div>
</div>