Return-Path: <linux-spi+bounces-11874-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E0CCB8198
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 08:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E14EE300B809
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 07:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59BE1F584C;
	Fri, 12 Dec 2025 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YMAlYhjC"
X-Original-To: linux-spi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581FD1AC44D;
	Fri, 12 Dec 2025 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765524206; cv=fail; b=pXYkwzug/eKv1/QkJkO5QmP3+Pg/WP3GnH2754IBDshDd/e8Ry8//V/Cv9MC3z934bBuHU9f13YiFOfseD2mK/l8jqef2SVUpLFFAiHx2Ax83va60uiYEFH5xnOXNYksWgf1xr0rY/enP8Q4RvzdSWwQk5Ru1dAf9PRt9i5Rq1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765524206; c=relaxed/simple;
	bh=ffVP4OduHl3pEoWpk3jI7vAwMnmqw4cVAZ92uEhoERo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J1/FSfvZRXz5agdHCmUhT1sql9MLvCJiUFJsz3U97RkMmvZtQMrWQNAfQxi4GPRKtj0rW7iLBWQe2sYW5+bPgSMLCL77dFHVV0SscptLJ0MFQiuA9Snxee1D2ANPe2ooE2NeUJn+Uio7aILpgK0YpzC3HR/yjUuusu4dUwgOYR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YMAlYhjC; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzm7FDAIn+4cHDCY7pGQMbIJ8QeQrnpSlHWbhSX6QmemdiLdbseDKHaqkfEC8jq5o8lJKHQnLB8vkcxanoljBttJT0R9ERu41zRmFm6w/cugAfe96gJqO4bSgZ0+R94vbfm+q5CfKbO8bYQ8g+WBpH+7USf5WThdXwYIinstWt4Q2bf4YeSnGyG7GL5b3dmUSz5CkcnYgsxE1xvB6gdcrJZUYOuQWViSqX9B+fz13+DQATI6MN1br+gGlacNYTIW4HZFWbuRHoantKvVN6tuG5Y9qYLNldzX7zKCeXdash2hH2TrHKkEu/EaaVc3f5CK6O/EpaQX3YkyrETR+MUarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsuGXAXEvrleZUk5GemriJL56NHGZLlWub1poXCY5gc=;
 b=JABShWYwtUzr2jjBmRVgD7FmYNyS4tXB68rvl/GaEPOZyV3TH+sBl/53e2nQQ2TllSy8LmaEgtCEm73Hsi6FnY9L3FYqbkx3My6savgGWYy0m14e2dJllbhCumrYZPY43vOX5/rS4/C0YU5LiLXYuTvau0UdsWD7ZE0K6zy4AQ36WWslpHmiOKu7jo9ifrl1hOy9CRE6d4hBbShR1TKbWfRx+jjvw5KXrFcxqn3CxK/Lbf9d/7HyfUi4Z4TWuM60mNvGfFjNmq1DCmnC2jOL782xNcofAIbKkyqIeUZa29eToArhYNhl/a1C6VNgAVLaO2wG1n6/7OapiA+zD0CSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsuGXAXEvrleZUk5GemriJL56NHGZLlWub1poXCY5gc=;
 b=YMAlYhjCD0DyEgZic9NPMGxm15ONxMemYT4jqHdn8oR/6U6S5VZ7rde64ZDzD00oMsLkZM8YPCK0LRCm9hbxG3xQrrjB722TLaauCsA7TgrMkYtnFevhjJ/a4YKDBKxTSn0QtcSgHxa+HkLRcO9BqIYTHiG3gWoEizZwMD0seeg=
Received: from CH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::11)
 by BY5PR10MB4180.namprd10.prod.outlook.com (2603:10b6:a03:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 07:23:20 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:1ef:cafe::dd) by CH5P220CA0009.outlook.office365.com
 (2603:10b6:610:1ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.10 via Frontend Transport; Fri,
 12 Dec 2025 07:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Fri, 12 Dec 2025 07:23:20 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 01:23:16 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 01:23:16 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Dec 2025 01:23:16 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.235.228])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BC7NDoY1844826;
	Fri, 12 Dec 2025 01:23:13 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <broonie@kernel.org>
CC: <grmoore@opensource.altera.com>, <nm@ti.com>, <francesco@dolcini.it>,
	<s-vadapalli@ti.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gehariprasath@ti.com>, <u-kumar1@ti.com>,
	<a-dutta@ti.com>
Subject: [PATCH 0/2] spi: cadence-quadspi: Fix probe error path and logging
Date: Fri, 12 Dec 2025 12:53:10 +0530
Message-ID: <20251212072312.2711806-1-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|BY5PR10MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 402ac71a-3664-4936-a4d1-08de394f53c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RKbApbzSv/eeeafnrpqexqJYIBoM8W9YzcZsbTIu0+RU12g4E/gDSaAFBkak?=
 =?us-ascii?Q?baToid+f2bsOv/91ZQ0Ws8jee82pgJq6N9GlTBPkTNhQi4S3KBJ830Nat7d8?=
 =?us-ascii?Q?drgBEwI2/BK/wgPJC2hStn45nF3yJP5os9Jen/egpgJipm0VCgS7u7L8imh+?=
 =?us-ascii?Q?71dzAQeIE03aegLbhyPvJ/4yp4hT5zZmLuYFrUqiUX7rx/LEFUxvwi4b48LB?=
 =?us-ascii?Q?xrKXLXERkS7/C9EnzoBaWAgWh8rxtJsXlm57r7fwA+ekMquyilUiEsm157Hh?=
 =?us-ascii?Q?B0S8wmbT8QE/v8mndAXCjZ+O3CHHYLK/fk/tbvNgf91K6aEoh+K8Ug+QpmiM?=
 =?us-ascii?Q?8YGTHgY1aXAtmrBLX3v7tKQSeBrurex9noIZ7QvTVnnrGj+YR4tCmgzzT/h3?=
 =?us-ascii?Q?wtwhhWAPxhxmAiIBPk+ujAU4X4VUjRqwEpIqyS7/GP76nqaH/RAjtx9Shtg9?=
 =?us-ascii?Q?1SkEC8lxC2Om1AyMXI5xuqHm1gzerx6OPzHKQ2b95Bo8Jtlu8VMvHrI3qhzk?=
 =?us-ascii?Q?tHgGjLmz2Sni2QY+6oOM04v0ywvVsBULSeYZGO02xCuxA86ED01Azh0e6FCe?=
 =?us-ascii?Q?9HfKP9FasYapgBjiczuQYrq7/aoMS1gfkOQ2izbRLLlqdOmUZBHFzYjIXpqi?=
 =?us-ascii?Q?4e6o6QxsxO78wOYrgpPcnSOKJMvJzexGx+le1nZHgYdv3n7s3pif2W+DZ9vh?=
 =?us-ascii?Q?FO08A8PcrHgR1h01qk5ECd130OySB/Pha96tx4NNI++9KF1iQen4Nq/qEMoP?=
 =?us-ascii?Q?VIRCbb0zJwkgaKoXeP2rweQ6Je1DrLgXu+yUUz0NnMIsMAfW7xmZbPAtfKmo?=
 =?us-ascii?Q?2ZR+KkdriskA75fPRFwH48QQj08Aq2q/P0FDBEmsJZ4+V6mGK/xK65G7zkoy?=
 =?us-ascii?Q?FC+ZUVtpE62CVAaf1vpkqeXlsLS1m9GAKWoEfAUdMbIvujUeqMdX8ZMXa9O5?=
 =?us-ascii?Q?OcgwffmaFuxGHWNXJ34Hjeg9IJCA9YafjhOL1PIZpcxfy8sIdKQRW9HC75xT?=
 =?us-ascii?Q?KnmnRFLxUJ/ygkNiiiOK3wlwKOonHcClOVkpysbAKkNBQlkKach8eELTFJkw?=
 =?us-ascii?Q?5PIwLWTj+/yaUeQG2eRqpErs79hMuPDbJ5I5BQimcZfa0F2F/ck6sqjIqh1w?=
 =?us-ascii?Q?JKUwNMvFhjsfOyGYesT8Hs4nSKpmUgm6gYAX7hoyiVijv+tCgZsCkRfRVxvU?=
 =?us-ascii?Q?1+9t7lD1s4b/XPGLu8CCnifrE8TV6iiGSO1W49SoSRidzKabLQdL1gZejweb?=
 =?us-ascii?Q?hn8legHpcZsRQzootURoBdrgMnmHTU7xfih0kSnYk4R/A8lvqwNqLUrt11IY?=
 =?us-ascii?Q?1jBV0Cf7NWUuW8yRt4nyW6MOsC4kvK6mFsPXsp8ztw7DJYJoymtky1FXeepk?=
 =?us-ascii?Q?qnx0RH8CLpFHycv5Jm/zHiH0VHYyI7aHZWsdqdQhDQSWNe17+epgsWEzEdQD?=
 =?us-ascii?Q?+sGmR3GE6Gz+ywIjWfL+K2CyqoxTGIdfQgTdiNewysZIXew7OG/GmrbgQ9N9?=
 =?us-ascii?Q?OLHkQRyY5b/CaJMy6DrkRxC4a7NNA9EOou0nzghPxxgRmz6GbFm+xFcoK+/T?=
 =?us-ascii?Q?YifGARPKTx5wbQ7adAk=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 07:23:20.3046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402ac71a-3664-4936-a4d1-08de394f53c5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180

This series addresses issues in the cadence-quadspi driver's probe
error path:

Patch 1 fixes a clock disable imbalance that occurs when probe fails
after runtime PM is enabled, particularly when DMA request returns
-EPROBE_DEFER.

Patch 2 adds proper error logging for DMA request failures using
dev_err_probe() to improve diagnostics and handle probe deferral
appropriately.

logs : https://gist.github.com/anuragdutta731/59925cd11a50913b7128c88cd5394db7

Anurag Dutta (2):
  spi: cadence-quadspi: Add error logging for DMA request failure
  spi: cadence-quadspi: Fix clock disable on probe failure path

 drivers/spi/spi-cadence-quadspi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.34.1


