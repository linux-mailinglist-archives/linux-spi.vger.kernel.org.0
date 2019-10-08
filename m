Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7370CF577
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2019 11:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfJHJAk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Oct 2019 05:00:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36825 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbfJHJAk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Oct 2019 05:00:40 -0400
Received: by mail-oi1-f193.google.com with SMTP id k20so14181739oih.3
        for <linux-spi@vger.kernel.org>; Tue, 08 Oct 2019 02:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYgIWTJVvflHeQL1iNyNFtgdqyVj+u3ySrKIccmsHP0=;
        b=Ur14RhBZPxmOZ5DPb9N0SsGqk+Ts4+9DnEoYosaxjwJv9kOJMCrBxWm7rDa6Cjo0Mo
         4O7hZeZqjPeub104OhYPXFiOTl5xKcqggAn3l9QN6KeqI5vF4ImNXqMCymH3wJZozcN0
         8aJ+Tg27ktWJz248YVBLI9MYZzBMliYbVylxyIpkiHsa+XrrYFuEo3/W9E2jqaQl5tPs
         DaOA788XOaFYAjCqprOmnqTQ74oWXMrc9n9U6fTFBFXliT5AgKJ6Sv9uAmMWCois3cgR
         iDpKSFT9P2HsYVODU0bFIfkzCRDoNIPhPQmn17iTPtz8UrNymQeW40gq7zyX/5UXybau
         hhQA==
X-Gm-Message-State: APjAAAVCISu2kP+zNt7W3+cr5g5AeEtMs0+hlbSPvVQVD/2YkwcP4zhK
        nTcF10SceVrSfQuGGR8Yut8w6Y5Rg3yZHv1gwhrupiFp
X-Google-Smtp-Source: APXvYqxWCeuiIlVCXddRHAdaOAvWKyE6qpTAvn7ni7dMHSRXR86qSlCRs/CU2d2eWf6M3twjx2GXPgsThlpvzWskEWM=
X-Received: by 2002:aca:f305:: with SMTP id r5mr2872124oih.131.1570525239790;
 Tue, 08 Oct 2019 02:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <1570523497-112804-1-git-send-email-zhengbin13@huawei.com> <1570523497-112804-3-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1570523497-112804-3-git-send-email-zhengbin13@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 11:00:28 +0200
Message-ID: <CAMuHMdVTH1=nZLKqaAtb4RhVZU2dGra4RSAzRhsescetLAEKbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: npcm: Remove set but not used variable 'val'
To:     zhengbin <zhengbin13@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Zhengbin,

On Tue, Oct 8, 2019 at 10:25 AM zhengbin <zhengbin13@huawei.com> wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/spi/spi-npcm-pspi.c: In function npcm_pspi_handler:
> drivers/spi/spi-npcm-pspi.c:296:6: warning: variable val set but not used [-Wunused-but-set-variable]
>
> It is not used since commit 2a22f1b30cee ("spi:
> npcm: add NPCM PSPI controller driver")
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Have you tested this on actual hardware?
Are you sure the hardware does not require reading this register to work
properly?

> --- a/drivers/spi/spi-npcm-pspi.c
> +++ b/drivers/spi/spi-npcm-pspi.c
> @@ -293,7 +293,6 @@ static void npcm_pspi_reset_hw(struct npcm_pspi *priv)
>  static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
>  {
>         struct npcm_pspi *priv = dev_id;
> -       u16 val;
>         u8 stat;
>
>         stat = ioread8(priv->base + NPCM_PSPI_STAT);
> @@ -303,7 +302,6 @@ static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
>
>         if (priv->tx_buf) {
>                 if (stat & NPCM_PSPI_STAT_RBF) {
> -                       val = ioread8(NPCM_PSPI_DATA + priv->base);
>                         if (priv->tx_bytes == 0) {
>                                 npcm_pspi_disable(priv);
>                                 complete(&priv->xfer_done);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
