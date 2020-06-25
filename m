Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C7220A879
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jun 2020 00:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404706AbgFYW6p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Jun 2020 18:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgFYW6o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Jun 2020 18:58:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633E9C08C5C1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 15:56:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h22so4066409pjf.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2020 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6DzB0kF8qy0+gSJmnXLymV2MPI92g2VgejgpjaBktM=;
        b=QQvjNJc4LDkUyQEj3k/zhQITbgGaIESunQW+DqNuSU30V+QbyiVFl9c/68DF7M/6yM
         dviOzIvO+uNyKM+DSUG3VTcKmdnzQeSWs7rkyYoMa92ZBOf5vTa6iweanR5/6PTPf1g0
         3dYV3iSOM6EMgis4RjAY21na0PkbjitVnidTdLZt/xVo3ftrKv6i85RbsHFeunk7Viay
         /ewWVYl0s3G6b8YHqjSV0fh94qI32fYJH1nvDSqZcNLSKK9BwP+sgvnwoRR/x0gyQSNM
         gnXI36W3enB03KacNBKNMDmpcpbPAj9ia6TVoFgbRvFVIO7RsL04+xqStegD+mQHSu7e
         fjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6DzB0kF8qy0+gSJmnXLymV2MPI92g2VgejgpjaBktM=;
        b=ApQXt+41s8a/KMN/38GslV5PtTNphLV42GnIkETGC1JEPRU2Dt+cz8LP7xJwJ+6Od9
         mY3x8bekQ/dZlL8xVInbaVerxXcBJEGjjIUaEn0zO3a3qlwZuk+kqRxhKbL4Bz8m1eme
         hVIai+kBWYTKQDERhJSnXWcMu+horK5HuWHTlycMa5CMMyyFyDkuwrMEtQUHNQPDSXVO
         ODx+0AIo4nJe4Zo2Hz2zu4nU5i/byuBrTAJWerXVqpvM6oS37pp/YVMesdOCLLIDUKMB
         +8wgj8tkL5VKv3Bgg5r4oX+wCIPlG8q906tmz8wG3MPNQfyQJM83jOPvNkIBD+Mr3paZ
         SQ2w==
X-Gm-Message-State: AOAM533DJ04c4tG7KST4dzzppIoTv0bY9nOFOR+l51zeGS6UDB2aNvtf
        PGYzTNp4selmKmrsZuBhPBgUuuU6hlU5fAIWjdisz3H5nak=
X-Google-Smtp-Source: ABdhPJwkIJ60G5G5apHcvaG9KpUzam3abN6MZ9YDagoUHxh9hSG3jXPS5ISFQjJOBsS5YpWnLmoXYC82m+Q6VtoJCrw=
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr265867pje.129.1593125769735;
 Thu, 25 Jun 2020 15:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200625220808.hac4egxalgn3pcqk@mobilestation>
In-Reply-To: <20200625220808.hac4egxalgn3pcqk@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Jun 2020 01:55:53 +0300
Message-ID: <CAHp75VfF3GhjNEgHaQWn+LqbVZVOn3_mORSompexxxRnmiAFcg@mail.gmail.com>
Subject: Re: [RFC] spi: dw: Test the last revision of the DMA module
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 26, 2020 at 1:08 AM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:

> Have you tested the recent revision of the DW APB SSI driver with DMA
> enabled? I am particularly concerned about the next fix in the driver:

Yes.

> > +     dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);

Yes, this line is problematic.
However we have experiencing another issue with Tx underrun, that's
why below has not been shared.

> Generally speaking it must work (even DW APB SSI/DMA databook suggests to have
> such DMATDLR setting), but in our case of a relatively slow DMA engine (it's
> clocked with just twice higher frequency with respect to the max SPI bus
> speed) sometimes SPI Rx FIFO gets overflown when SPI bus is configured to work
> with maximum speed (there are multiple reasons why this happens, but generally
> speaking all of them matter only due to the relatively slow DMA engine). The
> problem is fixed by reducing a value written into the DMATDLR register.
>
> I am wondering whether you've tested the last revision of the driver and it
> worked for your version of the DW APB SSI + DW DMAC IPs. AFAIU DMA engine on
> your devices is faster than on ours and has LLPs supported. So if you haven't
> noticed any problem in the recent driver, then I'll send a fixup for our version
> of the DW APB SSI block only (I'll have to introduce a new compatible string).
> Otherwise I could get back a setting of dws->txburst into the DW_SPI_DMATDLR
> register, which isn't that optimal as the current DMATDLR setting
> of (fifo_len - txburst), but at least will make things working for all DMAs.

That's what I have locally.

commit 43d9abb2711f5096e969adcf1a2fb6456fa6e275 (HEAD -> topic/ehl-dma)
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue Jun 2 15:53:03 2020 +0300

    DEBUG SPI dw (burst fix?)

    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 5986c520b196..79342528b1f4 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -373,7 +373,7 @@ static int dw_spi_dma_setup(struct dw_spi *dws,
struct spi_transfer *xfer)
        u16 imr = 0, dma_ctrl = 0;

        dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
-       dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
+       dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);



-- 
With Best Regards,
Andy Shevchenko
