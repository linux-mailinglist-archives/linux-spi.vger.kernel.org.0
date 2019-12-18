Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE4C124116
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2019 09:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfLRIJ6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Dec 2019 03:09:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57684 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfLRIJ6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Dec 2019 03:09:58 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5440F28EAAE;
        Wed, 18 Dec 2019 08:09:55 +0000 (GMT)
Date:   Wed, 18 Dec 2019 09:09:52 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Chris Brandt <Chris.Brandt@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Message-ID: <20191218090952.4c9f02a1@collabora.com>
In-Reply-To: <90164352-6b74-ff78-261c-374f51f83330@cogentembedded.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
        <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
        <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
        <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
        <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
        <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com>
        <90164352-6b74-ff78-261c-374f51f83330@cogentembedded.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 17 Dec 2019 22:44:14 +0300
Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:

> On 12/16/2019 11:31 PM, Sergei Shtylyov wrote:
> 
> [...]
> >> My understanding is that HyperFlash uses standard CFI commands, so all   
> > 
> >    The CFI command set driver needed some changes too (e.g. using the status
> > register to determine if a command is done).
> >   
> >> we need to do is register a CFI device in the driver, just like we 
> >> register a serial flash device.  
> >   
> >> (I guess I could go look at the sample code for our RTOS package and find out)
> >>  
> >>>> library that you are proposing have a very different API than just
> >>>> 'send bytes' and 'receive bytes'?  
> >>>
> >>>    There's "prepare" and "transfer" APIs and also "direct map read" API.  
> > 
> >   The 1st one prepares the values to be written in either SPI mode or direct
> > read mode registers. Then you can call "transfer" or "direct mao read" which
> > would write out the register values into either set...
> >   
> >> I wonder what is the value of the "direct map read" (other than XIP in 
> >> RZ/A systems). If you really want to directly access the flash (no 
> >> buffering though the MTD layer), you need to register as a mtd-rom device, 
> >> and then you don't really need an API at all.  
> > 
> >   I'd leave this question to Boris, else I never complete this msg. :-)   
> 
>    Didn't really summon him, doing that now... :-)

The dirmap API has not been designed with XIP in mind (though we could
theoretically extend it to support XIP). The main reason we added this
feature is because most controllers have either a slow PIO based path
where you can basically send every command you want and a fast
direct-mapping path which only support specific cmds or patterns. We
also hide things behind an API instead of returning a virtual mapping
because some controllers have extra constraints when accessing the
direct mapping (alignment, minimum size, limited direct mapping window
size, ...). Not to mention that some drivers might want to use DMA to
not stall the CPU on flash accesses.
