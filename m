Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917AF77DF05
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 12:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242877AbjHPKmX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 16 Aug 2023 06:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243996AbjHPKmK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 06:42:10 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417C22135;
        Wed, 16 Aug 2023 03:42:00 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-589d7755213so42704647b3.2;
        Wed, 16 Aug 2023 03:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692182519; x=1692787319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjooYlfG2n2Y0uOGJPbxJ2rDRMjkL/VsMoli4wJTmcI=;
        b=QPovr1uqBcTIwgqzqJvqBZ9acrBWrzaPcjs7yNWz4y9Qu00dyRi5gKmuyy3UmyWV/7
         86uNqOb8+LYLhuw9jkxTI/KJrS2Ph/n34WQ2S+z+yyZEuJD1ERGMi/1mXH0J1VZF4KFj
         /3OfDE7MdGkm4rhtjVj0uTeDOxtFFrk45hxDrNXWMPbZuPf1+KPwWRGe21E+eN28l9d9
         ojxBLEgMz2gCEwi5fK4WMNO219lh0iq8a9yhnahm6fk8mZCcObCULWglolt8jV9bppT1
         PlrxtPz8ASbnr2NEe0XLbzoiF+1k355Uz0kz6JoWPMMoWysoRX3Bh6mUzDY8hS5aMi3X
         xriw==
X-Gm-Message-State: AOJu0YwBIzqJTgbSzP4UDkJtw2nwZ2EG3e9YCp8XuOo25BrYr1LF3PJP
        Zq6HEclhUV4dlbANxnIpQKGP8dHX9tLm3Q==
X-Google-Smtp-Source: AGHT+IE0dBJF+Tux5a60NaUuZ2hDiHQb21amCP41W1Vhhdd4YRL8NOEnMIXippqPyaFJHx3V9UtjoA==
X-Received: by 2002:a81:4ed1:0:b0:561:c5d4:ee31 with SMTP id c200-20020a814ed1000000b00561c5d4ee31mr1423008ywb.38.1692182519247;
        Wed, 16 Aug 2023 03:41:59 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id i65-20020a0df844000000b005773afca47bsm3943177ywf.27.2023.08.16.03.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:41:59 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d6b0c2cca0aso2716771276.0;
        Wed, 16 Aug 2023 03:41:59 -0700 (PDT)
X-Received: by 2002:a25:f622:0:b0:d62:9b77:a41a with SMTP id
 t34-20020a25f622000000b00d629b77a41amr1308873ybd.31.1692182518870; Wed, 16
 Aug 2023 03:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230816094013.1275068-1-yangyingliang@huawei.com> <20230816094013.1275068-20-yangyingliang@huawei.com>
In-Reply-To: <20230816094013.1275068-20-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 12:41:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZq8CPLe6UK_igvGytkD7NcChZ1tCU+C4qSLy6Cd8grw@mail.gmail.com>
Message-ID: <CAMuHMdUZq8CPLe6UK_igvGytkD7NcChZ1tCU+C4qSLy6Cd8grw@mail.gmail.com>
Subject: Re: [PATCH -next 19/24] spi: sh-hspi: switch to use modern name
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
> Change legacy name master to modern name host.
>
> No functional changed.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for your patch!

> --- a/drivers/spi/spi-sh-hspi.c
> +++ b/drivers/spi/spi-sh-hspi.c

> @@ -137,7 +137,7 @@ static void hspi_hw_setup(struct hspi_priv *hspi,
>
>         hspi_write(hspi, SPCR, spcr);
>         hspi_write(hspi, SPSR, 0x0);
> -       hspi_write(hspi, SPSCR, 0x21);  /* master mode / CS control */
> +       hspi_write(hspi, SPSCR, 0x21);  /* host mode / CS control */

Please do not change this comment, as it matches the register bit
documentation in Rev. 1.00 of the  R-Car H1 Hardware User's Manual.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
