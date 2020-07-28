Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0565B230538
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jul 2020 10:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgG1IWG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 28 Jul 2020 04:22:06 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36767 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgG1IWF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jul 2020 04:22:05 -0400
X-Originating-IP: 86.206.138.11
Received: from windsurf.home (lfbn-tou-1-301-11.w86-206.abo.wanadoo.fr [86.206.138.11])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B9B91E0015;
        Tue, 28 Jul 2020 08:22:02 +0000 (UTC)
Date:   Tue, 28 Jul 2020 10:22:01 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>
Cc:     <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: High CPU load when using MAX14830 SPI UART controller
Message-ID: <20200728102201.515e2196@windsurf.home>
In-Reply-To: <070e2fa9-bacf-4d6e-a62a-63b3db55c25e@cesnet.cz>
References: <20200519163353.20c03286@windsurf.home>
        <4c5c972b-c8b8-4326-a1f9-438d88217a4a@cesnet.cz>
        <20200721155139.40fdb835@windsurf.home>
        <070e2fa9-bacf-4d6e-a62a-63b3db55c25e@cesnet.cz>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Jan,

On Tue, 21 Jul 2020 16:20:02 +0200
Jan Kundrát <jan.kundrat@cesnet.cz> wrote:

> I have no code, but according to the datasheet, it's the "RTimeout" bit 
> (Line Status Register, bit 0). If properly configured (RxTimeOut set and 
> the interrupt routing enabled via LSRIntEn[0], the "RTimeoutIEn" bit), 
> we're supposed to get ISR[0] set upon this timeout.
> 
> I have not tried it, I just read the datasheet a few years ago. When you 
> have patches, I'll be happy to test them (likely only in September, though, 
> because of vacations).

Wow, this was really useful! I had somehow missed this when glancing
through datasheet, but now that you pointed out, I implemented the
following patch, which:

 - Uses the RX timeout interrupt to fire an interrupt when there's data
   in the RX FIFO *and* no characters have been received for a duration
   equivalent to the reception time of 4 characters.

 - Uses the RX FIFO trigger interrupt to trigger an interrupt when the
   RX FIFO is half full. This ensure that if we have a continuous flow
   of data, we do get interrupts.

Thanks to that, in my scenario of receiving 20 bytes of data every
16ms, instead of having multiple interrupts each picking max 3-4 bytes
of data from the RX FIFO, I get a single interrupt that picks up the
full 20 bytes of data in one go. Result: CPU consumption goes down from
25% to 5%.

Here is the patch that I have so far. I'm waiting on more testing to
happen, and if more extensive testing is successful, I'll submit the
patch properly. The question is what are the right thresholds. In a
separate e-mail, Andy Shevchenko suggested the "4 characters timeout",
which I used arbitrarily. Same question for the RX FIFO trigger at half
the FIFO size.

Best regards,

Thomas

commit e958c6087aa889f421323314cb33ad9756ee033e
Author: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Wed Jul 22 16:18:14 2020 +0200

    serial: max310x: rework RX interrupt handling
    
    Currently, the RX interrupt logic uses the RXEMPTY interrupt, with the
    RXEMPTYINV bit set, which means we get an RX interrupt as soon as the
    RX FIFO is non-empty.
    
    However, with the MAX310X having a FIFO of 128 bytes, this makes very
    poor use of the FIFO: we trigger an interrupt as soon as the RX FIFO
    has one byte, which means a lot of interrupts, each only collecting a
    few bytes from the FIFO, causing a significant CPU load.
    
    Instead this commit relies on two other RX interrupt events:
    
     - MAX310X_IRQ_RXFIFO_BIT, which triggers when the RX FIFO has reached
       a certain threshold, which we define to be half of the FIFO
       size. This ensure we get an interrupt before the RX FIFO fills up.
    
     - MAX310X_LSR_RXTO_BIT, which triggers when the RX FIFO has received
       some bytes, and then no more bytes are received for a certain
       time. Arbitrarily, this time is defined to the time is takes to
       receive 4 characters.
    
    On a Microchip SAMA5D3 platform that is receiving 20 bytes every 16ms
    over one MAX310X UART, this patch has allowed to reduce the CPU
    consumption of the interrupt handler thread from ~25% to 6-7%.
    
    Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 8434bd5a8ec78..a1c80850d77ed 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1056,9 +1056,9 @@ static int max310x_startup(struct uart_port *port)
 	max310x_port_update(port, MAX310X_MODE1_REG,
 			    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
 
-	/* Configure MODE2 register & Reset FIFOs*/
-	val = MAX310X_MODE2_RXEMPTINV_BIT | MAX310X_MODE2_FIFORST_BIT;
-	max310x_port_write(port, MAX310X_MODE2_REG, val);
+	/* Reset FIFOs*/
+	max310x_port_write(port, MAX310X_MODE2_REG,
+			   MAX310X_MODE2_FIFORST_BIT);
 	max310x_port_update(port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_FIFORST_BIT, 0);
 
@@ -1086,8 +1086,27 @@ static int max310x_startup(struct uart_port *port)
 	/* Clear IRQ status register */
 	max310x_port_read(port, MAX310X_IRQSTS_REG);
 
-	/* Enable RX, TX, CTS change interrupts */
-	val = MAX310X_IRQ_RXEMPTY_BIT | MAX310X_IRQ_TXEMPTY_BIT;
+	/*
+	 * Let's ask for an interrupt after a timeout equivalent to
+	 * the receiving time of 4 characters after the last character
+	 * has been received.
+	 */
+	max310x_port_write(port, MAX310X_RXTO_REG, 4);
+
+	/*
+	 * Make sure we also get RX interrupts when the RX FIFO is
+	 * filling up quickly, so get an interrupt when half of the RX
+	 * FIFO has been filled in.
+	 */
+	max310x_port_write(port, MAX310X_FIFOTRIGLVL_REG,
+			   MAX310X_FIFOTRIGLVL_RX(MAX310X_FIFO_SIZE / 2));
+
+	/* Enable RX timeout interrupt in LSR */
+	max310x_port_write(port, MAX310X_LSR_IRQEN_REG,
+			   MAX310X_LSR_RXTO_BIT);
+
+	/* Enable LSR, RX FIFO trigger, CTS change interrupts */
+	val = MAX310X_IRQ_LSR_BIT  | MAX310X_IRQ_RXFIFO_BIT | MAX310X_IRQ_TXEMPTY_BIT;
 	max310x_port_write(port, MAX310X_IRQEN_REG, val | MAX310X_IRQ_CTS_BIT);
 
 	return 0;




-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
