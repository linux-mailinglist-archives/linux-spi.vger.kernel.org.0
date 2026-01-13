Return-Path: <linux-spi+bounces-12340-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B04B7D196A6
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBB0230731E5
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F79F2857CF;
	Tue, 13 Jan 2026 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mQH6LG5m"
X-Original-To: linux-spi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2A285CA2;
	Tue, 13 Jan 2026 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313832; cv=fail; b=oCl/2yA+58cGNh58aj/sJkvZDIgiVJjk83RW7/xdDpaDGRdFXXA4T3JhUyaufyUYQxI0Or0Mu2+6H8GMxI8DMSSSQnn5RqUofKic7TY926kI+RevEbcwCpcBPQwKpfYwenlb63nJ1W3pCO0vLHagXyUdhINRznxiYxKK/dvJU64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313832; c=relaxed/simple;
	bh=F81Rb6C3qbO5eTQloegzK0Xl/oNLTsSxACJttlYumdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzHps8tMyYKvPM3LQyThS06Ef70NJ8wjJ2y/Ekm+zFFvaVGGud8ae+EfswkU5xOz0VHOUvwvy7K4n59hbE40PwDVauw/dNIsUVairR5x69nwpvTykhpWulw+AKVA4qM92NdG7gf5gBGJcBBJcVu8BVl4DLvUQ2tl4m0ovs8EDMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mQH6LG5m; arc=fail smtp.client-ip=52.101.61.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZY8jH8WOyL/WCjEQQSNq6H9c+1gfr9Act6/l8gNt8R/Tws8k6AUxjQzojrc0qhcTpkBeWFtZh4c6+zTk/2inW0/77BGZQrzXAHCQxW1TAQfICcjjHdshDfXye+G7zMVHnv9ljtMsNNqzZGANXT7RqqAlesYmi5CwNJtrRK9qsXF7MFvlvE/MfFBwZMwmEuJ553RUN4OXQx/ZoxzTYnWqXWx/QISl8rTyyD0N3+pS2TJnE8eU0tOLTwJbtX8e51BoALFJAA8XUVGnRND2IQXGUGi7CrsPsJk1STB7oI92cMV+rKUk4dU34fpEe4Ecc73NhlyjQTy5m78tjmc3P4yJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2acWLlu87ySSXIBKW/wrkZxxySXNhsisYW1Tu3aF2Q=;
 b=JFIqKo+K5ag/IGvSpGs4g1hYzijMWugZSoKPcXHjI28lOph4O4ozMtt2lnNpcghOnzXz/RCoVVtt/5/h2Dtvaznd+K5isU53QF+AxXC+MAaHEjs/COrcA3U4gRgnI54AOpzQit4OFZjZv8HrQr45LP4Je13jXpOOC+HnAivLC1ebqnpn6BoM8ufqu0zdQDqTNKsWw4jmh/psHMjOAHnPOu2nUsp8KmQhe+T1UmAMTzOW7iIGlGyAQ1FIroUMWgnTvF39KS+K1+RVjtYNczznBYytqhtmBhEpkJ2YD92wJqOebsD2/O7avX7itK74hFOeX6HTPGnKkEk2hcpStAsvcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2acWLlu87ySSXIBKW/wrkZxxySXNhsisYW1Tu3aF2Q=;
 b=mQH6LG5mSiLUbqHvLdbKlIofI+ifcYZjB2Ykw/mmXlcvf1Fqk8iXkx/koM5y6eREL6ueSf0mvdv1mzvqscwboI16+Z5SNM/vDsbWRp6gAmrFwpb1KiuEiMtlJL320+wlDr5rtm8ZiXj02x96DaSGXMliOx0CNE+QZQ1zezxWx4E=
Received: from BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::26)
 by SA1PR10MB7554.namprd10.prod.outlook.com (2603:10b6:806:379::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:17:06 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::9e) by BLAP220CA0021.outlook.office365.com
 (2603:10b6:208:32c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 14:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 14:17:04 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:16:39 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:16:39 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 08:16:39 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DEGLol2381510;
	Tue, 13 Jan 2026 08:16:34 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<mwalle@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
Subject: [RFC PATCH v2 02/12] spi: spi-mem: add controller tuning support
Date: Tue, 13 Jan 2026 19:46:07 +0530
Message-ID: <20260113141617.1905039-3-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SA1PR10MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 903920bd-4942-4b1c-b48d-08de52ae6d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|34020700016|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HTahlPmI4Q9F4z3MroMEBN1izpCQOCUyhVkpTVo8eYypo0x2BhanZqY5bpAm?=
 =?us-ascii?Q?33Bjq9S1u3exu1JzAGwaqwy4IOB88W+CpfZqU5nPcH4iFpZjTiUysA5vTPBE?=
 =?us-ascii?Q?AKdx5hETkyejqCs2//xRcO6IvYOOqC7tXwdsG5lxzAjUsfcWQq40NXybaJ5F?=
 =?us-ascii?Q?gYpztPBglj/kPwNHlCPaLxJ8ysbMIfNIrYB2XLHFfgG9wDaKFybY8Chb0r8V?=
 =?us-ascii?Q?ly/exYocr1Ba78t8Io3yjUbCIIJZ2b8TkK67WcG711h3M/T11602Pj17Ka5k?=
 =?us-ascii?Q?mzSYNsGS7xqPtqVG03TJfDw8cQSr+clgLe5Iq4+PBt97fPklCsk7c02sQdFG?=
 =?us-ascii?Q?Jo4mAo/HqOV6dpLgM4hIHt3/EuGprokAUgZb0Xm0XHYscpjb9VBWqJJ+8fCD?=
 =?us-ascii?Q?0H/JSuh9qUkBSMFKZCHmOSSA1NQbIJuvkvVdbHWIjxxkom8gV0xgTPnsJr+z?=
 =?us-ascii?Q?HXSx06oxouuwW5GCbsc10TWUBMlzKEmXkoQXjB4aQlYqBtiNv6pPCnR7DeyO?=
 =?us-ascii?Q?EocGCrlWP7jKSKMy2j+TR4GzRUHHSamUwQBr1iBhwZuDe+P8gKTZ30RqQBjh?=
 =?us-ascii?Q?eiirldEMDo6fwsgZ4Iqg5TZKn9EsY9Ufdfqzv8mm68WB7LwCGy5x+kXWWyys?=
 =?us-ascii?Q?uFTMsS55PnHH4gWkzBQlTKaM7ORcWKFHD5LpDxdgtQO+FmlVrjZLYTraPOmS?=
 =?us-ascii?Q?JFOPS73E8fRMdncUDTLs109fVjxaaQPuTZqQv3Xr2F7iHO3BqMnHsMZJdlXG?=
 =?us-ascii?Q?e9aY2h6ANHQ+mOa3fRNtCIO1MLTcWRVsG9whhYt7iJwKuhKYsy70VylaTB4H?=
 =?us-ascii?Q?3ipgG7nCE841QUTvUk4mb0vQoCQgBs9PeH8tR+xptUvXEF3OUTcldeerjcVn?=
 =?us-ascii?Q?y5EITtv0JHGT2EhiKj3/37Pa6v5wMRw0qb4AQqRmQB4ulE2I7b4c0vLP5NRe?=
 =?us-ascii?Q?Lk58hG3AOzpU8EJibWMrWK5Ae2HTo9PGc6is18/Zz+SmqkQZhFjSQE3C8Yqs?=
 =?us-ascii?Q?p67tCaUXJnsiXNlIIhlV2gLE3+7P6rspP5uABSu5V/WhWSYSIFxJZ68wf5IE?=
 =?us-ascii?Q?2xzrO+6nhB8E8d/JEkFlSpvm96aHU04n+MBd1vfcdFD0GwhhXfcbuavaPjKl?=
 =?us-ascii?Q?NzZCpsztP3iC9/3u07OngbdiUOUVyZNRJdknVf0px1PiQVEoFbrO2pL/xyeJ?=
 =?us-ascii?Q?+MACZV232E102EmZzcMGzc2fccTuXyNFHsi0SfCZHlEQMhPNemVK056p12dp?=
 =?us-ascii?Q?wXjUq4tbW4GKhb9/KfWu0pIcxlOdrS0OWLvXPCfq1OztXiiI8OZ7FMQBIuoM?=
 =?us-ascii?Q?4uw6fx0BpPKy/8GYCObuEkD9vUcMFyxq+oCebXkLTS/ss0ap2YYu6/5Mob7n?=
 =?us-ascii?Q?+WOdO/deohdJRzs47NzeBj3EOuhuPOAuc+BxeuKazGS6dLu1UsxpufLb9fbb?=
 =?us-ascii?Q?n2uaLjqu5gM8RBGyOxeKoMOSqp2g9gfilMQjOGXQP5bc0yHegyQ2V/moAXd7?=
 =?us-ascii?Q?hOi4FvxBokWSHZCLW/ZFh7Lna/SmiLYmU3TgdQ5UQadvNnAwoTg233HQAu2G?=
 =?us-ascii?Q?25ba2+wsSGton4/95LzZoOEHCsKcnvBayDddjIRI?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(34020700016)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:17:04.7168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 903920bd-4942-4b1c-b48d-08de52ae6d84
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7554

High-speed SPI memory controllers often require timing calibration
to operate reliably at maximum frequencies. Parameters such as
sampling points and delays need to be tuned based on the specific
hardware configuration and operating conditions.

Add spi_mem_execute_tuning() to allow SPI memory drivers to request
controller-specific tuning. The function takes a mandatory read
operation template and an optional write template, as most tuning
procedures are based on read operations and calls the corresponding
execute_tuning callback to spi_controller_mem_ops to allow controller
drivers to implement their tuning procedures.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c       | 34 ++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h |  5 +++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c8b2add2640e..2d34469323ea 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -633,6 +633,40 @@ u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
 
+/**
+ * spi_mem_execute_tuning() - Execute controller tuning procedure
+ * @mem: the SPI memory device
+ * @read_op: read operation template (mandatory)
+ * @write_op: write operation template (optional, may be NULL)
+ *
+ * Requests the controller to perform tuning to optimize timing parameters
+ * for high-speed operation. Controllers use the provided operation templates
+ * to construct their tuning sequences.
+ *
+ * Return: 0 on success, -EINVAL if @mem or @read_op is NULL,
+ *         -EOPNOTSUPP if controller doesn't support tuning,
+ *         or a controller-specific error code on failure.
+ */
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op)
+{
+	struct spi_controller *ctlr;
+
+	if (!mem || !read_op)
+		return -EINVAL;
+
+	ctlr = mem->spi->controller;
+	if (!ctlr->mem_ops || !ctlr->mem_ops->execute_tuning)
+		return -EOPNOTSUPP;
+
+	spi_mem_adjust_op_freq(mem, read_op);
+	if (write_op)
+		spi_mem_adjust_op_freq(mem, write_op);
+
+	return ctlr->mem_ops->execute_tuning(mem, read_op, write_op);
+}
+EXPORT_SYMBOL_GPL(spi_mem_execute_tuning);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 82390712794c..871e46297517 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -344,6 +344,8 @@ struct spi_controller_mem_ops {
 			   unsigned long initial_delay_us,
 			   unsigned long polling_rate_us,
 			   unsigned long timeout_ms);
+	int (*execute_tuning)(struct spi_mem *mem, struct spi_mem_op *read_op,
+			      struct spi_mem_op *write_op);
 };
 
 /**
@@ -426,6 +428,9 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
 
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op);
+
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
 
-- 
2.34.1


