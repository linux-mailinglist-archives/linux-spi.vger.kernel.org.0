Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4F31DF0A5
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 22:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgEVUaN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 16:30:13 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45643 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbgEVUaN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 16:30:13 -0400
X-Originating-IP: 157.36.98.60
Received: from localhost (unknown [157.36.98.60])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 684321C0009;
        Fri, 22 May 2020 20:30:05 +0000 (UTC)
Date:   Sat, 23 May 2020 02:00:02 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 02/20] spi: spi-mem: allow specifying a command's
 extension
Message-ID: <20200522203002.3bztaxrz7rxmbzgt@yadavpratyush.com>
References: <20200522101301.26909-1-p.yadav@ti.com>
 <20200522101301.26909-3-p.yadav@ti.com>
 <20200522173254.05316d47@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522173254.05316d47@collabora.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22/05/20 05:32PM, Boris Brezillon wrote:
> On Fri, 22 May 2020 15:42:43 +0530
> Pratyush Yadav <p.yadav@ti.com> wrote:
> 
> > In xSPI mode, flashes expect 2-byte opcodes. The second byte is called
> > the "command extension". There can be 3 types of extensions in xSPI:
> > repeat, invert, and hex. When the extension type is "repeat", the same
> > opcode is sent twice. When it is "invert", the second byte is the
> > inverse of the opcode. When it is "hex" an additional opcode byte based
> > is sent with the command whose value can be anything.
> > 
> > So, make opcode a 16-bit value and add a 'nbytes', similar to how
> > multiple address widths are handled.
> 
> A slightly different version of patch 5 should go before this patch,
> otherwise your series is not bisectable. By slightly different, I mean
> that you should only write one byte, but put this byte in a temporary
> var. Or maybe you can squash patch 5 in this one and mention why you do
> so in your commit message.

How about the patch below before this patch? The supports_op() will 
reject multi-byte opcodes anyway, so we only care about single-byte 
opcodes for now. Multi-byte opcodes can be patched and tested later. 
This avoids squashing changes in this patch and having the changes split 
over two patches; one before and one after.

-- 8< --
diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 69491f3a515d..4e4292f0ee1d 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -356,6 +356,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	int nio = 1, i, ret;
 	u32 ss_ctrl;
 	u8 addr[8];
+	u8 opcode = op->cmd.opcode & 0xff;
 
 	ret = mxic_spi_set_freq(mxic, mem->spi->max_speed_hz);
 	if (ret)
@@ -393,7 +394,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
 	       mxic->regs + HC_CFG);
 
-	ret = mxic_spi_data_xfer(mxic, &op->cmd.opcode, NULL, 1);
+	ret = mxic_spi_data_xfer(mxic, &opcode, NULL, 1);
 	if (ret)
 		goto out;
 
-- 
Regards,
Pratyush Yadav
