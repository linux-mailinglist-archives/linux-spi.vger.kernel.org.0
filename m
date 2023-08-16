Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C2E77DE14
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243644AbjHPKD2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 16 Aug 2023 06:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243719AbjHPKDR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 06:03:17 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F5AC1
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:03:16 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-58c531d9a4aso27826637b3.1
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692180195; x=1692784995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sN9EQKf5x12CNCv30z0eOeJhjbvjff60jp7G9xoDDUo=;
        b=M5Whw952jJxDBOsNqU4S5rW8UuTd1krAT40C+AR3BDN4LWW1BPUpg72mgS2IUo94TU
         4g06mfd39EGGDfBgIXlndutchDtIsX4lxvQnyVpgLxEW7XVxJjHcIHZEqKKBpQPi/jJL
         t/BviJ9yX9tdUUab3hM9bbjoKP9XLoe5ShMfEDcnNDUmgPlFDPtAeAYQ3sYfA85QQBOw
         rkZFdyhRddFb5QdV6OQlOklIKkzkLjv1Y/PpRjX7xUnlUTTJBSkYXmfsU2iFCsAgT3NF
         ejmfEutNIdAt8KBKOif8JxoNy1IgfztqWjKPxt4Z1ET3JUCPnOw3T0xXgwgyA/tOgzMb
         B50g==
X-Gm-Message-State: AOJu0Yy0rgw3qyZOKe+TtvzD5zD7/X3HCPehYBCZWLieRytZ39NG13Z0
        iK17xh/BjNLLiJfPepx8tt8YNhSex5gu9Q==
X-Google-Smtp-Source: AGHT+IGAE5u+eojbCxyObXjgXiYZPLsLtFVLBy0HMw5cfY7zzfgudNzLLArxob9AtstUgp3iWwVoZw==
X-Received: by 2002:a81:a014:0:b0:56d:1ca0:fa55 with SMTP id x20-20020a81a014000000b0056d1ca0fa55mr1475144ywg.25.1692180195347;
        Wed, 16 Aug 2023 03:03:15 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id t12-20020a81830c000000b005772abf6234sm3915250ywf.11.2023.08.16.03.03.14
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:03:14 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d678b44d1f3so6482030276.0
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 03:03:14 -0700 (PDT)
X-Received: by 2002:a25:e912:0:b0:d47:3fcc:9911 with SMTP id
 n18-20020a25e912000000b00d473fcc9911mr1901811ybd.2.1692180194463; Wed, 16 Aug
 2023 03:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230807140717.3484180-1-yangyingliang@huawei.com>
 <20230807140717.3484180-20-yangyingliang@huawei.com> <CAMuHMdU7Q1Nps0b2543wx5BT_X2dU7HBwFm6YKEs0g6bmyaYww@mail.gmail.com>
 <a604b778-5dab-abaf-4c81-e10f7c23374c@huawei.com> <CAMuHMdU0akTNec7z_aAw=i_NO8j-j0Q_XsRiYhnnPj53qLneug@mail.gmail.com>
 <hq4k5y6el34vghqrfrg4sjgpvnw32fqyqlwfahypu4m4hoodfj@x4sprdm22b7s>
In-Reply-To: <hq4k5y6el34vghqrfrg4sjgpvnw32fqyqlwfahypu4m4hoodfj@x4sprdm22b7s>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 12:03:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQJ4v652mnoQoPF3fv2AJJiKWemT4=E757nPA1OuPSQw@mail.gmail.com>
Message-ID: <CAMuHMdWQJ4v652mnoQoPF3fv2AJJiKWemT4=E757nPA1OuPSQw@mail.gmail.com>
Subject: Re: [PATCH -next v2 19/21] spi: dw: switch to use modern name
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de
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

Hi Serge,

On Wed, Aug 16, 2023 at 11:38 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> On Wed, Aug 16, 2023 at 09:17:52AM +0200, Geert Uytterhoeven wrote:
> > On Wed, Aug 16, 2023 at 5:45 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> > > On 2023/8/15 19:36, Geert Uytterhoeven wrote:
> > > > On Mon, Aug 7, 2023 at 4:10 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> > > >> Change legacy name master to modern name host or controller.
> > > >>
> > > >> No functional changed.
> > > >>
> > > >> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > > Thanks for your patch, which is now commit eefc6c5c2451126c ("spi:
> > > > dw: switch to use modern name") in spi/for-next.
> > > >
> > > >> --- a/drivers/spi/spi-dw-mmio.c
> > > >> +++ b/drivers/spi/spi-dw-mmio.c
> > > >> @@ -68,7 +68,7 @@ struct dw_spi_mscc {
> > > >>                  ((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
> > > >>
> > > >>   /*
> > > >> - * The Designware SPI controller (referred to as master in the documentation)
> > > >> + * The Designware SPI controller (referred to as host in the documentation)
> > > >>    * automatically deasserts chip select when the tx fifo is empty. The chip
> > > >>    * selects then needs to be either driven as GPIOs or, for the first 4 using
> > > >>    * the SPI boot controller registers. the final chip select is an OR gate
> > > > Have you verified that Synopsys did update the documentation for the
> > > > Designware SPI controller?  If not, I think it's prudent to keep the
> > > > old name.
> > >
> > > I'm trying to rename the legacy name(master/slave) to modern
> > > name(host/target) used in SPI drivers,
> > > is it ok to change this comment master to host ?
>
> > That depends on the (external) documentation this comment refers
> > to.  If that documentation refers to master, you must not change
> > the comment.
> >
> > https://www.synopsys.com/dw/ipdir.php?ds=amba_ssi offers a download
> > link which is supposed to allow you to download this documentation
> > after registration, but unfortunately that process doesn't seem to work
> > (it just takes me back to the same page).
>
> I don't think Synopsys will let anybody to freely download their IP-core
> databook with no NDA signed. The only docs which can be relatively
> simple reached is the brief IP-core datasheet. For instance the DW SSI
> datasheet is available here:
> https://www.synopsys.com/dw/doc.php/ds/c/amba_ssi.pdf
> I had to provide my corporate private data to get that pdf-file
> including the corporate email. That file doesn't use any master or
> slave words but I doubt it used to have them anyway because
> another modern datasheet still utilizes master/slave wording:
> https://www.synopsys.com/dw/doc.php/ds/i/dw_amba_solutions.pdf

These links work for me (after filling in the form).
The first one seems to be the same I tried before, and didn't work
earlier today... Strange.

The actual databook is indeed not available without a real account.

> So as I already answered to Yang I doubt Synopsys has executed any
> renaming. You are correct to note the questionable change in this
> patch. Thanks.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
