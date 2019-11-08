Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46822F4CB9
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 14:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfKHNJ6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 08:09:58 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:43350 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbfKHNJ5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 08:09:57 -0500
Received: by mail-vk1-f195.google.com with SMTP id k19so1447655vke.10
        for <linux-spi@vger.kernel.org>; Fri, 08 Nov 2019 05:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HY+hEwKLzEvgoQNdabW19WgzgGOYk4Oz3mQlYDf643g=;
        b=vDFk9PbiiKPGPhYzLg2GNX0V2dthcVt2KgzCKLNgfAgLqKKueIbGlFvgJguEauu3yr
         Edz5crkwgGfKylbj2EbbzUWA1B8YrhY0buADRKlwAzpXJUY5ptKS+X9UWRpK+n1B/w6t
         W3b2UtBq5QZCiqRutdyTqgp8HipTJAloJVYA0defWbbG+Kt7xu+QkSamlI1SSD8gO8yO
         qyqJNfVgqdD5T5aHUkZCuucNeXXSH598fm0fGjjTk4HF6s+E5Ihvmd56B4uPCVnQVDcy
         z4nDqb75EZQAP2llZw6uz9GFl2vVTnc1/oD2f0AeNlL2101E6I1fkUaOYo7Oo1saGSD6
         b9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HY+hEwKLzEvgoQNdabW19WgzgGOYk4Oz3mQlYDf643g=;
        b=BZZAnju4Yf+OXBUegEJWGSM5LSkw96IPU0syxkG0kDn9qHsTibtcigj+E9le6uuY9U
         OYrhJAWSput4qKBBj6FCZnFaEEFPaghfCbelLrxvGm4QzxFY6rHG4GHQKOQesw2qNcex
         soNjizJFypCCCn/T84szu7rEVc07IVmRpSkPC8M9DNxBmU50oHF58VS0IfdSF6eNGMw6
         YFekV5pYFjXSgJoBBQFAdY5T9yEhVvNJ4pHpJQ2Kc2cbr1C3CzCrIxkJ7UcHq33IMZq+
         dxzXIfP7AGWIjAKieFXG94bi2w3cQRLye9TCl0ngCURRL8wyDnJlxneel6DPSawBIE/K
         79lg==
X-Gm-Message-State: APjAAAXwtiNuoxq7uZkg6GgYqYHRbv2yP3NvubfTh8ZV6zNFbJfFFRG2
        oW2862xzz47IAjvIQ4bengHmrhuyb2Xw3HHsL1nA8A==
X-Google-Smtp-Source: APXvYqw6tda3Mgq2w8GxUxsCqP9j7yelqHXQaiK6MH66+3Bv9z9BpkU1x4LrI2qJxPlb/FMfyHx1n0FhrzaGzEBMMwY=
X-Received: by 2002:ac5:c756:: with SMTP id b22mr7446044vkn.2.1573218595937;
 Fri, 08 Nov 2019 05:09:55 -0800 (PST)
MIME-Version: 1.0
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr>
In-Reply-To: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Nov 2019 14:09:44 +0100
Message-ID: <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 8, 2019 at 1:33 PM Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> [    3.227053] NIP [c0249054] gen_pool_free_owner+0xfc/0x100
> [    3.232377] LR [c0249054] gen_pool_free_owner+0xfc/0x100
> [    3.237588] Call Trace:
> [    3.240037] [c60e1d08] [c0249054] gen_pool_free_owner+0xfc/0x100
> (unreliable)
> [    3.247113] [c60e1d38] [c0299020] cpm_muram_free+0x84/0xf4
> [    3.252517] [c60e1d58] [c030e7a4] fsl_spi_cpm_free+0x94/0x100
> [    3.258198] [c60e1d68] [c030f2d4] of_fsl_spi_probe+0x260/0x3a0

Since fsl_spi_cpm_free() is called from of_fsl_spi_probe() and doesn't
even exist on the errorpath of this function I suppose it is some kind
inlining of_fsl_spi_probe() which goes on the errorpath and
crashes there. I suspect EPROBE_DEFER (-517) to be behind this
but it is just a guess.

What happens if you add this:

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 4b80ace1d137..a26b5e542006 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -678,6 +678,7 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
        return master;

 err_probe:
+       dev_info(dev, "bail out with error code %d\n", ret);
        fsl_spi_cpm_free(mpc8xxx_spi);
 err_cpm_init:
        spi_master_put(master);

I am assuming that the errorpath inside spi-fsl-cpm.c is crashing,
as cpm_muram_free() is called under the wrong conditions,
or simply not really working.

So fixing the errorpath is a separate problem in itself.

By just looking at the code and not understanding any more than
that the error path on fsl_spi_cpm_free() should probably
equal that of fsl_spi_cpm_init() I guess maybe this could
fix it, could you test?

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 858f0544289e..54ad0ac121e5 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -392,7 +392,8 @@ void fsl_spi_cpm_free(struct mpc8xxx_spi *mspi)
        dma_unmap_single(dev, mspi->dma_dummy_rx, SPI_MRBLR, DMA_FROM_DEVICE);
        dma_unmap_single(dev, mspi->dma_dummy_tx, PAGE_SIZE, DMA_TO_DEVICE);
        cpm_muram_free(cpm_muram_offset(mspi->tx_bd));
-       cpm_muram_free(cpm_muram_offset(mspi->pram));
+       if (!(mspi->flags & SPI_CPM1))
+               cpm_muram_free(cpm_muram_offset(mspi->pram));
        fsl_spi_free_dummy_rx();
 }
 EXPORT_SYMBOL_GPL(fsl_spi_cpm_free);

> Reverting 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
> solves the issue.

I hope we can fix the errorpath so we can see what the real problem
is with this patch.

> Renaming the gpios item to cs-gpios in the devicetree fixes the crash on
> boot but the following warning appears during boot and SPI doesn't work
> (can't read board temperature on LM74 chip):

That's annoying. I hope we can get the code to work though,
let's hammer on it a bit and see if we can fix it!

Yours,
Linus Walleij
