Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A17630F4BE
	for <lists+linux-spi@lfdr.de>; Thu,  4 Feb 2021 15:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbhBDORc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Feb 2021 09:17:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47280 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbhBDONW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Feb 2021 09:13:22 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 114ECM6Y098588;
        Thu, 4 Feb 2021 08:12:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612447942;
        bh=vSix/bWL9afVl8T+g4konnqAhGR2zbbqyEmN8MzpnlA=;
        h=From:To:CC:Subject:Date;
        b=qUXtEhkGs2mIduc2HQILwwkG9NT4af3s7swC7DGS/k3hBlCXPxC7fTV8rAoMYWeZ8
         1J0HpHJquQXbvKO3FFEV/JnCXuv81brXkBi72Sb4njSQZcXhLsikRMzzwIjXl/qJSV
         fVrMlClfsBtSDrxZgRHthTpAWqQrrnbpY0i3sK7k=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 114ECM3v033783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Feb 2021 08:12:22 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Feb
 2021 08:12:21 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Feb 2021 08:12:21 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 114ECJIt123632;
        Thu, 4 Feb 2021 08:12:20 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, <zhengxunli@mxic.com.tw>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 1/2] spi: spi-mem: add spi_mem_dtr_supports_op()
Date:   Thu, 4 Feb 2021 19:42:17 +0530
Message-ID: <20210204141218.32229-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi_mem_default_supports_op() rejects DTR ops by default to ensure that
the controller drivers that haven't been updated with DTR support
continue to reject them. It also makes sure that controllers that don't
support DTR mode at all (which is most of them at the moment) also
reject them.

This means that controller drivers that want to support DTR mode can't
use spi_mem_default_supports_op(). Driver authors have to roll their own
supports_op() function and mimic the buswidth checks. See
spi-cadence-quadspi.c for example. Or even worse, driver authors might
skip it completely or get it wrong.

Add spi_mem_dtr_supports_op(). It provides a basic sanity check for DTR
ops and performs the buswidth requirement check. Move the logic for
checking buswidth in spi_mem_default_supports_op() to a separate
function so the logic is not repeated twice.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-mem.c       | 22 +++++++++++++++++++---
 include/linux/spi/spi-mem.h |  9 +++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c64371ce6c38..dc713b0c3c4d 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -137,8 +137,8 @@ static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
 	return -ENOTSUPP;
 }
 
-bool spi_mem_default_supports_op(struct spi_mem *mem,
-				 const struct spi_mem_op *op)
+static bool spi_mem_check_buswidth(struct spi_mem *mem,
+				   const struct spi_mem_op *op)
 {
 	if (spi_check_buswidth_req(mem, op->cmd.buswidth, true))
 		return false;
@@ -156,13 +156,29 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 				   op->data.dir == SPI_MEM_DATA_OUT))
 		return false;
 
+	return true;
+}
+
+bool spi_mem_dtr_supports_op(struct spi_mem *mem,
+			     const struct spi_mem_op *op)
+{
+	if (op->cmd.nbytes != 2)
+		return false;
+
+	return spi_mem_check_buswidth(mem, op);
+}
+EXPORT_SYMBOL_GPL(spi_mem_dtr_supports_op);
+
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
 	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
 		return false;
 
 	if (op->cmd.nbytes != 1)
 		return false;
 
-	return true;
+	return spi_mem_check_buswidth(mem, op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
 
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 159463cc659c..2b65c9edc34e 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -311,6 +311,9 @@ void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op);
 
+bool spi_mem_dtr_supports_op(struct spi_mem *mem,
+			     const struct spi_mem_op *op);
+
 #else
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
@@ -334,6 +337,12 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 	return false;
 }
 
+static inline
+bool spi_mem_dtr_supports_op(struct spi_mem *mem,
+			     const struct spi_mem_op *op)
+{
+	return false;
+}
 #endif /* CONFIG_SPI_MEM */
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
-- 
2.30.0

