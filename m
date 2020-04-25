Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312011B8931
	for <lists+linux-spi@lfdr.de>; Sat, 25 Apr 2020 22:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgDYUAf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 25 Apr 2020 16:00:35 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:64065
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbgDYUAf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 25 Apr 2020 16:00:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhz/6un/feUTi+dTEJ/M2fct/1rPjxHpds9/k/s9ug0yXA4Aqlqp3BVhDcerUo3uLAor0DDIi0W0cF0iH/9jZh0GrjjQf0oXOQt02lqp//Mo83PCO6k1mM8dMxvesd/wjWAztfrF+1UuO142L4KVjXZc4pEtuMJg0KPcLKaIVY39if/ZxjtRmDAO+tWQwYnevtzEop4FmwA/7ykOGpuq2+4AqFFxG7YeS2qNw9gB6znyi+F7izQkcxa0qNqWCbc0qO7C4GSC3TOyXUOZ2KGuamwuCOSrlOH7JlmHv8iJaVygMhd537Ljbs04MrTw1njVJwYY03nJbUJhS8zOn/IdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvxyaIq66DHz7XUXc5xmK6nNPxXm1qMxYjauaKv42jY=;
 b=V5K0fBkM0MlKzglPgfK5OZ1r2nndd/aMWdmFnTxWIDWTyuPJjb8d9Wc1sZOk7jZS8wOMMkyw/NCDlU5yeWwf6lM+2VonP0QrDm5xQYngHAYM1fgS9Cf3YU88/aGNKr4UQtbCDJ67bnWszqFPJ2/GfPMVDmLd2kvDVUoGLZYGnvtG8x+JvctD4HOuX//A6NNK6GtwFkaEo292xX2Py5tWP2kyQoxVdR165ZTdMb2E4nbeAXyh9j4eaq5SF0NXflGse/dPVjlWgLgDF+CL102ns7QRUGo+aAQwYTj6yPX+Ld/kRdUCmZVMsrGI8OrqcaQ3FFpclm31Q4orEf2KYPNdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvxyaIq66DHz7XUXc5xmK6nNPxXm1qMxYjauaKv42jY=;
 b=GvRztudWpjPwHvfR/14hYah3CHRPf22ESzMHmFJpxlqc3a15jArvOXxWv6Zkp8Ht0Jamla1zJ3+QEXpASoa6aisjaSVCzvgQmlt2/C20FILqJxSRhV5P7JAlairjSXBh4Xk+o/G6Tc4gofGTXT+mARiWZPJem8Iy+wi8ZpJIrpI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from DM6PR12MB3420.namprd12.prod.outlook.com (2603:10b6:5:3a::27) by
 DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Sat, 25 Apr 2020 20:00:31 +0000
Received: from DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0]) by DM6PR12MB3420.namprd12.prod.outlook.com
 ([fe80::7545:386:8328:18a0%6]) with mapi id 15.20.2937.020; Sat, 25 Apr 2020
 20:00:31 +0000
From:   Sanjay R Mehta <sanju.mehta@amd.com>
To:     broonie@kernel.org
Cc:     Nehal-bakulchandra.Shah@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2] spi: spi-amd: Add AMD SPI controller driver support
Date:   Sat, 25 Apr 2020 14:59:48 -0500
Message-Id: <1587844788-33997-1-git-send-email-sanju.mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::18) To DM6PR12MB3420.namprd12.prod.outlook.com
 (2603:10b6:5:3a::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MAXPR01CA0100.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2937.13 via Frontend Transport; Sat, 25 Apr 2020 20:00:28 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7db3f79-e973-4130-f253-08d7e9534e73
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:|DM6PR12MB4123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41233D1C3558CCF5176C83FCE5D10@DM6PR12MB4123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0384275935
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3420.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(316002)(8936002)(81156014)(6486002)(4326008)(186003)(6916009)(16526019)(6666004)(66556008)(956004)(478600001)(86362001)(52116002)(7696005)(8676002)(36756003)(2616005)(26005)(2906002)(5660300002)(30864003)(66476007)(66946007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjOA5742bQFAC9I5CoLlhWLPBnA9as+BtSUAEGs4m/WE0yu58Dw170S9r2r33Za5l0pcAHOguQj9a6UT6xbE8ldrculk1dc44Zl8onaeMbhNmIX8gQUDs/5aIjiecTs5A5eMu7CojctrlFIqT1EMjE8PBVHKvjuC+Q/n3PbDyuHeLLRDM9O7aLS5kgD97j7BSY+bbil0RBYEXPt7rn+L37OCAmHTs7FNSJuvt/4/CzhBkcb5QnlmJDkgWJXfYfeYwqo/ODRDBndLhkPWCI50ib7aNItcb32YJF2C9lZEiBQ+jMcXOtbIaKr4vwbCXCR6KHLpQD7koyErNPREGtkcxrwkreTJVQqZFvlVJQWQKNIk4NEEiakicX2XwsTeC4KsvETvqzPFDtm2y4n84OnuQE7ilUFxjPnxOgxR72JsjnZh2OUJy3rTCKIWOJ0rwI8W
X-MS-Exchange-AntiSpam-MessageData: v4nrdKKEjSoB99cJ4drU71vkTgsioxKhcvLtUauaR+EYI0I2Fnwu2OHHfipNsRyl2Tvw1mKlqgkzrxysuPA5uvl37SMg/BmdYwk76Uu9/81Ealdhphhd5WfboBICwv4Io8Pg7XOmo2cjGSHsPmwlQUIgNzlG/St5muKkXvnlpO8t2lAZVDz9o4fohiNwFJ3bT7g/82XEynPax7cDtPxqdIrirKRPeIi0hvceNvugzApCYdsUoPTPck51SYTDJzXNN0Rit8FW0ATpR8FLzb5ZPv2XuTNcLvAdn24PNweX4Lf85c4dcy2r7MnrAiNNtRKkESdfE1F1eGUSzuyW9MWHu6V6YnethhHlyr/6j1VUB1Py5qz168BdwpjMMkgvxAk+D4sJIJEwXtGDdFP02Hvwg2qpeENqSb4Xn/0bZSvB9Yiu+JZJ+8y9/z9ilAkE0Wh4XAhvEF2o02L2aKWK42Jz/5ZPBFDXutlXDYQfmaFMLkwYKun2fem2fXC5dIolBY1r/GA8NqC77KI/0snZ/7olawHRf6MsVtA1wTHUGJXKTgst5nZB8loUogLXvcPEFvIV9malouRO9RZXvdTkN/kUcybR13OENzKjshRxWBRl8lj2lr88sXWIjDB7FZcTmw+63f8jOeQAJz66GH01rWFR6uvb6qk5vYTP4IHTnv5bqN5/6k7hwMWjOjBBlhgVV1/MA2QGSRLNA8ZgiUU2/zmqVFyanBfCIjh528TlrYBePp3HFWvoMBK/gyAzf3ljf9Z/OOdOxXrAhjv0Ngj9z//nKeoieICyAFNxcjWfqxGoRE1kazjLml3us5houCmMNYgz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7db3f79-e973-4130-f253-08d7e9534e73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 20:00:31.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnctzGcnayKFOcd5TFS0Bpmd6oQ5jW0qWqxGz1xJqGubRp3QpaXc3lxtFm5iT9U5wRx2j3aGKXJmJperUkfupw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver supports SPI Controller for AMD SOCs.This driver
supports SPI operations using FIFO mode of transfer.

ChangeLog v1->v2:
	- Fix up to handle multiple receive transfer case.
	- move chip_select in transfer_message, flag device as
	  half-duplex and some cosmetic changes.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS           |   5 +
 drivers/spi/Kconfig   |   6 +
 drivers/spi/Makefile  |   1 +
 drivers/spi/spi-amd.c | 333 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 345 insertions(+)
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
index 0000000..0d9debe
--- /dev/null
+++ b/drivers/spi/spi-amd.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+//
+// AMD SPI controller driver
+//
+// Copyright (c) 2020, Advanced Micro Devices, Inc.
+//
+// Author: Sanjay R Mehta <sanju.mehta@amd.com>
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
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
+#define AMD_SPI_XFER_TX		1
+#define AMD_SPI_XFER_RX		2
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
+static inline int amd_spi_busy_wait(struct amd_spi *amd_spi)
+{
+	bool spi_busy;
+	int timeout = 100000;
+
+	/* poll for SPI bus to become idle */
+	spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
+		    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
+	while (spi_busy) {
+		usleep_range(10, 20);
+		if (timeout-- < 0)
+			return -ETIMEDOUT;
+
+		spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
+			    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
+	}
+
+	return 0;
+}
+
+static void amd_spi_execute_opcode(struct spi_master *master)
+{
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+
+	/* Set ExecuteOpCode bit in the CTRL0 register */
+	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD,
+			       AMD_SPI_EXEC_CMD);
+
+	amd_spi_busy_wait(amd_spi);
+}
+
+static int amd_spi_master_setup(struct spi_device *spi)
+{
+	struct spi_master *master = spi->master;
+
+	amd_spi_clear_fifo_ptr(master);
+
+	return 0;
+}
+
+static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
+				    struct spi_message *message)
+{
+	struct spi_master *master = amd_spi->master;
+	struct spi_transfer *xfer = NULL;
+	u8 cmd_opcode, opcode = 0;
+	u8 *buf = NULL;
+	u32 m_cmd = 0;
+	u32 i = 0;
+	u32 tx_len = 0, rx_len = 0;
+
+	list_for_each_entry(xfer, &message->transfers,
+			    transfer_list) {
+		if (xfer->rx_buf)
+			m_cmd = AMD_SPI_XFER_RX;
+		if (xfer->tx_buf)
+			m_cmd = AMD_SPI_XFER_TX;
+
+		if (m_cmd & AMD_SPI_XFER_TX) {
+			buf = (u8 *)xfer->tx_buf;
+			tx_len = xfer->len - 1;
+			cmd_opcode = *(u8 *)xfer->tx_buf;
+			buf++;
+			amd_spi_set_opcode(master, cmd_opcode);
+
+			/* Write data into the FIFO. */
+			for (i = 0; i < tx_len; i++) {
+				iowrite8(buf[i],
+					 ((u8 __iomem *)amd_spi->io_remap_addr +
+					 AMD_SPI_FIFO_BASE + i));
+			}
+
+			amd_spi_set_tx_count(master, tx_len);
+			amd_spi_clear_fifo_ptr(master);
+			/* Execute command */
+			amd_spi_execute_opcode(master);
+		}
+		if (m_cmd & AMD_SPI_XFER_RX) {
+			/*
+			 * Store no. of bytes to be received from
+			 * FIFO
+			 */
+			rx_len = xfer->len;
+			buf = (u8 *)xfer->rx_buf;
+			amd_spi_set_rx_count(master, rx_len);
+			amd_spi_clear_fifo_ptr(master);
+			/* Execute command */
+			amd_spi_execute_opcode(master);
+			/* Read data from FIFO to receive buffer  */
+			for (i = 0; i < rx_len; i++)
+				buf[i] = amd_spi_readreg8(master,
+							  AMD_SPI_FIFO_BASE +
+							  tx_len + i);
+		}
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
+	struct spi_device *spi = msg->spi;
+
+	amd_spi->chip_select = spi->chip_select;
+	amd_spi_select_chip(master);
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
+		dev_err(dev, "error %d ioremap of SPI registers failed\n", err);
+		err = -ENOMEM;
+		goto err_free_master;
+	}
+	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
+
+	/* Initialize the spi_master fields */
+	master->bus_num = 0;
+	master->num_chipselect = 4;
+	master->mode_bits = 0;
+	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->setup = amd_spi_master_setup;
+	master->transfer_one_message = amd_spi_master_transfer;
+
+	/* Register the controller with SPI framework */
+	err = spi_register_master(master);
+	if (err) {
+		dev_err(dev, "error %d registering SPI controller\n", err);
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
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Sanjay Mehta <sanju.mehta@amd.com>");
+MODULE_DESCRIPTION("AMD SPI Master Controller Driver");
-- 
2.7.4

