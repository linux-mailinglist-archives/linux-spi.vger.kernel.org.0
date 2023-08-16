Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2E477DD72
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbjHPJjQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243416AbjHPJi5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:38:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0992A26AB
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:38:56 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso95465611fa.0
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692178734; x=1692783534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3CDrQL78a8TwAe7WgLp8uqjRA22khj+Oz63Uf4V9nhg=;
        b=BiT6c2OfFNfsbi7e3194WnBoqI7RJoIlCbkmjFnvb1j10OYfmu6lvG37ssn8hY1IdK
         OJBrH7GEeV4Dhs4oxXwqUj6UvaSz2DRjgMeEom+MjfvQ9COTNaEVvtB61QJ3Jo/DlDjo
         1xK5BRwp7HyiwAufqVzQm15bgzR+RsqjCJyScxOHk/9b6bGNDN81LD+m9qVNK1G2giMO
         1HOGNVFdKmH1BM3+Zop437Ni8Vbpe1cGzWVbFi4g38YGjQusa5eXGrFxs575XjCJivAD
         IhFgSilff1ENn89t0oe3yE+mqKHpuoCnHohht4ByFGzUwYMgBH2X3mhaYPBpZHHy3ky0
         P4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692178734; x=1692783534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CDrQL78a8TwAe7WgLp8uqjRA22khj+Oz63Uf4V9nhg=;
        b=ddNY5uZiZJjkzVc2YJh/JfakIB31qhcPcHPB8JiUCnj/R9dTiTyG0qxkUUKLkJvtdp
         ylbP42O59kFZlRieecnbluRyYMakvxb2Xh/vEyydM+q8XuXbrbo8foxlI+dxbRPE630w
         Gsq0WP1s1SWuvz7rA7JAuUbXwxNFfnxuxSCEMZXMehphROOa8cxprYlZ2QdoITCFFgsc
         rGF/C4rNjd+slIZWwn2Xn4AZ7KMeKnZoSxtgKCHG2XogZsWSjcOll8I8dfdiT6tYdnRm
         0d618NTY2/JL3A2FGj8UgSJX7cd7nrtctywnG4c3pfiDRkMQRQ7WYE55iO6F1USBSYdk
         J3Rw==
X-Gm-Message-State: AOJu0YxgAM5U46poHHfmjLP8vOJdBXqBw8V3o/44bIa/9RldduI7nAPB
        L3OXcbY4JGhoB/lRbHTDbRhnbJGAnwA=
X-Google-Smtp-Source: AGHT+IFvPr9O8Ai7oVANaBAwhPg92HfV2TWJp2+my/87mCO6zzQESACmwVskePHHDbOQYHZmvYrH3g==
X-Received: by 2002:a2e:b174:0:b0:2b6:e7ff:4b2e with SMTP id a20-20020a2eb174000000b002b6e7ff4b2emr1095629ljm.33.1692178733975;
        Wed, 16 Aug 2023 02:38:53 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id o16-20020a2e7310000000b002bb9b1db5b9sm103929ljc.8.2023.08.16.02.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 02:38:53 -0700 (PDT)
Date:   Wed, 16 Aug 2023 12:38:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de
Subject: Re: [PATCH -next v2 19/21] spi: dw: switch to use modern name
Message-ID: <hq4k5y6el34vghqrfrg4sjgpvnw32fqyqlwfahypu4m4hoodfj@x4sprdm22b7s>
References: <20230807140717.3484180-1-yangyingliang@huawei.com>
 <20230807140717.3484180-20-yangyingliang@huawei.com>
 <CAMuHMdU7Q1Nps0b2543wx5BT_X2dU7HBwFm6YKEs0g6bmyaYww@mail.gmail.com>
 <a604b778-5dab-abaf-4c81-e10f7c23374c@huawei.com>
 <CAMuHMdU0akTNec7z_aAw=i_NO8j-j0Q_XsRiYhnnPj53qLneug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU0akTNec7z_aAw=i_NO8j-j0Q_XsRiYhnnPj53qLneug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert

On Wed, Aug 16, 2023 at 09:17:52AM +0200, Geert Uytterhoeven wrote:
> Hi Yang,
> 
> On Wed, Aug 16, 2023 at 5:45 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> > On 2023/8/15 19:36, Geert Uytterhoeven wrote:
> > > On Mon, Aug 7, 2023 at 4:10 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> > >> Change legacy name master to modern name host or controller.
> > >>
> > >> No functional changed.
> > >>
> > >> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > Thanks for your patch, which is now commit eefc6c5c2451126c ("spi:
> > > dw: switch to use modern name") in spi/for-next.
> > >
> > >> --- a/drivers/spi/spi-dw-mmio.c
> > >> +++ b/drivers/spi/spi-dw-mmio.c
> > >> @@ -68,7 +68,7 @@ struct dw_spi_mscc {
> > >>                  ((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
> > >>
> > >>   /*
> > >> - * The Designware SPI controller (referred to as master in the documentation)
> > >> + * The Designware SPI controller (referred to as host in the documentation)
> > >>    * automatically deasserts chip select when the tx fifo is empty. The chip
> > >>    * selects then needs to be either driven as GPIOs or, for the first 4 using
> > >>    * the SPI boot controller registers. the final chip select is an OR gate
> > > Have you verified that Synopsys did update the documentation for the
> > > Designware SPI controller?  If not, I think it's prudent to keep the
> > > old name.
> >
> > I'm trying to rename the legacy name(master/slave) to modern
> > name(host/target) used in SPI drivers,
> > is it ok to change this comment master to host ?
> 

> That depends on the (external) documentation this comment refers
> to.  If that documentation refers to master, you must not change
> the comment.
> 
> https://www.synopsys.com/dw/ipdir.php?ds=amba_ssi offers a download
> link which is supposed to allow you to download this documentation
> after registration, but unfortunately that process doesn't seem to work
> (it just takes me back to the same page).

I don't think Synopsys will let anybody to freely download their IP-core
databook with no NDA signed. The only docs which can be relatively
simple reached is the brief IP-core datasheet. For instance the DW SSI
datasheet is available here:
https://www.synopsys.com/dw/doc.php/ds/c/amba_ssi.pdf
I had to provide my corporate private data to get that pdf-file
including the corporate email. That file doesn't use any master or
slave words but I doubt it used to have them anyway because
another modern datasheet still utilizes master/slave wording:
https://www.synopsys.com/dw/doc.php/ds/i/dw_amba_solutions.pdf

So as I already answered to Yang I doubt Synopsys has executed any
renaming. You are correct to note the questionable change in this
patch. Thanks.

-Serge(y)

> 
> > >> @@ -142,14 +142,14 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
> > >>   }
> > >>
> > >>   /*
> > >> - * The Designware SPI controller (referred to as master in the
> > >> + * The Designware SPI controller (referred to as host in the
> > > Likewise.
> > >
> > >>    * documentation) automatically deasserts chip select when the tx fifo
> > >>    * is empty. The chip selects then needs to be driven by a CS override
> > >>    * register. enable is an active low signal.
> > >>    */
> > >>   static void dw_spi_sparx5_set_cs(struct spi_device *spi, bool enable)
> > >>   {
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
