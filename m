Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB4B28B629
	for <lists+linux-spi@lfdr.de>; Mon, 12 Oct 2020 15:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgJLN2d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Oct 2020 09:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgJLN2d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Oct 2020 09:28:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272A2C0613D0
        for <linux-spi@vger.kernel.org>; Mon, 12 Oct 2020 06:28:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kRxsF-0000xt-5v; Mon, 12 Oct 2020 15:28:23 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kRxsD-0000Va-NB; Mon, 12 Oct 2020 15:28:21 +0200
Date:   Mon, 12 Oct 2020 15:28:21 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: enable runtime pm support"
Message-ID: <20201012132821.GE11648@pengutronix.de>
References: <20201009042738.26602-1-ceggers@arri.de>
 <20201009073944.GA11648@pengutronix.de>
 <2670390.HS4A6M72fu@n95hx1g2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2670390.HS4A6M72fu@n95hx1g2>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:40:01 up 235 days, 20:10, 155 users,  load average: 0.12, 0.38,
 0.33
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Oct 12, 2020 at 12:59:34PM +0200, Christian Eggers wrote:
> Hi Sascha,
> 
> On Friday, 9 October 2020, 09:39:44 CEST, Sascha Hauer wrote:
> > On Fri, Oct 09, 2020 at 06:27:38AM +0200, Christian Eggers wrote:
> > > This reverts commit 525c9e5a32bd7951eae3f06d9d077fea51718a6c.
> > >
> > > If CONFIG_PM is disabled, the system completely freezes on probe as
> > > nothing enables the clock of the SPI peripheral.
> >
> > Instead of reverting it, why not just fix it?
> >
> > Normally the device should be brought to active state manually in probe
> > before pm_runtime takes over, then CONFIG_PM disabled doesn't hurt.
> > Using pm_runtime to put the device to active state initially has the
> > problem you describe.
> 
> prior introducing runtime pm for spi-imx, the clock was "manually" enabled and
> disabled around each transfer (so the power usage should already have been
> optimal). If we would manually enable the clock in probe() as you suggested,
> for users without CONFIG_PM there would be a drawback compared with the
> previous state (as the clock will always be on now).
> 
> What is the benefit of controlling the SPI clock with runtime PM instead of
> doing it manually?

The clocks are reconfigured less frequently with pm_runtime. Especially
when enabling/disabling PLLs are involved pm_runtime can increase
performance.

Also you can put other stuff you need to handle for your device into
pm_runtime, think of regulators for example. All this is then abstracted
behind a common kernel API.

Generally when you disable CONFIG_PM then you are not interested in
power consumption and in that case you shouldn't be interested in
disabling your SPI clocks.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
