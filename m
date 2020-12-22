Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AC22E0E51
	for <lists+linux-spi@lfdr.de>; Tue, 22 Dec 2020 19:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgLVSpR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Dec 2020 13:45:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59246 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVSpQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Dec 2020 13:45:16 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiYed115127;
        Tue, 22 Dec 2020 12:44:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608662674;
        bh=weNOJvwMIdHweOu5YL8SzPFO6rkeFp0Tn3zpeGJXxW4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OVqsAMm54Sf68CmcjFTAKn6XwMX9RHoBduLH/FeoS4IU4ZJaLwS5EeT6dxzNwDIMu
         lFWyU+gX/vUruqQ6JlqIdGo+N5Gft5D8/UTtC104srolA6jAJ56YiPExVWxcSraFJh
         gMv7pO1niEKBpo7cUNy5woTF0Jsurr5mRfZ2UwJI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BMIiYP7122959
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 12:44:34 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 12:44:34 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 12:44:34 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiQbb003761;
        Tue, 22 Dec 2020 12:44:32 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] spi: cadence-quadspi: Set dummy cycles from STIG commands
Date:   Wed, 23 Dec 2020 00:14:21 +0530
Message-ID: <20201222184425.7028-4-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201222184425.7028-1-p.yadav@ti.com>
References: <20201222184425.7028-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If a command does not have an address phase it goes via the STIG path.
The dummy cycles are not initialized for the STIG commands. As a result,
STIG commands with dummy cycles will not work.

Initialize the dummy cycle field before issuing the STIG command to make
sure it is sent correctly. Move the code to calculate dummy cycle value
to a separate function so it is not repeated twice. DTR support will add
some more logic here to it is worth it to extract it out in a function.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 5efb1f929be0..6a778014ff60 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -188,6 +188,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_CMDCTRL			0x90
 #define CQSPI_REG_CMDCTRL_EXECUTE_MASK		BIT(0)
 #define CQSPI_REG_CMDCTRL_INPROGRESS_MASK	BIT(1)
+#define CQSPI_REG_CMDCTRL_DUMMY_LSB		7
 #define CQSPI_REG_CMDCTRL_WR_BYTES_LSB		12
 #define CQSPI_REG_CMDCTRL_WR_EN_LSB		15
 #define CQSPI_REG_CMDCTRL_ADD_BYTES_LSB		16
@@ -198,6 +199,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_CMDCTRL_WR_BYTES_MASK		0x7
 #define CQSPI_REG_CMDCTRL_ADD_BYTES_MASK	0x3
 #define CQSPI_REG_CMDCTRL_RD_BYTES_MASK		0x7
+#define CQSPI_REG_CMDCTRL_DUMMY_MASK		0x1F
 
 #define CQSPI_REG_INDIRECTWR			0x70
 #define CQSPI_REG_INDIRECTWR_START_MASK		BIT(0)
@@ -288,6 +290,15 @@ static unsigned int cqspi_calc_rdreg(struct cqspi_flash_pdata *f_pdata)
 	return rdreg;
 }
 
+static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op)
+{
+	unsigned int dummy_clk;
+
+	dummy_clk = op->dummy.nbytes * 8;
+
+	return dummy_clk;
+}
+
 static int cqspi_wait_idle(struct cqspi_st *cqspi)
 {
 	const unsigned int poll_idle_retry = 3;
@@ -355,6 +366,7 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 	size_t n_rx = op->data.nbytes;
 	unsigned int rdreg;
 	unsigned int reg;
+	unsigned int dummy_clk;
 	size_t read_len;
 	int status;
 
@@ -370,6 +382,14 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 	rdreg = cqspi_calc_rdreg(f_pdata);
 	writel(rdreg, reg_base + CQSPI_REG_RD_INSTR);
 
+	dummy_clk = cqspi_calc_dummy(op);
+	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
+		return -EOPNOTSUPP;
+
+	if (dummy_clk)
+		reg |= (dummy_clk & CQSPI_REG_CMDCTRL_DUMMY_MASK)
+		     << CQSPI_REG_CMDCTRL_DUMMY_LSB;
+
 	reg |= (0x1 << CQSPI_REG_CMDCTRL_RD_EN_LSB);
 
 	/* 0 means 1 byte. */
@@ -459,7 +479,8 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	reg |= cqspi_calc_rdreg(f_pdata);
 
 	/* Setup dummy clock cycles */
-	dummy_clk = op->dummy.nbytes * 8;
+	dummy_clk = cqspi_calc_dummy(op);
+
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 		return -EOPNOTSUPP;
 
-- 
2.28.0

