Return-Path: <linux-spi+bounces-11390-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD9EC73D1F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28EB64E18BC
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B342E6CBF;
	Thu, 20 Nov 2025 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtdVFeCY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD5F21018A;
	Thu, 20 Nov 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763639458; cv=none; b=h+3t47IvR25o8tKPYoEFGdycqGDq4WEFEeHEIQhbiiPOS3iD2o9U3wYU25DY1xACGOOEL+SgBp4uWNavwgKytOECFfrFo6zACpwlux9f58+SRchwo/RZuz8IrUfX6Rxd/pyN36m/7wON9j6AjAgQhGGgUe7mIGTx9+fpES7vxmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763639458; c=relaxed/simple;
	bh=hHuzHnlBqW4WDgV6+GUJEfNxJXUti1RJz1gP54YPtKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmj9e2U212Ydjc16Bj4PJ1DZwIk8no37nlamsgp9rsH8TTphKbWsa8BhRSeXuQmYvd5x8VxYsNGLN+6RW/KJBpedluxa4GSS0PjdV1Q9zUKbrmwWc6VhY9ZHSfaoiKA+CC0bHi9640j1fgvA8qC+Twv53gNE/W55H7n2uUe3yFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EtdVFeCY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763639456; x=1795175456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hHuzHnlBqW4WDgV6+GUJEfNxJXUti1RJz1gP54YPtKg=;
  b=EtdVFeCYUZs/IgpS4UYzCdv0Ed+JcjLXYRa3YEQ+wDbXUNY6RvgaunZT
   75+4jH7Gk+o/VsRWOUZzJSasPEQFAa2gP56Z2VldSUu98LNyDl/dVjGl9
   M9+jSYpGUSgYZggZ5o2W1V6eNIdVnny92s30LcoKSDeOPGTkDcohxaBP2
   5yQjSFAb2M4rJEIkkFQazZR4NsvziXTKtQDORsZAQJVbV6ot/lVCvXMf1
   VynTJmnukPwZlp551uQ3JbfF7Ux+kVes8f54ajYf27JVFeBIA8xl1mZsv
   QU6npWT3RxRIxBEkqarPj7Nqud5UACUmGe3y5FVKEfcXKn2giwe5043xP
   w==;
X-CSE-ConnectionGUID: CWd1kIhzQAKWVufqw6EkOg==
X-CSE-MsgGUID: hQ8cUDYOQ/+fRaTtKHuijQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="91189714"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="91189714"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 03:50:55 -0800
X-CSE-ConnectionGUID: /OUwqpHdRZOp+oyMqNDyoA==
X-CSE-MsgGUID: LlR79JmkS1qGQbx/fm4ZMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="222275428"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 03:50:53 -0800
Date: Thu, 20 Nov 2025 13:50:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
	andy@kernel.org, p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org, bartosz.golaszewski@linaro.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2] spi: cs42l43: Use actual ACPI firmware node for chip
 selects
Message-ID: <aR8AmhcY_y93O3GM@smile.fi.intel.com>
References: <20251120105907.1373797-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120105907.1373797-1-ckeepax@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 20, 2025 at 10:59:07AM +0000, Charles Keepax wrote:
> On some systems the cs42l43 has amplifiers attached to its SPI
> controller that are not properly defined in ACPI. Currently
> software nodes are added to support this case, however, the chip
> selects for these devices are specified using a hack. A software
> node is added with the same name as the pinctrl driver, as the
> look up was name based, this allowed the GPIO look up to return
> the pinctrl driver even though the swnode was not owned by it.
> This was necessary as the swnodes did not support directly
> linking to real firmware nodes.
> 
> Since commit e5d527be7e69 ("gpio: swnode: don't use the swnode's
> name as the key for GPIO lookup") changed the lookup to be
> fwnode based this hack will no longer find the pinctrl driver,
> resulting in the driver not probing. There is no pinctrl driver
> attached to the swnode itself. But other patches did add support
> for linking a swnode to a real fwnode node [1]. As such the hack
> is no longer needed, so switch over to just passing the real
> fwnode for the pinctrl property to avoid any issues.

...

> +		struct property_entry props[] = {
> +			PROPERTY_ENTRY_REF_ARRAY_LEN("cs-gpios", args, ARRAY_SIZE(args)),

No need to open code PROPERTY_ENTRY_REF_ARRAY().

> +			{ }
> +		};

-- 
With Best Regards,
Andy Shevchenko



