Return-Path: <linux-spi+bounces-10891-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D88EC15647
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 16:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 006504FE764
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086DE33B975;
	Tue, 28 Oct 2025 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QzKqiYw+"
X-Original-To: linux-spi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED633B976;
	Tue, 28 Oct 2025 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664557; cv=fail; b=C6tQpyQ+ehlQhhUE1q/L/NKTliJBKUhcV6Krt3JsymhPaYUlVQxyO1kohociMmq/LJkrOxEUaN09cd0WOEyorGMdzbkBXEtkGA2ItO/w098+xpnjQS01hF1oqkqL49SOICev3RRoLfozmWpn5LH7yLiqJMgWwJWvjdJIeaOkrwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664557; c=relaxed/simple;
	bh=sZ4Yms2enzCiN3Q+TugrsTWMSFPD7GqvYbmlyhi3dW8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p1/o5sn/lBbaVfwOmZuSYM8ErJJ1eEmIRcWuMHHyIkzYjXi52RGbl8fU1AFvjSWHk1yOXoTJYzB8/v33Iu7xpQs/bHwsNxj3hQ1dTb3A88zC/e+8Sx/cOYSrCEoHgFFcunTM5pErnZqJo/8eNTZ/0BrBALz7lXCTz1wfXeN2CRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QzKqiYw+; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8XymriHDvn9JqOpJRmOjMLfebBGy05aABmE5Ex5mdUS0pvUAqgu8UDDqvs4toJ6oIuKKK8IoXmzfI+nUZiEpQPp61FUmQTE4GkFmNFGSWKqvkNzohNiMuJNNNb2t077X56Z7tupR6dM8TSuT3SqrDurkqoWULJHrrdZ7NAZURAA8+Vn79t43XkcdvhwJt1Mm01YzZCnefMqjQ81pNRDoH2W2DS7vIilcXDQbCUhYMUMXByXzcKQc8tFIzSHW0o+SYJLeywv8hvfsjNW9/IGiQ5rLqOACDewFrySoDzTf9O3JXUu1SQ9J0dZMCA6cWXJYMml2boo8iFyN9KVYsCd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQBqUySZMX5F5HhaOQU5JVXqmlBOHMShxtqVMO6jS4I=;
 b=RK8rbbz4LUxCveikfPS1s7yZ7PT3ZF18X+zrL32wGOYGNJSvC558McZvpK/Eq+MQRMYJJylZdwkIx6c888r/yHtOdZuxL0sIk/szNPtovkbm4/jo75ak1VCCtoGEQbfDCbLFv6dHFsH+QkYkSbiIQs35JnWAsxm3kf0CPMUnT2G6o4RvLRAMeaadyVvXUnk24mnuweKCn7vDKcDn5TfT+Hi15lG7OPlwY+70p2oZgDiFsRGW3DG0K4TWuXYy4Bl07x3GJy8tfRPrCMF4UfSm3mQprFd/aIUPmL7H74xyIR2bIPz69mGQWYpugCFtSOpnQ7/Vr8213+jAzt7KKzqPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQBqUySZMX5F5HhaOQU5JVXqmlBOHMShxtqVMO6jS4I=;
 b=QzKqiYw+SkQOlsIpZ5HKAO/NRNX96aD+mqwT+8qHCDHHXek4cWa/SgfDuyHlslNX0HMorR3Qkc/SeqNxaccrokQwOdcOTfnbn+LHye8DIZ71bkPsySOKHQFm+E3m7iKCSECdBA7tBd3nGKTaG2phoDriUOzsB4nF7fTVu0BDwzJjJcz7QPCbVP5bRDHwBY5QKHgjq7mIUYXg+W9NOlZl1dcuihqIHBceU2TPGwolvsvYjopwbNTLB0TuPw7RYEWeqoQywOzTGy24JyRGXjeMnm6bB4afGejR0ei7OfJvGlPctwaRlstxNYRfbIx8NqoxZgXhXonPNJPj3BzsXDc+cA==
Received: from PH7PR02CA0010.namprd02.prod.outlook.com (2603:10b6:510:33d::29)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:15:52 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:33d:cafe::8a) by PH7PR02CA0010.outlook.office365.com
 (2603:10b6:510:33d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 15:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 15:15:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 28 Oct
 2025 08:15:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 08:15:20 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 28 Oct 2025 08:15:16 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] spi: tegra210-quad: Improve timeout handling under high system load
Date: Tue, 28 Oct 2025 15:15:12 +0000
Message-ID: <20251028151515.4142618-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a06fea1-1c9c-43bc-714c-08de1634e21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xEtqPfmh+NkXG/U6ayKVAxb3fyQycCpcdTNI2SFfJy1OuBn5y3zNJzRThWVh?=
 =?us-ascii?Q?S2lsvCZ+QBAxn83Tk9iQmBDp54eHvK+M0Fu8Qgwi2OBu40bpMljrz7dEWYLj?=
 =?us-ascii?Q?rGtphXLwYjJfrIoGI0WmfRSI1F7dQ8asUdi590TUqwobX43Gh0cKTS9XEYN3?=
 =?us-ascii?Q?xa1C+4tr/Z2fzBrCxBNw+zq8K2vPx3hyiCL7ov5rvfCfEiWqNHKRNlTsIPAL?=
 =?us-ascii?Q?lBH39crZrVg6U4N8xDA5PXcmmREhjK/VFWJPD39mKrQOj0cvjh4l375iwaYI?=
 =?us-ascii?Q?09Jznx5fgpq9PNs03/VUWfjGkQ9MWacmChLxdb0h1lSkUFp1Yij6YA8y0rs+?=
 =?us-ascii?Q?3YNIhnO34FMhrRDyRmqNdy5PdhAY7bNir0N4gpUck/ln8/d4dNM/j2mu6ht6?=
 =?us-ascii?Q?WxvwGQvQeoRGZPmY72SZJFL7w+ZDuL5tZrMQuFW7OVgQgtw2fHnlTy7SaUKk?=
 =?us-ascii?Q?XvnFZNqzXEvHbffQRMkOShQA2M31zXT7dfKvPMa3zb0U4iAZQSCs0S2gL81i?=
 =?us-ascii?Q?Nzvq+d2rCcm6r3+MEv8zc82JCIQtchGtyfumTWjWrMMTNmHaPSQUwQ0k6dTr?=
 =?us-ascii?Q?p8riGdbsSqPtg2U0iiDoliolNr5Nobo+Ox0mx5+4IN4M8afdpobf17yS6aL8?=
 =?us-ascii?Q?WlV9Tw1DsX4iy7oYOlTOUmSJwZjcxYZsb5fKDLKcUiCxmZP4wAmRH69VRClI?=
 =?us-ascii?Q?Al2E0fXMWQs4Qy29dJgIrPSf/wsNUEnRMJUBwyTPfayPpMTmuRzU76oLvebX?=
 =?us-ascii?Q?VpzrKtnUsuazksI3yHYOjExVk8UVb9AVEL/zgqzWFX6LkM9RT5BbXQDHRS+d?=
 =?us-ascii?Q?jOlJFWGc9W2ciEmFVpbdmcIHsK4wO84KZVhvdpoh37QeJ/kd9Dkc1W5cRHeZ?=
 =?us-ascii?Q?VVwyv6zHePjAxu+oIao9cYjNHh59WeMd53GwhIavX3WRwaasWri8fPGJlxjg?=
 =?us-ascii?Q?Zo6L6Af5LsmW/vXXPN7oQjZt9Lh9VcaF/asfMm54NCGYf40qDgXbdI1Orrqj?=
 =?us-ascii?Q?HqSF/KA3e7IURfs6Wp4GJUYsmyla1yQN0+Reb9aw0yz7zr6koddOaMNnyl4Z?=
 =?us-ascii?Q?a4Kfy/2BF3DD/df8VdrCeH3cCnzdMqAZVZXeSWZBv4ZWg9nbTOQVpLtYETr/?=
 =?us-ascii?Q?mQCZQqKSdhAUMAcdyhQ33fAWDGZIHCcGQqb69CRTRj/0UwQKscGsoLKIRnPJ?=
 =?us-ascii?Q?uICfVcufM2XFGdosoN9+SmDtqDigG1L2ZYCS/2xgbzxWkEYxhzVf43ikGllG?=
 =?us-ascii?Q?xXiXf7QoWDj8t9yJqYloVigxQCoFAF01v5uPoKkRLgpfUugq6zpRcX+ZuH6p?=
 =?us-ascii?Q?376M0mhcZc+1vUi9qR0/nmIx2zyvO2U1RcJggfWGbttVwNYjXFzO+nJjSudp?=
 =?us-ascii?Q?2N4qqGMIpxhqhoBkrwCAB0N8Gm0bAordOxjUQ6enxesOZhjNTxfw2WiDP4+Z?=
 =?us-ascii?Q?QWSsbqp5dHvhJvCpCppDQmWEzNKsXKte6L1GN/7dIkDoHjwBMe/VVaTeZTuR?=
 =?us-ascii?Q?uGziiehpJAvVuO45zfLldhryWbq29ocbPMUYQmbm1qE6wgY3PXSQ3itEBAuK?=
 =?us-ascii?Q?BzOYw8YkI3kqxBuPc/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:15:51.9628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a06fea1-1c9c-43bc-714c-08de1634e21f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270

Hi,

This patch series addresses timeout handling issues in the Tegra QSPI driver
that occur under high system load conditions. We've observed that when CPUs
are saturated (due to error injection, RAS firmware activity, or general CPU
contention), QSPI interrupt handlers can be delayed, causing spurious transfer
failures even though the hardware completed the operation successfully.

Patch 1 fixes a stale pointer issue by ensuring curr_xfer is cleared on timeout
and checked when the IRQ thread finally runs. It also ensures interrupts are
properly cleared on failure paths.

Patch 2 refactors the timeout cleanup code into dedicated helper functions
(tegra_qspi_reset, tegra_qspi_dma_stop, tegra_qspi_pio_stop) to improve code
readability and maintainability. This is purely a code reorganization with no
functional changes.

Patch 3 adds hardware status checking on timeout. Before failing a transfer,
the driver now reads QSPI_TRANS_STATUS to verify if the hardware actually
completed the operation. If so, it manually invokes the completion handler
instead of failing the transfer. This distinguishes genuine hardware timeouts
from delayed/lost interrupts.

These changes have been tested in production environments under various high
load scenarios including RAS testing and CPU saturation workloads.

Changes in v3:
- Added missing tqspi->curr_xfer = NULL assignment in handle_cpu_based_xfer()
- Split the previous patch 2/2 into two separate patches (now 2/3 and 3/3)
- Patch 2/3: New patch - refactoring only, no functional changes
- Patch 3/3: Functional changes to add hardware timeout checking

Changes in v2:
- Fixed indentation in patch 1/2: The "Reset controller if timeout happens"
  block now has correct indentation (inside the WARN_ON_ONCE block)
- No functional changes

Thierry Reding (1):
  spi: tegra210-quad: Fix timeout handling

Vishwaroop A (2):
  spi: tegra210-quad: Refactor error handling into helper functions
  spi: tegra210-quad: Check hardware status on timeout

 drivers/spi/spi-tegra210-quad.c | 216 +++++++++++++++++++++++++-------
 1 file changed, 171 insertions(+), 45 deletions(-)

--
2.34.1


