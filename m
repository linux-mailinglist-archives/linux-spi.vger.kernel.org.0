Return-Path: <linux-spi+bounces-2259-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6F89E210
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 20:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E581F226AC
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 18:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF0615574A;
	Tue,  9 Apr 2024 18:03:36 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564DF85276;
	Tue,  9 Apr 2024 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685816; cv=none; b=gEMnoM0wgl1BdwP3yqNuWScmnNAUDqAKxks00NZuAv50zK642EqbYY7XHyL+qLr3AFhs5b/ZAPqSOIJYg4XtRGSDQWVNQ/Cy13zsDuRqNXyFtxcJ5YhXhJuHLb2hEfHz3eFmEBek7gtt8d/pxkOAlbpbPh3L29NVFymr/OCROf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685816; c=relaxed/simple;
	bh=zWqKSFPU81yS8xorh31vN1bAafoa69UMC9wy1vfua1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plPQYUm0mreOWPkpBODhoDrjfwV1usQAlqAzvSTotxQEA/yYK+MNg3S58atAjj/ynGGBZFNwA0T0JdCxQubw22/DZxEoaJG84KIxzL6af22vEgdAsjQucoOiaGTVK5+MCkr4FS43dfvjd9NmXaHTMwq5iGY/UoXgNVG4q8cmEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: 5ivpZKv1Tzy2xVWcyWjw0g==
X-CSE-MsgGUID: bRhRZ6bFRuOf3slBDayAGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11858825"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11858825"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093713"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="937093713"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 11:03:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6CB0C193; Tue,  9 Apr 2024 21:03:30 +0300 (EEST)
Date: Tue, 9 Apr 2024 21:03:30 +0300
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v4 1/3] gpio: swnode: Add ability to specify native chip
 selects for SPI
Message-ID: <ZhWC8kAMQ4BS4OaC@black.fi.intel.com>
References: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com>
 <20240409132126.1117916-2-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409132126.1117916-2-ckeepax@opensource.cirrus.com>

On Tue, Apr 09, 2024 at 02:21:24PM +0100, Charles Keepax wrote:
> SPI devices can specify a cs-gpios property to enumerate their
> chip selects. Under device tree, a zero entry in this property can
> be used to specify that a particular chip select is using the SPI
> controllers native chip select, for example:
> 
>         cs-gpios = <&gpio1 0 0>, <0>;
> 
> Here the second chip select is native. However, when using swnodes
> there is currently no way to specify a native chip select. The
> proposal here is to register a swnode_gpio_undefined software node,
> that can be specified to allow the indication of a native chip
> select. For example:
> 
> static const struct software_node_ref_args device_cs_refs[] = {
> 	{
> 		.node  = &device_gpiochip_swnode,
> 		.nargs = 2,
> 		.args  = { 0, GPIO_ACTIVE_LOW },
> 	},
> 	{
> 		.node  = &swnode_gpio_undefined,
> 		.nargs = 0,
> 	},
> };
> 
> Register the swnode as the gpiolib is initialised and
> check in swnode_get_gpio_device if the returned node matches

swnode_get_gpio_device()

> swnode_gpio_undefined and return -ENOENT, which matches the behaviour
> of the device tree system when it encounters a 0 phandle.

...

> +config GPIO_SWNODE_UNDEFINED
> +	bool "Undefined swnode GPIOs"

Why is this user visible?

> +	help
> +	  This adds a special place holder for software nodes to contain an
> +	  undefined GPIO reference, this is primarily used by SPI to allow a
> +	  list of GPIO chip selects to mark a certain chip select as being
> +	  controlled the SPI device's internal chip select mechanism and not
> +	  a GPIO.

How are drivers supposed to work in case this is not selected?

...

> +EXPORT_SYMBOL_NS_GPL(swnode_gpio_undefined, GPIO_SWNODE);

+ export.h

> +static int __init swnode_gpio_init(void)

+ init.h

> +		pr_err("gpiolib: failed to register swnode: %d\n", ret);

+ printk.h

-- 
With Best Regards,
Andy Shevchenko



