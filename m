Return-Path: <linux-spi+bounces-12227-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A3BD053A9
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 18:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBEE63019B42
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 17:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364063009E4;
	Thu,  8 Jan 2026 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FM89BuzR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983ED2FCBE1;
	Thu,  8 Jan 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894828; cv=none; b=KBSv6yShgt8+XAmIyExUyj44YZZ/+cNUjD84fnxetPQkqk85KVrgUunaRvcqOafT3AD8Fn6OkpxZxp/gcN3iedlZ8QTA7qfS8dF7CxGsgQJacgZsrxrbYyAiU5Hz9JQorIQg6FbCHKXANiRYYrs/s1qUnqls7G/1idT1ePBOr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894828; c=relaxed/simple;
	bh=b7fKBWK2cjLjFB0xnpPKs+gMwNToz+Aq4tCPnlq8VuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtCEAWaLqK1FZNSbw3og9HDuMYmqD27twY7t4T5kkSA1i7cZtsGPTl4vYWVc57xAQ7WPhCLarqYy9XxV5rHTNDLD3VGsa04P2ZsX7XPHCr1oV39GsVG4JZO8oKbxGlEsXonV8w4xHQPggQhaUzYGxJ2LnIQ3Z6trJzkE+QdcDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FM89BuzR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767894827; x=1799430827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=b7fKBWK2cjLjFB0xnpPKs+gMwNToz+Aq4tCPnlq8VuM=;
  b=FM89BuzRw3nzA1ZVWMZxD1zg90cI2MbKZ3Zd6wmfzDSP3BjzEzKYT8Qf
   zC/9dJHnTbjop2DXFRfj+wcuz4rd3lRFQDJNUirU8ZanIAP71BeDoawOS
   e0aBM05V612YueeLgL2yavztDQcbOxqILswT2WzHnZdsYdOvTpxluTQc7
   Q+pDl5ucOZJtHZOUEC3PfBxjigJ0I/oQKITgB6zV1D5PYyNrkNzSBSMBE
   vkGgPu/sxm3eu2iqq/tfrgD1bqJIR4bazYiMzdopuIitj7AQPcUMwGRxJ
   lVJPfzDJBBwBQA0DhYIKhs+tiQjQfPIMppA1B6npvG6f4Zk+x4wRnn3pe
   Q==;
X-CSE-ConnectionGUID: y66GW3ChTv+jIsqoba0Y5w==
X-CSE-MsgGUID: 9XfzyIjHS+ygfC7GPhDLOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69352140"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69352140"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 09:53:46 -0800
X-CSE-ConnectionGUID: vLebn7QPTt6SKT1C3nVeNA==
X-CSE-MsgGUID: 0osMjNCbSJSZnqzQU7HBvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207400613"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 09:53:44 -0800
Date: Thu, 8 Jan 2026 19:53:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Jonas Gorski <jonas.gorski@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] spi: microchip-core: use XOR instead of ANDNOT to
 simplify the logic
Message-ID: <aV_vJRg0CoMHaCGb@smile.fi.intel.com>
References: <20251128185518.3989250-1-andriy.shevchenko@linux.intel.com>
 <20251128185518.3989250-3-andriy.shevchenko@linux.intel.com>
 <CAOiHx==y-4Jjckr-KnwdmJhi=TR9_wzcHvNo8GAeUmJ43Y_bHw@mail.gmail.com>
 <aSqsdKpJ7CDd6jJn@smile.fi.intel.com>
 <20251201-calamity-favoring-b2d1ec4bcc81@spud>
 <aS3XBW7D0vVmUTio@smile.fi.intel.com>
 <12446fa2-570b-4882-80dc-c72a166aaf19@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12446fa2-570b-4882-80dc-c72a166aaf19@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 08, 2026 at 01:00:39PM +0000, Prajna Rajendra Kumar wrote:
> On 01/12/2025 17:57, Andy Shevchenko wrote:
> > On Mon, Dec 01, 2025 at 04:08:57PM +0000, Conor Dooley wrote:
> > > On Sat, Nov 29, 2025 at 10:19:00AM +0200, Andy Shevchenko wrote:
> > > > On Fri, Nov 28, 2025 at 08:30:43PM +0100, Jonas Gorski wrote:
> > > > > On Fri, Nov 28, 2025 at 7:56 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > > > -       if (spi->mode & SPI_MODE_X_MASK & ~spi->controller->mode_bits) {
> > > > > > +       if ((spi->mode ^ spi->controller->mode_bits) & SPI_MODE_X_MASK) {
> > > > > This changes the behavior: if a bit isn't set in spi->mode that is set
> > > > > in mode_bits, it would have been previously accepted, now it's
> > > > > refused. E.g. controller has (SPI_CPOL | SPI_CPHA), device only
> > > > > SPI_CPOL. 0x1 & 0x3 & ~0x3 => 0, vs (0x1 ^ 0x3) & 0x3 => 0x2
> > > > > 
> > > > > If this is the actually intended behavior here, it is a fix and should
> > > > > carry a Fixes tag (the message below implies that).
> > > > Yeah, yesterday I was thinking about the same and I was confused by the logic
> > > > behind. As far as I understood the comments regarding mode provided by DT is
> > > > that the mode is configured in IP and may not be changed. And you are right
> > > > about the fix, but let's wait for Microchip to elaborate on the expected
> > > > behaviour.
> > > Prajna is on holiday and I don't have a setup to actually test this on,
> > > but I'm 99% sure that you're both right and the original behaviour was
> > > wrong. There's a verilog parameter to the IP block that determines which
> > > motorola mode it is and a device that's not an exact match won't work.
> > Okay, let's not hurry up with this and wait for testing results.
> > 
> > > FWIW:
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > >                  dev_err(&spi->dev, "incompatible CPOL/CPHA, must match controller's Motorola mode\n");
> > > > > >                  return -EINVAL;
> > > > > >          }
> > Thanks for the review!
> 
> I've tested this on my setup and XOR check matches how the controller
> behaves. The SPI mode is fixed in hardware, so the previous logic was
> wrong.
> 
> Tested-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>

Thank you! I just sent a new version of this patch with updated tags and commit
message.

-- 
With Best Regards,
Andy Shevchenko



