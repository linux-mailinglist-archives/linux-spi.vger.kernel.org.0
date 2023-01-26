Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2144467C7DA
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jan 2023 10:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbjAZJ5j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Jan 2023 04:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbjAZJ5i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Jan 2023 04:57:38 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E236C10A;
        Thu, 26 Jan 2023 01:57:34 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id s4so843572qtx.6;
        Thu, 26 Jan 2023 01:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0/CGok+q2trTJfM1fINcU1Sm5royASKyfwZ+KPuXyQ=;
        b=oJjopNInKvP6KCImSPtXE/yXP8dJkLnZsoiAOjQPC/wzBPUm34UrpYjCbaLkmRqWj8
         3eq28cbfG3fEiq/9Nh8zOd1qgr5kNS2Dkxq/JOA8970G12GvXUX/+Tu+xLoc+GSnE8rJ
         BKWHIbmBIzSoYvwS/h2TucT8/vhOb+iVRboOgAqf3kqE2Fy5pNRTpXWK0JkJj0Kstkd1
         SVg5ZNjNwRV8tNPjewGh+71D+O300wSfX9TyHS20Es5LgbYizcJzdv+xgzvRJvMaa8ax
         lLAEYC/+3l4t0ccOoRTkggqum53HQxxqG1Cu3uPlhuKRcbXYlqWMLuwYem+hqO/g4I2Y
         09Vw==
X-Gm-Message-State: AFqh2kqqYO2lvoqhL+GSZ2QmMCB/ANSDc43zPe9b27la+e1PnqaeRkpE
        h96zGQw59uaSOxkgHCU87DYPcWY//3TsTA==
X-Google-Smtp-Source: AMrXdXvwNMVNo+MR3kC6WITKoSg2NqVCAhDJEJDA1tLD+d67wseiUBrt3GoiQOZTEYIITcN4uoj1uw==
X-Received: by 2002:ac8:709a:0:b0:3a4:f209:84cd with SMTP id y26-20020ac8709a000000b003a4f20984cdmr49988715qto.9.1674727053184;
        Thu, 26 Jan 2023 01:57:33 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id g13-20020ac8468d000000b003a7e4129f83sm438780qto.85.2023.01.26.01.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:57:32 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-4fd37a1551cso15769517b3.13;
        Thu, 26 Jan 2023 01:57:32 -0800 (PST)
X-Received: by 2002:a81:1216:0:b0:506:6b5d:523c with SMTP id
 22-20020a811216000000b005066b5d523cmr421460yws.283.1674727052535; Thu, 26 Jan
 2023 01:57:32 -0800 (PST)
MIME-Version: 1.0
References: <20230124074706.13383-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230124074706.13383-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Jan 2023 10:57:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUnUf+ZTRTBSmjz1_61CpWvaO=fyDv7ExT+FnQi=ujFXw@mail.gmail.com>
Message-ID: <CAMuHMdUnUf+ZTRTBSmjz1_61CpWvaO=fyDv7ExT+FnQi=ujFXw@mail.gmail.com>
Subject: Re: [PATCH] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Wolfram,

Thanks for your patch!

On Tue, Jan 24, 2023 at 8:47 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Documentation says only DTDL of 200 is allowed for this SoC.

Do you have a pointer to that?

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Tested with MSIOF0 on a Salvator-XS with R-Car H3 ES2.0 by creating a
> loopback with a wire.
>
>  drivers/spi/spi-sh-msiof.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 9bca3d076f05..609f48ec84dd 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -30,12 +30,15 @@
>
>  #include <asm/unaligned.h>
>
> +#define SH_MSIOF_FLAG_FIXED_DTDL_200   BIT(0)

We already have "renesas,dtdl" to configure this from DT.
Iff this is really needed, perhaps it should be added to r8a77951.dtsi?

I suspect this is a leftover in the BSP from attempts to get MSIOF
working on R-Car H3 ES1.0 (which it never did for me, as CLK starts
and stops too soon, compared to MOSI/MISO).
On R-Car H3 ES2.0, everything works fine, without touching DTDL.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
