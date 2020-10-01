Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFE427FA73
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbgJAHoY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 03:44:24 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50805 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHoV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 03:44:21 -0400
X-Originating-IP: 86.206.245.199
Received: from localhost (lfbn-tou-1-420-199.w86-206.abo.wanadoo.fr [86.206.245.199])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0D7FDFF80B;
        Thu,  1 Oct 2020 07:44:17 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2] serial: max310x: rework RX interrupt handling
Date:   Thu,  1 Oct 2020 09:44:15 +0200
Message-Id: <20201001074415.349739-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

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
---
Changes since v1:
- Fix missing space when closing a comment
---
 drivers/tty/serial/max310x.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 8434bd5a8ec7..21130af106bb 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1056,9 +1056,9 @@ static int max310x_startup(struct uart_port *port)
 	max310x_port_update(port, MAX310X_MODE1_REG,
 			    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
 
-	/* Configure MODE2 register & Reset FIFOs*/
-	val = MAX310X_MODE2_RXEMPTINV_BIT | MAX310X_MODE2_FIFORST_BIT;
-	max310x_port_write(port, MAX310X_MODE2_REG, val);
+	/* Reset FIFOs */
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
2.26.2

