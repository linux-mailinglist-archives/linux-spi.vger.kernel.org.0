Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE15A104E38
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2019 09:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKUIkx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Nov 2019 03:40:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49280 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKUIkw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Nov 2019 03:40:52 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAL8el3Z123034;
        Thu, 21 Nov 2019 02:40:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574325647;
        bh=3pylHeaN7iP6cxBeTqVahG6KV6jdHcvq0KcnwEGK/LI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yai/2WpPT8zYSQ9++gVSogRTbCi+pMS2ua+nUCFcysWmgP6Q8biDbD5aSyFrKX1M+
         ISqkkFs5dWettRGuHIG2vAO3xRHou12aNXokBdOtQYtgyHVEO385fOcGvJK5Tx/SbF
         0zf0Cn5liOL6dpbvr72ODXWRUji/2FeCJ9C9tyVw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAL8elVs122541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Nov 2019 02:40:47 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 21
 Nov 2019 02:40:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 21 Nov 2019 02:40:46 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAL8eikU059437;
        Thu, 21 Nov 2019 02:40:45 -0600
Subject: Re: [PATCH] spi: pic32: Retire dma_request_slave_channel_compat()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191121080954.14915-1-peter.ujfalusi@ti.com>
 <CAMuHMdVWCM_LQ5Fx+3NMhyd21LSpYQWCX2pmtkU2tHvtzDzUzw@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <c14dd693-74e6-7e48-9697-849f44b8e0d9@ti.com>
Date:   Thu, 21 Nov 2019 10:40:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVWCM_LQ5Fx+3NMhyd21LSpYQWCX2pmtkU2tHvtzDzUzw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

On 21/11/2019 10.30, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Thu, Nov 21, 2019 at 9:11 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> There is no reason to use the dma_request_slave_channel_compat() as no
>> filter function and parameter is provided.
>>
>> Switch the driver to use dma_request_chan() instead.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
>> --- a/drivers/spi/spi-pic32.c
>> +++ b/drivers/spi/spi-pic32.c
>> @@ -609,22 +609,18 @@ static void pic32_spi_cleanup(struct spi_device *spi)
>>  static void pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
>>  {
>>         struct spi_master *master = pic32s->master;
>> -       dma_cap_mask_t mask;
>>
>> -       dma_cap_zero(mask);
>> -       dma_cap_set(DMA_SLAVE, mask);
>> -
>> -       master->dma_rx = dma_request_slave_channel_compat(mask, NULL, NULL,
>> -                                                         dev, "spi-rx");
>> -       if (!master->dma_rx) {
>> +       master->dma_rx = dma_request_chan(dev, "spi-rx");
> 
> Why not dma_request_slave_channel()?

The longer term plan is to retire dma_request_slave_channel() as well.
With dma_request_chan() deferred probing against DMA drivers is possible
and it also supports legacy boot with dma_slave_map.

At the end we should be left with only dma_request_chan() for slave
channels in the kernel.

> That way you...
> 
>> +       if (IS_ERR(master->dma_rx)) {
> 
> ... don't have to change the NULL check here, and...
> 
>>                 dev_warn(dev, "RX channel not found.\n");
>> +               master->dma_rx = NULL;
> 
> ...  don't have to override by NULL here.

It is a small sacrifice, true, but if anyone cares the driver can
support deferred probing with dma_request_chan().

> 
> (same for TX below).
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
