Return-Path: <linux-spi+bounces-11622-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F932C8F533
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 16:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90E144E4AAB
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9A122759C;
	Thu, 27 Nov 2025 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="j60Dabbk"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71026F2BC;
	Thu, 27 Nov 2025 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258291; cv=none; b=tOCCuUrd0+8pIMk7uNVIH5Qhmq7bL3vLuMGdPrSRkgb7w1j41HVVJWe2eSbCfYv9o+ykUZF//pithIBiRzPkv01bfR9G+oEpus2AZcevB92LZSYn3S1chxgQxWVHyO39I8adFjqlln5N71cqXl9WCO+1R2xo8vBt4qLOX9tK0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258291; c=relaxed/simple;
	bh=f0Ws7uIdq+4ayP+SUpRN2qhaZyQ3a5jWl7GFqoiCWfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CVSjl+N4M/PPMjUbZkKiYx5Th45kRtU3GTdpzjzPLivJRA3CsNn5vsVnWZMNNlJbgx/uoRoomeo+WBgzRBUq2yUHhqa9vSHVgGdx8y943Pv31qLXYXYGQrTmrkooboiwdPN9phBk+G6P+A92sA4r5IIazgViS6XoE/QTBbaJW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=j60Dabbk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1764258289; x=1795794289;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f0Ws7uIdq+4ayP+SUpRN2qhaZyQ3a5jWl7GFqoiCWfA=;
  b=j60Dabbk04kxZEGO04XALb+ZWJbgIlVy84Q9bdezkmjRzoG87prZZbE0
   95m860yhSglqZABvlt9BwuqTtA+CqqAFlumbpKXLcnsyoKuTOEC/HGDCm
   tjLP1MdI6lDhPN3uH8THc7lGrOohzIJNT4voFU3MRc3G7yYhUbfEzjhKY
   OMs889Qsa1OeSPGNMf4ATH/HqlXAEkQa2Yyo5slWYfvUdFTNaXVxZViLu
   x75CY4YzkGTdOdoiz2XIhFSam2Nb1534axIB5FAUGrVjcqJ30rXiopLZd
   sCOPY9ZxhLEO8vNASC234s5oVwJLK0tAQjnMPSYMTMN/rGmPJ7fJ1dVWE
   A==;
X-CSE-ConnectionGUID: caWGY072RNqSKWV1cMgR9g==
X-CSE-MsgGUID: DfJo+Q09Tk26yVMlcJJwkw==
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="49786172"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2025 08:44:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 27 Nov 2025 08:44:36 -0700
Received: from [10.205.167.104] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 27 Nov 2025 08:44:35 -0700
Message-ID: <09929e85-badd-4c43-a7fa-cd27bf42fbb0@microchip.com>
Date: Thu, 27 Nov 2025 15:55:38 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] spi: microchip-core: use min() instead of min_t()
To: david laight <david.laight@runbox.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mark Brown
	<broonie@kernel.org>, Prajna Rajendra Kumar - M74368
	<prajna.rajendrakumar@microchip.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-2-andriy.shevchenko@linux.intel.com>
 <20251126092258.3bc4d92e@pumpkin>
Content-Language: en-US
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
In-Reply-To: <20251126092258.3bc4d92e@pumpkin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2025 09:22, david laight wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
> On Wed, 26 Nov 2025 08:54:39 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> min_t(int, a, b) casts an 'unsigned int' to 'int'. This might lead
>> to the cases when big number is wrongly chosen. On the other hand,
>> the SPI transfer length is unsigned and driver uses signed type for
>> an unknown reason. Change the type of the transfer length to be
>> unsigned and convert use min() instead of min_t().
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: David Laight <david.laight.linux@gmail.com>
Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
>
>> ---
>>   drivers/spi/spi-microchip-core-spi.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
>> index 16e0885474a0..08ccdc5f0cc9 100644
>> --- a/drivers/spi/spi-microchip-core-spi.c
>> +++ b/drivers/spi/spi-microchip-core-spi.c
>> @@ -74,8 +74,8 @@ struct mchp_corespi {
>>        u8 *rx_buf;
>>        u32 clk_gen;
>>        int irq;
>> -     int tx_len;
>> -     int rx_len;
>> +     unsigned int tx_len;
>> +     unsigned int rx_len;
>>        u32 fifo_depth;
>>   };
>>
>> @@ -214,7 +214,7 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
>>                       spi->regs + MCHP_CORESPI_REG_INTCLEAR);
>>                finalise = true;
>>                dev_err(&host->dev,
>> -                     "RX OVERFLOW: rxlen: %d, txlen: %d\n",
>> +                     "RX OVERFLOW: rxlen: %u, txlen: %u\n",
>>                        spi->rx_len, spi->tx_len);
>>        }
>>
>> @@ -223,7 +223,7 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
>>                       spi->regs + MCHP_CORESPI_REG_INTCLEAR);
>>                finalise = true;
>>                dev_err(&host->dev,
>> -                     "TX UNDERFLOW: rxlen: %d, txlen: %d\n",
>> +                     "TX UNDERFLOW: rxlen: %u, txlen: %u\n",
>>                        spi->rx_len, spi->tx_len);
>>        }
>>
>> @@ -283,7 +283,7 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
>>        spi->rx_len = xfer->len;
>>
>>        while (spi->tx_len) {
>> -             int fifo_max = min_t(int, spi->tx_len, spi->fifo_depth);
>> +             unsigned int fifo_max = min(spi->tx_len, spi->fifo_depth);
>>
>>                mchp_corespi_write_fifo(spi, fifo_max);
>>                mchp_corespi_read_fifo(spi, fifo_max);



