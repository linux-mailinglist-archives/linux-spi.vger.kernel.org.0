Return-Path: <linux-spi+bounces-11053-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED2C36B75
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D523625BF9
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17779324B29;
	Wed,  5 Nov 2025 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="clRnhv5z"
X-Original-To: linux-spi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0D322A3E;
	Wed,  5 Nov 2025 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359120; cv=fail; b=sQLIxqAlB3IIfKNTr+RX8rkH9luJgxPvhec0/+UB6DFfOy2Bz4Wuasyq5CITaXud8khauCtIymT0517DamPoisYLHYcqwEb+RHyHKKX4oIWzFWKSNxLIMuCgR9Vz3i/7GzYrZgWHRgMzFa1vcREnfLbMFn2tpK0R8QWAt4vig6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359120; c=relaxed/simple;
	bh=EdoUIg3RUN/SiJO0JSYaxMlpPyTXLjLcToVwARvDuVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ACxHhdEqFd7oIqBDYdBkIjcQIY1a+YOdLup5j8f0YJJcrO2riTjvfVTg7RSOXZ1gkLamq8Y2zxtCuzB12TWZwNTlfR7KXrym1D9tJhiT3E0xMrbjlcIUzXwPuAaOwUlK2K4O4Tz2zmF54Scf5arEDAbXd4O8kQWwDjcrOl38/Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=clRnhv5z; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/Uo+RVEZDqnH1yh2GSIA4uSGqvkL/5ZItoLyvzvy5wLBgM08ZMpRlXhJ8mzkVgcZXDmo6k6FnlJ3dBu75SXy6xxsCuJkgCyLcy5JFbO6DwVlX1UaO6FjiNBZYI8qBG3EEfC1yk3PIlJo3z06KRadSxk+HnZwpTYZ1jmGa5UcCxlYxOAJcfzZg04DAaFYs25tThYu7EbWfzsWIJV+zc9up6I7iq1g4/maewQzuVMY0BxON2J6c9Le1HEZKE7VbKe3K/d7+pJluNk47wa0mcVyx0vbUGNg+UKaD5udToMHPmY27a9j6KdBWA4GQkAOWztXgMSucwH6hNgmQHBPtu09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Q8bKBaSz7NZ8DZDRLigdvDFACkN0bzfDGQDg7EMZAU=;
 b=oAL/veh03H6W0aMGSSnWfP6md3U6UwtT0HDVa5RCOmcsO4VWKRAIwJfrdKA2R0PYauASsFS2Wx4G+89lyGV415q0h7n/AUtWKREwh3OZ/0iISBodXUeptgb8122YXEf1XPm6U2nr/QDRo82b7Q1GulkqplrQ1apmel/90ySyp7e4LZ7ih9f6VVTSJhTdBApay2hQwePmnUpUTAnnqeXcFITItODNGk70xYX66cwG6kpXDjltJvRTi+IB/3bGBNHsB9ycwwb+HH74GFVftTtvzwmaPVQj2Ow0lVzXmuIEJ9RJpjji0JybU8LeCXy8BXFEGHt+ptn+YQuSDOc5X8YP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q8bKBaSz7NZ8DZDRLigdvDFACkN0bzfDGQDg7EMZAU=;
 b=clRnhv5zLiHLehMvQrLkBv/XviDoxF0yvFsq5Kj7ZrlfV3ZgO78zQK0hury6mZXS1e8QD9VFfE3FVg2bE5GbrFB7BfH6/0rcNqVlHq2uIYjASi8oSYQN4qq3Q6e9/ti6flrQQryO57tVnqgtuyVqKWrRLjWrz5jhW3/BECZ+vgs=
Received: from SJ0PR03CA0076.namprd03.prod.outlook.com (2603:10b6:a03:331::21)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 16:11:54 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::bc) by SJ0PR03CA0076.outlook.office365.com
 (2603:10b6:a03:331::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 16:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:11:54 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:11:50 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:11:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 10:11:50 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5GBldK3979508;
	Wed, 5 Nov 2025 10:11:47 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <broonie@kernel.org>, <khairul.anuar.romli@altera.com>, <vigneshr@ti.com>
CC: <u-kumar1@ti.com>, <s-k6@ti.com>, <linux-spi@vger.kernel.org>,
	<gehariprasath@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] OSPI pm_runtime fixes
Date: Wed, 5 Nov 2025 21:41:44 +0530
Message-ID: <20251105161146.2019090-1-a-dutta@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|SJ0PR10MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: fa79d168-427b-498f-236e-08de1c860961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|34020700016|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AUX7jJLtif8VV1k4lbY6KCCqrzsAIvaj1HTk7ZBFHoY/eMsTkupuPR6SUGcG?=
 =?us-ascii?Q?a6DLrpdCOLENK+zqxwVDMAmSkiy/6KizRj/iOpf3W0jpOd2x2pOv8k+23/Yr?=
 =?us-ascii?Q?7hnc1OsKe6AX4n6x6AxCwOTQ7EPzOxxoza15jgNzPH8+A6QXCbxetoWbII0d?=
 =?us-ascii?Q?8xaGUP/hWa22U4ePpwMdkamiLN8CrpBGFeTRuWlCvCPq8UUFd1b7SO/daA2k?=
 =?us-ascii?Q?rGPxpQJNKla91Oz3OkGiqn3WcLadZy7EIj18hYXaO3VdVLpF26+cbQy99rJf?=
 =?us-ascii?Q?8GxRDL/mEzZdVrXvI1tV0xl2uwHaKn6FzrWc/M3nbo7KoPz+U7Rhtl2c1QO1?=
 =?us-ascii?Q?a2jxwdrlKnhATIWWMuaMcEX3SkZW2OOcdndSQP5p0EMVNS9lkdExD8ix2PcF?=
 =?us-ascii?Q?lasEOu3aHGrum0lJTC65U5PqoapV4LOJuDE2uO9lsYWfxoS5NIcJe3RYLZdk?=
 =?us-ascii?Q?LBQ44z3zWResRXbSXIi7HsHZkcQ09YJIFNf8eHKD21XZg6fA3fbK01qIdeQ/?=
 =?us-ascii?Q?cgd6gbkudK41mMZ8DKGDy180DvdUyz97DKXpE6luJqS8FnRP1dlfxfv/5a3L?=
 =?us-ascii?Q?a32m7h2FaIrMjvoxidUG7QwP2rEd+SJYJYYTu1h25LsZ7rTv+8ZDJehFbRHm?=
 =?us-ascii?Q?O+HP0LYMmVMeUGEIrQ0tGRDId+LuYMCRWK3H4u/ELCdMtP1dSgCfN2wpuuEg?=
 =?us-ascii?Q?mD7fHIg+6jRBKghaVphzK0YnyrnRG/7BHxxNi1uaH46m5LffAUqpZQfAYnF8?=
 =?us-ascii?Q?BFFbdH7D7f7J/X/L3FqIg4SxX7b7Q/xqhHEAoyWEzGv34Hz+UP76BjOPYncr?=
 =?us-ascii?Q?zFAVYMAQCoPIjmaGSsvaf8o4+8d7S3J0guXrkl22f3BiiSPuwf7ajRP4Uzlb?=
 =?us-ascii?Q?TJfM4OCneMSAtoryOmKgkWMg28f0/z/0ch79BNTdB62nouiSDMZjjQCKP1hZ?=
 =?us-ascii?Q?z33qREcljZ9ohplOhA0Kb8qUTyOjKBluappuhrAlJBea/iKrwsS8AZLdCGg/?=
 =?us-ascii?Q?wU9lWNJ6YPUennSVmL9ocYvhMZb8iMFHrI4anyqZHc3mVPbux9aLB0vle7kr?=
 =?us-ascii?Q?mR2PWEreKWRsc4DrsZ7QISpvj4Yf2lCWnxX+NFrvn4Xg/4HDaunx2sxVk9yi?=
 =?us-ascii?Q?IUVblXaCSGtIjFUtbw+Jj83bU2xYiniRROk/tYC2kCAcW8G6BHG9l+hZ0tNE?=
 =?us-ascii?Q?Cr0yiP47xfh/dmkWTG5lMzSpX4f5U8BzKmn7tmbzrKqlho0UnN67vMPCN6vs?=
 =?us-ascii?Q?ssztgeEMUqxAMAXLDWVS1xJGp0kM4RgCnNHqiMdBzmnQOCztvQPYAbuhvJkV?=
 =?us-ascii?Q?kNxX8LUEYhDplp2QjlOz7fRXTxsdXUCvkjPREwbDOVkGQvR/952b+1uKr8iT?=
 =?us-ascii?Q?RuNbDpx1cD0qqVuU5TRr+4Ef+Wk91gGVPuhFLgfCp8nMhgO6mZ0tpsaW1sV4?=
 =?us-ascii?Q?EUqYGYsLavghZ5hGPxbyILD46n6Ae8PJEVzjzk0GrmI5i8xl0rF2p3BZqD3E?=
 =?us-ascii?Q?cgAhWmdmb1q5OxxChuXNWymkozoF/CUmUYDLeE2vtfntBUDXv7jDPVfJIfBL?=
 =?us-ascii?Q?TnZdFkwuA5f2SoLeXnY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(34020700016)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:11:54.1096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa79d168-427b-498f-236e-08de1c860961
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527

Hi all
This short series introduces fixes for OSPI pm_runtime to balance the
runtime PM reference counting.

Logs :
https://gist.github.com/anuragdutta731/238dbc6d9ff7927c63cd4dcfc51dfa97

Anurag Dutta (2):
  spi: spi-cadence-quadspi: Enable pm runtime earlier to avoid imbalance
  spi: spi-cadence-quadspi: Remove duplicate
    pm_runtime_put_autosuspend() call

 drivers/spi/spi-cadence-quadspi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

-- 
2.34.1


