Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19EB109F5C
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 14:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfKZNjI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 26 Nov 2019 08:39:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37531 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfKZNjH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 08:39:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id 128so8581994oih.4;
        Tue, 26 Nov 2019 05:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KBE62G5TqwvfDq3zWraJyzewnIE554HLvG/8S50wbCo=;
        b=r5AFMOaS7kWFBunyoGKihP15FDPU+FGCNoi0Fyt5KsA0d9h4Q6fq5U823H3WolVBcb
         S9PmM6IK+N402XTdpAbYkOadlain5B83i8fz92i1lVuRp4WiIUXHGfQEBc8Im8JRBtnw
         3PQz3dkuCtYFBUI0vlGOxka66H6dR8/xVBk1VyWtlKgtO14wiExJpsmpCNp0JYmI1qq1
         6XRtTqOX4i/rW9Wmg7EtpgYJKH/JxTL/24XDDGCpCavhrMhphGuAgjE1+5u6WCjIvZdf
         FsyQIdgwxrwqw6bS6PI0lpClkzYzPXWCeqpo7y3+jP14HnDSoLpDZqkb112Q2cLDC6H7
         edwg==
X-Gm-Message-State: APjAAAVkMiD/v1+cJXfVC9yfkoVT9hb0k44jsZNqgoBNjWrOCuLnxrCY
        2qLzC2lI/Oy6fk7kWF0FLKSNpm3hVMhC8tGaGow=
X-Google-Smtp-Source: APXvYqyHm98jvIoleyicTgAaSVMGjNc3U1qSoWTefwVGDm+ab3CDmGMdxmxk4JTtwPoIhsL1IZ3fNep0gLxkrjxpFAA=
X-Received: by 2002:a05:6808:b17:: with SMTP id s23mr3761322oij.102.1574775546015;
 Tue, 26 Nov 2019 05:39:06 -0800 (PST)
MIME-Version: 1.0
References: <20191126122324.v3rj7oscvjobhjxo@kili.mountain>
 <CAMuHMdX52phf_dSQh3vK8QGJtvmUwDiY_0f6d7xAJ_xF2vKNfg@mail.gmail.com> <a22ba950-f65b-b80e-948a-eddfa0a7d431@ti.com>
In-Reply-To: <a22ba950-f65b-b80e-948a-eddfa0a7d431@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Nov 2019 14:38:54 +0100
Message-ID: <CAMuHMdWrvi9gv1QNwqhQV8cxgK9ecGnaC5LRxvLba5uUJLedrA@mail.gmail.com>
Subject: Re: [PATCH] spi: pic32: Fix an error code in pic32_spi_dma_prep()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Péter,

On Tue, Nov 26, 2019 at 2:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 26/11/2019 15.27, Geert Uytterhoeven wrote:
> > On Tue, Nov 26, 2019 at 1:51 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >> We accidentally return success on this error path.
> >>
> >> Fixes: eb7e6dc6d9ff ("spi: pic32: Retire dma_request_slave_channel_compat()")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> ---
> >>  drivers/spi/spi-pic32.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
> >> index 156961b4ca86..93fb95073522 100644
> >> --- a/drivers/spi/spi-pic32.c
> >> +++ b/drivers/spi/spi-pic32.c
> >> @@ -633,7 +633,8 @@ static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
> >>                 goto out_err;
> >>         }
> >>
> >> -       if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE))
> >> +       ret = pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE);
> >> +       if (ret)
> >>                 goto out_err;
> >
> > This used to be non-fatal, as DMA was optional, cfr. the comment:
> >
> >         /* optional DMA support */
> >         ret = pic32_spi_dma_prep(pic32s, &pdev->dev);
> >         if (ret)
> >                 goto err_bailout;
> >
> > However, as of the aforementioned commit, DMA is no longer optional,
> > and probe will fail instead of falling back to PIO on DMA init failure...
>
> It is still optional. It only handles deferred probing. If the DMA
> request fails then it returns 0 and the driver falls back to PIO.

Oops, I missed that ret is only set to a non-zero value in case of
probe deferral.

Sorry for that, seen too many broken patches today ;-)

> And this is why I have not changed the pic32_spi_dma_config() error
> handling.

Right. So Dan's patch is wrong, as it makes this a hard failure, preventing
fallback to PIO.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
