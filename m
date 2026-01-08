Return-Path: <linux-spi+bounces-12216-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADF1D047C3
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 17:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D458323B7CB
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC16946BBFF;
	Thu,  8 Jan 2026 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0QsV2+5m"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116FC46BBED;
	Thu,  8 Jan 2026 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876706; cv=none; b=JjuzRYESi0CTkkWjidltZAfTJAtwuSYLyw+iaeDB4RTepP2ylu2boEdc0V/5XTAmEIsdSS91gbhIA25HURvmi+v1PbmwwFXSTVu3ZplC56WhS0DPuaSwkqHFcXU/fr8eXO0UKmjIFTLIzgPVGsb7tgveYtV7k608jazCl9ghMYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876706; c=relaxed/simple;
	bh=oMbg1t4gVHb0Gg+4k+LaYWcg2zi+dDlwTj6oLi0A9bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DZe9AfJ0SGR1qCrfQlEEJCXjSgFWuueEvdliSFx5knRNgoMv+noKhULkmgQSgj9sauGpyr8m1/FWc04UeHUH8akd+QiL309+IWo8F7FpoM4ncuneCdhA5bmxJpmb1RI0Rk+bKvrnjzqxlYN9PcDkZH/SeAwgaSMkmdp43PE9Chk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0QsV2+5m; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1767876705; x=1799412705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oMbg1t4gVHb0Gg+4k+LaYWcg2zi+dDlwTj6oLi0A9bE=;
  b=0QsV2+5mdWUmtiptXmK2/DBE8wMGZXgafrQnFEhOQXs6eReG3h15qAB0
   6hEjVW+reMHGnxV/8lfW2uf+ShU6YNdItACuGF1MN8qQT0ZxpPedC8Hy7
   DD3hYAMr5U7uFj+ozfaQavq8NZFUwuB4/npaQFwO3nwScoUimqpZctIiF
   +p4goaIqbg/tWSbLS23iDPVcx0pnmEBYVd3J6wyI1kZxIsK65/BJiVI1G
   6ZX3c12N4wOh6ObenByKWrEE095cJBkWTFEBi0RdIY6c13CGT0zLPK++A
   Xi5EoGk8+jBK2+Mr+3c+tSp1R6EdbKr/bJx1sSsjJtBUfOo2JeC+ThHR8
   A==;
X-CSE-ConnectionGUID: X6J/S07DR6yot7+6HsGmPQ==
X-CSE-MsgGUID: aacrEZ+gQPGTejMT6AIfFQ==
X-IronPort-AV: E=Sophos;i="6.21,210,1763449200"; 
   d="scan'208";a="51559444"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jan 2026 05:51:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 8 Jan 2026 05:51:08 -0700
Received: from [10.205.167.104] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 8 Jan 2026 05:51:06 -0700
Message-ID: <12446fa2-570b-4882-80dc-c72a166aaf19@microchip.com>
Date: Thu, 8 Jan 2026 13:00:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] spi: microchip-core: use XOR instead of ANDNOT to
 simplify the logic
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Conor Dooley
	<conor@kernel.org>
CC: Jonas Gorski <jonas.gorski@gmail.com>, Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Prajna Rajendra
 Kumar - M74368" <prajna.rajendrakumar@microchip.com>
References: <20251128185518.3989250-1-andriy.shevchenko@linux.intel.com>
 <20251128185518.3989250-3-andriy.shevchenko@linux.intel.com>
 <CAOiHx==y-4Jjckr-KnwdmJhi=TR9_wzcHvNo8GAeUmJ43Y_bHw@mail.gmail.com>
 <aSqsdKpJ7CDd6jJn@smile.fi.intel.com>
 <20251201-calamity-favoring-b2d1ec4bcc81@spud>
 <aS3XBW7D0vVmUTio@smile.fi.intel.com>
Content-Language: en-US
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
In-Reply-To: <aS3XBW7D0vVmUTio@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 01/12/2025 17:57, Andy Shevchenko wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
> On Mon, Dec 01, 2025 at 04:08:57PM +0000, Conor Dooley wrote:
>> On Sat, Nov 29, 2025 at 10:19:00AM +0200, Andy Shevchenko wrote:
>>> On Fri, Nov 28, 2025 at 08:30:43PM +0100, Jonas Gorski wrote:
>>>> On Fri, Nov 28, 2025 at 7:56 PM Andy Shevchenko
>>>> <andriy.shevchenko@linux.intel.com> wrote:
> ...
>
>>>>> -       if (spi->mode & SPI_MODE_X_MASK & ~spi->controller->mode_bits) {
>>>>> +       if ((spi->mode ^ spi->controller->mode_bits) & SPI_MODE_X_MASK) {
>>>> This changes the behavior: if a bit isn't set in spi->mode that is set
>>>> in mode_bits, it would have been previously accepted, now it's
>>>> refused. E.g. controller has (SPI_CPOL | SPI_CPHA), device only
>>>> SPI_CPOL. 0x1 & 0x3 & ~0x3 => 0, vs (0x1 ^ 0x3) & 0x3 => 0x2
>>>>
>>>> If this is the actually intended behavior here, it is a fix and should
>>>> carry a Fixes tag (the message below implies that).
>>> Yeah, yesterday I was thinking about the same and I was confused by the logic
>>> behind. As far as I understood the comments regarding mode provided by DT is
>>> that the mode is configured in IP and may not be changed. And you are right
>>> about the fix, but let's wait for Microchip to elaborate on the expected
>>> behaviour.
>> Prajna is on holiday and I don't have a setup to actually test this on,
>> but I'm 99% sure that you're both right and the original behaviour was
>> wrong. There's a verilog parameter to the IP block that determines which
>> motorola mode it is and a device that's not an exact match won't work.
> Okay, let's not hurry up with this and wait for testing results.
>
>> FWIW:
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>>>                  dev_err(&spi->dev, "incompatible CPOL/CPHA, must match controller's Motorola mode\n");
>>>>>                  return -EINVAL;
>>>>>          }
> Thanks for the review!
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Hi,

I've tested this on my setup and XOR check matches how the controller
behaves. The SPI mode is fixed in hardware, so the previous logic was
wrong.

Tested-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>


