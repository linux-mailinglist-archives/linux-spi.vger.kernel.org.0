Return-Path: <linux-spi+bounces-10376-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF43BABEBB
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 09:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EA13B4367
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01C62D94BA;
	Tue, 30 Sep 2025 07:56:53 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023115.outbound.protection.outlook.com [52.101.127.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428A2C0F87;
	Tue, 30 Sep 2025 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219013; cv=fail; b=U3+5sO4FxCPLDbuGTI6scpEoBvxAv3lvhMoMKuMxGmmjX6kxF9Krl8EP12IapxG07W1zjoT65y8JrMRaLrnNKmzi/UOPYwXBONnpO+6qf1v9WM7N6pqDMYYdVHGMW3e7Qai60M7+E2ClYu0IK5TtXXJT/zbKfvwLIelc1zeBNtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219013; c=relaxed/simple;
	bh=jb9rGcRxrG2ji4xfPO/13t/Wh9mDd1HK2S14JYqCGe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTSf6ODiqsve3OhJSQPVls2xCk0qKoDRn5xJUHsF45/cN5Mx8Dys85PESzftL5zrTp9RxX9xd3MWxAR9NKxZqe7ZQae+rNjTxAvrwBNHBOw3qDY2aKoOEMDQJjFmvKr93r2gxfR5sR4Gg3Meakc3bbqOKniQj3vb4k7gc4gTsC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqqZNZlAAOlGW8Wmz837uXBETMogrDadLkOFy9M8A5g2Oc2TxAF7nl1mYFxsYFdhHSm5hkePIkjDnCul/R9/ZYw23SRCjBaVpiT3Nz4TDCjffQNWYawz+YCmXRUhmCOVQdunR0HiII/bd3wJW/7qVL/+TI8JmKdoCgc25nRzuDBkss9I6zATAAT/6BBeDbDoI0MhWhzFEU2wj2T9sZgyqE5Xm92IPhyuIKqDYvytcqRv25s+4FL9kkGJr3ThGrK5FqqNQG+nnpYmp8N/tujfJWOBP435a5gtmt47O+3J7CDhXZWPakrWC9LOrlBAtGeMCAc/QgWkctGvNSDtBwlVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkOwIawL+erpluYuJ2Z+HFD22cqsVNx8iFKFXLqrnA8=;
 b=r+9MfI/zAxK3H1DEf27whlLDMj3wiR36xaQtTWb4YdnNfbfWO/D+9VhH0QBJ3KZTGMSb4L4Kn1v8cBYmVFk7dXpulcUNoOfwE01OiuoNqGrvtA36I+ErY0xMxrCpIA5E+VF9wNecuUMc8qo6S5yt1qV7HfnS/5kWTJM+SsqvKENDnP0FjRv5wwQvmvc/vr8NI9EbidlU4i4oD11oNby+eiR6bBra5qzRx1WiCfEhSX7ABdLJyPjQTGc41ntGzDz8glhVbpNGnc25fcAJN1Rj6YRmffWx4T5jd0WYdUN9C9lIOlf59GiQDwB+6QCCixFgzst2yagsAgIxkExJFrVikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS3P286CA0058.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:200::16)
 by SG2PR06MB5216.apcprd06.prod.outlook.com (2603:1096:4:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Tue, 30 Sep
 2025 07:56:47 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:604:200:cafe::36) by OS3P286CA0058.outlook.office365.com
 (2603:1096:604:200::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 07:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 07:56:47 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9F9084115DE5;
	Tue, 30 Sep 2025 15:56:45 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	michal.simek@amd.com,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH 3/3] arm64: dts: cix: add the fifo-width configuration field for cadence SPI
Date: Tue, 30 Sep 2025 15:56:44 +0800
Message-Id: <20250930075644.1665970-4-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930075644.1665970-1-jun.guo@cixtech.com>
References: <20250930075644.1665970-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|SG2PR06MB5216:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 93c57463-9daa-49cc-d247-08ddfff6e7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jdvid7MOaEBwHuqbDSdr2dsZCPgXK1CtCnR/Dh0+JwJ65/GcP3aXtgoPKeiy?=
 =?us-ascii?Q?ohMYlYJr2jUsOOO/xw8NkNgOzNBv4msr5awOav13HL2tVQrt63PR7YQ+bgcZ?=
 =?us-ascii?Q?kcuuDICFNjiOETRnaBm+mN63yk6qC59n8qyplo0wrmchdNCIJhn7r8uccu/a?=
 =?us-ascii?Q?Pe/cwtijhP0rh1u4Fsdh5819zr6sK1vXm7jedt3MCAEXNlNY9+lUDWYuWIkQ?=
 =?us-ascii?Q?Gt1PA0VctvYHQ3LR0Bu+j/XYCyOXZFKGY9Umjk3qYi9RC8PE9xlpHcsSI4pE?=
 =?us-ascii?Q?OFd+WuqUQkHlzvzuzuHK/ntxg5Td9mAt6N9Ghl9+Oav6XHsChllIh7RqbOI/?=
 =?us-ascii?Q?4wC1QmPnMdMBKnqiR5DHedtZcsIlmk8T9XxS/4Y4UspoUQPmlX0seZt38Qe4?=
 =?us-ascii?Q?xP8qDFEWqomwzYTtve66gD0m3kJrayYq0gT59Xjuek0dbUQxRWuE01hOAbCz?=
 =?us-ascii?Q?tR62wUVq8exUYfuu2Q0h3GuaqwGRpBnvW/UtD8KCyJc9gban+aQpj6oB9bVS?=
 =?us-ascii?Q?jnLQYqkzieD9uZ63yMCojgPLFLBmkCJSJbvuAXTlf/sckzwqctBaFKMah7Ok?=
 =?us-ascii?Q?LnsUST7yTvSUhWKekDKn5Mw+P1gaj79/4X5T1kaekNyoSUDnCGCtpKTGFQHj?=
 =?us-ascii?Q?oMp+Ef7hCaxAHNTMSi0zwgKwWEgVpVKfVumdUml1dWjOFhGkkWHXDhOawu1r?=
 =?us-ascii?Q?IDGZ//Ve2HinScFTl8IO9S+YtmAMKltKwuCrtqaMyvqST7nunFe5e2qEMx0P?=
 =?us-ascii?Q?RgJK0O+yc/G8mFJybbqcdmjPrCWLhGQatlunuXMJp/5iqG+kGdYnE424WLk9?=
 =?us-ascii?Q?2Ir0ySLHWNN/VKvZqj/RmECypHH0Do7zGDK9x7PUTJV3+7CDI4m1EHo2aNrs?=
 =?us-ascii?Q?obXjl/kftmksVYhFk4fEn/h4ueLAtKkv9KA9m7Fls5D5vvVgsZCq4qbIjdpv?=
 =?us-ascii?Q?1u13YK7xWBhD6mfUeW15pTA46Hj6umJx4IXj3f32BIFlGvspAQ5M3wGeQrQX?=
 =?us-ascii?Q?D+yHK3C3FympfN4gY692kLO74tgsbw+eXq7DeTIaPq4rt+H1npbi+zPux3qi?=
 =?us-ascii?Q?3tgU5AaXBFJK5tcMR2GlHAIps7GSFlOmP6UF9hUzk5C03GD1d2yobiS6jF1x?=
 =?us-ascii?Q?pi1Ld6FbdODUnXjGpTkZeLA6JHrtm5EviMvjUL/G2IiUktELZWl0MO4qg+eG?=
 =?us-ascii?Q?FBr68XczRSKURRccfWxlM4kLsup14Ys322Yj2TszaWqKEXjk1ITECE1O0+XP?=
 =?us-ascii?Q?4bJDH/4CyjZO2f5gjokDQsQYzgHAgisJUr/j/dRzDbFu194r8Kpk92IwKZ5O?=
 =?us-ascii?Q?ODeUKoFR5jNm+TKT3CNyuH4hSq+Aq1vJW3W/OhYtSaYlsK8dImWV/vSsVOEH?=
 =?us-ascii?Q?5BbrrO+EQ60K6UTueGxDX7kZ8t59ZBKjLrwWhk1yJzqC6HXyxf+5ZzD5zCc6?=
 =?us-ascii?Q?EVEP9yK+w/XCSI2ISmgwluMy/lRwRvfNwCqEsXaXyvFqCb/cmjPUbxE9EDuf?=
 =?us-ascii?Q?wrVv9kq3GzKGm9Hd0W8+FwvDtLAa1HoMUGdfNpnIoJEV+beixxc9DLMSlDR7?=
 =?us-ascii?Q?2L+SDfncWY5xW9T0ARg=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 07:56:47.0586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c57463-9daa-49cc-d247-08ddfff6e7d2
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5216

The fifo-width is the FIFO data width (in bits) for the Cadence IP.
Configure it according to the FIFO data width set during the chip design.
The current design of sky1 has a FIFO data width of 32 bits.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index ea324336bf34..c526b92d62ff 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -271,6 +271,7 @@ spi0: spi@4090000 {
 				 <&scmi_clk CLK_TREE_FCH_SPI0_APB>;
 			clock-names = "ref_clk", "pclk";
 			interrupts = <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH 0>;
+			fifo-width = <32>;
 			status = "disabled";
 		};
 
@@ -281,6 +282,7 @@ spi1: spi@40a0000 {
 				 <&scmi_clk CLK_TREE_FCH_SPI1_APB>;
 			clock-names = "ref_clk", "pclk";
 			interrupts = <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH 0>;
+			fifo-width = <32>;
 			status = "disabled";
 		};
 
-- 
2.34.1


