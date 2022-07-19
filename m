Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940EB579563
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 10:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiGSIlS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbiGSIlP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 04:41:15 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BECB186F2;
        Tue, 19 Jul 2022 01:41:13 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id l14so8143590qtv.4;
        Tue, 19 Jul 2022 01:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRglt7LLCb5iPE9bUTK9HQlv9670D6Bkng4M1cGxQRU=;
        b=iw7UnHQCai1X5O1DCngE0QNPGJjg0m0bfwTW/zs7rEviZXpM+yluLSR8aIjI1SNEgz
         SSWc5doMtAiW/T1JC8yi9m1EEuNv5FCd0t1ETUJj2Q+83BZaMywb8swe8W339fW1t4XG
         oIIcm5xX3Sa51SIjXDTq+8Avm6lYwmybTrTv+K5BYd4dD+X5+LqEuV5Xkv0pVgAcGejZ
         YVFZbFQqB2C5/PNQOdB/aEtCEmpsIIlIFSU6NEga5ZpYtyTMGNFMUI3EpS0vuH1Fyo0n
         7Uil7ckZHZisq7AO++b31Ef/ZRV/f1mNEimofA8fL5vKUQF19cgbJlRGe7iC3CJgd28z
         b4hQ==
X-Gm-Message-State: AJIora/oQwPD1XOfzEyb/fnsYguRaT/Tk//pmAFNxGPMyyHakwXAPIit
        gtpcWSR3d9EY1T+KzFvYmv1VZfrm5Wl1SQ==
X-Google-Smtp-Source: AGRyM1tIheOnT8mbEzIdPoeKAfuZZ+Iz5/eXQKkeCXI9kQ8cHT485m7PPSLHJQv9H1REMP+LWEFp1Q==
X-Received: by 2002:a05:622a:1886:b0:31e:c183:136e with SMTP id v6-20020a05622a188600b0031ec183136emr23688141qtc.508.1658220072518;
        Tue, 19 Jul 2022 01:41:12 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id cc12-20020a05622a410c00b00316a384447fsm7882412qtb.16.2022.07.19.01.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 01:41:12 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31e0d4ad6caso72792637b3.10;
        Tue, 19 Jul 2022 01:41:12 -0700 (PDT)
X-Received: by 2002:a81:98d:0:b0:31c:921c:9783 with SMTP id
 135-20020a81098d000000b0031c921c9783mr34511911ywj.316.1658220071932; Tue, 19
 Jul 2022 01:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdWqfnpN_FWyLVb+KGmgR+VY4GJ67Sk2xSAb18HK_B7WZw@mail.gmail.com> <OS0PR01MB5922FC0E3C336E727084C96B868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922FC0E3C336E727084C96B868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jul 2022 10:41:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUJzNkf+n5VLzEZTzUpChz9T4Yn-Hpq01sVBRMk3-c2CQ@mail.gmail.com>
Message-ID: <CAMuHMdUJzNkf+n5VLzEZTzUpChz9T4Yn-Hpq01sVBRMk3-c2CQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Biju,

On Tue, Jul 19, 2022 at 10:29 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
> > On Sat, Jul 16, 2022 at 5:39 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > On RZ/G2L SoCs switching from DMA to interrupt mode, causes timeout
> > > issue as we are not getting Rx interrupt even though SPRF bit is set
> > > in the status register.
> > >
> > > But there is no issue if we don't switch between interrupt to DMA mode
> > > or vice versa.
> > >
> > > Performance comparison between interrupt and DMA mode on RZ/Five SMARC
> > > platform connected to a display module shows that performance and CPU
> > > utilization is much better with DMA mode compared to interrupt mode
> > > (1->65 fps) and (98->8%).
> > >
> > > This patch introduces a variable force_dma to avoid switching between
> > > DMA to interrupt mode for RZ platforms.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > @@ -1196,6 +1197,7 @@ static const struct spi_ops rspi_rz_ops = {
> > >         .flags =                SPI_CONTROLLER_MUST_RX |
> > SPI_CONTROLLER_MUST_TX,
> > >         .fifo_size =            8,      /* 8 for TX, 32 for RX */
> > >         .num_hw_ss =            1,
> > > +       .force_dma =            true,
> > >  };
> >
> > Do you know if this is needed on RZ/A series, too?
>
> I guess it is needed?? I may be wrong. I got a link from Chris [1]. As per this still
> We haven't found a solution. May be the priority is changed for this activity and
> no one looked after this.
>
> [1] https://lore.kernel.org/linux-renesas-soc/?q=spi-rspi+mixes+DMA+and+PIO+transfers+causing+PIO+transfer+to+fail

Daniel said he found the issue, i.e. the dmac driver never resetting
DMARS?

> > I knowupstream does not have DMA support for RZ/A yet, but the BSP has?
>
> RZ/G2L DMA driver is derived from RZ/A, with small changes it can support RZ/A.
> I am not sure is there any plan to upstream DMA support for RZ/A?
> I do not have RZ/A board.

I have, so it might happen, one day...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
