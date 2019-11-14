Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC35FC12F
	for <lists+linux-spi@lfdr.de>; Thu, 14 Nov 2019 09:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfKNII5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Nov 2019 03:08:57 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59376 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfKNII5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Nov 2019 03:08:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAE88TAI087495;
        Thu, 14 Nov 2019 02:08:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573718909;
        bh=39b7nZ1qRF2Y+FLYhjNIYsRZV7qmctGWElYWFg7WX+c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jz3+gAJ3tZEIyJcZzYoDt3ibitF3wiUAMwOW2S5lRPPY58xnjxyQg4oFQkUEHkTUk
         3TUmRmXZAr4W+u8/Rwj3JafK+izUYxskI6nlAaLVuwLwSdjSJQZdhhMgEEaqdda8nJ
         iO4BKurruUwtjfW9CuZlD+vuGD4UGU9pZ6l3e74k=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAE88SDs112761;
        Thu, 14 Nov 2019 02:08:28 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 14
 Nov 2019 02:08:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 14 Nov 2019 02:08:22 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAE88H8G125696;
        Thu, 14 Nov 2019 02:08:17 -0600
Subject: Re: [PATCH 7/9] spi: s3c64xx: Use dma_request_chan() directly for
 channel request
To:     Andi Shyti <andi@etezian.org>
CC:     <linus.walleij@linaro.org>, <kgene@kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-arm-msm@vger.kernel.org>,
        <radu_nicolae.pirea@upb.ro>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
        <bjorn.andersson@linaro.org>, <vkoul@kernel.org>,
        <agross@kernel.org>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
        <linux-tegra@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-8-peter.ujfalusi@ti.com>
 <20191113234049.GA1249@jack.zhora.eu>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <e453c716-7658-a9fd-324d-4d95ff1aa29c@ti.com>
Date:   Thu, 14 Nov 2019 10:09:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113234049.GA1249@jack.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 14/11/2019 1.40, Andi Shyti wrote:
> Hi Peter,
> 
>>  	if (!is_polling(sdd)) {
>>  		/* Acquire DMA channels */
>> -		sdd->rx_dma.ch = dma_request_slave_channel_reason(&pdev->dev,
>> -								  "rx");
>> +		sdd->rx_dma.ch = dma_request_chan(&pdev->dev, "rx");
> 
> I have a little concern here. We have two funcions
> 'dma_request_chan' and  'dma_request_channel' don't we end up
> making some confusion here?
> 
> Wouldn't it make more sense renaming 'dma_request_chan' to
> 'dma_request_slave_channel_reason'?

The dma_request_channel() should go away. It was the old API before we
got the dma_slave_map for non DT (and non ACPI) platforms so we can get
rid of the filter function exports from DMA drivers to clients all over
the place.

I know there are users where they provide dummy filter function.

At the end the main API to request slave DMA channel should be
dma_request_chan()
For non slave channels (not HW triggered) we have dma_request_chan_by_mask()

Imoh the dma_request_slave_channel_compat() should also go away with time.

> 
> Thanks,
> Andi
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
