Return-Path: <linux-spi+bounces-11695-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17039C98A18
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 18:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480A33A4164
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC55A335BAA;
	Mon,  1 Dec 2025 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJiQL0f6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB8723A994;
	Mon,  1 Dec 2025 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611852; cv=none; b=SAK8Dy34Mz5d5AnUVpXhjA+tZ7rvQ2qJPJIwLLRRsACWgxNxEkpln/KxbVvpT4Q3wq3JhLDmnYT0XOsgZspQrIkFJJJ/PSc+b+bFfOSLmV20G9ygqD/987+T68sLNk3aiXTRWjIPmeF1uxznSilG/2s1Umiu/tv3WRvy/4iMcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611852; c=relaxed/simple;
	bh=sJslQGVChVzN0t5UfgFc+2I5dfUMEnh+UNR2x47S21o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7etoegxkk4x/aGf/xvLgsSMmCJhWF72ZTpt+fSuk3oTgC6mkX5f5yZdYa8tZ5ndeKAKepEt0alDkhGZAFdZvBe+ky48IrB1vr7yRZovxcszRjItISXuwM7t18erJuYmBVN0t04Nyfu3QCdusn2OT2hk978g3zCT/JdIdr3pk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJiQL0f6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764611851; x=1796147851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sJslQGVChVzN0t5UfgFc+2I5dfUMEnh+UNR2x47S21o=;
  b=RJiQL0f6D97Oe0twFDkfnWTBlaz51da1jnYCIWhhVBOMy2faTvZDKJJy
   yvFIJnuYaj/FUY6XV0tNSiWGWlavAL84e1svjjkgeKWWyHA/30MMuS+ev
   UyhLtYl5yR111CvEgeFk+QVfey8yL27yu4kRckY+cFwceev2AJZWNcfjL
   bHOzSX8lx3J0Ku/9JR1RV+YScIESl/iav7GArNzROXjr3fwjEGvgNbvc/
   kkGIjfGXODJ8G/yV3wlTLN+uj9KE4gT6k3SuIOXqbGYRIQITAHPTbkRyw
   bG/71+V4Oc7ZXB2+PjJzusrF4jpttBV8/ugX6yrpmeM4FvEeWPBxYpqJQ
   A==;
X-CSE-ConnectionGUID: 2XPNFZtWQYeB8VyS1zGXag==
X-CSE-MsgGUID: DxMNax1lRqSK0Ygxaxln5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66593995"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="66593995"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 09:57:31 -0800
X-CSE-ConnectionGUID: ZyYQmwkJTva88znEJy3+zQ==
X-CSE-MsgGUID: mSjB4+A8Tn6KjY3rAlZQ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="194131810"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.4])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 09:57:28 -0800
Date: Mon, 1 Dec 2025 19:57:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] spi: microchip-core: use XOR instead of ANDNOT to
 simplify the logic
Message-ID: <aS3XBW7D0vVmUTio@smile.fi.intel.com>
References: <20251128185518.3989250-1-andriy.shevchenko@linux.intel.com>
 <20251128185518.3989250-3-andriy.shevchenko@linux.intel.com>
 <CAOiHx==y-4Jjckr-KnwdmJhi=TR9_wzcHvNo8GAeUmJ43Y_bHw@mail.gmail.com>
 <aSqsdKpJ7CDd6jJn@smile.fi.intel.com>
 <20251201-calamity-favoring-b2d1ec4bcc81@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251201-calamity-favoring-b2d1ec4bcc81@spud>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 01, 2025 at 04:08:57PM +0000, Conor Dooley wrote:
> On Sat, Nov 29, 2025 at 10:19:00AM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 28, 2025 at 08:30:43PM +0100, Jonas Gorski wrote:
> > > On Fri, Nov 28, 2025 at 7:56 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > -       if (spi->mode & SPI_MODE_X_MASK & ~spi->controller->mode_bits) {
> > > > +       if ((spi->mode ^ spi->controller->mode_bits) & SPI_MODE_X_MASK) {
> > > 
> > > This changes the behavior: if a bit isn't set in spi->mode that is set
> > > in mode_bits, it would have been previously accepted, now it's
> > > refused. E.g. controller has (SPI_CPOL | SPI_CPHA), device only
> > > SPI_CPOL. 0x1 & 0x3 & ~0x3 => 0, vs (0x1 ^ 0x3) & 0x3 => 0x2
> > > 
> > > If this is the actually intended behavior here, it is a fix and should
> > > carry a Fixes tag (the message below implies that).
> > 
> > Yeah, yesterday I was thinking about the same and I was confused by the logic
> > behind. As far as I understood the comments regarding mode provided by DT is
> > that the mode is configured in IP and may not be changed. And you are right
> > about the fix, but let's wait for Microchip to elaborate on the expected
> > behaviour.
> 
> Prajna is on holiday and I don't have a setup to actually test this on,
> but I'm 99% sure that you're both right and the original behaviour was
> wrong. There's a verilog parameter to the IP block that determines which
> motorola mode it is and a device that's not an exact match won't work.

Okay, let's not hurry up with this and wait for testing results.

> FWIW:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> > > >                 dev_err(&spi->dev, "incompatible CPOL/CPHA, must match controller's Motorola mode\n");
> > > >                 return -EINVAL;
> > > >         }

Thanks for the review!

-- 
With Best Regards,
Andy Shevchenko



