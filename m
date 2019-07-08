Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D776A61F5D
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2019 15:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfGHNMu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jul 2019 09:12:50 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52255 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfGHNMu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Jul 2019 09:12:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hkTRn-0001zX-E0; Mon, 08 Jul 2019 15:12:47 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hkTRk-0003nn-Uo; Mon, 08 Jul 2019 15:12:44 +0200
Date:   Mon, 8 Jul 2019 15:12:44 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>,
        linux-spi@vger.kernel.org
Subject: glitch in spi-imx rxready irq assertion?
Message-ID: <20190708131244.q3cbjrtneputkkds@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

I currently try to pin down a problem reported by a customer. They do
repeated read/write operations to an MRAM connected via SPI to an i.MX6
running Linux 4.14 with a few spi-Patches backported (
e697271c4e29 ("spi: imx: add a device specific prepare_message callback")
00b80ac93553 ("spi: imx: mx51-ecspi: Move some initialisation to prepare_message hook.")
). We only use PIO because of some problems we saw disappearing when DMA
is disabled.

Sometimes the machine logs an I/O error and after that hangs, sometimes
the whole machine is not responsive any more (not entirely sure this is
related).

Applying some tracing I see:

After a big transfer (4096 bytes) that completed successfully another 4
bytes are written to the hardware. Then the irq routine[1] is called,
->rx_available returns false, ->count is zero and ->txfifo is still
non-zero. So the irq triggered because the TX-fifo was empty but there
wasn't yet data available to receive and so the RR irq got enabled. The
RR-irq doesn't trigger during the next two seconds however.

Does this ring a bell for you? Is there maybe a glitch that the RR-irq
doesn't trigger in such a case?

The obvious workaround would be to enable RR (or RDR) before starting to
write data to the FIFO.
The problem isn't easy to reproduce and I'm unsure if I can resolve the
problem as fixed when it doesn't reappear after that change. So some
input from your side that confirms my suspicion would be great.

I'd also make sure that no FIFO overflow happened (using the
RO interrupt) but I don't expect any relevant insights here.

Best regards
Uwe

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-imx.c?h=v4.14#n951

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
