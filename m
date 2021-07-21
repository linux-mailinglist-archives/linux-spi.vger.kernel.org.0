Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EE73D0EB0
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 14:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhGULfE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 07:35:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:43837 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231680AbhGULfE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Jul 2021 07:35:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="191699401"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="191699401"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 05:15:40 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="564724111"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 05:15:39 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m6B8P-00Gd8J-Cb; Wed, 21 Jul 2021 15:15:33 +0300
Date:   Wed, 21 Jul 2021 15:15:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [bug report] spi: pxa2xx: Reuse int_stop_and_reset() in couple
 of places
Message-ID: <YPgP5TuvwBh0r5CS@smile.fi.intel.com>
References: <20210721113246.GA24694@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721113246.GA24694@kili>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jul 21, 2021 at 04:32:46AM -0700, Dan Carpenter wrote:
> Hello Andy Shevchenko,
> 
> The patch 3bbdc083262d: "spi: pxa2xx: Reuse int_stop_and_reset() in
> couple of places" from Jul 19, 2021, leads to the following static
> checker warning:
> 
> 	drivers/spi/spi-pxa2xx.c:774 ssp_int()
> 	error: we previously assumed 'drv_data->controller->cur_msg' could be null (see line 773)

>     773 	if (!drv_data->controller->cur_msg) {
> --> 774 		handle_bad_msg(drv_data);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^
> We can't reset with a NULL drv_data->controller->cur_msg.

We can if we handle this inside reset_sccr1() properly.
Thanks for the report and patch on its way!

-- 
With Best Regards,
Andy Shevchenko


