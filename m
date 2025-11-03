Return-Path: <linux-spi+bounces-10970-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35832C2AC3F
	for <lists+linux-spi@lfdr.de>; Mon, 03 Nov 2025 10:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F6084EDB79
	for <lists+linux-spi@lfdr.de>; Mon,  3 Nov 2025 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A752EB866;
	Mon,  3 Nov 2025 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldEVTPYP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7EE20DD52;
	Mon,  3 Nov 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162508; cv=none; b=REv4Sjn9pzj4vhqLWMxhY8C9t740oDYTi4zo0qKx1EElCKPVF6+cbER6nDUq7u9cg6/Oy5iKrPwGUo3tsq4ucw50cXMRazmsTwRrfvp2/0sYMLbK6O7ZD++QbBhE7Jmr04AwBJ/fP8+XhiU8CijaRUDKx4wg6J9D4TabmXFsUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162508; c=relaxed/simple;
	bh=3Lv1tnlhgCB9vdu0ZkwoOO7RrUhXDwV8Tgt8OB4u5O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrUan4FzzHw4/54hX1pcE1YXAhTMsBonpvCopVHPcZiVGr1+dshLbZJ1zjuRJvNLEBR0yUfK04sZQtD11xNnoPAnkus3RWvd4b26up2Bo8E6bNdYmwCqV2r9rlVVFO+Uk69bAy9dbej0y/0A3lTUumGISfWEIp65Fs/7wOVA2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldEVTPYP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762162506; x=1793698506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3Lv1tnlhgCB9vdu0ZkwoOO7RrUhXDwV8Tgt8OB4u5O8=;
  b=ldEVTPYPm1WqJxO35YPr+RVG36HNPT/R/zvgl0sZGBsgjW1sT1y26V7V
   Dc3g4gDPFRJ1n2ndAgsST113igkGqsIwRT6kfoCrkP7sVsB17ngjH59y5
   00XhVg2Ky2A949kIZfq+DY2ICFOFTBxooygqG73mexs5P9eQHeIXUJV3O
   302Oe0HD7t26LM1FhniIzLSBULaXVW/OHwonBK8RDqXCMpZVeH90Xwxrf
   ceLmGF4RX/7QPV5HMnXwgauWbCyC8jPV8UVQP7EZ4QiK27Sxa64pBk4w1
   JYDCk+tRrcy2OZOUw4JWqMlRwQwPzwDdJGi5ElA/f7vPPAO30nhKJZhWE
   w==;
X-CSE-ConnectionGUID: wCF1o2nyT9CKwPv4p86wMA==
X-CSE-MsgGUID: CTtz4o4wQdaXsuBmP1Gcjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="68094207"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="68094207"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:35:06 -0800
X-CSE-ConnectionGUID: 2H7ffXlOSieACmCDsTPuCg==
X-CSE-MsgGUID: n2UsL+lwTTS0ewMmE2T2XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="210352434"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:35:04 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFqxp-000000056kW-0lNh;
	Mon, 03 Nov 2025 11:35:01 +0200
Date: Mon, 3 Nov 2025 11:35:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: Try to get ACPI GPIO IRQ earlier
Message-ID: <aQh3RJQ95jTx7VYO@smile.fi.intel.com>
References: <20251102190921.30068-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251102190921.30068-1-hansg@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 02, 2025 at 08:09:21PM +0100, Hans de Goede wrote:
> Since commit d24cfee7f63d ("spi: Fix acpi deferred irq probe"), the
> acpi_dev_gpio_irq_get() call gets delayed till spi_probe() is called
> on the SPI device.
> 
> If there is no driver for the SPI device then the move to spi_probe()
> results in acpi_dev_gpio_irq_get() never getting called. This may
> cause problems by leaving the GPIO pin floating because this call is
> responsible for setting up the GPIO pin direction and/or bias according
> to the values from the ACPI tables.
> 
> Re-add the removed acpi_dev_gpio_irq_get() in acpi_register_spi_device()
> to ensure the GPIO pin is always correctly setup, while keeping the
> acpi_dev_gpio_irq_get() call added to spi_probe() to deal with
> -EPROBE_DEFER returns caused by the GPIO controller not having a driver
> yet.

Even before following the link to some papering over module via the link below
I wondered, if the I²C case should be covered as well. The
https://github.com/alexpevzner/hotfix-kvadra-touchpad refers to I²C enabled
touchpads.

> Link: https://bbs.archlinux.org/viewtopic.php?id=302348

...

I'm not against the SPI fix, but is it confirmed that it really fixes the issue?

-- 
With Best Regards,
Andy Shevchenko



