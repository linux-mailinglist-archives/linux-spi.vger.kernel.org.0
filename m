Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9B657CF4F
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jul 2022 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiGUPg0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jul 2022 11:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGUPgT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Jul 2022 11:36:19 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E94CDBF;
        Thu, 21 Jul 2022 08:36:18 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id h18so1426069qvr.12;
        Thu, 21 Jul 2022 08:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNoG8qyTwtKxLZ+3ZiXPaTPcsDHAGEGbxIjDgGoHn3E=;
        b=LqRWn+AxFXEWTq9ho2u8a6wCBxPhEIOCy5Mmm5NuJDBgvs530y8kjpUYebA3MpdCVn
         N6x5Nx9xe2JFxzGeCxAy3+a3Wmn4RPx8MXPfFColUCrYTLgvengsGERMWyIX/pZumKYC
         U7egeapUgf4IsvEqLmV+hTO9u5W2yXgRCUlGYBgVA4RX0600T09rsjJChna7srvK2/M9
         4WDqoiCGwPqIDSNxcSGBfYRDnWvPiqorOT9DBEtK4ZRU+/2YtJ4sJhf+olrh+4fN+c9B
         C01A++uWIXe3wmTBaUekpG+QeVYqGlH6xNqnuFphfe4R/0BIaEal4VLmKKzMnAu3YeJw
         y3Tg==
X-Gm-Message-State: AJIora8mUHUkonNwB4nMvnRtGleqA48hsRjqC7lhYNyceaO6BCJwnKFA
        sG5SNdhuP9113wGVgU53KU+xaweRGzlB+A==
X-Google-Smtp-Source: AGRyM1sOHiwhyj7zXsV1uyU/5YrytYiubF2yM24pU/qu8pkeMKxDg8eCipslVOJKQxGWKBnFMXHdpQ==
X-Received: by 2002:a05:6214:2428:b0:473:5e3a:c66b with SMTP id gy8-20020a056214242800b004735e3ac66bmr34751292qvb.57.1658417777314;
        Thu, 21 Jul 2022 08:36:17 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm1540869qtk.52.2022.07.21.08.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 08:36:17 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31e7055a61dso21099957b3.11;
        Thu, 21 Jul 2022 08:36:16 -0700 (PDT)
X-Received: by 2002:a81:84c1:0:b0:31e:4e05:e4f4 with SMTP id
 u184-20020a8184c1000000b0031e4e05e4f4mr17634707ywf.384.1658417776628; Thu, 21
 Jul 2022 08:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220721143449.879257-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220721143449.879257-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 17:36:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQ5zx2dxuHd4q1c+KmJkvPmAPXB=s4rG7-LVBV8thNLw@mail.gmail.com>
Message-ID: <CAMuHMdXQ5zx2dxuHd4q1c+KmJkvPmAPXB=s4rG7-LVBV8thNLw@mail.gmail.com>
Subject: Re: [PATCH v3] spi: spi-rspi: Fix PIO fallback on RZ platforms
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
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

On Thu, Jul 21, 2022 at 4:35 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> RSPI IP on RZ/{A, G2L} SoC's has the same signal for both interrupt
> and DMA transfer request. Setting DMARS register for DMA transfer
> makes the signal to work as a DMA transfer request signal and
> subsequent interrupt requests to the interrupt controller
> are masked.
>
> PIO fallback does not work as interrupt signal is disabled.
>
> This patch fixes this issue by re-enabling the interrupts by
> calling dmaengine_synchronize().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * dmaengine_synchronize() called unconditionally and removed need_dmar_clr.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
