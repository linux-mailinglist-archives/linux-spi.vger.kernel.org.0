Return-Path: <linux-spi+bounces-4970-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7F39860E3
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 16:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4AF288468
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F7E18E350;
	Wed, 25 Sep 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p2ToFbcB"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0818E349;
	Wed, 25 Sep 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271613; cv=fail; b=EHiFXnf+C3iCYiuOO61UGCJkXrjL2pmqhEBv5oaFGYX+acqTXLsb/oZAtFt5J+MBMK/RX4jPKHxbB68maeotDSmbsYNLWxRCikq+UnqjNLziionDjdGs6alWis9iO04C9/0u2IQ4sR1HA0CzTXVTGwUxWu91+OOnSyGLbqjc6lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271613; c=relaxed/simple;
	bh=tmeDs39U6rEmllj6p9zeM2GlpUukOcATFbue6sW4qwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Phe0bTN7uIjQxfKGYFDhZJR7Ernlw3z2cpAOFUSUNTLH3u+kAs5oc80yN2t9Tdxixw3gQc2pD6E6UjQI2Lk6vBaUFd5IFkX80yL3fz5PnFkabdc5yL8pRufRMB2Yv4Gqinf8q40fSWu8VhMDAkxArNwrCm8z11jFYgQ7TWRyiBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p2ToFbcB; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovp9JDYNzWNGCsg1jCMc7JgK7axtWmUV5oqCUSuK4135ZgZyGyU8jLrz0GsdtPVG18JSNUuUuUYBg117N2xZwrSSs5ujW9oyBrFM7ABAv+jOv3I5WFzh6VSuppG42h4vSyU/O07ETWxeY+ZwHYpFd/6sIUpVZuI9Hj36Qu1CJg7fq5QCMcKgN53DmJeOQhp7V8h/A2TXrk6IGaO+oh/9yAvJSD6OFNjSA8a1LqGghLRcye29RmGIuN+3Ux87ps1fo21XYwG9rTIZlLPOiuFunTtcTfEDnTzM2Exc6ouDZ/gU2aGRmBgJE3N7A+eTkw9jloDSp867RTK8f8HBOeFnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boi7sB7p338EPlfmVcLVmrQA8f30jhO2Bs7zV0EInSU=;
 b=hzE6n7XKiseMf9IqfpXN5Wcj6XEdWFRHrnz9d4MDCSA9PRv5yA8feMQrmCREukfZkjLJTHwBwJKJfDbXxv5WGF3gMt0ARG8z3BCkh6SBE5VOQzE9iK+OzXTJn8f1msAGuqjU00gkNO5efKlVtS7VS21OHH/DLdGJkA6j2vIEdAUFecrMz0hHygHy/RJa3UdXHLOhG/4Evwt0pAu5I02Aae+gweZB0gqVKJWnnvrRwkMWj1Gv7EhUsLxvCzgaIIQv9qYImZ2fMMzp7qK8vjM6vHo7ga6ExOXd2Wa1O46lNaJ6EQW2Y5Ov3rCXJOtY4Fc5FwaOzPsWe8FVk7ur/9bjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boi7sB7p338EPlfmVcLVmrQA8f30jhO2Bs7zV0EInSU=;
 b=p2ToFbcBKyNRUfDzXLr4rRy172BiMyuMhElTM3GW0ug10MYZb5bqv4P/XRGVDh4XIyJMp28/FLDjOgx3c6lqwddjb3+NGFWHmqMWxbpK5kmnG1b6WCCVYb5W1cZl4v7KLXjBqfzH/tBJRzKctLnLjABCj/LfiFqxmIRajI1FcmY=
Received: from SA1P222CA0133.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::18)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 13:40:07 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::c9) by SA1P222CA0133.outlook.office365.com
 (2603:10b6:806:3c2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Wed, 25 Sep 2024 13:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 13:40:07 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 08:40:04 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH V2 3/8] spi: spi_amd: Replace ioread/iowrite calls
Date: Wed, 25 Sep 2024 19:06:39 +0530
Message-ID: <20240925133644.2922359-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925133644.2922359-1-Raju.Rangoju@amd.com>
References: <20240925133644.2922359-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e7d708-05b5-4fa4-ffc1-08dcdd6791ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mS/W1ajw0UbO57cuCigRUr8hic3S7qrlMz/bdR3WhZat6FUZ+l1Q5BLbuoRR?=
 =?us-ascii?Q?FA2+CUjLSXZED3mJxX2BhHmwEtzGK+nxm21674ZzCWNND0IjtSJcqMsPpJUn?=
 =?us-ascii?Q?ylpli/jwrvRQKmT5OkdunW1UXGG8IqxjhcAFhUPfRm+h9sxsicIPtqSIcaCj?=
 =?us-ascii?Q?Rif/AMyfXt6iviFQXF5JJmiiyxVLpAkpRWjSam7eyUL3lwL7cPU7ozOUwbpK?=
 =?us-ascii?Q?ui7+hAAVDxgAwwVqcQZkjoNrdMjqdDsnvrUZ5xAAWlySXQnbrr3tmxAjI/pA?=
 =?us-ascii?Q?0zffi/5Y0wCCNC2IAqcja+WNok3t0LYA2a0lYlpo/f8lK/gFhDhTYqAgE1K+?=
 =?us-ascii?Q?lw5n28TYhfwbW4Dxa12PbtSnPYPDuwRRJt1pCVVT2ms6Zl2yQmVte1L4SZPc?=
 =?us-ascii?Q?rrDMFmPvGfl90nsk7odNaVI5Rh4VGjNob3fOKmmEJRTw7n1rhJG3/3LmmtZi?=
 =?us-ascii?Q?qO2hksErDjn0KJ06nEw5KZ94ShN7OkaQPX/dqb+mdOJBvEkT0515/fvDa1C5?=
 =?us-ascii?Q?/z5NiZFyLE+AcWv/veVU8j6/nbvKaI6Cd+LTuWUw12812X0dQ90Doc3kWps+?=
 =?us-ascii?Q?YTblwHbdrQKTBw6MD5uHzgAiSS41hcdtWQ6TvOubi2/rtFKVqWOHIIvF+mmm?=
 =?us-ascii?Q?aBiVNLzYzvM/o6wbGPxTeF2N8fiYbYNZC5ZZ9cAz43d3xnR0ceOQ7V+Eh95a?=
 =?us-ascii?Q?fPt6sBUC1huch7j00SRJmBFXKc8cBmemKcL2gpdzAZuB1Et4AmFVbFDvH+1g?=
 =?us-ascii?Q?dd80E9KyUur7A7BCk6bGwsKw4kj+vTDoc7IeOIO0R+/OaKzKHnElA4SzUQgE?=
 =?us-ascii?Q?3PXn8pGOx3Hy49mB9Xu2Sh5PMbuuTeshpZugAvD3bxzNaHmNbBe5lDXUlNZV?=
 =?us-ascii?Q?lm+zM0p4aaHu7cJ1LMTk4rHmdKMminO8YMoMlDSSo384rJ3AKQQ92uZScPp/?=
 =?us-ascii?Q?Ja057XpvLL4uqWpjJxSFsMh7MmqnVPQDVY2ZRdHf9eSG3uZyrWVDQVFDQzS2?=
 =?us-ascii?Q?a/f4Ls3BtyeHWUPqu3xDtQX7caN2g/DkLTKfn8B3uwtChPzS/KA0IJviuxrk?=
 =?us-ascii?Q?9qe9XGv0ljsuEFwluV2xbH+hqdYg9ngDvGDjwEZ4UeBiXgtp378muVXzroWB?=
 =?us-ascii?Q?cktwVfQBrBO0X3ZwPAXQb8fGdc+TTWvNTrQXkQ4i8FqHgeCtrC1glzSjBVVb?=
 =?us-ascii?Q?NbAUiQSQ80NkSyapU9xnGFVSf6Ro7qVsHYkffoX4T/+Dz+YgVFVUE0iJiTRr?=
 =?us-ascii?Q?v2hkMrZWoS/o573SZubvwT1ZrjVPjhWk8EllJ0keEwHzmlwEujKWWn0bd1A0?=
 =?us-ascii?Q?h7t/wSbywGLTdo2jUn1dRYSsiTZmqwZWaviEslltJx6c6bBOl11YWiVcj7Ai?=
 =?us-ascii?Q?bpsqN0I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:40:07.4637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e7d708-05b5-4fa4-ffc1-08dcdd6791ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593

All `ioread*` and `iowrite*` functions are better suited for architecture
independent code to ensure portability across different architectures.
Since AMD SoCs support only the x86 architecture, replacing all `ioread*`
and `iowrite*` calls with `read*` and `write*` calls can reduce the
overhead of ensuring portability and increase the speed of I/O operations.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 17a8401216e4..1d1a18ee0bb5 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -114,12 +114,12 @@ struct amd_spi {
 
 static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
 {
-	return ioread8((u8 __iomem *)amd_spi->io_remap_addr + idx);
+	return readb((u8 __iomem *)amd_spi->io_remap_addr + idx);
 }
 
 static inline void amd_spi_writereg8(struct amd_spi *amd_spi, int idx, u8 val)
 {
-	iowrite8(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
+	writeb(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
 }
 
 static void amd_spi_setclear_reg8(struct amd_spi *amd_spi, int idx, u8 set, u8 clear)
@@ -132,12 +132,12 @@ static void amd_spi_setclear_reg8(struct amd_spi *amd_spi, int idx, u8 set, u8 c
 
 static inline u32 amd_spi_readreg32(struct amd_spi *amd_spi, int idx)
 {
-	return ioread32((u8 __iomem *)amd_spi->io_remap_addr + idx);
+	return readl((u8 __iomem *)amd_spi->io_remap_addr + idx);
 }
 
 static inline void amd_spi_writereg32(struct amd_spi *amd_spi, int idx, u32 val)
 {
-	iowrite32(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
+	writel(val, ((u8 __iomem *)amd_spi->io_remap_addr + idx));
 }
 
 static inline void amd_spi_setclear_reg32(struct amd_spi *amd_spi, int idx, u32 set, u32 clear)
-- 
2.34.1


