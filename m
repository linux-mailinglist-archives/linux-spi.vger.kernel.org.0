Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FFA25C058
	for <lists+linux-spi@lfdr.de>; Thu,  3 Sep 2020 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgICLbY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Sep 2020 07:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbgICLa2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Sep 2020 07:30:28 -0400
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 696A02071B;
        Thu,  3 Sep 2020 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599131928;
        bh=V5y+y4ckj5wtg1W1CTDEuywzLwbESPco3MLGZI3/DcI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1gkRkIIKuv1Nfmp9tk1EMA/CHfjflnxAq84fYOIoDaeIye7wTy1JurkbZ+xyf5Uoi
         /7XXpWTtQ2h9oD+uqtuRmdtZhyUK6IU3AjFT9qMNc7eFrie2wcPQqixQMzZpO8Ryb5
         Ldgvp/H03/Tx3h/URe8JveHvTCZNx3jfN/VGnY2U=
Subject: Re: [PATCH v2 6/9] spi: spi-s3c64xx: Check return values
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
References: <fa403451-5f61-8edf-c696-2d020ec5b920@kernel.org>
 <CGME20200903084555eucas1p2f40375edb325107b68966fd52198b220@eucas1p2.samsung.com>
 <dleftjmu27s0y8.fsf%l.stelmach@samsung.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <a3e1e8d8-8ad8-6807-6317-caf79f44e91d@kernel.org>
Date:   Thu, 3 Sep 2020 13:18:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dleftjmu27s0y8.fsf%l.stelmach@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 9/3/20 10:45, Lukasz Stelmach wrote:
> It was <2020-09-02 śro 10:14>, when Sylwester Nawrocki wrote:
>> On 9/1/20 17:21, Lukasz Stelmach wrote:
>>> It was <2020-08-25 wto 21:06>, when Sylwester Nawrocki wrote:
>>>> On 8/21/20 18:13, Łukasz Stelmach wrote:
>>>>> Check return values in prepare_dma() and s3c64xx_spi_config() and
>>>>> propagate errors upwards.
>>>>>
>>>>> Signed-off-by: Łukasz Stelmach<l.stelmach@samsung.com>
>>>>> ---
>>>>>     drivers/spi/spi-s3c64xx.c | 47 ++++++++++++++++++++++++++++++++-------
>>>>>     1 file changed, 39 insertions(+), 8 deletions(-)
>>>>
>>>>> @@ -298,12 +299,24 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>>>>>       	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>>>>>     				       dma->direction, DMA_PREP_INTERRUPT);
>>>>> +	if (!desc) {
>>>>> +		dev_err(&sdd->pdev->dev, "unable to prepare %s scatterlist",
>>>>> +			dma->direction == DMA_DEV_TO_MEM ? "rx" : "tx");
>>>>> +		return -ENOMEM;
>>>>> +	}
>>>>>       	desc->callback = s3c64xx_spi_dmacb;
>>>>>     	desc->callback_param = dma;
>>>>>       	dma->cookie = dmaengine_submit(desc);
>>>>> +	ret = dma_submit_error(dma->cookie);
>>>>> +	if (ret) {
>>>>> +		dev_err(&sdd->pdev->dev, "DMA submission failed");
>>>>> +		return -EIO;
>>>>
>>>> Just return the error value from dma_submit_error() here?
>>>>
>>>
>>> --8<---------------cut here---------------start------------->8---
>>> static inline int dma_submit_error(dma_cookie_t cookie)
>>> {
>>>           return cookie < 0 ? cookie : 0;
>>>
>>> }
>>> --8<---------------cut here---------------end--------------->8---
>>>
>>> Not quite meaningful IMHO, is it?
>>
>> dma_submit_error() returns 0 or an error code, I think it makes sense
>> to propagate that error code rather than replacing it with -EIO.
> 
> It is not an error code that d_s_e() returns it is a value returned by
> dma_cookie_assign() called from within the tx_submit() operation of a
> DMA driver.
> 
> --8<---------------cut here---------------start------------->8---
> static inline dma_cookie_t dma_cookie_assign(struct
> dma_async_tx_descriptor *tx)
> {
>          struct dma_chan *chan = tx->chan;
>          dma_cookie_t cookie;
> 
>          cookie = chan->cookie + 1;
>          if (cookie < DMA_MIN_COOKIE)
>                  cookie = DMA_MIN_COOKIE;
>          tx->cookie = chan->cookie = cookie;
> 
>          return cookie;
> }
> --8<---------------cut here---------------end--------------->8---
> 
> Yes, a non-zero value returned by d_s_e() indicates an error but it
> definitely isn't one of error codes from errno*.h.

I guess we can end that discussion at this point and keep your patch
as is, I just followed comment at the dma_submit_error() function:

"if dma_cookie_t is >0 it's a DMA request cookie, <0 it's an error code"
 
AFAICS dma_cookie_assign() always returns value > 0 and dma_submit_error()
only returns the cookie if its value is < 0 so in consequence d_s_e() will 
be always returning 0 in your case (PL330 DMAC)?

The below commit, likely a result of static code analysis, might be 
a confirmation. It could also explain why some drivers overwrite the return
value of d_s_e() and some just pass it up to the callers.

--------------------------------8<------------------------------------
commit 71ea148370f8b6c745a8a42f6fd983cf5ebade18
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Sat Aug 10 10:46:50 2013 +0300

    dmaengine: make dma_submit_error() return an error code
    
    The problem here is that the dma_xfer() functions in
    drivers/ata/pata_arasan_cf.c and drivers/mtd/nand/fsmc_nand.c expect
    dma_submit_error() to return an error code so they return 1 when they
    intended to return a negative.
    
    So far as I can tell, none of the ->tx_submit() functions ever do
    return error codes so this patch should have no effect in the current
    code.
    
    I also changed it from a define to an inline.
    
    Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
    Signed-off-by: Dan Williams <djbw@fb.com>

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index cb286b1a..b3ba7e4 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -38,7 +38,10 @@ typedef s32 dma_cookie_t;
 #define DMA_MIN_COOKIE 1
 #define DMA_MAX_COOKIE INT_MAX
 
-#define dma_submit_error(cookie) ((cookie) < 0 ? 1 : 0)
+static inline int dma_submit_error(dma_cookie_t cookie)
+{
+       return cookie < 0 ? cookie : 0;
+}
--------------------------------8<------------------------------------



