import React from 'react';
import { MoreOutlined } from '@ant-design/icons';
import { Link } from 'react-router';

const MoreToggleIcon = React.forwardRef(({ onClick }, ref) => (
  <Link
    to="#"
    ref={ref as any}
    onClick={(e) => {
      e.preventDefault();
      onClick(e);
    }}
  >
    <MoreOutlined />
  </Link>
));

export default MoreToggleIcon;
