Return-Path: <linux-spi+bounces-11310-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C5C6E57E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 12:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A3C74E3586
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 11:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852B3570DF;
	Wed, 19 Nov 2025 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azz/vqov"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164393570A0;
	Wed, 19 Nov 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763553206; cv=none; b=suIfTRbRX8HqcvM2RSpsuUlqyBfGjAkckVmn6Krwagu0He7/S12KMkgBiRHsiPPihRqjcM++QSFOC45vNTE+rjDFFAXpTk/Cd8ccG+P4n1i6ABYkJsEOTdG4zjSdLyFFopScrPj1cbjwtqYTD0Bhdhhe0DNSAbLjmpZOf010Po8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763553206; c=relaxed/simple;
	bh=Z4g5UcYWx3k7JZLI0Dlqs8uvjOb68fHCr2W0YYeOHFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HerLC+MvqY1gI4x9+M4c7aXMNiVGcmT6hDYIpm+ww5k5vK6pWZPLgA0XMc8u0jJzU/G87it3cQrGm2/K79GiEnYVTAm6YtPUGhA0KLvWifYRi4MkRolqp2U+H40oLzlEEIJO18f9VueczsBgbP8SRpxeQ5n0cV4qiic9r2yyKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azz/vqov; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763553204; x=1795089204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Z4g5UcYWx3k7JZLI0Dlqs8uvjOb68fHCr2W0YYeOHFw=;
  b=azz/vqovxTmbGFdxailtMJlAsYjfascJyrZRY9P6Bd5Li0X5oCdxeJw2
   kQ7fUlKxcsi4wny5ccsWTTCFf0IPpkjGaWZrsv1J610l1oPo1XKDu5xGg
   ID4XiIEH7+mofGbJWByGO4Wrnpsc5IACq+kcQuYODgqmE576fRIwR54cj
   Rt9tJc8daGROvC5VNlhKy59V9ZOF9FMYpiBnJvkstCj8fSq2daNIa7ke0
   5qvhEkd0A2g2B3akx2AbSXWLcND32UI9Iu7E/u16uMpOn1F4WrPlKdavu
   ldSrXPaXLmZ51LQ5R/f1FuqFgA8N65Cqi5SvO60r8C9oKhSYUqLsjHxzf
   Q==;
X-CSE-ConnectionGUID: KTctkaHsREiJcKCJUQbkAA==
X-CSE-MsgGUID: 1M6nTT0bTO6z35FZqQnSCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65523965"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65523965"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 03:53:23 -0800
X-CSE-ConnectionGUID: ntOARxDhRguA4v4ECDOL5g==
X-CSE-MsgGUID: ml0EIgA2Tb+oZ3nuMMUDWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="191289861"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 03:53:20 -0800
Date: Wed, 19 Nov 2025 13:53:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
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
Message-ID: <aR2vrdBwF_oJ9H7k@smile.fi.intel.com>
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
 <aR2OU4se7lxcMtGW@opensource.cirrus.com>
 <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
 <aR2Uo++k1NKkk2sj@opensource.cirrus.com>
 <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
 <aR2gVzKhfN38MHAR@opensource.cirrus.com>
 <CAMRc=Mck8MiAm_nxY_L6Zw4cH-vYf24zSkPp=bhnUw68Q6FV=g@mail.gmail.com>
 <aR2i6lNNWEbQk0fx@smile.fi.intel.com>
 <CAMRc=MdYcdrQSDWKDHrx4-Y4-y92AQqr73MoRC3ws-X==SL0MA@mail.gmail.com>
 <aR2o2R30TbVOcqZe@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aR2o2R30TbVOcqZe@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 11:24:09AM +0000, Charles Keepax wrote:
> On Wed, Nov 19, 2025 at 12:06:57PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 19, 2025 at 11:58 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Nov 19, 2025 at 11:50:09AM +0100, Bartosz Golaszewski wrote:
> > > > On Wed, Nov 19, 2025 at 11:47 AM Charles Keepax
> > > > <ckeepax@opensource.cirrus.com> wrote:
> > > > > On Wed, Nov 19, 2025 at 11:38:35AM +0100, Bartosz Golaszewski wrote:

...

> > > > > Cool, thanks for all your help here. Might take me a couple hours
> > > > > but I will get to the bottom of the EBUSY thing, and report back.
> > > >
> > > > Sure. Could you just post the stack trace down to where the EBUSY is
> > > > returned in drivers/base/swnode.c? I'd like to analyze the logic
> > > > myself too if that's not too much work for you.
> > >
> > > FWIW, there is also an interesting debug technique. Put in your driver where
> > > you get this error code something like this (after all #include directives):
> > >
> > > #undef EBUSY
> > > #define EBUSY __LINE__
> > >
> > > And then you get some error code which is line number in some C file. You can
> > > narrow down grepping of the EBUSY in the suspected files and get the one.
> > >
> > >         git grep -n -w EBUSY -- ...files of interest...
> > >
> > > Hope this saves some minutes for you.
> > 
> > Charles confirmed he gets it from device_add_software_node(). I want
> > to know how we're getting there and how we could end up already having
> > a software node.
> 
> Ok I think I see what is happening now, the swnode is created on
> the first cell (the pinctrl). Then it moves onto the second cell,
> but mfd_acpi_add_device() copies the firmware node into both
> devices, the device_set_node() call at the bottom. So it inherits
> the swnode node through that primary fwnode.

Okay, you got into fundamental problem of fwnode design it seems.

(below is the summary related to that, but it may be not related here)

If it's the case, there is no easy solution for it right now.

And going ahead, please, don't even try hacks like recreating a copy
of needed properties from the parent fwnode to get an independent child
fwnode.

The proper solution OTOH should be decoupling fwnode from struct device
and making there a list of fwnodes.

	struct fwnode_handle {
		struct list_head node;
		...
	}

	struct device {
		// asumming dropped of_node and fw_node
		struct list_head nodes;
	}

This will require at first to make sure no code dereferencing fwnode
(and of_node) from struct device. With that enormous task done, the
rest is much easier to achieve as it will be just API's internals
refactoring.

With that done, we may stitch as many fwnodes as we want where the order in
the list will define match priority.

> I am guessing this code has perhaps been more heavily tested on
> device tree where it is more common to have nodes for each cell,
> whereas ACPI is far more likely to have a single firmware node for
> the whole device.

-- 
With Best Regards,
Andy Shevchenko



