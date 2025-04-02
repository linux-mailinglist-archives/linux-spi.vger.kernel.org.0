Return-Path: <linux-spi+bounces-7394-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C19AA79199
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 16:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803D71891A4F
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB0923AE8D;
	Wed,  2 Apr 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5j+Ew71"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB091E521;
	Wed,  2 Apr 2025 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743605971; cv=none; b=DfQnHoKUeY3tYOqZ8nGAC7gX7cqin9YBjzGsu3Khjl7OQj+GKFxTSFzVS7kdAeopEvhnJGwtvTfq2gLVoG5tR/rpnpEhmqGvHW/GFo3mF7tNkTnQ17gj+4WOGtAEkZf2/uaS8xqdHn3yj5grEPzRjhSF26rDKyVTH+YH9FOk8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743605971; c=relaxed/simple;
	bh=dlLqY1u1t6/c8205XqJOIrRCz/YhzQT9F0ssufJpEow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X48WgzAzJJoGtMJnMLi7ohKWM1Bx25dzthK0vCvw8yaKcWHv8hQkyW7Gm+STqah2Ffu3YKrILHN5gnwhDc6DZ1gAXZQCm/eMhzxJP0A+GtoCUrNQ0h150jRBsUDHGNwENMC8ubWlclhGri01Luq226floReZ6PxTmIQoNfN+NBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5j+Ew71; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743605970; x=1775141970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dlLqY1u1t6/c8205XqJOIrRCz/YhzQT9F0ssufJpEow=;
  b=T5j+Ew716casl2pfjn9n7XMxkniwD5/Zd+D3ZDLxvSTWTxesXBbo9GZk
   l6cs8AblYoVgmDeEGblqfmMz17/XfMcCUT5lCuCNkzdRvJJG7Rnyq2XLb
   Zc6deg3rdaxuxM+G3Wk6j3BRx8g7SGkS70+m0QSD2meAQC3NRL23XucH7
   jyoJl4wr7JhzQZXiyiSA6s0VTllsSFpUUO6G37GYnYmeA1EMUw94MLUZj
   KK0ZM7GOMCnDUtU2hlQ1uoY6IX1HYpOy5s0PCLhshys6CrNlj6wv6sUcg
   RMQWOBudgiH+nk1AgiDdMKvAot9EiQ7LVSz4FIErtd52zvXN1YwrkttB/
   A==;
X-CSE-ConnectionGUID: mkyhhZz4QtWPxYP8mAs7bw==
X-CSE-MsgGUID: LOOKeM1rT0qLEpxaGkIsVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44232459"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44232459"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 07:59:29 -0700
X-CSE-ConnectionGUID: UlGiov7MSou8TYTSDLOb1Q==
X-CSE-MsgGUID: AlQg4rPaTtq3pa3PjFbrBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="131848576"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 02 Apr 2025 07:59:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B3A6426D; Wed, 02 Apr 2025 17:59:25 +0300 (EEST)
Date: Wed, 2 Apr 2025 17:59:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] spi: bcm2835: Do not call gpiod_put() on invalid
 descriptor
Message-ID: <Z-1QzesPs7A3_FQY@black.fi.intel.com>
References: <20250401224238.2854256-1-florian.fainelli@broadcom.com>
 <CAMRc=Mefks5RMDkO-w-WT1279rKKyz8Up9UbuNdcF+WpsOxioA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mefks5RMDkO-w-WT1279rKKyz8Up9UbuNdcF+WpsOxioA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 02, 2025 at 01:36:28PM +0200, Bartosz Golaszewski wrote:
> On Wed, Apr 2, 2025 at 12:43 AM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
> >
> > If we are unable to lookup the chip-select GPIO, the error path will
> > call bcm2835_spi_cleanup() which unconditionally calls gpiod_put() on
> > the cs->gpio variable which we just determined was invalid.

...

> > -       gpiod_put(bs->cs_gpio);
> > +       if (!IS_ERR(bs->cs_gpio))
> > +               gpiod_put(bs->cs_gpio);

> We could also just set it to NULL on error in bcm2835_spi_setup() but
> I'm fine either way.

I think this patch papers over the real issue:
1) the cleanup call does everything and not split to have the exact reversed order of the setup;
2) the GPIO here as far as I understand is not optional and on errors may contain an error pointer
but gpiod_put() ignores that.

TL;DR: I think the proper fix is to make gpio_put() to accept an error pointer as NULL. I.o.w.
if (desc) --> if (!IS_ERR_OR_NULL(desc)) in all conditionals related to gpiod*put*() calls.

-- 
With Best Regards,
Andy Shevchenko



