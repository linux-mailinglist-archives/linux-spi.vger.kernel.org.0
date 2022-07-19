Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A958B579503
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 10:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiGSILR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 04:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGSILQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 04:11:16 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE821C5;
        Tue, 19 Jul 2022 01:11:15 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id c24so5089152qkm.4;
        Tue, 19 Jul 2022 01:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOxWc09UEL9X9FbemCUP4HNjg4QFbTbbVYlarhBbsaE=;
        b=h4vLGMCCjg4vXUXDlMgwEr5zEy9X81HksjeGDINV/t1E5Sc/UIXEI/1qdiRtAI/9Ek
         Sfrq+5T7LVHmZx0zOo69ymQlCb5QQQjVgzXZNAOTEA/Np6VVjsDpk+jk9HNDx71h7ut3
         QWkTAKO5bzULw9hS/5VURJrMaPt9Le64QhUSzY/QNuTDBqqVcgHQ0YNMADX0DdSNgcWf
         sLixJia1uADQ2MbXcRJWzp6e/oBXZbhmt2J7bQ+e8IwoyZSmKvkSN5mzsUECYh+azrKN
         ZgFSAIm7pLJF/OioSEsyCc0T9XCfw8T1O7wYSNtCjw4YMQ/bJJfwbTfn7QnpZgs3VfrC
         os5w==
X-Gm-Message-State: AJIora97V2MVPBagr24Za3W7Sq3qA46Njlu62hVR/BPBxW1V6OPRI0xR
        9xakMnzYs4psnNAiVBk0SHAdagtTUeniqw==
X-Google-Smtp-Source: AGRyM1uaf+yCcTBl/rVXgPWuWwhL8JvZN/mIFgufgQmqnFhL+FBUysxY/gwjt/CDeX2h8sbhNQcR4g==
X-Received: by 2002:ae9:d8c1:0:b0:6b5:7f9b:d978 with SMTP id u184-20020ae9d8c1000000b006b57f9bd978mr19918053qkf.676.1658218274785;
        Tue, 19 Jul 2022 01:11:14 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id bm17-20020a05620a199100b006b5cccf62fbsm11608898qkb.46.2022.07.19.01.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 01:11:14 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-31c89653790so132283927b3.13;
        Tue, 19 Jul 2022 01:11:14 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr33604113ywd.283.1658218274201; Tue, 19
 Jul 2022 01:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jul 2022 10:11:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWqfnpN_FWyLVb+KGmgR+VY4GJ67Sk2xSAb18HK_B7WZw@mail.gmail.com>
Message-ID: <CAMuHMdWqfnpN_FWyLVb+KGmgR+VY4GJ67Sk2xSAb18HK_B7WZw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Biju,

On Sat, Jul 16, 2022 at 5:39 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> On RZ/G2L SoCs switching from DMA to interrupt mode, causes timeout
> issue as we are not getting Rx interrupt even though SPRF bit is set in
> the status register.
>
> But there is no issue if we don't switch between interrupt to DMA mode
> or vice versa.
>
> Performance comparison between interrupt and DMA mode on RZ/Five SMARC
> platform connected to a display module shows that performance and
> CPU utilization is much better with DMA mode compared to interrupt mode
> (1->65 fps) and (98->8%).
>
> This patch introduces a variable force_dma to avoid switching between
> DMA to interrupt mode for RZ platforms.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> @@ -1196,6 +1197,7 @@ static const struct spi_ops rspi_rz_ops = {
>         .flags =                SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
>         .fifo_size =            8,      /* 8 for TX, 32 for RX */
>         .num_hw_ss =            1,
> +       .force_dma =            true,
>  };

Do you know if this is needed on RZ/A series, too?
I know upstream does not have DMA support for RZ/A yet, but the
BSP has?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
