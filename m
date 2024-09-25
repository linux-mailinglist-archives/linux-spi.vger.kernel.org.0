Return-Path: <linux-spi+bounces-4975-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1998610C
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E676EB30E4E
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0EF1B2EC8;
	Wed, 25 Sep 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ibmInqCU"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202151B29D9;
	Wed, 25 Sep 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271634; cv=fail; b=mK3o9WkJKvd0E7V+lGYFj9MjWGQxgFOFk90JkwO+wZ7dQec7PYnuhYHlFjhShx1cQN9a588Dis3XirLUC/yJmBkqc8Jsd9BCWdVy1COnPzSEoOEzdZk0ahLt3ttpvvGbIdxy/PMatUQbtYQr15H2MvobS6oBWMWWihZYDVPjV0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271634; c=relaxed/simple;
	bh=T1WBBlENekmNm1+3P0QP1VG3FxhaF37d52O3NSvRToU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7kZzTi4IeIddMTkr7dOpNFwtdxa/+/1z549Bbi+mBKzhq0vfQYc3DVVIOcffwljVs2F3R5B8BRLuiRfSJjfhCE6MOmjoz8WF8edVrl9c+leu4JfgcT+NKkC5Ub7oNLU8hpmez/pzM8q9P21YvAd0bG97U9IehYZkW8fWJl41Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ibmInqCU; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmq3HvEwTGo6CB2mN9lfZIUle2X2jdc1GZqLSI5u9uLceHKYNtx10ZL0cevkM0SZVDb4VbcEai4Hwpf49Fgz/++ZUkRONe8ExByu/eCrU3BemcOe5Gz5wGfeNmw47fxhza0AS+VrauAuuQYHggIU/8PSeuYP56BmX1ztaC6HXNZjt3DQYi0DdDs4zB5RM/vB1xyBvLrKY8MxjjdnSpVFOCG7C8U35+g6EmRt8eVkE6/P7kZMN/OhmmpWv267nEhMl8qzd8rVffmTl/kuyvYMRG7J4dt0WNCZXc+5gbyX68SGEFCMh0bJzOVSglt4nPsWaRquYMh6BC9fXeHAbh0SFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BdVuzbL2D+alHG7nUTDPxI61FWIzoKqkJ/9uIblQUU=;
 b=RSbhniMmcBBMUTHirGzynHqCsR572OfI7/83r51VJ+3f3z5h2UAl3Ep/OZll0Uf3KmlL515EXs6aj39vz9fPbuSaSF32vBwiyE7AJ7JDYb4NC4ZgAQ+fB8uiu2em0NDQXsma/ldhJZ0kyn1Wltpga5tyN/jlHfRHb6+6kDKM3HPHp0c5dBXxMqicEGdkZsDNOcsVqeuBS6KDpLhqOuxBoDAXxaTkq/GqHHfXa4HKhcm8sdVZFB3V5L8iT7pZw+M9DPlQsLSL8tcARTcJd9zyA0jBe5CAeIIolzTmjddXEmSVmHfNbIJGefMZa9MCM+pGouXrWz9r+0gCN3JJvTgVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BdVuzbL2D+alHG7nUTDPxI61FWIzoKqkJ/9uIblQUU=;
 b=ibmInqCU170KdqyVDxwrBCciyC4P5R89AGSdjsRY7RzPZ5aHfYwdqT+hW2VLEt1ZyhzKTd5Rt03QPeqn4+feKuNpU8Pj/y4rTlpfv39at55aCCSJgPLk470xIzdPsSZ1iW5uVFoOqNHOzks2SkpU5domH1eO4Lm0SFwMCzHAShY=
Received: from SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::21)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 13:40:21 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::1a) by SA9P223CA0016.outlook.office365.com
 (2603:10b6:806:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 13:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 13:40:21 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 08:40:18 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <sanju.mehta@amd.com>,
	<krishnamoorthi.m@amd.com>, <akshata.mukundshetty@amd.com>,
	<Raju.Rangoju@amd.com>
Subject: [PATCH V2 7/8] spi: spi_amd: Set controller address mode
Date: Wed, 25 Sep 2024 19:06:43 +0530
Message-ID: <20240925133644.2922359-8-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: f36f6f42-3547-4dac-dc44-08dcdd679a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qKJgwnj7IydTdZ5Po24yAuh3yJnjLRS42leGxynLzyQUhvstT0pwCo5tioFP?=
 =?us-ascii?Q?AGYx4d+CtRps1OtGvN+5oAlWMMqBM37AJ0TnpMKZUxr9H+wcto2b+KR/NW6c?=
 =?us-ascii?Q?wOKAJg9KNJfxysyK0eEsXV1qdTlFJ7gBZJj8dWSkHDKFi7NpmKuBW+0g8HFN?=
 =?us-ascii?Q?QRKX623IbbqO0AeWXg/SyMLpkn+QVnpl8ZdtLXgk2MjOqu6pm/utqD6LF2OO?=
 =?us-ascii?Q?bbHKycMlrAN3dbcJXMKiwsiKbLqtX82bmpOdKT81jepC17fA+fyEqJZx490R?=
 =?us-ascii?Q?cQ5a/zyqqF37vN5UIRup1QpJIrAd+FYMPUdgjFBS8TegMaoPUhGnQZA8fUhn?=
 =?us-ascii?Q?HSvlT9Vf5mEGt/EldHsiDzDGxMaQV2DTL/Pw1AvrQ120Fti5wC2x6JaEVh7u?=
 =?us-ascii?Q?LMx1vRoyDwwcOf5earVxknRl64KvqfwhpE1lrbW4c3WjEN33xMEMhzUl4Zae?=
 =?us-ascii?Q?bGoETKsUpY/tfvHVfMJF+8k5ryJHwwRzHz7d4iGEINQegquypbgadfQDOTcp?=
 =?us-ascii?Q?MwbKIU2wvsilLD2APS/Tmsl6SwTLQcyJkdJpipsNuxkAEbXFpAAZOm+SmjKe?=
 =?us-ascii?Q?/V68U7oMKekoB4e5SyklCxYfhVKjc59wQEI3zjIotD8nDA+iVlItuOUvycz3?=
 =?us-ascii?Q?t3HN9G7Ks2UBbdor7cTyjhkKEFUX/ISUBP9X9OCKepdurT00MuJHUgu34LaI?=
 =?us-ascii?Q?Jsw+ieOp0AAwdgGmqPM6mqdR3IiOtKQyWJh2IoGVnTah5Rppe4CasSPEtlSD?=
 =?us-ascii?Q?g/6cclVeY3avVkPixv059v2cx0ucJn461Nm/eZbUwyhCXAu5pos3eACXMoGl?=
 =?us-ascii?Q?zwE8Alcp3E/74DHkP3rIERHbBbQmgbIJbXZUkMwQUd6a4eAwV73VQYzWjX/I?=
 =?us-ascii?Q?qwk5o5gjI9X7bl96uWlqej0bW5kF13+Bt53YjxUh9TULvhNttan3rWyBOQ7r?=
 =?us-ascii?Q?A/svIwvk0/LJYCrMxyoCr+K9sZjkAUoZv6o8ZziUppZ2gXkUCrxgCALfgj63?=
 =?us-ascii?Q?WuR1AZBunMOBphBjkoILbTG1ollctKY2nc5af4Nrnik/wGE3Zgiata9ecH7G?=
 =?us-ascii?Q?1kpuxM8tqXDt9pW/GDHCQqLCy9Tjh8XF/GY7y7XWgjlsdIjYaa5Dl1cX7/PZ?=
 =?us-ascii?Q?sw5od8Yg8Xt0Qd0Qxr+z5sTXBlmlrIPfdCiplbd6vKI/fPZf5rsS1j2PEsDx?=
 =?us-ascii?Q?nuqrifjtzHdkX3ak/sjxGgAdphftf8Ty3tYJt++F04wvZL2Y0ZsvwlNl9BKh?=
 =?us-ascii?Q?maHz/bUixOkqRXNH9JluFUrlm2WQ2i2HF9PJHGBxZAWm7C4U6rUPcLmSymH/?=
 =?us-ascii?Q?f+hCgfvz5+wEbRjlycV8joKt9LDtqf5t/4agiSanRGZYywiPaDhtWc0h3NBw?=
 =?us-ascii?Q?i6aN1Fi17DfUI24aBbs1NXRagvuJGRyUGxVf7z4+FDM/5zjPHRUm9kQqvTvK?=
 =?us-ascii?Q?KEwk1apNELW52sx6jPQl5LsRZAvYFtX7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:40:21.5087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36f6f42-3547-4dac-dc44-08dcdd679a0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284

Add changes to set the controller address mode before initiating commands.
The AMD SPI0 controller(AMDI0062) supports both 24-bit and 32-bit address
modes, while the HID2 SPI controller(AMDI0063) supports only the 24-bit
address mode. So this change is applicable only for SPI0 controller.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/spi-amd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index f146366a67e7..50dfdf2ab6ee 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -34,6 +34,7 @@
 #define AMD_SPI_TX_COUNT_REG	0x48
 #define AMD_SPI_RX_COUNT_REG	0x4B
 #define AMD_SPI_STATUS_REG	0x4C
+#define AMD_SPI_ADDR32CTRL_REG	0x50
 
 #define AMD_SPI_FIFO_SIZE	70
 #define AMD_SPI_MEM_SIZE	200
@@ -548,6 +549,17 @@ static void amd_spi_mem_data_in(struct amd_spi *amd_spi,
 					  nbytes + i - left_data);
 }
 
+static void amd_set_spi_addr_mode(struct amd_spi *amd_spi,
+				  const struct spi_mem_op *op)
+{
+	u32 val = amd_spi_readreg32(amd_spi, AMD_SPI_ADDR32CTRL_REG);
+
+	if (amd_is_spi_read_cmd_4b(op->cmd.opcode))
+		amd_spi_writereg32(amd_spi, AMD_SPI_ADDR32CTRL_REG, val | BIT(0));
+	else
+		amd_spi_writereg32(amd_spi, AMD_SPI_ADDR32CTRL_REG, val & ~BIT(0));
+}
+
 static int amd_spi_exec_mem_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
@@ -560,6 +572,9 @@ static int amd_spi_exec_mem_op(struct spi_mem *mem,
 	if (ret)
 		return ret;
 
+	if (amd_spi->version == AMD_SPI_V2)
+		amd_set_spi_addr_mode(amd_spi, op);
+
 	switch (op->data.dir) {
 	case SPI_MEM_DATA_IN:
 		amd_spi_mem_data_in(amd_spi, op);
-- 
2.34.1


