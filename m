Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E774BF635
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 11:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiBVKk2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 05:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiBVKkS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 05:40:18 -0500
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC9915C1A6;
        Tue, 22 Feb 2022 02:39:46 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id j17so9767876vkd.12;
        Tue, 22 Feb 2022 02:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyGyBDnJ7ed79Jt+fCdZ4lhHfeabojxBlr+Z2wBlxFo=;
        b=jvxFkUIvxJh4jVGXMW/VByjwdx7401cxUEb6sxz6mDmOZQhTdpTVXYgF1X0PMrl18q
         qqnvwjmuS3wctyXCQssPAinyhnTs2fPzFrmU0vuTBm0I+oejL34R8XXkygA4FmWkf7RD
         tZTA57DwIYODxtoML+j+RFvPU3aHFohsfTFrFfnmAj7bPLoeJ3FvGE9PW9jTbFy61DI4
         thGXWyL68u3/SKBNuMWcClimJU2mnmoJ1bCieLTwesEr5p+Z1KHra1QrHDVZv+BvW0Av
         CJeLHeUguCeF+sI108TYFFE0pJ0guHW04b9RgGPrLOrJByBHmacdOqWRk/+DhXStoc/Q
         be3A==
X-Gm-Message-State: AOAM532PIkFIYwJeewFqbk3HXwYLh0Cu7E+WogOAlTk0pW90iA3ue4GK
        JR7TXElFQVIWl1+LqsQ5NsbaogrnS5/ruw==
X-Google-Smtp-Source: ABdhPJwaYTrc4TbfnISpFM9BydSY1SjXbfc5T3sX7vwC6veIb7qMqFEbW8TdDdCwP6kCO9kryUg/bA==
X-Received: by 2002:a05:6122:788:b0:331:2063:3645 with SMTP id k8-20020a056122078800b0033120633645mr10100718vkr.10.1645526385864;
        Tue, 22 Feb 2022 02:39:45 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id u8sm1087070vsq.23.2022.02.22.02.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 02:39:45 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id l42so3441696vkd.7;
        Tue, 22 Feb 2022 02:39:45 -0800 (PST)
X-Received: by 2002:a05:6122:8c7:b0:32d:7e3:96c8 with SMTP id
 7-20020a05612208c700b0032d07e396c8mr10270146vkg.7.1645526385162; Tue, 22 Feb
 2022 02:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20211216111654.238086-1-miquel.raynal@bootlin.com> <20211216111654.238086-15-miquel.raynal@bootlin.com>
In-Reply-To: <20211216111654.238086-15-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Feb 2022 11:39:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJHAx4HptRRqfhe74mkfm+-oKp0qtd9Ns7Moh5omWehg@mail.gmail.com>
Message-ID: <CAMuHMdXJHAx4HptRRqfhe74mkfm+-oKp0qtd9Ns7Moh5omWehg@mail.gmail.com>
Subject: Re: [PATCH v6 14/28] mtd: nand: mxic-ecc: Add Macronix external ECC
 engine support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquel,

On Thu, Dec 16, 2021 at 12:48 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Some SPI-NAND chips do not support on-die ECC. For these chips,
> correction must apply on the SPI controller end. In order to avoid
> doing all the calculations by software, Macronix provides a specific
> engine that can offload the intensive work.
>
> Add Macronix ECC engine support, this engine can work in conjunction
> with a SPI controller and a raw NAND controller, it can be pipelined
> or external and supports linear and syndrome layouts.
>
> Right now the simplest configuration is supported: SPI controller
> external and linear ECC engine.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for your patch!

> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -46,6 +46,12 @@ config MTD_NAND_ECC_SW_BCH
>           ECC codes. They are used with NAND devices requiring more than 1 bit
>           of error correction.
>
> +config MTD_NAND_ECC_MXIC
> +       bool "Macronix external hardware ECC engine"
> +       select MTD_NAND_ECC
> +       help
> +         This enables support for the hardware ECC engine from Macronix.

I guess this is a licensable IP core, which can appear anywhere, so
we don't have a proper platform dependency to add here?

> +
>  endmenu
>
>  endmenu

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
