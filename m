Return-Path: <linux-spi+bounces-2778-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F9C8BF8BD
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 10:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBD1285E38
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 08:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3287173A;
	Wed,  8 May 2024 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nfqIbQlw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32E548F5;
	Wed,  8 May 2024 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157441; cv=none; b=IMkTQtbginP+RGyYqUChC7ppK935nSWSh2+Mgj718o9Idln3c0o99BKHKFvbdaX++kPt5sQzt8UmHRenyl3dWrFUdqNIlL+SlZIEn50ofQCH0IAtM6qEnsck4QLiZbRbHcyvFf2peE6dit8uP/8qzs7ZquomasVms3Ow5Z6Tu08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157441; c=relaxed/simple;
	bh=Eg5fgsy2lBjiUko+T/nyRk2RsnElqhqwOEuwfhVYdYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhltbpjg5dwTEbrlBXbhXh0pqn8emg5w3Xx4NdCX7HU+eE4IOJEX8zMJMShEjHmIzEH0Q3jIWsEId/B6BaTiFgTrbzBTLGCRtNxhxt/akAAa8Ml9zciUGqqZlVUyX+yetj6DrigNk1GycqybaxDRdvQBnavSEzsfavWzAkclC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nfqIbQlw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4484b5DF013395;
	Wed, 8 May 2024 08:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=PiKsz7K
	LTJySuNT9gg20cpph2vKBZ2wfsidCuN/Dh5s=; b=nfqIbQlwM3KEQ9laYmUBlLm
	8kUWjo7wRXZI0TA0atkzHw1HMe/DZ1KCUgpBPNJwKqqCtDmCFpBTHn6dXhkzAy4S
	RDrVSkNlcEX8yIAhAVFKFucrWjfbE/LLww3cb6oPBybv5n0gtRwB24GuURykPX2S
	9X882zmmopso+jkQpR6TvoRHs/DD1V2jq9SDJYVAJjC1mkVIRYr6klOB/3LiYT0S
	xX+ZufptbqQoqSQkR4Pued6ISj9ERUndwTIMGls43vbghRDgemmvGW6IiKO9s/i/
	bPsPzA9bzuosRNIyy6Hhhj9kfAOzeWx637RtBFGMBeo7NTQuCV324rTi5t8A5yg=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xysph1c9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 08:36:45 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4488afGD001208;
	Wed, 8 May 2024 08:36:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xwe3kwchu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 08:36:42 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4488aQWp000641;
	Wed, 8 May 2024 08:36:42 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4488afOA001245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 08:36:42 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 1D3A64163B; Wed,  8 May 2024 14:06:40 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        quic_mdalam@quicinc.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v5 5/7] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
Date: Wed,  8 May 2024 14:06:35 +0530
Message-Id: <20240508083637.3744003-6-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
References: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6RH9D41oGwwVQD9EQTHTqC1YJgvx_G7d
X-Proofpoint-GUID: 6RH9D41oGwwVQD9EQTHTqC1YJgvx_G7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_04,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080060

This driver implements support for the SPI-NAND mode of QCOM NAND Flash
Interface as a SPI-MEM controller with pipelined ECC capability.

Tested-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v5]

* Added raw_read() and raw_write() api

* Updated commit message

* Removed register indirection

* Added qcom_spi_ prefix to all the api

* Removed snand_set_reg() api.

* Fixed nandbiterr issue

* Removed hardcoded num_cw and made it variable

* Removed hardcoded value for mtd pagesize

* Added -ENOSUPPORT in cmd mapping for unsupported
  commands

* Replace if..else with switch..case statement

Change in [v4]

* No change

Change in [v3]

* Set SPI_QPIC_SNAND to n and added COMPILE_TEST in Kconfig

* Made driver name sorted in Make file

* Made comment like c++

* Changed macro to functions, snandc_set_read_loc_last()
  and snandc_set_read_loc_first()

* Added error handling in snandc_set_reg()

* Changed into normal conditional statement for
  return snandc->ecc_stats.failed ? -EBADMSG :
  snandc->ecc_stats.bitflips;

* Remove cast of wbuf in qpic_snand_program_execute()
  function

* Made num_cw variable instead hardcoded value

* changed if..else condition of function qpic_snand_io_op()
  to switch..case statement

* Added __devm_spi_alloc_controller() api instead of
  devm_spi_alloc_master()

* Disabling clock in remove path

Change in [v2]

* Added initial support for SPI-NAND driver

Change in [v1]

* Added RFC patch for design review

 drivers/spi/Kconfig                  |    8 +
 drivers/spi/Makefile                 |    1 +
 drivers/spi/spi-qpic-snand.c         | 1423 ++++++++++++++++++++++++++
 include/linux/mtd/nand-qpic-common.h |   64 ++
 4 files changed, 1496 insertions(+)
 create mode 100644 drivers/spi/spi-qpic-snand.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a2c99ff33e0a..a5d33fd57d52 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -892,6 +892,14 @@ config SPI_QCOM_QSPI
 	help
 	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
 
+config SPI_QPIC_SNAND
+	tristate "QPIC SNAND controller"
+	depends on (ARCH_QCOM || COMPILE_TEST) && QPIC_COMMON
+	help
+	  QPIC_SNAND (QPIC SPI NAND) driver for Qualcomm QPIC controller.
+	  QPIC controller supports both parallel nand and serial nand.
+	  This config will enable serial nand driver for QPIC controller.
+
 config SPI_QUP
 	tristate "Qualcomm SPI controller with QUP interface"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index e694254dec04..536292292bc5 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_SPI_PXA2XX)		+= spi-pxa2xx-platform.o
 obj-$(CONFIG_SPI_PXA2XX_PCI)		+= spi-pxa2xx-pci.o
 obj-$(CONFIG_SPI_QCOM_GENI)		+= spi-geni-qcom.o
 obj-$(CONFIG_SPI_QCOM_QSPI)		+= spi-qcom-qspi.o
+obj-$(CONFIG_SPI_QPIC_SNAND)            += spi-qpic-snand.o
 obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
 obj-$(CONFIG_SPI_ROCKCHIP_SFC)		+= spi-rockchip-sfc.o
diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
new file mode 100644
index 000000000000..f32fa5e40937
--- /dev/null
+++ b/drivers/spi/spi-qpic-snand.c
@@ -0,0 +1,1423 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * Authors:
+ *	Md Sadre Alam <quic_mdalam@quicinc.com>
+ *	Sricharan R <quic_srichara@quicinc.com>
+ *	Varadarajan Narayanan <quic_varada@quicinc.com>
+ */
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/qcom_adm.h>
+#include <linux/dma/qcom_bam_dma.h>
+#include <linux/module.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mtd/nand-qpic-common.h>
+#include <linux/mtd/spinand.h>
+
+#define NAND_FLASH_SPI_CFG		0xc0
+#define NAND_NUM_ADDR_CYCLES		0xc4
+#define NAND_BUSY_CHECK_WAIT_CNT	0xc8
+#define NAND_FLASH_FEATURES		0xf64
+
+/* QSPI NAND config reg bits */
+#define LOAD_CLK_CNTR_INIT_EN   BIT(28)
+#define CLK_CNTR_INIT_VAL_VEC   0x924
+#define FEA_STATUS_DEV_ADDR     0xc0
+#define SPI_CFG			BIT(0)
+#define SPI_NUM_ADDR		0xDA4DB
+#define SPI_WAIT_CNT		0x10
+#define QPIC_QSPI_NUM_CS	1
+#define SPI_TRANSFER_MODE_x1	BIT(29)
+#define SPI_TRANSFER_MODE_x4	(3 << 29)
+#define SPI_WP			BIT(28)
+#define SPI_HOLD		BIT(27)
+#define QPIC_SET_FEATURE	BIT(31)
+
+#define SPINAND_RESET		0xff
+#define SPINAND_READID		0x9f
+#define SPINAND_GET_FEATURE	0x0f
+#define SPINAND_SET_FEATURE	0x1f
+#define SPINAND_READ		0x13
+#define SPINAND_ERASE		0xd8
+#define SPINAND_WRITE_EN	0x06
+#define SPINAND_PROGRAM_EXECUTE	0x10
+#define SPINAND_PROGRAM_LOAD	0x84
+
+#define ACC_FEATURE		0xe
+#define BAD_BLOCK_MARKER_SIZE	0x2
+#define OOB_BUF_SIZE		128
+
+struct qpic_snand_op {
+	u32 cmd_reg;
+	u32 addr1_reg;
+	u32 addr2_reg;
+};
+
+struct snandc_read_status {
+	__le32 snandc_flash;
+	__le32 snandc_buffer;
+	__le32 snandc_erased_cw;
+};
+
+static void qcom_spi_set_read_loc_first(struct qcom_nand_controller *snandc,
+					int reg, int cw_offset, int read_size,
+					int is_last_read_loc)
+{
+	int val = (((cw_offset) << READ_LOCATION_OFFSET) |
+		  ((read_size) << READ_LOCATION_SIZE) | ((is_last_read_loc)
+		  << READ_LOCATION_LAST));
+
+	if (reg == NAND_READ_LOCATION_0)
+		snandc->regs->read_location0 = val;
+	else if (reg == NAND_READ_LOCATION_1)
+		snandc->regs->read_location1 = val;
+	else if (reg == NAND_READ_LOCATION_2)
+		snandc->regs->read_location1 = val;
+	else if (reg == NAND_READ_LOCATION_3)
+		snandc->regs->read_location3 = val;
+}
+
+static void qcom_spi_set_read_loc_last(struct qcom_nand_controller *snandc,
+				       int reg, int cw_offset, int read_size,
+				       int is_last_read_loc)
+{
+	int val = (((cw_offset) << READ_LOCATION_OFFSET) |
+		  ((read_size) << READ_LOCATION_SIZE) | ((is_last_read_loc)
+		  << READ_LOCATION_LAST));
+
+	if (reg == NAND_READ_LOCATION_LAST_CW_0)
+		snandc->regs->read_location_last0 = val;
+	else if (reg == NAND_READ_LOCATION_LAST_CW_1)
+		snandc->regs->read_location_last1 = val;
+	else if (reg == NAND_READ_LOCATION_LAST_CW_2)
+		snandc->regs->read_location_last2 = val;
+	else if (reg == NAND_READ_LOCATION_LAST_CW_3)
+		snandc->regs->read_location_last3 = val;
+}
+
+static struct qcom_nand_controller *nand_to_qcom_snand(struct nand_device *nand)
+{
+	struct nand_ecc_engine *eng = nand->ecc.engine;
+
+	return container_of(eng, struct qcom_nand_controller, ecc_eng);
+}
+
+static int qcom_spi_init(struct qcom_nand_controller *snandc)
+{
+	u32 snand_cfg_val = 0x0;
+	int ret;
+
+	snand_cfg_val |= (LOAD_CLK_CNTR_INIT_EN | (CLK_CNTR_INIT_VAL_VEC << 16) |
+			 (FEA_STATUS_DEV_ADDR << 8) | SPI_CFG);
+
+	snandc->regs->spi_cfg = snand_cfg_val;
+	snandc->regs->num_addr_cycle = SPI_NUM_ADDR;
+	snandc->regs->busy_wait_cnt = SPI_WAIT_CNT;
+
+	qcom_write_reg_dma(snandc, &snandc->regs->spi_cfg, NAND_FLASH_SPI_CFG, 1, 0);
+
+	snand_cfg_val &= ~LOAD_CLK_CNTR_INIT_EN;
+	snandc->regs->spi_cfg = snand_cfg_val;
+
+	qcom_write_reg_dma(snandc, &snandc->regs->spi_cfg, NAND_FLASH_SPI_CFG, 1, 0);
+
+	qcom_write_reg_dma(snandc, &snandc->regs->num_addr_cycle, NAND_NUM_ADDR_CYCLES, 1, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->busy_wait_cnt, NAND_BUSY_CHECK_WAIT_CNT, 1,
+			   NAND_BAM_NEXT_SGL);
+
+	ret = qcom_submit_descs(snandc);
+	if (ret) {
+		dev_err(snandc->dev, "failure in submitting spi init descriptor\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
+	struct qpic_ecc *qecc = snandc->ecc;
+
+	if (section > 1)
+		return -ERANGE;
+
+	if (!section) {
+		oobregion->length = (qecc->bytes * (qecc->steps - 1)) + qecc->bbm_size;
+		oobregion->offset = 0;
+	} else {
+		oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
+		oobregion->offset = mtd->oobsize - oobregion->length;
+	}
+
+	return 0;
+}
+
+static int qcom_spi_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobregion)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
+	struct qpic_ecc *qecc = snandc->ecc;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = qecc->steps * 4;
+	oobregion->offset = ((qecc->steps - 1) * qecc->bytes) + qecc->bbm_size;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops qcom_spi_ooblayout = {
+	.ecc = qcom_spi_ooblayout_ecc,
+	.free = qcom_spi_ooblayout_free,
+};
+
+static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
+{
+	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
+	struct nand_ecc_props *conf = &nand->ecc.ctx.conf;
+	struct nand_ecc_props *reqs = &nand->ecc.requirements;
+	struct nand_ecc_props *user = &nand->ecc.user_conf;
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	int step_size = 0, strength = 0, steps;
+	int cwperpage, bad_block_byte;
+	struct qpic_ecc *ecc_cfg;
+
+	cwperpage = mtd->writesize / NANDC_STEP_SIZE;
+	snandc->num_cw = cwperpage;
+
+	ecc_cfg = kzalloc(sizeof(*ecc_cfg), GFP_KERNEL);
+	if (!ecc_cfg)
+		return -ENOMEM;
+
+	nand->ecc.ctx.priv = ecc_cfg;
+
+	if (user->step_size && user->strength) {
+		step_size = user->step_size;
+		strength = user->strength;
+	} else if (reqs->step_size && reqs->strength) {
+		step_size = reqs->step_size;
+		strength = reqs->strength;
+	}
+
+	if (step_size && strength)
+		steps = mtd->writesize / step_size;
+
+	ecc_cfg->ecc_bytes_hw = 7;
+	ecc_cfg->spare_bytes = 4;
+	ecc_cfg->bbm_size = 1;
+	ecc_cfg->bch_enabled = true;
+	ecc_cfg->bytes = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes + ecc_cfg->bbm_size;
+
+	ecc_cfg->steps = 4;
+	ecc_cfg->strength = 4;
+	ecc_cfg->step_size = 512;
+
+	mtd_set_ooblayout(mtd, &qcom_spi_ooblayout);
+
+	ecc_cfg->cw_data = 516;
+	ecc_cfg->cw_size = ecc_cfg->cw_data + ecc_cfg->bytes;
+	bad_block_byte = mtd->writesize - ecc_cfg->cw_size * (cwperpage - 1) + 1;
+
+	ecc_cfg->cfg0 = (cwperpage - 1) << CW_PER_PAGE
+				| ecc_cfg->cw_data << UD_SIZE_BYTES
+				| 1 << DISABLE_STATUS_AFTER_WRITE
+				| 3 << NUM_ADDR_CYCLES
+				| ecc_cfg->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_RS
+				| 0 << STATUS_BFR_READ
+				| 1 << SET_RD_MODE_AFTER_STATUS
+				| ecc_cfg->spare_bytes << SPARE_SIZE_BYTES;
+
+	ecc_cfg->cfg1 = 0 << NAND_RECOVERY_CYCLES
+				| 0 <<  CS_ACTIVE_BSY
+				| bad_block_byte << BAD_BLOCK_BYTE_NUM
+				| 0 << BAD_BLOCK_IN_SPARE_AREA
+				| 20 << WR_RD_BSY_GAP
+				| 0 << WIDE_FLASH
+				| ecc_cfg->bch_enabled << ENABLE_BCH_ECC;
+
+	ecc_cfg->cfg0_raw = (cwperpage - 1) << CW_PER_PAGE
+				| ecc_cfg->cw_size << UD_SIZE_BYTES
+				| 3 << NUM_ADDR_CYCLES
+				| 0 << SPARE_SIZE_BYTES;
+
+	ecc_cfg->cfg1_raw = 0 << NAND_RECOVERY_CYCLES
+				| 0 << CS_ACTIVE_BSY
+				| 17 << BAD_BLOCK_BYTE_NUM
+				| 1 << BAD_BLOCK_IN_SPARE_AREA
+				| 20 << WR_RD_BSY_GAP
+				| 0 << WIDE_FLASH
+				| 1 << DEV0_CFG1_ECC_DISABLE;
+
+	ecc_cfg->ecc_bch_cfg = !ecc_cfg->bch_enabled << ECC_CFG_ECC_DISABLE
+				| 0 << ECC_SW_RESET
+				| ecc_cfg->cw_data << ECC_NUM_DATA_BYTES
+				| 1 << ECC_FORCE_CLK_OPEN
+				| 0 << ECC_MODE
+				| ecc_cfg->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_BCH;
+
+	ecc_cfg->ecc_buf_cfg = 0x203 << NUM_STEPS;
+	ecc_cfg->clrflashstatus = FS_READY_BSY_N;
+	ecc_cfg->clrreadstatus = 0xc0;
+
+	conf->step_size = ecc_cfg->step_size;
+	conf->strength = ecc_cfg->strength;
+
+	snandc->regs->erased_cw_detect_cfg_clr = cpu_to_le32(CLR_ERASED_PAGE_DET);
+	snandc->regs->erased_cw_detect_cfg_set = cpu_to_le32(SET_ERASED_PAGE_DET);
+
+	dev_dbg(snandc->dev, "ECC strength: %u bits per %u bytes\n",
+		ecc_cfg->strength, ecc_cfg->step_size);
+
+	return 0;
+}
+
+static void qcom_spi_ecc_cleanup_ctx_pipelined(struct nand_device *nand)
+{
+	struct qpic_ecc *ecc_cfg = nand_to_ecc_ctx(nand);
+
+	kfree(ecc_cfg);
+}
+
+static int qcom_spi_ecc_prepare_io_req_pipelined(struct nand_device *nand,
+						 struct nand_page_io_req *req)
+{
+	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
+	struct qpic_ecc *ecc_cfg = nand_to_ecc_ctx(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+
+	snandc->pagesize = mtd->writesize;
+	snandc->ecc = ecc_cfg;
+	snandc->raw_rw = false;
+	snandc->oob_rw = false;
+	snandc->page_rw = false;
+
+	if (req->datalen)
+		snandc->page_rw = true;
+
+	if (req->ooblen) {
+		snandc->oob_rw = true;
+		if (req->ooblen == BAD_BLOCK_MARKER_SIZE)
+			snandc->read_last_cw = true;
+	}
+
+	if (req->mode == MTD_OPS_RAW)
+		snandc->raw_rw = true;
+
+	return 0;
+}
+
+static int qcom_spi_ecc_finish_io_req_pipelined(struct nand_device *nand,
+						struct nand_page_io_req *req)
+{
+	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+
+	if (req->mode == MTD_OPS_RAW || req->type != NAND_PAGE_READ)
+		return 0;
+
+	if (snandc->ecc_stats.failed)
+		mtd->ecc_stats.failed += snandc->ecc_stats.failed;
+	mtd->ecc_stats.corrected += snandc->ecc_stats.corrected;
+
+	if (snandc->ecc_stats.failed)
+		return -EBADMSG;
+	else
+		return snandc->ecc_stats.bitflips;
+}
+
+static struct nand_ecc_engine_ops qcom_spi_ecc_engine_ops_pipelined = {
+	.init_ctx = qcom_spi_ecc_init_ctx_pipelined,
+	.cleanup_ctx = qcom_spi_ecc_cleanup_ctx_pipelined,
+	.prepare_io_req = qcom_spi_ecc_prepare_io_req_pipelined,
+	.finish_io_req = qcom_spi_ecc_finish_io_req_pipelined,
+};
+
+/* helper to configure location register values */
+static void qcom_spi_set_read_loc(struct qcom_nand_controller *snandc, int cw, int reg,
+				  int cw_offset, int read_size, int is_last_read_loc)
+{
+	int reg_base = NAND_READ_LOCATION_0;
+	int num_cw = snandc->num_cw;
+
+	if (cw == (num_cw - 1))
+		reg_base = NAND_READ_LOCATION_LAST_CW_0;
+
+	reg_base += reg * 4;
+
+	if (cw == (num_cw - 1))
+		return qcom_spi_set_read_loc_last(snandc, reg_base, cw_offset,
+						  read_size, is_last_read_loc);
+	else
+		return qcom_spi_set_read_loc_first(snandc, reg_base, cw_offset,
+						   read_size, is_last_read_loc);
+}
+
+static void
+qcom_spi_config_cw_read(struct qcom_nand_controller *snandc, bool use_ecc, int cw)
+{
+	__le32 *reg = &snandc->regs->read_location0;
+	int num_cw = snandc->num_cw;
+
+	qcom_write_reg_dma(snandc, reg, NAND_READ_LOCATION_0, 4, NAND_BAM_NEXT_SGL);
+	if (cw == (num_cw - 1)) {
+		reg = &snandc->regs->read_location_last0;
+		qcom_write_reg_dma(snandc, reg, NAND_READ_LOCATION_LAST_CW_0, 4,
+				   NAND_BAM_NEXT_SGL);
+	}
+
+	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+
+	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 2, 0);
+	qcom_read_reg_dma(snandc, NAND_ERASED_CW_DETECT_STATUS, 1,
+			  NAND_BAM_NEXT_SGL);
+}
+
+static int qcom_spi_block_erase(struct qcom_nand_controller *snandc)
+{
+	struct qpic_ecc *ecc_cfg = snandc->ecc;
+	int ret;
+
+	snandc->buf_count = 0;
+	snandc->buf_start = 0;
+	qcom_clear_read_regs(snandc);
+	qcom_clear_bam_transaction(snandc);
+
+	snandc->regs->cmd = snandc->cmd;
+	snandc->regs->addr0 = snandc->addr1;
+	snandc->regs->addr1 = snandc->addr2;
+	snandc->regs->cfg0 = ecc_cfg->cfg0_raw & ~(7 << CW_PER_PAGE);
+	snandc->regs->cfg1 = ecc_cfg->cfg1_raw;
+	snandc->regs->exec = 1;
+
+	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+
+	ret = qcom_submit_descs(snandc);
+	if (ret) {
+		dev_err(snandc->dev, "failure to erase block\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void qcom_spi_config_single_cw_page_read(struct qcom_nand_controller *snandc,
+						bool use_ecc, int cw)
+{
+	__le32 *reg = &snandc->regs->read_location0;
+	int num_cw = snandc->num_cw;
+
+	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_clr,
+			   NAND_ERASED_CW_DETECT_CFG, 1, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_set,
+			   NAND_ERASED_CW_DETECT_CFG, 1,
+			   NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
+
+	if (cw == (num_cw - 1)) {
+		reg = &snandc->regs->read_location_last0;
+		qcom_write_reg_dma(snandc, reg, NAND_READ_LOCATION_LAST_CW_0, 4, NAND_BAM_NEXT_SGL);
+	}
+	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+
+	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 1, 0);
+}
+
+static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
+				 const struct spi_mem_op *op)
+{
+	struct qpic_ecc *ecc_cfg = snandc->ecc;
+	int size, ret = 0;
+	int col,  bbpos;
+	u32 cfg0, cfg1, ecc_bch_cfg;
+	u32 num_cw = snandc->num_cw;
+
+	qcom_clear_bam_transaction(snandc);
+	qcom_clear_read_regs(snandc);
+
+	size = ecc_cfg->cw_size;
+	col = ecc_cfg->cw_size * (num_cw - 1);
+
+	memset(snandc->data_buffer, 0xff, size);
+	snandc->regs->addr0 = (snandc->addr1 | col);
+	snandc->regs->addr1 = snandc->addr2;
+
+	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
+		0 << CW_PER_PAGE;
+	cfg1 = ecc_cfg->cfg1_raw;
+	ecc_bch_cfg = 1 << ECC_CFG_ECC_DISABLE;
+
+	snandc->regs->cmd = snandc->cmd;
+	snandc->regs->cfg0 = cfg0;
+	snandc->regs->cfg1 = cfg1;
+	snandc->regs->ecc_bch_cfg = ecc_bch_cfg;
+	snandc->regs->clrflashstatus = ecc_cfg->clrflashstatus;
+	snandc->regs->clrreadstatus = ecc_cfg->clrreadstatus;
+	snandc->regs->exec = 1;
+
+	qcom_spi_set_read_loc(snandc, num_cw - 1, 0, 0, ecc_cfg->cw_size, 1);
+
+	qcom_spi_config_single_cw_page_read(snandc, false, num_cw - 1);
+
+	qcom_read_data_dma(snandc, FLASH_BUF_ACC, snandc->data_buffer, size, 0);
+
+	ret = qcom_submit_descs(snandc);
+	if (ret) {
+		dev_err(snandc->dev, "failed to read last cw\n");
+		return ret;
+	}
+
+	qcom_nandc_dev_to_mem(snandc, true);
+	u32 flash = le32_to_cpu(snandc->reg_read_buf[0]);
+
+	if (flash & (FS_OP_ERR | FS_MPU_ERR))
+		return -EIO;
+
+	bbpos = snandc->pagesize - ecc_cfg->cw_size * (num_cw - 1);
+
+	if (snandc->data_buffer[bbpos] == 0xff)
+		snandc->data_buffer[bbpos + 1] = 0xff;
+	if (snandc->data_buffer[bbpos] != 0xff)
+		snandc->data_buffer[bbpos + 1] = snandc->data_buffer[bbpos];
+
+	memcpy(op->data.buf.in, snandc->data_buffer + bbpos, op->data.nbytes);
+
+	return ret;
+}
+
+static int qcom_spi_check_error(struct qcom_nand_controller *snandc, u8 *data_buf, u8 *oob_buf)
+{
+	struct snandc_read_status *buf;
+	struct qpic_ecc *ecc_cfg = snandc->ecc;
+	int i, num_cw = snandc->num_cw;
+	bool flash_op_err = false, erased;
+	unsigned int max_bitflips = 0;
+	unsigned int uncorrectable_cws = 0;
+
+	snandc->ecc_stats.failed = 0;
+	snandc->ecc_stats.corrected = 0;
+
+	qcom_nandc_dev_to_mem(snandc, true);
+	buf = (struct snandc_read_status *)snandc->reg_read_buf;
+
+	for (i = 0; i < num_cw; i++, buf++) {
+		u32 flash, buffer, erased_cw;
+		int data_len, oob_len;
+
+		if (i == (num_cw - 1)) {
+			data_len = NANDC_STEP_SIZE - ((num_cw - 1) << 2);
+			oob_len = num_cw << 2;
+		} else {
+			data_len = ecc_cfg->cw_data;
+			oob_len = 0;
+		}
+
+		flash = le32_to_cpu(buf->snandc_flash);
+		buffer = le32_to_cpu(buf->snandc_buffer);
+		erased_cw = le32_to_cpu(buf->snandc_erased_cw);
+
+		if ((flash & FS_OP_ERR) && (buffer & BS_UNCORRECTABLE_BIT)) {
+			if (ecc_cfg->bch_enabled)
+				erased = (erased_cw & ERASED_CW) == ERASED_CW;
+			else
+				erased = false;
+
+			if (!erased)
+				uncorrectable_cws |= BIT(i);
+
+		} else if (flash & (FS_OP_ERR | FS_MPU_ERR)) {
+			flash_op_err = true;
+		} else {
+			unsigned int stat;
+
+			stat = buffer & BS_CORRECTABLE_ERR_MSK;
+			snandc->ecc_stats.corrected += stat;
+			max_bitflips = max(max_bitflips, stat);
+		}
+
+		if (data_buf)
+			data_buf += data_len;
+		if (oob_buf)
+			oob_buf += oob_len + ecc_cfg->bytes;
+	}
+
+	if (flash_op_err)
+		return -EIO;
+
+	if (!uncorrectable_cws)
+		snandc->ecc_stats.bitflips = max_bitflips;
+	else
+		snandc->ecc_stats.failed++;
+
+	return 0;
+}
+
+static int qcom_spi_check_raw_flash_errors(struct qcom_nand_controller *snandc, int cw_cnt)
+{
+	int i;
+
+	qcom_nandc_dev_to_mem(snandc, true);
+
+	for (i = 0; i < cw_cnt; i++) {
+		u32 flash = le32_to_cpu(snandc->reg_read_buf[i]);
+
+		if (flash & (FS_OP_ERR | FS_MPU_ERR))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int qcom_spi_read_cw_raw(struct qcom_nand_controller *snandc, u8 *data_buf,
+				u8 *oob_buf, int cw)
+{
+	int data_size1, data_size2, oob_size1, oob_size2;
+	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
+	int raw_cw = cw;
+	struct qpic_ecc *ecc_cfg = snandc->ecc;
+	u32 cfg0, cfg1, ecc_bch_cfg, num_cw = snandc->num_cw;
+	int col;
+
+	snandc->buf_count = 0;
+	snandc->buf_start = 0;
+	qcom_clear_read_regs(snandc);
+	qcom_clear_bam_transaction(snandc);
+	raw_cw = num_cw - 1;
+
+	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
+				0 << CW_PER_PAGE;
+	cfg1 = ecc_cfg->cfg1_raw;
+	ecc_bch_cfg = 1 << ECC_CFG_ECC_DISABLE;
+
+	col = ecc_cfg->cw_size * cw;
+
+	snandc->regs->addr0 = snandc->addr1 | col;
+	snandc->regs->addr1 = snandc->addr2;
+	snandc->regs->cmd = snandc->cmd;
+	snandc->regs->cfg0 = cfg0;
+	snandc->regs->cfg1 = cfg1;
+	snandc->regs->ecc_bch_cfg = ecc_bch_cfg;
+	snandc->regs->clrflashstatus = ecc_cfg->clrflashstatus;
+	snandc->regs->clrreadstatus = ecc_cfg->clrreadstatus;
+	snandc->regs->exec = 1;
+
+	qcom_spi_set_read_loc(snandc, raw_cw, 0, 0, ecc_cfg->cw_size, 1);
+
+	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->ecc_buf_cfg, NAND_EBI2_ECC_BUF_CFG, 1, 0);
+
+	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_clr,
+			   NAND_ERASED_CW_DETECT_CFG, 1, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_set,
+			   NAND_ERASED_CW_DETECT_CFG, 1,
+			   NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
+
+	data_size1 = snandc->pagesize - ecc_cfg->cw_size * (num_cw - 1);
+	oob_size1 = ecc_cfg->bbm_size;
+
+	if (cw == (num_cw - 1)) {
+		data_size2 = NANDC_STEP_SIZE - data_size1 -
+			     ((num_cw - 1) * 4);
+		oob_size2 = (num_cw * 4) + ecc_cfg->ecc_bytes_hw +
+			    ecc_cfg->spare_bytes;
+	} else {
+		data_size2 = ecc_cfg->cw_data - data_size1;
+		oob_size2 = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes;
+	}
+
+	qcom_spi_set_read_loc(snandc, cw, 0, read_loc, data_size1, 0);
+	read_loc += data_size1;
+
+	qcom_spi_set_read_loc(snandc, cw, 1, read_loc, oob_size1, 0);
+	read_loc += oob_size1;
+
+	qcom_spi_set_read_loc(snandc, cw, 2, read_loc, data_size2, 0);
+	read_loc += data_size2;
+
+	qcom_spi_set_read_loc(snandc, cw, 3, read_loc, oob_size2, 1);
+
+	qcom_spi_config_cw_read(snandc, false, raw_cw);
+
+	qcom_read_data_dma(snandc, reg_off, data_buf, data_size1, 0);
+	reg_off += data_size1;
+
+	qcom_read_data_dma(snandc, reg_off, oob_buf, oob_size1, 0);
+	reg_off += oob_size1;
+
+	qcom_read_data_dma(snandc, reg_off, data_buf + data_size1, data_size2, 0);
+	reg_off += data_size2;
+
+	qcom_read_data_dma(snandc, reg_off, oob_buf + oob_size1, oob_size2, 0);
+
+	ret = qcom_submit_descs(snandc);
+	if (ret) {
+		dev_err(snandc->dev, "failure to read raw cw %d\n", cw);
+		return ret;
+	}
+
+	return qcom_spi_check_raw_flash_errors(snandc, 1);
+}
+
+static int qcom_spi_read_page_raw(struct qcom_nand_controller *snandc,
+				  const struct spi_mem_op *op)
+{
+	struct qpic_ecc *ecc_cfg = snandc->ecc;
+	u8 *data_buf = NULL, *oob_buf = NULL;
+	int ret, cw;
+	u32 num_cw = snandc->num_cw;
+
+	if (snandc->page_rw)
+		data_buf = op->data.buf.in;
+
+	if (snandc->oob_rw)
+		oob_buf = op->data.buf.in;
+
+	if (!oob_buf) {
+		oob_buf = snandc->oob_buf;
+		memset(oob_buf, 0xff, OOB_BUF_SIZE);
+	}
+
+	for (cw = 0; cw < num_cw; cw++) {
+		ret = qcom_spi_read_cw_raw(snandc, data_buf, oob_buf, cw);
+		if (ret)
+			return ret;
+
+		if (data_buf)
+			data_buf += ecc_cfg->cw_data;
+		if (oob_buf)
+			oob_buf += ecc_cfg->bytes;
+	}
+
+	return 0;
+}
+
+static int qcom_spi_read_page_cache(struct qcom_nand_controller *snandc,
+				    const struct spi_mem_op *op)
+{
+	struct qpic_ecc *ecc_cfg = snandc->ecc;
+	u8 *data_buf = NULL, *data_buf_start, *oob_buf = NULL, *oob_buf_start;
+	int ret, i;
+	u32 cfg0, cfg1, ecc_bch_cfg, num_cw = snandc->num_cw;
+
+	if (snandc->page_rw) {
+		data_buf = op->data.buf.in;
+		data_buf_start = data_buf;
+	}
+
+	if (snandc->oob_rw || snandc->raw_rw) {
+		oob_buf = op->data.buf.in;
+		oob_buf_start = oob_buf;
+	}
+
+	if (snandc->page_rw && snandc->raw_rw)
+		return qcom_spi_read_page_raw(snandc, op);
+
+	if (snandc->oob_rw && snandc->raw_rw && snandc->read_last_cw)
+		return qcom_spi_read_last_cw(snandc, op);
+
+	snandc->buf_count = 0;
+	snandc->buf_start = 0;
+	qcom_clear_read_regs(snandc);
+
+	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
+				(num_cw - 1) << CW_PER_PAGE;
+	cfg1 = ecc_cfg->cfg1;
+	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
+
+	snandc->regs->addr0 = snandc->addr1;
+	snandc->regs->addr1 = snandc->addr2;
+	snandc->regs->cmd = snandc->cmd;
+	snandc->regs->cfg0 = cfg0;
+	snandc->regs->cfg1 = cfg1;
+	snandc->regs->ecc_bch_cfg = ecc_bch_cfg;
+	snandc->regs->clrflashstatus = ecc_cfg->clrflashstatus;
+	snandc->regs->clrreadstatus = ecc_cfg->clrreadstatus;
+	snandc->regs->exec = 1;
+
+	qcom_spi_set_read_loc(snandc, 0, 0, 0, ecc_cfg->cw_data, 1);
+
+	qcom_clear_bam_transaction(snandc);
+
+	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_clr,
+			   NAND_ERASED_CW_DETECT_CFG, 1, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_set,
+			   NAND_ERASED_CW_DETECT_CFG, 1,
+			   NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
+
+	for (i = 0; i < num_cw; i++) {
+		int data_size, oob_size;
+
+		if (i == (num_cw - 1)) {
+			data_size = 512 - ((num_cw - 1) << 2);
+			oob_size = (num_cw << 2) + ecc_cfg->ecc_bytes_hw +
+				    ecc_cfg->spare_bytes;
+		} else {
+			data_size = ecc_cfg->cw_data;
+			oob_size = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes;
+		}
+
+		if (data_buf && oob_buf) {
+			qcom_spi_set_read_loc(snandc, i, 0, 0, data_size, 0);
+			qcom_spi_set_read_loc(snandc, i, 1, data_size, oob_size, 1);
+		} else if (data_buf) {
+			qcom_spi_set_read_loc(snandc, i, 0, 0, data_size, 1);
+		} else {
+			qcom_spi_set_read_loc(snandc, i, 0, data_size, oob_size, 1);
+		}
+
+		qcom_spi_config_cw_read(snandc, true, i);
+
+		if (data_buf)
+			qcom_read_data_dma(snandc, FLASH_BUF_ACC, data_buf,
+					   data_size, 0);
+		if (oob_buf) {
+			int j;
+
+			for (j = 0; j < ecc_cfg->bbm_size; j++)
+				*oob_buf++ = 0xff;
+
+			qcom_read_data_dma(snandc, FLASH_BUF_ACC + data_size,
+					   oob_buf, oob_size, 0);
+		}
+
+		if (data_buf)
+			data_buf += data_size;
+		if (oob_buf)
+			oob_buf += oob_size;
+	}
+
+	ret = qcom_submit_descs(snandc);
+	if (ret) {
+		dev_err(snandc->dev, "failure to read page\n");
+		return ret;
+	}
+
+	return qcom_spi_check_error(snandc, data_buf_start, oob_buf_start);
+}
+
+static void qcom_spi_config_page_write(struct qcom_nand_controller *snandc)
+{
+	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->ecc_buf_cfg, NAND_EBI2_ECC_BUF_CFG,
+			   1, NAND_BAM_NEXT_SGL);
+}
+
+static void qcom_spi_config_cw_write(struct qcom_nand_controller *snandc)
+{
+	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+
+	qcom_write_reg_dma(snandc, &snandc->regs->clrflashstatus, NAND_FLASH_STATUS, 1, 0);
+	qcom_write_reg_dma(snandc, &snandc->regs->clrreadstatus, NAND_READ_STATUS, 1,
+			   NAND_BAM_NEXT_SGL);
+}
+
+static int qcom_spi_program_raw(struct qcom_nand_controller *snandc,
+				const struct spi_mem_op *op)
+{
+	struct qpic_ecc *ecc_cfg = snandc->ecc;
+	u8 *data_buf = NULL, *oob_buf = NULL;
+	int i, ret;
+	int num_cw = snandc->num_cw;
+	u32 cfg0, cfg1, ecc_bch_cfg;
+
+	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
+			(num_cw - 1) << CW_PER_PAGE;
+	cfg1 = ecc_cfg->cfg1_raw;
+	ecc_bch_cfg = 1 << ECC_CFG_ECC_DISABLE;
+
+	data_buf = snandc->data_buf;
+
+	oob_buf = snandc->oob_buf;
+	memset(oob_buf, 0xff, OOB_BUF_SIZE);
+
+	snandc->buf_count = 0;
+	snandc->buf_start = 0;
+	qcom_clear_read_regs(snandc);
+	qcom_clear_bam_transaction(snandc);
+
+	snandc->regs->addr0 = snandc->addr1;
+	snandc->regs->addr1 = snandc->addr2;
+	snandc->regs->cmd = snandc->cmd;
+	snandc->regs->cfg0 = cfg0;
+	snandc->regs->cfg1 = cfg1;
+	snandc->regs->ecc_bch_cfg = ecc_bch_cfg;
+	snandc->regs->clrflashstatus = ecc_cfg->clrflashstatus;
+	snandc->regs->clrreadstatus = ecc_cfg->clrreadstatus;
+	snandc->regs->exec = 1;
+
+	qcom_spi_config_page_write(snandc);
+
+	for (i = 0; i < num_cw; i++) {
+		int data_size1, data_size2, oob_size1, oob_size2;
+		int reg_off = FLASH_BUF_ACC;
+
+		data_size1 = snandc->pagesize - ecc_cfg->cw_size * (num_cw - 1);
+		oob_size1 = ecc_cfg->bbm_size;
+
+		if ((i == (num_cw - 1))) {
+			data_size2 = NANDC_STEP_SIZE - data_size1 -
+				     ((num_cw - 1) << 2);
+			oob_size2 = (num_cw << 2) + ecc_cfg->ecc_bytes_hw +
+				    ecc_cfg->spare_bytes;
+		} else {
+			data_size2 = ecc_cfg->cw_data - data_size1;
+			oob_size2 = ecc_cfg->ecc_bytes_hw + ecc_cfg->spare_bytes;
+		}
+
+		qcom_write_data_dma(snandc, reg_off, data_buf, data_size1,
+				    NAND_BAM_NO_EOT);
+		reg_off += data_size1;
+		data_buf += data_size1;
+
+		qcom_write_data_dma(snandc, reg_off, oob_buf, oob_size1,
+				    NAND_BAM_NO_EOT);
+		oob_buf += oob_size1;
+		reg_off += oob_size1;
+
+		qcom_write_data_dma(snandc, reg_off, data_buf, data_size2,
+				    NAND_BAM_NO_EOT);
+		reg_off += data_size2;
+		data_buf += data_size2;
+
+		qcom_write_data_dma(snandc, reg_off, oob_buf, oob_size2, 0);
+		oob_buf += oob_size2;
+
+		qcom_spi_config_cw_write(snandc);
+	}
+
+	ret = qcom_submit_descs(snandc);
+	if (ret) {
+		dev_err(snandc->dev, "failure to write raw page\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_spi_program_execute(struct qcom_nand_controller *snandc,
+				    const struct spi_mem_op *op)
+{
+	struct qpic_ecc *ecc_cfg = snandc->ecc;
+	u8 *data_buf = NULL, *oob_buf = NULL;
+	int i, ret;
+	int num_cw = snandc->num_cw;
+	u32 cfg0, cfg1, ecc_bch_cfg, ecc_buf_cfg;
+
+	cfg0 = (ecc_cfg->cfg0 & ~(7U << CW_PER_PAGE)) |
+				(num_cw - 1) << CW_PER_PAGE;
+	cfg1 = ecc_cfg->cfg1;
+	ecc_bch_cfg = ecc_cfg->ecc_bch_cfg;
+	ecc_buf_cfg = ecc_cfg->ecc_buf_cfg;
+
+	if (snandc->page_rw && snandc->raw_rw)
+		return qcom_spi_program_raw(snandc, op);
+
+	if (snandc->data_buf)
+		data_buf = snandc->data_buf;
+
+	if (snandc->oob_buf)
+		oob_buf = snandc->oob_buf;
+
+	snandc->buf_count = 0;
+	snandc->buf_start = 0;
+	qcom_clear_read_regs(snandc);
+	qcom_clear_bam_transaction(snandc);
+
+	snandc->regs->addr0 = snandc->addr1;
+	snandc->regs->addr1 = snandc->addr2;
+	snandc->regs->cmd = snandc->cmd;
+	snandc->regs->cfg0 = cfg0;
+	snandc->regs->cfg1 = cfg1;
+	snandc->regs->ecc_bch_cfg = ecc_bch_cfg;
+	snandc->regs->ecc_buf_cfg = ecc_buf_cfg;
+	snandc->regs->exec = 1;
+
+	qcom_spi_config_page_write(snandc);
+
+	for (i = 0; i < num_cw; i++) {
+		int data_size, oob_size;
+
+		if (i == (num_cw - 1)) {
+			data_size = NANDC_STEP_SIZE - ((num_cw - 1) << 2);
+			oob_size = (num_cw << 2) + ecc_cfg->ecc_bytes_hw +
+				    ecc_cfg->spare_bytes;
+		} else {
+			data_size = ecc_cfg->cw_data;
+			oob_size = ecc_cfg->bytes;
+		}
+
+		if (data_buf)
+			qcom_write_data_dma(snandc, FLASH_BUF_ACC, data_buf, data_size,
+					    i == (num_cw - 1) ? NAND_BAM_NO_EOT : 0);
+
+		if (i == (num_cw - 1)) {
+			if (oob_buf) {
+				oob_buf += ecc_cfg->bbm_size;
+				qcom_write_data_dma(snandc, FLASH_BUF_ACC + data_size,
+						    oob_buf, oob_size, 0);
+			}
+		}
+
+		qcom_spi_config_cw_write(snandc);
+
+		if (data_buf)
+			data_buf += data_size;
+		if (oob_buf)
+			oob_buf += oob_size;
+	}
+
+	ret = qcom_submit_descs(snandc);
+	if (ret) {
+		dev_err(snandc->dev, "failure to write page\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static u32 qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode)
+{
+	u32 cmd = 0x0;
+
+	switch (opcode) {
+	case SPINAND_RESET:
+		cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_RESET_DEVICE);
+		break;
+	case SPINAND_READID:
+		cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_FETCH_ID);
+		break;
+	case SPINAND_GET_FEATURE:
+		cmd = (SPI_TRANSFER_MODE_x1 | SPI_WP | SPI_HOLD | ACC_FEATURE);
+		break;
+	case SPINAND_SET_FEATURE:
+		cmd = (SPI_TRANSFER_MODE_x1 | SPI_WP | SPI_HOLD | ACC_FEATURE |
+			QPIC_SET_FEATURE);
+		break;
+	case SPINAND_READ:
+		if (snandc->raw_rw) {
+			cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
+					SPI_WP | SPI_HOLD | OP_PAGE_READ);
+		} else {
+			cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
+					SPI_WP | SPI_HOLD | OP_PAGE_READ_WITH_ECC);
+		}
+
+		break;
+	case SPINAND_ERASE:
+		cmd = OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE | SPI_WP |
+			SPI_HOLD | SPI_TRANSFER_MODE_x1;
+		break;
+	case SPINAND_WRITE_EN:
+		cmd = SPINAND_WRITE_EN;
+		break;
+	case SPINAND_PROGRAM_EXECUTE:
+		cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
+				SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
+		break;
+	case SPINAND_PROGRAM_LOAD:
+		cmd = SPINAND_PROGRAM_LOAD;
+		break;
+	default:
+		dev_err(snandc->dev, "Opcode not supported: %u\n", opcode);
+		return -EOPNOTSUPP;
+	}
+
+	return cmd;
+}
+
+static int qcom_spi_write_page_cache(struct qcom_nand_controller *snandc,
+				     const struct spi_mem_op *op)
+{
+	struct qpic_snand_op s_op = {};
+	u32 cmd;
+
+	cmd = qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
+	s_op.cmd_reg = cmd;
+
+	if (op->cmd.opcode == SPINAND_PROGRAM_LOAD) {
+		if (snandc->page_rw)
+			snandc->data_buf = (u8 *)op->data.buf.out;
+		if (snandc->oob_rw)
+			snandc->oob_buf = (u8 *)op->data.buf.out;
+	}
+
+	return 0;
+}
+
+static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
+				 const struct spi_mem_op *op)
+{
+	struct qpic_snand_op s_op = {};
+	u32 cmd;
+	int ret, opcode;
+
+	cmd = qcom_spi_cmd_mapping(snandc, op->cmd.opcode);
+
+	s_op.cmd_reg = cmd;
+	s_op.addr1_reg = op->addr.val;
+	s_op.addr2_reg = 0;
+
+	opcode = op->cmd.opcode;
+
+	switch (opcode) {
+	case SPINAND_WRITE_EN:
+		return 0;
+	case SPINAND_PROGRAM_EXECUTE:
+		s_op.addr1_reg = op->addr.val << 16;
+		s_op.addr2_reg = op->addr.val >> 16 & 0xff;
+		snandc->addr1 = s_op.addr1_reg;
+		snandc->addr2 = s_op.addr2_reg;
+		snandc->cmd = cmd;
+		return qcom_spi_program_execute(snandc, op);
+	case SPINAND_READ:
+		s_op.addr1_reg = (op->addr.val << 16);
+		s_op.addr2_reg = op->addr.val >> 16 & 0xff;
+		snandc->addr1 = s_op.addr1_reg;
+		snandc->addr2 = s_op.addr2_reg;
+		snandc->cmd = cmd;
+		return 0;
+	case SPINAND_ERASE:
+		s_op.addr2_reg = (op->addr.val >> 16) & 0xffff;
+		s_op.addr1_reg = op->addr.val;
+		snandc->addr1 = s_op.addr1_reg;
+		snandc->addr1 <<= 16;
+		snandc->addr2 = s_op.addr2_reg;
+		snandc->cmd = cmd;
+		qcom_spi_block_erase(snandc);
+		return 0;
+	default:
+		break;
+	}
+
+	snandc->buf_count = 0;
+	snandc->buf_start = 0;
+	qcom_clear_read_regs(snandc);
+	qcom_clear_bam_transaction(snandc);
+
+	snandc->regs->cmd = s_op.cmd_reg;
+	snandc->regs->exec = 1;
+	snandc->regs->addr0 = s_op.addr1_reg;
+	snandc->regs->addr1 = s_op.addr2_reg;
+
+	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
+	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+
+	ret = qcom_submit_descs(snandc);
+	if (ret)
+		dev_err(snandc->dev, "failure in sbumitting cmd descriptor\n");
+
+	return ret;
+}
+
+static int qcom_spi_io_op(struct qcom_nand_controller *snandc, const struct spi_mem_op *op)
+{
+	int ret, val, opcode;
+	bool copy = false, copy_ftr = false;
+
+	ret = qcom_spi_send_cmdaddr(snandc, op);
+	if (ret)
+		return ret;
+
+	snandc->buf_count = 0;
+	snandc->buf_start = 0;
+	qcom_clear_read_regs(snandc);
+	qcom_clear_bam_transaction(snandc);
+	opcode = op->cmd.opcode;
+
+	switch (opcode) {
+	case SPINAND_READID:
+		snandc->buf_count = 4;
+		qcom_read_reg_dma(snandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
+		copy = true;
+		break;
+	case SPINAND_GET_FEATURE:
+		snandc->buf_count = 4;
+		qcom_read_reg_dma(snandc, NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
+		copy_ftr = true;
+		break;
+	case SPINAND_SET_FEATURE:
+		snandc->regs->flash_feature = *(u32 *)op->data.buf.out;
+		qcom_write_reg_dma(snandc, &snandc->regs->flash_feature,
+				   NAND_FLASH_FEATURES, 1, NAND_BAM_NEXT_SGL);
+		break;
+	default:
+		return 0;
+	}
+
+	ret = qcom_submit_descs(snandc);
+	if (ret)
+		dev_err(snandc->dev, "failure in submitting descriptor for:%d\n", opcode);
+
+	if (copy) {
+		qcom_nandc_dev_to_mem(snandc, true);
+		memcpy(op->data.buf.in, snandc->reg_read_buf, snandc->buf_count);
+	}
+
+	if (copy_ftr) {
+		qcom_nandc_dev_to_mem(snandc, true);
+		val = le32_to_cpu(*(__le32 *)snandc->reg_read_buf);
+		val >>= 8;
+		memcpy(op->data.buf.in, &val, snandc->buf_count);
+	}
+
+	return ret;
+}
+
+static bool qcom_spi_is_page_op(const struct spi_mem_op *op)
+{
+	if (op->addr.buswidth != 1 && op->addr.buswidth != 2 && op->addr.buswidth != 4)
+		return false;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		if (op->addr.buswidth == 4 && op->data.buswidth == 4)
+			return true;
+
+		if (op->addr.nbytes == 2 && op->addr.buswidth == 1)
+			return true;
+
+	} else if (op->data.dir == SPI_MEM_DATA_OUT) {
+		if (op->data.buswidth == 4)
+			return true;
+		if (op->addr.nbytes == 2 && op->addr.buswidth == 1)
+			return true;
+	}
+
+	return false;
+}
+
+static bool qcom_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	if (op->cmd.nbytes != 1 || op->cmd.buswidth != 1)
+		return false;
+
+	if (qcom_spi_is_page_op(op))
+		return true;
+
+	return ((!op->addr.nbytes || op->addr.buswidth == 1) &&
+		(!op->dummy.nbytes || op->dummy.buswidth == 1) &&
+		(!op->data.nbytes || op->data.buswidth == 1));
+}
+
+static int qcom_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct qcom_nand_controller *snandc = spi_controller_get_devdata(mem->spi->controller);
+
+	dev_dbg(snandc->dev, "OP %02x ADDR %08llX@%d:%u DATA %d:%u", op->cmd.opcode,
+		op->addr.val, op->addr.buswidth, op->addr.nbytes,
+		op->data.buswidth, op->data.nbytes);
+
+	if (qcom_spi_is_page_op(op)) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			return qcom_spi_read_page_cache(snandc, op);
+		if (op->data.dir == SPI_MEM_DATA_OUT)
+			return qcom_spi_write_page_cache(snandc, op);
+	} else {
+		return qcom_spi_io_op(snandc, op);
+	}
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops qcom_spi_mem_ops = {
+	.supports_op = qcom_spi_supports_op,
+	.exec_op = qcom_spi_exec_op,
+};
+
+static const struct spi_controller_mem_caps qcom_spi_mem_caps = {
+	.ecc = true,
+};
+
+static int qcom_spi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_controller *ctlr;
+	struct qcom_nand_controller *snandc;
+	struct resource *res;
+	const void *dev_data;
+	struct qpic_ecc *ecc;
+	int ret;
+
+	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
+	if (!ecc)
+		return -ENOMEM;
+
+	ctlr = __devm_spi_alloc_controller(dev, sizeof(*snandc), false);
+	if (!ctlr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ctlr);
+
+	snandc = spi_controller_get_devdata(ctlr);
+
+	snandc->ctlr = ctlr;
+	snandc->dev = dev;
+	snandc->ecc = ecc;
+
+	snandc->oob_buf = devm_kzalloc(dev, OOB_BUF_SIZE, GFP_KERNEL);
+	if (!snandc->oob_buf)
+		return -ENOMEM;
+
+	dev_data = of_device_get_match_data(dev);
+	if (!dev_data) {
+		dev_err(&pdev->dev, "failed to get device data\n");
+		return -ENODEV;
+	}
+
+	snandc->props = dev_data;
+	snandc->dev = &pdev->dev;
+
+	snandc->core_clk = devm_clk_get(dev, "core");
+	if (IS_ERR(snandc->core_clk))
+		return PTR_ERR(snandc->core_clk);
+
+	snandc->aon_clk = devm_clk_get(dev, "aon");
+	if (IS_ERR(snandc->aon_clk))
+		return PTR_ERR(snandc->aon_clk);
+
+	snandc->iomacro_clk = devm_clk_get(dev, "iom");
+	if (IS_ERR(snandc->iomacro_clk))
+		return PTR_ERR(snandc->iomacro_clk);
+
+	snandc->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(snandc->base))
+		return PTR_ERR(snandc->base);
+
+	snandc->base_phys = res->start;
+	snandc->base_dma = dma_map_resource(dev, res->start, resource_size(res),
+					    DMA_BIDIRECTIONAL, 0);
+	if (dma_mapping_error(dev, snandc->base_dma))
+		return -ENXIO;
+
+	ret = clk_prepare_enable(snandc->core_clk);
+	if (ret)
+		goto err_core_clk;
+
+	ret = clk_prepare_enable(snandc->aon_clk);
+	if (ret)
+		goto err_aon_clk;
+
+	ret = clk_prepare_enable(snandc->iomacro_clk);
+	if (ret)
+		goto err_snandc_alloc;
+
+	ret = qcom_nandc_alloc(snandc);
+	if (ret)
+		goto err_iom_clk;
+
+	ret = qcom_spi_init(snandc);
+	if (ret)
+		goto err_init;
+
+	/* setup ECC engine */
+	snandc->ecc_eng.dev = &pdev->dev;
+	snandc->ecc_eng.integration = NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
+	snandc->ecc_eng.ops = &qcom_spi_ecc_engine_ops_pipelined;
+	snandc->ecc_eng.priv = snandc;
+
+	ret = nand_ecc_register_on_host_hw_engine(&snandc->ecc_eng);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register ecc engine.\n");
+		goto err_init;
+	}
+
+	ctlr->num_chipselect = QPIC_QSPI_NUM_CS;
+	ctlr->mem_ops = &qcom_spi_mem_ops;
+	ctlr->mem_caps = &qcom_spi_mem_caps;
+	ctlr->dev.of_node = pdev->dev.of_node;
+	ctlr->mode_bits = SPI_TX_DUAL | SPI_RX_DUAL |
+			    SPI_TX_QUAD | SPI_RX_QUAD;
+
+	ret = spi_register_controller(ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "spi_register_controller failed.\n");
+		goto err_init;
+	}
+
+	return 0;
+
+err_init:
+	qcom_nandc_unalloc(snandc);
+err_iom_clk:
+	clk_disable_unprepare(snandc->iomacro_clk);
+err_snandc_alloc:
+	clk_disable_unprepare(snandc->aon_clk);
+err_aon_clk:
+	clk_disable_unprepare(snandc->core_clk);
+err_core_clk:
+	dma_unmap_resource(dev, res->start, resource_size(res),
+			   DMA_BIDIRECTIONAL, 0);
+	return ret;
+}
+
+static int qcom_spi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct qcom_nand_controller *snandc = spi_controller_get_devdata(ctlr);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	spi_unregister_controller(ctlr);
+
+	clk_disable_unprepare(snandc->aon_clk);
+	clk_disable_unprepare(snandc->core_clk);
+	clk_disable_unprepare(snandc->iomacro_clk);
+
+	dma_unmap_resource(&pdev->dev, snandc->base_dma, resource_size(res),
+			   DMA_BIDIRECTIONAL, 0);
+	return 0;
+}
+
+static const struct qcom_nandc_props ipq9574_snandc_props = {
+	.dev_cmd_reg_start = 0x7000,
+	.supports_bam = true,
+};
+
+static const struct of_device_id qcom_snandc_of_match[] = {
+	{
+		.compatible = "qcom,spi-qpic-snand",
+		.data = &ipq9574_snandc_props,
+	},
+	{}
+}
+MODULE_DEVICE_TABLE(of, qcom_snandc_of_match);
+
+static struct platform_driver qcom_spi_driver = {
+	.driver = {
+		.name		= "qcom_snand",
+		.of_match_table = qcom_snandc_of_match,
+	},
+	.probe = qcom_spi_probe,
+	.remove = qcom_spi_remove,
+};
+module_platform_driver(qcom_spi_driver);
+
+MODULE_DESCRIPTION("SPI driver for QPIC QSPI cores");
+MODULE_AUTHOR("Md Sadre Alam <quic_mdalam@quicinc.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
index 096c15d3be76..dd2b56125bc1 100644
--- a/include/linux/mtd/nand-qpic-common.h
+++ b/include/linux/mtd/nand-qpic-common.h
@@ -315,11 +315,56 @@ struct nandc_regs {
 	__le32 read_location_last1;
 	__le32 read_location_last2;
 	__le32 read_location_last3;
+	__le32 spi_cfg;
+	__le32 num_addr_cycle;
+	__le32 busy_wait_cnt;
+	__le32 flash_feature;
 
 	__le32 erased_cw_detect_cfg_clr;
 	__le32 erased_cw_detect_cfg_set;
 };
 
+/*
+ * ECC state struct
+ * @corrected:		ECC corrected
+ * @bitflips:		Max bit flip
+ * @failed:		ECC failed
+ */
+struct qcom_ecc_stats {
+	u32 corrected;
+	u32 bitflips;
+	u32 failed;
+};
+
+struct qpic_ecc {
+	struct device *dev;
+	const struct qpic_ecc_caps *caps;
+	struct completion done;
+	u32 sectors;
+	u8 *eccdata;
+	bool use_ecc;
+	u32 ecc_modes;
+	int ecc_bytes_hw;
+	int spare_bytes;
+	int bbm_size;
+	int ecc_mode;
+	int bytes;
+	int steps;
+	int step_size;
+	int strength;
+	int cw_size;
+	int cw_data;
+	u32 cfg0, cfg1;
+	u32 cfg0_raw, cfg1_raw;
+	u32 ecc_buf_cfg;
+	u32 ecc_bch_cfg;
+	u32 clrflashstatus;
+	u32 clrreadstatus;
+	bool bch_enabled;
+};
+
+struct qpic_ecc;
+
 /*
  * NAND controller data struct
  *
@@ -329,6 +374,7 @@ struct nandc_regs {
  *
  * @core_clk:			controller clock
  * @aon_clk:			another controller clock
+ * @iomacro_clk:		io macro clock
  *
  * @regs:			a contiguous chunk of memory for DMA register
  *				writes. contains the register values to be
@@ -338,6 +384,7 @@ struct nandc_regs {
  *				initialized via DT match data
  *
  * @controller:			base controller structure
+ * @ctlr:			spi controller structure
  * @host_list:			list containing all the chips attached to the
  *				controller
  *
@@ -375,6 +422,7 @@ struct qcom_nand_controller {
 
 	struct clk *core_clk;
 	struct clk *aon_clk;
+	struct clk *iomacro_clk;
 
 	struct nandc_regs *regs;
 	struct bam_transaction *bam_txn;
@@ -382,6 +430,7 @@ struct qcom_nand_controller {
 	const struct qcom_nandc_props *props;
 
 	struct nand_controller controller;
+	struct spi_controller *ctlr;
 	struct list_head host_list;
 
 	union {
@@ -418,6 +467,21 @@ struct qcom_nand_controller {
 
 	u32 cmd1, vld;
 	bool exec_opwrite;
+	struct qpic_ecc *ecc;
+	struct qcom_ecc_stats ecc_stats;
+	struct nand_ecc_engine ecc_eng;
+	u8 *data_buf;
+	u8 *oob_buf;
+	u32 wlen;
+	u32 addr1;
+	u32 addr2;
+	u32 cmd;
+	u32 num_cw;
+	u32 pagesize;
+	bool oob_rw;
+	bool page_rw;
+	bool raw_rw;
+	bool read_last_cw;
 };
 
 /*
-- 
2.34.1


