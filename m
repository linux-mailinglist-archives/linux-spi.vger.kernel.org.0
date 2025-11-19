Return-Path: <linux-spi+bounces-11328-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 363A1C6FAA2
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5062381F49
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4993E32FA36;
	Wed, 19 Nov 2025 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ni952sK5"
X-Original-To: linux-spi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9126C38C;
	Wed, 19 Nov 2025 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565943; cv=fail; b=L/KbfbYC9+JhkLm4iygIlS/LThFSJzSvuhyas8S955RN6RdGaUMQadWwIlUi2Phy7xaualthVUzMqS1Umk69BAhNk28P4PMazay8YDjLpJoB62KnOfotSebniYUo7aY6oOFU654wnVl+l4jSfqrE3Gxr8SpNj22Z8IK4mx8EENM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565943; c=relaxed/simple;
	bh=4qAsWBUSEvBYe7FCJsrxPe26z/wxfeSIuc6E9SdRWDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MecgViX33ZuFz7T/60SiagYioqNVCkWElxx5Wk+8riqpMyGElES7eZ9bMI3Pzgmi1YBdRTSC2rPmrtCML9cwbVMO2iAMN9EmmRWQaTibMxPEEQd2wzhzw0FySfUpMqkkggVHGuAWx2nf2UjFfbgkScdNHsApphvmdaLOcsFBr/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ni952sK5; arc=fail smtp.client-ip=52.101.85.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJnD8UE/t1yifBZ7oo6Vnm8A5eCPqqMcWd3kYmyNhHRcuCTiK1aM2oAtIXK2izXsvbGkwKAXsM9kTe9PDPte+JUEPMSNj/Wf5i0j4XHuTENbH6+MSgQpU1hd+ls+6Y8g4/s0tBKxtvehm4LyMy4asm/r7wAHrvMhMY6jsb/Vt32XGG1+m3FEb62Gxk18jWblXcs3u914y4uaDPsE/SPKOmGzbY1bE0AT8KF9aQH12PZ1GUkxrozj+T0+oMZJX/vsdhLWlJ1degG1z1LZl9Ue0zQCUSLoAM8BRTdv1Nkjnru9UV+sTu7Euk31cf2m9tB/k6fwU6IicjDi1bVRtEB1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Fgck6/hUPoi7JfmlqBJklaLm+vbM6Db3znunr02SnI=;
 b=jHaY+ksIXntqUZ1GQzn0M1yCS+bprleLrPg/mciSxeWyTxOHJHie1kNRQShOA4M07yOPJBBq6kSeGOd6NH+ijeZHZCaaXdoLIF7n6mTiOqwzGS+djDCazH/cZ3Hs0ksS0HvAl9YFt+QECbCZZd9IYrLLzCINH6CvG+zUAB/M2Lx1hU2uoyZW5BEKw0c9ZW0KCE0EaqbFwizTRYBo8+tV4LblhZ5ZZMJC/bTskeUAoDaD0KuZ33QJ9mcvqYArW4+xv670Z0xgm8GUEE5kMeTKWlrAwwvitoD1UjbX8N49Eaqc4FfheCB3+MJpuU5ujUPRo0dACObY4XmE21LgrIigPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Fgck6/hUPoi7JfmlqBJklaLm+vbM6Db3znunr02SnI=;
 b=ni952sK5HFW3twobHXQnZD+GcjtuTvNbnSnWzazWTZlcnM+/AXEjyRIE+ZC5XL7QUjGRSSUOgctQ2jDTYglmKHU39fdRjHWcsvWfyA32KWIxppMyl2+PBkFP/Nh/pnCbHRACD5dzcdcN2NiHBkpJ+1M6AX0NGy/ONClEmUK/wz0=
Received: from DM5PR08CA0036.namprd08.prod.outlook.com (2603:10b6:4:60::25) by
 DM4PR10MB6038.namprd10.prod.outlook.com (2603:10b6:8:8f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 15:25:35 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::b0) by DM5PR08CA0036.outlook.office365.com
 (2603:10b6:4:60::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 15:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 15:25:33 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 09:25:30 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 09:25:30 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 09:25:30 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AJFPRFk2056071;
	Wed, 19 Nov 2025 09:25:28 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <broonie@kernel.org>, <a-dutta@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] spi: cadence-quadspi: Fix cqspi_probe() error handling for runtime pm
Date: Wed, 19 Nov 2025 20:53:53 +0530
Message-ID: <20251119152545.2591651-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DM4PR10MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: df993982-2d06-4b21-e229-08de277fe1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ja/XjTGXMk2En5vx09A1FlEf/yl4WfEeHubBcp1DagTDp2atH0mg7VWHl8oR?=
 =?us-ascii?Q?j6ls2HeoW9SymhrdEk+1L+VDQW3w3aIXuKM2Y/f5fcrSloAugmBn14W7ojkQ?=
 =?us-ascii?Q?qut7QUM7qSYEJD91Nbq3MK3lsvXTuNlwW3o/Vfx9+KpBQvAkVv0/k0qWe8YV?=
 =?us-ascii?Q?zuhmxpzPVZ71uA8GYhBMNfZ8rwaiKKd76bDSumkNNmp+ooLoJ1CTekCGrI+w?=
 =?us-ascii?Q?OoxQn5Zq1810ipaVrsk9UHX1f1cR4oUAJmi7bC9KKaKd5Spi8fs9wTTrTOFK?=
 =?us-ascii?Q?nz8bnlpz3xKj6gTEyXK2tz3BcVLatyzpHGa56Kj3hQz4aRzOM7bWKevqUqRl?=
 =?us-ascii?Q?hrhKHyz13Zu9k/anJ9wbDKVV6JdCYuPXvrNjin+tAY8Ygf87JtkMmvLxnpn4?=
 =?us-ascii?Q?7gXeiqr0/Jxb4ENUQKnsO5+fXmno1XAu1KuUoY/6t3CWdashJC12SATSSH1f?=
 =?us-ascii?Q?fXIohJR9FMVU9uJWA7+2TWE0pQWW7vBR5RzbPI/YKu0RgYuBtfUpIgCVHPX0?=
 =?us-ascii?Q?ftP/fm0sDSiEOQ8CfwmzvekXK4G8WUDyDilYBeQtUZQZmGa8pkV8V28ohy0m?=
 =?us-ascii?Q?oWEePM1rVh84JejIRzmM0tKuQxreKmrm71sQtxkJkoz3HA5xzSC8DngydREH?=
 =?us-ascii?Q?ah3ZAFMkoSAmm2+O+riPXVGNL3NnTBhhCsUNBePYQx8mzZFxkwuMuhaPe93r?=
 =?us-ascii?Q?8ECoH6a+H36cjHfN4v1CzcIfpDiEcIIibDeM/bcm4TWDtaw4t8yW/3stToeF?=
 =?us-ascii?Q?VFMDPsHKzkKAbmT+f/yTKhb58T3Preh3G0i7cyz1enMqod2QShGuiCtmbGJm?=
 =?us-ascii?Q?S6juAaO9n5uPdOvkbCd9ld5S2Z5EeQUz3cnumSKh1DSH22QcN2u+SvQt+sNU?=
 =?us-ascii?Q?ObMzRxZFFcoeqW57kOc5jg6l1OTa32JREyGohv9R0hgLcB0mTXIJwErri3cm?=
 =?us-ascii?Q?XUB5nGk+gg9cUNnWNWHIHuPbacQmvdynrd39ycymMDa9gaEA4n0+hIadp+K6?=
 =?us-ascii?Q?XB7Ol3YINaXmHuHzKXXdsFf10spXRWfWkvUXUcFXJxjiDDNM46wQyVnrLlcn?=
 =?us-ascii?Q?y8T3qLtLPe9beFJ2wjeqfBn57Ay5KWD6f23pwuTV8he6VmLCwd90/GZoThD8?=
 =?us-ascii?Q?xksvHobUlgFWPv5IzwpzFdVhBdRVIXxRGPyf6ZshivgQ8EbzKeegabFaf/ge?=
 =?us-ascii?Q?tKJFXARL9pc4ldQ4odQIyvv3geCPoMtefRXT25kuW4rwqF7IfQV48VPGL43E?=
 =?us-ascii?Q?LvGNziiR77RgnzgHdcP1/+JDDXPfI6V4cvp/4IZ+FedvsCgdgxBiw8iQpfxa?=
 =?us-ascii?Q?DjmlEPLbvoejiiN4TSpc5Tcv1l1e4ueUEoWLhnIIWbjp2jQb/zRx0A3Hz3cT?=
 =?us-ascii?Q?Vlfb91pup103sZwlZIxGQoO8yWcdpgVbWrZIhCOVXG/A4Ato+AcsQlai5l+D?=
 =?us-ascii?Q?uOWPI/Oj1PhmrHj12L1gphIFWj7PPrTV47vMV2vLx6VhZYZ+tIRO905uKeXZ?=
 =?us-ascii?Q?BGFqvAVDeU8chzgZ42BF3pYrd9B4PZaqPb1giWt0I1q5YPYfDMJ2wQPHECEf?=
 =?us-ascii?Q?W+sNKH6VRN2Txta3rrE=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:25:33.5841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df993982-2d06-4b21-e229-08de277fe1d7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6038

Commit f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier
to avoid imbalance") relocated code but missed updating the error handling
path associated with it.

Prior to the relocation, runtime pm was enabled after the code-block
associated with 'cqspi_request_mmap_dma()', due to which, the error
handling for the same didn't require invoking 'pm_runtime_disable()'.

Post refactoring, runtime pm has been enabled before the code-block and
when an error is encountered, jumping to 'probe_dma_failed' doesn't
invoke 'pm_runtime_disable()'. This leads to a race condition wherein
'cqspi_runtime_suspend()' is invoked while the error handling path executes
in parallel. The resulting error is the following:

  clk:103:0 already disabled
  WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0x80/0xa0, CPU#1: kworker/u8:0/12
  [TRIMMED]
  pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : clk_core_disable+0x80/0xa0
  lr : clk_core_disable+0x80/0xa0
  [TRIMMED]
  Call trace:
   clk_core_disable+0x80/0xa0 (P)
   clk_core_disable_lock+0x88/0x10c
   clk_disable+0x24/0x30
   cqspi_probe+0xa3c/0xae8
  [TRIMMED]

The error is due to the second invocation of 'clk_disable_unprepare()' on
'cqspi->clk' in the error handling within 'cqspi_probe()', with the first
invocation being within 'cqspi_runtime_suspend()'.

Fix this by correcting the error handling.

Fixes: f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to avoid imbalance")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20251118.
Please note that the commit being fixed is not in Mainline Linux yet,
due to which the patch is based on linux-next and 'stable@vger.kernel.org'
hasn't been copied.

Regards,
Siddharth.

 drivers/spi/spi-cadence-quadspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 8e0df08609c0..af6d050da1c8 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2002,7 +2002,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (cqspi->use_direct_mode) {
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER)
-			goto probe_dma_failed;
+			goto probe_setup_failed;
 	}
 
 	ret = spi_register_controller(host);
@@ -2020,7 +2020,6 @@ static int cqspi_probe(struct platform_device *pdev)
 probe_setup_failed:
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		pm_runtime_disable(dev);
-probe_dma_failed:
 	cqspi_controller_enable(cqspi, 0);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
-- 
2.51.1


