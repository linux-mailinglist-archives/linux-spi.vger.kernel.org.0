Return-Path: <linux-spi+bounces-11498-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AFFC83AFF
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 08:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221853AC4B8
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 07:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDD32877D6;
	Tue, 25 Nov 2025 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWUHhcFU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D1286D4B;
	Tue, 25 Nov 2025 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055122; cv=none; b=MYHp325LAh9aoI4Dvt38uTBOvsn382aUDvVeL8Xg2jbJrmZtbCaBGZA7hotLM5wkEv27wma1X7xFSD28S/ceFw+AjoueUl2sOZAuFkgZQbEIGJIyCZPOsO7cZEfINNBaCjcnC73czobPyVWrndtdUbPhhKA8Fl6/Rukq5X6Mcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055122; c=relaxed/simple;
	bh=/X+wco292UFJAKK39s6qaccyy9GGH1wWRxkeCx6P5qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7cbApo2kwNvJGl+QMoYU2Euf7Joql1Kgwv2BgynKqY5p6FMCLf9x2VkMXafBzfNj4m5DtyVKjRz5VxOAyGdrNhz2Qy/DDk7CvjE2ESIjv/uZwuY/BmM64/CYDm7/0zk5ryHiZeIkHvScY+Wsn0fw9UTNkztCEyrqyBJifn2FVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWUHhcFU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764055121; x=1795591121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/X+wco292UFJAKK39s6qaccyy9GGH1wWRxkeCx6P5qw=;
  b=jWUHhcFUJYgRzM4ktmQVPyCQ11+VuR1Lr7zXPERIdGfUMVSdiqcY/9Bw
   f9OMndt4TE56OgIIFV0HXRjQHys5DMWnlaiq0PlF8elxw/MD7GizyqBnD
   s99NrZduyPZLFPUOwSSDdZp7RC6le83VWjSuugMxRbM3hEuFjX76XxIWg
   QLKLQQGbtiemfeSwI2F5Nv3rLNZbKYP7YvnyeNX80lY8ZiYmEzKNYMkE7
   0U7ZEbTUTNttVdYrCIgmaAcHt2uS+RjmqdEGuC1/ntBYj7uml/shWjTDD
   5Im1NTgRag1zLdwvdS0aIs5nN7NGChomH8lf1j6eUWE0JeWWlhNZpHBHB
   Q==;
X-CSE-ConnectionGUID: YgBwxtBlQYqh6tzrhKwklA==
X-CSE-MsgGUID: rt9pVVdZR+6CgU3pYgQKcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77176689"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="77176689"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 23:18:41 -0800
X-CSE-ConnectionGUID: BWEPn88hRXSOdQ6eSCA73A==
X-CSE-MsgGUID: n8YhzwQNQE+i8HSVsoquTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="229840402"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 23:18:37 -0800
Date: Tue, 25 Nov 2025 09:18:34 +0200
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
Message-ID: <aSVYShXLirW--bYe@smile.fi.intel.com>
References: <20251125021051.857159-1-mikhail.kshevetskiy@iopsys.eu>
 <20251125021051.857159-2-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125021051.857159-2-mikhail.kshevetskiy@iopsys.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 25, 2025 at 05:10:49AM +0300, Mikhail Kshevetskiy wrote:
> Airoha EN7523 specific bug
> --------------------------
> We found that some serial console may pull TX line to GROUND during board
> boot time. Airoha uses TX line as one of it's BOOT pins.

I know the term bootstrap, what does BOOT mean?

> On the EN7523 SoC this may lead to booting in RESERVED boot mode.
> 
> It was found that some flashes operates incorrectly in RESERVED mode.
> Micron and Skyhigh flashes are definitely affected by the issue,
> Winbond flashes are NOT affected.

NOT --> not

> Details:
> --------
> DMA reading of odd pages on affected flashes operates incorrectly. Page
> reading offset (start of the page) on hardware level is replaced by 0x10.
> Thus results in incorrect data reading. As result OS loading becomes
> impossible.
> 
> Usage of UBI make things even worse. On attaching, UBI will detects
> corruptions (because of wrong reading of odd pages) and will try to
> recover. For recovering UBI will erase and write 'damaged' blocks with
> a valid information. This will destroy all UBI data.
> 
> Non-DMA reading is OK.
> 
> This patch detects booting in reserved mode, turn off DMA and print big
> fat warning.

...

> -	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
> -	if (err)
> -		return err;

> +	if (dma_enable) {
> +		err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
> +		if (err)
> +			return err;
> +	}

Why do you need this to be conditional? The settings of DMA mask should not
affect the (in)ability of the device to perform DMA. I.o.w. it should not
influence PIO mode. Can you confirm this?

-- 
With Best Regards,
Andy Shevchenko



