Return-Path: <linux-spi+bounces-11305-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF362C6E1CC
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 12:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B30C34E5D2D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A539A34D939;
	Wed, 19 Nov 2025 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLHHOag6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B33594F;
	Wed, 19 Nov 2025 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549939; cv=none; b=dQklsxm1ZytilJBKwiJssrWCI5QUUDFMYDP3UrfSaQj5e9j8Mc04EWgUCAv30slTtZfRDPAH9/8ahwcuf+zFRKiBNSfhMXpC9ockrzuqWMzO4UxFE3Ui7XvKWfGjfpTh2KO32guDMHZDYUOXRBxVK8L03vPHA6E5Wv0WtzVhkc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549939; c=relaxed/simple;
	bh=p4YNMiZ5Bzksv1/IRwwAGN6YmgXf/pbINPKbaHtlXjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMX233YIKl1cHL4u7NI+WusW7TTYtK2qTR7xkpot5yOtqjJafUt1rMRCxyPuvFy36DVL8klzKejfqnEJXT6bSU2/jH/xPVOiwGAz40yEzUxbcokv1XoRhwCDKxpAMaWWJo4NbOhs8wHpP8VGlV1wyrHLFkj/LD1k/3IkrfgBqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLHHOag6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763549938; x=1795085938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=p4YNMiZ5Bzksv1/IRwwAGN6YmgXf/pbINPKbaHtlXjI=;
  b=gLHHOag6FMTZbpcbCxor4vQ4GCN7W4WdV7TDGPFmbuxE42bQ0yDctDxu
   g9GFmbnrALlDg609xAXpbAlo03jURem4NDR85+VlOLHctJfX8m33Zxe8Y
   qZARbDFiSXKg9/5KLFSvv1yIuWW6qCmOKGresDhUlVMWlwPvYRHrrulpB
   gO+6uIzDepoGTJZlVY0uSNJel2hemTpNAkDs8aphsIWKNnrVHe5gJQdrq
   VIlZURdKhfWb5Lq2fWQzA2MGfPS8YLW8kWCYd8IbUT1IijV2eER6DB3oi
   /FAXSR64mLYyt56Ugfy7+tm5jTLPscqtJh3wOFCRLE2t7AJiAzDjBg3D2
   A==;
X-CSE-ConnectionGUID: bhL34rDeQxaNSE3J+hs6SQ==
X-CSE-MsgGUID: blvW+bivR8mCLr+nHCs+Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65626812"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65626812"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 02:58:57 -0800
X-CSE-ConnectionGUID: rQZ8VtU8SheHV+GTFj7YZQ==
X-CSE-MsgGUID: CdngFKeiSQ6Y3o68+6i2ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190294336"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 02:58:54 -0800
Date: Wed, 19 Nov 2025 12:58:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software
 nodes
Message-ID: <aR2i6lNNWEbQk0fx@smile.fi.intel.com>
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
 <aR2OU4se7lxcMtGW@opensource.cirrus.com>
 <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
 <aR2Uo++k1NKkk2sj@opensource.cirrus.com>
 <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
 <aR2gVzKhfN38MHAR@opensource.cirrus.com>
 <CAMRc=Mck8MiAm_nxY_L6Zw4cH-vYf24zSkPp=bhnUw68Q6FV=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mck8MiAm_nxY_L6Zw4cH-vYf24zSkPp=bhnUw68Q6FV=g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 11:50:09AM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 19, 2025 at 11:47 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Wed, Nov 19, 2025 at 11:38:35AM +0100, Bartosz Golaszewski wrote:

...

> > Cool, thanks for all your help here. Might take me a couple hours
> > but I will get to the bottom of the EBUSY thing, and report back.
> 
> Sure. Could you just post the stack trace down to where the EBUSY is
> returned in drivers/base/swnode.c? I'd like to analyze the logic
> myself too if that's not too much work for you.


FWIW, there is also an interesting debug technique. Put in your driver where
you get this error code something like this (after all #include directives):

#undef EBUSY
#define EBUSY __LINE__

And then you get some error code which is line number in some C file. You can
narrow down grepping of the EBUSY in the suspected files and get the one.

	git grep -n -w EBUSY -- ...files of interest...

Hope this saves some minutes for you.

-- 
With Best Regards,
Andy Shevchenko



