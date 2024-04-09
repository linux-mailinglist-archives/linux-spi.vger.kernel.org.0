Return-Path: <linux-spi+bounces-2261-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0862E89E27D
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 20:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C861C211AC
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 18:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA0156C46;
	Tue,  9 Apr 2024 18:26:50 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BEF156892;
	Tue,  9 Apr 2024 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687210; cv=none; b=MrR289ggAJy62ajTck3h0dzRelvTkExznCkJDP6REok8QuQRTLrhO0gq3YiJwRh1yN60CFkGGIpW8jbQ2N/myCzT3aGdTcnR+k2JHbMup5MjigERhCLl8Mq6VvCLRAlJpRlY+hay+xKtKvlRLaGeCCNqM2gNJntkGasJewQdsnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687210; c=relaxed/simple;
	bh=sE41A36unxs9xF9gJ4myqUWYHNi43pa7OySsXW4BmZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkSkRE4ZRd/2j2SCwRTUcAgIwoeTms6mZ+qz21Vt5oW0PmMIBvKjoH2zYmg43THx9PetW8fTy2Xw3CiZSu4eXyBO+ORpA7nlDPNEqz5uIqZ/9y+w5anto1W99XAyUBTWb4KbmZKsUC2OOxFBDWkp0941TlEQs8Y9rhGK7VVTL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: mzEY1YzETti7oqn0Ys5/jw==
X-CSE-MsgGUID: 3lELVDI1S9Ca8+arOBkqQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11794435"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11794435"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093733"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="937093733"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 11:26:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9E1F6193; Tue,  9 Apr 2024 21:26:44 +0300 (EEST)
Date: Tue, 9 Apr 2024 21:26:44 +0300
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v4 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <ZhWIZFvfYb85Pftm@black.fi.intel.com>
References: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com>
 <20240409132126.1117916-4-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409132126.1117916-4-ckeepax@opensource.cirrus.com>

On Tue, Apr 09, 2024 at 02:21:26PM +0100, Charles Keepax wrote:
> From: Maciej Strozek <mstrozek@opensource.cirrus.com>
> 
> On some cs42l43 systems a couple of cs35l56 amplifiers are attached
> to the cs42l43's SPI and I2S. On Windows the cs42l43 is controlled
> by a SDCA class driver and these two amplifiers are controlled by
> firmware running on the cs42l43. However, under Linux the decision
> was made to interact with the cs42l43 directly, affording the user
> greater control over the audio system. However, this has resulted
> in an issue where these two bridged cs35l56 amplifiers are not
> populated in ACPI and must be added manually.
> 
> Check for the presence of the "01fa-cirrus-sidecar-instances" property
> in the SDCA extension unit's ACPI properties to confirm the presence
> of these two amplifiers and if they exist add them manually onto the
> SPI bus.

...

> +#include <linux/acpi.h>
> +#include <linux/array_size.h>
>  #include <linux/bits.h>
>  #include <linux/bitfield.h>
>  #include <linux/device.h>
>  #include <linux/errno.h>
> +#include <linux/gpio/machine.h>

Shouldn't you include gpio/property.h as well?
Ah, in the previous patch you put swnode to consumer.h instead of
gpio/property.h. Please, fix that.

>  #include <linux/mfd/cs42l43.h>
>  #include <linux/mfd/cs42l43-regs.h>
>  #include <linux/mod_devicetable.h>

>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  #include <linux/units.h>

...

> +static const struct software_node ampl = {
> +	.name			= "cs35l56-left",
> +};
> +
> +static const struct software_node ampr = {
> +	.name			= "cs35l56-right",
> +};

What these swnodes are for?

...

> +static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
> +{
> +	static const u32 func_smart_amp = 0x1;
> +	struct fwnode_handle *child_fwnode, *ext_fwnode;
> +	unsigned int val;
> +	u32 function;
> +	int ret;
> +
> +	fwnode_for_each_child_node(fwnode, child_fwnode) {
> +		struct acpi_device *adev = to_acpi_device_node(child_fwnode);
> +
> +		if (!adev)
> +			continue;
> +
> +		ret = acpi_get_local_address(adev->handle, &function);
> +		if (ret || function != func_smart_amp) {

> +			fwnode_handle_put(child_fwnode);

Why?

> +			continue;
> +		}
> +
> +		ext_fwnode = fwnode_get_named_child_node(child_fwnode,
> +				"mipi-sdca-function-expansion-subproperties");
> +		if (!ext_fwnode) {

> +			fwnode_handle_put(child_fwnode);

Ditto.

> +			continue;
> +		}
> +
> +		ret = fwnode_property_read_u32(ext_fwnode,
> +					       "01fa-cirrus-sidecar-instances",
> +					       &val);
> +
> +		fwnode_handle_put(ext_fwnode);

> +		fwnode_handle_put(child_fwnode);

Ditto.

Haven't you get reference underflow?

> +
> +		if (!ret)
> +			return !!val;
> +	}
> +

> +	return false;
> +}

...

> +MODULE_IMPORT_NS(GPIO_SWNODE);

> +

Stray blank line.

>  MODULE_DESCRIPTION("CS42L43 SPI Driver");
>  MODULE_AUTHOR("Lucas Tanure <tanureal@opensource.cirrus.com>");
>  MODULE_AUTHOR("Maciej Strozek <mstrozek@opensource.cirrus.com>");

-- 
With Best Regards,
Andy Shevchenko



