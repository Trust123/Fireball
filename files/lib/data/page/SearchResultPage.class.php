<?php
namespace cms\data\page;

use wcf\data\search\ISearchResultObject;
use wcf\data\user\User;
use wcf\data\user\UserProfile;
use wcf\system\request\LinkHandler;
use wcf\system\search\SearchResultTextParser;

/**
 * @author	Jens Krumsieck
 * @copyright	2014 codeQuake
 * @license	GNU Lesser General Public License <http://www.gnu.org/licenses/lgpl-3.0.txt>
 * @package	de.codequake.cms
 */

class SearchResultPage extends ViewablePage implements ISearchResultObject {

	protected $userProfile = null;

	public function getFormattedMessage() {
		return SearchResultTextParser::getInstance()->parse($this->description);
	}

	public function getLink($query = '') {
		if ($query) {
			return LinkHandler::getInstance()->getLink('Page', array(
				'alias' => $this->getDecoratedObject()->getAlias(),
				'application' => 'cms',
				'highlight' => urlencode($query)
			));
		}

		return $this->getDecoratedObject()->getLink();
	}

	public function getSubject() {
		$this->getDecoratedObject()->getTitle();
	}

	public function getUserProfile() {
		if ($this->userProfile === null) {
			$this->userProfile = new UserProfile(new User(null, $this->getDecoratedObject()->data));
		}

		return $this->userProfile;
	}

	public function getTime() {
		return $this->creationTime;
	}

	public function getObjectTypeName() {
		return 'de.codequake.cms.page';
	}

	public function getContainerLink() {
		return '';
	}

	public function getContainerTitle() {
		return '';
	}
}
