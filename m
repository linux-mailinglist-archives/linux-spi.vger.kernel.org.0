Return-Path: <linux-spi+bounces-4851-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D21F97BB39
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 12:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B1DB20BED
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 10:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD7D291E;
	Wed, 18 Sep 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zcofx6oX"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7668381D5;
	Wed, 18 Sep 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657160; cv=fail; b=CvA0Fv9yXhOne/XmW0C085QBTmY8UtBU8UMpTTbETwSVB+q37KM1ycyBhrm1IWJmIa0La3Spbm9DcLbDr+z/K3eLuYtny2dYxTnm9k+SEqdvBWfYlFwmuLhpqACGPKVnRDIn0PKPmUqQCwBUqYKC1FlQpndh9HDARyWqfPdJBVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657160; c=relaxed/simple;
	bh=/cN0jLeJZqOJELSJDV3QVC70dWoDD5z/IW60y8skhoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGGxyy+QfwoHuA0goiuwlNoxbG4bdkpcve+XAjQY5GET82byORUc1199vNAWzab2Kl3WxaQGiRX3v1m6SadQQw2GJT4q8/Ix5s+Xb/AHxc+U7euja9tvevO2MrZyIpenGvUSVnItTCFZf30e9zajyo6qqJ+tkZTS0HuorDT2j0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zcofx6oX; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzkiiYkf+6/Pwl3kwaT5U/pL6QecDTGKi/q9/jLS5gvTMgLnPKu9hVK9sbuxvSSTzZZ58iCmqNSgyTC9v+b+jZCZJsgZjc7/46xt4ATJ0yCmSeKB6vHc3KeAjLqKx38yEpLfYJG/ooumV4p87K4EYXGxC8r2FYq/+sWnFkQZeW3zVQyZ2juDypKvdwWcMN6SxRAStYkKJsLAIV6c/bG/MpR06mluvLANkrZ2MOvHV27h/p4LJQZA9jjPm+/dM/26KPeK5vc1pDv3ezmHCmCVAClAeGr9n1/Veeu7EhMLU0EUXsT6XLXnFtEOfsStiOlwbOzqmPbwfxfsorNyHKo3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TRLtM00Pj/aucppfn7qH4fvZUWzwM37RRlC8UlOfCI=;
 b=cRyTMzKF42n3odspoJRM/Ly9h+HVd2AusrSKBg3s7H25W5Jvwst8CMwfnuxnMb3aq9Ogi0h98AAbuYTMREEOFfk+SIOykYJTNkNNxMU6w85Y66SIOdjwwNRwukRYEiI3AlnQtxzBF82ftlXCbQEVEUMeXfYdiuz0GxjdIqiwwlECsmPNpc4raXEtHjx1EjJ9oWrRySvFr8Ourp85xoDYwOeipfQ3saQb31telXcCpzu2uExU/ycSPE42cboDjT3dIp/425q0Q1gdbbI49pG20DIZQydoaBUNwD5Iv2FpxR6E9wBaryNbYcjaoiywmG2tAGs9M5z1QMFtj3eyoBQElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TRLtM00Pj/aucppfn7qH4fvZUWzwM37RRlC8UlOfCI=;
 b=Zcofx6oXZj2fgn6mV54sGH3lyg7/W7GrPKmYgzXs/tqK+4JyRNh8mKrGkbiGOBbRCCliqItOFqwPYgrGgQ8dD0mR10dY66Hg/rBfH2WaPg4Tvc/BKBzfHE3MX7K6KswvPuiQ2fTi40Gaivh07Yer2yw0V32KYqj3iACLQGB8w44=
Received: from BYAPR02CA0045.namprd02.prod.outlook.com (2603:10b6:a03:54::22)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 10:59:15 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::f8) by BYAPR02CA0045.outlook.office365.com
 (2603:10b6:a03:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 10:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 10:59:15 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 05:58:36 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH 7/9] spi: spi_amd: Enhance SPI-MEM support functions
Date: Wed, 18 Sep 2024 16:20:35 +0530
Message-ID: <20240918105037.406003-8-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918105037.406003-1-Raju.Rangoju@amd.com>
References: <20240918105037.406003-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ee72b4-71f7-4594-194f-08dcd7d0ef91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/oQDP3Q9VB/hjZGrh3mHPOWk3qfBpnuh6dcuvkvAwHmBrAyt9mK5RkyvMHXE?=
 =?us-ascii?Q?TWQYC0puci3o9IZyUD3OGx/8vGxxuWaM/H355402BEds8QZsO54JUfvifWci?=
 =?us-ascii?Q?Z03s6YtnUnjq/8jK8qWZCgx1PAzzuX3205tylCq4+o1DicXh8q8UxYSIb1Kl?=
 =?us-ascii?Q?gsLXBrbltfpcGuaizvS4CKNSwTr/OYz2Cl8j0HmP30h4lwFRLEivgQaVst+D?=
 =?us-ascii?Q?j5J0qRj3TWUbOBAnfs53MWqQVjdA/cHV0RQ9TdDDVVH0V40jfi6VbPFFHsNX?=
 =?us-ascii?Q?Ez3gXwsZ0gWZn05W2o/OB3+72sM8SG2hJ0u1xQKY5XUtBGyY8yhZBPkuo4AE?=
 =?us-ascii?Q?pT71z2xn3GLNM9O6aXHQw0dxGlRlwiPr0VNh8csKnn3js3PF9B1wisosgzxa?=
 =?us-ascii?Q?0vuI87LjFmEWsBuFg5RawDqU/WNht+XKzj3FOBIvS91zZsuH8H9geQba1klj?=
 =?us-ascii?Q?nRqzbWwqoSoBGbkctjhqiz80cuJcQQEbYIs4k0CVyd9mPyqE6W+Wh8Hl6xDu?=
 =?us-ascii?Q?6taP9f8xUqwkSja1GvgTqqNRgi29Kzayt392Zlzwz3UfcR+cHCNn7cOwqnvH?=
 =?us-ascii?Q?k6IpYB1zWZqQZLrGF7fC0MA7lycRWlVqpkVrNErleVpUlBnca+3o3y+ZJagk?=
 =?us-ascii?Q?XWVHwJqHE2434unFEe2xOg3peU8CNrGnyWzl/7ektttwMbZu2IgeUcM1w6e4?=
 =?us-ascii?Q?gKXKOr6UF6GI6eHjZ2Oo4tJfK4ukhQQn43loTBauwGGDNP81uIY0LhWoaxj7?=
 =?us-ascii?Q?1oLbZoP3uRm4IuLYLu9GPSTeT+yjmJsP00FFF5a5A99aeDPMmKHL3Xi4mJcf?=
 =?us-ascii?Q?IzFHzPU8w3vGH8HXqWALp1bZ5pW4bWWrbwoW/nrZWppIFbe52VrnNmf+19cZ?=
 =?us-ascii?Q?oxPsJldk/Y7L9ZYr0pbvhasC8J+s6568ig5v2clq3m7gt4PMHk7gC6Mh9ylp?=
 =?us-ascii?Q?qRpBDlZKneQAqObIPyiaUK62RvxiFsWidOsv0ant4Iq0atigCUgHgFktyOJt?=
 =?us-ascii?Q?ubsucJt9xw0aP9bPqyaE2px2PI4K3ajV6w2bqWBctxovLUTEjxDJgB4N98Kp?=
 =?us-ascii?Q?aG8yTB6hvQvnsQombxiWzjPeGu+il++vwFLT4CibGMqGuDDRRNBp7QifircN?=
 =?us-ascii?Q?h67ULQ971vbdl+uH21so2OMjfpN9znprCpAKS3c775TCpYaj9n7UNQDDtAwq?=
 =?us-ascii?Q?3CHJYVWL8XrGOms0umLP5dCsxZI6ai+AE7PpdH293QH0SnnIf6tBCwOKwERK?=
 =?us-ascii?Q?8RYbpkoEIha+D5/MUKxbiTvJjoBpClqG+RJVX8Y7w0MXxIx/W5Ffg+zPuQHI?=
 =?us-ascii?Q?fYKHnc2ec9N0/F0g7IwfNGCYr9e0p7WbR85+isNL0+3OIVB5WPPA8nmZiyvw?=
 =?us-ascii?Q?8+0FT0w52olAb4qhL1/gezhLZS0NUtpYc+6WRpbsUC5+UtjXBzs8wr8NXMsF?=
 =?us-ascii?Q?HOm5GajgVXZppqFY2XNbT8kcpGvDF1uP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 10:59:15.0482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ee72b4-71f7-4594-194f-08dcd7d0ef91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752

AMD SPI0 controller supports quad mode only for read operations and has
limited support for quad mode writes. And, the AMD HID2 SPI controller
supports DMA read, allowing for up to 4 KB of data to be read in single
transaction. Update the SPI-MEM support functions to reflect these hardware
capabilities.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 84 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index ccad969f501f..f146366a67e7 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -38,6 +38,7 @@
 #define AMD_SPI_FIFO_SIZE	70
 #define AMD_SPI_MEM_SIZE	200
 #define AMD_SPI_MAX_DATA	64
+#define AMD_SPI_HID2_DMA_SIZE   4096
 
 #define AMD_SPI_ENA_REG		0x20
 #define AMD_SPI_ALT_SPD_SHIFT	20
@@ -51,6 +52,21 @@
 #define AMD_SPI_MAX_HZ		100000000
 #define AMD_SPI_MIN_HZ		800000
 
+/* SPI read command opcodes */
+#define AMD_SPI_OP_READ          0x03	/* Read data bytes (low frequency) */
+#define AMD_SPI_OP_READ_FAST     0x0b	/* Read data bytes (high frequency) */
+#define AMD_SPI_OP_READ_1_1_2    0x3b	/* Read data bytes (Dual Output SPI) */
+#define AMD_SPI_OP_READ_1_2_2    0xbb	/* Read data bytes (Dual I/O SPI) */
+#define AMD_SPI_OP_READ_1_1_4    0x6b	/* Read data bytes (Quad Output SPI) */
+#define AMD_SPI_OP_READ_1_4_4    0xeb	/* Read data bytes (Quad I/O SPI) */
+
+/* SPI read command opcodes - 4B address */
+#define AMD_SPI_OP_READ_FAST_4B		0x0c    /* Read data bytes (high frequency) */
+#define AMD_SPI_OP_READ_1_1_2_4B	0x3c    /* Read data bytes (Dual Output SPI) */
+#define AMD_SPI_OP_READ_1_2_2_4B	0xbc    /* Read data bytes (Dual I/O SPI) */
+#define AMD_SPI_OP_READ_1_1_4_4B	0x6c    /* Read data bytes (Quad Output SPI) */
+#define AMD_SPI_OP_READ_1_4_4_4B	0xec    /* Read data bytes (Quad I/O SPI) */
+
 /**
  * enum amd_spi_versions - SPI controller versions
  * @AMD_SPI_V1:		AMDI0061 hardware version
@@ -377,20 +393,82 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 	return message->status;
 }
 
+static inline bool amd_is_spi_read_cmd_4b(const u16 op)
+{
+	switch (op) {
+	case AMD_SPI_OP_READ_FAST_4B:
+	case AMD_SPI_OP_READ_1_1_2_4B:
+	case AMD_SPI_OP_READ_1_2_2_4B:
+	case AMD_SPI_OP_READ_1_1_4_4B:
+	case AMD_SPI_OP_READ_1_4_4_4B:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool amd_is_spi_read_cmd(const u16 op)
+{
+	switch (op) {
+	case AMD_SPI_OP_READ:
+	case AMD_SPI_OP_READ_FAST:
+	case AMD_SPI_OP_READ_1_1_2:
+	case AMD_SPI_OP_READ_1_2_2:
+	case AMD_SPI_OP_READ_1_1_4:
+	case AMD_SPI_OP_READ_1_4_4:
+		return true;
+	default:
+		return amd_is_spi_read_cmd_4b(op);
+	}
+}
+
 static bool amd_spi_supports_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
+	struct amd_spi *amd_spi = spi_controller_get_devdata(mem->spi->controller);
+
 	/* bus width is number of IO lines used to transmit */
-	if (op->cmd.buswidth > 1 || op->addr.buswidth > 4 ||
-	    op->data.buswidth > 4 || op->data.nbytes > AMD_SPI_MAX_DATA)
+	if (op->cmd.buswidth > 1 || op->addr.buswidth > 4)
+		return false;
+
+	/* AMD SPI controllers support quad mode only for read operations */
+	if (amd_is_spi_read_cmd(op->cmd.opcode)) {
+		if (op->data.buswidth > 4)
+			return false;
+
+		/*
+		 * HID2 SPI controller supports DMA read up to 4K bytes and
+		 * doesn't support 4-byte address commands.
+		 */
+		if (amd_spi->version == AMD_HID2_SPI) {
+			if (amd_is_spi_read_cmd_4b(op->cmd.opcode) ||
+			    op->data.nbytes > AMD_SPI_HID2_DMA_SIZE)
+				return false;
+		} else if (op->data.nbytes > AMD_SPI_MAX_DATA) {
+			return false;
+		}
+	} else if (op->data.buswidth > 1 || op->data.nbytes > AMD_SPI_MAX_DATA) {
 		return false;
+	}
 
 	return spi_mem_default_supports_op(mem, op);
 }
 
 static int amd_spi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
-	op->data.nbytes = clamp_val(op->data.nbytes, 0, AMD_SPI_MAX_DATA);
+	struct amd_spi *amd_spi = spi_controller_get_devdata(mem->spi->controller);
+
+	/*
+	 * HID2 SPI controller DMA read mode supports reading up to 4k
+	 * bytes in single transaction, where as SPI0 and HID2 SPI
+	 * controller index mode supports maximum of 64 bytes in a single
+	 * transaction.
+	 */
+	if (amd_spi->version == AMD_HID2_SPI && amd_is_spi_read_cmd(op->cmd.opcode))
+		op->data.nbytes = clamp_val(op->data.nbytes, 0, AMD_SPI_HID2_DMA_SIZE);
+	else
+		op->data.nbytes = clamp_val(op->data.nbytes, 0, AMD_SPI_MAX_DATA);
+
 	return 0;
 }
 
-- 
2.34.1


