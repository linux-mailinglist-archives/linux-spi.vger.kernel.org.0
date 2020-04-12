Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EAC1A6001
	for <lists+linux-spi@lfdr.de>; Sun, 12 Apr 2020 21:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgDLT3I (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 Apr 2020 15:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLT3I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 Apr 2020 15:29:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64930C0A3BF0;
        Sun, 12 Apr 2020 12:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUSSorCG0xXIKMx++tZAZioDFtlrVbeDCa3pBJFrIcFEmar4ps26ZgDSRx67nVktmtE9TmsjiUNpZjxUz42Z1oqvrmGDsUKWtRnRkZrXZM/cfi1NPszTPbFHnXCjg736aphqHKrVuHgjEYPYpTHufcyppdyLpa3NDtEVd0pgpouYGXXiGo73hsRqvglb2Ln5OGa2W3NPV10fRdiDWK11gFxV4f9vdbZKMClqFH+CFToaAU7zCyfokYUlWuLozpTrIbBnoJLK9wyxFcsnqZ3VrZ4mR7CGiIXD71Xn4O31HNhlX4gS4dZnUWKkQ1L405OX9xS+1lyix9hKbvvPwk6z3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P95dlCVU/SZVt0QTPUtvfFDRiIiYWpgoJ13sdLPYX/U=;
 b=od2G6lkY1kyQrkzoZ3Gk/V5X3/vNBiw8OkcDYEaTuCa9UhRZUCpwZFCWJxlj+6ca7osHAAod64e1bmNnINGcu9SZ8IEDWoEG4RqJm3pzsnRc9upEcGs4JjZDB+TU7MnmJt/En4d8tGtkutAzEV0WKf9ClB+028N7qGflkXt7ChTH8H6xRaafB3dC9gbjTLlFKMzOpmDAFCmYWe2FaJViSDOjhMgMBCVySwNMpbREhjQsl7Afp1kbgAE8ZvVAzVvPWbouSNHrha/BiebdWmlVsTNrYHAlB7EvtGBGjFSSMFFNCcLVIMa6cCMY98Z4ZZKTkiF9iMlkdcsvXM1VtlGMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P95dlCVU/SZVt0QTPUtvfFDRiIiYWpgoJ13sdLPYX/U=;
 b=okLIr7//zUgLvZTMIyjNG8+o/GkAyXC1m81N9jr4HbJXhsukybXuGAd8K1WGPK8mAt4glqYvrCtsJZXSswYLfTYRPz1f3FvkKPYVImFejoTw6fIjOwA248jCVK7oS6X5lcWXpRtLC+SvXcQvDTaZMyF4qMQZhNL15ikRT9yvYdM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22)
 by MN2PR12MB3230.namprd12.prod.outlook.com (2603:10b6:208:108::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Sun, 12 Apr
 2020 19:29:03 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f19a:d981:717:3cb6%2]) with mapi id 15.20.2900.026; Sun, 12 Apr 2020
 19:29:02 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     broonie@kernel.org
Cc:     Nehal-bakulchandra.Shah@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH] spi: spi-amd: Add AMD SPI controller driver support
Date:   Sun, 12 Apr 2020 14:28:31 -0500
Message-Id: <1586719711-46010-1-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::34) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.15 via Frontend Transport; Sun, 12 Apr 2020 19:29:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e1b0c6f-0b3c-4d41-ec0e-08d7df17c14f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3230:|MN2PR12MB3230:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32306D664E6B52D666CF4FB1E5DC0@MN2PR12MB3230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0371762FE7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3455.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(8936002)(81156014)(5660300002)(956004)(2616005)(6666004)(6916009)(316002)(36756003)(8676002)(6486002)(16526019)(52116002)(26005)(4326008)(66556008)(66476007)(7696005)(2906002)(30864003)(478600001)(86362001)(186003)(66946007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9UhbiBzRAAvSkgO7hxXj2LZRu9XzuxGmBYg2p2qNJAh1Tulss9XRpMRryZ6HLOxkajdXeHWS35FEJrnu0kJfb8kHvwcslPDfMXJatmm5eRNAzHRZe77TxZkcLa3cqiHAtZc+7kl9pzT1UT5YC7abXUNS3XruKOT0caU/pd5KP7z0vh0dHiC1S/17aoPvTi0JfEQc/KX85Nn9VTplSUUqcSFokWcISB27vs8v6yYRqIqOobrgDkFtgOgBwFk0jsPv9It+ggl4iZ96uFD+PAZpAYpajcjMH9E6jkkVuMKws5c4+NSFK0yM7w83Bq85iFFdPabXTcvpZ9JvLNxE7ERZz1w7laSbxQBCIS1aCtWzZPKFOunJp32w3ffWDaGJpmlkamvJVpqqqlDqnGeXLKhYqgArfFkrKv1lNUaih7VHaQ0UeB6itI6olSaUPzcYUvZv
X-MS-Exchange-AntiSpam-MessageData: ScYfbjdW+8YH4jITAr2LMhnD0tsfUCxFidmbj39yso2/J1ksxh+0dw4eyqnMuIX1RLfS2amrHXybMUBi68yGq684JPxIpNY2epSrFKi7kFEmxNbkQaqEaAJKMc6/XKF5qi5ZiQCtEUxt2zajHaEcjA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1b0c6f-0b3c-4d41-ec0e-08d7df17c14f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2020 19:29:02.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYJ5MiePrdVR8WOwuHrhK9gowUGrAj0roMsF8xJuu45UvTcXPWoEOpyF7vf1ZMNlr3MmQ54kcrZbG8x60jqtEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3230
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver supports AMD based SPI Controller for AMD SOCs.This
driver supports SPI operations using FIFO mode of transfer.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 MAINTAINERS           |   5 +
 drivers/spi/Kconfig   |   6 +
 drivers/spi/Makefile  |   1 +
 drivers/spi/spi-amd.c | 341 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 353 insertions(+)
 create mode 100644 drivers/spi/spi-amd.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6158a14..4455b92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -870,6 +870,11 @@ F:	drivers/gpu/drm/amd/include/vi_structs.h
 F:	drivers/gpu/drm/amd/include/v9_structs.h
 F:	include/uapi/linux/kfd_ioctl.h
 
+AMD SPI DRIVER
+M:	Sanjay R Mehta <sanju.mehta@amd.com>
+S:	Maintained
+F:	drivers/spi/spi-amd.c
+
 AMD MP2 I2C DRIVER
 M:	Elie Morisse <syniurge@gmail.com>
 M:	Nehal Shah <nehal-bakulchandra.shah@amd.com>
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d6ed0c3..1f4fa9a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -886,6 +886,12 @@ config SPI_ZYNQMP_GQSPI
 	help
 	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
 
+config SPI_AMD
+	tristate "AMD SPI controller"
+	depends on SPI_MASTER || COMPILE_TEST
+	help
+	  Enables SPI controller driver for AMD SoC.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 9b65ec5..ceb7249 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
 obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQ_QSPI)		+= spi-zynq-qspi.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
+obj-$(CONFIG_SPI_AMD)			+= spi-amd.o
 
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
new file mode 100644
index 0000000..69e51a8
--- /dev/null
+++ b/drivers/spi/spi-amd.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * AMD SPI controller driver
+ *
+ * Copyright (c) 2020, Advanced Micro Devices, Inc.
+ *
+ * Author: Sanjay R Mehta <sanju.mehta@amd.com>
+ */
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#define DRIVER_NAME		"amd_spi"
+
+#define AMD_SPI_CTRL0_REG	0x00
+#define AMD_SPI_EXEC_CMD	BIT(16)
+#define AMD_SPI_FIFO_CLEAR	BIT(20)
+#define AMD_SPI_BUSY		BIT(31)
+
+#define AMD_SPI_OPCODE_MASK	0xFF
+
+#define AMD_SPI_ALT_CS_REG	0x1D
+#define AMD_SPI_ALT_CS_MASK	0x3
+
+#define AMD_SPI_FIFO_BASE	0x80
+#define AMD_SPI_TX_COUNT_REG	0x48
+#define AMD_SPI_RX_COUNT_REG	0x4B
+#define AMD_SPI_STATUS_REG	0x4C
+
+#define AMD_SPI_MEM_SIZE	200
+
+/* M_CMD OP codes for SPI */
+#define SPI_XFER_TX		1
+#define SPI_XFER_RX		2
+
+struct amd_spi {
+	void __iomem *io_remap_addr;
+	unsigned long io_base_addr;
+	u32 rom_addr;
+	struct spi_master *master;
+	u8 chip_select;
+};
+
+static inline u8 amd_spi_readreg8(struct spi_master *master, int idx)
+{
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+
+	return ioread8((u8 __iomem *)amd_spi->io_remap_addr + idx);
+}
+
+static inline void amd_spi_writereg8(struct spi_master *master, int idx,
+				     u8 val)
+{
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+
+	iowrite8(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
+}
+
+static inline void amd_spi_setclear_reg8(struct spi_master *master, int idx,
+					 u8 set, u8 clear)
+{
+	u8 tmp = amd_spi_readreg8(master, idx);
+
+	tmp = (tmp & ~clear) | set;
+	amd_spi_writereg8(master, idx, tmp);
+}
+
+static inline u32 amd_spi_readreg32(struct spi_master *master, int idx)
+{
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+
+	return ioread32((u8 __iomem *)amd_spi->io_remap_addr + idx);
+}
+
+static inline void amd_spi_writereg32(struct spi_master *master, int idx,
+				      u32 val)
+{
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+
+	iowrite32(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
+}
+
+static inline void amd_spi_setclear_reg32(struct spi_master *master, int idx,
+					  u32 set, u32 clear)
+{
+	u32 tmp = amd_spi_readreg32(master, idx);
+
+	tmp = (tmp & ~clear) | set;
+	amd_spi_writereg32(master, idx, tmp);
+}
+
+static void amd_spi_select_chip(struct spi_master *master)
+{
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+	u8 chip_select = amd_spi->chip_select;
+
+	amd_spi_setclear_reg8(master, AMD_SPI_ALT_CS_REG, chip_select,
+			      AMD_SPI_ALT_CS_MASK);
+}
+
+static void amd_spi_clear_fifo_ptr(struct spi_master *master)
+{
+	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_FIFO_CLEAR,
+			       AMD_SPI_FIFO_CLEAR);
+}
+
+static void amd_spi_set_opcode(struct spi_master *master, u8 cmd_opcode)
+{
+	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, cmd_opcode,
+			       AMD_SPI_OPCODE_MASK);
+}
+
+static inline void amd_spi_set_rx_count(struct spi_master *master,
+					u8 rx_count)
+{
+	amd_spi_setclear_reg8(master, AMD_SPI_RX_COUNT_REG, rx_count, 0xff);
+}
+
+static inline void amd_spi_set_tx_count(struct spi_master *master,
+					u8 tx_count)
+{
+	amd_spi_setclear_reg8(master, AMD_SPI_TX_COUNT_REG, tx_count, 0xff);
+}
+
+static void amd_spi_execute_opcode(struct spi_master *master)
+{
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+	bool spi_busy;
+
+	/* Set ExecuteOpCode bit in the CTRL0 register */
+	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD,
+			       AMD_SPI_EXEC_CMD);
+
+	/* poll for SPI bus to become idle */
+	spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
+		    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
+	while (spi_busy) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+		set_current_state(TASK_RUNNING);
+		spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
+			    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
+	}
+}
+
+static int amd_spi_master_setup(struct spi_device *spi)
+{
+	struct spi_master *master = spi->master;
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+
+	amd_spi->chip_select = spi->chip_select;
+	amd_spi_select_chip(master);
+
+	return 0;
+}
+
+static int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
+			     struct spi_message *message)
+{
+	struct spi_master *master = amd_spi->master;
+	struct spi_transfer *xfer = NULL;
+	u8 cmd_opcode, opcode = 0;
+	u8 *buffer = NULL;
+	u32 m_cmd = 0;
+	u32 i = 0, saved_index = 0;
+	u32 tx_len = 0, rx_len = 0;
+
+	list_for_each_entry(xfer, &message->transfers,
+			    transfer_list) {
+		if (xfer->rx_buf)
+			m_cmd = SPI_XFER_RX;
+		else if (xfer->tx_buf)
+			m_cmd = SPI_XFER_TX;
+
+		if (m_cmd & SPI_XFER_TX) {
+			buffer = (u8 *)xfer->tx_buf;
+
+			if (opcode != 1) {
+				tx_len = xfer->len - 1;
+				cmd_opcode = *(u8 *)xfer->tx_buf;
+				buffer++;
+				amd_spi_set_opcode(master, cmd_opcode);
+				opcode = 1;
+			} else {
+				/* Store no. of bytes to be sent into
+				 * FIFO
+				 */
+				tx_len = xfer->len;
+			}
+
+			/* Write data into the FIFO. */
+
+			for (i = 0; i < tx_len; i++) {
+				iowrite8(buffer[i],
+					 ((u8 __iomem *)amd_spi->io_remap_addr +
+					 AMD_SPI_FIFO_BASE +
+					 i + saved_index));
+			}
+
+			amd_spi_set_tx_count(master,
+					     tx_len + saved_index);
+
+			/*
+			 * Saving the index, from where next
+			 * spi_transfer's data will be stored in FIFO.
+			 */
+			saved_index = i;
+
+		} else if (m_cmd & SPI_XFER_RX) {
+			/* Store no. of bytes to be received from
+			 * FIFO
+			 */
+			rx_len = xfer->len;
+			buffer = (u8 *)xfer->rx_buf;
+		}
+	}
+
+	amd_spi_set_rx_count(master, rx_len);
+	amd_spi_clear_fifo_ptr(master);
+
+	/* Execute command */
+	amd_spi_execute_opcode(master);
+
+	if (m_cmd & SPI_XFER_RX) {
+		/* Read data from FIFO to receive buffer  */
+		for (i = 0; i < rx_len; i++)
+			buffer[i] = ioread8((u8 __iomem *)amd_spi->io_remap_addr
+					    + AMD_SPI_FIFO_BASE
+					    + tx_len + i);
+	}
+
+	/* Update statistics */
+	message->actual_length = tx_len + rx_len + 1;
+	/* complete the transaction */
+	message->status = 0;
+	spi_finalize_current_message(master);
+
+	return 0;
+}
+
+static int amd_spi_master_transfer(struct spi_master *master,
+				   struct spi_message *msg)
+{
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+
+	/*
+	 * Extract spi_transfers from the spi message and
+	 * program the controller.
+	 */
+	amd_spi_fifo_xfer(amd_spi, msg);
+
+	return 0;
+}
+
+static int amd_spi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_master *master;
+	struct amd_spi *amd_spi;
+	struct resource *res;
+	int err = 0;
+
+	/* Allocate storage for spi_master and driver private data */
+	master = spi_alloc_master(dev, sizeof(struct amd_spi));
+	if (!master) {
+		dev_err(dev, "Error allocating SPI master\n");
+		return -ENOMEM;
+	}
+
+	amd_spi = spi_master_get_devdata(master);
+	amd_spi->master = master;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	amd_spi->io_remap_addr = devm_ioremap_resource(&pdev->dev, res);
+
+	if (!amd_spi->io_remap_addr) {
+		dev_err(dev, "ioremap of SPI registers failed\n");
+		err = -ENOMEM;
+		goto err_free_master;
+	}
+	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
+
+	/* Initialize the spi_master fields */
+	master->bus_num = 0;
+	master->num_chipselect = 4;
+	master->mode_bits = 0;
+	master->flags = 0;
+	master->setup = amd_spi_master_setup;
+	master->transfer_one_message = amd_spi_master_transfer;
+
+	/* Register the controller with SPI framework */
+	err = spi_register_master(master);
+	if (err) {
+		dev_err(dev, "error registering SPI controller\n");
+		goto err_iounmap;
+	}
+	platform_set_drvdata(pdev, amd_spi);
+
+	return 0;
+
+err_iounmap:
+	iounmap(amd_spi->io_remap_addr);
+err_free_master:
+	spi_master_put(master);
+
+	return 0;
+}
+
+static int amd_spi_remove(struct platform_device *pdev)
+{
+	struct amd_spi *amd_spi = platform_get_drvdata(pdev);
+
+	spi_unregister_master(amd_spi->master);
+	spi_master_put(amd_spi->master);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct acpi_device_id spi_acpi_match[] = {
+	{ "AMDI0061", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, spi_acpi_match);
+
+static struct platform_driver amd_spi_driver = {
+	.driver = {
+		.name = "amd_spi",
+		.acpi_match_table = ACPI_PTR(spi_acpi_match),
+	},
+	.probe = amd_spi_probe,
+	.remove = amd_spi_remove,
+};
+
+module_platform_driver(amd_spi_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sanjay Mehta <sanju.mehta@amd.com>");
+MODULE_DESCRIPTION("AMD SPI Master Controller Driver");
-- 
2.7.4

