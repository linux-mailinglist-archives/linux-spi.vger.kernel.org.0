Return-Path: <linux-spi+bounces-10975-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B9CC2C060
	for <lists+linux-spi@lfdr.de>; Mon, 03 Nov 2025 14:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65F2188479D
	for <lists+linux-spi@lfdr.de>; Mon,  3 Nov 2025 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3E51C84BD;
	Mon,  3 Nov 2025 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9BpxbsN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8B230F52C;
	Mon,  3 Nov 2025 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175725; cv=none; b=WcNdUk6GAY7J9nW/LMY5g9tPUNqalv1B6qchGxguEL88BA2pTnpghFG4yxfBtxA4wkqRDTKyJYl/NeAlkiHcDsH9fB6MmMgJN42hHVrotj9kHqPigLN40GXf3Qwhq4q5y9ZzCKDRMCMYppY15A2N+Q1UUDSyg5hwjh0omVuRwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175725; c=relaxed/simple;
	bh=BrUO1cTuo9HyN2IfjVfYTebP2gccBlnbEGfKcY5hl1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDta4olUU2j1GGYPHIgfJuEjfiPvXSR27UldceHckbwJPnDT8PoUN3hLZ8PrUwfy/3k89Ij9un96CkKtj34/s6ixacYgg+nuQxKP3zqE7JNtik4npLUPM940mJC4TsRNNuxXnEmBRRKxN+nOM9m85OKnBwPbc8DFA9RzfkTA5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9BpxbsN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762175723; x=1793711723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BrUO1cTuo9HyN2IfjVfYTebP2gccBlnbEGfKcY5hl1Y=;
  b=R9BpxbsNLi+OLBtP9lVsjaM1BcnHKPKGddCqwF1F76bBkmNTk4sHZb0p
   IhiVTm37/FWvGLzvyiZPX7ZCc0ytacuX1XS8WTKmOErufBUxrD8CkwEs4
   Hrtmvh3Xsqyfjr0jOefXwaTRLl8XX0g6YxQfMdX8ciAmBGB/UOQa2F0nb
   SWtmC9yyOhibn/657mOxosMpSKc8E3PGb1ze2DfGWMBzO/6Io/GJ1yyhb
   lP1P4v9u+W2NbYzds3eO9wJRWymfjbBIZ9NBk2uSC73hIqvxUiBklOyI6
   TJiP6tPv5+lR8acg5TWswPD7qVj8mDNNC3lLtt6U7bDrbLBUxfrUd4nVz
   Q==;
X-CSE-ConnectionGUID: NUanCj8IQXKZdx7Z26NZjA==
X-CSE-MsgGUID: y5VM+1igRgy3HMstEh2kbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="89711441"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="89711441"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 05:15:21 -0800
X-CSE-ConnectionGUID: 2nVMVhYKS1+Szz2U6eBIYg==
X-CSE-MsgGUID: x7QyeuscRq+VoOU3ce8bdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186105007"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 05:15:20 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFuOy-000000059bH-2oEI;
	Mon, 03 Nov 2025 15:15:16 +0200
Date: Mon, 3 Nov 2025 15:15:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: Try to get ACPI GPIO IRQ earlier
Message-ID: <aQiq4_W6AL1n-Geh@smile.fi.intel.com>
References: <20251102190921.30068-1-hansg@kernel.org>
 <aQh3RJQ95jTx7VYO@smile.fi.intel.com>
 <f8dc0e8b-bbdc-4ac6-9ebc-c633bda24403@kernel.org>
 <aQiATDzxEIKBytXw@smile.fi.intel.com>
 <af07a18b-cfc8-47d1-ac5a-b343cbfe0f36@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af07a18b-cfc8-47d1-ac5a-b343cbfe0f36@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 11:20:30AM +0100, Hans de Goede wrote:
> On 3-Nov-25 11:13 AM, Andy Shevchenko wrote:
> > On Mon, Nov 03, 2025 at 10:57:44AM +0100, Hans de Goede wrote:
> >> On 3-Nov-25 10:35 AM, Andy Shevchenko wrote:
> >>> On Sun, Nov 02, 2025 at 08:09:21PM +0100, Hans de Goede wrote:
> >>>> Since commit d24cfee7f63d ("spi: Fix acpi deferred irq probe"), the
> >>>> acpi_dev_gpio_irq_get() call gets delayed till spi_probe() is called
> >>>> on the SPI device.
> >>>>
> >>>> If there is no driver for the SPI device then the move to spi_probe()
> >>>> results in acpi_dev_gpio_irq_get() never getting called. This may
> >>>> cause problems by leaving the GPIO pin floating because this call is
> >>>> responsible for setting up the GPIO pin direction and/or bias according
> >>>> to the values from the ACPI tables.
> >>>>
> >>>> Re-add the removed acpi_dev_gpio_irq_get() in acpi_register_spi_device()
> >>>> to ensure the GPIO pin is always correctly setup, while keeping the
> >>>> acpi_dev_gpio_irq_get() call added to spi_probe() to deal with
> >>>> -EPROBE_DEFER returns caused by the GPIO controller not having a driver
> >>>> yet.
> >>>
> >>> Even before following the link to some papering over module via the link below
> >>> I wondered, if the I²C case should be covered as well. The
> >>> https://github.com/alexpevzner/hotfix-kvadra-touchpad refers to I²C enabled
> >>> touchpads.
> >>>
> >>>> Link: https://bbs.archlinux.org/viewtopic.php?id=302348

...

> >>> I'm not against the SPI fix, but is it confirmed that it really fixes the issue?
> >>
> >> Yes Mark and I got an offlist email bisecting this to the:
> >>
> >> Fixes: d24cfee7f63d ("spi: Fix acpi deferred irq probe")
> >>
> >> commit (on a stable kernel series) and a later email confirming that this
> >> patch fixes it.
> > 
> > Shouldn't we use Closes in this case instead of Link?
> 
> I guess so.
> 
> >> It seems that leaving the fingerprint reader enable pin (the first GPIO
> >> listed in _CRS which is an output only pin, is likely the enable pin)
> >> floating is causing these issues. So in a way the acpi_dev_gpio_irq_get()
> >> fixing this by forcing the enable pin to no longer float is a bit of
> >> luck. But things did work before d24cfee7f63d ("spi: Fix acpi deferred irq probe")
> >> so we need this to fix a regression
> > 
> > Yeah, fixing a regression is good thing, but not papering over the issue.
> 
> I agree in principle, but this is a quick and safe way to fix
> the regression, where as the generic fix you describe below is
> likely months away and also has significant risks of causing
> regressions in various places, see below.

Perhaps we should add a TODO / FIXME there as well?
So at least we will know that this is not a proper solution.

> >> and as you indicate it seems
> >> like a good idea in general and maybe we should also do this for i2c.
> > 
> >> As for doing something similar for I2C devices, that is an interesting
> >> question. Even though it is possible I'm not aware of any i2c-devices
> >> which have a userspace driver like SPI/USB fingerprint readers do,
> >> so on i2c I would expect probe() to always get called. So I'm not sure
> >> it is necessary there.
> > 
> > Reading the problem statement (the second paragraph) I lean towards
> > a generic solution residing somewhere in drivers/acpi/scan.c (like
> > acpi_init_device_object() / acpi_bus_attach() calls), although I don't
> > see a quick way how to achieve this. It seems would require a bit of
> > refactoring to allow ACPI glue code to call specific subsystem calls
> > or making a GPIOLIB to provide some "early" initialisation flow(s).
> 
> I guess that you want to do the direction and bias init on all
> GPIOs listed in _CRS, at least for devices with status == present ?

For the devices that are serial busses only (I²C, SPI, UART).

> I was wondering about the same thing, but ACPI tables are full
> of, well, erm, garbage in various places so I'm afraid that doing
> this for all GPIO _CRS resources is likely to cause a whole lot
> of pain.
> 
> Typically the firmware already sets up the direction + bias
> of all used pins. I'm pretty sure the BIOS-es have some GPIO
> init table especially for this somewhere.
> 
> Now those init-tables may have bugs, but I'm seriously worried
> about the implication of doing the direction + bios setup for
> all _CRS GPIO entries. I have simply seen too much non sense
> devices (with _STA returning 0x0f) listing GPIOs also actually
> used elsewhere to think this is a good idea.

Btw, other GPIO initialisation issues we have been solving by adding quirks.
Why this one can't be targeted with the same approach?

-- 
With Best Regards,
Andy Shevchenko



