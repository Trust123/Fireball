<?php
namespace cms\data\page;

use cms\data\content\DrainedPositionContentNodeTree;
use cms\data\CMSDatabaseObject;
use cms\system\layout\LayoutHandler;
use cms\system\page\PagePermissionHandler;
use cms\system\revision\PageRevisionHandler;
use wcf\data\ILinkableObject;
use wcf\system\menu\page\PageMenu;
use wcf\system\request\IRouteController;
use wcf\system\request\LinkHandler;
use wcf\system\WCF;

/**
 * Represents a page.
 *
 * @author	Jens Krumsieck
 * @copyright	2014 codeQuake
 * @license	GNU Lesser General Public License <http://www.gnu.org/licenses/lgpl-3.0.txt>
 * @package	de.codequake.cms
 */
class Page extends CMSDatabaseObject implements IRouteController, ILinkableObject {
	/**
	 * @see	\wcf\data\DatabaseObject::$databaseTableName
	 */
	protected static $databaseTableName = 'page';

	/**
	 * @see	\wcf\data\DatabaseObject::$databaseTableIndexName
	 */
	protected static $databaseTableIndexName = 'pageID';

	/**
	 * @see	\wcf\data\ITitledObject::getTitle()
	 */
	public function getTitle() {
		return WCF::getLanguage()->get($this->title);
	}

	public function getLayout() {
		$stylesheets = @unserialize($this->stylesheets);
		if (is_array($stylesheets) && !empty($stylesheets)) {
			return LayoutHandler::getInstance()->getStylesheet($this->pageID);
		}

		return '';
	}

	public function isVisible() {
		if ($this->invisible == 1 && $this->isDisabled == 0) {
			if ($this->getPermission('canViewInvisiblePage')) return true;
			return false;
		}
		if ($this->isDisabled == 1 && $this->invisible == 0) {
			if ($this->getPermission('canViewDisabledPage')) return true;
			return false;
		}

		if ($this->isDisabled == 1 && $this->invisible == 1) {
			if ($this->getPermission('canViewDisabledPage') && $this->getPermission('canViewInvisiblePage')) return true;
			return false;
		}
		if ($this->getPermission('canViewPage')) return true;
		return false;
	}

	public function isAccessible() {
		if (!$this->isPublished && !WCF::getSession()->getPermission('mod.cms.canReadUnpublishedPage')) {
			// user can't read unpublished pages
			return false;
		}

		return $this->getPermission('canEnterPage');
	}

	public function isChild() {
		if ($this->parentID) return true;
		return false;
	}

	public function hasChildren() {
		$list = new PageList();
		$list->getConditionBuilder()->add('page.parentID = (?)', array(
			$this->pageID
		));
		if ($list->countObjects() != 0) return true;
		return false;
	}

	public function getChildren() {
		$list = new PageList();
		$list->getConditionBuilder()->add('page.parentID = (?)', array(
			$this->pageID
		));
		$list->readObjects();
		$list = $list->getObjects();
		return $list;
	}

	public function getChildrenTree($maxDepth = -1) {
		$tree = new PageNodeTree($this->pageID);
		$tree = $tree->getIterator();
		if ($maxDepth >= 0) $tree->setMaxDepth($maxDepth);
		return $tree;
	}

	// builds up a complete folder structure like link
	public function getAlias() {
		// returns page alias
		if ($this->getParentPage() != null) {
			return $this->getParentPage()->getAlias() . '/' . $this->alias;
		}

		return $this->alias;
	}

	public function getLink() {
		return LinkHandler::getInstance()->getLink('Page', array(
			'application' => 'cms',
			'forceFrontend' => true,
			'alias' => $this->getAlias()
		));
	}

	public function getParentPage() {
		if ($this->isChild()) {
			return PageCache::getInstance()->getPage($this->parentID);
		}
		return null;
	}

	public function getParentPages() {
		if ($this->isChild()) {
			$parentPages = array();
			$parent = $this;
			while ($parent = $parent->getParentPage()) {
				$parentPages[] = $parent;
			}
			$parentPages = array_reverse($parentPages);
			return $parentPages;
		}
		return array();
	}

	public function getContents() {
		$contentListBody = new DrainedPositionContentNodeTree(null, $this->pageID, null, 'body');
		$contentListSidebar = new DrainedPositionContentNodeTree(null, $this->pageID, null, 'sidebar');
		$contentList = array(
			'body' => $contentListBody->getIterator(),
			'sidebar' => $contentListSidebar->getIterator()
		);
		return $contentList;
	}

	public function getRevisions() {
		//gets page revisions
		return PageRevisionHandler::getInstance()->getRevisions($this->pageID);
	}

	public function getPermission($permission = 'canViewPage') {
		$permissions = PagePermissionHandler::getInstance()->getPermission($this);
		if (isset($permissions[$permission])) {
			return $permissions[$permission];
		}
		return WCF::getSession()->getPermission('user.cms.page.' . $permission);
	}

	public function checkPermission(array $permissions = array('canViewPage')) {
		foreach ($permissions as $permission) {
			if (! $this->getPermission($permission)) {
				throw new PermissionDeniedException();
			}
		}
	}

	public function getMenuItem() {
		foreach (PageMenu::getInstance()->getMenuItems('header') as $item) {
			if ($item->menuItemID == $this->menuItemID) return $item;
		}
		foreach (PageMenu::getInstance()->getMenuItems('footer') as $item) {
			if ($item->menuItemID == $this->menuItemID) return $item;
		}
		return null;
	}
}
