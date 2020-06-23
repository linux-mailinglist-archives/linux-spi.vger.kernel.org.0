Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431B8205ACA
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jun 2020 20:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbgFWSbK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Jun 2020 14:31:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54536 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732988AbgFWSbK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Jun 2020 14:31:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05NIUqap015214;
        Tue, 23 Jun 2020 13:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592937052;
        bh=ICZSgKDya0MZb9NLJPQdWRiZClZw58Cs4X/tbJ2rxUc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hWHhC8lpgSWnL/3edl4bB55XXcEVSlnX5q1EbEb7I+oJh8pcxGbIJifUVzi5yAXrR
         h1K6CTK++JD5IoPqaaD0ucYcvrn3ujFnNhtEON6lQUfzlaLKo34531GKjsnx5+S032
         jrjSfhsnNYQqKQ7/cfMIAfXQG0g3EgaxVDhKGdg0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05NIUqk4038437
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jun 2020 13:30:52 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 23
 Jun 2020 13:30:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 23 Jun 2020 13:30:51 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05NIUVJH000942;
        Tue, 23 Jun 2020 13:30:47 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v10 03/17] spi: atmel-quadspi: reject DTR ops
Date:   Wed, 24 Jun 2020 00:00:16 +0530
Message-ID: <20200623183030.26591-4-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200623183030.26591-1-p.yadav@ti.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Double Transfer Rate (DTR) ops are added in spi-mem. But this controller
doesn't support DTR transactions. Since we don't use the default
supports_op(), which rejects all DTR ops, do that explicitly in our
supports_op().

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/atmel-quadspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index cb44d1e169aa..a898755fb41e 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -285,6 +285,12 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 		op->dummy.nbytes == 0)
 		return false;
 
+	/* DTR ops not supported. */
+	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
+		return false;
+	if (op->cmd.nbytes != 1)
+		return false;
+
 	return true;
 }
 
-- 
2.27.0

