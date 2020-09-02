Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61ED325A77C
	for <lists+linux-spi@lfdr.de>; Wed,  2 Sep 2020 10:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgIBIOH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Sep 2020 04:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBIOH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Sep 2020 04:14:07 -0400
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E232072A;
        Wed,  2 Sep 2020 08:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599034446;
        bh=5D9PpWt9bWuDNc203FjduFMM/5rtLKQAc3pFFPBSd7s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=La76+VbBkCekCKyKhOMiO4ukzogPXQcPXmTsjW7CUn9XuTVaaKXRgbg3u/h5UPNUg
         QDS9DQeALQK2dw8H2YN/NHsXzgeLwX5h5dOhachsvz6725rDAKReavMhrfX3f08oyk
         /naVL0/Hw7IwW/K/aFlHGMDNDoaXa0wVYHhIJRQo=
Subject: Re: [PATCH v2 6/9] spi: spi-s3c64xx: Check return values
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
References: <e7db038c-b8e6-8ddc-edc7-8b69c2019d04@kernel.org>
 <CGME20200901152113eucas1p2977046b7a5b4c5a519f88870d658698a@eucas1p2.samsung.com>
 <dleftjd035tteq.fsf%l.stelmach@samsung.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <fa403451-5f61-8edf-c696-2d020ec5b920@kernel.org>
Date:   Wed, 2 Sep 2020 10:14:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dleftjd035tteq.fsf%l.stelmach@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 9/1/20 17:21, Lukasz Stelmach wrote:
> It was <2020-08-25 wto 21:06>, when Sylwester Nawrocki wrote:
>> On 8/21/20 18:13, Łukasz Stelmach wrote:
>>> Check return values in prepare_dma() and s3c64xx_spi_config() and
>>> propagate errors upwards.
>>>
>>> Signed-off-by: Łukasz Stelmach<l.stelmach@samsung.com>
>>> ---
>>>    drivers/spi/spi-s3c64xx.c | 47 ++++++++++++++++++++++++++++++++-------
>>>    1 file changed, 39 insertions(+), 8 deletions(-)
>>
>>> @@ -298,12 +299,24 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>>>      	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>>>    				       dma->direction, DMA_PREP_INTERRUPT);
>>> +	if (!desc) {
>>> +		dev_err(&sdd->pdev->dev, "unable to prepare %s scatterlist",
>>> +			dma->direction == DMA_DEV_TO_MEM ? "rx" : "tx");
>>> +		return -ENOMEM;
>>> +	}
>>>      	desc->callback = s3c64xx_spi_dmacb;
>>>    	desc->callback_param = dma;
>>>      	dma->cookie = dmaengine_submit(desc);
>>> +	ret = dma_submit_error(dma->cookie);
>>> +	if (ret) {
>>> +		dev_err(&sdd->pdev->dev, "DMA submission failed");
>>> +		return -EIO;
>>
>> Just return the error value from dma_submit_error() here?
>>
> 
> --8<---------------cut here---------------start------------->8---
> static inline int dma_submit_error(dma_cookie_t cookie)
> {
>          return cookie < 0 ? cookie : 0;
> 
> }
> --8<---------------cut here---------------end--------------->8---
> 
> Not quite meaningful IMHO, is it?

dma_submit_error() returns 0 or an error code, I think it makes sense
to propagate that error code rather than replacing it with -EIO.
