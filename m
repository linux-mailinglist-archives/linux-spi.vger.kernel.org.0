Return-Path: <linux-spi+bounces-12335-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D2D195D3
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97D4F300B809
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A9126AA91;
	Tue, 13 Jan 2026 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ljNcXAz/"
X-Original-To: linux-spi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A5327B34D;
	Tue, 13 Jan 2026 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313813; cv=fail; b=nRQtQe/6COzvGkGjdK8NWQzI1D1HXeq47MOZZ++gMtRr2QnbnBHmbtKcWGsys3t/RLKIYvDXx5ezqyOkY3eP3gor6sfI3shMihm2uIhaBDCsBa53ZkvetHOKb02UCKwld3pD5T+PvTpKMeJwA+Vc+FDeOAOUNLyQANp3ku2uDGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313813; c=relaxed/simple;
	bh=DqWOJxi3JO8qhgjzQxEBgmAfuXe3vnDDBULRB0RULQ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KypZIa85LRcrbbRtoowuS3xdNll7JC6ax+YhS5nmY+0c5sXYFhw2eQMPuzRvICt9VeOuPP3nZu/4z5UG0Tnx3lg7O3mzFWIMOIeQ5bj7tYj7uy9F+U8vvV/fSPIIoO4KQ7XuSNa1km+NwJ/09wYUA0WJOVm29k60Ej1ldTv3fLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ljNcXAz/; arc=fail smtp.client-ip=52.101.62.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g49EVaenOCM13rfvnEdPTNJMZa33F6PRbqrbafsNK9Bx+wdxkiJ0y73O1sdq0rNdmtEZTbWVOjdpomqy0Yh4eXxWy2CraERyTm4uBjsrbcAkmi6fxMTxMvikX1ESiPe9CnqmyK8oynF6xKDXlzxKDGjvDQbU+mPxnySSmg3zyqNN9peennJhpiHcP9nOrpR/EHsKBf2xZP+Vwvusk9xedXnhCq3Y6X+dGe3greUUk5IEU7WjTciHqO0InbeixdZerMs6dXbI3eUhQNNtYWTTqnAaTaC077anvKXDaO/k2yRLPP3/3qMRfewI2PVXpubrLFtKvZpykRQPGfpT5747wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8xKPAfZ4ADRh+KaVpS3L1GdmwsjAVdfSJ/vHAjfprc=;
 b=tlQq9uI6XF9Ma+WZ7SoWnsSQ1krXhz9rYdLOog90QXxaba/BI/ROcEIPyZFaiqpBXCn4kv7JjQQiISX0jNPOZyojXo1Rf0JW8Sf7TvqJakMqZWvcgAJfhQUnOt8GUBhDRzADZBbst4gv/PnxHKTBldr+avpIJ/miqNRMqju4BTVJWjKpWYREgsrhUoE/FKoVueHxpqL+DaIorHS7GBd3JLpY5zBcUnfPmcNxrQKrzsbSlOI6GC1DhlPHgUmRogbzAyQXoT5bOmaMPqsDZ2S7+ISzv4fNQ6DfN/nVO2hcfRITgkbY4Q/J9lsmSjIiqkL4xLEhwWLvWI9yFZiHdS9qoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8xKPAfZ4ADRh+KaVpS3L1GdmwsjAVdfSJ/vHAjfprc=;
 b=ljNcXAz/OCXiNtK55f+cg/dAGWiDP1UU0LUMeNpy7Pzq8/spxtv4Oq+S54A+KXehublZa3dNKGr9ECrrZzqOZn5wGPDYNlP9LMr8EXIb3iu8F1sZwWPYXr4V5p8kvrsWOCkgCgcznl5LkAAzKldujmLkMbuMDo4BKRFN/Z/je8E=
Received: from BN9PR03CA0335.namprd03.prod.outlook.com (2603:10b6:408:f6::10)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:16:45 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::c8) by BN9PR03CA0335.outlook.office365.com
 (2603:10b6:408:f6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.8 via Frontend Transport; Tue,
 13 Jan 2026 14:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Tue, 13 Jan 2026 14:16:44 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:16:28 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:16:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 08:16:27 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DEGLoj2381510;
	Tue, 13 Jan 2026 08:16:22 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<mwalle@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
Subject: [RFC PATCH v2 00/12] spi: cadence-quadspi: add PHY tuning support
Date: Tue, 13 Jan 2026 19:46:05 +0530
Message-ID: <20260113141617.1905039-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: ea20bf2d-78c2-495d-a6cd-08de52ae614d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|34020700016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SG3N1gTk5YPjqv4KRoO25hYI2HUxgzf0fVab2uR/jiIgfaa04uLXAKr8bpLb?=
 =?us-ascii?Q?bzPEaNgblXyJotlFK/J+q6B1pwyyYbvOzq3xBL5wYAsMUfXSNhA+ADP95tVW?=
 =?us-ascii?Q?FDQM6PqtHO2uquAssh4U3nPbPUe7dBtNdpXMaE4bhGIESWM+4x11jcVG3+h6?=
 =?us-ascii?Q?0j1bTvoBzc1K8gLwG3dd7mALCpXfPRuZQspCrrY/XJnEKiC2XKFDawDEo+pJ?=
 =?us-ascii?Q?4lQtwsAfGlU8tZFDvQS6S8+USy7VP4YXs1UHzNTWl1ntb8ZNrwVhwq78KYIk?=
 =?us-ascii?Q?NdZi3qGboR2UWVj8gjjy5Q5Bae4FiGPUjSdCJERzc+ASCuDi7ZECvOGZmCu1?=
 =?us-ascii?Q?t1CHJxtTLgd4407krDzyoICNqLXzui/cWSa2geSmmvXKFcI9hnG75mNUL1T7?=
 =?us-ascii?Q?EFnyYUWKLKU5n3If4MSHJZMHTwOOWXpFuMzRVGNfwP+QZMggyB6gYoYauvsS?=
 =?us-ascii?Q?XcYbMjgjDeDGIpdykpiElSz8vtOpR1+S9VpLsn1D0dCXYUGKV0RIYI9bZF3K?=
 =?us-ascii?Q?j5343fzYtYgqvl58ySYEVeGRdHHKzkKYeLOjMKalSrSqVFXRI9uQpW9rAB2h?=
 =?us-ascii?Q?erGjO33Bu/dt132WRKKmWi//GoMoezLiD0OMTE5+107U05jSrMxnV9ChycHE?=
 =?us-ascii?Q?++f8dxKNtSJYnZzU/iVDusiBnMxjUqi4GMxWC5xUTfahTFUC5d4eXit88h8f?=
 =?us-ascii?Q?lh061jrgOgKQnO7peDv0C187E0nmwf7JZZ9/TYTh69H74t71WDX0Wmdnzbqd?=
 =?us-ascii?Q?5i554RQ0YBlu262orxaXg3uIJD1YQOdeUn1It3X0CJZDnSFIVPcfDrqoWu2L?=
 =?us-ascii?Q?Fh4QzyHD58Ct2qMMR62pTROIcMQ2+9KEuYUOy7yQ2LDw2KI8yveewYtQaN6k?=
 =?us-ascii?Q?R1OL5QFsyzBpe+kEJlZgUSBk0VJgfMWVqVDJvswPFQAYxVy6LfZNcvrhIMr4?=
 =?us-ascii?Q?eyqdVnW/Nev1yaOLZB911ENY/vY9M+ovUqXlwWHe7XThA176cxzqVTzbOLlb?=
 =?us-ascii?Q?iv6Qq2G1Vl4ZSX7sNilyxqZppKqdbeKqzWxpiOIL0QslogjivEMgAyglFdC0?=
 =?us-ascii?Q?wLIWK+g/xZYDOjRx2TI6n2rme+jPgTOrqFLI9yetgqpo+wosrfbptrSghTgs?=
 =?us-ascii?Q?vzFIANw7MLuXH3rlyEYVpnFhYR27tAqkDP8Ei6dixJUGruUDIhKYcS3il2av?=
 =?us-ascii?Q?fbRu1WVv/upx7n4iuc2vPjuaplBt9HTS1LRMTxNajgs0gO+YHWXlrNjHhJ7j?=
 =?us-ascii?Q?kbL1S7pS5TrqHAOkjVOLIQyFzwzILdmIbI0XISQPu4BjxHgN7vpnDPC7RYOP?=
 =?us-ascii?Q?wCGRTdJjfmu7V0xzV97KTH6OqNrB4tLPqB4EgzKcDJCKpQWebHg4KGB7D1ts?=
 =?us-ascii?Q?yOH4KR3ySUx0nbna1McMcXDieqcuzTuqETQCRIJezEklvOnzEQGHotefBDMV?=
 =?us-ascii?Q?GN25Oy9P90iYLVf++h00gJszRvYH+44DDWLh/r888ZQ122DVRkqgjW7PRIok?=
 =?us-ascii?Q?RYKV74ZaKWOOkLQx3K3F/Y1sGjLrnxQqPbyJuH3gR4kHyiesbZZiPVnZKIch?=
 =?us-ascii?Q?cCidOA+ulyM1FJT15a2tbLCFYO0mb9e4wDqMayPO?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(34020700016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:16:44.2263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea20bf2d-78c2-495d-a6cd-08de52ae614d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779

This series implements PHY tuning support for the Cadence QSPI controller to
enable reliable high-speed operations. Without PHY tuning, controllers use
conservative timing that limits the performance. PHY tuning calibrates RX/TX
delay lines to find optimal data capture timing windows, enabling operation up
to the controller's maximum frequency.

Background:
High-speed SPI memory controllers require precise timing calibration for
reliable operation. At higher frequencies, board-to-board variations make
fixed timing parameters inadequate. The Cadence QSPI controller includes
a PHY interface with programmable delay lines (0-127 taps) for RX and TX
paths, but these require runtime calibration to find the valid timing window.

Approach:
Add SDR/DDR PHY tuning algorithms for the Cadence controller:

SDR Mode Tuning (1D search):
- Searches for two consecutive valid RX delay windows
- Selects the larger window and uses its midpoint for maximum margin
- TX delay fixed at maximum (127) as it's less critical in SDR

DDR Mode Tuning (2D search):
- Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
- Finds TX boundaries (txlow/txhigh) at fixed RX positions
- Defines valid region corners and detects gaps via binary search
- Applies temperature compensation for optimal point selection
- Handles single or dual passing regions with different strategies

DQS Support:
- Adds optional DQS (Data Strobe) mode for improved timing margins
- Configures read data capture to use dedicated strobe signal

Patch description:
Infrastructure (1-5):
- Patch 1:   Add DT binding for spi-has-dqs property
- Patch 2:   Implement spi_mem_execute_tuning() API in SPI core
- Patch 3-5: Refactor and integrate tuning in MTD SPI-NAND/NOR layers and call
             tuning during probe

Cadence QSPI Implementation (6-12):
- Patch 6-8: Preparatory refactoring and DQS support
- Patch 9:   Add PHY tuning infrastructure with placeholders
- Patch 10:  Implement complete SDR/DDR tuning algorithms
- Patch 11:  Restrict PHY frequency to calibrated operations only
- Patch 12:  Enable PHY for direct memory-mapped reads and large writes

Testing:
This series was tested on TI's
AM62A SK with OSPI NAND flash and
AM62P SK with OSPI NOR flash:

Read throughput:
|-------------------------------------|
|           | without PHY | with PHY  |
|-------------------------------------|           
|OSPI NOR   | 37.5 MB/s   | 216 MB/s  |
|-------------------------------------|
|OSPI NAND  | 9.2 MB/s    | 35.1 MB/s |
|-------------------------------------|

Write throughput:
|-------------------------------------|
|           | without PHY | with PHY  |
|-------------------------------------|           
|OSPI NAND  | 6 MB/s      | 9.2 MB/s  |
|-------------------------------------|

Test log: https://gist.github.com/santhosh21/baab9e1c003c8e685dd6202f5c2f23de
Repo: https://github.com/santhosh21/linux/commits/phy_rfc_v2_review

Changes in v2:
 - Restructure the .execute_tuning() call from spi-mem clients instead of mtdcore
with best read_op and write_op (optional) passed
 - Add compatible-specific .execute_tuning() call which can be called by
spi_mem_execute_tuning() if exists
 - Handle tuning requirement check by controller instead of spi-mem clients
 - Add support to write the phy_pattern to cache if relevant write_op is passed
or get the partition offset which contains the phy_pattern
 - Add tuning algorithm for DDR mode
 - Add support for DQS
 - Restrict PHY frequency to tuned operations
 - Link to v1: https://lore.kernel.org/linux-spi/20250811193219.731851-1-s-k6@ti.com/

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Pratyush Yadav (1):
  mtd: spi-nor: extract read operation setup into helper

Santhosh Kumar K (11):
  spi: dt-bindings: add spi-has-dqs property
  spi: spi-mem: add controller tuning support
  mtd: spinand: perform controller tuning during probe
  mtd: spi-nor: perform controller tuning during probe
  spi: cadence-quadspi: move cqspi_readdata_capture earlier
  spi: cadence-quadspi: add DQS support to read data capture
  spi: cadence-quadspi: read 'has-dqs' DT property
  spi: cadence-quadspi: add PHY tuning infrastructure
  spi: cadence-quadspi: implement PHY tuning algorithm
  spi: cadence-quadspi: restrict PHY frequency to tuned operations
  spi: cadence-quadspi: enable PHY for direct reads and writes

 .../bindings/spi/spi-peripheral-props.yaml    |    6 +
 drivers/mtd/nand/spi/core.c                   |   14 +
 drivers/mtd/spi-nor/core.c                    |   71 +-
 drivers/spi/spi-cadence-quadspi.c             | 2060 ++++++++++++++++-
 drivers/spi/spi-mem.c                         |   34 +
 include/linux/spi/spi-mem.h                   |    5 +
 6 files changed, 2102 insertions(+), 88 deletions(-)

-- 
2.34.1

