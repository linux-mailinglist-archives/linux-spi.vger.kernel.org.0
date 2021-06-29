Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92DA3B7691
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 18:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhF2Qlb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 12:41:31 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:43168
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233979AbhF2Qla (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Jun 2021 12:41:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ5oEwn7IA51SZi7O6Uq2iCy/Ykt1kM9a0CdeETRgXpMo5RwVEiadx6NbMAHH4zRMJqjAlPM3ljzL5LV60O6P2oXDXpQcdb+yqxn6Y67uCpz2xOXYb9uuLAUINJHrY1v3ki7yxdslQHErVk+E0faN3YcWILaTc24007WSg3fUAbU1uoNVEQhE9+Fchh3zOVAHePzatTo+Yl9Y9dh+dN/VnN7AGH3uJi/fMiwvmbLiptCcWESYni4mwd6DEp1LCjCn3yk/cEi8CdZsbBElm/U7Q9Y7paZSUmhVY0Gxp+GfXgE+k57hE8XoadphS/snobs5wvXugkU4qEmtOgnpDPEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AC1qehoDc3RvM73d02s4/qV7v3QNq2ICBv92UkgEFY=;
 b=W8GqDugHwFMw9JcKebrPOxHlwWjAmYwKfil9sLxvAlDvN1hP3gH2XXCU+eXNzNvYvEMbJca6rTVlF1n1TT/+buLJIqqSXtHLQi+0BvwDY8QlqbmowjwFRq8eTDS+yJ9hCTG3tPrZDwALrWkCIYV8YQkIKRXb0YGK4aD7HXps2/ZEawTPBvjwZyX6EbsAu8JYGQx+UYyr9wqAlyrXctyqiZ7zw57b6fHUdAH0ZvAASaFzWHPUGZZ6NEORG+qr/QRMhJ5Kgvi1C8DrEQ2UE+Uvi/qwPMjp6vWnlQcZTgv2Q1WkfezhI/axrnm7ay8hE/h5najPReZrT8Ydqtu9scyJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AC1qehoDc3RvM73d02s4/qV7v3QNq2ICBv92UkgEFY=;
 b=u0d9A2Y93nJ/0oFnE+JFhclg/B98Twe3Cnw0gdaTnytVFpQCkb/R2K7xj3kpoeu5Jc5UaRcFQLUjOUBay7/xl2reNPf+a+gpSTLR6SLv1NEkUQZc/a5oY8fHo+zZUUbGJsSGXjuNXeEdd+isu049dAyiYs8Q2npfyXrHyEoexcg=
Received: from DM6PR13CA0060.namprd13.prod.outlook.com (2603:10b6:5:134::37)
 by DM5PR12MB1803.namprd12.prod.outlook.com (2603:10b6:3:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Tue, 29 Jun
 2021 16:39:00 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::66) by DM6PR13CA0060.outlook.office365.com
 (2603:10b6:5:134::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend
 Transport; Tue, 29 Jun 2021 16:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 16:39:00 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 11:38:57 -0500
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nehal Bakulchandra Shah" <Nehal-Bakulchandra.shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Liang Liang <liang.liang@amd.com>
Subject: [RESEND PATCH v2 2/2] spi:amd: Fix for transfer large size of data
Date:   Tue, 29 Jun 2021 22:08:34 +0530
Message-ID: <20210629163834.581774-3-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629163834.581774-1-Nehal-Bakulchandra.shah@amd.com>
References: <20210629163834.581774-1-Nehal-Bakulchandra.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f4199b9-ffdc-4fc9-0d5d-08d93b1c65e3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1803:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1803D34F41796A7DEDF6A0EEA0029@DM5PR12MB1803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSRYufwQsNQ25BpDNjj4uZkMXwVhQrgTxmgThuUrUiEJUgdatD87jv8OzsxbqE/GFY7PuUYj8FlNB/Y7TKqvNskNcyr826Tc/62tgZ2+OBSYWsMfbwSA/B836kMSW2t5ZfUqe5ygq02AL9Yd9/RGBDDIJGgqvz35HKOP144MJ6ERpDnbZ16UtixTV6gvUeDab8pZWfqHaH45d0SNBxrqQWYHrVAVfbBmIS/Xz+lvXcL0x++3W6gZ9b4qRIkgtkDU7nZ1yHKKIqHQZbD1OzpT17Q8wcJVgipls0BXPCd4zhqhKELTSNwG77rCCHvCX39vAy7sVQ2tata5GuestQAjOFG8UxJXfwzMdGzYCIlQgP7nujlClLYdPXxMQeRlzeTzrAFElNxmZMh3pC6NeiJJoOeeDPPsqDF9fwEUnyGobQO4EH3Fmfi2JC0PWZ/2WtoWrg7zVwtk3A+pKMcA/ooTaMUjZ4gwwzKcTIgfTwrrmShFci9dyjvQ22IcR2ZLDrae5oKR/UOgcOmC5NFNuAehB31Izp2dWezYNSbCkoFJs41/40Ht/ISJEcqbKyUjhY1ScOfYf3A+0WuEJtqCAc+x5LQLsk2zuBcOOAh0VOuwQrFgDEtkVMD4iPL9oZcQJmGp0KO7mRncOePQ6k4lveDMMHzBo4/iuVUkUPzMMJin03NAFlQvBByULuud152hmdaUiQ2IU7WV2bDecZxCqOEVy+HfDKpPV+Pn8bLTVXR2hXA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(36840700001)(46966006)(1076003)(26005)(82740400003)(186003)(16526019)(6666004)(82310400003)(83380400001)(7696005)(47076005)(86362001)(356005)(81166007)(4326008)(70206006)(70586007)(54906003)(2616005)(5660300002)(316002)(36860700001)(336012)(36756003)(8676002)(8936002)(2906002)(426003)(6916009)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 16:39:00.3058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4199b9-ffdc-4fc9-0d5d-08d93b1c65e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1803
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hardware has 72 bytes of FIFO.This patch addresses the same by means
of software workaround.

Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Reviewed-by: Liang Liang <liang.liang@amd.com>
Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
---
 drivers/spi/spi-amd.c | 77 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index e65e7178d5fe..d608c27fe599 100644
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
@@ -29,7 +30,7 @@
 #define AMD_SPI_TX_COUNT_REG	0x48
 #define AMD_SPI_RX_COUNT_REG	0x4B
 #define AMD_SPI_STATUS_REG	0x4C
-
+#define AMD_SPI_FIFO_SIZE	72
 #define AMD_SPI_MEM_SIZE	200
 
 /* M_CMD OP codes for SPI */
@@ -215,8 +216,8 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 	u8 cmd_opcode;
 	u8 *buf = NULL;
 	u32 m_cmd = 0;
-	u32 i = 0;
-	u32 tx_len = 0, rx_len = 0;
+	u32 i = 0, it = 0, tx_index = 0, rx_index = 0;
+	u32 tx_len = 0, rx_len = 0, iters = 0, remaining =  0;
 
 	list_for_each_entry(xfer, &message->transfers,
 			    transfer_list) {
@@ -230,17 +231,40 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 			tx_len = xfer->len - 1;
 			cmd_opcode = *(u8 *)xfer->tx_buf;
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
@@ -250,16 +274,38 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
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
 
@@ -365,4 +411,5 @@ module_platform_driver(amd_spi_driver);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Sanjay Mehta <sanju.mehta@amd.com>");
+MODULE_AUTHOR("Nehal Bakulchandra Shah <nehal-bakulchandra.shah@amd.com>");
 MODULE_DESCRIPTION("AMD SPI Master Controller Driver");
-- 
2.25.1

