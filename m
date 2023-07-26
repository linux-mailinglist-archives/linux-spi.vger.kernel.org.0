Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C132C763D1F
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jul 2023 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjGZRBu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jul 2023 13:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjGZRBp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jul 2023 13:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D50813D;
        Wed, 26 Jul 2023 10:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B85D61BF3;
        Wed, 26 Jul 2023 17:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222C0C433CB;
        Wed, 26 Jul 2023 17:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690390903;
        bh=4mbYmnu1PDgK0itPtxxQYM0+Hl+zT+MwXTqlREX4YhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlygdD+/KE1R/9AaKHGMCTFrqMun444kuddWkLPP/pXwMkc8RFH/CqsNJRzbROd5q
         hvHHxv3+KRojZaLXxUgCXE1nZxdFEOYDFXtoj2FirCiW7xPuG7LkP/kCXSqm06woUE
         gXKPTvU2NDgbv3pHK1q3S7wuvgbwI5Ey4DYWZ7o1sZzn8UgAhQad7Eoz+yzZih+TXI
         OD5+vitXuR/7A/RiC0KPR5a0hYdWU3/3X0YtqUGEGKUEAZPtVCULnThdDqfTuGN4ry
         IVs296+9cHENYnQXkshMl21XP+HhHQ2ch+qKJ8Gqj/EAO+rBgqijgQ7zXL0YvRLvfR
         /MpDs/Qn6NmVA==
Received: (nullmailer pid 1585388 invoked by uid 1000);
        Wed, 26 Jul 2023 17:01:41 -0000
Date:   Wed, 26 Jul 2023 11:01:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: media: imx-jpeg: Add clocks property
Message-ID: <20230726170141.GA1568248-robh@kernel.org>
References: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com>
 <20230724122101.2903318-3-alexander.stein@ew.tq-group.com>
 <20230724-unscrew-bonnet-3c86da806df3@spud>
 <1908243.taCxCBeP46@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1908243.taCxCBeP46@steina-w>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 25, 2023 at 07:31:55AM +0200, Alexander Stein wrote:
> Am Montag, 24. Juli 2023, 20:26:15 CEST schrieb Conor Dooley:
> > On Mon, Jul 24, 2023 at 02:21:00PM +0200, Alexander Stein wrote:
> > > i.MX8 and i.MX8X both use two clocks for accessing the periphery.
> > > Add clocks and clock-names properties accordingly.
> > > 
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > > Changes in v2:
> > > * None
> > > 
> > >  .../devicetree/bindings/media/nxp,imx8-jpeg.yaml          | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> > > b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml index
> > > 3d9d1db37040..2533e16720f2 100644
> > > --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> > > +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> > > 
> > > @@ -46,6 +46,14 @@ properties:
> > >      minItems: 2               # Wrapper and 1 slot
> > >      maxItems: 5               # Wrapper and 4 slots
> > > 
> > > +  clocks:
> > > +    maxItems: 2
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: per
> > > +      - const: ipg
> > 
> > What do "per" and "ipg" mean? I assume "per" is peripheral?
> 
> Actually I don't know what "ipg" stands for. It's a quite common name on i.MX 
> platforms though. I opted for the names currently used in the DT. The driver 
> doesn't care for the names currently.

Those names date back about 25 years to Motorola Mcore GSM SoCs. IPG 
came from IPG bus which IIRC stood for IP gasket. Essentially the bus 
was something like Arm APB being slave only. The IPG clock is 
essentially the bus and register access clock. 'per' is the functional 
clock in cases that need a defined clock rate such as UART baud clock. 

There is also a shared (between CPU and DSP) bus called SPBA from the 
same time which still lives on even though it isn't shared in i.MX 
chips.

> But cross-checking the reference manual these clocks seems to be called "jpeg" 
> and "ips", individually for both jpeg encoder and decoder.

Given this block is probably licensed IP, seems like it would use 
something different and be directly connected to AHB or AXI.

> Mirela (added to recipients): As the original author of the DT nodes, could 
> you provide additional information regarding the clock names?
> 
> Best regards,
> Alexander
