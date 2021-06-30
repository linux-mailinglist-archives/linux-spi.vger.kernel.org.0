Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A383B819F
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 14:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhF3MHR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 08:07:17 -0400
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:58689
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234387AbhF3MHR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 08:07:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTVknQVRuMqUvVLisMghGSnIDGET7SXZEIMHQtTl7IwI7m5/YqmQ8NE94jkQhFgvmMuy8mraLl2D0NsKvnvYriip/nRlLaQA6wW1+M5iAolrRVcL6bqwD9XZxep0u9qJev0xae1+YR0edae7KVLcuGFvZKwGarTA2gKuDsgXKw4CkNrDlQeypGJDDPPro3AS6TzH6gYFECyi/xgP8Bakvh9s9h93JRC56ur6rDYmUh73x0ulGto+KqsDh1xUtY7LLo2BDLYZlIhrfKpZ/6RvprIPes3znBo3mVsYrq5d87TisVJwyD9sLchDtWpf//yasDltqJWsuxiCPHbw6MKuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+32KAULdQkLlVkBqCNZD1H7u4OXbAizOZJxl149RKc=;
 b=c5cfRxUTUt+CaT11BDgRUTq+vZcl2BuRGJJKpStC8x2nK1c7KgHLvnTPYNYlk8y6TM9bS2o7DOgDgOY6uWy1E5gUL9ZE6VBIeHoaPpKAdfAD+Pqhfese6WnODdYpNLVeFRufpqI0D7pG8cNYYywRcIX8BUTSNGjnPjwv1vPfCMXd56JT8jBUwV31f5P6K0Paav6dqHAkF6rKtoc3Twxi2QjZi2/ZKJCtPx9pNXZ0cthLzlurXwjZs16eCFP6azfGvSZsGT4C4iOXoytDjKP3uAEhCjs22uPQXzsUZ75hnpxY9kQvxMvI2p+Spz/fFjsZdsHC4pw7Tks3RuBSkWygvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+32KAULdQkLlVkBqCNZD1H7u4OXbAizOZJxl149RKc=;
 b=lGbeeYvrDN5mlMJCK6+UGrqDnMhNV6yYnq9d6LUFFxdEKVXcAXuY01O+9FsXFJPv6t3l5X+DKWqvs7fdF/zlUjF2mOZfQSbTeKhWvz95LN5R/Zhicq9rxmfR8J/L+1d63cBLHxgKGE0XpmaOhZbsRnKNICd5IUeXw0LV2QmwjIg=
Received: from MWHPR04CA0072.namprd04.prod.outlook.com (2603:10b6:300:6c::34)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 12:04:46 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::3f) by MWHPR04CA0072.outlook.office365.com
 (2603:10b6:300:6c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 30 Jun 2021 12:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 12:04:46 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 07:04:43 -0500
From:   Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nehal Bakulchandra Shah" <Nehal-Bakulchandra.shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Liang Liang <liang.liang@amd.com>
Subject: [PATCH v3 2/3] spi:amd: Fix for transfer large size of data
Date:   Wed, 30 Jun 2021 17:34:24 +0530
Message-ID: <20210630120425.606957-3-Nehal-Bakulchandra.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210630120425.606957-1-Nehal-Bakulchandra.shah@amd.com>
References: <20210630120425.606957-1-Nehal-Bakulchandra.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f102e42f-1aca-45a2-63e3-08d93bbf40f3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4420:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4420CDC06F68E269C4986901A0019@DM6PR12MB4420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSRLYiakIyuVjz7VdgSXcpKV9UNigF49hHHmwYjtq6/N6m9ePjVsq+H0r90OEXmBVW4fIlDYdv46ro33wvBdeKIiLfEgIMYdU4y/A/psOmhNpZN2DhAowWWHMMWmj9Bue1ajQx/1jr6CNXj9bS6HFySgVL9cVDomlbGrwv4YxO8rggh2l9P6PIJW1oQdslcbYYo11FEVzO+OIj0xkVN29/rDIPyXj9WokeGZPDvjLjIPebW2lBXIbZJ5auNQSSwFISqIEDQNfb5fdhhMp0bWuG4Vs0LrWpNOPUwOb5xoFTRu8yf8gj4FUB4wgGDVQ3QAUqUzEx9MbulfPFDzF8dZnT3mIdpUB5dk4e/iThjtsmckwENn3SeeiH0R88q8yfG0hZHDGTdI7L+4gd3cuBIrnkZ+1fLXlWD8b3xAwHchEHN7dFoQsR00ckgxPC7fzBc+Rgo33SUzE08wuRLamN4eNEaeNDxJF4Tes3BJOUYM/37mYEdM8a68OnJZ4iZxJSscvzbDhUmXP6DHAPS6wHsTKQ66zWr9gqE+sYPSz19IAUCU+JDWGx3qZ2oY/PD74Yj8ax+qCgir1EwMKlMBQfAvRlmblQUfoW+1zR2cQW49+ONGvu1vMWKdOHuwpwYu65CQjM2pxcD4MwW19uDHy+aCRlgk88ArDUZvI3GpY6l2xudiC0P1qI4D9PL2Jk1e3ovBhYNN6lMGRpOolXnAvs3vTdwlrSOjWMq6S0mAxuQ844Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966006)(36840700001)(8936002)(2906002)(4326008)(1076003)(6916009)(86362001)(36860700001)(5660300002)(36756003)(54906003)(70586007)(70206006)(47076005)(6666004)(26005)(82310400003)(336012)(16526019)(8676002)(7696005)(82740400003)(426003)(81166007)(478600001)(2616005)(356005)(186003)(83380400001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 12:04:46.2381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f102e42f-1aca-45a2-63e3-08d93bbf40f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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
index 2150f54512d9..2849f901a075 100644
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

