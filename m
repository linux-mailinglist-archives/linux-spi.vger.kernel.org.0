Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874264E3D3F
	for <lists+linux-spi@lfdr.de>; Tue, 22 Mar 2022 12:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiCVLKW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 22 Mar 2022 07:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiCVLKP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Mar 2022 07:10:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E6A21A9
        for <linux-spi@vger.kernel.org>; Tue, 22 Mar 2022 04:08:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nWcNV-0007To-T5; Tue, 22 Mar 2022 12:08:41 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nWcNP-002HSz-Ju; Tue, 22 Mar 2022 12:08:38 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nWcNR-000459-MN; Tue, 22 Mar 2022 12:08:37 +0100
Message-ID: <8b9aaabebc65a91e7700f2bd232e48b853aff9e8.camel@pengutronix.de>
Subject: Re: [PATCH] spi: dw: assert reset before deasserting reset
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Date:   Tue, 22 Mar 2022 12:08:37 +0100
In-Reply-To: <YjmlsZl1Xg/Xkg37@x1-carbon>
References: <20220301111715.3062886-1-Niklas.Cassel@wdc.com>
         <20220311142550.haw5jnrjycavr43m@mobilestation>
         <Yitv+tKTH2RpTV2K@x1-carbon>
         <20220311170558.5bj4vwbalufpmc3f@mobilestation>
         <YjHwCcRW0kXMhiLk@x1-carbon>
         <a5bc14e4a116717a68889f9a576ba9a332d25c80.camel@pengutronix.de>
         <YjmlsZl1Xg/Xkg37@x1-carbon>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Niklas,

On Di, 2022-03-22 at 10:32 +0000, Niklas Cassel wrote:
[...]
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c?h=v5.17#n7035
> 

Thank you.

[...]
I see your point. Many drivers should probably change assert() +
udelay(x) + deassert() with a reset_control_reset(), since .reset()
implementation should have the correct delay for each SoC.
..but I guess often the manual for some hardware block states the how long
reset has to be held. So for that to work the delay in .reset() has to be
greater equal the longest reset time needed for all hardware in that SoC?

Yes, exactly. The reset-simple driver was prepared for this in commit
a9701376ed0f ("reset: simple: Add reset callback"), for example.
Several of the custom reset drivers also implement .reset() with a
fixed delay.

regards
Philipp
