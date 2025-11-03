Return-Path: <linux-spi+bounces-10972-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A945C2AF27
	for <lists+linux-spi@lfdr.de>; Mon, 03 Nov 2025 11:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FB734ED5C3
	for <lists+linux-spi@lfdr.de>; Mon,  3 Nov 2025 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F232FAC18;
	Mon,  3 Nov 2025 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j36fOhzN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987842F3612;
	Mon,  3 Nov 2025 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164820; cv=none; b=JejaRqnAJCHNNffGxZhsxS2g2PGrBbLrpkxJeMeWze4dzCLFgNwiq1yxRsZl6sQW5Wszof/YYlCI7TyOB5rJEj84+yaD+UUG2nFPi6FhKbKLUg8r9gPYSgw/3DjH+wxz5fUNv+/LYrzR0TIXTjUg+RbK+ET0qJXCC81v6jXGmzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164820; c=relaxed/simple;
	bh=ZZzHs+5Bi+cHdy4zlvLm2DFCrupMI90Vf6b6xn4yLiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKUAZfzSrRsMhYvsFejo8Z8V7MldeS3qNeMLObgkacb/Kio+8ibFWDAIR/pEFpkngfOLpSwjW2UQbblTqaeGw7teVKQPmWJMrqFPvVkfdABSlzzm0yW72S4wDXLXUVE4BC4jlY5mNWH5o67Mn3KC0YAO4YoOUW4B1X+nQC1tGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j36fOhzN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762164819; x=1793700819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZZzHs+5Bi+cHdy4zlvLm2DFCrupMI90Vf6b6xn4yLiI=;
  b=j36fOhzN9MZSdpIcgLDOY6uPw6jiCh7WH4R4jt8GLLZA7t9RkuEVDp83
   VsbHRToRjFeIb0HH83EqDvquGm11pxApyC63lKhB0buDPIbf+9B5KecBb
   92DY52w2amkjeHaoKfz2h9kZYpzwIFOd2Uhl6fvW9cuKAKJ9z5XRMk5Ue
   NW1eoF8mIGP9TS1PeC0zUwpnOObnADygyeFhgSHNfw1WgodXQ3/qErsqg
   kdNa9k+W/AVfF0IWZ7jxcF3ifQuvngLJVVnTb7u9saFcky7mVb8KlDAnt
   ATbE1f7zViTrxvr1Vy0S0xe9O4n6AUwThPU+Ry9lJ33CrHCTt5sP5RNE7
   Q==;
X-CSE-ConnectionGUID: NuC+0uelQzKRW6AqDr8ZuQ==
X-CSE-MsgGUID: qquV+kGFSsyCXsfWWRpxBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="67889891"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="67889891"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:13:39 -0800
X-CSE-ConnectionGUID: vHhfMnw6Ql+x5RDRkQyGFA==
X-CSE-MsgGUID: lgoWsthGTfm56C8iQZ1azQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="191170168"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:13:37 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFrZ7-000000057Jl-21wF;
	Mon, 03 Nov 2025 12:13:33 +0200
Date: Mon, 3 Nov 2025 12:13:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: Try to get ACPI GPIO IRQ earlier
Message-ID: <aQiATDzxEIKBytXw@smile.fi.intel.com>
References: <20251102190921.30068-1-hansg@kernel.org>
 <aQh3RJQ95jTx7VYO@smile.fi.intel.com>
 <f8dc0e8b-bbdc-4ac6-9ebc-c633bda24403@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8dc0e8b-bbdc-4ac6-9ebc-c633bda24403@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 10:57:44AM +0100, Hans de Goede wrote:
> On 3-Nov-25 10:35 AM, Andy Shevchenko wrote:
> > On Sun, Nov 02, 2025 at 08:09:21PM +0100, Hans de Goede wrote:
> >> Since commit d24cfee7f63d ("spi: Fix acpi deferred irq probe"), the
> >> acpi_dev_gpio_irq_get() call gets delayed till spi_probe() is called
> >> on the SPI device.
> >>
> >> If there is no driver for the SPI device then the move to spi_probe()
> >> results in acpi_dev_gpio_irq_get() never getting called. This may
> >> cause problems by leaving the GPIO pin floating because this call is
> >> responsible for setting up the GPIO pin direction and/or bias according
> >> to the values from the ACPI tables.
> >>
> >> Re-add the removed acpi_dev_gpio_irq_get() in acpi_register_spi_device()
> >> to ensure the GPIO pin is always correctly setup, while keeping the
> >> acpi_dev_gpio_irq_get() call added to spi_probe() to deal with
> >> -EPROBE_DEFER returns caused by the GPIO controller not having a driver
> >> yet.
> > 
> > Even before following the link to some papering over module via the link below
> > I wondered, if the I²C case should be covered as well. The
> > https://github.com/alexpevzner/hotfix-kvadra-touchpad refers to I²C enabled
> > touchpads.
> > 
> >> Link: https://bbs.archlinux.org/viewtopic.php?id=302348

...

> > I'm not against the SPI fix, but is it confirmed that it really fixes the issue?
> 
> Yes Mark and I got an offlist email bisecting this to the:
> 
> Fixes: d24cfee7f63d ("spi: Fix acpi deferred irq probe")
> 
> commit (on a stable kernel series) and a later email confirming that this
> patch fixes it.

Shouldn't we use Closes in this case instead of Link?

> It seems that leaving the fingerprint reader enable pin (the first GPIO
> listed in _CRS which is an output only pin, is likely the enable pin)
> floating is causing these issues. So in a way the acpi_dev_gpio_irq_get()
> fixing this by forcing the enable pin to no longer float is a bit of
> luck. But things did work before d24cfee7f63d ("spi: Fix acpi deferred irq probe")
> so we need this to fix a regression

Yeah, fixing a regression is good thing, but not papering over the issue.

> and as you indicate it seems
> like a good idea in general and maybe we should also do this for i2c.

> As for doing something similar for I2C devices, that is an interesting
> question. Even though it is possible I'm not aware of any i2c-devices
> which have a userspace driver like SPI/USB fingerprint readers do,
> so on i2c I would expect probe() to always get called. So I'm not sure
> it is necessary there.

Reading the problem statement (the second paragraph) I lean towards
a generic solution residing somewhere in drivers/acpi/scan.c (like
acpi_init_device_object() / acpi_bus_attach() calls), although I don't
see a quick way how to achieve this. It seems would require a bit of
refactoring to allow ACPI glue code to call specific subsystem calls
or making a GPIOLIB to provide some "early" initialisation flow(s).


-- 
With Best Regards,
Andy Shevchenko



