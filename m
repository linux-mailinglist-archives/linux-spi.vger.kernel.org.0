Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A3B5115E9
	for <lists+linux-spi@lfdr.de>; Wed, 27 Apr 2022 13:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiD0Kyz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Apr 2022 06:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiD0Kyz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Apr 2022 06:54:55 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593049FF92;
        Wed, 27 Apr 2022 03:27:05 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id z126so947906qkb.2;
        Wed, 27 Apr 2022 03:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8fheWnmjASQpGr52DX1eSSjcY85tX/RgUM6t+KFdYg=;
        b=5k3DUvWH28hQhA8ypY4LIMyNr807u1rLbm6h2GrQaujvl7mgQR9at+w18rs7EQDYE+
         qzkU/MrV+TRQVUJBxH++DlmTOgD1IZmjcJUcspVBi/USj4LF2S/aKmhLitiBil06OQt3
         dV7I1uIkLIaC/3lMlJS66cFTFu2s/sKZXM9Xa3HJP8WWPQEbaissrG4ZhsrnYObOY+7b
         HJYJAHRjQKtC57M+j6doHJCbt3q470+3hR0zOIhKBXTDWZJCpoFUBHG4r9/k6FbORzQF
         9xbZ/VR4ihFC3jAOs6pfG/DDXIqtMVwlM+hCKrQH1L8U8dp4d9mP8k5GsVF63GsaFWKK
         uU6A==
X-Gm-Message-State: AOAM532GwStY2zGK0QyAebHKguTsAu+HcXqX86+ndwupbkZVkYJwh+C8
        i4OLp6HWNb1+doAGcYYBt5ptSi4Y7Z0hkw==
X-Google-Smtp-Source: ABdhPJw/Ld8AKlAAL0z9/PLZ3Y5dLWyB+9MXvxUmkIcGlCvzjsXWaqLg6DlUtEcFSS4/BqjCN+39qA==
X-Received: by 2002:a37:b442:0:b0:69a:fc75:ca52 with SMTP id d63-20020a37b442000000b0069afc75ca52mr15594682qkf.730.1651055224355;
        Wed, 27 Apr 2022 03:27:04 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id r12-20020ac85e8c000000b002f36944423bsm4851726qtx.87.2022.04.27.03.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 03:27:04 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id w187so2541095ybe.2;
        Wed, 27 Apr 2022 03:27:03 -0700 (PDT)
X-Received: by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr24921293ybq.342.1651055223642; Wed, 27
 Apr 2022 03:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210818165604.22127-1-zhengxunli.mxic@gmail.com> <CAMuHMdWUVVnZXc4iXrkpyLFpr9w5X-EzuwvvFGQYAp+0=ZJbqw@mail.gmail.com>
In-Reply-To: <CAMuHMdWUVVnZXc4iXrkpyLFpr9w5X-EzuwvvFGQYAp+0=ZJbqw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Apr 2022 12:26:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpvuC2Cm41jCQm+rT8MZB5GN+Z0bPz941QzsHX17Ux-g@mail.gmail.com>
Message-ID: <CAMuHMdWpvuC2Cm41jCQm+rT8MZB5GN+Z0bPz941QzsHX17Ux-g@mail.gmail.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix missing setting address
To:     Zhengxun <zhengxunli.mxic@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        zhengxunli <zhengxunli@mxic.com.tw>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Mon, Aug 23, 2021 at 1:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> CC sergey's new address
>
> On Wed, Aug 18, 2021 at 10:57 AM Zhengxun <zhengxunli.mxic@gmail.com> wrote:
> > In the RPC manual mode, if the data direction is not set
> > (such as the flash erase command), the address misses the
> > setting.
> >
> > Signed-off-by: Zhengxun <zhengxunli.mxic@gmail.com>
> > ---
> >  drivers/memory/renesas-rpc-if.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
> > index 45eed659b0c6..9dd27c6307f7 100644
> > --- a/drivers/memory/renesas-rpc-if.c
> > +++ b/drivers/memory/renesas-rpc-if.c
> > @@ -482,6 +482,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
> >                 }
> >                 break;
> >         default:
> > +               regmap_write(rpc->regmap, RPCIF_SMADR, rpc->smadr);
> >                 regmap_write(rpc->regmap, RPCIF_SMENR, rpc->enable);
> >                 regmap_write(rpc->regmap, RPCIF_SMCR,
> >                              rpc->smcr | RPCIF_SMCR_SPIE);

This patch never received review comments.
As of commit fff53a551db50f5e ("memory: renesas-rpc-if: Correct QSPI
data transfer in Manual mode") in v5.16-rc1, RPCIF_SMADR is written
before the switch() statement, hence this patch can be ignored.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
