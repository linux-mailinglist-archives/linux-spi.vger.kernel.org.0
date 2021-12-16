Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36379476FFF
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 12:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhLPLRa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 06:17:30 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53625 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhLPLRa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 06:17:30 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C94E0E0010;
        Thu, 16 Dec 2021 11:17:27 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v6 18/28] spi: spi-mem: Fix a DTR related check in spi_mem_dtr_supports_op()
Date:   Thu, 16 Dec 2021 12:16:44 +0100
Message-Id: <20211216111654.238086-19-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216111654.238086-1-miquel.raynal@bootlin.com>
References: <20211216111654.238086-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It seems that the number of command bytes must be "2" only when the
command itself is sent in DTR mode. The current logic checks if the
number of command bytes is "2" when any of the cycles is a DTR cycle. It
is likely that so far no device was actually mixing DTR/non-DTR cycles
in the same operation, explaining why this was left undetected until
now.

Fixes: 539cf68cd51b ("spi: spi-mem: add spi_mem_dtr_supports_op()")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 37f4443ce9a0..c4da0c9b05e9 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -163,7 +163,7 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
 bool spi_mem_dtr_supports_op(struct spi_mem *mem,
 			     const struct spi_mem_op *op)
 {
-	if (op->cmd.nbytes != 2)
+	if (op->cmd.dtr && op->cmd.nbytes != 2)
 		return false;
 
 	return spi_mem_check_buswidth(mem, op);
-- 
2.27.0

