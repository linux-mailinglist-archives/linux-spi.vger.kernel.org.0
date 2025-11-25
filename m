Return-Path: <linux-spi+bounces-11528-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4360C86AF3
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 19:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789DC3B4282
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 18:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BF03328EA;
	Tue, 25 Nov 2025 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8GrVZGc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FAE2D73B8;
	Tue, 25 Nov 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764096127; cv=none; b=fGD8bGmFGfPmW5pIhUkPl6X0AJC6GqY0BspU22sc4xpDFXGdjc3+LxN4mzXlOZH2h64XkLPtmE1bQSafxXIdAkDW+ZeDjep4QQdL/sVoIsCTYo/mZrzHpMlG4g2uhyTRy/aXQlYmChJIrm+ixgZ46aw9Xw3+2CM9ukXF4Ze1HIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764096127; c=relaxed/simple;
	bh=mEHY9GgoiSqhxR/W0E8OtjxK4nwc0SEgrPhZ5czKwe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g15hBacgivW9a3WnOwPmUoDZeQWC2K8w/ldjzrHc5GwCLQ0logY7vxVcCL7rlkizHqxom4J46K34gP3Llk40y8uWLl66LysTYd6adshb4Gi7Qe5vQmwjwgZ7P8MBUGsoWg2LUVrzntfKbrqsvATeP0QEu07jQRYOWMSRHF1MjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8GrVZGc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764096126; x=1795632126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mEHY9GgoiSqhxR/W0E8OtjxK4nwc0SEgrPhZ5czKwe8=;
  b=U8GrVZGc9vFDv/wGYb+no03OEtNeREQbCQI1bk3J53bDjgrcLxlRFWXz
   P1T0bP6hzWhNhbjRJBz3lQ3JV5ATUsDp513LTtS+9VX1wyvFOzm/OIAUs
   9o3tf5ZIhxqnwYenqK/cie45qrr8qbF94+Pc1bh3HR5FC6nRQtIWUw7Sc
   jS/D9Frc4kb2abN/u72v27G4+bQrlKBm93z0hZjOn5XpOzSBCiOYjJo0M
   7St8CRkfWSbRk1FZXDcMgITLL5nq6kvuFS5bIAsEz88wvmyhdn9bbWuD3
   /oL5Ln6JWCKqzXEIdMIA0zS2qewi8fzBLRBZgeTPFlLjPiv1r6dAxz4Tx
   w==;
X-CSE-ConnectionGUID: mFwblke0Qm+wnyVaPhJZaA==
X-CSE-MsgGUID: Ddpz5JIJQtObqUpiPyzeiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="65833578"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="65833578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 10:42:03 -0800
X-CSE-ConnectionGUID: k0Wtz+P3Spe8Tm0zUe2zGQ==
X-CSE-MsgGUID: 7DGzM9uHRSWs90aCUXQEHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="192719812"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.22])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 10:41:59 -0800
Date: Tue, 25 Nov 2025 20:41:57 +0200
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
Message-ID: <aSX4dXXmlHcz0zeU@smile.fi.intel.com>
References: <20251125021051.857159-1-mikhail.kshevetskiy@iopsys.eu>
 <20251125021051.857159-2-mikhail.kshevetskiy@iopsys.eu>
 <aSVYShXLirW--bYe@smile.fi.intel.com>
 <83a15a9d-8dfa-4949-b483-020bbcf0847a@iopsys.eu>
 <aSWBacH8N5NWO8oV@smile.fi.intel.com>
 <13321124-6b45-479c-a73d-1d9ec9e96f05@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13321124-6b45-479c-a73d-1d9ec9e96f05@iopsys.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 25, 2025 at 05:20:44PM +0300, Mikhail Kshevetskiy wrote:
> On 11/25/25 13:14, Andy Shevchenko wrote:
> > On Tue, Nov 25, 2025 at 01:04:12PM +0300, Mikhail Kshevetskiy wrote:
> >> On 11/25/25 10:18, Andy Shevchenko wrote:
> >>> On Tue, Nov 25, 2025 at 05:10:49AM +0300, Mikhail Kshevetskiy wrote:

...

> could you clarify what's wrong here?
> 
> >>>> -	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
> >>>> -	if (err)
> >>>> -		return err;

Sure, just don't touch these lines. Only set the respective ops depending
on dma_enable.

With that done the patch will look better and less confusing about affection of
DMA mask setting on DMA operations (which are kinda orthogonal).

> >>>> +	if (dma_enable) {
> >>>> +		err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
> >>>> +		if (err)
> >>>> +			return err;
> >>>> +	}
> >>> Why do you need this to be conditional? The settings of DMA mask should not
> >>> affect the (in)ability of the device to perform DMA. I.o.w. it should not
> >>> influence PIO mode. Can you confirm this?
> >>>
> >> no any particular reason, just see no sense to set mask if dma will not
> >> be used
> > So, this is an unneeded churn in the patch. Device is [still] capable of DMA?
> > Yes. Set the mask. The DMA/PIO choice is done on the upper layer (as you do it
> > via ops).

-- 
With Best Regards,
Andy Shevchenko



