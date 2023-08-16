Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BE677DD3A
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbjHPJYj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243337AbjHPJYh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:24:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21DF26A1
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:24:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe8c3b5ca0so10244380e87.1
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692177874; x=1692782674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qHPhuCBUaJn3Gi5QLQ4UwgLxI9tiS1dLoXEq56R+ju4=;
        b=bTjI1jIGrUzSeO2VW+Uj/QQn/vGyXSLbjmqMK5L5Z6zl42M7FcThY6quSV06yZVgl7
         09Ep4H2qN0rFoZ2MN3SGXdg6qfcxijda2IY/Fj09B1J06IU1o82Wt6BZ9yxeibz0adBX
         kyxOGq1lTtEOJU+q6Lwu2UzxesR4d9hHnIoq6pR3+86VuPCvs8j5HYDc4MAABD882+18
         wc1te4X0NlNASW67QOkOP4VtePm1sN2BVCcxHIe41BW/jm6DuFa/O0ivC2i9zu8xaYSZ
         MH1btLIxF/8bgjfcNITNkGam5MGAKO1ijuLV/CG1/Ksab+fRVm+X0V9qlUOMwZ2/BsqO
         K0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692177874; x=1692782674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHPhuCBUaJn3Gi5QLQ4UwgLxI9tiS1dLoXEq56R+ju4=;
        b=CKsDQ0xDZXYXR5czdfZpFhq85qqWbuAaKMuyMapWyW2eD5r2V/2VX3MIIhQmjCjeT+
         QuLIJ3qgQVMAyv1pHeT94a8nMTgK7/25Hoynh+rHDkxLAV54HVR13ILl2qk0BmxxfXar
         qqlY3C25CcRUdn7lUa/Y4Rls4D870B/NmYdK3h+As8ngtylR2LotVNYSnVBrxhP6FRuI
         o729Nj5zUD9cLUfPdhRUuKKvHWyPVHRCyOSozSocqQseAXDHYAM9TsPkuF6q7nnfcRsS
         O00Kz2Uf9tRVRrow4RksqimwRwm7FB42ZdQdTFBAoKBIR2J83/5uH+AGD9t+MA0e8BrT
         qpWQ==
X-Gm-Message-State: AOJu0Yzb4jCTlB9YFi5D57jHBH0uhqJ9g9I9Y+x5eO0JfF9sQFFAIlEH
        nt6J601qXzLEXlBQP0GSV0aFtOH1qI8=
X-Google-Smtp-Source: AGHT+IHpExZckwzxYFuHIImE8+WvzEknrTD1lNMrMoySbu/0C0pT3W7QtM24s+sfiBTPEub9q/xIFQ==
X-Received: by 2002:a05:6512:128a:b0:4fe:2d93:2b50 with SMTP id u10-20020a056512128a00b004fe2d932b50mr1393322lfs.31.1692177873718;
        Wed, 16 Aug 2023 02:24:33 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id q18-20020a19a412000000b004fe3ba2d487sm2858836lfc.108.2023.08.16.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 02:24:33 -0700 (PDT)
Date:   Wed, 16 Aug 2023 12:24:29 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de
Subject: Re: [PATCH -next v2 19/21] spi: dw: switch to use modern name
Message-ID: <rjwaprnnlkpkohzdq5iapcmvx4uayc4tvdr2nny3s5olhphqvs@iusqjo6na75w>
References: <20230807140717.3484180-1-yangyingliang@huawei.com>
 <20230807140717.3484180-20-yangyingliang@huawei.com>
 <CAMuHMdU7Q1Nps0b2543wx5BT_X2dU7HBwFm6YKEs0g6bmyaYww@mail.gmail.com>
 <a604b778-5dab-abaf-4c81-e10f7c23374c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a604b778-5dab-abaf-4c81-e10f7c23374c@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Yang

On Wed, Aug 16, 2023 at 11:45:26AM +0800, Yang Yingliang wrote:
> Hi Serge,
> 
> On 2023/8/15 19:36, Geert Uytterhoeven wrote:
> > Hi Yang,
> > 
> > On Mon, Aug 7, 2023 at 4:10 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> > > Change legacy name master to modern name host or controller.
> > > 
> > > No functional changed.
> > > 
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > Thanks for your patch, which is now commit eefc6c5c2451126c ("spi:
> > dw: switch to use modern name") in spi/for-next.
> > 
> > > --- a/drivers/spi/spi-dw-mmio.c
> > > +++ b/drivers/spi/spi-dw-mmio.c
> > > @@ -68,7 +68,7 @@ struct dw_spi_mscc {
> > >                  ((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
> > > 
> > >   /*
> > > - * The Designware SPI controller (referred to as master in the documentation)
> > > + * The Designware SPI controller (referred to as host in the documentation)
> > >    * automatically deasserts chip select when the tx fifo is empty. The chip
> > >    * selects then needs to be either driven as GPIOs or, for the first 4 using
> > >    * the SPI boot controller registers. the final chip select is an OR gate
> > Have you verified that Synopsys did update the documentation for the
> > Designware SPI controller?  If not, I think it's prudent to keep the
> > old name.

> I'm trying to rename the legacy name(master/slave) to modern
> name(host/target) used in SPI drivers,
> is it ok to change this comment master to host ?

The latest Synopsys DesignWare HW databook I posses is of DW APB SSI
4.03a IP-core dated by 12.2020. It still uses the master/slave
wording. The same words can be found in the modern DW AMBA
Interconnect datasheets:
https://www.synopsys.com/dw/doc.php/ds/i/dw_amba_solutions.pdf
(fill in the form with your corporate personal data and you'll be able
to read the doc)
I doubt Synopsys has been in anyway concerned about the renaming.  So
the in-situ comment Geert correctly noted should be left as is: using
the "master" word in this context.

-Serge(y)

> 
> Thanks,
> Yang
> > 
> > > @@ -142,14 +142,14 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
> > >   }
> > > 
> > >   /*
> > > - * The Designware SPI controller (referred to as master in the
> > > + * The Designware SPI controller (referred to as host in the
> > Likewise.
> > 
> > >    * documentation) automatically deasserts chip select when the tx fifo
> > >    * is empty. The chip selects then needs to be driven by a CS override
> > >    * register. enable is an active low signal.
> > >    */
> > >   static void dw_spi_sparx5_set_cs(struct spi_device *spi, bool enable)
> > >   {
> > 
> > Gr{oetje,eeting}s,
> > 
> >                          Geert
> > 
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                  -- Linus Torvalds
> > 
> > .
