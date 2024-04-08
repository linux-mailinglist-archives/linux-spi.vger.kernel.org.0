Return-Path: <linux-spi+bounces-2229-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6D789CCAE
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 21:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9B1B23D4B
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A89414601D;
	Mon,  8 Apr 2024 19:50:35 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1314600C;
	Mon,  8 Apr 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605835; cv=none; b=CePdtIqHdpdfsDqawEghIToWQcPcOxQMkObguefCRX9x4VgaMk/gJpxzWbJ8Nb0s045IYzwQ1irOv3ln99A3rvNEfXRHJdTiUOml9NMKItNCdCl1PtJ4DNK4T2kMQJoolQRUo5wyicqcWd+bgU1D2VoQq3Wh/r1ZUmu5dSHWSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605835; c=relaxed/simple;
	bh=ac2T839zWN+RxjRCTp59U795i6BdOscEdkejc7akIDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEcRqkw2bBOBHCkK+lDZlvdEr7hZpJJVtG+B0Ld3Zn28KF3rGC8+Cq+wILnY94FQqN63Agwvdoxaot6H//6CtNOkTYpYK3j8xcfQMA7hDgHNFEXZE+yM2zP42he/ELvRQN9y0VZu3qXS3BqIgW0g9RsbV5z7+Xo7/iNqvDODuiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: W4quTSg/TuGjDB+lE83KsA==
X-CSE-MsgGUID: TePycSOTTOmuivYmnbJVtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11740472"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="11740472"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 12:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915375921"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915375921"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 12:50:31 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rtv0e-00000002dAp-3vpE;
	Mon, 08 Apr 2024 22:50:28 +0300
Date: Mon, 8 Apr 2024 22:50:28 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v3 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <ZhRKhIJKxUdQpZK0@smile.fi.intel.com>
References: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
 <20240329114730.360313-4-ckeepax@opensource.cirrus.com>
 <Zg3AaNM0eizfC6Bk@surfacebook.localdomain>
 <ZhQO0vTvr67bR2O9@ediswmail9.ad.cirrus.com>
 <CAHp75VdJQd4bcJ4qfMfJvNnNrE46SHmQQiVwyJa-99Y5k50nsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdJQd4bcJ4qfMfJvNnNrE46SHmQQiVwyJa-99Y5k50nsg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 08, 2024 at 07:07:55PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 8, 2024 at 6:35 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Wed, Apr 03, 2024 at 11:47:36PM +0300, Andy Shevchenko wrote:
> > > Fri, Mar 29, 2024 at 11:47:30AM +0000, Charles Keepax kirjoitti:

...

> > > > +#include <dt-bindings/gpio/gpio.h>
> > >
> > > Hmm... Is it requirement by gpiolib-swnode? (I haven't looked at the use cases,
> > > I'm not the author of this idea, hence the Q).
> >
> > It's required for the GPIO_ACTIVE_LOW used in the swnode stuff.
> 
> Seems to me like you are mistaken.
> https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib-swnode.c#L85

Okay, I stand corrected, under "native" the GPIO_* are assumed.

But what you need is to include gpio/property.h for that, and not directly
the DT header.

-- 
With Best Regards,
Andy Shevchenko



