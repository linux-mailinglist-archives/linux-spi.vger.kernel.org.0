Return-Path: <linux-spi+bounces-11384-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BFAC73555
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D6994EB45A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A009930FC3A;
	Thu, 20 Nov 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gi6S6BYi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811D2DE711;
	Thu, 20 Nov 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632578; cv=none; b=QsgTZpmTszHlji0zpFDaMFZSGx6CXgQzZ8a3G85XpAhPuxigoqur8K5JU+BtqFmIpeX83b9dyiiJ7S9cuCqKBg0nRFUr+35XC9x6jY/ApsNZcxVNhG9cK6E0UIc4zmUoc24f5cyGg5Sx+QLlpaQGbgzfhqM8wKYgQrfZKFqGbDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632578; c=relaxed/simple;
	bh=VazEnpPnFoBoJ8p0AoOtS3RJnfpeCdqi/y7vL1cQD1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBg3XGyEKxIlgJTaULqLf9kpkeGPAahVD3XzXo4538LDAFV+M927n+g2Z/Mbfd7o1xnyEpYXtQhlYUelpE74CBpNk8gQvIMuKPuRQKb/ZLZWYDcnFagKj7mp0UvtULA5pSWoT5BwBBFcdWPWS36fKWTlm7nzBiFV9+pXUG3eX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gi6S6BYi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763632576; x=1795168576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VazEnpPnFoBoJ8p0AoOtS3RJnfpeCdqi/y7vL1cQD1U=;
  b=Gi6S6BYizVKEteiTcmwYdOr1TWBxQLk4ozeAtZd7HKDbiSR4yzsccngA
   cn3LJTwWqJwPXrHfefdXUM4WUCnLXstfMU18mzhENNOJVqa18Tx6DzMvd
   rV4IuCK9OzxJ3tLTFJKiRLHwHFnJ3Auxzu+WNU0AQk9QYcx0T/bY8jCRw
   +6tYmef11TgcKep+9EZnXt3F3aL2M/eMWBHc9y4oOxtxCclFlQ0HvR8U+
   GkTd2HzyTWWKXsHV79+rDEBZTEiozH5cZdCDbj+QydRsg9A23+xNqBpks
   XYiJUVD3tDXnJRilitEsrKQqHkcMkOpTaD/6xmmZSM41kyO5kSr1YIW8j
   Q==;
X-CSE-ConnectionGUID: ueZfWjwcQHSS2nyXwH40dw==
X-CSE-MsgGUID: DLtRhP0hRC68cH1HkeU4Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="69312779"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="69312779"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 01:56:15 -0800
X-CSE-ConnectionGUID: xPUjTznQTeOva00wp59Y2g==
X-CSE-MsgGUID: XTvmEvyDTMWr//+SQ6oljA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191753407"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.97])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 01:56:12 -0800
Date: Thu, 20 Nov 2025 11:56:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
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
Message-ID: <aR7luqqew3LRwFgn@smile.fi.intel.com>
References: <aR29uKW7yLxws9jA@opensource.cirrus.com>
 <CAMRc=MdXNXQhE9zi=i0x0yGCi0fKQNU8_tn2_Uy24TAhxG7BRA@mail.gmail.com>
 <aR3FnUNO4DyCdiLD@opensource.cirrus.com>
 <CAMRc=MfuQSGPbt3x366j5c9Sg-mgu=TfmD6X25Dk5Rmu0JiiEw@mail.gmail.com>
 <CAHp75VdLfkcrmaGBPu_YLDReyX5Gvu9pE6BXweArA5PmM3MQnQ@mail.gmail.com>
 <CAMRc=Mf9djJ77ob8L1OKa6HHBx_JxR_sajWH1mFGz=V+hMDbmw@mail.gmail.com>
 <CAHp75Vf_+WzMn+pmwK4zhLEZtG3Uat4FrdFMCMtPmmX82E3Wzg@mail.gmail.com>
 <CAMRc=MdbgeJOMoHDm_z04ko1pdKed06GP4=M+VsPaD3YOEvs6Q@mail.gmail.com>
 <aR4qxiR7pzrPdaUz@smile.fi.intel.com>
 <CAMRc=Me-DXN9kx+5bqDb9doMG9MX2EiRJiC=_QqDc0q3gOz8wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me-DXN9kx+5bqDb9doMG9MX2EiRJiC=_QqDc0q3gOz8wA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 20, 2025 at 10:12:39AM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 19, 2025 at 9:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Nov 19, 2025 at 03:30:46PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Nov 19, 2025 at 3:24 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:

...

> > > > > > My idea was to mark the fwnode with __private and fix the (ab)users,
> > > > > > should not be so many. Can somebody mock up a coccinelle script to
> > > > > > find all dereferences of fwnode from struct device?
> > > > >
> > > > > I think you're underestimating the level of complexity. What about the
> > > > > concept of dev_fwnode()? It literally makes no sense if we switch to a
> > > > > list of fwnodes.
> > > >
> > > > Why not? It will return the pointer to the primary node. You can look
> > > > for example how the list of the DMA descriptors is done in
> > > > drivers/dma/dw/core.c. Not the best solution, but gives you an idea of
> > > > how it may look.
> > >
> > > What even is a primary node though? You can have auxiliary devices
> > > without an ACPI or OF node.
> >
> > The one which gives the main set of the properties for the device.
> > The devices that don't have it, simply have a list of fwnodes empty.
> 
> Well, what *is* the *main* set of properties? Who declares that? I
> agree, it's easy for device-tree - the OF node is the main one, but
> then what if a sub-device inherits the OF node of the parent while we
> also add a software node? It's not that straightforward and we'll run
> into issues for sure just like what we're seeing now with secondary
> fwnodes.

First rule is that swnode NEVER is the "main" property provider.
But it could be a single property provider.
The rest becomes easier after this.

> > > Only with software nodes. Which one is the
> > > primary? The first one we add?
> >
> > Yes. The problem here might be if we add the SW node before the actual FW node
> > appear (it can be if we created some devices before the actual FW based
> > enumeration happens. It would probably need to have some kind of weight
> > (or priority value) and list should be sorted based on that number.
> 
> Ugh, please no. Firmware node priority?? With magic numbers?

Why not? Many tools and things rely on weights.
But again, first problem first, the design. The additional property bundles
(as swnodes or OF overlays on ACPI-based systems) can come later on.

> > > > > For it to make sense we'd have to have a kind of "dynamic" firmware
> > > > > node attached to a device which we'd fill with an aggregation of all
> > > > > properties from firmware nodes in the list.
> > > >
> > > > "Dynamic" is just a node in the list. The only potential problem here
> > > > is prioritisation. Should we add to the head, tail or insert? But
> > > > converting current approach will be straightforward.
> > >
> > > What I have in my mind is not another firmware node in the list in
> > > struct device but rather a new firmware node implementation, that
> > > would be assigned to the device via a dedicated pointer and would be
> > > filled with a logical OR of properties from other firmware nodes added
> > > to the list.
> >
> > Oh no, this won't work in corner cases. What if we actually need to "fix"
> > an existing primary node (there were discussions long time ago about inverting
> > primary/secondary in some corner cases, but it didn't appear so far as
> > it most likely will give tons of issues in the _current_ design)?
> 
> What do you mean by "fix"? Like repair? Or fix in place? I'm not following.

When the primary already has a property that needs to be rewritten
(same name, different value). Note, that there are use cases already
for this AFAIR, but probably they were worked around in not too hackish
way or abandoned for now.

> > > Then dev_fwnode() would return this rather than any one
> > > of the firmware nodes from the list. Think of it as the "master
> > > fwnode" of a struct device.
> >
> > fwnode should not be in any relations to the device, I mean when we do fwnodes,
> > we should not assume that it's backing the device. In the idea you shared it
> > won't be possible ("dedicated pointer") in mine it is (just a list of something
> > that may belong to the device, or to another object, doesn't matter).
> 
> That's not true, we expect fwnodes to back real devices all the time.

No. Even OF doesn't do that. OF node can be a separate thing without struct
device being associated with it.

> Look at all the find_device_by_fwnode() functions we have everywhere.

What do you mean, please?

$ git grep -n -w find_device_by_fwnode | wc -l
0

Even if you refer to *_find_device_by_fwnode(), still it's not everywhere,
just in a dozen of modules.

> The crux of the problem Charles identified is the fact that the
> secondary fwnode is a field of struct fwnode_handle and not of a
> struct device. This really doesn't make sense as we see where multiple
> devices use a single "real" fwnode but want to have different
> secondary software nodes.
> 
> Moving the secondary fwnode to struct device would already help a lot
> but if we're doing that then we may as well switch to a list of
> fwnodes.

They all should be an independent entity that can be part of the struct device
but it's not obligatory relation ship.

Again, device may have a backing fwnode, while fwnode might not have a struct
device consumer.

-- 
With Best Regards,
Andy Shevchenko



