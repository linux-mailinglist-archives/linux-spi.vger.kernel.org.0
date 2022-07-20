Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF3457B648
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiGTMZq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 08:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGTMZq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 08:25:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3889E45F7A;
        Wed, 20 Jul 2022 05:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0B6D61614;
        Wed, 20 Jul 2022 12:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53857C3411E;
        Wed, 20 Jul 2022 12:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658319944;
        bh=3jwvTmS4Zq7kPtUaSWDATV8h0TY/gSDNXxfwVnm6gxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D75rqCEBd/MA3ySpdQWmjF6Yrc1ViXGq2kJ5KxeOTfO59aTmYMma8EjKR7ux+hdJ9
         7LZ1jiUCazI0LOzUilUTgFtcu8ltcBH1wtSeqjd7XYJzmljerYH5hiMg3KT0yqKoYA
         7/QZvnYDELwoRzhQ1FNFB73BHJcGLA6W/xpBmHASOBbYejw6fakjUSep0E75ToLdQ8
         cp/tFdMkpdKFs3imXuaXVWhBLBcDHPJB6pGwK3Oa5G2Mf0JJEkfNlt2hmigcn/Oxb8
         iUJwy3WcY8qbqzEvnvcOgNNlOKTanxPAZgomCiQxwZgEAYad4PAoZuVwAn6l/j2OkC
         1o24PHD/C1hAA==
Date:   Wed, 20 Jul 2022 17:55:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>
Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Message-ID: <Ytf0RMoTjTnH1GVT@matsya>
References: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdWqfnpN_FWyLVb+KGmgR+VY4GJ67Sk2xSAb18HK_B7WZw@mail.gmail.com>
 <OS0PR01MB5922FC0E3C336E727084C96B868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUJzNkf+n5VLzEZTzUpChz9T4Yn-Hpq01sVBRMk3-c2CQ@mail.gmail.com>
 <OS0PR01MB59220A67C039CCBF7D4D4AFE868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YteNFrNSsEfLDHR/@matsya>
 <OS0PR01MB592241E22FCEA9084FAAD24C868E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Ytfa4NYhLGASHxk7@matsya>
 <OS0PR01MB59225A3C2B0A891068DAF390868E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59225A3C2B0A891068DAF390868E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20-07-22, 10:54, Biju Das wrote:
> Hi Vinod,
> 
> > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
> > 
> > On 20-07-22, 05:13, Biju Das wrote:
> > > Hi Vinod,
> > >
> > > > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to
> > > > spi_ops
> > > >
> > > > On 19-07-22, 11:28, Biju Das wrote:
> > > > > Hi Geert,
> > > > >
> > > > > +Vinod
> > > > >
> > > > > > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to
> > > > > > spi_ops
> > > > > >
> > > > > > Hi Biju,
> > > > > >
> > > > > > On Tue, Jul 19, 2022 at 10:29 AM Biju Das
> > > > > > <biju.das.jz@bp.renesas.com>
> > > > > > wrote:
> > > > > > > > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable
> > > > > > > > to spi_ops On Sat, Jul 16, 2022 at 5:39 PM Biju Das
> > > > > > <biju.das.jz@bp.renesas.com> wrote:
> > > > > > > > > On RZ/G2L SoCs switching from DMA to interrupt mode,
> > > > > > > > > causes timeout issue as we are not getting Rx interrupt
> > > > > > > > > even though SPRF bit is set in the status register.
> > > > > > > > >
> > > > > > > > > But there is no issue if we don't switch between interrupt
> > > > > > > > > to DMA mode or vice versa.
> > > > > > > > >
> > > > > > > > > Performance comparison between interrupt and DMA mode on
> > > > > > > > > RZ/Five SMARC platform connected to a display module shows
> > > > > > > > > that performance and CPU utilization is much better with
> > > > > > > > > DMA mode compared to interrupt mode
> > > > > > > > > (1->65 fps) and (98->8%).
> > > > > > > > >
> > > > > > > > > This patch introduces a variable force_dma to avoid
> > > > > > > > > switching between DMA to interrupt mode for RZ platforms.
> > > >
> > > > Why do you need a variable for that, if DMA is availble (you were
> > > > able to allocate channels) then use DMA, otherwise fall back to PIO..
> > >
> > > I was using DMA. We are not getting rspi interrupts after the DMA to
> > > PIO switch because of [1]. ie, we are not clearing DMAR in DMA driver
> > > and interrupt requests to the interrupt controller are masked.
> > >
> > > [1]
> > >
> > > >
> > > > Or anything missing from context which I am not aware of?
> > >
> > > After this discussion, I have posted [1] and [2] to fix this issue.
> > >
> > > [2]
> > 
> > Thanks for the explanation Biju. But why do we need .force_dma flag?
> 
> It is not required. This patch is not valid anymore.

okay, that sounds about right!

> Initially I met with an issue(PIO fallback does not work). So posted this patch to make all transfer DMA by using .force_dma flag.
> 
> Then Mark suggested that we should find the root cause. After that, Geert mentioned 
> we are not clearing DMARS, that is the reason for interrupt miss.
> 
> During DMA prepare, we set RSPI DMARS and signal is set for DMA transfer request signal
> and it masks rspi interrupts. When we do PIO mode, still DMARS is set, and we won't get rspi
> interrupt.
> 
> The new patches which I posted[1] and [2] clears DMARS in dmaengine_synchronize() in dma callback
> after synchronizing with wait_event and PIO fallback works as expected.
> 
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220719150000.383722-1-biju.das.jz@bp.renesas.com/
> [2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220719150000.383722-2-biju.das.jz@bp.renesas.com/
> 
> Cheers,
> Biju

-- 
~Vinod
