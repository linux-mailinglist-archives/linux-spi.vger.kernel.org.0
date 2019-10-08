Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8BDCF5FE
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2019 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfJHJ1W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Oct 2019 05:27:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729624AbfJHJ1W (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Oct 2019 05:27:22 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D64BF9B2AE150A1924E9;
        Tue,  8 Oct 2019 17:27:19 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 17:27:18 +0800
Subject: Re: [PATCH 2/2] spi: npcm: Remove set but not used variable 'val'
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
References: <1570523497-112804-1-git-send-email-zhengbin13@huawei.com>
 <1570523497-112804-3-git-send-email-zhengbin13@huawei.com>
 <CAMuHMdVTH1=nZLKqaAtb4RhVZU2dGra4RSAzRhsescetLAEKbA@mail.gmail.com>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <56658b8a-2a30-a762-1520-1da2719e5b29@huawei.com>
Date:   Tue, 8 Oct 2019 17:27:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVTH1=nZLKqaAtb4RhVZU2dGra4RSAzRhsescetLAEKbA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 2019/10/8 17:00, Geert Uytterhoeven wrote:
> Hi Zhengbin,
>
> On Tue, Oct 8, 2019 at 10:25 AM zhengbin <zhengbin13@huawei.com> wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/spi/spi-npcm-pspi.c: In function npcm_pspi_handler:
>> drivers/spi/spi-npcm-pspi.c:296:6: warning: variable val set but not used [-Wunused-but-set-variable]
>>
>> It is not used since commit 2a22f1b30cee ("spi:
>> npcm: add NPCM PSPI controller driver")
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> Have you tested this on actual hardware?
> Are you sure the hardware does not require reading this register to work
> properly?

oops, my mistake, sorry for the noise.

marybe we can just remove val, and call  ioread8(NPCM_PSPI_DATA + priv->base); ?

to avoid this warning?


>> --- a/drivers/spi/spi-npcm-pspi.c
>> +++ b/drivers/spi/spi-npcm-pspi.c
>> @@ -293,7 +293,6 @@ static void npcm_pspi_reset_hw(struct npcm_pspi *priv)
>>  static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
>>  {
>>         struct npcm_pspi *priv = dev_id;
>> -       u16 val;
>>         u8 stat;
>>
>>         stat = ioread8(priv->base + NPCM_PSPI_STAT);
>> @@ -303,7 +302,6 @@ static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
>>
>>         if (priv->tx_buf) {
>>                 if (stat & NPCM_PSPI_STAT_RBF) {
>> -                       val = ioread8(NPCM_PSPI_DATA + priv->base);
>>                         if (priv->tx_bytes == 0) {
>>                                 npcm_pspi_disable(priv);
>>                                 complete(&priv->xfer_done);
> Gr{oetje,eeting}s,
>
>                         Geert
>

