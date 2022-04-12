Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C78E4FDC69
	for <lists+linux-spi@lfdr.de>; Tue, 12 Apr 2022 13:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbiDLK0S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Apr 2022 06:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358401AbiDLKKI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Apr 2022 06:10:08 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73B972E10;
        Tue, 12 Apr 2022 02:12:51 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id s6so4087412qta.1;
        Tue, 12 Apr 2022 02:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkECA0wcXPkNVP5UUzbpxuKdY10vBfhtx3lvTK3ip6U=;
        b=Z/iymKhNeD2J2v2XHjIE0ytcg1BA+GIQuwJpHfoMh4pCwaNJeXvhAaNc6hejSkc3m3
         jRkbdIQ1lUs9955JdaaMKjT4x8KHIwXQ8qdrZXTr+79XEI6bxaz0XNb/ERaZWNNcgqUi
         qKlu/s7ydSGccPiwIBuz/gNMZ0O6N7emGxq1SAJDGbbjK5cutc880O90q6R3L55cST9m
         TY1tRzwumEj2siJM3hd/rDqIFxiZqVVoS9iyi2yssr8y3xEoQlWq/cMiOYU4DozBKjhf
         Vt1Uz9bWqCy+fiowGEl8GJ39RTksQDjUk4Xgtr9hQpeXFwvUj5oQBUA60JY4zZ8ijkJZ
         JdJA==
X-Gm-Message-State: AOAM533si6dTyjKmg/T/utuAUSrtAHK7pWXEtK0oqP29dI3wrYsIaWW4
        IJuxxbKSpLzkhdTiA2dNt7Tgh2vX/21Ynvo9
X-Google-Smtp-Source: ABdhPJyD/i/77zfWNKW+mEm/kTnlXvC0xn4ydoYn5kZhOF5U/BxUtQTXMf7vAzoiaIcusIJleFrmsA==
X-Received: by 2002:ac8:5893:0:b0:2e1:c7f6:9992 with SMTP id t19-20020ac85893000000b002e1c7f69992mr2480536qta.23.1649754770846;
        Tue, 12 Apr 2022 02:12:50 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id v67-20020a379346000000b0069bdb3bb132sm7949931qkd.37.2022.04.12.02.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 02:12:50 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id m132so2744592ybm.4;
        Tue, 12 Apr 2022 02:12:50 -0700 (PDT)
X-Received: by 2002:a5b:24e:0:b0:63d:cba0:3d55 with SMTP id
 g14-20020a5b024e000000b0063dcba03d55mr24406484ybp.613.1649754770194; Tue, 12
 Apr 2022 02:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220411173115.6619-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220411173115.6619-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 11:12:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWifFd1P941mNdvmvRTYCG0Fg0XagwPTkdVts27664t6w@mail.gmail.com>
Message-ID: <CAMuHMdWifFd1P941mNdvmvRTYCG0Fg0XagwPTkdVts27664t6w@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-rspi: Remove setting {src,dst}_{addr,addr_width}
 based on DMA direction
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Apr 11, 2022 at 7:31 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The direction field in the DMA config is deprecated. The rspi driver
> sets {src,dst}_{addr,addr_width} based on the DMA direction and
> it results in dmaengine_slave_config() failure as RZ DMAC driver
> validates {src,dst}_addr_width values independent of DMA direction.
>
> This patch fixes the issue by passing both {src,dst}_{addr,addr_width}
> values independent of DMA direction.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Suggested-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
(QSPI on Koelsch)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
