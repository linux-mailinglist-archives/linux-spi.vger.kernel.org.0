Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624834DC3D5
	for <lists+linux-spi@lfdr.de>; Thu, 17 Mar 2022 11:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiCQKTC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 17 Mar 2022 06:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiCQKTB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Mar 2022 06:19:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1123A1DE6F4
        for <linux-spi@vger.kernel.org>; Thu, 17 Mar 2022 03:17:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nUnCM-0004Vw-9X; Thu, 17 Mar 2022 11:17:38 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nUnCK-001ESd-8u; Thu, 17 Mar 2022 11:17:34 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nUnCI-0004UQ-A9; Thu, 17 Mar 2022 11:17:34 +0100
Message-ID: <a5bc14e4a116717a68889f9a576ba9a332d25c80.camel@pengutronix.de>
Subject: Re: [PATCH] spi: dw: assert reset before deasserting reset
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Date:   Thu, 17 Mar 2022 11:17:34 +0100
In-Reply-To: <YjHwCcRW0kXMhiLk@x1-carbon>
References: <20220301111715.3062886-1-Niklas.Cassel@wdc.com>
         <20220311142550.haw5jnrjycavr43m@mobilestation>
         <Yitv+tKTH2RpTV2K@x1-carbon>
         <20220311170558.5bj4vwbalufpmc3f@mobilestation>
         <YjHwCcRW0kXMhiLk@x1-carbon>
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

Hi Niklas, Serge,

On Mi, 2022-03-16 at 14:11 +0000, Niklas Cassel wrote:
[...]
> > > > What about the self-reset based controllers?
> > > 
> > > Not sure what specific feature in the SPI controller you are
> > > referring to.
> > 
> > I am speaking about the reset-controller lines. They can be of two
> > types: manually asserted/de-asserted and self-deasserted. It's
> > platform-specific and mainly depends on the reset-controller
> > implementation.

I assume this is theoretical. Or are there any platforms where spi-dw-
mmio could be used with a self-deasserting reset controller?

> > Seeing you are adding a full-reset cycle anyway, I suggest to add a
> > support for the both types of reset. Like this:
> > 
> > #include <linux/delay.h>
> > ...
> > 
> > ret = reset_control_assert(dwsmmio->rstc);
> > if (ret == -ENOTSUPP) {
> >         ret = reset_control_reset(dwsmmio->rstc);
> > } else if (!ret) {
> >         udelay(2);

Where do the 2 microseconds come from?

> >         ret = reset_control_deassert(dwsmmio->rstc);
> > }
> > if (ret)
> >         goto out;
> > 
> > * Please don't forget to add the include line.
> 
> Wow, that is ugly, and I only see one other driver doing it this way.

Which one?

> (All drivers in drivers/spi simply do assert() + udelay() +
> deassert()).

assert() will return -ENOTSUPP if the reset controller is self-
deasserting. That's why they should implement proper error handling if
the driver may be used on a platform with a self-deasserting reset
controller in the future.

> If this is the way to handle both reset control types, there should
> probably be a common helper function in drivers/reset/core.c.
> 
> Right now, I'd rather drop this patch than being guilty of copy
> pasting this pattern futher. (Considering that this patch does not
> solve any known issue.)

If it doesn't solve any issue, I'd say drop it.

> Philipp Zabel, reset controller maintainer is already on CC, would be
> nice to hear his point of view.

I would be open to reset_control_assert_delay_deassert_or_reset() kind
of helpers (not with this name) if there are multiple users. But I'd
prefer such a thing to be introduced for drivers that are actually used
both with self-deasserting reset controllers and with reset controllers
with manually controllable reset lines, with an explanation why this is
better than just using reset_control_reset() and implementing .reset()
in all relevant reset controller drivers.

regards
Philipp
