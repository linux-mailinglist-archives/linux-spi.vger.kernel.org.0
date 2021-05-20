Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41B838B029
	for <lists+linux-spi@lfdr.de>; Thu, 20 May 2021 15:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhETNmJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 May 2021 09:42:09 -0400
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:61280
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232329AbhETNmJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 May 2021 09:42:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItgX7GI8Iku08HuRu+1zkpzlGWbKXeRlbr6IwiUIk0a9GD0/3CGLtQsBzX6e9O/l2lxCEq4hgrbHxR1uGu7ICQwcgAZbwB06cOhY6Lp79Gx58MvJOJMsfQ2RBiR4KBIQcBtJIGpGW/+Vin2QniX2yiRrVijft+8Da8ZE1W/pzUE1i/mrml77idyNhNaukRzAGePbX97tXK7RVE4RsJqfvwF+2lW3hVWvDSL4KdJzYfL+ssdDDqPVC+cqy0kyi6u3USj1AKbTeA3OH7V5VxQozkIVedcV3RfGNQ3XYVtpKs3rv/7UtXtEJfNV+gvowkdH3IEETSi01AuH/7tk93rcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/OvzfmWtwy7C+0IKgjkWR91QKERdOiqYdqVFu3NUFg=;
 b=IAJkfdfR5F6QbCxJGs6FpWv/FqDx+q/M15qtaRKL+tqsoGkfvZSUnjYfOTdqqh1KQRFoULx+5cofqr2pto1kSyx9OjgvDpOLEIz+gM4PVPJLDuH5aHTOLD2tSsM8BNZNqCx0kiGb7KoUvh+Hxfak0uIW6Zoaob3dbBybWHJmSqJa7/Hys+Yvl3PP4aWPWImpyT+YGU/+RHo76sFUjknpZIWWnHXSi28dZPiCRtoSyqDN2gC6pe6B6VmyKjhdVI+/eOcfFCUWTjPHnC6teA2WNs7rNkBP8tT7r4omZIPYnzwCxiEFZLa812Uy10jApGs4sroSURoxoRbAw8NbVhvwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/OvzfmWtwy7C+0IKgjkWR91QKERdOiqYdqVFu3NUFg=;
 b=hfLxMSbPzb+tVLL+jjaLnuJt40g4VKDrtAKkuj1+nbMCOhCJKHMSg+dXVkAE0mKNO5kNtXnyfSdM6x+o2lql1vzNMIqyfkYdcje7H3VqJQNpcBCe8eSixb6MFWDWLzBi1xWYRJfh5qhzMJIqKaZNT0oMuilBODqJMZTOGAZ/wrs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 13:40:46 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::69b8:2b8d:bce1:b1be]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::69b8:2b8d:bce1:b1be%7]) with mapi id 15.20.4150.025; Thu, 20 May 2021
 13:40:46 +0000
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Liang Liang <liang.liang@amd.com>
Subject: [PATCH] spi:amd: Add support for latest platform
Date:   Thu, 20 May 2021 19:09:46 +0530
Message-Id: <20210520133946.2263172-1-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR0101CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::17) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR0101CA0031.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 13:40:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eddb2bd-dbe8-455a-6a3c-08d91b94dee6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5355C36897F856F15DE69F0AA02A9@BN9PR12MB5355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KW0qZ/XBmer8Hbt8S4dkmTHvTC1DrLr0xgwbRIeGuAOT4zdWVICXL3hMw3uI64OXj2HCjjY0SNG1PZCPNJNL9eyQ9gPrKP+OZs4j6u1QewqN8ja7+FiGpEbpzfdXAljpxd5bT2cTsrgMXzchjElQkD1i/rZ+yGIJgdXvSOFzG8SQSLvVMLdMUCjudk6H3xv0PhUVK1w9mEUY9552FaGxMTQdPfJV+f88hp0bIUg+MqIWWMk1pjD0P96d8N07hEfc+suggMkffE7M/2sFahd+EkvLe9jMJeymS4DksgtBEEhR47e+i1d8f0B1RIgrA+zc1yLv+9WaNXxSNqNiUe0dVikwuUiDsppYFa7SclxLxK8HVa6u4T6xwR5wqK/PiwrUdKalQBTo7ge0b29FyIRiHEcvD3VLWezUSBLkCMsjhlXFRsoE3GS54Dh596CXQMEvRuHi8u34EnXT8nPv4lbvp+u2SabKBZF4+GYnEhrck5FCeHzW5aLASA+Lp4+pl6eFM+skcmUZ1ZawmTiZSk079G1yo4ghxcVXwjxiQVHBWpDC9sNyw3gX1z7HX1XVT0BqEC6T0lbmMZZFpCDLDwVPZTbtPEXfmDU1xFg0agsNdqnKhZ7gLyrEX+E+xq5CqaKDwSr/fmwBX3kPqZOvB/HReHIRpmeKnqJ+7vQ4kFUtkbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(316002)(54906003)(956004)(52116002)(8676002)(7696005)(2616005)(8936002)(4326008)(5660300002)(6486002)(66946007)(66476007)(66556008)(16526019)(2906002)(478600001)(186003)(83380400001)(38350700002)(36756003)(38100700002)(86362001)(26005)(1076003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EL3QW3y4qmk4yAVqe0GiFXWHRpiJoaN7QaZFsnFwpphbmFAuXSsQ3uJukSQn?=
 =?us-ascii?Q?naYxiVbZVoPpZ9kbMo0AV4IYd7ILXsqalPqAOdqEg3nUM6XDxLAblCDxEJMD?=
 =?us-ascii?Q?EFw24KnKe6GSvZkVKMg0PldIK1XzKPLf4k9h35XpQeR1CPoj51DnycjKY0Pk?=
 =?us-ascii?Q?3tcnw+2gkTi2pR+MB7iDOYR0sJzkN86tzUuH4UrUC+4JV/wKD57vCGF0hmqq?=
 =?us-ascii?Q?EsIE9thzou6mFmTdPeOuphX5JCmzr64Qa6OWkDI+C8eNbv1IgLYxBOWxpa+r?=
 =?us-ascii?Q?kfiq30d9zUBH7wKpIMqOL9GHg59nVZGajIcHLuU+YjO+4A3UufQnXmaYl+Om?=
 =?us-ascii?Q?qEm3wbY2/1U5eT07004HwJAgA1ryP1dArvQnm4F//1FG6Es4uPnlwuM/3Mo8?=
 =?us-ascii?Q?hLRnaQKb+CKNW+hxlEw69U7CwKzT1WcMwyFnn8/8N7NZL7Rpzet4PhqxZNvL?=
 =?us-ascii?Q?iB+EjKGSHFAxQsINCGz3m2FRGha3Gnl2wKxFELFzpwGJk2DKypZFubqi2Yz8?=
 =?us-ascii?Q?eUPrj6GFka/+GQG67oHV4QBBifwNnN1AnVyv9XfuZpFtRsNKSkiNZwpUgVHV?=
 =?us-ascii?Q?2G6rmW9H1K3h3UfJ/zn7EgOZ4RDIPUt6vmagUK7XNwcRtJBjzUaAWh6F83il?=
 =?us-ascii?Q?MRvcX2FtL1cSzURp7VibnTZy6A31A88IqiH7KoQjfEsKlJ/YeJTMxGoGJBJd?=
 =?us-ascii?Q?9ip9zFJbrLZeDi1yuXnhBjX/RfBmLUIecQmEJc3eA9rv1JDOiX4+yO7XPoMh?=
 =?us-ascii?Q?xvKgI4LDjuiKbQAUu9fBcfNA50xCqN4nBTYT835bnCYtlVhr0mPExuX2+yKu?=
 =?us-ascii?Q?07Tnu/GWnlpLiUVV+d1TylEx++DRVbd1FrDl8/5AEr+JNmN98Eq9Ksn8Pp5m?=
 =?us-ascii?Q?TCLkXSTQirx1gYoA3LRVrrTZXNjkMQcP8lPp4VFxOlCPRmsgIkLJtQQFac2S?=
 =?us-ascii?Q?Y/W7hFjXum2gKT3dPAn9Cz1dvRaLZ5gAAAB1W76p7OrUAcuY+idKdG93cxyk?=
 =?us-ascii?Q?uRXjWouqYTTrKpnPAX4yHn27yapeIusLRKDQjyQU/y67KAmQBt4yxDnFwBX3?=
 =?us-ascii?Q?hUjvVmrWNW67IS0TUtOtYpT797bovxRCzkUe35G0svpcRT5ub924MzjURg+L?=
 =?us-ascii?Q?9lwJgs0grE+RQoKOcgAWDHK7OhizPatX+m9l2fT7zTUqjcYw87I1YnlEE+Wr?=
 =?us-ascii?Q?GN8LR1qyQJLAL5VolLgfPR4gz9AE91E9TzjkpvZFSsvg3fXHnrUorL1MAMg5?=
 =?us-ascii?Q?REsxKv20ZV0C+q7zjlDUtfq6Utq6Qfo59wSM63IMLu6D4RHwIIb/75YL5sDK?=
 =?us-ascii?Q?7L5j4lDQ9a9Ga5toRaqfEcWu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eddb2bd-dbe8-455a-6a3c-08d91b94dee6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 13:40:46.0518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qbjLOuzDO/3glFzxmhiMXVl65DupE6OrlPPS5E5VK+l3tnm3AlHXRKjXoVJ88av
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

*Support for latest platform
*Hardware Fifo has 72 bytes limitation so fix for the larger data size.

Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Liang Liang (Leo) <liang.liang@amd.com>
Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
---
 drivers/spi/spi-amd.c | 160 +++++++++++++++++++++++++++++++++---------
 1 file changed, 128 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 3cf76096a76d..071c01eedbc3 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -2,9 +2,10 @@
 //
 // AMD SPI controller driver
 //
-// Copyright (c) 2020, Advanced Micro Devices, Inc.
+// Copyright (c) 2020-2021, Advanced Micro Devices, Inc.
 //
-// Author: Sanjay R Mehta <sanju.mehta@amd.com>
+// Authors: Sanjay R Mehta <sanju.mehta@amd.com>
+//          Nehal Bakulchandra Shah <nehal-bakulchandra.shah@amd.com>
 
 #include <linux/acpi.h>
 #include <linux/init.h>
@@ -14,31 +15,48 @@
 #include <linux/spi/spi.h>
 
 #define AMD_SPI_CTRL0_REG	0x00
+#define AMD_SPI_OPCODE_REG  0x45
+#define AMD_SPI_CMD_TRIGGER_REG 0x47
 #define AMD_SPI_EXEC_CMD	BIT(16)
 #define AMD_SPI_FIFO_CLEAR	BIT(20)
 #define AMD_SPI_BUSY		BIT(31)
-
+#define AMD_SPI_TRIGGER_CMD	BIT(7)
 #define AMD_SPI_OPCODE_MASK	0xFF
-
 #define AMD_SPI_ALT_CS_REG	0x1D
 #define AMD_SPI_ALT_CS_MASK	0x3
-
 #define AMD_SPI_FIFO_BASE	0x80
 #define AMD_SPI_TX_COUNT_REG	0x48
 #define AMD_SPI_RX_COUNT_REG	0x4B
 #define AMD_SPI_STATUS_REG	0x4C
-
+#define AMD_SPI_FIFO_SIZE	72
 #define AMD_SPI_MEM_SIZE	200
-
 /* M_CMD OP codes for SPI */
 #define AMD_SPI_XFER_TX		1
 #define AMD_SPI_XFER_RX		2
 
+struct amd_spi_devtype_data {
+	u32 spi_status;
+	u8	version;
+};
+
+static const struct amd_spi_devtype_data spi_v1 = {
+	.spi_status	= AMD_SPI_CTRL0_REG,
+	.version	= 0,
+};
+
+static const struct amd_spi_devtype_data spi_v2 = {
+	.spi_status	= AMD_SPI_STATUS_REG,
+	.version	= 1,
+};
+
 struct amd_spi {
 	void __iomem *io_remap_addr;
 	unsigned long io_base_addr;
 	u32 rom_addr;
 	u8 chip_select;
+	const struct amd_spi_devtype_data *devtype_data;
+	struct spi_device *spi_dev;
+	struct spi_master *master;
 };
 
 static inline u8 amd_spi_readreg8(struct spi_master *master, int idx)
@@ -98,6 +116,14 @@ static void amd_spi_select_chip(struct spi_master *master)
 			      AMD_SPI_ALT_CS_MASK);
 }
 
+static void amd_spi_clear_chip(struct spi_master *master)
+{
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+	u8 chip_select = amd_spi->chip_select;
+
+	amd_spi_writereg8(master, AMD_SPI_ALT_CS_REG, chip_select & 0XFC);
+}
+
 static void amd_spi_clear_fifo_ptr(struct spi_master *master)
 {
 	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_FIFO_CLEAR,
@@ -106,8 +132,13 @@ static void amd_spi_clear_fifo_ptr(struct spi_master *master)
 
 static void amd_spi_set_opcode(struct spi_master *master, u8 cmd_opcode)
 {
-	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, cmd_opcode,
-			       AMD_SPI_OPCODE_MASK);
+	struct amd_spi *amd_spi = spi_master_get_devdata(master);
+
+	if (!amd_spi->devtype_data->version)
+		amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, cmd_opcode,
+				       AMD_SPI_OPCODE_MASK);
+	else
+		amd_spi_writereg8(master, AMD_SPI_OPCODE_REG, cmd_opcode);
 }
 
 static inline void amd_spi_set_rx_count(struct spi_master *master,
@@ -126,17 +157,20 @@ static inline int amd_spi_busy_wait(struct amd_spi *amd_spi)
 {
 	bool spi_busy;
 	int timeout = 100000;
+	u32 status_reg = amd_spi->devtype_data->spi_status;
 
 	/* poll for SPI bus to become idle */
 	spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
-		    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
+				status_reg) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
+
 	while (spi_busy) {
-		usleep_range(10, 20);
+		usleep_range(10, 40);
 		if (timeout-- < 0)
 			return -ETIMEDOUT;
 
+		/* poll for SPI bus to become idle */
 		spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
-			    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
+				status_reg) & AMD_SPI_BUSY) == AMD_SPI_BUSY;
 	}
 
 	return 0;
@@ -146,9 +180,14 @@ static void amd_spi_execute_opcode(struct spi_master *master)
 {
 	struct amd_spi *amd_spi = spi_master_get_devdata(master);
 
+	amd_spi_busy_wait(amd_spi);
 	/* Set ExecuteOpCode bit in the CTRL0 register */
-	amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD,
-			       AMD_SPI_EXEC_CMD);
+	if (!amd_spi->devtype_data->version)
+		amd_spi_setclear_reg32(master, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD,
+				       AMD_SPI_EXEC_CMD);
+	else
+		amd_spi_setclear_reg8(master, AMD_SPI_CMD_TRIGGER_REG, AMD_SPI_TRIGGER_CMD,
+				      AMD_SPI_TRIGGER_CMD);
 
 	amd_spi_busy_wait(amd_spi);
 }
@@ -170,8 +209,8 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 	u8 cmd_opcode;
 	u8 *buf = NULL;
 	u32 m_cmd = 0;
-	u32 i = 0;
-	u32 tx_len = 0, rx_len = 0;
+	u32 i = 0, it = 0, tx_index = 0, rx_index = 0;
+	u32 tx_len = 0, rx_len = 0, iters = 0, remaining =  0;
 
 	list_for_each_entry(xfer, &message->transfers,
 			    transfer_list) {
@@ -182,20 +221,43 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 
 		if (m_cmd & AMD_SPI_XFER_TX) {
 			buf = (u8 *)xfer->tx_buf;
-			tx_len = xfer->len - 1;
 			cmd_opcode = *(u8 *)xfer->tx_buf;
+			tx_len = xfer->len - 1;
 			buf++;
+
+			tx_index = 0;
+			iters = tx_len / AMD_SPI_FIFO_SIZE;
+			remaining = tx_len % AMD_SPI_FIFO_SIZE;
+
+			for (it = 0; it < iters; it++) {
+				amd_spi_clear_fifo_ptr(master);
+				amd_spi_set_opcode(master, cmd_opcode);
+
+				amd_spi_set_tx_count(master, AMD_SPI_FIFO_SIZE);
+				/* Write data into the FIFO. */
+				for (i = 0; i < AMD_SPI_FIFO_SIZE; i++) {
+					iowrite8(buf[tx_index],
+						 ((u8 __iomem *)amd_spi->io_remap_addr +
+						 AMD_SPI_FIFO_BASE + i));
+					tx_index++;
+				}
+
+				/* Execute command */
+				amd_spi_execute_opcode(master);
+			}
+
+			amd_spi_clear_fifo_ptr(master);
 			amd_spi_set_opcode(master, cmd_opcode);
 
+			amd_spi_set_tx_count(master, remaining);
 			/* Write data into the FIFO. */
-			for (i = 0; i < tx_len; i++) {
-				iowrite8(buf[i],
+			for (i = 0; i < remaining; i++) {
+				iowrite8(buf[tx_index],
 					 ((u8 __iomem *)amd_spi->io_remap_addr +
-					 AMD_SPI_FIFO_BASE + i));
+					AMD_SPI_FIFO_BASE + i));
+				tx_index++;
 			}
 
-			amd_spi_set_tx_count(master, tx_len);
-			amd_spi_clear_fifo_ptr(master);
 			/* Execute command */
 			amd_spi_execute_opcode(master);
 		}
@@ -205,16 +267,38 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 			 * FIFO
 			 */
 			rx_len = xfer->len;
+			rx_index = 0;
+			iters = rx_len / AMD_SPI_FIFO_SIZE;
+			remaining = rx_len % AMD_SPI_FIFO_SIZE;
 			buf = (u8 *)xfer->rx_buf;
-			amd_spi_set_rx_count(master, rx_len);
+
+			for (it = 0 ; it < iters; it++) {
+				amd_spi_clear_fifo_ptr(master);
+
+				amd_spi_set_rx_count(master, AMD_SPI_FIFO_SIZE);
+
+				/* Execute command */
+				amd_spi_execute_opcode(master);
+				/* Read data from FIFO to receive buffer  */
+				for (i = 0; i < AMD_SPI_FIFO_SIZE; i++) {
+					buf[rx_index] = amd_spi_readreg8(master, AMD_SPI_FIFO_BASE +
+									tx_len + i);
+					rx_index++;
+				}
+			}
+
 			amd_spi_clear_fifo_ptr(master);
+
+			amd_spi_set_rx_count(master, remaining);
+
 			/* Execute command */
 			amd_spi_execute_opcode(master);
 			/* Read data from FIFO to receive buffer  */
-			for (i = 0; i < rx_len; i++)
-				buf[i] = amd_spi_readreg8(master,
-							  AMD_SPI_FIFO_BASE +
-							  tx_len + i);
+			for (i = 0; i < remaining; i++) {
+				buf[rx_index] = amd_spi_readreg8(master, AMD_SPI_FIFO_BASE +
+								tx_len + i);
+				rx_index++;
+			}
 		}
 	}
 
@@ -241,7 +325,8 @@ static int amd_spi_master_transfer(struct spi_master *master,
 	 * program the controller.
 	 */
 	amd_spi_fifo_xfer(amd_spi, master, msg);
-
+	if (amd_spi->devtype_data->version)
+		amd_spi_clear_chip(master);
 	return 0;
 }
 
@@ -250,6 +335,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct spi_master *master;
 	struct amd_spi *amd_spi;
+	struct resource *res;
 	int err = 0;
 
 	/* Allocate storage for spi_master and driver private data */
@@ -260,19 +346,25 @@ static int amd_spi_probe(struct platform_device *pdev)
 	}
 
 	amd_spi = spi_master_get_devdata(master);
-	amd_spi->io_remap_addr = devm_platform_ioremap_resource(pdev, 0);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	amd_spi->io_remap_addr = devm_ioremap_resource(&pdev->dev, res);
+
 	if (IS_ERR(amd_spi->io_remap_addr)) {
 		err = PTR_ERR(amd_spi->io_remap_addr);
 		dev_err(dev, "error %d ioremap of SPI registers failed\n", err);
 		goto err_free_master;
 	}
+	amd_spi->devtype_data = device_get_match_data(dev);
+	if (!amd_spi->devtype_data) {
+		err = -ENODEV;
+		goto err_free_master;
+	}
 	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
-
 	/* Initialize the spi_master fields */
 	master->bus_num = 0;
 	master->num_chipselect = 4;
 	master->mode_bits = 0;
-	master->flags = SPI_MASTER_HALF_DUPLEX;
 	master->setup = amd_spi_master_setup;
 	master->transfer_one_message = amd_spi_master_transfer;
 
@@ -293,7 +385,10 @@ static int amd_spi_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id spi_acpi_match[] = {
-	{ "AMDI0061", 0 },
+	{ "AMDI0061",
+	.driver_data = (kernel_ulong_t)&spi_v1 },
+	{ "AMDI0062",
+	.driver_data = (kernel_ulong_t)&spi_v2 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, spi_acpi_match);
@@ -311,4 +406,5 @@ module_platform_driver(amd_spi_driver);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Sanjay Mehta <sanju.mehta@amd.com>");
+MODULE_AUTHOR("Nehal Bakulchandra Shah <nehal-bakulchandra.shah@amd.com>");
 MODULE_DESCRIPTION("AMD SPI Master Controller Driver");
-- 
2.25.1

