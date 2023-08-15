Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8004577CBD6
	for <lists+linux-spi@lfdr.de>; Tue, 15 Aug 2023 13:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbjHOLhE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 15 Aug 2023 07:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbjHOLgv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Aug 2023 07:36:51 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0B110C0
        for <linux-spi@vger.kernel.org>; Tue, 15 Aug 2023 04:36:50 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5862a6ae535so50792717b3.0
        for <linux-spi@vger.kernel.org>; Tue, 15 Aug 2023 04:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692099410; x=1692704210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mN58ZsYYVSBJMFJ6O0Ukpdq1fgdVkBczutt4xwbGw6Q=;
        b=U+Wu4Rx7jZ2EXtzz2+0iRXjsBYGzz880Gp+xHM4vnk13itlZJPvwknsYS+CGSHYeuJ
         ioGWOZAL1pFxBs3w/Zp8xBRQGDfEpwjOLxci7B2HeD6Zc/PiM/lDpMZ5K8v6EDDXkhl6
         zd1c6IG4LaWlXbYhLlT7IW3Lfiq2LubN5MybTg+j/rZjaYSyRa+aRi63/nIEtZRuZr2W
         GtsUzGKKSmENIHSZ5+wQ/FZW+OINySdCCA5ob92QuUWrepEq6jrx9GieHP0LPRy3Kph3
         UPbW6/9MI3FGvS+4X8Vu0FR4Cp6lb4aNRPFPd2FlRP475ERxJSHc2tlCbzGJ1VyDPKAX
         h+og==
X-Gm-Message-State: AOJu0Ywnv4J7et2aBd0Ixoe0xgTrq1vDa7JJre8v1axlktl0Qm+mwmRG
        PpTqox6hHsIwJyj34nt4pPZgYGVdYQOhYA==
X-Google-Smtp-Source: AGHT+IFLOF/TexDMYIJ7DPefvstR/ifsHVmjbHfX73E+Dn78xln8dI/+/ec+dIo3QS/Nfr5WxlHBpw==
X-Received: by 2002:a0d:fb46:0:b0:586:6a71:b018 with SMTP id l67-20020a0dfb46000000b005866a71b018mr11025157ywf.20.1692099408820;
        Tue, 15 Aug 2023 04:36:48 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id q65-20020a818044000000b00589b653b7adsm3154782ywf.136.2023.08.15.04.36.46
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 04:36:46 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d3563cb41e9so3912760276.0
        for <linux-spi@vger.kernel.org>; Tue, 15 Aug 2023 04:36:46 -0700 (PDT)
X-Received: by 2002:a25:250e:0:b0:d44:a90b:ba4d with SMTP id
 l14-20020a25250e000000b00d44a90bba4dmr9783333ybl.46.1692099406267; Tue, 15
 Aug 2023 04:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230807140717.3484180-1-yangyingliang@huawei.com> <20230807140717.3484180-20-yangyingliang@huawei.com>
In-Reply-To: <20230807140717.3484180-20-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Aug 2023 13:36:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU7Q1Nps0b2543wx5BT_X2dU7HBwFm6YKEs0g6bmyaYww@mail.gmail.com>
Message-ID: <CAMuHMdU7Q1Nps0b2543wx5BT_X2dU7HBwFm6YKEs0g6bmyaYww@mail.gmail.com>
Subject: Re: [PATCH -next v2 19/21] spi: dw: switch to use modern name
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Yang,

On Mon, Aug 7, 2023 at 4:10 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> Change legacy name master to modern name host or controller.
>
> No functional changed.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for your patch, which is now commit eefc6c5c2451126c ("spi:
dw: switch to use modern name") in spi/for-next.

> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -68,7 +68,7 @@ struct dw_spi_mscc {
>                 ((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
>
>  /*
> - * The Designware SPI controller (referred to as master in the documentation)
> + * The Designware SPI controller (referred to as host in the documentation)
>   * automatically deasserts chip select when the tx fifo is empty. The chip
>   * selects then needs to be either driven as GPIOs or, for the first 4 using
>   * the SPI boot controller registers. the final chip select is an OR gate

Have you verified that Synopsys did update the documentation for the
Designware SPI controller?  If not, I think it's prudent to keep the
old name.

> @@ -142,14 +142,14 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
>  }
>
>  /*
> - * The Designware SPI controller (referred to as master in the
> + * The Designware SPI controller (referred to as host in the

Likewise.

>   * documentation) automatically deasserts chip select when the tx fifo
>   * is empty. The chip selects then needs to be driven by a CS override
>   * register. enable is an active low signal.
>   */
>  static void dw_spi_sparx5_set_cs(struct spi_device *spi, bool enable)
>  {


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
