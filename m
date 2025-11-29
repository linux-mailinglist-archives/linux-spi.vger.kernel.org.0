Return-Path: <linux-spi+bounces-11664-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6122AC93946
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 09:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0870B3A6EBC
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E222F77E;
	Sat, 29 Nov 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L36taNuR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132F79CF;
	Sat, 29 Nov 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764404346; cv=none; b=atj2HghySdLEYJT2DIH9qJJcx14gqsyqpG4g0eAC7Nn5CqbVs9t0Yp9EDLXeD6nVvRUMto0PGJohClsBSoYiouUMq+5MYU2o9rjNb2KeavU0w6esbnP2zqpMiIMOx0bCOWdDrbf3LozXaaiyMufZl+RPtaP/SYhbvEZg3+bPpt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764404346; c=relaxed/simple;
	bh=uv/kPw1McE5f3bmKv8GjbUJ6JEEDRK2Oh3WgY3zU8N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEgPU24PYQvgSEhqYcg8EhPueCo23x+Y1S3wAlwOYAlOCv3k4VjI/luziwUc03C00svS3Bt6C1GCZ7NYBMlxQCcla8cSXf8eOHL2NzgtjX/8irpowRlsGJrz/VnMy1v2ojbtu+5XtZvD0AvqguvEVCup9i2vcLIJaiDtJF7pe9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L36taNuR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764404345; x=1795940345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uv/kPw1McE5f3bmKv8GjbUJ6JEEDRK2Oh3WgY3zU8N4=;
  b=L36taNuR5XES5S1SE/6/ozL1tHGNf5IxpcBTLxXxFNvePm1vMfuolz1n
   /cSKydToIlUv71pCtEYGAp58Q34RiTf09W3KsUd1RissfsC/aImAMnq2+
   xKljiOu1CE74J9Tge4j3fceejv7eF7qgTPkWBbrT55PhVQwiMYKizBNjv
   BLpPiB12BnKgcluTrUBinkRinK/iNjgXqf66iQ9ADZI0aSp0MpI7ilGea
   hLlbt7+EKljBlxLVWQUbknVf+xS8Gxr3L6v4EiJK0zOhtxjvsbttMWZTP
   Nj6UnjosGiLBv3UVWm8Lu1MByV5hgjZJSZJja43PtK7VPd278vvGha3ug
   w==;
X-CSE-ConnectionGUID: 1vNykGU9S9y5YMRqrIi7tw==
X-CSE-MsgGUID: hmdD5Hi7TU+NDcqIbNPLRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="66363434"
X-IronPort-AV: E=Sophos;i="6.20,235,1758610800"; 
   d="scan'208";a="66363434"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 00:19:04 -0800
X-CSE-ConnectionGUID: 9RxSrQuLStm3f1UAKgRhiA==
X-CSE-MsgGUID: +A4ygBIHThqrqKIXgJ/5Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,235,1758610800"; 
   d="scan'208";a="224317636"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 00:19:02 -0800
Date: Sat, 29 Nov 2025 10:19:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] spi: microchip-core: use XOR instead of ANDNOT to
 simplify the logic
Message-ID: <aSqsdKpJ7CDd6jJn@smile.fi.intel.com>
References: <20251128185518.3989250-1-andriy.shevchenko@linux.intel.com>
 <20251128185518.3989250-3-andriy.shevchenko@linux.intel.com>
 <CAOiHx==y-4Jjckr-KnwdmJhi=TR9_wzcHvNo8GAeUmJ43Y_bHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx==y-4Jjckr-KnwdmJhi=TR9_wzcHvNo8GAeUmJ43Y_bHw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 28, 2025 at 08:30:43PM +0100, Jonas Gorski wrote:
> On Fri, Nov 28, 2025 at 7:56 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > -       if (spi->mode & SPI_MODE_X_MASK & ~spi->controller->mode_bits) {
> > +       if ((spi->mode ^ spi->controller->mode_bits) & SPI_MODE_X_MASK) {
> 
> This changes the behavior: if a bit isn't set in spi->mode that is set
> in mode_bits, it would have been previously accepted, now it's
> refused. E.g. controller has (SPI_CPOL | SPI_CPHA), device only
> SPI_CPOL. 0x1 & 0x3 & ~0x3 => 0, vs (0x1 ^ 0x3) & 0x3 => 0x2
> 
> If this is the actually intended behavior here, it is a fix and should
> carry a Fixes tag (the message below implies that).

Yeah, yesterday I was thinking about the same and I was confused by the logic
behind. As far as I understood the comments regarding mode provided by DT is
that the mode is configured in IP and may not be changed. And you are right
about the fix, but let's wait for Microchip to elaborate on the expected
behaviour.

> >                 dev_err(&spi->dev, "incompatible CPOL/CPHA, must match controller's Motorola mode\n");
> >                 return -EINVAL;
> >         }

Thanks for the review!

-- 
With Best Regards,
Andy Shevchenko



