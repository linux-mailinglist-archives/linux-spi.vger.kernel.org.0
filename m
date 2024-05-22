Return-Path: <linux-spi+bounces-2999-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3878CC332
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 16:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4FD1F239C9
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084811411F0;
	Wed, 22 May 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wun3A0k7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652021DA24;
	Wed, 22 May 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387886; cv=none; b=FjMBUtUekkkokB8Tm/6eAXJeSzwRhohDEl6XeHjH2/KAobuFfzkAQFsIKSHqadKta4kka25BHCy+u43c0WADqatMFo+NdrJ5MX9SGhHPP7A9rEiYhzis0QTtFnxjJibiMQxqtWSZ3vjc2O8BY7K76fg8UFrUcS8K1nmdbRX3xmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387886; c=relaxed/simple;
	bh=4HdH2WSoEjtzw3/IRy4XnCEk8ND6ji1NG2pzUyyvaoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5uVhq8EOb7PC6LCADy/YjHdcEX/tMRir4V32W04fdAfzk6MR3eImNVbWmZTZ7+WByfwV5A1k/VAsYU/nRdZv42Strdc2aTZPqksPnC6OKV2RtFFzrqs8+hZb/yCWA9CMNVd4D6wqSPi/d+44fb4KPiSIuysB0yZfd7QF18JL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wun3A0k7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716387885; x=1747923885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4HdH2WSoEjtzw3/IRy4XnCEk8ND6ji1NG2pzUyyvaoQ=;
  b=Wun3A0k7wAg2waf9Zqtb72k0BOUZiKtsjrvUNIbIFuNmE120t21S22cM
   77enfHJ2G5+WsJXFrGgGAmVThbswbiSKMwqu5A6NETZmQfNTaQ4Gm/WpK
   xNxkkcCygm5oFJ1bg/f35J0MWXAZa6zXccdF2sERk2San0wWSCEz5/0Kl
   0N8U+6eX2+dYCZOZcHXgaa4J5uTDBe83ZhWX9lVOo5E6MkjODeuWldC00
   Mf9dhKzDkYNRFhjJyVLQeTC3/gZ9X+8ThrVmBz1gkowz+J7rQa8djFeI8
   XjSsxd/Emgu8ZJlXBeZxMuqf1v+CAi7fqDKyAABe9dX6ZXrGiuifBKax1
   Q==;
X-CSE-ConnectionGUID: TsTEzY00TzKDhWuMvC4HbQ==
X-CSE-MsgGUID: tXsRRDRiTLeoqHRfwMfqNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="16474019"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="16474019"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 07:24:45 -0700
X-CSE-ConnectionGUID: PSqobMfWT6GCbF3w1EYD2Q==
X-CSE-MsgGUID: JZSFloj4TsyHc69eSFFnvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33886280"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 07:24:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9mtU-00000009zWu-3NL2;
	Wed, 22 May 2024 17:24:40 +0300
Date: Wed, 22 May 2024 17:24:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Message-ID: <Zk4AKOoymq5OvlkA@smile.fi.intel.com>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
 <8ae675b5-fcf9-4c9b-b06a-4462f70e1322@linaro.org>
 <Zk3X7Dgst5kVzJxy@smile.fi.intel.com>
 <5c32d7fd-4a7f-4d9c-805c-87d4d14f741e@linaro.org>
 <71e7b6f8-67f2-4c03-b83a-71d7e747ad04@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71e7b6f8-67f2-4c03-b83a-71d7e747ad04@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 22, 2024 at 03:18:18PM +0200, Neil Armstrong wrote:
> On 22/05/2024 13:53, Neil Armstrong wrote:
> > On 22/05/2024 13:33, Andy Shevchenko wrote:
> > > On Wed, May 22, 2024 at 12:03:33PM +0200, Neil Armstrong wrote:
> > > > On 15/05/2024 23:09, Nícolas F. R. A. Prado wrote:
> > > > > On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
> > > > > > Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
> > > > > > have checks for orig_nents against 0. No need to duplicate this.
> > > > > > All the same applies to other DMA mapping API calls.
> > > > > > 
> > > > > > Also note, there is no other user in the kernel that does this kind of
> > > > > > checks.
> > > > > > 
> > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > this commit caused a regression which I reported here:
> > > > > 
> > > > > https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> > > > > 
> > > > > along with some thoughts on the cause and a possible solution, though I'm not
> > > > > familiar with this code base at all and would really appreciate any feedback you
> > > > > may have.
> > > > 
> > > > I also see the same regression on the SM8550 and SM8650 platforms,
> > > > please CC linux-arm-msm@vger.kernel.org and me for a potential fix to test on those platforms.
> > > 
> > > There is still no answer from IOMMU patch author. Do you have the same trace
> > > due to IOMMU calls? Anyway, I guess it would be nice to see it.
> > 
> > Yes :
> > [    6.404623] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
> > <snip>
> > [    6.641597] lr : __dma_sync_sg_for_device+0x3c/0x40
> > <snip>
> > [    6.688286] Call trace:
> > [    6.688287]  iommu_dma_sync_sg_for_device+0x28/0x100
> > [    6.717582]  __dma_sync_sg_for_device+0x3c/0x40
> > [    6.717585]  spi_transfer_one_message+0x358/0x680
> > [    6.732229]  __spi_pump_transfer_message+0x188/0x494
> > [    6.732232]  __spi_sync+0x2a8/0x3c4
> > [    6.732234]  spi_sync+0x30/0x54
> > [    6.732236]  goodix_berlin_spi_write+0xf8/0x164 [goodix_berlin_spi]
> > [    6.739854]  _regmap_raw_write_impl+0x538/0x674
> > [    6.750053]  _regmap_raw_write+0xb4/0x144
> > [    6.750056]  regmap_raw_write+0x7c/0xc0
> > [    6.750058]  goodix_berlin_power_on+0xb0/0x1b0 [goodix_berlin_core]
> > [    6.765520]  goodix_berlin_probe+0xc0/0x660 [goodix_berlin_core]
> > [    6.765522]  goodix_berlin_spi_probe+0x12c/0x14c [goodix_berlin_spi]
> > [    6.772339]  spi_probe+0x84/0xe4
> > [    6.772342]  really_probe+0xbc/0x29c
> > [    6.784313]  __driver_probe_device+0x78/0x12c
> > [    6.784316]  driver_probe_device+0x3c/0x15c
> > [    6.784319]  __driver_attach+0x90/0x19c
> > [    6.784322]  bus_for_each_dev+0x7c/0xdc
> > [    6.794520]  driver_attach+0x24/0x30
> > [    6.794523]  bus_add_driver+0xe4/0x208
> > [    6.794526]  driver_register+0x5c/0x124
> > [    6.802586]  __spi_register_driver+0xa4/0xe4
> > [    6.802589]  goodix_berlin_spi_driver_init+0x20/0x1000 [goodix_berlin_spi]
> > [    6.802591]  do_one_initcall+0x80/0x1c8
> > [    6.902310]  do_init_module+0x60/0x218
> > [    6.921988]  load_module+0x1bcc/0x1d8c
> > [    6.925847]  init_module_from_file+0x88/0xcc
> > [    6.930238]  __arm64_sys_finit_module+0x1dc/0x2e4
> > [    6.935074]  invoke_syscall+0x48/0x114
> > [    6.938944]  el0_svc_common.constprop.0+0xc0/0xe0
> > [    6.943781]  do_el0_svc+0x1c/0x28
> > [    6.947195]  el0_svc+0x34/0xd8
> > [    6.950348]  el0t_64_sync_handler+0x120/0x12c
> > [    6.954833]  el0t_64_sync+0x190/0x194
> > [    6.958600] Code: 2a0203f5 2a0303f6 a90363f7 aa0003f7 (b9401c2
> > 
> > Reverting  8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents") removes the crash.
> > 
> > > 
> > > Meanwhile, I have three changes I posted in the replies to the initial report,
> > > can you combine them all and test? This will be a plan B (? or A, depending on
> > > the culprit).
> > > 
> > 
> > I'll try to apply them and test.
> 
> I stacked the 3 changes, and it works:
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

Thank you!

I will try to develop and submit a fix against IOMMU which I believe is the
correct place to address this. So, this one will be plan B in case the IOMMU
folks will refuse the other one.

-- 
With Best Regards,
Andy Shevchenko



