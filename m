Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D0C326608
	for <lists+linux-spi@lfdr.de>; Fri, 26 Feb 2021 18:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhBZRFK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Feb 2021 12:05:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:50956 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhBZRFF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 26 Feb 2021 12:05:05 -0500
IronPort-SDR: +c9y/S5se88wdus1BBlwGKdixztgK/4FstVqJgg8LqmAt1HpPeKBNaQaoOIPHDyMuA1Yp/QGBP
 dLkUr5jt8Q4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="247353201"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="247353201"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 09:03:12 -0800
IronPort-SDR: z/vSgVa1z4xt+j8enQ47g/W/ChsEIJq16t8zawwQgZ9iNY52slQAVZOu3y/3i4fzjfN/Gor8uc
 rTgyZ0n2n22A==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="502385376"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 09:03:11 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lFgWD-008PHW-43; Fri, 26 Feb 2021 19:03:09 +0200
Date:   Fri, 26 Feb 2021 19:03:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] parport: Introduce module_parport_driver() helper
 macro
Message-ID: <YDkpzZ8jL7O9HJuG@smile.fi.intel.com>
References: <20210216110741.1286-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216110741.1286-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Feb 16, 2021 at 01:07:39PM +0200, Andy Shevchenko wrote:
> Introduce module_parport_driver() helper macro to reduce boilerplate
> in the existing and new code.

Sudip, any comments on this?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: fixed typo in the macro
>  include/linux/parport.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/parport.h b/include/linux/parport.h
> index 1fb508c19e83..54539b80021e 100644
> --- a/include/linux/parport.h
> +++ b/include/linux/parport.h
> @@ -301,9 +301,19 @@ int __must_check __parport_register_driver(struct parport_driver *,
>  	__parport_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
>  
>  /* Unregister a high-level driver. */
> -extern void parport_unregister_driver (struct parport_driver *);
>  void parport_unregister_driver(struct parport_driver *);
>  
> +/**
> + * module_parport_driver() - Helper macro for registering a modular parport driver
> + * @__parport_driver: struct parport_driver to be used
> + *
> + * Helper macro for parport drivers which do not do anything special in module
> + * init and exit. This eliminates a lot of boilerplate. Each module may only
> + * use this macro once, and calling it replaces module_init() and module_exit().
> + */
> +#define module_parport_driver(__parport_driver) \
> +	module_driver(__parport_driver, parport_register_driver, parport_unregister_driver)
> +
>  /* If parport_register_driver doesn't fit your needs, perhaps
>   * parport_find_xxx does. */
>  extern struct parport *parport_find_number (int);
> -- 
> 2.30.0
> 

-- 
With Best Regards,
Andy Shevchenko


