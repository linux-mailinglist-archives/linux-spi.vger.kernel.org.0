Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F225177DB0A
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 09:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbjHPHSX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 16 Aug 2023 03:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242441AbjHPHSL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 03:18:11 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D67269F
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 00:18:06 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-589f2fb1a88so31284907b3.2
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 00:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692170285; x=1692775085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aianph52HWLLcJ8SFEbNqBRQjpEFqBOvyEh+HcttSkE=;
        b=OFlwBzusccByvOZZL+gBx0qR+Z+aQg4BDFtIzvRcaM0C/2ExvS54lgqUjGvUnfOuot
         snTd9SKgB7s4YeoKuXpALLyxJRh8oGMgefjhbTGdcWF6pm5Anew66B3MbjDPxmKffFVo
         5NlGo8q/CybekJibiaIRboKLyABwOYXqe4Eu9ow0NR1xn9+/zKfCLZH5xqvR+GDfVchf
         R4tm/Z1jWgVC1uv4Uu8ovdPiSyLn1M0VEkRORgXqqGNCnZlWq7qJqmeBg8R8HhLgoxOl
         8oAB2Ljh4UArAO4s6LY5ORY2LGO3G7+V/LhMB2/C2EQtmn1aOKR+pPshQf8gXqhQnCFE
         M6FQ==
X-Gm-Message-State: AOJu0YxEbMJyv5F7UxSt5mDF4AQHlayhR4gRWbYPG0dk7ncmDGs1q3a+
        jBgN/HP0MOieWkPtQMnbQLmoLsI9opZ3EA==
X-Google-Smtp-Source: AGHT+IEgMMzb05Nm0RbHny6UNXKoqtR+rVIE9VuUXR/9YFVqQg2/Ji6m/kuIkRwNU3DtmB58edgMaQ==
X-Received: by 2002:a0d:db4c:0:b0:583:b72c:883b with SMTP id d73-20020a0ddb4c000000b00583b72c883bmr936350ywe.11.1692170285273;
        Wed, 16 Aug 2023 00:18:05 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id m185-20020a0dcac2000000b00585e2c112fdsm3860009ywd.111.2023.08.16.00.18.04
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 00:18:04 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d6b1025fc7aso2612071276.3
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 00:18:04 -0700 (PDT)
X-Received: by 2002:a25:40f:0:b0:d63:1cdd:c98 with SMTP id 15-20020a25040f000000b00d631cdd0c98mr841471ybe.12.1692170284714;
 Wed, 16 Aug 2023 00:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230807140717.3484180-1-yangyingliang@huawei.com>
 <20230807140717.3484180-20-yangyingliang@huawei.com> <CAMuHMdU7Q1Nps0b2543wx5BT_X2dU7HBwFm6YKEs0g6bmyaYww@mail.gmail.com>
 <a604b778-5dab-abaf-4c81-e10f7c23374c@huawei.com>
In-Reply-To: <a604b778-5dab-abaf-4c81-e10f7c23374c@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 09:17:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU0akTNec7z_aAw=i_NO8j-j0Q_XsRiYhnnPj53qLneug@mail.gmail.com>
Message-ID: <CAMuHMdU0akTNec7z_aAw=i_NO8j-j0Q_XsRiYhnnPj53qLneug@mail.gmail.com>
Subject: Re: [PATCH -next v2 19/21] spi: dw: switch to use modern name
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     fancer.lancer@gmail.com, linux-spi@vger.kernel.org,
        broonie@kernel.org, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Yang,

On Wed, Aug 16, 2023 at 5:45 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> On 2023/8/15 19:36, Geert Uytterhoeven wrote:
> > On Mon, Aug 7, 2023 at 4:10 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> >> Change legacy name master to modern name host or controller.
> >>
> >> No functional changed.
> >>
> >> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > Thanks for your patch, which is now commit eefc6c5c2451126c ("spi:
> > dw: switch to use modern name") in spi/for-next.
> >
> >> --- a/drivers/spi/spi-dw-mmio.c
> >> +++ b/drivers/spi/spi-dw-mmio.c
> >> @@ -68,7 +68,7 @@ struct dw_spi_mscc {
> >>                  ((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
> >>
> >>   /*
> >> - * The Designware SPI controller (referred to as master in the documentation)
> >> + * The Designware SPI controller (referred to as host in the documentation)
> >>    * automatically deasserts chip select when the tx fifo is empty. The chip
> >>    * selects then needs to be either driven as GPIOs or, for the first 4 using
> >>    * the SPI boot controller registers. the final chip select is an OR gate
> > Have you verified that Synopsys did update the documentation for the
> > Designware SPI controller?  If not, I think it's prudent to keep the
> > old name.
>
> I'm trying to rename the legacy name(master/slave) to modern
> name(host/target) used in SPI drivers,
> is it ok to change this comment master to host ?

That depends on the (external) documentation this comment refers
to.  If that documentation refers to master, you must not change
the comment.

https://www.synopsys.com/dw/ipdir.php?ds=amba_ssi offers a download
link which is supposed to allow you to download this documentation
after registration, but unfortunately that process doesn't seem to work
(it just takes me back to the same page).

> >> @@ -142,14 +142,14 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
> >>   }
> >>
> >>   /*
> >> - * The Designware SPI controller (referred to as master in the
> >> + * The Designware SPI controller (referred to as host in the
> > Likewise.
> >
> >>    * documentation) automatically deasserts chip select when the tx fifo
> >>    * is empty. The chip selects then needs to be driven by a CS override
> >>    * register. enable is an active low signal.
> >>    */
> >>   static void dw_spi_sparx5_set_cs(struct spi_device *spi, bool enable)
> >>   {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
