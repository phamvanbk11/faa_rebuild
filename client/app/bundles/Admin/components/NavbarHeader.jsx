import React from 'react';
import {FormattedMessage, injectIntl, intlShape} from 'react-intl';
import {defaultMessages} from '../../../libs/i18n/default';

class NavbarHeader extends React.Component {
  static propTypes = {
    intl: intlShape.isRequired
  }

  constructor(props, _railsContext) {
    super(props);
  }

  render() {
    const {formatMessage} = this.props.intl;

    return (
      <div className="navbar-header">
        <button type="button" className="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
          <span className="sr-only">{formatMessage(defaultMessages.adminNavbarHeaderBrand)}</span>
          <span className="icon-bar" />
          <span className="icon-bar" />
          <span className="icon-bar" />
        </button>
        <a className="navbar-brand" href="/" target="_blank">{formatMessage(defaultMessages.adminNavbarHeaderBrand)}</a>
      </div>
    );
  }
}

export default injectIntl(NavbarHeader);
