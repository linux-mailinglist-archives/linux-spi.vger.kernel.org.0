Return-Path: <linux-spi+bounces-11542-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0A7C87009
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 21:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263D03B6335
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A133B95E;
	Tue, 25 Nov 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lo1ReI/v"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9133B6D7;
	Tue, 25 Nov 2025 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101941; cv=none; b=JsF5MkO3Ka6eE95mo5tl/Qxwt9SOnnIWkKGohEcTc/4EmH/kOmgYmS4e6Dvt2dzgimf9p8zzRi4q35tyXXS5PJxAEM1oMju+I51lhLc9xo1g4RUCbWXfHqCXQqpUab9KxpyHgHbqfoYS3wp4PaWVngAq5RlnLrrewbFfYQQuH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101941; c=relaxed/simple;
	bh=C/nczyx82VZaS4AmQR2UYzKvFB2krpsUMY9RzoSPWb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ue4Fs+fezFkFSD2Q/e5qtfkXg/e5nywCxp4WH7EBoLx0BzDaA0omWqXhzaulYH2BFYbhKkiaSXg7e4Kf/wmi0PSHliaIlHxpZ+qN0GsS3VoaKSSK4IyiUIvM9k20w0CuTA+36E6aKaVrNIlYArQgnJn/2BFOS7ZZXZ7Rnme+TwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lo1ReI/v; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764101941; x=1795637941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C/nczyx82VZaS4AmQR2UYzKvFB2krpsUMY9RzoSPWb8=;
  b=Lo1ReI/vu7MpK9+/yGpGO5414ceXr79EvgK9nFdFQwO5UbXrJTAD42bH
   b6ML72HyMZrFC7Pn99L9504K4DvcRVSA+zmLmxcyS40/Mb+Hd9owsFeMH
   C/sirUhDgbaZzezrJj9wkhRvXU+2U3JvBC212PwQ/3hNOy9YnEZJCVbtl
   bIKzxbYYjcfemV+52F8/DkjtCk1RrPZFBFgi67GRdLcQXTLhmBKXnpB1i
   ZyG8GvyMtjtfLMChEaGGeejMQmR2Bub5+Pq0EiKVpZBIG1QaoRiwA47y+
   2boeTJBwUJ41bUNL68IRVzD/0EIRIItx+4UDn7E6vd0711v78WyUm6obg
   w==;
X-CSE-ConnectionGUID: Z/dxbSCkTB63u7amp0xOow==
X-CSE-MsgGUID: K/MecNUeS9mpu1CB2e08fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="88782058"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="88782058"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:19:00 -0800
X-CSE-ConnectionGUID: WwcUIy9TQAutStddwldHXw==
X-CSE-MsgGUID: UUiqtk4+TIehTgfExfLoXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="197862607"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.22])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:18:55 -0800
Date: Tue, 25 Nov 2025 22:18:53 +0200
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
Subject: Re: [PATCH v5 1/3] spi: airoha-snfi: en7523: workaround flash
 damaging if UART_TXD was short to GND
Message-ID: <aSYPLWKEz0lzBtjf@smile.fi.intel.com>
References: <20251125191635.1075027-1-mikhail.kshevetskiy@iopsys.eu>
 <20251125191635.1075027-2-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125191635.1075027-2-mikhail.kshevetskiy@iopsys.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 25, 2025 at 10:16:33PM +0300, Mikhail Kshevetskiy wrote:
> Airoha EN7523 specific bug
> --------------------------
> We found that some serial console may pull TX line to GROUND during board
> boot time. Airoha uses TX line as one of its bootstrap pins. On the EN7523
> SoC this may lead to booting in RESERVED boot mode.
> 
> It was found that some flashes operates incorrectly in RESERVED mode.
> Micron and Skyhigh flashes are definitely affected by the issue,
> Winbond flashes are not affected.
> 
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

LGTM now, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



