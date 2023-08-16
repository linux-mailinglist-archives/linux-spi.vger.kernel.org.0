Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0F877DEE5
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 12:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243519AbjHPKhe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 16 Aug 2023 06:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243923AbjHPKhR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 06:37:17 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6C52110;
        Wed, 16 Aug 2023 03:37:15 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-58cbdf3eecaso4228907b3.0;
        Wed, 16 Aug 2023 03:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692182234; x=1692787034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+kEdb4MrmJUs3I1p66ZT1RM9WxXbD2BUVc2Yvn8nt4=;
        b=EGO8l8ngtVmXjwOlk4OqktTr3ubwj5vrMimLrD60Mr6PybT0nXpIBUH7dONX229NzC
         PIS22HG01SJQjCaY6l8pZ/tYaHjwnT25+dVP+L1GvFCLiOphkbNPa6u7KFIPNi2ZlER3
         m/lYotEDJyCY2ENwqrfkcc7lldBqrdQh0LwME8MToDsnT0fpOTZkcb2+BKmyitQz8jnu
         WJoDI15XXK+NgieWmoXzU6QKBy7OKG/Z7p/KHMj14ePYIP63Dz1EUMgQUep8W3WoVuvz
         cYmyzz6iC+PFpuiUkSQ+aqDncTFJRf6V4xSkU3Gmedu88K1koDGFuX+87gdpByh6MIa6
         Je/g==
X-Gm-Message-State: AOJu0YzM4nowGk8BFeIsyV9tucn/w7gvZRCWMtKiGAkgUOcf7s6URrCt
        DPOJ42J0+jXeaHIO9AAaUHgX5ztXjXsHUQ==
X-Google-Smtp-Source: AGHT+IFqF8KYBLWA7CWcAneKilzmko+T3+HV3dVo/j1qUIkaxF6NpYhluxiAWIm0NZTTvuamN9BTbg==
X-Received: by 2002:a0d:cb8c:0:b0:589:e4aa:7b67 with SMTP id n134-20020a0dcb8c000000b00589e4aa7b67mr1264404ywd.41.1692182234645;
        Wed, 16 Aug 2023 03:37:14 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id v184-20020a0dd3c1000000b00586a3283e64sm3904923ywd.143.2023.08.16.03.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:37:14 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-583d702129cso68874117b3.3;
        Wed, 16 Aug 2023 03:37:14 -0700 (PDT)
X-Received: by 2002:a25:ab04:0:b0:d0d:102c:78a8 with SMTP id
 u4-20020a25ab04000000b00d0d102c78a8mr1118347ybi.31.1692182233947; Wed, 16 Aug
 2023 03:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230816094013.1275068-1-yangyingliang@huawei.com> <20230816094013.1275068-21-yangyingliang@huawei.com>
In-Reply-To: <20230816094013.1275068-21-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 12:37:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX9R5SQ_GSRhcfBH+UN0rxYP7NOeyrQSgZ3G6zY=zJnHA@mail.gmail.com>
Message-ID: <CAMuHMdX9R5SQ_GSRhcfBH+UN0rxYP7NOeyrQSgZ3G6zY=zJnHA@mail.gmail.com>
Subject: Re: [PATCH -next 20/24] spi: sh-msiof: switch to use modern name
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
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

On Wed, Aug 16, 2023 at 11:43 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
> Change legacy name master/slave to modern name host/target.
>
> No functional changed.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for your patch!

> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -79,7 +79,7 @@ struct sh_msiof_spi_priv {
>  #define SIRFDR 0x60    /* Receive FIFO Data Register */
>
>  /* SITMDR1 and SIRMDR1 */
> -#define SIMDR1_TRMD            BIT(31)         /* Transfer Mode (1 = Master mode) */
> +#define SIMDR1_TRMD            BIT(31)         /* Transfer Mode (1 = Host mode) */

Please do not change this register bit definition nor the comment, as
they match Rev 0.81 of the R-Car V4H Series Hardware User's Manual.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
