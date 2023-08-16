Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1F77DE9F
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 12:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbjHPK2W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 16 Aug 2023 06:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243414AbjHPK2A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 06:28:00 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B58819A7
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:27:59 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-589e590af61so47155537b3.0
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181678; x=1692786478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUj/06hk3ZpaiwNTOKTG6o8EBE/qHiq2Qm3AZ/Onl14=;
        b=R/NCF0Fugk80ybPq7s6t2/kFzbKlrytsC1sNcjAGz+lnKeiv8N5Av5RdgMKFjIYRpk
         ssTIz6V9BUQ6XR6aRT9kudkyUXU/1Yvj42h63ITP5vAiuBg/0oRNGkZlWYJKTHoCcbz7
         geE3tIVSNWKmsn52MkdmM/iGKCnWx5pq9i28OTgvVDo9rYFYR+GlaR1Mc4uZvxVUQ2dk
         RD/WIUDTgV3p1YAbkUh2xPNqy+JVL4HtR3sBaff5z4X3bqj86hO6UZzF39rLTScEjVTv
         5Fyufr/qDYD/RGcyJlTOnhkLlEmDAXn11qm3uZFoQ/NXovK3Edyz+NNFaHfGh0eeM0hT
         IYPA==
X-Gm-Message-State: AOJu0Yx9dKnlI2UoQTslmxCHxuOeJjmKtZRde42JxZ3eiXk7JG8MiwU4
        hGuOAlC00UdiRLjJdauQYaKH+SFvsDTzUQ==
X-Google-Smtp-Source: AGHT+IFpxJpCrhIsufuYfQ8RU0y6YXBM2wlYPFz2Y0NHtBioVifiumWPNVKNPkOOV69oJv7z66uPPA==
X-Received: by 2002:a25:dc6:0:b0:cb2:7e6:191c with SMTP id 189-20020a250dc6000000b00cb207e6191cmr1668994ybn.20.1692181678405;
        Wed, 16 Aug 2023 03:27:58 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id a81-20020a254d54000000b00d0069942a3esm3429792ybb.43.2023.08.16.03.27.58
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:27:58 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d299ed34bacso10398828276.1
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:27:58 -0700 (PDT)
X-Received: by 2002:a25:ac63:0:b0:d71:6835:c250 with SMTP id
 r35-20020a25ac63000000b00d716835c250mr1580616ybd.30.1692181678006; Wed, 16
 Aug 2023 03:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230816094013.1275068-1-yangyingliang@huawei.com> <20230816094013.1275068-18-yangyingliang@huawei.com>
In-Reply-To: <20230816094013.1275068-18-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 12:27:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWM2ZenmJan31vXrc_=uu9_uYTaXw+ccj7TUv3FtYBOmQ@mail.gmail.com>
Message-ID: <CAMuHMdWM2ZenmJan31vXrc_=uu9_uYTaXw+ccj7TUv3FtYBOmQ@mail.gmail.com>
Subject: Re: [PATCH -next 17/24] spi: s3c64xx: switch to use modern name
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de,
        Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
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

CC Andi, Krzysztof, Alim

On Wed, Aug 16, 2023 at 11:43 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
> Change legacy name master/slave to modern name host/target or controller.
>
> No functional changed.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for your patch!

> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -38,7 +38,7 @@
>
>  #define S3C64XX_SPI_CH_HS_EN           (1<<6)  /* High Speed Enable */
>  #define S3C64XX_SPI_CH_SW_RST          (1<<5)
> -#define S3C64XX_SPI_CH_SLAVE           (1<<4)
> +#define S3C64XX_SPI_CH_TARGET          (1<<4)

I assume the register bit name comes straight from the hardware
documentation, so you cannot just change it without making future
maintenance harder.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
