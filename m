Return-Path: <linux-spi+bounces-9286-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F2B1B135
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 11:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50515188749E
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90494274B48;
	Tue,  5 Aug 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="qMP97BDL"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFCF2741D6;
	Tue,  5 Aug 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386433; cv=fail; b=bLLjQZF8reiKVb9Esvt06emaxyHiI4tOS3xFvLwaEcqysQk0mNdxafSUp0T2KYM/Z9MhcZ+YXJr2RO+nFBdDYr4uq3gmyRglY0GcPI0rxJl1oDR9dnp7ByLRoih5V7GMKFA0lRxODgNopxuj9f0M+FQ60XWpuxZQENdAqsRDnDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386433; c=relaxed/simple;
	bh=yiEioGhWjWa9fP98erA6GdHSglNLkV1n3SwZdHviT+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oIfmjZHUl5N3MfxcfdE0No7EVbQxM5G9qqooZYZ8v0ZYgtKbP9OZZFf1Vrosv9FAYHjiRA1BJwm2RhunWhVL6OEDlFjoHVQ7yqbS1sJVYk7QgEHaP9psyERaK/L9tYzNPty3j0N4LGLUd30KbDtACn/GnzrIExl9PhZZuqKONcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=qMP97BDL; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygAANp6QApcsCHjbdnUVry2BypklkVV6NMIK+vFAKIA5YY8e8WcU/sQRKvtWj06f9kLU0BtSfszQFxqpjHbxUdgcKSUCok4qlZrOGKwXBuwudShGHVlnv5Y1pf14/A+4SOobTq+oqKM60pVc89tipolj+IT7o34MBbr5MhFHmZKNWe1YCg8aCRrmwQMeSpgBtutQJA41XuG7niN5U/M+kvqoX9P8WgQ/r8uGbpPvPDHIIaFbik+tf2JRN01dhmnfnmGXEdQdsmFJG+Mo31X8WOUL7ABUMjMrcZHb6Bnr9jXh/9MmZIN2DoOx/kI7p64rPOUMfnANAbrfCRte1Hp6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imnzosc27OxaRZqEQokwegyuTHiy1dOHFuMet7Y1KMk=;
 b=p8y5kkLreyk8xGzkoQJbBGaLDeFoMNfzoYLmWenD1rh8kqVO9WSLvCE+S97gWz6W/9RX1j5G5BpaX71Mo5LFtEH9q0mqyEVvXcfDWPANNOWkAbQHtfAEKl3sVRWIdOBZPc22GiRgVy8gowqUSItBMQRhp+VDuZt+HDj/v5i9SR8CEX0IUXjLu6G+sPB/fYn3dRgSF6dd4gPsdSKiIXz3k6yj5gzXBhyI8OIuJzQXGe9W9zy9MY8Pr56mElPpg+5Q81ziW3/znVnNDJUgkZLHU6xDaITePkQIHIAiB8M3Tv8Ko2doFxVfyTw6lnun7f//l0qII2+JTpF3ditsJb3hGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imnzosc27OxaRZqEQokwegyuTHiy1dOHFuMet7Y1KMk=;
 b=qMP97BDLVlwD34SbamPL6olh3wmej/XL+trLBfbzhgr4RJ7ErbPnSontKOEPxsst11EcZvmSGEyaFnkHQu9ihOsd3M3U1rEKku512nX7Lq8I5unk3pC/Dmmi4CkR9uQ+S6FvwFR/3kLE3BbQHQ5YmiCWRZ8mBpduWh2b6WryxyM=
Received: from AS4PR09CA0010.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::14)
 by DU5PR02MB10846.eurprd02.prod.outlook.com (2603:10a6:10:528::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 09:33:48 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::e8) by AS4PR09CA0010.outlook.office365.com
 (2603:10a6:20b:5e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Tue,
 5 Aug 2025 09:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 09:33:48 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 5 Aug
 2025 11:33:37 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur
	<yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
CC: <kernel@axis.com>, <linux-spi@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] spi: nxp-fspi: Remove error print for
 devm_add_action_or_reset()
User-Agent: a.out
Date: Tue, 5 Aug 2025 11:33:37 +0200
Message-ID: <pndqzxqkt8u.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|DU5PR02MB10846:EE_
X-MS-Office365-Filtering-Correlation-Id: 31439d76-caf5-488e-55d3-08ddd4032e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q5M77udrHpXpAkJiYVzBg08Dx7PxXeMb8Aashgvfm23C/DgyuJHTSlpC0XB3?=
 =?us-ascii?Q?XJsodSMp1Z7y6ukfi4Le5vIebHeTxSbkualEjQXDRqo6VXGDTkV/WvhMypi9?=
 =?us-ascii?Q?8AWWTGvaOdW7dRJ6KmxMFucFyOJ+GtElWTTHiT+284H4A4yOLb38hNascnyC?=
 =?us-ascii?Q?I99y2QQx4Qj4rfTSSjOq/gHZ9vUP+XIfmmg7vj+vjQ4pVm+HsZkmgf68axXU?=
 =?us-ascii?Q?eAal6nlZ1vw1V8KS+wPP39386BXNne/F/xPf1C60l5FB3YC/WR1JHrouzAme?=
 =?us-ascii?Q?KDwAm3qB4zmQE9/vqnkY6CKbTtADmpA8j9DG9DyPbqBUm3xCyAFpTjQCHSSA?=
 =?us-ascii?Q?ja4+21G592LP/IIuchs7YbSgO5+NE2dhJZE0xJCiQ66206CSeDNfIslsMPFc?=
 =?us-ascii?Q?gmG4xonJu+8UkgSKR3XbhyhdL34kO9bHmKMG94FQxF/Vd3A/XngLMjseYcD7?=
 =?us-ascii?Q?tcKBFMzT3qDOWOVqKkq36AW/3ooknx0OMsdPrJTUVTpWN/ntsCo6ShAa+R98?=
 =?us-ascii?Q?BMfha0xHMNvBqrZjn1CU3XOCclQ/oNIhRjZCr1WRPqoazoDM3iYWpz8NPuyG?=
 =?us-ascii?Q?oc567agNrLYt67OWPt93hlEUP8pbkRv0S+LD+PktUC2H3Y95dbVtPbx6HQO2?=
 =?us-ascii?Q?0ECqnB0vP3wImvzhxbEpuMWMR8k+LGz+zVEsJWvu254RI9m025A+lh2yGiBM?=
 =?us-ascii?Q?dukPAjFMfY0AqD3L98UmdiLQsp5tsHwjH+Ko/fzPpiMuuRK+TqUaHx5Ru4b4?=
 =?us-ascii?Q?++WPtEufY5uLe58x4JctST+WUvWFUSuKByzm5m6aywWIZty9ezV5y0+SrAMB?=
 =?us-ascii?Q?1wEpHY7wIDkEpqLSA9LBaJ6MmlWQqwu9t1wXC8yrkoOv+/kDDfiK1UN+P0Iq?=
 =?us-ascii?Q?KC0YA/TYHa3jy9m79fLGPD5fAGnRc81MER7sbUR/pGnMHW3Z8EYDKGfXIK4N?=
 =?us-ascii?Q?DZnLchwl8bCUtauGRp7qePCeKL+vuu1Q7ejUEzSC1bHkYKPs1cFouV8t/u/J?=
 =?us-ascii?Q?dffODcSuON4GYFyA64ycgJjDS3PkZ8W3FehJisR1CBGQy1+orAgBkvd4G6nm?=
 =?us-ascii?Q?IljBmwxudHmPRts9Bc1QYnjcASh2PQPO1xwJyH75CmktFRidHo7p2oPF76TS?=
 =?us-ascii?Q?mLFrQgswJNfGq9+UV6vG7qLYrkRTiSW3bNercpCfwLK4dSAKNGr8LX6EOUzW?=
 =?us-ascii?Q?HJENn6SUbLykrL9Qi0q5Rwvelc0mp0R37RRhRu7cSF8ApK579h/y2r9g3mxZ?=
 =?us-ascii?Q?TZlo9JNj+yLTCo6KGHMdvfUawNAE+IYqHiprpxDxfq11s+RR6M8HnoAJacwr?=
 =?us-ascii?Q?3JNIn9AONepOdGE//8yuWxFMijp7t7ae+h6A9DOnJ1ku1qgFYh1pliTkmNPV?=
 =?us-ascii?Q?nsBOAXmWuqSn5Nl9Ao5p3pWBW97uAObKLyEYkR6CJFCTpPapn+wPlQFP4e5Y?=
 =?us-ascii?Q?n8u/y1Aq8ObtF5hV55LL+u7fxLvZ9hcM2hH/V4fxdQBsxLsMAud0A1NXVBX6?=
 =?us-ascii?Q?PB4hhUjZ9Zi9cVxBrWOiluUDPDnhiTd46OVQ?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:33:48.5542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31439d76-caf5-488e-55d3-08ddd4032e76
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10846

When `devm_add_action_or_reset()` fails, it is due to a failed memory
allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
anything when error is `-ENOMEM`. Therefore, remove the useless call to
`dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
return the value instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v2:

* Split the patch to one seperate patch for each sub-system.

Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/

 drivers/spi/spi-nxp-fspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index b92bfef47371..848fa9319e36 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1284,7 +1284,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	ret = devm_add_action_or_reset(dev, nxp_fspi_cleanup, f);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to register nxp_fspi_cleanup\n");
+		return ret;
 
 	return devm_spi_register_controller(&pdev->dev, ctlr);
 }

base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
-- 
2.39.5


