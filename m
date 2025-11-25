Return-Path: <linux-spi+bounces-11511-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE63C84668
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 11:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75063AAF27
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F4B2E7198;
	Tue, 25 Nov 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdWXRQrZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307942EDD41;
	Tue, 25 Nov 2025 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065649; cv=none; b=orWLGMUiOzmDFxUB9pI6o9PP1pDadp/kL38sdheKH5k9GhH9F0C9M0yVHjOtxjVRBpBGs+QMq0FIW06ALV2tYi1uZFa0cEm9GSwHR6BwX7M9L/V2D7V+jFaN8twqiSQogCAKCPVHwNm+0PFao8PM8QCmiUS1B83WP/WnSq7fAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065649; c=relaxed/simple;
	bh=+KH7Ypgy6kj3Q59t5+0vx6RYUePPMpPgWugFJSvdq6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwbU5Xd8ZV8nhBCaVLfQZ8VJhrwWwARIMZjcfb1maDtvuA3dscFhUToSdbI2R7teHRae0QsmTWAXW8/6n7PfH8gDIriaJmTxRDrfdBGY3ZTz/QO0S/k81+VomvJJj1VM35CphaEIC9opbmMBFdR+wHorWyvASbKRqH8WMfeTMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdWXRQrZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764065648; x=1795601648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+KH7Ypgy6kj3Q59t5+0vx6RYUePPMpPgWugFJSvdq6k=;
  b=AdWXRQrZyS36nYvyyt7pQEqBONDnQo3bAS89cad2DKTXYjdDSy2HkXM5
   sXLLJg2Fb63wu53l+hkPd5npMd4jYglZZ/QahHsTqwlttltQ9Mypc+kLf
   iwAsBrL0Z9WC/JhPZdBXo3FjIIcKbg8+bZhN0oot4KIhOIOC0NsVrojFK
   pmKwiMfR02SIdwjDM4xGMf74w2zPTMvTMQfBUfgPXRLydQ4NjGiA8zCJ3
   okqs6+8BM+lq1gBrBtmpTP6uzJwOEUdkh2D+oUl/RKNfquiti79YmyRF4
   UhNYsHN70ZfVIIYA8M3KrEmM+TlYKMGKyQzjS/2duIaDq5rFuLT4zbeAo
   Q==;
X-CSE-ConnectionGUID: uubsW+CATv+KSoLjA5a8XA==
X-CSE-MsgGUID: fa2isbe7Tz6EdoVK0N/QMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="91565056"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="91565056"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 02:14:07 -0800
X-CSE-ConnectionGUID: b+bhd7nARGGQ5v25jH4xQg==
X-CSE-MsgGUID: 0jzW2n0PQym93ChWozUx/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="191859408"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.152])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 02:14:03 -0800
Date: Tue, 25 Nov 2025 12:14:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: [PATCH v4 1/3] spi: airoha-snfi: en7523: workaround flash
 damaging if UART_TXD was short to GND
Message-ID: <aSWBacH8N5NWO8oV@smile.fi.intel.com>
References: <20251125021051.857159-1-mikhail.kshevetskiy@iopsys.eu>
 <20251125021051.857159-2-mikhail.kshevetskiy@iopsys.eu>
 <aSVYShXLirW--bYe@smile.fi.intel.com>
 <83a15a9d-8dfa-4949-b483-020bbcf0847a@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83a15a9d-8dfa-4949-b483-020bbcf0847a@iopsys.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 25, 2025 at 01:04:12PM +0300, Mikhail Kshevetskiy wrote:
> On 11/25/25 10:18, Andy Shevchenko wrote:
> > On Tue, Nov 25, 2025 at 05:10:49AM +0300, Mikhail Kshevetskiy wrote:
> >> Airoha EN7523 specific bug
> >> --------------------------
> >> We found that some serial console may pull TX line to GROUND during board
> >> boot time. Airoha uses TX line as one of it's BOOT pins.
> > I know the term bootstrap, what does BOOT mean?
> 
> yes, it's bootstrap pin

Then use that term.

> >> On the EN7523 SoC this may lead to booting in RESERVED boot mode.
> >>
> >> It was found that some flashes operates incorrectly in RESERVED mode.
> >> Micron and Skyhigh flashes are definitely affected by the issue,
> >> Winbond flashes are NOT affected.
> > NOT --> not
> will fix

> >> Details:
> >> --------
> >> DMA reading of odd pages on affected flashes operates incorrectly. Page
> >> reading offset (start of the page) on hardware level is replaced by 0x10.
> >> Thus results in incorrect data reading. As result OS loading becomes
> >> impossible.
> >>
> >> Usage of UBI make things even worse. On attaching, UBI will detects
> >> corruptions (because of wrong reading of odd pages) and will try to
> >> recover. For recovering UBI will erase and write 'damaged' blocks with
> >> a valid information. This will destroy all UBI data.
> >>
> >> Non-DMA reading is OK.
> >>
> >> This patch detects booting in reserved mode, turn off DMA and print big
> >> fat warning.

...

> >> -	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
> >> -	if (err)
> >> -		return err;
> >> +	if (dma_enable) {
> >> +		err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
> >> +		if (err)
> >> +			return err;
> >> +	}
> > Why do you need this to be conditional? The settings of DMA mask should not
> > affect the (in)ability of the device to perform DMA. I.o.w. it should not
> > influence PIO mode. Can you confirm this?
> >
> no any particular reason, just see no sense to set mask if dma will not
> be used

So, this is an unneeded churn in the patch. Device is [still] capable of DMA?
Yes. Set the mask. The DMA/PIO choice is done on the upper layer (as you do it
via ops).

-- 
With Best Regards,
Andy Shevchenko



