Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDA1314D00
	for <lists+linux-spi@lfdr.de>; Tue,  9 Feb 2021 11:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhBIK3M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Feb 2021 05:29:12 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:37722 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231796AbhBIK1J (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Feb 2021 05:27:09 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZfF85lnFz9tx3V;
        Tue,  9 Feb 2021 11:26:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id srx25kv8u0IC; Tue,  9 Feb 2021 11:26:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZfF850Jrz9tx2x;
        Tue,  9 Feb 2021 11:26:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A50188B7D6;
        Tue,  9 Feb 2021 11:26:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8p7HUzzF1Kv1; Tue,  9 Feb 2021 11:26:21 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 57B668B7D8;
        Tue,  9 Feb 2021 11:26:21 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1AD0E6733E; Tue,  9 Feb 2021 10:26:21 +0000 (UTC)
Message-Id: <99bf008e2970de7f8ed3225cda69a6d06ae1a644.1612866360.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/3] spi: mpc52xx: Avoid using get_tbl()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-spi@vger.kernel.org
Date:   Tue,  9 Feb 2021 10:26:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

get_tbl() is confusing as it returns the content TBL register
on PPC32 but the concatenation of TBL and TBU on PPC64.

Use mftb() instead.

This will allow the removal of get_tbl() in a following patch.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/spi-mpc52xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index ef2f24420460..e6a30f232370 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -120,7 +120,7 @@ static void mpc52xx_spi_start_transfer(struct mpc52xx_spi *ms)
 	ms->cs_change = ms->transfer->cs_change;
 
 	/* Write out the first byte */
-	ms->wcol_tx_timestamp = get_tbl();
+	ms->wcol_tx_timestamp = mftb();
 	if (ms->tx_buf)
 		out_8(ms->regs + SPI_DATA, *ms->tx_buf++);
 	else
@@ -221,8 +221,8 @@ static int mpc52xx_spi_fsmstate_transfer(int irq, struct mpc52xx_spi *ms,
 		 * but it can also be worked around simply by retrying the
 		 * transfer which is what we do here. */
 		ms->wcol_count++;
-		ms->wcol_ticks += get_tbl() - ms->wcol_tx_timestamp;
-		ms->wcol_tx_timestamp = get_tbl();
+		ms->wcol_ticks += mftb() - ms->wcol_tx_timestamp;
+		ms->wcol_tx_timestamp = mftb();
 		data = 0;
 		if (ms->tx_buf)
 			data = *(ms->tx_buf - 1);
@@ -247,14 +247,14 @@ static int mpc52xx_spi_fsmstate_transfer(int irq, struct mpc52xx_spi *ms,
 	/* Is the transfer complete? */
 	ms->len--;
 	if (ms->len == 0) {
-		ms->timestamp = get_tbl();
+		ms->timestamp = mftb();
 		ms->timestamp += ms->transfer->delay_usecs * tb_ticks_per_usec;
 		ms->state = mpc52xx_spi_fsmstate_wait;
 		return FSM_CONTINUE;
 	}
 
 	/* Write out the next byte */
-	ms->wcol_tx_timestamp = get_tbl();
+	ms->wcol_tx_timestamp = mftb();
 	if (ms->tx_buf)
 		out_8(ms->regs + SPI_DATA, *ms->tx_buf++);
 	else
@@ -276,7 +276,7 @@ mpc52xx_spi_fsmstate_wait(int irq, struct mpc52xx_spi *ms, u8 status, u8 data)
 		dev_err(&ms->master->dev, "spurious irq, status=0x%.2x\n",
 			status);
 
-	if (((int)get_tbl()) - ms->timestamp < 0)
+	if (((int)mftb()) - ms->timestamp < 0)
 		return FSM_POLL;
 
 	ms->message->actual_length += ms->transfer->len;
-- 
2.25.0

