Return-Path: <linux-spi+bounces-4845-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F9D97BB1C
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 12:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF530283D01
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 10:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAA018858E;
	Wed, 18 Sep 2024 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ev+JI95Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0083E1865F5;
	Wed, 18 Sep 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656747; cv=fail; b=iKLR00YdjqX4uDVW0Be84UIKT3OXqfP9doIUzrMYMJw0iP+dxt51QPoaJwNdn80Ozmlm7Wr1cI5sJd/OJNFlBLBUCsQ94iXKKA32dodlW7hp/TOXHR6Fhw2QWDY9hSEBnwshYl/SyG7lubTrpGrX+vHzE7fzu7rSZkeRNr47jEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656747; c=relaxed/simple;
	bh=lct+Aq2VyibkPpmL6WvSI5CAbDLzQxXh04drQ9ZXz8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0Wt4HkHogWPNfcd4aZKgm0+zIKByiRJiPGiVaN+dxDmnQKSkb78p2lziFySn890IrX+cEQwE46KKpTa21U71lo9TxY9mBIAje6TclvTGEiONGQxnz+zoSWfgD9kdCrzT7bFPHPPWKFGuejHwgzYwcaqoHSYSC+zPEYx1AxSpoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ev+JI95Z; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uamkxbiKtC3Poompdhgj8SLyvFc9ub9uHspSzezSFAj2HiOztg8FU5alSUV0U/bLVXUsW9lK9HcIUKPt7IYLXGr1PI7fDqbKHjyu0He3u+W6Uqfc16ivkWtyfkqpLy8E59qDHtN1Fali1+OwAI9QmB9Z5SE9eCzsO/lxl2pv3cwhT20e9panqVF8tXrSwKYk8IkkaPRv0NWdhNjOn8TV6qJdAww7yMpikcXLoENA99saXmxycZD3AKXFh1arMwheyoMcQExHqR6EUzRIyX5BC80+ac2Lmaa7Edy9bYBWdo467JZsLu8kQXFqgubCNADYmDB2UlC2AZXNxLFzTAijvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mka/3NXTv+DkpmGny/3YCntHT1LUsx9/Cu05bmAiXc=;
 b=DFRzsTdN65Wb02Et0qk8Wcn37S2Bs083pgWoX2brxERj/cTFqJgZKXEgsLJOYiPiuBvteDGpynteqG56cQ3tPtnvDLKd5fPKFJl+nplSDNd0bXVhO6k9HCdGQ2C2kJ2L+fxRgrQY6sdI1blcpnhiCYUGnicqOur9lhjofdtFZ3raTsnGEGuUYUYKOChBq1LnlxOBtmxYnGdLU3homt+i/nlzfa5lwoGgCVkPgJ1n19udXGClT7MoXjkLPatbrau5a+1mu28RtecJlHxKXqGOeheB5+gdeuDo0ZLUPF32Suo4hBhLkaRxobRFcBz+XH7QmhCDRiF/BUsdtkVSe1IdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mka/3NXTv+DkpmGny/3YCntHT1LUsx9/Cu05bmAiXc=;
 b=Ev+JI95ZZrP0MQjKjOirli37V1G8x81LSlv19zguWN6Eq7ZGxNA+xubl95gVGxGp/kSV2/ClbXn+cPse7fbxsHGc+CNqthwN6uXpdAUgiZ88dQcE8pOYjAK4U3EOojmmDONFR9lOil4Fs0mB0JDTi3mLMtJGDc5HxydSsoQMJeo=
Received: from CH0PR03CA0118.namprd03.prod.outlook.com (2603:10b6:610:cd::33)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Wed, 18 Sep
 2024 10:52:21 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::78) by CH0PR03CA0118.outlook.office365.com
 (2603:10b6:610:cd::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 10:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 10:52:20 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 05:52:18 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH 1/9] spi: spi_amd: Sort headers alphabetically
Date: Wed, 18 Sep 2024 16:20:29 +0530
Message-ID: <20240918105037.406003-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918105037.406003-1-Raju.Rangoju@amd.com>
References: <20240918105037.406003-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ae6731-6ef8-4328-e352-08dcd7cff899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2032O4E9//AgBYgKIqImQDtsEeSgABW1LxoXEcCz/5vi1k3dq++2kdI4TVgd?=
 =?us-ascii?Q?kMGDMRgC6hh6igHopfl8wi4xpHHExYeerm7m+JAaKHwZjLuaTuTupZTnS4Ls?=
 =?us-ascii?Q?jORUKbNAziEcUMtsPBu9XtHzRQO1P0VlQ1lbh9Q7Y2RsUnqwpTNpMBYf8vTv?=
 =?us-ascii?Q?pIiqPW/epSQvMo9ZLL7eegi9YAZufbihyikCi6u8hAKiKbp3R1MbPTbd9XCV?=
 =?us-ascii?Q?yLeaKPpLWs2udVqIzBby7IuT6Wnac6H40EtDnlZA3goKH3v+lOHDPo+adNqZ?=
 =?us-ascii?Q?X3/hYrMbbUgyw1K748nbJubc6TUZJGXM5v2t1Kt0Q+xmJRR3LKZVAg81TU9T?=
 =?us-ascii?Q?ROdVzs9w5EF79LHOQymIw4Pxm1mOTv9M4sieuOb6JInlr6cf1EljuV+PCd2x?=
 =?us-ascii?Q?x9XB992CwKL30HSSzvWYcfageDDt/snTS65JR4ONAhwkhUqpIZAp5B7l3smq?=
 =?us-ascii?Q?bmr7fs2rAriHno66IuW7/CALV2oQcvBPn2FB89SG9JP0T4U6Z7PcagOQQXOg?=
 =?us-ascii?Q?qpnE21UhW0ay0jd3QTMCJtk+bRfTNZnvIrLeLERFxb65VdxKbTcT6+pfqJfP?=
 =?us-ascii?Q?B29Xz9q+NfPlR9eD6urj4OnQ7JeW51C0MuvOyOLv+rhgrzx/OnmBAPfrCtcJ?=
 =?us-ascii?Q?ikWNxERdfkic2uPb8aQ2w935lMhueTsr5Ena+QzUsPxYNq4b9giEaov4TXMq?=
 =?us-ascii?Q?nhL1aaGwcR30OvhHEUrSr6r16AAyMZjOMK5uEp2mQi8XJElp/b2QK+KGUC96?=
 =?us-ascii?Q?+973Ys+HXy8L0IQ9BaVoSfLqQguZBZU596aTrot7vsoN7qlarsgKAKkDWGvZ?=
 =?us-ascii?Q?B7GpUq5iRoOIVqXo2YxKnwF48U81tEQ2KvLwZ+tNCOfQAllygOhWKH04HRjz?=
 =?us-ascii?Q?UKWvHie655cklGpYiQOsIklQUTg5FZRiMPGyoIQUpR9IUfOK9OjQQOhN+cu+?=
 =?us-ascii?Q?QhA4oKZ7lMo9HJtOJZ3NFrqUFHsPTeDh8fq4hKaP/gRChivfY/s4Q6dSGmCv?=
 =?us-ascii?Q?cLEp0qXrT6PfRJvKnGb8qp8JuQtV2TVHzbzb9CWAgycAPZFO7o1BXCHqgED5?=
 =?us-ascii?Q?M2LwqemugDPCwOynn/R3xQh5W9M+WJ31s+mhOci9pNWEsd37BoC+OLj5/HXM?=
 =?us-ascii?Q?JEZy/aG/ZsdI5NTZQTebBC2ArtWcC9luPVFSwUdxRTdpzG8z8W6D54ybaf4R?=
 =?us-ascii?Q?sPSuxhtxf7Htd1FypHFPzheoihEHjtqkd74sHe3IgT2Cb9qEHW7nuu0kFcn4?=
 =?us-ascii?Q?vExyHQ3S5RpfGwlEq6L+GnuFE/9IHFD7XkY30NenE2fWzzVjNm6nwEQbk1WZ?=
 =?us-ascii?Q?/V1xPFh2Bd2rgx4rHjeiKE/4ucEam+ZnN+4U0xFN+M/3GTiiGAf7cS1mMvP9?=
 =?us-ascii?Q?q1Uo0LKoTXZxEMgq2yX0I5ERK4adSe7JVGdy74yLyBbfosHNnpaIi5Jg5rx1?=
 =?us-ascii?Q?z8np7t0A0nlwKvo892BkA/PcWBpWgocC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 10:52:20.7867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ae6731-6ef8-4328-e352-08dcd7cff899
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170

Sorting headers alphabetically helps locating duplicates, and makes it
easier to figure out where to insert new headers.

Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 2245ad54b03a..c52066360dfe 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -7,12 +7,12 @@
 // Author: Sanjay R Mehta <sanju.mehta@amd.com>
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/delay.h>
 #include <linux/spi/spi.h>
-#include <linux/iopoll.h>
 #include <linux/spi/spi-mem.h>
 
 #define AMD_SPI_CTRL0_REG	0x00
-- 
2.34.1


