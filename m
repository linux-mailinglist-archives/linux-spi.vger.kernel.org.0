Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AAF77DE87
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 12:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243858AbjHPKVU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 16 Aug 2023 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243963AbjHPKVR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 06:21:17 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D831BE6
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:21:09 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3a43cbb432aso4971119b6e.3
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181269; x=1692786069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt//vQS9S6A+lGQYOMXb7PVJeD+LrN7mtL7eWdnw9Nw=;
        b=G/WxjoCgF0LRz06dLYew1V9X4VF6iK1AlfQ4qWJQgBpOuDS6L2rwJ4NHAmyad9exe3
         Hyt5gTwtVhsmMR4cKl14H1bX0MDSpZuBnidT3HHSn4MHa5LzuQcvqyQ1PSjj+ME6VjUO
         I8gdsEDf50/FbWcJpfSgeURAIqtQ7Vk6oXmzEOj7En9yyNoJx0fpf2NcWapKYTkfdFkl
         KXbTJNoAFoHjXOhgpfI+DaRIbblMebpi1YOLuPz6g8SWu2M/DW3tC1hCtlpy8gT8LVgh
         J1MHFWjJdYFRpTwhQUN0p+dJAtFWTp514buehEECqEzF1oxlRXYl+YplYuagjHG/gXWX
         azFg==
X-Gm-Message-State: AOJu0YwsTzgF0URVrY05ezGgCxeaTZRIwOH4EyfiueCQ9PDXx+yEutPE
        hMUQyBqF9s0S0TR6zg2qH/n130aZxOobXw==
X-Google-Smtp-Source: AGHT+IEYmN2hnh7dXK6++w1r7H8tAndZIE/Ch9Pk7RYtHq/kbuIBDBtx19TotvAp2W+lJMmkShfXbA==
X-Received: by 2002:aca:d11:0:b0:3a3:91f8:d3da with SMTP id 17-20020aca0d11000000b003a391f8d3damr1597795oin.13.1692181269068;
        Wed, 16 Aug 2023 03:21:09 -0700 (PDT)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id 16-20020aca0f10000000b003a724566afdsm6272524oip.20.2023.08.16.03.21.07
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:21:08 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-56cc3453e31so4570400eaf.1
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:21:07 -0700 (PDT)
X-Received: by 2002:a05:6358:280b:b0:133:7c4:e752 with SMTP id
 k11-20020a056358280b00b0013307c4e752mr1534853rwb.26.1692181267730; Wed, 16
 Aug 2023 03:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230816094013.1275068-1-yangyingliang@huawei.com> <20230816094013.1275068-14-yangyingliang@huawei.com>
In-Reply-To: <20230816094013.1275068-14-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 12:20:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfov+UhdpapX4h-nANByUc9hAJY5aQmQB5+j4iFLyPgQ@mail.gmail.com>
Message-ID: <CAMuHMdXfov+UhdpapX4h-nANByUc9hAJY5aQmQB5+j4iFLyPgQ@mail.gmail.com>
Subject: Re: [PATCH -next 13/24] spi: rockchip: switch to use modern name
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Yang,

CC Heiko

On Wed, Aug 16, 2023 at 11:43 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
> Change legacy name master/slave to modern name host/target or controller.
>
> No functional changed.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for your patch!

> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -104,8 +104,8 @@
>  #define CR0_XFM_RO                                     0x2
>
>  #define CR0_OPM_OFFSET                         20
> -#define CR0_OPM_MASTER                         0x0
> -#define CR0_OPM_SLAVE                          0x1
> +#define CR0_OPM_HOST                           0x0
> +#define CR0_OPM_TARGET                         0x1
>
>  #define CR0_SOI_OFFSET                         23
>
> @@ -125,7 +125,7 @@
>  #define SR_TF_EMPTY                                    (1 << 2)
>  #define SR_RF_EMPTY                                    (1 << 3)
>  #define SR_RF_FULL                                     (1 << 4)
> -#define SR_SLAVE_TX_BUSY                               (1 << 5)
> +#define SR_TARGET_TX_BUSY                              (1 << 5)

I assume the register bit names come straight from the hardware
documentation, so you cannot just change them without making future
maintenance harder.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
