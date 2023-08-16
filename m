Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BE077DEDC
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 12:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbjHPKeu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 16 Aug 2023 06:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbjHPKeR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 06:34:17 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4BB2117;
        Wed, 16 Aug 2023 03:34:15 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6bd04558784so5474117a34.3;
        Wed, 16 Aug 2023 03:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692182054; x=1692786854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4y4qkdot/vHgUsb1GVrCkyqsy0MKvIDYNr9DRrUqgjs=;
        b=eEmcureKQwih2b9FP2XC8h7FZf0U/c764o5P0Ez2eoxdR2rxbCIB50eyC7jHi+JfDM
         j7pO4a1tsxiE1dCAVu8ObQD1ul0aDjRAJ71lrGgqL9cELoeTwo3rnOmSzMz66JNfp8nn
         VSOaQs+7wp9MxnHeD+5qr5YT0Xvz3IR6+6GRBP9ijyuq3NXOe/5lmnxbgiPIHSSQoalV
         05SredGkOHbFB/xTQ35KOXsFWFNg/swguSjMe2fU6EvjfRvJqWeMjhefjItHwUZQaNGK
         bMZbYLnOOHTkmZSgIwhGKdEh6DQBT/3JWQBiwXej+IGCX+cA98fvApVpdRV110FjkNne
         RsZA==
X-Gm-Message-State: AOJu0Yxxkyoi4taeJpzNvW5pHH7XPl3QoMGoMtndV8CqwHef/+hqmJJ0
        VokoxfbXVsQoIrBtW3ISTkbBiq3dLQKblQ==
X-Google-Smtp-Source: AGHT+IHYBFkmK/5jHHreVKRcRKHn6EMLlBxLIx7joADIU8U/NLZ1vyhBx//PnWN5/VzppXWfCkC6FA==
X-Received: by 2002:a9d:7dcb:0:b0:6bd:63a:1a7f with SMTP id k11-20020a9d7dcb000000b006bd063a1a7fmr1584891otn.27.1692182054569;
        Wed, 16 Aug 2023 03:34:14 -0700 (PDT)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id w13-20020a9d674d000000b006b8a0c7e14asm5929085otm.55.2023.08.16.03.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:34:14 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-56c711a88e8so4672767eaf.2;
        Wed, 16 Aug 2023 03:34:14 -0700 (PDT)
X-Received: by 2002:a05:6358:89c:b0:135:96fa:bff3 with SMTP id
 m28-20020a056358089c00b0013596fabff3mr2224699rwj.4.1692182054046; Wed, 16 Aug
 2023 03:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230816094013.1275068-1-yangyingliang@huawei.com> <20230816094013.1275068-16-yangyingliang@huawei.com>
In-Reply-To: <20230816094013.1275068-16-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 12:34:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUAi2f5XdGJpoyYF2Q5o0vxzwzKxZ-fbVan2LD+8TDqhw@mail.gmail.com>
Message-ID: <CAMuHMdUAi2f5XdGJpoyYF2Q5o0vxzwzKxZ-fbVan2LD+8TDqhw@mail.gmail.com>
Subject: Re: [PATCH -next 15/24] spi: rspi: switch to use modern name
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -71,7 +71,7 @@
>  #define SPCR_SPE               0x40    /* Function Enable */
>  #define SPCR_SPTIE             0x20    /* Transmit Interrupt Enable */
>  #define SPCR_SPEIE             0x10    /* Error Interrupt Enable */
> -#define SPCR_MSTR              0x08    /* Master/Slave Mode Select */
> +#define SPCR_MSTR              0x08    /* Host/Target Mode Select */

Please do not change this register bit definition nor the comment, as
they match Rev 2.00 of the R-Car Series, 2nd Generation, and Rev. 1.30
of the RZ/G2L{,C} Group Hardware User's Manual.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
