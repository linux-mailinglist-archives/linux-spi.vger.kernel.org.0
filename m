Return-Path: <linux-spi+bounces-6007-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D14D9ECFAB
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 16:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87AA2859AE
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A1F1D5ACE;
	Wed, 11 Dec 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BLKgsUF/"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41B1B6D0D;
	Wed, 11 Dec 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930748; cv=none; b=o1/9BwqB5V8+TiHvE4Q97tPVZBpakBY6lMws2kxmznEZjl5roqnN2J5da6tDFiNuxFuKOoc4Ynij0dEOWS0e8xN12HLdhhacJz9pKSRYxFtt0o9lf9X26n+CJx2JUDfDTr5bg/kpk0m0Fk0u3veT+LD8aamyO6tkRIU7WL3rmfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930748; c=relaxed/simple;
	bh=PX0Dak1GrNxWpNhFmQrRSn4HhzzLwAXXKZWfOHdy07c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iFv5hypgRZEP7wuudBnp5bVU69M0DYy2uIk7s4VI4k/6krJDdTQzNZiwfpDVQuNOlz5rfcbSm8/AViVCw0m2+lQlFtqrxflVVk5BVEFXwJG42UbSfgbpGR/njWrAp6RCb6hAHJYY+BdSPaQWrDV0wioXhuguTSfVZSRK/H6Ekms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BLKgsUF/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733930746; x=1765466746;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PX0Dak1GrNxWpNhFmQrRSn4HhzzLwAXXKZWfOHdy07c=;
  b=BLKgsUF/wbMyTGyowKR6w+3rieVTd8ha3flvuryhF1JiDRHuGWWi77pB
   lxRa/o25IEnIlFcR9cylPVAYPCfJFd+69HMnFaNxIx4beiuXGJf5e7y2P
   jjIZHif8PIqoGpu2AsC/bDw58eAOkRgGOiFna0G59EkXpyIutwGxL8nb9
   mhZQAiGpC/MyJCj+KuROP2V6ohJqW+xB961Pd3I6qajaXR5mb1WsadoEB
   Jmnz4zIbQnIB852ljMk8Z9HX8m8GR+ZQ0VYg6MRCXYFm3cBHCrQyvxumq
   aw6+qAnFmvJxu/BwukHLRgRSOvBXRypu83MPnkW97ykF8iRcg+bQZOOSW
   g==;
X-CSE-ConnectionGUID: qgV54QVtS8C7rcxkisT06g==
X-CSE-MsgGUID: PyP866H5QiSc3zjJIIYzAA==
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="35876300"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2024 08:25:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Dec 2024 08:25:31 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 11 Dec 2024 08:25:31 -0700
Message-ID: <fb11338b-986f-4a9a-a0dd-e8f4e63941aa@microchip.com>
Date: Wed, 11 Dec 2024 08:25:32 -0700
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/13] dt-bindings: clock: Add SAMA7D65 PMC compatible
 string
To: Rob Herring <robh@kernel.org>
CC: <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<arnd@arndb.de>, <dharma.b@microchip.com>, <mihai.sain@microchip.com>,
	<romain.sioen@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <5252a28531deaee67af1edd8e72d45ca57783464.1733505542.git.Ryan.Wanner@microchip.com>
 <20241210164638.GA3770349-robh@kernel.org>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <20241210164638.GA3770349-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 12/10/24 09:46, Rob Herring wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, Dec 06, 2024 at 12:59:52PM -0700, Ryan.Wanner@microchip.com wrote:
>> From: Dharma Balasubiramani <dharma.b@microchip.com>
>>
>> Add the `microchip,sama7d65-pmc` compatible string to the existing binding,
>> since the SAMA7D65 PMC shares the same properties and clock requirements
>> as the SAMA7G5.
>>
>> Export MCK3 and MCK5 to be accessed and referenced in DT to assign to
>> the clocks property for sama7d65 SoC.
>>
>> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Missing Conor's ack.
I removed the ack because I have changed the original patch that was
acked. Should the ack not have been removed even though the original
patch as been changed?

