<?php
namespace cms\page;

use wcf\system\comment\CommentHandler;
use wcf\system\style\StyleHandler;
use wcf\system\WCF;

/**
 * Shows a created page.
 * 
 * @author	Jens Krumsieck
 * @copyright	2013 - 2017 codeQuake
 * @license	GNU Lesser General Public License <http://www.gnu.org/licenses/lgpl-3.0.txt>
 * @package	de.codequake.cms
 */
class PagePage extends AbstractCMSPage {
	/**
	 * structured list of page comments
	 * @var	\wcf\data\comment\StructuredCommentList
	 */
	public $commentList = null;

	/**
	 * comment manager object
	 * @var	\wcf\system\comment\manager\ICommentManager
	 */
	public $commentManager = null;

	/**
	 * object type id for comments
	 * @var	integer
	 */
	public $commentObjectTypeID = 0;

	/**
	 * @inheritDoc
	 */
	public function readData() {
		parent::readData();

		// change style
		if ($this->page->styleID && StyleHandler::getInstance()->getStyle()->styleID != $this->page->styleID) {
			StyleHandler::getInstance()->changeStyle($this->page->styleID, true);
		}
		
		// comments
		if ($this->page->isCommentable) {
			$this->commentObjectTypeID = CommentHandler::getInstance()->getObjectTypeID('de.codequake.cms.page.comment');
			$this->commentManager = CommentHandler::getInstance()->getObjectType($this->commentObjectTypeID)->getProcessor();
			$this->commentList = CommentHandler::getInstance()->getCommentList($this->commentManager, $this->commentObjectTypeID, $this->page->pageID);
		}
	}

	/**
	 * @inheritDoc
	 */
	public function assignVariables() {
		parent::assignVariables();

		WCF::getTPL()->assign([
			'likeData' => ((MODULE_LIKE && $this->commentList) ? $this->commentList->getLikeData() : []),
			'commentCanAdd' => $this->page->getPermission('user.canAddComment'),
			'commentList' => $this->commentList,
			'commentObjectTypeID' => $this->commentObjectTypeID,
			'lastCommentTime' => ($this->commentList ? $this->commentList->getMinCommentTime() : 0)
		]);
	}
}
