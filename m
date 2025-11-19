Return-Path: <linux-spi+bounces-11363-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4825C710C6
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 21:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1633528FE5
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 20:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114D32698AF;
	Wed, 19 Nov 2025 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FU/OW+5k"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04019346E7B;
	Wed, 19 Nov 2025 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763584718; cv=none; b=fZQA/S44fv9ZhXalmT2r0SKtHChgKlJlLrkzVlRFyg6/MPIO2qQkRNJ4gHio0fs4xExe1wpuNgNoZI86semZMQ0+QSJpoSWPL9d/YrfXWup7Y5E4zOWq1kZ5+kK4qqo6uW6xmvzs0/6RrJjgKjj2NtPB8z/RKdColYJhMpNlUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763584718; c=relaxed/simple;
	bh=tHJhQALu/zXr27/IbyzSbgqoGvyrzkqeV8m04hdGCww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1i7+w18JK7nu+ef1bEfgIP3ybYQKE65kvkx2xSXkCG2Yhc+I0CUCmU07kWVCe72Nn8RTTtARGPoYiIiJpilzXbRZl10b5v1fVTt9ekkPmK5A5JQ0yvizxZSzDbghCw1xGjXFINx7yeLaAlIEJ7LYZncgn7xnfcQ34d1BETGXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FU/OW+5k; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763584718; x=1795120718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tHJhQALu/zXr27/IbyzSbgqoGvyrzkqeV8m04hdGCww=;
  b=FU/OW+5kh4DYYkdQD9bzpyJCupaRpI1yWeYHktPS5zsSUiBclqn4p+q0
   iTYYRsNTPjlBdexPp/7EfaRBXFxochiIFDQu+SnezzVP2TFjkoOPuOrQi
   u0otoR/g/S55Y7Qi8Zmqq64fakPjAy6ZemtE9YtzryS4IiQdoEMwCs3LY
   wj5jVt5hF3zmOt1UiwB8SrzbpHy5M+wQpItfAFeOJBHVIr8toknwi/kOj
   +viLg/jGrt8mzxEwkdVIDuz8++dHiw4YH29XG91COjAF/pWCtd0DE0Xgr
   eu378SUyF72EV3rCCdYEHBNxddWLApOYhMhOBh4zbj1HDYMGf/FjKrrpG
   A==;
X-CSE-ConnectionGUID: WwpGAoLGQdqezUAd7NKuYQ==
X-CSE-MsgGUID: nfMg7+MKQmuDp1Nu+A9fpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572730"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="65572730"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 12:38:37 -0800
X-CSE-ConnectionGUID: CQa8OhioTmGC7vdZLXF66g==
X-CSE-MsgGUID: +iGDebK1QhagyK05xIjUrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="196114431"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 12:38:33 -0800
Date: Wed, 19 Nov 2025 22:38:30 +0200
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
Message-ID: <aR4qxiR7pzrPdaUz@smile.fi.intel.com>
References: <aR2o2R30TbVOcqZe@opensource.cirrus.com>
 <CAMRc=MciO0WYejOYZduqE73U4OVTxcaMfe6Sv1VXWJWL2FFNmw@mail.gmail.com>
 <aR29uKW7yLxws9jA@opensource.cirrus.com>
 <CAMRc=MdXNXQhE9zi=i0x0yGCi0fKQNU8_tn2_Uy24TAhxG7BRA@mail.gmail.com>
 <aR3FnUNO4DyCdiLD@opensource.cirrus.com>
 <CAMRc=MfuQSGPbt3x366j5c9Sg-mgu=TfmD6X25Dk5Rmu0JiiEw@mail.gmail.com>
 <CAHp75VdLfkcrmaGBPu_YLDReyX5Gvu9pE6BXweArA5PmM3MQnQ@mail.gmail.com>
 <CAMRc=Mf9djJ77ob8L1OKa6HHBx_JxR_sajWH1mFGz=V+hMDbmw@mail.gmail.com>
 <CAHp75Vf_+WzMn+pmwK4zhLEZtG3Uat4FrdFMCMtPmmX82E3Wzg@mail.gmail.com>
 <CAMRc=MdbgeJOMoHDm_z04ko1pdKed06GP4=M+VsPaD3YOEvs6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdbgeJOMoHDm_z04ko1pdKed06GP4=M+VsPaD3YOEvs6Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 03:30:46PM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 19, 2025 at 3:24 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > > > My idea was to mark the fwnode with __private and fix the (ab)users,
> > > > should not be so many. Can somebody mock up a coccinelle script to
> > > > find all dereferences of fwnode from struct device?
> > >
> > > I think you're underestimating the level of complexity. What about the
> > > concept of dev_fwnode()? It literally makes no sense if we switch to a
> > > list of fwnodes.
> >
> > Why not? It will return the pointer to the primary node. You can look
> > for example how the list of the DMA descriptors is done in
> > drivers/dma/dw/core.c. Not the best solution, but gives you an idea of
> > how it may look.
> 
> What even is a primary node though? You can have auxiliary devices
> without an ACPI or OF node.

The one which gives the main set of the properties for the device.
The devices that don't have it, simply have a list of fwnodes empty.

> Only with software nodes. Which one is the
> primary? The first one we add?

Yes. The problem here might be if we add the SW node before the actual FW node
appear (it can be if we created some devices before the actual FW based
enumeration happens. It would probably need to have some kind of weight
(or priority value) and list should be sorted based on that number.

> > > For it to make sense we'd have to have a kind of "dynamic" firmware
> > > node attached to a device which we'd fill with an aggregation of all
> > > properties from firmware nodes in the list.
> >
> > "Dynamic" is just a node in the list. The only potential problem here
> > is prioritisation. Should we add to the head, tail or insert? But
> > converting current approach will be straightforward.
> 
> What I have in my mind is not another firmware node in the list in
> struct device but rather a new firmware node implementation, that
> would be assigned to the device via a dedicated pointer and would be
> filled with a logical OR of properties from other firmware nodes added
> to the list.

Oh no, this won't work in corner cases. What if we actually need to "fix"
an existing primary node (there were discussions long time ago about inverting
primary/secondary in some corner cases, but it didn't appear so far as
it most likely will give tons of issues in the _current_ design)?

> Then dev_fwnode() would return this rather than any one
> of the firmware nodes from the list. Think of it as the "master
> fwnode" of a struct device.

fwnode should not be in any relations to the device, I mean when we do fwnodes,
we should not assume that it's backing the device. In the idea you shared it
won't be possible ("dedicated pointer") in mine it is (just a list of something
that may belong to the device, or to another object, doesn't matter).


-- 
With Best Regards,
Andy Shevchenko



