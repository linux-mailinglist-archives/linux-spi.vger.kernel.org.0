Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E3C2FCBE1
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jan 2021 08:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbhATHlp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jan 2021 02:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbhATHlU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jan 2021 02:41:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6053CC0613C1
        for <linux-spi@vger.kernel.org>; Tue, 19 Jan 2021 23:40:40 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l286U-0004eK-7C; Wed, 20 Jan 2021 08:40:34 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1l286S-0001Md-2k; Wed, 20 Jan 2021 08:40:32 +0100
Date:   Wed, 20 Jan 2021 08:40:32 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 2/2] Input: ads7846: convert to one message
Message-ID: <20210120074032.2swvp7iqli6xttul@pengutronix.de>
References: <20201110085041.16303-1-o.rempel@pengutronix.de>
 <20201110085041.16303-3-o.rempel@pengutronix.de>
 <20201118003138.GD2009714@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118003138.GD2009714@dtor-ws>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:38:56 up 48 days, 21:45, 28 users,  load average: 0.00, 0.03,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Dmitry,

On Tue, Nov 17, 2020 at 04:31:38PM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 10, 2020 at 09:50:41AM +0100, Oleksij Rempel wrote:
> > Convert multiple full duplex transfers in to a single transfer to reduce
> > CPU load.
> > 
> > Current driver version support following filtering modes:
> > - ads7846_no_filter() - not filtered
> > - ads7846_debounce_filter() - driver specific debounce filter
> > - pdata->filter - platform specific debounce filter (do any platform
> > 	provides such filter?)
> > 
> > Without filter this HW is not really usable, since the physic of
> > resistive touchscreen can provide some bounce effects. With driver internal
> > filter, we have constant amount of retries + debounce retries if some anomaly
> > was detected.
> > 
> > High amount of tiny SPI transfers is the primer reason of high CPU load
> > and interrupt frequency.
> > 
> > This patch create one SPI transfer with all fields and not optional retires. If
> > bounce anomaly was detected, we will make more transfer if needed.
> > 
> > Without this patch, we will get about 10% CPU load on iMX6S on pen-down event.
> > For example by holding stylus on the screen.
> > 
> > With this patch, depending in the amount of retries, the CPU load will
> > be 1% with "ti,debounce-rep = <3>".
> > 
> > One buffer transfer allows us to use PIO FIFO or DMA engine, depending
> > on the platform.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> Applied, thank you.

I can't find this patch in your git repository. Should I rebase it
against latest git and resend it?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
