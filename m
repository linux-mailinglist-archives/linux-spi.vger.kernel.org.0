Return-Path: <linux-spi+bounces-12346-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E8BD1966D
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 077F13034055
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BBE29AB02;
	Tue, 13 Jan 2026 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Uk+v4lTd"
X-Original-To: linux-spi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8C29617D;
	Tue, 13 Jan 2026 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313887; cv=fail; b=FLM/4ai59x+PWtgC0YsQ7D+TapODMcUkgOxqOmxpBuBQwoOhGunF7CTxcxdw3vtAVCvy+EtrNUU4tATcppCwCdt9VXzqDYKyBSl49IKttNsQqfYmFZYVPlN/KH49d2bBrogn+HhgpznzrCRjomvIz963881Wko9mT7boO/ZwyCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313887; c=relaxed/simple;
	bh=1BgTbITff5QPiFyTUgFQ1tF9q6jBp1MtsvftGp8aKW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Exiu/JBHQUgNNK5PzJrZyN2UFnyr/NXzIytUh2JcONRNolcHPKPozLFMfiIxxjBZD5pfb2nOejEA5jZt1ygmtYJ2F+VlN8F4RyEF4/ZmcbxOFSW/vVaK8YtK5z0O5MaBV3N7xS395ESUKcoWXrgGgQE4SEosPBu9/64c1GjWcYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Uk+v4lTd; arc=fail smtp.client-ip=40.93.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjYtZRUk6kIu0oo6nlTT4SEsFMaAzqXDCYiU25rYlZjNKX7uUYO8EMy/UnOwSV31SSIoGPqxgks7b3d9pa7RKo7qcCL+5wSyC2p+IK6jTz6oNMXz1pgeJ/bKCPRwnuOge56YRHaFHFQncHx5fTiCJp07HTCJTfn45+bbOctvoytOZv1AI8O020GsBmNZL7jBMo55vbyIxQemhT2SeSYBBiQ6WlWzp6klj3zp8xBQyXhy9Vc969b6BR5Stlt694YZOqGHRNcfGaOTT3pCHVxa2Ar8tUpo58Kr6DxVPqet2Z5NaENEGytBZ+J5211fE7UPyUMtTKazA0tZ/G/9hHjjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS0mjrn2OOVRL+WcpSy+0qmh14kWHKv5ZaKQfzCyUXE=;
 b=Y8tZn5NsfI62ird8eDzZylmXH4NqwiRoTgUEWyOGzoWTKAWONZqqRTMfGvJvGVxavNpafV0K6OVmwvVESRDJPr3xZJMo93bKrAt1x166fyC5pHrfFA2nRLKMGwKgRtk6C9GhbSO0LFJz1lPRx3SPZ3otHW9a+DDWY/LOooLCUNNufa2Mwp3fT4SLpoOZTRsr1OtBOge5Myqq3Rb5F9LGQ7ioYP3iMDD1d00IRZjd0EGkz/VGpiq+QpRU4EPyb8ClNmSXNSK/Wu/OcsIuTuF+G1XqelZzdjHxl7CVWHyhFwf/uNKA/GDPNDZwjcfxL8Q2PabILVgt3anS3jzNuMiqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS0mjrn2OOVRL+WcpSy+0qmh14kWHKv5ZaKQfzCyUXE=;
 b=Uk+v4lTdinyPB1Bgz9Wv18/Q/B+N9KGmsXHEsvWPKVPxZj3tYTkPMzI64ZR1hYCGDX0aKGNQltE8FCXdjouT1s7aqusT5nBsvjfembfd/beXIgLZZ/BTTnP98BqrdoSkg8tFzeF9TQZyTMM5wwyEUcv8ghPnDkzC+0RFhmL6sHI=
Received: from CH0PR03CA0246.namprd03.prod.outlook.com (2603:10b6:610:e5::11)
 by MW4PR10MB5726.namprd10.prod.outlook.com (2603:10b6:303:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:18:01 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::50) by CH0PR03CA0246.outlook.office365.com
 (2603:10b6:610:e5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 14:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 14:18:00 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:17:30 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:17:30 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 08:17:30 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DEGLou2381510;
	Tue, 13 Jan 2026 08:17:25 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<mwalle@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
Subject: [RFC PATCH v2 11/12] spi: cadence-quadspi: restrict PHY frequency to tuned operations
Date: Tue, 13 Jan 2026 19:46:16 +0530
Message-ID: <20260113141617.1905039-12-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113141617.1905039-1-s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MW4PR10MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 6743ed80-9efe-4ed3-79d4-08de52ae8e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ypDGPMcPZX4j3g7wZi66wk3IMsFrz+NINTmtNsKIlGHIhgyJt+ZqsSEeHbJS?=
 =?us-ascii?Q?t1HuSfcoT0m/mNo8INMPrxltwJdA21kO4gwGbAfMA2RlQgxvnkx9UnQKOs54?=
 =?us-ascii?Q?y9TzIinE/tM8AwVyaN+Fl7xtyN5xx1xJRjG+z7HOfAT2Wwq7bXWCZQkLcFQE?=
 =?us-ascii?Q?zdCBmdGjdw5gd3K0pWBBH0sZOja8zlY+/PzRf92GtYjGKNkMk1zw2fCYfffP?=
 =?us-ascii?Q?2aCrQnQHJA8zRC5zTQke6/L+X6+hAfAYCeZPbWEfCr9f+BPm7j0oncbK8jVW?=
 =?us-ascii?Q?LZXPjI4jsR/i7Z4qxOmuS+GXtAfKTKY6WlJg2HI4ZRn9iD6oF3jI5i/ZQ9Sq?=
 =?us-ascii?Q?bKR2X8XD1QcfwXY+NLGJoZs3t1kJdkTw5KMO3LPvCHNZu5KveiqllX9dN3PL?=
 =?us-ascii?Q?LtJ93fL6vlF5o/uGUYg4SeWzQcsRZM+ZYVTMCnmfJH4eJPQYQezAp35j3u9O?=
 =?us-ascii?Q?hkkSbibYpt21y5hd/XULaa56NitUP3dNJmDqEvMB0fbuVITBboS5Hqup5sF7?=
 =?us-ascii?Q?c+OIA0vP+k2sIPBmtkLxGU6HAj1++qOZd+kUQIKuBQ411MtPdI43VDHlhd6V?=
 =?us-ascii?Q?o7TDBXh1hZpqGPNWyVa5JoDRByG/gMHXyTItnXW2RxPRcfdXeVtM+SpWS4c/?=
 =?us-ascii?Q?ZU0fZwQTm/otY6lc/XiSvAZRXW+wEjdSsyvCk+mbfWLZL7nktRwyeWyRRemp?=
 =?us-ascii?Q?DqALIQBuCS2UHg56KhJodOvhzz6V7qw7EvFDHeYft+zL89KzCZnk8QjE6iyE?=
 =?us-ascii?Q?/VktyGwNnh+gXz4lJGyKK6f4uxVKmzd3UmCX3Kmsp38I13pTylwQsMe2MXkQ?=
 =?us-ascii?Q?FjplANbe4AjfgBT+tj7rP3udsUGgXLU+bO1xWffXOwagzs9QCxgTlj2OiTJh?=
 =?us-ascii?Q?mB0SaaQngF2xbeQlLU8mi8crd9hZvLX5Ad1qlzyzhRVS/vAFez5WdxjbzInW?=
 =?us-ascii?Q?jdDK3m7VXsHzTodChNnpBpiykoRmNXI5egIkh4qXpytDSZjPDadxBDm1MeDW?=
 =?us-ascii?Q?JdO6WqxQ7938JvCwXAFmdz6/FvEtqPY+VYWEFl8o9gLWVhCrpOgIDjd2PUN0?=
 =?us-ascii?Q?Jx93WlIMZGLGBH5VHPvmiUiq2tr13VsJSAwHWLmLLjUTXyP/ry1DVY5zGB4S?=
 =?us-ascii?Q?booQWfx1bqZhIFwbuyrijCywJqx/offZI/7aqczDWvRYQvjnYLNyIk1fHVoZ?=
 =?us-ascii?Q?c/+4yHrt6/tltgdCO+XqvjHB40Zv17g9E+39jf6eKcax9CQwXuERH0yXblw1?=
 =?us-ascii?Q?FZMUAKzDTsst9ogA7lKF3bL2uEo6c5mFS4Uv3wWUJChKIP9vyz9uxqGT4e3q?=
 =?us-ascii?Q?L7R+iUY/7jK/2f8DXqemoPTWZypAxnbRErNy6KldG2Sr7qWd0PQ4bukXihlX?=
 =?us-ascii?Q?Pu/e3dHTweKkkDrD8lrfIGR+rDO5hqEIyauAQlnFb/zlg7My9/9vZBmHO7pt?=
 =?us-ascii?Q?8RVg1IAx3HVgwOfdtDMs9a361IM4Fu8EIBnDroNc8+TwAxpAi3tUF8Ds+kL7?=
 =?us-ascii?Q?+MWyFny2jB/CB9iDH4SfVS22vPoHDmzB2ut5PTb2+wgkdqOd8dbQJyIVvlHM?=
 =?us-ascii?Q?P7e78J+GpR4A/gMdN0EOHmD0eUZxAvjoZZQ//PBb?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(34020700016)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:18:00.0618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6743ed80-9efe-4ed3-79d4-08de52ae8e7f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5726

PHY tuning calibrates timing delays for specific read and write commands
at high frequency. Using this frequency for uncalibrated operations
causes timing violations.

Apply PHY frequency only to operations that were tuned. All other
operations use the lower non-PHY frequency.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 33 ++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 930ea094f6d8..3669936ae4e1 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1532,13 +1532,44 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 	return cqspi_indirect_read_execute(f_pdata, buf, from, len);
 }
 
+/*
+ * Check if operation exactly matches the tuned operations.
+ */
+static bool cqspi_op_matches_tuned(const struct spi_mem_op *op,
+				   const struct spi_mem_op *tuned_op)
+{
+	return op->cmd.opcode == tuned_op->cmd.opcode &&
+	       op->cmd.buswidth == tuned_op->cmd.buswidth &&
+	       op->cmd.dtr == tuned_op->cmd.dtr &&
+	       op->addr.buswidth == tuned_op->addr.buswidth &&
+	       op->addr.dtr == tuned_op->addr.dtr &&
+	       op->data.buswidth == tuned_op->data.buswidth &&
+	       op->data.dtr == tuned_op->data.dtr;
+}
+
 static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct cqspi_flash_pdata *f_pdata;
 
 	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
-	cqspi_configure(f_pdata, op->max_freq);
+
+	/*
+	 * PHY tuning allows high-frequency operation only for calibrated
+	 * commands. Uncalibrated operations use safe non-PHY frequency to
+	 * avoid timing violations.
+	 */
+	if (cqspi->ddata->execute_tuning && f_pdata->use_phy &&
+	    (cqspi_op_matches_tuned(op, &f_pdata->phy_read_op) ||
+	     cqspi_op_matches_tuned(op, &f_pdata->phy_write_op))) {
+		cqspi_configure(f_pdata, op->max_freq);
+	} else if (cqspi->ddata->execute_tuning) {
+		/* Use safe frequency for untuned operations */
+		cqspi_configure(f_pdata, f_pdata->non_phy_clk_rate);
+	} else {
+		/* No tuning support, always use requested frequency */
+		cqspi_configure(f_pdata, op->max_freq);
+	}
 
 	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
 	/*
-- 
2.34.1


