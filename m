Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C8677DE97
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 12:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243882AbjHPK0M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 16 Aug 2023 06:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbjHPKZw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 06:25:52 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239BD19A1
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:25:51 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so6015853276.2
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181550; x=1692786350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvbBgTkLsFBKAOgdFoJMNDPf69rlDJ7/pbi07TqIWn4=;
        b=c+4G6/I/jZhTs+yqZW5BAZhm6ZOgowpoMSesL8zPeuQr1V5cJilVwld2VCQAzxJj9S
         O3QObrKrRTa6FldCMB03FyQr9OPg4/f1UQqwXoukiEx03964bn5Bh5gYMx+XARi331+O
         9ThxY8QTxs2hkbYfBicxoPsYztGfLMiBzjhPT8UDu1+9BMl97pKvEixZE+YOimLT9GzX
         O+SVGQmW3f49ce8ZsMwmqngjwIIfxObBemm+ms4alnINWf94FrwY1jA5nL0bhzM5YVd+
         3zzM3V9ixX28WXFNdOoX+NEM9zvGN7C2KxuY7GXlheDAMj3pJTCXLXUwZf1u4QTKXibs
         Bdew==
X-Gm-Message-State: AOJu0YxwGMi+dLR5ZjFvEqTmpdbKBpqkQjLUFMzbvKJzUDD+pBPp60g6
        EBvZ7LW1wLiuAyQpqTeY1FvPsgZIJI3Q/g==
X-Google-Smtp-Source: AGHT+IGhKNyqjWFKmU4r4gawIbXU/JdqC4+iVoj4SWz7k8idA/R20UpmkWG4DRVp7ibmUcyKIwNL2g==
X-Received: by 2002:a25:230a:0:b0:d69:fe0f:de52 with SMTP id j10-20020a25230a000000b00d69fe0fde52mr1081005ybj.51.1692181550016;
        Wed, 16 Aug 2023 03:25:50 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id n196-20020a25d6cd000000b00d32135938c1sm3386424ybg.26.2023.08.16.03.25.49
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:25:49 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-58c5aecea4eso15101397b3.3
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:25:49 -0700 (PDT)
X-Received: by 2002:a25:d702:0:b0:c3c:5eb1:e975 with SMTP id
 o2-20020a25d702000000b00c3c5eb1e975mr1098570ybg.47.1692181549369; Wed, 16 Aug
 2023 03:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230816094013.1275068-1-yangyingliang@huawei.com> <20230816094013.1275068-17-yangyingliang@huawei.com>
In-Reply-To: <20230816094013.1275068-17-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 12:25:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU91fDpwK2ttAi0gY-G_sg3wiqNpQxhGgYYWHv5PXmwUg@mail.gmail.com>
Message-ID: <CAMuHMdU91fDpwK2ttAi0gY-G_sg3wiqNpQxhGgYYWHv5PXmwUg@mail.gmail.com>
Subject: Re: [PATCH -next 16/24] spi: rzv2m-csi: switch to use modern name
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de
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

> --- a/drivers/spi/spi-rzv2m-csi.c
> +++ b/drivers/spi/spi-rzv2m-csi.c
> @@ -41,7 +41,7 @@
>  #define CSI_CLKSEL_CKP         BIT(17)
>  #define CSI_CLKSEL_DAP         BIT(16)
>  #define CSI_CLKSEL_MODE                (CSI_CLKSEL_CKP|CSI_CLKSEL_DAP)
> -#define CSI_CLKSEL_SLAVE       BIT(15)
> +#define CSI_CLKSEL_TARGET      BIT(15)

Please do not change this register bit definition, as its name matches
Rev. 1.30 of the RZ/V2M Hardware User's Manual.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
