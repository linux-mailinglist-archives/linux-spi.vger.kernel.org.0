Return-Path: <linux-spi+bounces-5783-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CAA9D3A4F
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 13:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C457C1F22A3F
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5825B1A0BD1;
	Wed, 20 Nov 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1KM6sFEu"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B719AA72;
	Wed, 20 Nov 2024 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104636; cv=fail; b=Yi7idxolvwn7e1mZKfdkKUWaVgYXwTLm86R6EHUsj6CcbZNHb1p8FAWb1zsg4txHzyDr52M/b4nVXBI3drdosy/QX7g/kqCmmIWGPJ38gchZYYpUFaK64Ob7VCN5QVG14xNpF1+bQQg5y+cR3LLAPj3rrdvnQYzZ+WrGehq/mzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104636; c=relaxed/simple;
	bh=1Wgr9ZPk6JbI+cRRCkB5KyjikjmJsJho656f/SSzw74=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uW5MxbJILwerWnPaOZEtQgVzbuw1T4Y3vnoMtkRtR9a0TbVyAKOUdfsfePxxw91tbxnKRFyDHlZLjb8qjbrCst6JzYWA1dyx0mnU8P/BuyjB6ZqPwtgpQ8OXnMZbW7gDa2+b9rwivrjEUjEmOTDnInDY3/eA4kQIcXjYXcCWXA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1KM6sFEu; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CI1U6MujLW0mN0VtnTMg+rs6W7kZyPs5A2KHaJ75RZ4Pm8hWdi/SulSu8zePsK5sbH2FoAG5mWrrCQ/ThwgpwKrGcVBeySQGJ6LHML2rkZEmJ6ftTppcBuPXyX378Oo5Lx/+HPcXRmrB8SE6YDMP9XDB6vaIIy5Gnzis+rwtd2UFG9hSaG/uFsqPl9wnkhB+CLS1MC1YynNWbyR5sqBBvWSGE2YtlZRBxvHnlThfQXCUXkIywx98aCZw0W5kJd0JSn57048+A9Bf1SbI7b6LBbvcQIA2viWbu85knBdDs1NIFMkTviwQ7QkzdzYL1zx3uKqVbJWGgN809ZQaCDn6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMYhWnf8aCVP2/jzag8u8Rau+3LfkC/OK46QG5kPpfY=;
 b=X41x4wQiBmo8B59AVzW0CdjgDcVWOPGBBqUj/VJfbtY8rTFYL5WCfmy2794os8BAEi+RweO1i8tFZa+EscbT2ARu6uqyMzF8Z+UhhJoBCFMAfS+ElK4/qbdNti8+FbGYZMwA/vsdD7p3ZxexDGrYVGHOU0mwR65684Z1o18f/rXL56dhQrTm5hLH4IZ1bTSirs+bNw6KFH40ztYuVst6LpAkSaOFyHytu+9uikvpktzwpn2i8MVAGZdLyR7khdwQnXY7Nm/oh8DP7/AxC0zL56op54ZdYKVyeYqIdEa1giyy9wU022owBaU5z7o8mpnYPzHjhMxuQPVlCBk6JsPZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMYhWnf8aCVP2/jzag8u8Rau+3LfkC/OK46QG5kPpfY=;
 b=1KM6sFEupyd4FK/2RCV7JQog0LUu/MUhUDWBWkWKN8Eko6u5z3Pp6SArKhk5Is1JK5QRpLpnyZ2tlD4j96vbxHFg9PJKrooSVltd5EWgBj39Zo1dP/kwk1SFqw6+vFKa8rbIIZGOZvzizeZqVw4GFn4Ql4Aqd4EJliaCYnypZ3c=
Received: from CH2PR10CA0017.namprd10.prod.outlook.com (2603:10b6:610:4c::27)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 12:10:30 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::7f) by CH2PR10CA0017.outlook.office365.com
 (2603:10b6:610:4c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Wed, 20 Nov 2024 12:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 12:10:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 06:10:24 -0600
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Nov 2024 06:10:20 -0600
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <vaishnav.a@ti.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <srinivas.goud@amd.com>,
	<radhey.shyam.pandey@amd.com>, <srikanthboyapally2016@gmail.com>,
	<srikanth.boyapally@amd.com>, <sai.krishna.potthuri@amd.com>
Subject: [PATCH 0/3] spi: cadence-quadspi: Add support for device reset
Date: Wed, 20 Nov 2024 17:39:48 +0530
Message-ID: <20241120120951.56327-1-srikanth.boyapally@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: srikanth.boyapally@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: bda47f70-c284-4dfc-f759-08dd095c5396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?onCJN4Kux9ZdGA0gOBElnXspgemCX+IYOkQwR2HwYEB3zvA7WbPYVFQ//Zlx?=
 =?us-ascii?Q?RKsJSKwBi5FCVOOjcLl9LlCp+f5JZR2HO8NW0qeBAasK55Aqyl2aEu20BIlG?=
 =?us-ascii?Q?0Ctn1Pf/EVskikWnv3Po4CfmjVYJ3ks3ib02Hc/5X45l+7W+p/9ybtn5Ywtu?=
 =?us-ascii?Q?Bkg+Dx6wBLIlJPZ2zLARuDU8aA3kgXbEVJcxb1ZS7htEosDrgPBnL2+h4F1h?=
 =?us-ascii?Q?yN4FFZ/QCarA58TbHuElamaWjkCJYWcg66vBGrpakMsUqvAJIFxYKh6jN+GQ?=
 =?us-ascii?Q?Iu+pljDgwHNrsH9K6KKwfqCN0RHEtQENUtaYTCObXe4oHBAzNYP2qYnHZVEb?=
 =?us-ascii?Q?PNJsqW7K3lVeSsABVSAHjoJNLZfQfrxB7aacz1iovxh5Hy7W4ZMk1WVga9ja?=
 =?us-ascii?Q?atjVfznNE3qlQ3+s9AXNH2r+7coq8EPuZBxAHD04R8a9jBnZNwCw00VlzBZr?=
 =?us-ascii?Q?K+1+U3QYvMLiCJYk+P+Op2qpNBjNSCG38do5vQdSgEfDY85X2hfERA0XpJjD?=
 =?us-ascii?Q?JryUajvkP+r+/hLAtPaao5ISat3ddlIbDaC9N9jM5jFvGKz6k2G5FhZDrj6q?=
 =?us-ascii?Q?gdBJKOdReWtOHhti5GxqwgbG9lFLm01MOIeTBfwNXWzu0VOdKA1qi1RbKZ4k?=
 =?us-ascii?Q?/2zfmy4vQU3rkJFJZ0msyZuApAynfLVMvcyG1XEFNoEdeVIcxn5DFTVRnh81?=
 =?us-ascii?Q?+ThvDYkzK8MLoZZNvMmvCUlw9ShceDsWjdnsfhlOB59OMwBje+KVi21ajqbx?=
 =?us-ascii?Q?PKjQeYrmm2FdnxfCLqPXjHB/UzQCwUec/I4vkFATkOBnSa3i8UIriJiNHteC?=
 =?us-ascii?Q?Y/F70/jKEaQgdt8Zzjg6akNqiu3V0EF9oOXFTsr2FrHyI9POdg7AIXE0aHq2?=
 =?us-ascii?Q?xIufX0xmM9w8xvK6LmcnZMwpMurLhNVWfX5lMGMT+2PhHLlNRuRsK+SgoRvz?=
 =?us-ascii?Q?XZLI/S897xlGo+bSYbpBftmAv3WbqI2kNlGqePDWoljWlhq6L5cLnlHEYmYu?=
 =?us-ascii?Q?726/d2gKzc2VCmNIKOO7EgXoL+Sp5oTcwyCaJpPd4W6atQS4ZTIdMp86uWZj?=
 =?us-ascii?Q?LI1eDu7mzXoG5Ag9J2aMnpwvhDPUtsFebXbaNI8jPz5Jl9R0iIqHx2p9gho1?=
 =?us-ascii?Q?3tALnnx7uJ5fWqyZC1mSJ+W4f4Br0DRGiLEgFQRJ8HqQfKmqBMvViTZn92mS?=
 =?us-ascii?Q?hRP2IJSDxwZM44qlPRGv3qfWlXxHGyFYq5VE028faJnC/WnHxN9rLILq9VxT?=
 =?us-ascii?Q?Hyk8yLC0ECrfvnPfNV4iEkJPKvo2ipZtm2G9QO5E6E/rKdMNPokCf8uL4Ye7?=
 =?us-ascii?Q?fgJpGdki41nk8XWXB/InYlXD0puu8p2+x+5kpgmWHKRI5/6i0sCNxaLQrSsA?=
 =?us-ascii?Q?BHJMzCIS1FjMW0ZG8JIXKbuRqm0/G4QPh4oy/0Rhn+l6R/0/5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 12:10:29.9428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bda47f70-c284-4dfc-f759-08dd095c5396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250

Add support for device reset via OSPI on Versal Gen 2 platform.

Srikanth Boyapally (3):
  dt-bindings: qspi: cdns,qspi-nor: Add compatible string to support
    OSPI controller on Versal Gen2 platform
  spi: cadence-quadspi: Use quirks to set dma_set_mask instead of
    compatible string for 64-bit DMA support
  spi: cadence-quadspi: Support for device reset via OSPI controller

 .../bindings/spi/cdns,qspi-nor.yaml           |  1 +
 drivers/spi/spi-cadence-quadspi.c             | 47 +++++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.34.1


