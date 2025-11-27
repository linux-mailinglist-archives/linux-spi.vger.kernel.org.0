Return-Path: <linux-spi+bounces-11627-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F02CC8F69E
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 17:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4CBE4ECA09
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748F336EE7;
	Thu, 27 Nov 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="akF8dwpr"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF60231858;
	Thu, 27 Nov 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259089; cv=none; b=ZQmAP5+AWg91U2NWiEVzvSO85N3cmnIvIUpAOO+EHf+J7iMb33sIoJlE5W8393/LbFfUQm/Ha+fggZtMOJWnpQxBsPe66B1Mw/S6Kck2TH07BL0zlR3xtGCgXVr9ENfrCn0fMrSu/CgKu1W7sRu+jyY+KPaykbS1dhNIFQC2Y2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259089; c=relaxed/simple;
	bh=B76jvNuezJl5RDDNSVj5p96Fgml0dOGU9XUp9gb0Yxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RBEjHY3Kg/wZGuoodaf/zEeIElNJBqm8xCh+kFExcV4Z3KX9HtpKiOwzEwA7A4HA1nhutU5MALMPPcnrVVkGQTb2ceeqm+XxuDCIjgb4oYK42Tj9wOqdeWZgUnTLLXUHj5mUM1EH3qiDPtaOhPTilwQsclnVqr1wW+kpAz6Vab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=akF8dwpr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1764259084; x=1795795084;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B76jvNuezJl5RDDNSVj5p96Fgml0dOGU9XUp9gb0Yxo=;
  b=akF8dwpr1GC/lLwj1iTnBZ/Ivl7EafouwwffoolycE8DRU4smYZiS6q8
   Fh2QEsSBIOMuuwPo6m4OJz/hFDVn/QyrDgr9O3luaHtSLPwBObZdLzj+Q
   IZCJVw4Wl/4ciaDir5GZ8s4jjQ7TxUyTG4i6DMVy609zznST5gPmiytg3
   pUw/IiLKebSFuJEX9ck3QPWsNg6mbRcKOH4CbAgjO2LmQ88FcCtx8YwDa
   gfC6ocnrbz7B6Mdevj/hE5nb4REGuMkyfz+WRQvgvU4xwKDKW5DGDCuvO
   sEs/QouMBvDjGVBzq2Nh9dfyzqjBbe3J6RXzxm4PMKudzxvjjzPSlNDy5
   A==;
X-CSE-ConnectionGUID: +Nf61N02TC+aZJxHAR/W9w==
X-CSE-MsgGUID: z+epkULzSPS0tHgKNuNqKQ==
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="56365609"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2025 08:58:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 27 Nov 2025 08:57:23 -0700
Received: from [10.205.167.104] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 27 Nov 2025 08:57:22 -0700
Message-ID: <48d3b29b-1010-4749-aef0-c66a72f1d8fa@microchip.com>
Date: Thu, 27 Nov 2025 16:08:25 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown
	<broonie@kernel.org>
CC: david laight <david.laight@runbox.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Prajna Rajendra Kumar - M74368
	<prajna.rajendrakumar@microchip.com>, Conor Dooley - M52691
	<Conor.Dooley@microchip.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-3-andriy.shevchenko@linux.intel.com>
 <20251126092145.2f8e4c8d@pumpkin>
 <720a960d-797b-4404-90ab-e0c75c12a151@sirena.org.uk>
 <aSbu4BA8pohsYSQ8@smile.fi.intel.com>
Content-Language: en-US
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
In-Reply-To: <aSbu4BA8pohsYSQ8@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 26/11/2025 12:13, Andy Shevchenko wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
> On Wed, Nov 26, 2025 at 12:05:22PM +0000, Mark Brown wrote:
>> On Wed, Nov 26, 2025 at 09:21:45AM +0000, david laight wrote:
> ...
>
>>> I'm not sure I don't prefer the version with one writeb() call.
>>> How about:
>>>              writeb(spi->tx_buf ? *spi->tx_buf++ : 0xaa,
>>>                      spi->regs + MCHP_CORESPI_REG_TXDATA);
>> Please don't abuse the ternery operator like this, just write normal
>> conditional statements.
> FWIW, that's what my patch does already :-)
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Hi Andy,

Thanks for the series. However, this particular patch appears to
introduce a regression. The SPI controller reads an incorrect
Device ID from the peripheral.

I’m investigating the root cause and will follow up.

Best regards,
Prajna


