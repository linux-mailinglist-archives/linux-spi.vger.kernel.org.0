Return-Path: <linux-spi+bounces-11071-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CDCC3A381
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 11:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B98418C75E3
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F10B2309B9;
	Thu,  6 Nov 2025 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXn3yd68"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241441760;
	Thu,  6 Nov 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424204; cv=none; b=heTH7sPvsBMqZnWL7+I6efdJNFL7Otqp72P/7aRe+1PKrO+kY6qzpd6zdppUswp/zfw4q96u4qugDyMEVubkScY768oUJyY6gWQhMya6qMcFe1lp3W32q3xYhXdwxWIFzLwmBixcF97LfVIb/V+NOpavbP2YtmyIPW1Ky3tXVh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424204; c=relaxed/simple;
	bh=F2w8YHR9YhxjBieyUGuR3XiVqy1SfvUXyaO0c0GLx78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqhDyxDfJYH64eLjxw7GjIEfDvqcGMyHKM42BRXKgIXj5VvHmv80V1ltk3Kt37bjiYgdXjzUeEG2EYBFyEh8+liwyqaBhPHIB+vNPR0Vs7U/uXsE2H9Kzzd9zT1OeWH32OfZZbWWTD4EHU+9oxJbEXLOyuCsNvYZFBMniKk42II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXn3yd68; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762424203; x=1793960203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=F2w8YHR9YhxjBieyUGuR3XiVqy1SfvUXyaO0c0GLx78=;
  b=AXn3yd683oKPAXEp7jkKkWXjwPPlfoHER2uJR5/BZ4w+E/VsAvYO61/7
   n+OKfZ4BNhNrwCP3nMCEacQR/oSCBEl2AyAVP+znbD8RB8E/fetbeQ09O
   oUahiH4k8EUuSCDe+OW4VQ97gBNk+4QLLpRDg/mpncZ0WQUf+FdPuwEbM
   HZ+aVyJXthGnzzSXeTUO4RnKvjmxFuCy6+xC0EuvhjjEdql0CVd6AC+lQ
   T3ywX6RRJK46zaPo1zbNfSWkn84x4CfAz40Q9l8jaPEm0ZyfqsF4B0ajM
   w2+jU/fX09NLq8KMOISkFcGJSqW1laAcvecVnZ9WzBtZmC/qJR6ncKyIE
   Q==;
X-CSE-ConnectionGUID: PaINpChLRRGchfQJyCNYow==
X-CSE-MsgGUID: 8by0si82RaCroGwW9nGPRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75166941"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="75166941"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 02:16:42 -0800
X-CSE-ConnectionGUID: V2zMms2eR+G2RAbcGSD1Uw==
X-CSE-MsgGUID: 7t467nQTR4e3kBNIi1hldw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="211183094"
Received: from jjgreens-desk21.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.229])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 02:16:40 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGx2j-000000063XJ-0MJp;
	Thu, 06 Nov 2025 12:16:37 +0200
Date: Thu, 6 Nov 2025 12:16:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: Try to get ACPI GPIO IRQ earlier
Message-ID: <aQx1hPtuBKmLnLgA@smile.fi.intel.com>
References: <20251102190921.30068-1-hansg@kernel.org>
 <aQh3RJQ95jTx7VYO@smile.fi.intel.com>
 <f8dc0e8b-bbdc-4ac6-9ebc-c633bda24403@kernel.org>
 <aQiATDzxEIKBytXw@smile.fi.intel.com>
 <af07a18b-cfc8-47d1-ac5a-b343cbfe0f36@kernel.org>
 <aQiq4_W6AL1n-Geh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQiq4_W6AL1n-Geh@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 03:15:15PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 03, 2025 at 11:20:30AM +0100, Hans de Goede wrote:
> > On 3-Nov-25 11:13 AM, Andy Shevchenko wrote:
> > > On Mon, Nov 03, 2025 at 10:57:44AM +0100, Hans de Goede wrote:
> > >> On 3-Nov-25 10:35 AM, Andy Shevchenko wrote:
> > >>> On Sun, Nov 02, 2025 at 08:09:21PM +0100, Hans de Goede wrote:
> > >>>> Since commit d24cfee7f63d ("spi: Fix acpi deferred irq probe"), the
> > >>>> acpi_dev_gpio_irq_get() call gets delayed till spi_probe() is called
> > >>>> on the SPI device.
> > >>>>
> > >>>> If there is no driver for the SPI device then the move to spi_probe()
> > >>>> results in acpi_dev_gpio_irq_get() never getting called. This may
> > >>>> cause problems by leaving the GPIO pin floating because this call is
> > >>>> responsible for setting up the GPIO pin direction and/or bias according
> > >>>> to the values from the ACPI tables.
> > >>>>
> > >>>> Re-add the removed acpi_dev_gpio_irq_get() in acpi_register_spi_device()
> > >>>> to ensure the GPIO pin is always correctly setup, while keeping the
> > >>>> acpi_dev_gpio_irq_get() call added to spi_probe() to deal with
> > >>>> -EPROBE_DEFER returns caused by the GPIO controller not having a driver
> > >>>> yet.
> > >>>
> > >>> Even before following the link to some papering over module via the link below
> > >>> I wondered, if the I²C case should be covered as well. The
> > >>> https://github.com/alexpevzner/hotfix-kvadra-touchpad refers to I²C enabled
> > >>> touchpads.
> > >>>
> > >>>> Link: https://bbs.archlinux.org/viewtopic.php?id=302348

...

> > >>> I'm not against the SPI fix, but is it confirmed that it really fixes the issue?
> > >>
> > >> Yes Mark and I got an offlist email bisecting this to the:
> > >>
> > >> Fixes: d24cfee7f63d ("spi: Fix acpi deferred irq probe")
> > >>
> > >> commit (on a stable kernel series) and a later email confirming that this
> > >> patch fixes it.
> > > 
> > > Shouldn't we use Closes in this case instead of Link?
> > 
> > I guess so.
> > 
> > >> It seems that leaving the fingerprint reader enable pin (the first GPIO
> > >> listed in _CRS which is an output only pin, is likely the enable pin)
> > >> floating is causing these issues. So in a way the acpi_dev_gpio_irq_get()
> > >> fixing this by forcing the enable pin to no longer float is a bit of
> > >> luck. But things did work before d24cfee7f63d ("spi: Fix acpi deferred irq probe")
> > >> so we need this to fix a regression
> > > 
> > > Yeah, fixing a regression is good thing, but not papering over the issue.
> > 
> > I agree in principle, but this is a quick and safe way to fix
> > the regression, where as the generic fix you describe below is
> > likely months away and also has significant risks of causing
> > regressions in various places, see below.
> 
> Perhaps we should add a TODO / FIXME there as well?
> So at least we will know that this is not a proper solution.

Assuming it's added
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
as a quick fix of the regression. But in long term I would like to see the real
solution here.

> > >> and as you indicate it seems
> > >> like a good idea in general and maybe we should also do this for i2c.
> > > 
> > >> As for doing something similar for I2C devices, that is an interesting
> > >> question. Even though it is possible I'm not aware of any i2c-devices
> > >> which have a userspace driver like SPI/USB fingerprint readers do,
> > >> so on i2c I would expect probe() to always get called. So I'm not sure
> > >> it is necessary there.
> > > 
> > > Reading the problem statement (the second paragraph) I lean towards
> > > a generic solution residing somewhere in drivers/acpi/scan.c (like
> > > acpi_init_device_object() / acpi_bus_attach() calls), although I don't
> > > see a quick way how to achieve this. It seems would require a bit of
> > > refactoring to allow ACPI glue code to call specific subsystem calls
> > > or making a GPIOLIB to provide some "early" initialisation flow(s).
> > 
> > I guess that you want to do the direction and bias init on all
> > GPIOs listed in _CRS, at least for devices with status == present ?
> 
> For the devices that are serial busses only (I²C, SPI, UART).
> 
> > I was wondering about the same thing, but ACPI tables are full
> > of, well, erm, garbage in various places so I'm afraid that doing
> > this for all GPIO _CRS resources is likely to cause a whole lot
> > of pain.
> > 
> > Typically the firmware already sets up the direction + bias
> > of all used pins. I'm pretty sure the BIOS-es have some GPIO
> > init table especially for this somewhere.
> > 
> > Now those init-tables may have bugs, but I'm seriously worried
> > about the implication of doing the direction + bios setup for
> > all _CRS GPIO entries. I have simply seen too much non sense
> > devices (with _STA returning 0x0f) listing GPIOs also actually
> > used elsewhere to think this is a good idea.
> 
> Btw, other GPIO initialisation issues we have been solving by adding quirks.
> Why this one can't be targeted with the same approach?

-- 
With Best Regards,
Andy Shevchenko



