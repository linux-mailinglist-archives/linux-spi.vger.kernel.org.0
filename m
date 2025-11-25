Return-Path: <linux-spi+bounces-11543-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34359C8707E
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 21:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559E33B6459
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DC933B6F8;
	Tue, 25 Nov 2025 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHMK0xk+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA8933AD8C;
	Tue, 25 Nov 2025 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102282; cv=none; b=E89hRwy7kAZqjk2X64gj0oWBYGVwSrRPpzGgKy8jU7J9HrvjlmtvrKg7bl9UkwF7/X2mfrM8c0tzlHYZ45tOj7so2rrsWU63l2Rlhs2TaavMa5D1XwjEp7Um60gLs+Z4BgThR/3WmfzcdcycD7/hQSKdVrU52IZZlr6sHbtMaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102282; c=relaxed/simple;
	bh=nlQgA8SwbQHk5U14QPjlZByfr1U0IgvDlzMgeQQE/KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLHg9bEDHwPbGUPXMhLk4ea6vKR/qI1FUvFmB2LMCvv5fnzFEoksLch0wPNjo46kT8uq9m9SmQ7sCU1JVtrFNRshjF9pakBpKqq91rNCqAHpYbJtEfZgziaqGHVTq2BHeI74MnfMRsI2pwyassepTyOu2NvRR/wbxRf7J+yEM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHMK0xk+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764102280; x=1795638280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nlQgA8SwbQHk5U14QPjlZByfr1U0IgvDlzMgeQQE/KI=;
  b=SHMK0xk+sTYYUE6Oc3ds/HCz+QHEtp63jw7/l0m0hVZHsGLJ/soYtGtU
   WmFA04bbjQfRb+zfGxSXBYCDwraM3sSSWJLGIyBfulaseQbM/dis8gdsL
   UriedIFDY+xQ0wDXR9p2g5vGZOiNQzke3xx31wZV0d6KFOgqU3TxmHuqd
   qfivKbf2uIZWsTJ8Q212hDpa38+LEvMCma8XSh1TlD4TDlRcvOFM1tSpt
   u9MBCjm1q/iKbImh3ZoPQTgWAq6tTAXBsyJ3hhUhaA67nLi4ODfjVsUo4
   zMUnOYuPGoN6JmJsaNh0y7IjgP11CRGA2n3l//x5FMjtdvj8BW7aqoxAz
   w==;
X-CSE-ConnectionGUID: znGcCbdTTXqMb1SMA211+Q==
X-CSE-MsgGUID: 4Xc6cTWiTseMbR/BU15Z5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66016356"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="66016356"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:24:39 -0800
X-CSE-ConnectionGUID: gSiRx9hWTuul5+64L2UjIw==
X-CSE-MsgGUID: 6tBO7O20TrKO4OAE7VUosw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="223722026"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.22])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:24:35 -0800
Date: Tue, 25 Nov 2025 22:24:33 +0200
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
Message-ID: <aSYQgZR1YoVQkbxC@smile.fi.intel.com>
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

...

> +			dev_warn(dev, "Detected booting in RESERVED mode (UART_TXD was short to GND).\n");
> +			dev_warn(dev, "This mode is known for incorrect DMA reading of some flashes.\n");
> +			dev_warn(dev, "Usage of DMA for flash operations will be disabled to prevent data\n");
> +			dev_warn(dev, "damage. Unplug your serial console and power cycle the board\n");
> +			dev_warn(dev, "to boot with full performance.\n");

One non-critical remark (for the future), the '\n' in the string literals when
we print messages has two meanings:
 - (obviously) new line
 - (seems not so obvious for people) flush the line to the output device

Due to the second property the messages might be interleaved with the other
messages (assuming SMP machine actively doing and printing something), hence
your messages might be split with other and imagine the user who gets in the
middle of the text something like

"Usage of DMA for flash operations will be disabled to prevent data"

The first thought will be "what the heck does this mean?"

TL;DR: place '\n' with a care in the messages to print not only here,
but in general.

-- 
With Best Regards,
Andy Shevchenko



