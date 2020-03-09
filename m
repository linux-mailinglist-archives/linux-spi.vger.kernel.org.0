Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6ED17E9CF
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 21:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgCIURq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 16:17:46 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:43297 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIURq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 16:17:46 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2C33223EB9;
        Mon,  9 Mar 2020 21:17:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583785062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4lMfHVJtv1/7tVOgY+2NWcDkuP/vkxxc0vG3i3iujk=;
        b=NBn4ng5rW9oF8jRIKbzD31HivmfpG9BA77wMSo0PPFk6bAfzl3PR72WqOaR7fjDpHdA3sE
        77UMpTWS/9sN2Naf6SKSh6yNpPZjkpJOcwGJxbP1PO5bDjUajSZyDnmbRtpReyBIMfb2VP
        1JOHIrABm2aB7IU06lyO+tfP9+TnPVo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Mar 2020 21:17:42 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Subject: Re: [PATCH 5/6] arm64: dts: ls1028a: Specify the DMA channels for the
 DSPI controllers
In-Reply-To: <CA+h21hp2MxLqLJL9AnufmW_-OQFdiY7p4Db97G3eTr_MUkH4TA@mail.gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <20200309145624.10026-6-olteanv@gmail.com>
 <83af52172a3cabd662de1ed9574e4247@walle.cc>
 <CA+h21hp2MxLqLJL9AnufmW_-OQFdiY7p4Db97G3eTr_MUkH4TA@mail.gmail.com>
Message-ID: <3b25c8b5fc9c433715e1fa99bc515822@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 2C33223EB9
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.385];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,deif.com,sysam.it,gmail.com,embeddedor.com,nvidia.com,nxp.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2020-03-09 20:59, schrieb Vladimir Oltean:
> On Mon, 9 Mar 2020 at 21:06, Michael Walle <michael@walle.cc> wrote:
>> 
>> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
>> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
>> >
>> > LS1028A has a functional connection to the eDMA module. Even if the
>> > spi-fsl-dspi.c driver is not using DMA for LS1028A now, define the
>> > slots
>> > in the DMAMUX for connecting the eDMA channels to the 3 DSPI
>> > controllers.
>> >
>> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> > ---
>> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > index 515e0a1b934f..18155273a46e 100644
>> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > @@ -298,6 +298,8 @@
>> >                       interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>> >                       clock-names = "dspi";
>> >                       clocks = <&clockgen 4 1>;
>> > +                     dmas = <&edma0 0 62>, <&edma0 0 60>;
>> > +                     dma-names = "tx", "rx";
>> 
>> minor nit. Other nodes specified the dma channels as
>> 
>> dma-names = "tx", "rx";
>> dmas = <&edma0 0 62>,
>>         <&edma0 0 60>;
>> 
>> -michael
>> 
> 
> Does it matter?

No, therefore "minor nit". Its just formatted other then everything else 
in the file.

-michael
