Return-Path: <linux-spi+bounces-11054-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A072C36A99
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2B462381E
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28BD335BA8;
	Wed,  5 Nov 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JpcM+96l"
X-Original-To: linux-spi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00C3358DD;
	Wed,  5 Nov 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359125; cv=fail; b=VTUmsb85jsjaMZH8ye2dh4dmK1yOfy/ypbPY9XfT1f7dC3dOXDxnWJMWLRj15otVO+Tx72z5DVCb5MOfCMBBYF7S0Nnvxob5VxYn00wEiYqAl2P0dYuo2k5kPG1WuwIaxIqpTmjfpaIA2wkvdWZzRfoFh7082r8UTcATt4p+RSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359125; c=relaxed/simple;
	bh=dkzvOvJSZpOTlvty3ez/VFlselT/O4tNuvUY2HhLurI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuQfUQafmrNUzkIAHmc1JsqsFVACjPRFNZdu7KCAEUKzlFIPTONXNBoSuTRS6PeCsj4kRRk29I+wMSrjeNXpcp7rFuiG3yCs9F48lhyLPD6SbKwbG3FuNeV6oXe1t7xVLqLxz7e5KarQHmlFaMjzPvBB8ZzDqTk+7pT5kovuj6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JpcM+96l; arc=fail smtp.client-ip=40.93.196.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxIuiD15nYDHVtSWK/i/OUB5N1N5O38Bfn72+qvnyhBg8coUuIjKV0GPA56/v8R68nE17MfrpIYhxHNiXeWq7W80X78hD6s2DGjZb+Bd9e9iyhbdWiADOyojwu8CtKY5u+Y4xVzfzUbtUGTf3TGrcmK+gAX4nO3O05OapiJniOuKJbpklOwNK2ZNMMwzA5Qy6DhJ+dGashQw2jYB/1KI0m5Ih8eS5ukYTXroCJx/WQq1eHBWSN1wLGYH7A7jw6B9H2MLjAAWTUN4ITY4Ov3xV57K0fwtoDvfveb/+V3u4Nz+AS7BiHTIO0teeqb+esNi8CC6oxnP8tyAAky467n9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BugEoN9EnAGF7T/ELo2fqx8xkWwZcdfecHMz4W5SCDM=;
 b=hOaSMH4PnMtLYLzzJvgj6UXZEgVgIJ1fD1npLwotn98m5qF+9G3iNTlHp9O/MvmnSipdoPeHaAYLApEVc1XhUzur6zzUQAJatc8BKXg9pvD9cZA0qSrsiLiUU3v7st2FZvP4Q5CkBAWF9kpy7YUAJuv7YGJhUVDzRCNFFK++pALrHpFaZEiuFtdT5DA/6Z5mcn+s2m2a6RejfYi358eL+7Yd+CtTF7ugIGxeXl3F5M3ftrye5+40XHTZq9vB41Bn/bUO+E+d+vXNZD0cX9sfRRLf85gmVxlwe3+u9N10jvJ3aERSMW0I3OKOxNst/zoGIEj1ybsRB04C/Hg7c8XyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BugEoN9EnAGF7T/ELo2fqx8xkWwZcdfecHMz4W5SCDM=;
 b=JpcM+96lSlZj9sbIwOBt/u6jos07V26u34+IBdmkf33yzeKCEQpZjBfBYV6RBBy/kzXFKIcw/31G6s3Ru5chZKdVPdCCM5d3OJ5H69dWgbAZXawf0Y90I4G79QFKGZ0OMkdojALftHeUQ06fbluMHdPbWVQfPQ6bYaU2GsIGwQ0=
Received: from PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::28)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 16:11:59 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:d3:cafe::57) by PH0P220CA0014.outlook.office365.com
 (2603:10b6:510:d3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Wed,
 5 Nov 2025 16:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Wed, 5 Nov 2025 16:11:57 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:11:53 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:11:52 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 10:11:52 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5GBldL3979508;
	Wed, 5 Nov 2025 10:11:50 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <broonie@kernel.org>, <khairul.anuar.romli@altera.com>, <vigneshr@ti.com>
CC: <u-kumar1@ti.com>, <s-k6@ti.com>, <linux-spi@vger.kernel.org>,
	<gehariprasath@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] spi: spi-cadence-quadspi: Enable pm runtime earlier to avoid imbalance
Date: Wed, 5 Nov 2025 21:41:45 +0530
Message-ID: <20251105161146.2019090-2-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105161146.2019090-1-a-dutta@ti.com>
References: <20251105161146.2019090-1-a-dutta@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: c12b5873-aa2e-412f-6645-08de1c860bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|34020700016|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?07lr93TeCkycfUHs6rdTAk39mTukSIplzsU/Y0ym9A5iL6A/HP5yaTEpFqqX?=
 =?us-ascii?Q?Zn9dYnO78opWwUqnmF+2anu4IHZvfRevVA1kl8OcHBjx5fsTD1VrXQpJQg4Y?=
 =?us-ascii?Q?pWqUBRq81NwYK+HshenrnjcG378x59p/REH16JifmNutYYZDDDHg8AtFZSym?=
 =?us-ascii?Q?Ghj0Hlv8yXsc7Mh6MQ28FBgxzUVMWswTqEqchNHlL4UqXURIjRqo+9wqEx/Y?=
 =?us-ascii?Q?nXKksNWpiT78rvzn6JChJeoXW/Fzi/MxkX4XmMyr9yXNkRpMab7retneWA5L?=
 =?us-ascii?Q?kI43FNlQFDAOvinXybxRAtSWvpxyrDarJIdQaQyIbl0LnNcWBJ7UWXZPwmXu?=
 =?us-ascii?Q?5MThNQKfQFkYYPow5a1GTU5DmbkhRKoLnN9IBp5rw7CTmxosXr1HC3sAr82/?=
 =?us-ascii?Q?5N/2Ngof5OfGAKddX2aTkfGfhgRvsfNMxCnmJtm1tVvcwAy4ATbBUVxFQ66a?=
 =?us-ascii?Q?u4O7GWiLmSdjkS+e2GKJFVnPUMTDlAWPt3wVGusFzBv0/0QIm/DAbIDMP4oE?=
 =?us-ascii?Q?jOy6grA6ZGy2IayQiTtdXNeIU846d479Y2jWCavz30G7XYgWsvSBqMZuobhF?=
 =?us-ascii?Q?QienQbxTFmwUcqM43fyyU0040yDK+TKWMsjXtm/R7HzOHDODTbXQxp/fnLPK?=
 =?us-ascii?Q?fsdvJj+lrv7OxmTTo54v6suwyRYxmznp2itaODWJjnBn8dWs1EsvSdV4Arft?=
 =?us-ascii?Q?Z2DRtuHi/MIOdRjcliPN8T2gXoDHGYPzZb3uAmQRsTjYzKMlxlaH/6bi8pRU?=
 =?us-ascii?Q?ZXkYBZ6bQYmXfwb+o07MBGcpVRXV4gNO1V0UVv6txGsyw/o75rP+HniiRAZp?=
 =?us-ascii?Q?ZJv6nbySY2a1ZN0+8TWJsLSg4uFPN4XEBpOvcaW+EAUY1901XVm2uJnNjM6n?=
 =?us-ascii?Q?4LvjDeVObQX7VUmceDn4wI1xRmKUyoNSbt3fnCbp10yOf8l1kfc0o+Osv7/M?=
 =?us-ascii?Q?a+ARY5HA+/5HML2nQW9+xFg372sbAwNLieyK2+AgvoS8X8HIcqBl5SljgxtS?=
 =?us-ascii?Q?a9z3og55obO/6DHFotKzgOmgUHuC1EDDx6DNneWCT6MFG8C6kEd1N2TMVMh6?=
 =?us-ascii?Q?jtsfPeGejfEnO3dbErk0i9F2r426lbSPzC6fG/Z13QoxjViMSR+LOjR49PRW?=
 =?us-ascii?Q?VVlMSNNCHamvhzsLQPj0t4xzZjeHybP7AVxzWdwad73ZwTbBp5T/BrFEbvdr?=
 =?us-ascii?Q?JYtAH9bUVZrnJKJvzMwk0/faJNJ8TH7wa6rs3CNh+tOoJeZq+dpBwbsqzwrl?=
 =?us-ascii?Q?WQkkcwu11B2mnO6wLQTr286CA6Gt1qIOe5C6klQoLrsVjyZvmQteJX7W5WfQ?=
 =?us-ascii?Q?74qeNGHtdGKBYYIXcxuOTx0IelIOUjqL5eKs7ul8FMiBb+Vf0tzJa+RReEgH?=
 =?us-ascii?Q?jTqRwmgpSJl6V2sxMyqbMkMpI+iwAnwrGxl/eu2IIoOpaUzFpu20guDRbzRX?=
 =?us-ascii?Q?ewZpSBTucL5jOLO7oRhg7GhSLoywKDGODnizkDHYD9UHASbdvEqXAFchMBl4?=
 =?us-ascii?Q?iLmP2Y0gp4DP29K9eNNfmpJ1PqFUZAm1EdoEsXoGCe4tqZQo33Fq6uSc9ck1?=
 =?us-ascii?Q?wA31HvvJpP7mUQOv7OM=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(34020700016)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:11:57.9025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c12b5873-aa2e-412f-6645-08de1c860bad
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663

The "probe_setup_failed" label calls pm_runtime_disable(), but
pm_runtime_enable() was placed after a possible jump to this label.
When cqspi_setup_flash() fails, control jumps to the label without
pm_runtime_enable() being called, leading to unbalanced PM runtime
reference counting.

Move pm_runtime_enable() and associated calls above the first
possible branch to "probe_setup_failed" to ensure balanced
enable/disable calls across all error paths.

Fixes: 30dbc1c8d50f ("spi: cadence-qspi: defer runtime support on socfpga if reset bit is enabled")
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 81017402bc56..56906dc76b34 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1981,6 +1981,13 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_enable(dev);
+		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_get_noresume(dev);
+	}
+
 	ret = cqspi_setup_flash(cqspi);
 	if (ret) {
 		dev_err(dev, "failed to setup flash parameters %d\n", ret);
@@ -1998,13 +2005,6 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_dma_failed;
 	}
 
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_enable(dev);
-		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
-		pm_runtime_use_autosuspend(dev);
-		pm_runtime_get_noresume(dev);
-	}
-
 	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
-- 
2.34.1


