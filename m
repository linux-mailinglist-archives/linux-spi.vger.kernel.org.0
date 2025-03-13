Return-Path: <linux-spi+bounces-7126-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B2AA5FF5C
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F5D7A704E
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 18:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8F1EBA09;
	Thu, 13 Mar 2025 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uLaYrYGi"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B971CAA6E;
	Thu, 13 Mar 2025 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890915; cv=fail; b=K0oFNSSKlXqIwjS3OM1Gt/ceJ13Gg2KNV8kNDduv1MkCRBsRNZCTWLqjjEweNiXxyRClcECm3AF7USc6qMdG3jQPNXBPpcKjWfGXSpmN9fTjZbbCiZc/sfPrCA1M4MVZq7zvNuqDzpU7A+VY/dx56oK2r7V41T0rlwIhhPWjOQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890915; c=relaxed/simple;
	bh=0OxZh1SYFCmWhgSwvuZr6KpInYaegb2X53US5Ujf9CA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dpbuCJ+Tas+enMLVKauGq86AirLhnG8JDHDg6lNHyQ/E7fLRI+EbsktAGOCq67+SSKICZUZOtUAbzAtl7o+trv7AS9sUJvKLUtPkyk5NzZjpQC1h0LXp/AfMAeNk6Vg+DuHzF5Fwv+zWa6Msf3OeXQalktHw2Ls4GySnzTqvf48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uLaYrYGi; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfELhR73D3bfz+I0v49yAcz1CRL81AELPpvjxLqn98qDyxwHpB/4nWaA2sIZgVf+sFVHw9MkoLxC5IR2wFyKN46vNooXgVmrDOPo8EHA/zk0YPj05w91nikSRZ0ro1TNlf49Rj4Ogf7vQzpORTLAyYw5HPvvqI3fSJReoOhPAWV1gbTB0uNrrgeRQw+jCxD+SyVpyVZS2E5FRpaA3Pw6HbhanMobfUZYGtMwOx5tZvUH/L3j2zswlLCAEeNCPfJcSN0Kz0xFock60uD/AUtlyyABQN9omT84kd8x5PMmiSEBAitvrH7jXNSY+DkMPf0NJd4nU1FwARtM+czsAsrA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33j75SVLPOYq8kZS3B+LSq6VNfTJwRlbIUo/UWr8H/Q=;
 b=CidT9QxKclvYpdnu9Q0f85zZfBL1YB8xTrLLrtcqa1OnCtQW575MLkyx/grm2nFaYDK2dveGKgi1M1E4jYEE3ctLl8W0mTKhCQOMsWbA2FvtBVz8tlxYCanXNM/mGakYfi94fIQl40AxGZDkEfqTVjkB3U1gPtRhrobDbpX51urWy0rXVoa45SnPJcPZo21sgBSOa/4FwiNVJUXWmXiy4i8yZ1Uz4LNDilYqtQ1b0FO6BYnQIY/7uvgk/iDwrDDAzmXnox8bkLEjtM5k1covK4E0lUB2DOqg0r71mwoadBXTmbbVupqLorDbm9c+28vPebzg3ZBHU6ZJ8A951tCIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33j75SVLPOYq8kZS3B+LSq6VNfTJwRlbIUo/UWr8H/Q=;
 b=uLaYrYGiawKd1BxJngEmHt58lDxfoTeoeZIdXwxos4iND7/5IEOa/xi1lpH5PFTRgIVgaUcJ+5jPjxiiXk3sxTiD0HwGAIICewID7X0leSc/qlkyRKNrPNd4AW6Vj2OLJeEsDnuMTfrkm1izHf42pwCeRIuIv8QEg4rgzOu3q04=
Received: from SA9PR11CA0006.namprd11.prod.outlook.com (2603:10b6:806:6e::11)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 18:35:06 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::47) by SA9PR11CA0006.outlook.office365.com
 (2603:10b6:806:6e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 18:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 18:35:05 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 13:35:02 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <krishnamoorthi.m@amd.com>,
	<akshata.mukundshetty@amd.com>
Subject: [PATCH 00/10] spi: Add driver to support AMD eSPI controller
Date: Fri, 14 Mar 2025 00:04:30 +0530
Message-ID: <20250313183440.261872-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 7721f096-ef6c-430d-7ee4-08dd625dc627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9MdU1KkbdxlqUcnF7R6QoUGZb8N6UnyIWlnLBdYyiKMnkaoEtc7EF29cpwJI?=
 =?us-ascii?Q?R3DthGUFgeUKNCl6MnFv5nfTrBmg0J/em6sdMFqp5BI7+yDmO8yvO4yeF+uv?=
 =?us-ascii?Q?HnD6tcVg35YvKIBIDgwIAcQ5rwpZki6z+jV0qqEnv6B0G1Fa6uRDXzsBQcjw?=
 =?us-ascii?Q?7E0uVbc4QJUucOYTTccqdEi+CeAwcZsch0uodhyY+xBQnKQsHkl+pKNqXEoG?=
 =?us-ascii?Q?xFwvzsBWvANjX/r5T1habmc1NsUvI20jYzshIByTJs8Jy6DqzK9q4lmIeAmY?=
 =?us-ascii?Q?64hR4ChwfqFLbxP0s70Po7Z5l0xxEnHMEzJwwsZPL4wjbU2toqQhrL90gqg3?=
 =?us-ascii?Q?xcABm3pJjgTDmFBZc2BIC5MiuVkHDmV+DjemO6Z9eM4nLVvABIuqCBPo2BZS?=
 =?us-ascii?Q?2KciHClbSP0OBrhGKlZMz384OZ6Js0T47zWu5kW43vG5vIdmxE08zV0Tf0Tl?=
 =?us-ascii?Q?ECI3d4pEkEULQB2IppDJyzn8BQZQHzQo3ysL6NP2GGeHB0WPzXDBqSfcPkBe?=
 =?us-ascii?Q?PEvuNs0d1SYIHR1bqgC0T5yWMtKfDM1xXop/vp3l3IjiO+bh0xVzkx34TNbz?=
 =?us-ascii?Q?jHa7IDdhniyyPI3SDKyQZ6sSEqqODEzuOaeU/6dc6iIYjyMbyczX4rTcoDFS?=
 =?us-ascii?Q?Y2/I2b5viJqRPxYfoxaP6Lf4zdUxwLLxzbGkd1dv3rvk81bGp6+H4hvMPolS?=
 =?us-ascii?Q?t0ysDcvNxaioJTPhA1bpCWw+fgsxLhLX05KiCdxujpGaIlz/7xNJ9f343Ni/?=
 =?us-ascii?Q?Pu153urzranCO9xAgcoF1mi6eUpd/he9fO0oOhJ+X1OCi2a6XSHrzr9H6lXz?=
 =?us-ascii?Q?F9HYw4R8MjOTllQRyX7O34NarNb5aR1SOAnTgYoCNXFCGrf7IE7DCVJQTQqK?=
 =?us-ascii?Q?5ucpwkw+G1I2Pk1vrPdUChTsB5STSGMd6+EPZzR6gvhoYTr3nHIVRb0Owbnb?=
 =?us-ascii?Q?Ued3FHf4xAZKy1OkHywihpIuOkKMkROtCgMicuMr9QGkc/OZb3mDN5TxslSg?=
 =?us-ascii?Q?jMyPiZHJSIOlqbBOILzYaW7+NiUWnsiWetrBEIAG5WMaXxeHpUrmblMqT19f?=
 =?us-ascii?Q?0sKUINF4WHoCjguWIMqKqNEnNdC66jsZch2LI573VjawDXKGZoIlqPWx8vh0?=
 =?us-ascii?Q?vRbzf2xiBLkfMxipgPNgMYJ3/gmO8XNeJdEu5CWOJav1e8icdWutE60WM+sr?=
 =?us-ascii?Q?lbG1BumLGMOoq9H4ap6yVipLtyyvu7zl2tqq29Wiqw24HCUOV/49IzSbT9NA?=
 =?us-ascii?Q?IcfPaBRkBdm3DgL8h7PHzTnhZlCWnf4d6+H81Zsybl1hW2U0T2YzxM/WKdhK?=
 =?us-ascii?Q?OxmHni3ByAsyzWPoLjNjZ4/NqH0bruA+pA/M07Zg6dMzycW48jYYXvLOiGwG?=
 =?us-ascii?Q?+Ynch7fkGaXFniHHHrAMVLFnJVpXqm/piHZpX0bRPwrxW7hnhpfCfWonYSuk?=
 =?us-ascii?Q?q3Y0lqJZWY77AGWRxBaW/R6/S1a1UQWMG3U/WNLtCswlqh0EBFZXdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:35:05.1967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7721f096-ef6c-430d-7ee4-08dd625dc627
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278

The eSPI protocol serves as a communication interface between the main
processor and peripheral devices in computer systems. It offers several
advantages over the traditional LPC bus, including higher data transfer
rates, increased scalability and improved system management capabilities.
The eSPI protocol supports multiple channels, each serving a specific
purpose in the communication process.

AMD SOCs feature multiple SPI controllers, including a dedicated eSPI
controller. This controller is responsible for managing the communication
between the main processor and peripheral devices using the eSPI protocol.
It provides support for various channels, including Peripheral channel(PC),
Virtual Wire(VW), Out-Of-Band(OOB) message, and Flash access channels.

This patch series implements new AMD eSPI driver aims to comprehensive
support for the eSPI protocol, including initialization of eSPI controller
and slave devices. It also adds functionality for channel-independent eSPI
commands and support for I/O and MMIO read/write operations on PC
channels.

Raju Rangoju (10):
  spi: espi_amd: Add AMD eSPI controller driver support
  spi: espi_amd: Add eSPI set config IOCTL command
  spi: espi_amd: Add eSPI get config IOCTL command
  spi: espi_amd: Add eSPI inband-reset IOCTL command
  spi: espi_amd: Add eSPI set IO mode IOCTL command
  spi: espi_amd: Add eSPI set channel IOCTL command
  spi: espi_amd: Add eSPI set frequency IOCTL command
  spi: espi_amd: Add support for IO/MMIO configuration
  spi: espi_amd: Add eSPI PC channel IO read/write IOCTL commands
  spi: espi_amd: Add eSPI PC channel MMIO read/write IOCTL commands

 MAINTAINERS                  |    6 +
 drivers/spi/Kconfig          |   10 +
 drivers/spi/Makefile         |    2 +
 drivers/spi/espi-amd-core.c  | 1215 ++++++++++++++++++++++++++++++++++
 drivers/spi/espi-amd-dev.c   |  584 ++++++++++++++++
 drivers/spi/espi-amd-err.h   |   50 ++
 drivers/spi/espi-amd-slave.h |  109 +++
 drivers/spi/espi-amd.h       |  416 ++++++++++++
 8 files changed, 2392 insertions(+)
 create mode 100644 drivers/spi/espi-amd-core.c
 create mode 100644 drivers/spi/espi-amd-dev.c
 create mode 100644 drivers/spi/espi-amd-err.h
 create mode 100644 drivers/spi/espi-amd-slave.h
 create mode 100644 drivers/spi/espi-amd.h

-- 
2.34.1


