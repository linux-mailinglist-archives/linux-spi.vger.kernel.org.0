Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6148E22201D
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jul 2020 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgGPKBZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jul 2020 06:01:25 -0400
Received: from mail.loongson.cn ([114.242.206.163]:36886 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbgGPKBY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jul 2020 06:01:24 -0400
Received: from [10.130.0.99] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9duJRBfuJsFAA--.4223S3;
        Thu, 16 Jul 2020 18:01:19 +0800 (CST)
Subject: Re: [PATCH v2 2/2] spi: coldfire-qspi: Use clk_prepare_enable and
 clk_disable_unprepare
To:     Mark Brown <broonie@kernel.org>
References: <1594790807-32319-1-git-send-email-zhangqing@loongson.cn>
 <1594790807-32319-2-git-send-email-zhangqing@loongson.cn>
 <20200715094940.GB5431@sirena.org.uk>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
From:   zhangqing <zhangqing@loongson.cn>
Message-ID: <1616bb3e-ba20-46df-7818-c11c382a0d86@loongson.cn>
Date:   Thu, 16 Jul 2020 18:01:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200715094940.GB5431@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxn9duJRBfuJsFAA--.4223S3
X-Coremail-Antispam: 1UD129KBjvJXoW7XFyDCr1xXF17Gw4UXr4rGrg_yoW8Jr4xpF
        WxJFWFka1UXryF9an2yr40qr1ak3yvgayUArWrKa4xXw13Gr9Yqr1rCFyDWFyYvrZ7A3WI
        9FyxXF95AF4DCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjxUx3CzDUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 07/15/2020 05:49 PM, Mark Brown wrote:
> On Wed, Jul 15, 2020 at 01:26:47PM +0800, Qing Zhang wrote:
>> Convert clk_enable() to clk_prepare_enable() and clk_disable() to
>> clk_disable_unprepare() respectively in the spi-coldfire-qspi.c.
> Like I said on the previous version are you sure that ColdFire uses the
> common clock framework and has the prepare calls?
Hi Mark,

Thanks for your reminder again.

I see the following comment and code in arch/m68k/coldfire/clk.c:

For more advanced ColdFire parts that have clocks that can be enabled
we supply enable/disable functions. These must properly define their
clocks in their platform specific code.

int clk_enable(struct clk *clk)
{
     unsigned long flags;
     spin_lock_irqsave(&clk_lock, flags);
     if ((clk->enabled++ == 0) && clk->clk_ops)
         clk->clk_ops->enable(clk);
     spin_unlock_irqrestore(&clk_lock, flags);

     return 0;
}
EXPORT_SYMBOL(clk_enable);

void clk_disable(struct clk *clk)
{
     unsigned long flags;

     if (!clk)
         return;

     spin_lock_irqsave(&clk_lock, flags);
     if ((--clk->enabled == 0) && clk->clk_ops)
         clk->clk_ops->disable(clk);
     spin_unlock_irqrestore(&clk_lock, flags);
}
EXPORT_SYMBOL(clk_disable);

Thanks,
Qing

