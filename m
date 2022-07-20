Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6BF57B497
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 12:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiGTKh1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 06:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiGTKh0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 06:37:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D3A5508D;
        Wed, 20 Jul 2022 03:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08B7F61BF0;
        Wed, 20 Jul 2022 10:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C99AC3411E;
        Wed, 20 Jul 2022 10:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658313444;
        bh=AjL3dM6yBgYaym8wm8A74HA4sP8fhVSoeHkzmkF7ig4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJ72/lzK1it0k/N4rGOtMLbZBS0bPD4ntQS1s8JYmZTrfkFgb+JNlXULWENH/7R1m
         C5b2gQ72qXDGspTKk84K6bPEVdr4AgbhonYZWSw0yVsE+BKnJr10XdQgFGyYRBkaDm
         UXyzSR7wxUDfoaXnti3bxvQIt6heU34AzDQo9hDbfO3UAk4543q34zcjIGsZhU3lTh
         +Fe+iNQzQS6l3Y8vPdcX6/sph6AMldCDghLoKMZs7w6EbRikx4yfo+cyeKvNub2y64
         pNp8ln84zglSes0z84gsaTRHpvhg87+7etz+wrjwB1vs8yFpO9hlUvrqheDv0tBAT3
         bCIGIzEUBap5w==
Date:   Wed, 20 Jul 2022 16:07:20 +0530
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
Message-ID: <Ytfa4NYhLGASHxk7@matsya>
References: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdWqfnpN_FWyLVb+KGmgR+VY4GJ67Sk2xSAb18HK_B7WZw@mail.gmail.com>
 <OS0PR01MB5922FC0E3C336E727084C96B868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUJzNkf+n5VLzEZTzUpChz9T4Yn-Hpq01sVBRMk3-c2CQ@mail.gmail.com>
 <OS0PR01MB59220A67C039CCBF7D4D4AFE868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YteNFrNSsEfLDHR/@matsya>
 <OS0PR01MB592241E22FCEA9084FAAD24C868E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592241E22FCEA9084FAAD24C868E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20-07-22, 05:13, Biju Das wrote:
> Hi Vinod,
> 
> > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
> > 
> > On 19-07-22, 11:28, Biju Das wrote:
> > > Hi Geert,
> > >
> > > +Vinod
> > >
> > > > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to
> > > > spi_ops
> > > >
> > > > Hi Biju,
> > > >
> > > > On Tue, Jul 19, 2022 at 10:29 AM Biju Das
> > > > <biju.das.jz@bp.renesas.com>
> > > > wrote:
> > > > > > Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to
> > > > > > spi_ops On Sat, Jul 16, 2022 at 5:39 PM Biju Das
> > > > <biju.das.jz@bp.renesas.com> wrote:
> > > > > > > On RZ/G2L SoCs switching from DMA to interrupt mode, causes
> > > > > > > timeout issue as we are not getting Rx interrupt even though
> > > > > > > SPRF bit is set in the status register.
> > > > > > >
> > > > > > > But there is no issue if we don't switch between interrupt to
> > > > > > > DMA mode or vice versa.
> > > > > > >
> > > > > > > Performance comparison between interrupt and DMA mode on
> > > > > > > RZ/Five SMARC platform connected to a display module shows
> > > > > > > that performance and CPU utilization is much better with DMA
> > > > > > > mode compared to interrupt mode
> > > > > > > (1->65 fps) and (98->8%).
> > > > > > >
> > > > > > > This patch introduces a variable force_dma to avoid switching
> > > > > > > between DMA to interrupt mode for RZ platforms.
> > 
> > Why do you need a variable for that, if DMA is availble (you were able to
> > allocate channels) then use DMA, otherwise fall back to PIO..
> 
> I was using DMA. We are not getting rspi interrupts after the DMA to PIO switch
> because of [1]. ie, we are not clearing DMAR in DMA driver
> and interrupt requests to the interrupt controller are masked.
> 
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220719150000.383722-2-biju.das.jz@bp.renesas.com/
> 
> > 
> > Or anything missing from context which I am not aware of?
> 
> After this discussion, I have posted [1] and [2] to fix this issue.
> 
> [2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220719150000.383722-1-biju.das.jz@bp.renesas.com/

Thanks for the explanation Biju. But why do we need .force_dma flag? 

> 
> Cheers,
> Biju
> 
> 
> > 
> > > > > > >
> > > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > >
> > > > > > Thanks for your patch!
> > > > > >
> > > > > > > @@ -1196,6 +1197,7 @@ static const struct spi_ops rspi_rz_ops = {
> > > > > > >         .flags =                SPI_CONTROLLER_MUST_RX |
> > > > > > SPI_CONTROLLER_MUST_TX,
> > > > > > >         .fifo_size =            8,      /* 8 for TX, 32 for RX */
> > > > > > >         .num_hw_ss =            1,
> > > > > > > +       .force_dma =            true,
> > > > > > >  };
> > > > > >
> > > > > > Do you know if this is needed on RZ/A series, too?
> > > > >
> > > > > I guess it is needed?? I may be wrong. I got a link from Chris
> > > > > [1]. As per this still We haven't found a solution. May be the
> > > > > priority is changed for this activity and no one looked after this.
> > > > >
> > > > > [1]
> > > >
> > > > Daniel said he found the issue, i.e. the dmac driver never resetting
> > DMARS?
> > >
> > > Currently DMARS set during prepare and it never cleared. So I added
> > > device_synchronize callback in DMA driver to clear the DMARS. RSPI
> > > client driver after synchronizing DMA callback, calls
> > dmaengine_synchronize which clears DMARS.
> > >
> > > With this DMA to interrupt mode switching is working fine.
> > >
> > > Cheers,
> > > Biju
> > >
> > 
> > --
> > ~Vinod

-- 
~Vinod
