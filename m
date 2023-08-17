Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F330877FB20
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 17:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbjHQPr2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 17 Aug 2023 11:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353326AbjHQPrB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 11:47:01 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043930D1
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:47:00 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4ff9bbc83a5so1261618e87.1
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692287216; x=1692892016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/Ly13ccSyssMxAYR4202e2HlgIzeBfXRkynOaexbag=;
        b=hvGmkCBi0APOmCinQygqZ1Vpz1HwkHR7J5tjq8hDUdOkvkvQB6ggNAb7b4WO9WUMsN
         Vsj2+c3V5oCYYna520E0RqUrtBHqeJZ/eA5428xbzKAC/qATWEBEd3PcPevbgUNkP9/Q
         Cb1umJYA2LJqiAfmp9Nt3DNApd0QQclKYeVJlMeh6K1o6HfsuLUbou+GQ9f64RTC/Epx
         u4QBNpuJQ+aaa+6+rhcGdC9sQDr8WTyYUBfBUSCX5CXYmjN9jFboc/UW099bMT2/oTS7
         WHOYcPkMHMnEGDEdin5baPY9LUzW5XVRJWkxctTkTqWTPqLmck3ein0UsIFjUfBHulrP
         ZOsQ==
X-Gm-Message-State: AOJu0Yxm08epa4x/wlcHu6rW6N/fFmhUmYHuDGhdecD15y2TOv9JI4eQ
        /ARhHsOhkCCwcZXcWnvS+WXTEmh8Wjpw42Sq
X-Google-Smtp-Source: AGHT+IEQx/pCfqhCU+oQVcfupc9tjM9LvWvK7wk9ccOt6RvUoGD6W5Rosr3CXDuTouma4+5yhSe42A==
X-Received: by 2002:a19:520b:0:b0:4fe:82a7:814f with SMTP id m11-20020a19520b000000b004fe82a7814fmr4032537lfb.37.1692287216131;
        Thu, 17 Aug 2023 08:46:56 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p14-20020ac246ce000000b004f9fdb0ed8esm3454224lfo.304.2023.08.17.08.46.55
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 08:46:55 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so11932822e87.3
        for <linux-spi@vger.kernel.org>; Thu, 17 Aug 2023 08:46:55 -0700 (PDT)
X-Received: by 2002:a19:5e01:0:b0:4ff:8805:d863 with SMTP id
 s1-20020a195e01000000b004ff8805d863mr3263972lfb.61.1692287215491; Thu, 17 Aug
 2023 08:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230817050332.1274751-1-yangyingliang@huawei.com> <20230817050332.1274751-20-yangyingliang@huawei.com>
In-Reply-To: <20230817050332.1274751-20-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Aug 2023 17:46:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVfrTToyRDvGQ=XUnY-bUXedQ41e-zE8athrOW0rLCf_w@mail.gmail.com>
Message-ID: <CAMuHMdVfrTToyRDvGQ=XUnY-bUXedQ41e-zE8athrOW0rLCf_w@mail.gmail.com>
Subject: Re: [PATCH -next v2 19/23] spi: sh-msiof: switch to use modern name
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

On Thu, Aug 17, 2023 at 7:07 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> Change legacy name master/slave to modern name host/target.
>
> No functional changed.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for your patch!

> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c

> @@ -1175,7 +1175,7 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
>         struct device *tx_dev, *rx_dev;
>
>         if (dev->of_node) {
> -               /* In the OF case we will get the slave IDs from the DT */
> +               /* In the OF case we will get the target IDs from the DT */

This comment refers to DMA slave IDs, so it should not be changed (yet).

>                 dma_tx_id = 0;
>                 dma_rx_id = 0;
>         } else if (info && info->dma_tx_id && info->dma_rx_id) {

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
