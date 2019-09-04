Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50F2A82DB
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2019 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfIDMeY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Sep 2019 08:34:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:4080 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbfIDMeY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Sep 2019 08:34:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 05:34:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="194716420"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2019 05:34:21 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i5UUO-0000nP-7s; Wed, 04 Sep 2019 15:34:20 +0300
Date:   Wed, 4 Sep 2019 15:34:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: of: fix fallback quirks handling
Message-ID: <20190904123420.GK2680@smile.fi.intel.com>
References: <20190903231856.GA165165@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903231856.GA165165@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 03, 2019 at 04:18:56PM -0700, Dmitry Torokhov wrote:
> We should only try to execute fallback quirks handling when previous
> call returned -ENOENT, and not when we did not get -EPROBE_DEFER.
> The other errors should be treated as hard errors: we did find the GPIO
> description, but for some reason we failed to handle it properly.
> 
> The fallbacks should only be executed when previous handlers returned
> -ENOENT, which means the mapping/description was not found.
> 
> Also let's remove the explicit deferral handling when iterating through
> GPIO suffixes: it is not needed anymore as we will not be calling
> fallbacks for anything but -ENOENT.
> 

I would rather leave extra parenthesis and comments untouched,
nevertheless, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: df451f83e1fc ("gpio: of: fix Freescale SPI CS quirk handling")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpio/gpiolib-of.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index b034abe59f28..b45b39c48a34 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -457,36 +457,27 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
>  
>  		desc = of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
>  						&of_flags);
> -		/*
> -		 * -EPROBE_DEFER in our case means that we found a
> -		 * valid GPIO property, but no controller has been
> -		 * registered so far.
> -		 *
> -		 * This means we don't need to look any further for
> -		 * alternate name conventions, and we should really
> -		 * preserve the return code for our user to be able to
> -		 * retry probing later.
> -		 */
> -		if (IS_ERR(desc) && PTR_ERR(desc) == -EPROBE_DEFER)
> -			return desc;
>  
> -		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
> +		if (!IS_ERR(desc) || PTR_ERR(desc) != -ENOENT)
>  			break;
>  	}
>  
> -	/* Special handling for SPI GPIOs if used */
> -	if (IS_ERR(desc))
> +	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT) {
> +		/* Special handling for SPI GPIOs if used */
>  		desc = of_find_spi_gpio(dev, con_id, &of_flags);
> -	if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER) {
> +	}
> +
> +	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT) {
>  		/* This quirk looks up flags and all */
>  		desc = of_find_spi_cs_gpio(dev, con_id, idx, flags);
>  		if (!IS_ERR(desc))
>  			return desc;
>  	}
>  
> -	/* Special handling for regulator GPIOs if used */
> -	if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
> +	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT) {
> +		/* Special handling for regulator GPIOs if used */
>  		desc = of_find_regulator_gpio(dev, con_id, &of_flags);
> +	}
>  
>  	if (IS_ERR(desc))
>  		return desc;
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
> 
> -- 
> Dmitry

-- 
With Best Regards,
Andy Shevchenko


