Return-Path: <linux-spi+bounces-11111-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E214C3F90E
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 11:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3123A3A35A8
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 10:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50831960D;
	Fri,  7 Nov 2025 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZdeRC8fY"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45226ED51;
	Fri,  7 Nov 2025 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512496; cv=none; b=YJXndxThl8d3UGolUn32OliB7cep7/00EsPE2HLvOYf0pP8HoOT8pygMgWvzj32TediDSamVm4uLMngGtdCXwhccE+6rrQ2OcixfQz73mdX0Y7fXDmw3Fz+2b7eGR7PeCJ/x1htAHs7wLE7hq6Wgpf7GT5RawoRJ5bU9ipVXUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512496; c=relaxed/simple;
	bh=RIICj4penxJBPxqBLKJ+4qUchgJuxa5RrSSLr9xnkn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fNTo9rD0n+aZzmuWX2/6NMQxf1L+D2q0Apka3ZERZc7R9l0fVtyq5eQ2olgmuyvASw7t4u6zUxIW+/IksMaFU35pXD2SV37URNcLzpcN94GWUzBEUYP+Ro4/n6sChEZU9BQPZqNvHvpqZlJhCBrNjUt16cdpV38LkGzMjvWXQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZdeRC8fY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762512494; x=1794048494;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RIICj4penxJBPxqBLKJ+4qUchgJuxa5RrSSLr9xnkn8=;
  b=ZdeRC8fYq8JC28j+QuVWBZeyIWtYLkcjhPIYQBrAZ53Bih8xaVailqUA
   u1zpAYHn3L7s8W4GawUgW/E49nmJCmRhyzQKc68X5/fVMMBqIgPQSLsiI
   4TEz+WZiS4Wph3HB5PgNPTT3WqZrbQXALnS4vCSOOfmGrLhh3Sleg4gJO
   0KVmEM4Oc+H/TsPqEj30g2O1vXBTpRYJLix5v0Snc36PuI6cAd43gVEdC
   yB89zW4dkmNBqV4Sonk2mXNWXLHRPTNRWqa5u4irhJxrRrpi/ZbdEVdSB
   RgrfiILVJpPh3RFJ61Ijp6OHghzfdVHgMTZ/gqdlCHG8GrcQMgod1K8Q/
   Q==;
X-CSE-ConnectionGUID: fJZAe2bYTL273syaeJeQIg==
X-CSE-MsgGUID: rkdU9O4ORaqK6SACPKG9Kg==
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="49326352"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 03:48:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 7 Nov 2025 03:47:52 -0700
Received: from [10.205.167.104] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 7 Nov 2025 03:47:50 -0700
Message-ID: <427e0f16-0055-47d8-981e-7bc91ad71bfc@microchip.com>
Date: Fri, 7 Nov 2025 10:52:23 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] spi: add support for microchip "soft" spi
 controller
To: Conor Dooley <conor@kernel.org>, Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>
References: <20251105152823.730422-1-prajna.rajendrakumar@microchip.com>
 <20251105152823.730422-4-prajna.rajendrakumar@microchip.com>
 <aQt41uGfmbs7Qa7x@finisterre.sirena.org.uk>
 <20251106-cable-generic-819b798c7068@spud>
Content-Language: en-US
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
In-Reply-To: <20251106-cable-generic-819b798c7068@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 06/11/2025 17:50, Conor Dooley wrote:
> On Wed, Nov 05, 2025 at 04:18:30PM +0000, Mark Brown wrote:
>> On Wed, Nov 05, 2025 at 03:28:23PM +0000, Prajna Rajendra Kumar wrote:
>>
>>>   drivers/spi/Kconfig              |   9 +
>>>   drivers/spi/Makefile             |   1 +
>>>   drivers/spi/spi-microchip-core.c | 442 +++++++++++++++++++++++++++++++
>>>   3 files changed, 452 insertions(+)
>>> +config SPI_MICROCHIP_CORE
>>> +	tristate "Microchip FPGA SPI controllers"
>>> +	depends on SPI_MASTER
>> Reusing the same filename and config symbol is almost certainly going to
>> create issues and confusion for people upgrading their kernel or doing
>> backports.  Perhaps CoreSPI instead?
> The qspi driver (which is shared between SoC and FPGA IP) uses
> SPI_MICROCHIP_CORE_QSPI, so probably SPI_MICROCHIP_CORE_SPI should be
> used here. Prajna?

Hi Mark, Conor,

Thanks for the feedback. I’ll update the filename and config symbol to 
use SPI_MICROCHIP_CORE_SPI in the next version.

Best regards,
Prajna


