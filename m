Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23AE1DECB7
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgEVQCd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 12:02:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:59139 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730031AbgEVQCd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 12:02:33 -0400
IronPort-SDR: 7ycjfE3re2AzWJU+RiNV4+/2hInQy8KA0ILKT7g/geWZPzI4+f34gtKwFtLsTJB/9KzOKmzWI6
 GYHAs7Jmcs0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 09:02:32 -0700
IronPort-SDR: wivrcMNzeJXKNQX77IU2fAM7ZA0mTWjZhTkayi++yPyvp1tpMUK8+DoDZd5QhlPjzREnEZQB3a
 9Zk1wWoXnbYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="269041517"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 22 May 2020 09:02:30 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jcA81-008G7U-VM; Fri, 22 May 2020 19:02:33 +0300
Date:   Fri, 22 May 2020 19:02:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Make spi_delay_exec() warn if called from atomic
 context
Message-ID: <20200522160233.GH1634618@smile.fi.intel.com>
References: <20200522155005.46099-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522155005.46099-1-broonie@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 04:50:05PM +0100, Mark Brown wrote:
> If the delay used is long enough the spi_delay_exec() will use a sleeping
> function to implement it. Add a might_sleep() here to help avoid callers
> using this from an atomic context and running into problems at runtime on
> other systems.

Thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Suggested-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/spi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index e02f434affca..c69d23379e08 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1160,6 +1160,8 @@ int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer)
>  {
>  	int delay;
>  
> +	might_sleep();
> +
>  	if (!_delay)
>  		return -EINVAL;
>  
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


