Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A201C45431D
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 09:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhKQJAQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 17 Nov 2021 04:00:16 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:34569 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbhKQJAP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Nov 2021 04:00:15 -0500
Received: by mail-ua1-f53.google.com with SMTP id n6so4358251uak.1;
        Wed, 17 Nov 2021 00:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6vy1KPRa1ED8PcCzhlgYzLQmc74SyldWRjucvNisZ48=;
        b=XdSsg3+JV6r+Pw2+dD036iRl+2+XXInUXFNSyOUQJVZ0fg4K2okQRuw0FUFynw93Mo
         iodNwd8jO3cUV2hYmpihkPtZCbhVMI7/yfHKUnUJF1jdYzXi53SWugYXtaaTo52RlMNT
         620eARaWWKEWENVRL0NVDE3OVdhihCuEgpQJYHA9Q23D8ACxztGc84uHejRW0lfBSxnl
         SXtEHHTeAR1z6TK+ukT/+A0a14EPBcj0bjFQ8AsLDAAq79Get/vluO+ETTxyCrFGOUnI
         9mIlj/TlZEDAQHZIDuVHyuPtcYzH2KEzCfXGGmxMllCMdFJdkvF7ZUMi6IqlEbguOFtP
         O5dg==
X-Gm-Message-State: AOAM533kor7RDjXKJdjL7vLRDiZUxHPFpWcGq1WJdeAxTiUhkF88vtH1
        lZM/kv0JYTpskOVDD0gu4jKA7GZjnk8L5w==
X-Google-Smtp-Source: ABdhPJxl0L+fqu9OcYS/AnAptmk/iHyRsce6Mtf5vRHBYSdMopNjdCacBmHsR8nCi5la0n4LJWsGbA==
X-Received: by 2002:a05:6102:10c:: with SMTP id z12mr64182681vsq.45.1637139436926;
        Wed, 17 Nov 2021 00:57:16 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id j31sm13223511uag.4.2021.11.17.00.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 00:57:16 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id r15so4332794uao.3;
        Wed, 17 Nov 2021 00:57:16 -0800 (PST)
X-Received: by 2002:ab0:15a1:: with SMTP id i30mr21216242uae.122.1637139436148;
 Wed, 17 Nov 2021 00:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20211117010527.27365-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211117010527.27365-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211117010527.27365-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Nov 2021 09:57:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWkeXUzgoPCzxTSv65EGLyQTi_R8WnqOLievLrW9K7kFQ@mail.gmail.com>
Message-ID: <CAMuHMdWkeXUzgoPCzxTSv65EGLyQTi_R8WnqOLievLrW9K7kFQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] spi: spi-rspi: Drop redeclaring ret variable in qspi_transfer_in()
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 17, 2021 at 2:05 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> "ret" variable is already declared in qspi_transfer_in() at the
> beginning of function, drop redeclaring ret in the if block, fixing
> below:
>
> spi-rspi.c: In function ‘qspi_transfer_in’:
> spi-rspi.c:838:7: warning: declaration of ‘ret’ shadows a previous local
>   838 |   int ret = rspi_dma_transfer(rspi, NULL, &xfer->rx_sg);
>       |       ^~~
> spi-rspi.c:835:6: note: shadowed declaration is here
>   835 |  int ret;
>
> Fixes: db30083813b55 ("spi: rspi: avoid uninitialized variable access")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
