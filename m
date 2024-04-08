Return-Path: <linux-spi+bounces-2230-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B7789CCD2
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 22:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0283C1F2591F
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 20:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F5F1465B5;
	Mon,  8 Apr 2024 20:07:50 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817814600B;
	Mon,  8 Apr 2024 20:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712606870; cv=none; b=Z/Byz9J8rkpYiro69bjwxO6Y6VGw/sq4QjJKyJx3DfzFTyAJDaM3WUe6x0HtV2owikV1Vzz3krfF5ulxl44H4zs7svRDC7krPti0N1R/6YOjySJzeOSy7CJtAaqV88Sn+WbBORUMCWbtTUw0RjfHwBZiZjvr7G+j302qYhrB8bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712606870; c=relaxed/simple;
	bh=2b2fxxz6958tQ6WE2NY2kztePGWBKYG5Mvn1PZRf2No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKRdn25D1zIcl+VIKCS1C873nKA2Ur0r3DplNcXfCe+G5+QfqAA7y2jJIqtYIl8zmw4nqal4OonsM6eK3r4+rJ8I+go2GzwbN22PPhpdtB+B09qBxuPyg8Ns+N5jP23Iei/STCioHofRRLoJ2EYOfkssHbzPd+ta026UjPujsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: A7094MpRT3akHmPx/wmwKQ==
X-CSE-MsgGUID: chDqP01SRrWsYnPMrxtNIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8030533"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8030533"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 13:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915376327"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915376327"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 13:07:46 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rtvHL-00000002dUU-3I7l;
	Mon, 08 Apr 2024 23:07:43 +0300
Date: Mon, 8 Apr 2024 23:07:43 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v3 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <ZhROj-ZfKp_CEcA6@smile.fi.intel.com>
References: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
 <20240329114730.360313-4-ckeepax@opensource.cirrus.com>
 <Zg3AaNM0eizfC6Bk@surfacebook.localdomain>
 <ZhQO0vTvr67bR2O9@ediswmail9.ad.cirrus.com>
 <CAHp75VdJQd4bcJ4qfMfJvNnNrE46SHmQQiVwyJa-99Y5k50nsg@mail.gmail.com>
 <ZhRKhIJKxUdQpZK0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhRKhIJKxUdQpZK0@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 08, 2024 at 10:50:28PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 08, 2024 at 07:07:55PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 8, 2024 at 6:35 PM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > On Wed, Apr 03, 2024 at 11:47:36PM +0300, Andy Shevchenko wrote:
> > > > Fri, Mar 29, 2024 at 11:47:30AM +0000, Charles Keepax kirjoitti:

...

> > > > > +#include <dt-bindings/gpio/gpio.h>
> > > >
> > > > Hmm... Is it requirement by gpiolib-swnode? (I haven't looked at the use cases,
> > > > I'm not the author of this idea, hence the Q).
> > >
> > > It's required for the GPIO_ACTIVE_LOW used in the swnode stuff.
> > 
> > Seems to me like you are mistaken.
> > https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib-swnode.c#L85
> 
> Okay, I stand corrected, under "native" the GPIO_* are assumed.
> 
> But what you need is to include gpio/property.h for that, and not directly
> the DT header.

Oh, my, we have two _almost_ identical definitions in machine.h and under DT.
So, I believe we are using ones from machine.h.

-- 
With Best Regards,
Andy Shevchenko



