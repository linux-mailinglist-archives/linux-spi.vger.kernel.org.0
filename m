Return-Path: <linux-spi+bounces-12345-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 453FDD19731
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67AFE305C625
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D1286881;
	Tue, 13 Jan 2026 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HweBAQIh"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E2F2836A0;
	Tue, 13 Jan 2026 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313885; cv=fail; b=AJ8RSFaYbqWhQfzYXDOYMa9LWMd6O2OtyjOITJWFiKyjJfB5I6M+rBrMj13rrG028UHMie4z7/2Qpz4GtS1n/yNn8QE9QDn90u6183cSOahMT+70NnfPWXFDqQkO9p5wj52/ddzNLMM1jHQdzPx8K9Fc8QnIKUUDebiOetrn3x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313885; c=relaxed/simple;
	bh=7TIe8V3M53Buo3P5dM1d0Awqr6O/pV2Y+QByqvcwv5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvd0Gmh4mtbXz5EonC0N8iENQSWGwd7l+X6lGVLVcEPxWBXtW5XwXRl2M8EDzc8xZkERJw46Mp7EQnGhXRC92L9Yves85vDn9nf5RnRu+GHS3k9I/1rAKkFdHmeY2eidD63+Rf1m5Cpgw1r0Vk+q7boRblCjq8kVi9+Wlw/kuX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HweBAQIh; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwU/x4Q326D1IJeGE1eiFSXJQIZV7t2OEdMxSBgfGAzCYh2K/QGM6012u+E8+UJq+9cV2R9TXW3WNl+Y98YF9bAm+ONOSTZZdqwuBEPxqWK7oalGrUW7rd50baagM3j+BfUVWQkxixHVg2Ben+4U4LHzIoL2GozH8b3iiZ3kDhAmfgbTGw2904GqMnIkEZWVFt9E644NzCSu14ZlpqysFZSPavM+hi87KHgYxyy6URY0PdxTS5bkE4JGN20cXJuL5CzdSZ7zShHuidAHftfX/JiCLojDqcu8CaV/+0TB4ISkEtvU1YDYs5P1wJghr14kA7uxOnw5Hdzucqm1SgEHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxJBH1r6uYIEYnuL6PGHNyPaHMwQhTewWXMpO/0GzSA=;
 b=rkuDE0mTWUvVDDtXVmVbBoi0ck8bB4mBi9RYzi23GY6hJfwAMc4V0uxPZ75daJX4Lac2tFacMJvp8xZON4C9KrrcmN5GVtb6NbomKm5CwMPpYV+EwpDseUs7eJOlMScAp5rRvYq66C3dZjIB5yAlwbnvjKNV2jO2PrgtC40VPMRJB3U7vRTk7a2V8V3tWowyIdT5Hm67PaYZaim8yHxELwEwkAgrN8M9VCeBi9YY1WazHB0E/EJW3p4RLVp1l8s63BVQq1ZCHc2eh62JB2rP7KRaxQV11w1zPlISbr6duW8eP2SqP2cYTY5DNnA6m3ffXrm38gd79ZLWvL8gSCSagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxJBH1r6uYIEYnuL6PGHNyPaHMwQhTewWXMpO/0GzSA=;
 b=HweBAQIhO5XM7CcQ4iQM3oDFT7TjkcZjXiQ5wwNj96UPOs9H7K8J6rlWjICXYHWwJJXXxdKYX3ZPfwi2EIlM6Sup0v6ApotkXjljsYwHxXDkEGcp11nGcm2aPufCPYGpiAFbLQ1MC9GgArCk1d7AvM86/H5KcFNdY774pgIOuRQ=
Received: from CH0PR03CA0251.namprd03.prod.outlook.com (2603:10b6:610:e5::16)
 by CO1PR10MB4674.namprd10.prod.outlook.com (2603:10b6:303:9c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:17:59 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::d2) by CH0PR03CA0251.outlook.office365.com
 (2603:10b6:610:e5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Tue,
 13 Jan 2026 14:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 14:17:57 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:17:25 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:17:24 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 08:17:24 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DEGLot2381510;
	Tue, 13 Jan 2026 08:17:19 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<mwalle@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
Subject: [RFC PATCH v2 10/12] spi: cadence-quadspi: implement PHY tuning algorithm
Date: Tue, 13 Jan 2026 19:46:15 +0530
Message-ID: <20260113141617.1905039-11-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113141617.1905039-1-s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CO1PR10MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f2d51e-96bb-4a06-60c7-08de52ae8cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmtldVNWZlZxM21oeWI5Z0lVUlFHdGpPYW5rUXMwL1ZUS09zTDV6V3J6S0Qx?=
 =?utf-8?B?QlljcEEyQjNPNHI1MDU3TjdxbFZ6dWhZZ0I0dkcreE1OYm9zaTlvTGEraEpR?=
 =?utf-8?B?dklZbDZ2K2FHTHBjcEpDTDEwK2ExOE1VNnVCYlBEL0l1QlNHellhbVdsSktz?=
 =?utf-8?B?VmdpdDN2VDczRGdHMitlOTc4anVaTXJIMWhmaXk0N0JaREx4UUZ3K2JOU2xQ?=
 =?utf-8?B?VWI4aVk2aEthcHhyU01DSmdwbVFGKzVwK0wySUsrZXVTa0VxaUdaMi9VU2RN?=
 =?utf-8?B?S0NHUlo2ZzZ0NW1HTnJMTEFIakdTWmpxbDNrK0hPQVlXZGYyWVh5aUhzV2h5?=
 =?utf-8?B?eks2V2tvSFdMWGR5WUVEd0o5amdkVUVVTVowQUwxYW13R3pOS2N5eG9PNENC?=
 =?utf-8?B?VUpWRTdYb2dJVVBnTXRMV1FJL29zQkZHOTRJMTRPdmM3WFREUmZmSjdXMmtP?=
 =?utf-8?B?Z3VoSStseEpRc3lNNHpoeTliRGthU3ZucWNwN29SbEJmSTlkT0U5U2hsTEd1?=
 =?utf-8?B?VWFKWWZmNlh3dE00MnQ0b1ZQaXkvY2lCQXpweHdGREY1Z2hZNzVMamdQZ1I1?=
 =?utf-8?B?QnZpWW9MWjZaa0FhYWRKZ0R1V0tIZEJuSm5QSlpacTg1OUhqU0UrbkpPcEdR?=
 =?utf-8?B?R01QRy9XbzFxOFBpU0YydWRmTkJIejF3TllVRHV0VkM3QVpabmx4cnQwaWRB?=
 =?utf-8?B?bWlEd3hOb0plYWFyeXZ1Z01KR2w5WWs2UHo2R0hKc3ZnUXZUNWh0K3lQNVFU?=
 =?utf-8?B?N0hHTkR5SERPNnhqaTd0dmx3TEp4U1hpMDVuRktZK1lWYWIxK3ZRVGJ4UEEy?=
 =?utf-8?B?eHNyVTlvOEZIZXZLNFpXTmhGZDVoYitnSFVIRGpTK0tvS2wzNVJVaHBpNnBh?=
 =?utf-8?B?Q3p3TjJUOGdCQnBJU1hGdHREa0RqWVZFSy95SHpLd2hnNE8vMEhLRmJXenNV?=
 =?utf-8?B?cHM5QUxwKzN4WjcxZ0NhK0JsRmpMdlEyTlZZU3BvQXpvaTJqMzFhYlFXRzBP?=
 =?utf-8?B?WC9za1hQTDFuMDYrL1lXUnRZbjd1RXNXdmp1V3NscG9oM2RNa3ovY2xQLysy?=
 =?utf-8?B?ZklNL1ZDWnVZRjZ0dmJ5SjU5eXdoNjErMWhMS0FVc09yay9qeFJLc2oyT1Vy?=
 =?utf-8?B?V1NOL3NpV0cxWTIzNGJRUzJjTWJUSEt0eTZJU1NKdEpyWXlsNCt0Q0cwSTFx?=
 =?utf-8?B?WXNJUkxyNnBWbkNnSnZIWEtxUGhpTUtYRHUyU2M5TnNISzVaNnhpSlp2VUpv?=
 =?utf-8?B?b3RxanFqb1BwcTZDWHdPS3NiREdHajVIeVZ1MzhPVWdvMGhyZGhMY043d20z?=
 =?utf-8?B?VHRSa1lqMUMreCtVYlJtSnowZFo0cmVCd0pnVlBIZ1ZlejlZWUZKdTZEakhN?=
 =?utf-8?B?aVE1dUs3UThUdjVmNmNxOGJmUjNFWnFiZ0hpemNwc05QWGpQODVJK3pjcHNl?=
 =?utf-8?B?cFRTNFIzZDYrNys3T1QrdW03SjM4UkZNTjJTR09ManFLV3U3MTArS0VCQ0t1?=
 =?utf-8?B?Nk02S25uVGgwTVVzYld3RHhQN3VQWnhiaDVNNEpSa0Z0OTkySHlyUEZkZGVG?=
 =?utf-8?B?MVkzWElCU0QxM0dqZEVVWWNYc1dzbUsySnd5L0VxQlRvTHBBdGJNcmRMN0N1?=
 =?utf-8?B?UTRsMjE3MEM3NlE2VXBKaWFRNThqUW1vNU5SVmxNbUR4VGo1bUhySGlIcFRr?=
 =?utf-8?B?bUZlOTBBK0pIaUhRN0xoQk1seEhqWkNYaDZib1pwNmpPMktCLzlaZk5jSzJP?=
 =?utf-8?B?TjV4VEpCU1F5ZE1UWU91d0wwM21CTm9HVUluVTV6RkY3LzlZclFpWmFKU3oz?=
 =?utf-8?B?U0lHcEhBSlRSWlFVOHhnQnU1ZUxodTh1ckxhTmY2RHJJcGxDb0JmTU84RHJp?=
 =?utf-8?B?dk1wMldNemo2WmF6a2F2bEd5YnNMY1dWcmlIUDFBelhDdVQxeUJPdUQ5d1Ex?=
 =?utf-8?B?ME9NVkxhZmxlOFhuVXF3RnZnMkQ2bUwvNTB0cFR6SUFSODBNU3IyRTNuNEMv?=
 =?utf-8?B?dmpvZEJwaWFvci9aQ0QyTHBucXN2RU5jK2pnZDRzQ3ptbGR3c0g0ZEZsQXZX?=
 =?utf-8?B?aXBpblB3bkJVNXBYQXpjN2xPaGdpREFibnNtS1BEMzJFenY0eXJ1TWRxTjcz?=
 =?utf-8?Q?3A4eQu/UH7hMAJiaEArDpo8Ht?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:17:57.4990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f2d51e-96bb-4a06-60c7-08de52ae8cf8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4674

Implement PHY tuning for SDR and DDR modes. PHY tuning calibrates RX
and TX delay lines to find optimal timing for high-speed operation.

Add DLL management functions:
- cqspi_resync_dll(): Reset DLL and wait for lock
- cqspi_set_dll(): Configure RX/TX delays (0-127)

Add pre/post config functions that enable PHY mode during tuning and
restore normal operation afterward. PHY mode consumes one dummy cycle,
so adjust dummy count to maintain correct flash timing.

SDR tuning uses 1D search across RX delays at fixed TX. Search for
two valid windows at consecutive read_delay values, select the larger
window, and use the midpoint.

DDR tuning uses 2D search across RX and TX delays:
- Primary and secondary RX boundary searches at different TX values
- Binary search for gap boundaries within valid region
- Temperature compensation with midpoint calculation
- Systematic boundary searches using 4-step increments

The DDR algorithm finds the four corners of the valid region, identifies
gaps, calculates temperature-aware midpoints, and validates final settings.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 1519 ++++++++++++++++++++++++++++-
 1 file changed, 1513 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b8b0e85f4f68..930ea094f6d8 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -63,6 +63,12 @@ enum {
 
 struct cqspi_st;
 
+struct phy_setting {
+	u8			rx;
+	u8			tx;
+	u8			read_delay;
+};
+
 struct cqspi_flash_pdata {
 	struct cqspi_st	*cqspi;
 	u32		clk_rate;
@@ -73,7 +79,9 @@ struct cqspi_flash_pdata {
 	u32		tchsh_ns;
 	u32		tslch_ns;
 	bool		has_dqs;
+	bool		use_phy;
 	u8		cs;
+	struct phy_setting	phy_setting;
 	struct spi_mem_op	phy_read_op;
 	struct spi_mem_op	phy_write_op;
 };
@@ -137,6 +145,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_TIMEOUT_MS			500
 #define CQSPI_READ_TIMEOUT_MS			10
 #define CQSPI_BUSYWAIT_TIMEOUT_US		500
+#define CQSPI_DLL_TIMEOUT_US			300
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -150,12 +159,14 @@ struct cqspi_driver_platdata {
 /* Register map */
 #define CQSPI_REG_CONFIG			0x00
 #define CQSPI_REG_CONFIG_ENABLE_MASK		BIT(0)
+#define CQSPI_REG_CONFIG_PHY_EN			BIT(3)
 #define CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL	BIT(7)
 #define CQSPI_REG_CONFIG_DECODE_MASK		BIT(9)
 #define CQSPI_REG_CONFIG_CHIPSELECT_LSB		10
 #define CQSPI_REG_CONFIG_DMA_MASK		BIT(15)
 #define CQSPI_REG_CONFIG_BAUD_LSB		19
 #define CQSPI_REG_CONFIG_DTR_PROTO		BIT(24)
+#define CQSPI_REG_CONFIG_PHY_PIPELINE		BIT(25)
 #define CQSPI_REG_CONFIG_DUAL_OPCODE		BIT(30)
 #define CQSPI_REG_CONFIG_IDLE_LSB		31
 #define CQSPI_REG_CONFIG_CHIPSELECT_MASK	0xF
@@ -194,6 +205,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_READCAPTURE_BYPASS_LSB	0
 #define CQSPI_REG_READCAPTURE_DELAY_LSB		1
 #define CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
+#define CQSPI_REG_READCAPTURE_EDGE_LSB		5
 #define CQSPI_REG_READCAPTURE_DQS_LSB		8
 
 #define CQSPI_REG_SIZE				0x14
@@ -273,6 +285,27 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_POLLING_STATUS		0xB0
 #define CQSPI_REG_POLLING_STATUS_DUMMY_LSB	16
 
+#define CQSPI_REG_PHY_CONFIG			0xB4
+#define CQSPI_REG_PHY_CONFIG_RX_DEL_LSB		0
+#define CQSPI_REG_PHY_CONFIG_RX_DEL_MASK	0x7F
+#define CQSPI_REG_PHY_CONFIG_TX_DEL_LSB		16
+#define CQSPI_REG_PHY_CONFIG_TX_DEL_MASK	0x7F
+#define CQSPI_REG_PHY_CONFIG_DLL_RESET		BIT(30)
+#define CQSPI_REG_PHY_CONFIG_RESYNC		BIT(31)
+
+#define CQSPI_REG_PHY_DLL_MASTER		0xB8
+#define CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_LSB	0
+#define CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_VAL	16
+#define CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LEN	0x7
+#define CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LSB	20
+#define CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_3	0x2
+#define CQSPI_REG_PHY_DLL_MASTER_BYPASS		BIT(23)
+#define CQSPI_REG_PHY_DLL_MASTER_CYCLE		BIT(24)
+
+#define CQSPI_REG_DLL_OBS_LOW			0xBC
+#define CQSPI_REG_DLL_OBS_LOW_DLL_LOCK		BIT(0)
+#define CQSPI_REG_DLL_OBS_LOW_LOOPBACK_LOCK	BIT(15)
+
 #define CQSPI_REG_OP_EXT_LOWER			0xE0
 #define CQSPI_REG_OP_EXT_READ_LSB		24
 #define CQSPI_REG_OP_EXT_WRITE_LSB		16
@@ -321,6 +354,33 @@ struct cqspi_driver_platdata {
 
 #define CQSPI_REG_VERSAL_DMA_VAL		0x602
 
+#define CQSPI_PHY_INIT_RD			1
+#define CQSPI_PHY_MAX_RD			4
+#define CQSPI_PHY_MAX_DELAY			127
+#define CQSPI_PHY_DDR_SEARCH_STEP		4
+#define CQSPI_PHY_MAX_RX			63
+#define CQSPI_PHY_MAX_TX			63
+#define CQSPI_PHY_TX_LOOKUP_LOW_START		28
+#define CQSPI_PHY_TX_LOOKUP_LOW_END		48
+#define CQSPI_PHY_TX_LOOKUP_HIGH_START		60
+#define CQSPI_PHY_TX_LOOKUP_HIGH_END		96
+#define CQSPI_PHY_RX_LOW_SEARCH_START		0
+#define CQSPI_PHY_RX_LOW_SEARCH_END		40
+#define CQSPI_PHY_RX_HIGH_SEARCH_START		24
+#define CQSPI_PHY_RX_HIGH_SEARCH_END		127
+#define CQSPI_PHY_TX_LOW_SEARCH_START		0
+#define CQSPI_PHY_TX_LOW_SEARCH_END		64
+#define CQSPI_PHY_TX_HIGH_SEARCH_START		78
+#define CQSPI_PHY_TX_HIGH_SEARCH_END		127
+#define CQSPI_PHY_SEARCH_OFFSET			8
+
+#define CQSPI_PHY_DEFAULT_TEMP			45
+#define CQSPI_PHY_MIN_TEMP			-45
+#define CQSPI_PHY_MAX_TEMP			130
+#define CQSPI_PHY_MID_TEMP			(CQSPI_PHY_MIN_TEMP +	\
+						 ((CQSPI_PHY_MAX_TEMP -	\
+						   CQSPI_PHY_MIN_TEMP) / 2))
+
 /*
  * PHY tuning pattern for calibrating read data capture delay. This 128-byte
  * pattern provides sufficient bit transitions across all byte lanes to
@@ -1671,31 +1731,1478 @@ static int cqspi_phy_check_pattern(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static void cqspi_phy_set_dll_master(struct cqspi_st *cqspi)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_PHY_DLL_MASTER);
+	reg &= ~((CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LEN
+		  << CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LSB) |
+		 CQSPI_REG_PHY_DLL_MASTER_BYPASS |
+		 CQSPI_REG_PHY_DLL_MASTER_CYCLE);
+	reg |= ((CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_3
+		 << CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LSB) |
+		CQSPI_REG_PHY_DLL_MASTER_CYCLE);
+
+	writel(reg, reg_base + CQSPI_REG_PHY_DLL_MASTER);
+}
+
 static void cqspi_phy_pre_config(struct cqspi_st *cqspi,
 				 struct cqspi_flash_pdata *f_pdata,
 				 const bool bypass)
 {
-	/* Placeholder for PHY pre-configuration */
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+	u8 dummy;
+
+	cqspi_readdata_capture(cqspi, bypass, f_pdata->has_dqs,
+			       f_pdata->phy_setting.read_delay);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE);
+	reg |= CQSPI_REG_CONFIG_PHY_EN;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+	dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  reg);
+	dummy--;
+	reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+	reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  dummy);
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
+	cqspi_phy_set_dll_master(cqspi);
 }
 
 static void cqspi_phy_post_config(struct cqspi_st *cqspi,
 				  const unsigned int delay)
 {
-	/* Placeholder for PHY post-configuration */
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+	u8 dummy;
+
+	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
+	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
+		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
+
+	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
+	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
+	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE);
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+	dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  reg);
+	dummy++;
+	reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+	reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  dummy);
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+}
+
+static void cqspi_set_dll(void __iomem *reg_base, u8 rx_dll, u8 tx_dll)
+{
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg &= ~((CQSPI_REG_PHY_CONFIG_RX_DEL_MASK
+		  << CQSPI_REG_PHY_CONFIG_RX_DEL_LSB) |
+		 (CQSPI_REG_PHY_CONFIG_TX_DEL_MASK
+		  << CQSPI_REG_PHY_CONFIG_TX_DEL_LSB));
+	reg |= ((rx_dll & CQSPI_REG_PHY_CONFIG_RX_DEL_MASK)
+		<< CQSPI_REG_PHY_CONFIG_RX_DEL_LSB) |
+	       ((tx_dll & CQSPI_REG_PHY_CONFIG_TX_DEL_MASK)
+		<< CQSPI_REG_PHY_CONFIG_TX_DEL_LSB) |
+	       CQSPI_REG_PHY_CONFIG_RESYNC;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+}
+
+static int cqspi_resync_dll(struct cqspi_st *cqspi)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+	int ret;
+
+	ret = cqspi_wait_idle(cqspi);
+	if (ret)
+		return ret;
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_ENABLE_MASK);
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg &= ~(CQSPI_REG_PHY_CONFIG_DLL_RESET |
+		 CQSPI_REG_PHY_CONFIG_RESYNC);
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_PHY_DLL_MASTER);
+	reg |= (CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_VAL
+		<< CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_LSB);
+	writel(reg, reg_base + CQSPI_REG_PHY_DLL_MASTER);
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg |= CQSPI_REG_PHY_CONFIG_DLL_RESET;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+
+	ret = readl_poll_timeout(reg_base + CQSPI_REG_DLL_OBS_LOW, reg,
+				 (reg & CQSPI_REG_DLL_OBS_LOW_DLL_LOCK), 0,
+				 CQSPI_DLL_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	ret = readl_poll_timeout(reg_base + CQSPI_REG_DLL_OBS_LOW, reg,
+				 (reg & CQSPI_REG_DLL_OBS_LOW_LOOPBACK_LOCK), 0,
+				 CQSPI_DLL_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg |= CQSPI_REG_PHY_CONFIG_RESYNC;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg |= CQSPI_REG_CONFIG_ENABLE_MASK;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	return 0;
+}
+
+static int cqspi_phy_apply_setting(struct cqspi_flash_pdata *f_pdata,
+				   struct phy_setting *phy)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	unsigned int reg;
+
+	reg = readl(cqspi->iobase + CQSPI_REG_READCAPTURE);
+	reg |= BIT(CQSPI_REG_READCAPTURE_EDGE_LSB);
+	writel(reg, cqspi->iobase + CQSPI_REG_READCAPTURE);
+
+	cqspi_set_dll(cqspi->iobase, phy->rx, phy->tx);
+	f_pdata->phy_setting.read_delay = phy->read_delay;
+
+	return cqspi_resync_dll(cqspi);
+}
+
+static int cqspi_find_rx_low_ddr(struct cqspi_flash_pdata *f_pdata,
+				 struct spi_mem *mem, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->rx = CQSPI_PHY_RX_LOW_SEARCH_START;
+		do {
+			ret = cqspi_phy_apply_setting(f_pdata, phy);
+			if (!ret) {
+				ret = cqspi_phy_check_pattern(f_pdata, mem);
+				if (!ret)
+					return 0;
+			}
+
+			phy->rx += CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (phy->rx <= CQSPI_PHY_RX_LOW_SEARCH_END);
+
+		phy->read_delay++;
+	} while (phy->read_delay <= CQSPI_PHY_MAX_RD);
+
+	dev_dbg(dev, "Unable to find RX low\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_rx_low_sdr(struct cqspi_flash_pdata *f_pdata,
+				 struct spi_mem *mem, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	phy->rx = 0;
+	do {
+		ret = cqspi_phy_apply_setting(f_pdata, phy);
+		if (!ret) {
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+			if (!ret)
+				return 0;
+		}
+		phy->rx++;
+	} while (phy->rx < CQSPI_PHY_MAX_DELAY - 1);
+
+	dev_dbg(dev, "Unable to find RX low\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_rx_high_ddr(struct cqspi_flash_pdata *f_pdata,
+				  struct spi_mem *mem, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->rx = CQSPI_PHY_RX_HIGH_SEARCH_END;
+		do {
+			ret = cqspi_phy_apply_setting(f_pdata, phy);
+			if (!ret) {
+				ret = cqspi_phy_check_pattern(f_pdata, mem);
+				if (!ret)
+					return 0;
+			}
+
+			phy->rx -= CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (phy->rx >= CQSPI_PHY_RX_HIGH_SEARCH_START);
+
+		phy->read_delay--;
+	} while (phy->read_delay >= CQSPI_PHY_INIT_RD);
+
+	dev_dbg(dev, "Unable to find RX high\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_rx_high_sdr(struct cqspi_flash_pdata *f_pdata,
+				  struct spi_mem *mem, struct phy_setting *phy,
+				  u8 lowerbound)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	phy->rx = CQSPI_PHY_MAX_DELAY;
+	do {
+		ret = cqspi_phy_apply_setting(f_pdata, phy);
+		if (!ret) {
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+			if (!ret)
+				return 0;
+		}
+		phy->rx--;
+	} while (phy->rx > lowerbound);
+
+	dev_dbg(dev, "Unable to find RX high\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_tx_low_ddr(struct cqspi_flash_pdata *f_pdata,
+				 struct spi_mem *mem, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->tx = CQSPI_PHY_TX_LOW_SEARCH_START;
+		do {
+			ret = cqspi_phy_apply_setting(f_pdata, phy);
+			if (!ret) {
+				ret = cqspi_phy_check_pattern(f_pdata, mem);
+				if (!ret)
+					return 0;
+			}
+
+			phy->tx += CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (phy->tx <= CQSPI_PHY_TX_LOW_SEARCH_END);
+
+		phy->read_delay++;
+	} while (phy->read_delay <= CQSPI_PHY_MAX_RD);
+
+	dev_dbg(dev, "Unable to find TX low\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_tx_high_ddr(struct cqspi_flash_pdata *f_pdata,
+				  struct spi_mem *mem, struct phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->tx = CQSPI_PHY_TX_HIGH_SEARCH_END;
+		do {
+			ret = cqspi_phy_apply_setting(f_pdata, phy);
+			if (!ret) {
+				ret = cqspi_phy_check_pattern(f_pdata, mem);
+				if (!ret)
+					return 0;
+			}
+
+			phy->tx -= CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (phy->tx >= CQSPI_PHY_TX_HIGH_SEARCH_START);
+
+		phy->read_delay--;
+	} while (phy->read_delay >= CQSPI_PHY_INIT_RD);
+
+	dev_dbg(dev, "Unable to find TX high\n");
+	return -ENOENT;
+}
+
+static int cqspi_phy_find_gaplow_ddr(struct cqspi_flash_pdata *f_pdata,
+				     struct spi_mem *mem,
+				     struct phy_setting *bottomleft,
+				     struct phy_setting *topright,
+				     struct phy_setting *gaplow)
+{
+	struct phy_setting left, right, mid;
+	int ret;
+
+	left = *bottomleft;
+	right = *topright;
+
+	mid.tx = left.tx + ((right.tx - left.tx) / 2);
+	mid.rx = left.rx + ((right.rx - left.rx) / 2);
+	mid.read_delay = left.read_delay;
+
+	do {
+		ret = cqspi_phy_apply_setting(f_pdata, &mid);
+		if (!ret)
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+		if (ret) {
+			/* The pattern was not found. Go to the lower half. */
+			right.tx = mid.tx;
+			right.rx = mid.rx;
+
+			mid.tx = left.tx + ((mid.tx - left.tx) / 2);
+			mid.rx = left.rx + ((mid.rx - left.rx) / 2);
+		} else {
+			/* The pattern was found. Go to the upper half. */
+			left.tx = mid.tx;
+			left.rx = mid.rx;
+
+			mid.tx = mid.tx + ((right.tx - mid.tx) / 2);
+			mid.rx = mid.rx + ((right.rx - mid.rx) / 2);
+		}
+
+		/* Break the loop if the window has closed. */
+	} while ((right.tx - left.tx >= 2) && (right.rx - left.rx >= 2));
+
+	*gaplow = mid;
+	return 0;
+}
+
+static int cqspi_phy_find_gaphigh_ddr(struct cqspi_flash_pdata *f_pdata,
+				      struct spi_mem *mem,
+				      struct phy_setting *bottomleft,
+				      struct phy_setting *topright,
+				      struct phy_setting *gaphigh)
+{
+	struct phy_setting left, right, mid;
+	int ret;
+
+	left = *bottomleft;
+	right = *topright;
+
+	mid.tx = left.tx + ((right.tx - left.tx) / 2);
+	mid.rx = left.rx + ((right.rx - left.rx) / 2);
+	mid.read_delay = right.read_delay;
+
+	do {
+		ret = cqspi_phy_apply_setting(f_pdata, &mid);
+		if (!ret)
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+		if (ret) {
+			/* The pattern was not found. Go to the upper half. */
+			left.tx = mid.tx;
+			left.rx = mid.rx;
+
+			mid.tx = mid.tx + ((right.tx - mid.tx) / 2);
+			mid.rx = mid.rx + ((right.rx - mid.rx) / 2);
+		} else {
+			/* The pattern was found. Go to the lower half. */
+			right.tx = mid.tx;
+			right.rx = mid.rx;
+
+			mid.tx = left.tx + ((mid.tx - left.tx) / 2);
+			mid.rx = left.rx + ((mid.rx - left.rx) / 2);
+		}
+
+		/* Break the loop if the window has closed. */
+	} while ((right.tx - left.tx >= 2) && (right.rx - left.rx >= 2));
+
+	*gaphigh = mid;
+	return 0;
+}
+
+static int cqspi_get_temp(int *temp)
+{
+	/*
+	 * TODO: Implement temperature sensor reading for DDR PHY tuning.
+	 *
+	 * The DDR tuning algorithm uses temperature compensation to adjust
+	 * the final tuning point based on current die temperature. The valid
+	 * timing region shifts with temperature variations, and this offset
+	 * helps maintain optimal settings across the operating range
+	 * (-45°C to 130°C).
+	 *
+	 * This function should:
+	 * - Read the SoC die temperature from the thermal sensor
+	 * - Populate the temp parameter with temperature in degrees Celsius
+	 * - Return 0 on success, negative error code on failure
+	 *
+	 * Until implemented, the tuning algorithm falls back to assuming
+	 * room temperature (45°C) for temperature compensation calculations.
+	 */
+
+	return -EOPNOTSUPP;
+}
+
+static inline void cqspi_phy_reset_setting(struct phy_setting *phy)
+{
+	*phy = (struct phy_setting){ .rx = 0, .tx = 127, .read_delay = 0 };
 }
 
 static int cqspi_phy_tuning_ddr(struct cqspi_flash_pdata *f_pdata,
 				struct spi_mem *mem)
 {
-	/* Placeholder for DDR mode PHY tuning algorithm */
-	return 0;
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	struct device *dev = &cqspi->pdev->dev;
+	struct phy_setting rxlow, rxhigh, txlow, txhigh;
+	struct phy_setting srxlow, srxhigh;
+	struct phy_setting bottomleft, topright, searchpoint;
+	struct phy_setting gaplow, gaphigh;
+	struct phy_setting backuppoint, backupcornerpoint;
+	int ret, tmp;
+	bool primary = 1, secondary = 1;
+
+	/*
+	 * DDR tuning: 2D search across RX and TX delays for optimal timing.
+	 *
+	 * Algorithm: Find RX boundaries (rxlow/rxhigh) using TX window search,
+	 * find TX boundaries (txlow/txhigh) at fixed RX, define valid region,
+	 * locate gaps via binary search, select final point with temperature
+	 * compensation.
+	 *
+	 *              rx
+	 *          127 ^
+	 *              |                                 topright
+	 *              |                                    *
+	 *              |       xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *              |       xxxxxxxxxxxxx     ++++++++++++
+	 *              |       xxxxxxxxxxxxxx     +++++++++++
+	 *              |       xxxxxxxxxxxxxxx     ++++++++++
+	 *              |       xxxxxxxxxxxxxxxx     +++++++++
+	 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+	 *              |       xxxxxxxxxxxxxxxxxx     +++++++
+	 *              |       *
+	 *              |  bottomleft
+	 *              -----------------------------------------> tx
+	 *              0                                      127
+	 */
+
+	f_pdata->use_phy = true;
+
+	/* Golden rxlow search: Find lower RX boundary using TX window sweep */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |       xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       |xxxxx|xxxxx     +++++++++++++
+	 *              |       |xxxxx|xxxxxx     ++++++++++++
+	 *      search  |       |xxxxx|xxxxxxx     +++++++++++
+	 *      rxlow --------->|xxxxx|xxxxxxxx     ++++++++++
+	 *              |       |xxxxx|xxxxxxxxx     +++++++++
+	 *              |       |xxxxx|xxxxxxxxxx     ++++++++
+	 *              |       |xxxxx|xxxxxxxxxxx     +++++++
+	 *              |       |     |
+	 *              --------|-----|----------------------------> tx
+	 *              0       |     |                          127
+	 *                  txlow     txlow
+	 *                  start     end
+	 *
+	 *      |----------------------------------------------------------|
+	 *      | Primary | Secondary | Final                              |
+	 *      | Search  | Search    | Point                              |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Fail    | Fail      | Return Fail                        |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Fail    | Pass      | Return Fail                        |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Pass    | Fail      | Return Fail                        |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Pass    | Pass      | rx = min(primary.rx, secondary.rx) |
+	 *      |         |           | tx = primary.tx                    |
+	 *      |         |           | read_delay =                       |
+	 *      |         |           |         min(primary.read_delay,    |
+	 *      |         |           |             secondary.read_delay)  |
+	 *      |----------------------------------------------------------|
+	 */
+
+	/* Primary rxlow: Sweep TX window to find valid RX lower bound */
+
+	rxlow.tx = CQSPI_PHY_TX_LOOKUP_LOW_START;
+	do {
+		dev_dbg(dev, "Searching for Golden Primary rxlow on TX = %d\n",
+			rxlow.tx);
+		rxlow.read_delay = CQSPI_PHY_INIT_RD;
+		ret = cqspi_find_rx_low_ddr(f_pdata, mem, &rxlow);
+		rxlow.tx += CQSPI_PHY_DDR_SEARCH_STEP;
+	} while (ret && rxlow.tx <= CQSPI_PHY_TX_LOOKUP_LOW_END);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "Golden Primary rxlow: RX: %d TX: %d RD: %d\n", rxlow.rx,
+		rxlow.tx, rxlow.read_delay);
+
+	/* Secondary rxlow: Verify at offset TX for robustness */
+
+	if (rxlow.tx <= (CQSPI_PHY_TX_LOOKUP_LOW_END - CQSPI_PHY_SEARCH_OFFSET))
+		srxlow.tx = rxlow.tx + CQSPI_PHY_SEARCH_OFFSET;
+	else
+		srxlow.tx = CQSPI_PHY_TX_LOOKUP_LOW_END;
+	dev_dbg(dev, "Searching for Golden Secondary rxlow on TX = %d\n",
+		srxlow.tx);
+	srxlow.read_delay = CQSPI_PHY_INIT_RD;
+	ret = cqspi_find_rx_low_ddr(f_pdata, mem, &srxlow);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "Golden Secondary rxlow: RX: %d TX: %d RD: %d\n",
+		srxlow.rx, srxlow.tx, srxlow.read_delay);
+
+	rxlow.rx = min(rxlow.rx, srxlow.rx);
+	rxlow.read_delay = min(rxlow.read_delay, srxlow.read_delay);
+	dev_dbg(dev, "Golden Final rxlow: RX: %d TX: %d RD: %d\n", rxlow.rx,
+		rxlow.tx, rxlow.read_delay);
+
+	/* Golden rxhigh search: Find upper RX boundary at fixed TX */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |       |xxxx     ++++++++++++++++++++
+	 *              |       |xxxxx     +++++++++++++++++++
+	 *    search    |       |xxxxxx     ++++++++++++++++++
+	 *    rxhigh  --------->|xxxxxxx     +++++++++++++++++
+	 *    on fixed  |       |xxxxxxxx     ++++++++++++++++
+	 *    tx        |       |xxxxxxxxx     +++++++++++++++
+	 *              |       |xxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *              |       xxxxxxxxxxxxx     ++++++++++++
+	 *              |       xxxxxxxxxxxxxx     +++++++++++
+	 *              |       xxxxxxxxxxxxxxx     ++++++++++
+	 *              |       xxxxxxxxxxxxxxxx     +++++++++
+	 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+	 *              |       xxxxxxxxxxxxxxxxxx     +++++++
+	 *              |
+	 *              -------------------------------------------> tx
+	 *              0                                        127
+	 *
+	 *      |----------------------------------------------------------|
+	 *      | Primary | Secondary | Final                              |
+	 *      | Search  | Search    | Point                              |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Fail    | Fail      | Return Fail                        |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Fail    | Pass      | Choose Secondary                   |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Pass    | Fail      | Choose Primary                     |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Pass    | Pass      | if (secondary.rx > primary.rx)     |
+	 *      |         |           |         Choose Secondary           |
+	 *      |         |           | else                               |
+	 *      |         |           |         Choose Primary             |
+	 *      |----------------------------------------------------------|
+	 */
+
+	/* Primary rxhigh: Search at rxlow's TX, decrement from max read_delay */
+
+	rxhigh.tx = rxlow.tx;
+	dev_dbg(dev, "Searching for Golden Primary rxhigh on TX = %d\n",
+		rxhigh.tx);
+	rxhigh.read_delay = CQSPI_PHY_MAX_RD;
+	ret = cqspi_find_rx_high_ddr(f_pdata, mem, &rxhigh);
+	if (ret)
+		primary = 0;
+	dev_dbg(dev, "Golden Primary rxhigh: RX: %d TX: %d RD: %d\n", rxhigh.rx,
+		rxhigh.tx, rxhigh.read_delay);
+
+	/* Secondary rxhigh: Verify at offset TX */
+
+	if (rxhigh.tx <=
+	    (CQSPI_PHY_TX_LOOKUP_LOW_END - CQSPI_PHY_SEARCH_OFFSET))
+		srxhigh.tx = rxhigh.tx + CQSPI_PHY_SEARCH_OFFSET;
+	else
+		srxhigh.tx = CQSPI_PHY_TX_LOOKUP_LOW_END;
+	dev_dbg(dev, "Searching for Golden Secondary rxhigh on TX = %d\n",
+		srxhigh.tx);
+	srxhigh.read_delay = CQSPI_PHY_MAX_RD;
+	ret = cqspi_find_rx_high_ddr(f_pdata, mem, &srxhigh);
+	if (ret)
+		secondary = 0;
+	dev_dbg(dev, "Golden Secondary rxhigh: RX: %d TX: %d RD: %d\n",
+		srxhigh.rx, srxhigh.tx, srxhigh.read_delay);
+
+	if (primary || secondary) {
+		if (srxhigh.rx > rxhigh.rx)
+			rxhigh = srxhigh;
+	} else {
+		goto out;
+	}
+	dev_dbg(dev, "Golden Final rxhigh: RX: %d TX: %d RD: %d\n", rxhigh.rx,
+		rxhigh.tx, rxhigh.read_delay);
+
+	primary = 1;
+	secondary = 1;
+
+	/* If rxlow/rxhigh at same read_delay, search backup at upper TX range */
+
+	if (rxlow.read_delay == rxhigh.read_delay) {
+		dev_dbg(dev, "rxlow and rxhigh at the same read delay.\n");
+
+		/* Backup rxlow: Search at high TX window */
+
+		/*
+		 *              rx
+		 *          127 ^
+		 *              |       xxxxx     ++++++++++++++++++++
+		 *              |       xxxxxx     +++++++++++++++++++
+		 *              |       xxxxxxx     ++++++++++++++++++
+		 *              |       xxxxxxxx     +++++++++++++++++
+		 *              |       xxxxxxxxx     ++++++++++++++++
+		 *              |       xxxxxxxxxx     +++++++++++++++
+		 *              |       xxxxxxxxxxx     ++++++++++++++
+		 *              |       xxxxxxxxxxxx     +++++++|++++|
+		 *              |       xxxxxxxxxxxxx     ++++++|++++|
+		 *      search  |       xxxxxxxxxxxxxx     +++++|++++|
+		 *      rxlow --------------------------------->|++++|
+		 *              |       xxxxxxxxxxxxxxxx     +++|++++|
+		 *              |       xxxxxxxxxxxxxxxxx     ++|++++|
+		 *              |       xxxxxxxxxxxxxxxxxx     +|++++|
+		 *              |                               |    |
+		 *              --------------------------------|----|-----> tx
+		 *              0                               |    |   127
+		 *                                         txhigh    txhigh
+		 *                                          start    end
+		 *
+		 *      |-----------------------------------------------------|
+		 *      | Primary | Secondary | Final                         |
+		 *      | Search  | Search    | Point                         |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Fail    | Fail      | Return Fail                   |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Fail    | Pass      | Return Fail                   |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Pass    | Fail      | Return Fail                   |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Pass    | Pass      | rx =                          |
+		 *      |         |           |  min(primary.rx, secondary.rx)|
+		 *      |         |           | tx = primary.tx               |
+		 *      |         |           | read_delay =                  |
+		 *      |         |           |  min(primary.read_delay,      |
+		 *      |         |           |      secondary.read_delay)    |
+		 *      |-----------------------------------------------------|
+		 */
+
+		/* Primary backup: Decrement TX from high window end */
+
+		backuppoint.tx = CQSPI_PHY_TX_LOOKUP_HIGH_END;
+		do {
+			dev_dbg(dev,
+				"Searching for Backup Primary rxlow on TX = %d\n",
+				backuppoint.tx);
+			backuppoint.read_delay = CQSPI_PHY_INIT_RD;
+			ret = cqspi_find_rx_low_ddr(f_pdata, mem, &backuppoint);
+			backuppoint.tx -= CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (ret &&
+			 backuppoint.tx >= CQSPI_PHY_TX_LOOKUP_HIGH_START);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "Backup Primary rxlow: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		/* Secondary backup: Verify at offset TX */
+
+		if (backuppoint.tx >=
+		    (CQSPI_PHY_TX_LOOKUP_HIGH_START + CQSPI_PHY_SEARCH_OFFSET))
+			srxlow.tx = backuppoint.tx - CQSPI_PHY_SEARCH_OFFSET;
+		else
+			srxlow.tx = CQSPI_PHY_TX_LOOKUP_HIGH_START;
+		dev_dbg(dev,
+			"Searching for Backup Secondary rxlow on TX = %d\n",
+			srxlow.tx);
+		srxlow.read_delay = CQSPI_PHY_INIT_RD;
+		ret = cqspi_find_rx_low_ddr(f_pdata, mem, &srxlow);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "Backup Secondary rxlow: RX: %d TX: %d RD: %d\n",
+			srxlow.rx, srxlow.tx, srxlow.read_delay);
+
+		backuppoint.rx = min(backuppoint.rx, srxlow.rx);
+		backuppoint.read_delay =
+			min(backuppoint.read_delay, srxlow.read_delay);
+		dev_dbg(dev, "Backup Final rxlow: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		if (backuppoint.rx < rxlow.rx) {
+			rxlow = backuppoint;
+			dev_dbg(dev, "Updating rxlow to the one at TX = %d\n",
+				backuppoint.tx);
+		}
+		dev_dbg(dev, "Final rxlow: RX: %d TX: %d RD: %d\n", rxlow.rx,
+			rxlow.tx, rxlow.read_delay);
+
+		/* Backup rxhigh: Search at fixed backup TX */
+
+		/*
+		 *              rx
+		 *          127 ^
+		 *              |       xxxxx     +++++++++++++++++++|
+		 *              |       xxxxxx     ++++++++++++++++++|
+		 *    search    |       xxxxxxx     +++++++++++++++++|
+		 *    rxhigh  -------------------------------------->|
+		 *    on fixed  |       xxxxxxxxx     +++++++++++++++|
+		 *    tx        |       xxxxxxxxxx     ++++++++++++++|
+		 *              |       xxxxxxxxxxx     +++++++++++++|
+		 *              |       xxxxxxxxxxxx     +++++++++++++
+		 *              |       xxxxxxxxxxxxx     ++++++++++++
+		 *              |       xxxxxxxxxxxxxx     +++++++++++
+		 *              |       xxxxxxxxxxxxxxx     ++++++++++
+		 *              |       xxxxxxxxxxxxxxxx     +++++++++
+		 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+		 *              |       xxxxxxxxxxxxxxxxxx     +++++++
+		 *              |
+		 *              -------------------------------------------> tx
+		 *               0                                        127
+		 *
+		 *      |-----------------------------------------------------|
+		 *      | Primary | Secondary | Final                         |
+		 *      | Search  | Search    | Point                         |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Fail    | Fail      | Return Fail                   |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Fail    | Pass      | Choose Secondary              |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Pass    | Fail      | Choose Primary                |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Pass    | Pass      | if (secondary.rx > primary.rx)|
+		 *      |         |           |         Choose Secondary      |
+		 *      |         |           | else                          |
+		 *      |         |           |         Choose Primary        |
+		 *      |-----------------------------------------------------|
+		 */
+
+		/* Primary backup rxhigh: Use backup TX, decrement from max read_delay */
+
+		dev_dbg(dev, "Searching for Backup Primary rxhigh on TX = %d\n",
+			backuppoint.tx);
+		backuppoint.read_delay = CQSPI_PHY_MAX_RD;
+		ret = cqspi_find_rx_high_ddr(f_pdata, mem, &backuppoint);
+		if (ret)
+			primary = 0;
+		dev_dbg(dev, "Backup Primary rxhigh: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		/* Secondary backup rxhigh: Verify at offset TX */
+
+		if (backuppoint.tx >=
+		    (CQSPI_PHY_TX_LOOKUP_HIGH_START + CQSPI_PHY_SEARCH_OFFSET))
+			srxhigh.tx = backuppoint.tx - CQSPI_PHY_SEARCH_OFFSET;
+		else
+			srxhigh.tx = CQSPI_PHY_TX_LOOKUP_HIGH_START;
+		dev_dbg(dev,
+			"Searching for Backup Secondary rxhigh on TX = %d\n",
+			srxhigh.tx);
+		srxhigh.read_delay = CQSPI_PHY_MAX_RD;
+		ret = cqspi_find_rx_high_ddr(f_pdata, mem, &srxhigh);
+		if (ret)
+			secondary = 0;
+		dev_dbg(dev, "Backup Secondary rxhigh: RX: %d TX: %d RD: %d\n",
+			srxhigh.rx, srxhigh.tx, srxhigh.read_delay);
+
+		if (primary || secondary) {
+			if (srxhigh.rx > backuppoint.rx)
+				backuppoint = srxhigh;
+		} else {
+			goto out;
+		}
+		dev_dbg(dev, "Backup Final rxhigh: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		if (backuppoint.rx > rxhigh.rx) {
+			rxhigh = backuppoint;
+			dev_dbg(dev, "Updating rxhigh to the one at TX = %d\n",
+				backuppoint.tx);
+		}
+		dev_dbg(dev, "Final rxhigh: RX: %d TX: %d RD: %d\n", rxhigh.rx,
+			rxhigh.tx, rxhigh.read_delay);
+	}
+
+	/* Golden txlow: Fix RX at 1/4 of RX window, search TX lower bound */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |
+	 *     rxhigh --------->xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *    fix rx    |       xxxxxxxxxxxxx     ++++++++++++
+	 *    1/4 b/w ---------><------->xxxxx     +++++++++++
+	 *    rxlow and |       xxxx|xxxxxxxxxx     ++++++++++
+	 *    rxhigh    |       xxxx|xxxxxxxxxxx     +++++++++
+	 *              |       xxxx|xxxxxxxxxxxx     ++++++++
+	 *      rxlow --------->xxxx|xxxxxxxxxxxxx     +++++++
+	 *              |           |
+	 *              ------------|------------------------------> tx
+	 *              0           |                            127
+	 *                     search
+	 *                      txlow
+	 */
+
+	tmp = rxhigh.rx - rxlow.rx;
+	txlow.rx = rxlow.rx + (tmp / 4);
+	dev_dbg(dev, "Searching for Golden txlow on RX = %d\n", txlow.rx);
+	txlow.read_delay = CQSPI_PHY_INIT_RD;
+	ret = cqspi_find_tx_low_ddr(f_pdata, mem, &txlow);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "Golden txlow: RX: %d TX: %d RD: %d\n", txlow.rx, txlow.tx,
+		txlow.read_delay);
+
+	/* Golden txhigh: Same RX as txlow, decrement from max read_delay */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |
+	 *     rxhigh --------->xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *    fix rx    |       xxxxxxxxxxxxx     ++++++++++++
+	 *    1/4 b/w --------------------------------><----->
+	 *    rxlow and |       xxxxxxxxxxxxxxx     ++++++|+++
+	 *    rxhigh    |       xxxxxxxxxxxxxxxx     +++++|+++
+	 *              |       xxxxxxxxxxxxxxxxx     ++++|+++
+	 *      rxlow --------->xxxxxxxxxxxxxxxxxx     +++|+++
+	 *              |                                 |
+	 *              ----------------------------------|--------> tx
+	 *              0                                 |      127
+	 *                                           search
+	 *                                           txhigh
+	 */
+
+	txhigh.rx = txlow.rx;
+	dev_dbg(dev, "Searching for Golden txhigh on RX = %d\n", txhigh.rx);
+	txhigh.read_delay = CQSPI_PHY_MAX_RD;
+	ret = cqspi_find_tx_high_ddr(f_pdata, mem, &txhigh);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "Golden txhigh: RX: %d TX: %d RD: %d\n", txhigh.rx,
+		txhigh.tx, txhigh.read_delay);
+
+	/* If txlow/txhigh at same read_delay, search backup at 3/4 RX window */
+
+	if (txlow.read_delay == txhigh.read_delay) {
+		/* Backup txlow: Fix RX at 3/4 of RX window */
+
+		/*
+		 *              rx
+		 *          127 ^
+		 *              |
+		 *     rxhigh --------->xxxxx     ++++++++++++++++++++
+		 *              |       xxxxxx     +++++++++++++++++++
+		 *    fix rx    |       xxxxxxx     ++++++++++++++++++
+		 *    3/4 b/w ---------><----->x     +++++++++++++++++
+		 *    rxlow and |       xxxx|xxxx     ++++++++++++++++
+		 *    rxhigh    |       xxxx|xxxxx     +++++++++++++++
+		 *              |       xxxx|xxxxxx     ++++++++++++++
+		 *              |       xxxx|xxxxxxx     +++++++++++++
+		 *              |       xxxx|xxxxxxxx     ++++++++++++
+		 *              |       xxxx|xxxxxxxxx     +++++++++++
+		 *              |       xxxx|xxxxxxxxxx     ++++++++++
+		 *              |       xxxx|xxxxxxxxxxx     +++++++++
+		 *              |       xxxx|xxxxxxxxxxxx     ++++++++
+		 *      rxlow --------->xxxx|xxxxxxxxxxxxx     +++++++
+		 *              |           |
+		 *              ------------|------------------------------> tx
+		 *              0           |                            127
+		 *                     search
+		 *                      txlow
+		 */
+
+		dev_dbg(dev, "txlow and txhigh at the same read delay.\n");
+		backuppoint.rx = rxlow.rx + ((tmp * 3) / 4);
+		dev_dbg(dev, "Searching for Backup txlow on RX = %d\n",
+			backuppoint.rx);
+		backuppoint.read_delay = CQSPI_PHY_INIT_RD;
+		ret = cqspi_find_tx_low_ddr(f_pdata, mem, &backuppoint);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "Backup txlow: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		if (backuppoint.tx < txlow.tx) {
+			txlow = backuppoint;
+			dev_dbg(dev, "Updating txlow with the one at RX = %d\n",
+				backuppoint.rx);
+		}
+		dev_dbg(dev, "Final txlow: RX: %d TX: %d RD: %d\n", txlow.rx,
+			txlow.tx, txlow.read_delay);
+
+		/* Backup txhigh: Same RX as backup txlow, decrement from max */
+
+		/*
+		 *              rx
+		 *          127 ^
+		 *              |
+		 *     rxhigh --------->xxxxx     ++++++++++++++++++++
+		 *              |       xxxxxx     +++++++++++++++++++
+		 *    fix rx    |       xxxxxxx     ++++++++++++++++++
+		 *    3/4 b/w ------------------------------><------->
+		 *    rxlow and |       xxxxxxxxx     +++++++++++|++++
+		 *    rxhigh    |       xxxxxxxxxx     ++++++++++|++++
+		 *              |       xxxxxxxxxxx     +++++++++|++++
+		 *              |       xxxxxxxxxxxx     ++++++++|++++
+		 *              |       xxxxxxxxxxxxx     +++++++|++++
+		 *              |       xxxxxxxxxxxxxx     ++++++|++++
+		 *              |       xxxxxxxxxxxxxxx     +++++|++++
+		 *              |       xxxxxxxxxxxxxxxx     ++++|++++
+		 *              |       xxxxxxxxxxxxxxxxx     +++|++++
+		 *      rxlow --------->xxxxxxxxxxxxxxxxxx     ++|++++
+		 *              |                                |
+		 *              ---------------------------------|---------> tx
+		 *              0                                |       127
+		 *                                               search
+		 *                                               txhigh
+		 */
+
+		dev_dbg(dev, "Searching for Backup txhigh on RX = %d\n",
+			backuppoint.rx);
+		backuppoint.read_delay = CQSPI_PHY_MAX_RD;
+		ret = cqspi_find_tx_high_ddr(f_pdata, mem, &backuppoint);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "Backup txhigh: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		if (backuppoint.tx > txhigh.tx) {
+			txhigh = backuppoint;
+			dev_dbg(dev,
+				"Updating txhigh with the one at RX = %d\n",
+				backuppoint.rx);
+		}
+		dev_dbg(dev, "Final txhigh: RX: %d TX: %d RD: %d\n", txhigh.rx,
+			txhigh.tx, txhigh.read_delay);
+	}
+
+	/* Corner points: Define and verify bottomleft and topright boundaries */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |                                 topright
+	 *              |                                    *
+	 *    rxhigh -----------xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *              |       xxxxxxxxxxxxx     ++++++++++++
+	 *              |       xxxxxxxxxxxxxx     +++++++++++
+	 *              |       xxxxxxxxxxxxxxx     ++++++++++
+	 *              |       xxxxxxxxxxxxxxxx     +++++++++
+	 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+	 *     rxlow -----------xxxxxxxxxxxxxxxxxx     +++++++
+	 *              |       *                            |
+	 *              | bottom|left                        |
+	 *              --------|----------------------------|---> tx
+	 *              0       |                            | 127
+	 *                      |                            |
+	 *                      txlow                   txhigh
+	 *
+	 * Verification: Test point 4 taps inside each corner, adjust
+	 * read_delay ±1 if needed to ensure valid corners for gap search.
+	 */
+
+	bottomleft.tx = txlow.tx;
+	bottomleft.rx = rxlow.rx;
+	if (txlow.read_delay <= rxlow.read_delay)
+		bottomleft.read_delay = txlow.read_delay;
+	else
+		bottomleft.read_delay = rxlow.read_delay;
+
+	/* Verify bottomleft: Test 4 taps inside, adjust read_delay if needed */
+	backupcornerpoint = bottomleft;
+	backupcornerpoint.tx += 4;
+	backupcornerpoint.rx += 4;
+	ret = cqspi_phy_apply_setting(f_pdata, &backupcornerpoint);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret) {
+		backupcornerpoint.read_delay--;
+		ret = cqspi_phy_apply_setting(f_pdata, &backupcornerpoint);
+		if (!ret)
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+	}
+
+	/* TODO: if (ret) - handle case where corner cannot be verified */
+
+	if (!ret)
+		bottomleft.read_delay = backupcornerpoint.read_delay;
+
+	topright.tx = txhigh.tx;
+	topright.rx = rxhigh.rx;
+	if (txhigh.read_delay >= rxhigh.read_delay)
+		topright.read_delay = txhigh.read_delay;
+	else
+		topright.read_delay = rxhigh.read_delay;
+
+	/* Verify topright: Test 4 taps inside, adjust read_delay if needed */
+	backupcornerpoint = topright;
+	backupcornerpoint.tx -= 4;
+	backupcornerpoint.rx -= 4;
+	ret = cqspi_phy_apply_setting(f_pdata, &backupcornerpoint);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret) {
+		backupcornerpoint.read_delay++;
+		ret = cqspi_phy_apply_setting(f_pdata, &backupcornerpoint);
+		if (!ret)
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+	}
+
+	/* TODO: if (ret) - handle case where corner cannot be verified */
+
+	if (!ret)
+		topright.read_delay = backupcornerpoint.read_delay;
+
+	dev_dbg(dev, "topright: RX: %d TX: %d RD: %d\n", topright.rx,
+		topright.tx, topright.read_delay);
+	dev_dbg(dev, "bottomleft: RX: %d TX: %d RD: %d\n", bottomleft.rx,
+		bottomleft.tx, bottomleft.read_delay);
+	ret = cqspi_phy_find_gaplow_ddr(f_pdata, mem, &bottomleft, &topright,
+					&gaplow);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "gaplow: RX: %d TX: %d RD: %d\n", gaplow.rx, gaplow.tx,
+		gaplow.read_delay);
+
+	/* Final point selection: Handle single vs dual passing regions */
+
+	if (bottomleft.read_delay == topright.read_delay) {
+		/*
+		 * Single region: Use midpoint with temperature compensation.
+		 * Gaplow approximates upper boundary of valid region.
+		 *
+		 *              rx
+		 *          127 ^
+		 *              |              gaplow (approx. topright)
+		 *              |              |
+		 *    rxhigh -----------xxxxxxx|          failing
+		 *              |       xxxxxxx|           region
+		 *              |       xxxxxxx|     <--------------->
+		 *              |       xxxxxxx|     +++++++++++++++++
+		 *              |       xxxxxxxxx     ++++++++++++++++
+		 *              |       xxxxxxxxxx     +++++++++++++++
+		 *              |       xxxxxxxxxxx     ++++++++++++++
+		 *              |       xxxxxxxxxxxx     +++++++++++++
+		 *              |       xxxxxxxxxxxxx     ++++++++++++
+		 *              |       xxxxxxxxxxxxxx     +++++++++++
+		 *              |       xxxxxxxxxxxxxxx     ++++++++++
+		 *              |       xxxxxxxxxxxxxxxx     +++++++++
+		 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+		 *     rxlow -----------xxxxxxxxxxxxxxxxxx     +++++++
+		 *              |       *                            |
+		 *              | bottom|left                        |
+		 *              --------|----------------------------|---> tx
+		 *              0       |                            | 127
+		 *                      |                            |
+		 *                      txlow                   txhigh
+		 *                             (same read_delay)
+		 *
+		 * Temperature compensation: Valid region shifts with temp.
+		 * Offset = region_size / (330 / (temp - 87.5°C))
+		 * Factor 330 is empirically determined for this hardware.
+		 */
+
+		dev_dbg(dev,
+			"bottomleft and topright at the same read delay.\n");
+
+		topright = gaplow;
+		searchpoint.read_delay = bottomleft.read_delay;
+		searchpoint.tx =
+			bottomleft.tx + ((topright.tx - bottomleft.tx) / 2);
+		searchpoint.rx =
+			bottomleft.rx + ((topright.rx - bottomleft.rx) / 2);
+
+		ret = cqspi_get_temp(&tmp);
+		if (ret) {
+			/* Assume room temperature if sensor unavailable */
+			dev_dbg(dev,
+				"Unable to get temperature. Assuming room temperature\n");
+			tmp = CQSPI_PHY_DEFAULT_TEMP;
+		}
+
+		if (tmp < CQSPI_PHY_MIN_TEMP || tmp > CQSPI_PHY_MAX_TEMP) {
+			dev_err(dev,
+				"Temperature outside operating range: %dC\n",
+				tmp);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (tmp == CQSPI_PHY_MID_TEMP)
+			tmp++; /* Avoid divide-by-zero */
+		dev_dbg(dev, "Temperature: %dC\n", tmp);
+
+		/* Apply temperature offset: positive at high temp, negative at low */
+		searchpoint.tx += (topright.tx - bottomleft.tx) /
+				  (330 / (tmp - CQSPI_PHY_MID_TEMP));
+		searchpoint.rx += (topright.rx - bottomleft.rx) /
+				  (330 / (tmp - CQSPI_PHY_MID_TEMP));
+	} else {
+		/*
+		 * Dual regions: Gap separates two valid regions, choose larger.
+		 *
+		 *              rx
+		 *          127 ^
+		 *              |                                 topright
+		 *              |                                    *
+		 *    rxhigh -----------xxxxx     +++++++++++++++++++|
+		 *              |       xxxxxx    <region 2> ++++++++|
+		 *              |       xxxxxxx     +++++++++++++++++|
+		 *              |       xxxxxxxx     ++++++++++++++++|
+		 *              |       xxxxxxxxx     +++++++++++++++|
+		 *              |       xxxxxxxxxx     ++++++++++++++|
+		 *              |                  failing           |
+		 *              |                  region            |
+		 *              |       xxxxxxxxxxxxx     +++++++++++|
+		 *              |       xxxxxxxxxxxxxx     ++++++++++|
+		 *              |       xxxxxxxxxxxxxxx     +++++++++|
+		 *              |       xxxxxxxxxxxxxxxx     ++++++++|
+		 *              |       xxxxxxxxx <region 1>  +++++++|
+		 *     rxlow -----------xxxxxxxxxxxxxxxxxx     ++++++|
+		 *              |       *                            |
+		 *              | bottom|left                        |
+		 *              --------|----------------------------|---> tx
+		 *              0       |                            | 127
+		 *                      |                            |
+		 *                      txlow                   txhigh
+		 *
+		 * Strategy: Compare Manhattan distances from gap boundaries to
+		 * corners. Choose corner furthest from gap (larger region).
+		 * Apply 16-tap margin inward, scale RX proportionally.
+		 */
+
+		ret = cqspi_phy_find_gaphigh_ddr(f_pdata, mem, &bottomleft,
+						 &topright, &gaphigh);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "gaphigh: RX: %d TX: %d RD: %d\n", gaphigh.rx,
+			gaphigh.tx, gaphigh.read_delay);
+
+		/* Compare Manhattan distances: choose corner furthest from gap */
+		if ((abs(gaplow.tx - bottomleft.tx) +
+		     abs(gaplow.rx - bottomleft.rx)) <
+		    (abs(gaphigh.tx - topright.tx) +
+		     abs(gaphigh.rx - topright.rx))) {
+			/* Topright further: Use Region 2, 16 taps inward */
+			searchpoint = topright;
+			searchpoint.tx -= 16;
+			searchpoint.rx -= (16 * (topright.rx - bottomleft.rx)) /
+					  (topright.tx - bottomleft.tx);
+		} else {
+			/* Bottomleft further: Use Region 1, 16 taps inward */
+			searchpoint = bottomleft;
+			searchpoint.tx += 16;
+			searchpoint.rx += (16 * (topright.rx - bottomleft.rx)) /
+					  (topright.tx - bottomleft.tx);
+		}
+	}
+
+	/* Apply and verify final tuning point */
+	dev_dbg(dev, "Final tuning point: RX: %d TX: %d RD: %d\n",
+		searchpoint.rx, searchpoint.tx, searchpoint.read_delay);
+	ret = cqspi_phy_apply_setting(f_pdata, &searchpoint);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret) {
+		dev_err(dev,
+			"Failed to find pattern at final calibration point\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = 0;
+	f_pdata->phy_setting.read_delay = searchpoint.read_delay;
+	f_pdata->phy_setting.rx = searchpoint.rx;
+	f_pdata->phy_setting.tx = searchpoint.tx;
+out:
+	if (ret)
+		f_pdata->use_phy = false;
+
+	return ret;
 }
 
 static int cqspi_phy_tuning_sdr(struct cqspi_flash_pdata *f_pdata,
 				struct spi_mem *mem)
 {
-	/* Placeholder for SDR mode PHY tuning algorithm */
-	return 0;
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	struct device *dev = &cqspi->pdev->dev;
+	struct phy_setting rxlow, rxhigh, first, second, final;
+	u8 window1 = 0;
+	u8 window2 = 0;
+	int ret;
+
+	/*
+	 * SDR tuning: 1D search for optimal RX delay (TX less critical).
+	 * Find two consecutive windows, choose larger, use midpoint.
+	 *
+	 *              rx
+	 *          127 ^
+	 *              |        |-----window at----------|
+	 *              |        |-----read_dealy = n+1---|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow(n+1)   midpoint    rxhigh(n+1)
+	 *              |
+	 *              |   |---window at--------|
+	 *              |   |---read_dealy = n---|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   rxlow(n)   midpoint  rxhigh(n)
+	 *              |
+	 *              -----------------------------------------> tx
+	 *              0                                      127
+	 *                  read_delay=n                  read_dealy=n+1
+	 */
+
+	f_pdata->use_phy = true;
+	cqspi_phy_reset_setting(&rxlow);
+	cqspi_phy_reset_setting(&rxhigh);
+	cqspi_phy_reset_setting(&first);
+
+	/* First window: Find rxlow by incrementing read_delay from 0 */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *  search      |   |xxxxxxxxxxxxxxxxxxxx|
+	 *  rxlow       |   |xxxxxxxxxxxxxxxxxxxx|
+	 *  increasing  |   |xxxxxxxxxxxxxxxxxxxx|
+	 *           --------->|xxxxxxxxxxxxxxxxxxxx|
+	 *  read_delay  |        |xxxxxxxxxxxxxxxxxxx|
+	 *  until found |        |xxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow
+	 *              -----------------------------------------> tx
+	 *              0                            tx fixed at 127
+	 */
+
+	do {
+		ret = cqspi_find_rx_low_sdr(f_pdata, mem, &rxlow);
+
+		if (ret)
+			rxlow.read_delay++;
+	} while (ret && rxlow.read_delay <= CQSPI_PHY_MAX_RD);
+
+	/* Find rxhigh: Decrement from RX=127 at same read_delay */
+
+	/*
+	 *              rx
+	 *          127 ^        search rxhigh
+	 *              |        (decrement from
+	 *              |        127 until found)
+	 *              |          |
+	 *              |          |
+	 *              |          v
+	 *              |        |------------------------|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow                    rxhigh
+	 *              -----------------------------------------> tx
+	 *              0                            tx fixed at 127
+	 */
+
+	rxhigh.read_delay = rxlow.read_delay;
+	ret = cqspi_find_rx_high_sdr(f_pdata, mem, &rxhigh, rxlow.rx);
+	if (ret)
+		goto out;
+
+	/* Calculate first window midpoint for max margin */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |        |--------window1---------|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxx * xxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow        ^           rxhigh
+	 *              ----------------------|------------------> tx
+	 *              0                     |      tx fixed at 127
+	 *                            window1/2
+	 */
+
+	first.read_delay = rxlow.read_delay;
+	window1 = rxhigh.rx - rxlow.rx;
+	first.rx = rxlow.rx + (window1 / 2);
+
+	dev_dbg(dev, "First tuning point: RX: %d TX: %d RD: %d\n", first.rx,
+		first.tx, first.read_delay);
+	ret = cqspi_phy_apply_setting(f_pdata, &first);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret || first.read_delay > CQSPI_PHY_MAX_RD)
+		goto out;
+
+	/* Second window: Search at read_delay+1, may differ in size */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |        |-------|
+	 *              |        |xxxxxxx|
+	 *              |        |xxxxxxx|
+	 *              |        |xxxxxxx|
+	 *              |        |xxxxxxx|
+	 *              |        |xxxxxxx|
+	 *              |        rxlow   rxhigh
+	 *              -----------------------------------------> tx
+	 *              0
+	 *              read_delay = n (smaller window)
+	 *
+	 *              rx
+	 *          127 ^
+	 *              |        |-----------------|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        rxlow             rxhigh
+	 *              -----------------------------------------> tx
+	 *              0
+	 *              read_delay = n+! (larger window - better)
+	 */
+
+	cqspi_phy_reset_setting(&rxlow);
+	cqspi_phy_reset_setting(&rxhigh);
+	cqspi_phy_reset_setting(&second);
+
+	rxlow.read_delay = first.read_delay + 1;
+	if (rxlow.read_delay > CQSPI_PHY_MAX_RD)
+		goto compare;
+
+	ret = cqspi_find_rx_low_sdr(f_pdata, mem, &rxlow);
+	if (ret)
+		goto compare;
+
+	rxhigh.read_delay = rxlow.read_delay;
+	ret = cqspi_find_rx_high_sdr(f_pdata, mem, &rxhigh, rxlow.rx);
+	if (ret)
+		goto compare;
+
+	/* Calculate second window midpoint */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |        |--------window2---------|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxx * xxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow        ^           rxhigh
+	 *              ----------------------|------------------> tx
+	 *              0                     |      tx fixed at 127
+	 *                            window1/2
+	 *              read_delay = n+1
+	 */
+
+	window2 = rxhigh.rx - rxlow.rx;
+	second.rx = rxlow.rx + (window2 / 2);
+	second.read_delay = rxlow.read_delay;
+
+	dev_dbg(dev, "Second tuning point: RX: %d TX: %d RD: %d\n", second.rx,
+		second.tx, second.read_delay);
+	ret = cqspi_phy_apply_setting(f_pdata, &second);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret || second.read_delay > CQSPI_PHY_MAX_RD)
+		window2 = 0;
+
+	/* Window comparison: Choose larger window for better margin */
+
+compare:
+	cqspi_phy_reset_setting(&final);
+	if (window2 > window1) {
+		final.rx = second.rx;
+		final.read_delay = second.read_delay;
+	} else {
+		final.rx = first.rx;
+		final.read_delay = first.read_delay;
+	}
+
+	/* Apply and verify final tuning point */
+
+	dev_dbg(dev, "Final tuning point: RX: %d TX: %d RD: %d\n", final.rx,
+		final.tx, final.read_delay);
+	ret = cqspi_phy_apply_setting(f_pdata, &final);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	f_pdata->phy_setting.read_delay = final.read_delay;
+	f_pdata->phy_setting.rx = final.rx;
+	f_pdata->phy_setting.tx = final.tx;
+
+out:
+	if (ret)
+		f_pdata->use_phy = false;
+
+	return ret;
 }
 
 static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
-- 
2.34.1


