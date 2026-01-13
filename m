Return-Path: <linux-spi+bounces-12338-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB709D196B3
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E7B13072803
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E87D2868A9;
	Tue, 13 Jan 2026 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ocZlStR5"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C62836B5;
	Tue, 13 Jan 2026 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313831; cv=fail; b=HPPgdLo2YU6XSJ/5K3DoyfD79GAxp+N+vVKW1rsMTHO68CKO1f40aekL4W7UoN0wrxNLOVyLCRXPvNu0AfigQe3zWK6vROkcFx7D7Pvz486lIhwaW5Qealil4DiKR9MxUed0aJlOLpe2PsNWvsppfTIuMb6K+hCxebZXndOWV1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313831; c=relaxed/simple;
	bh=SVxpRPi9TTYHMYNuzx97FBOU4jbbAT+xmI4+MXipMMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2FQxh2tU5kTfNUPBqurXR2lsxyf/g+h41ZCNdozgf837p0I9ObJLZKFsuZnmcrTOh2lSQpw3NrC5rvPg0a0XXlugKPV8KO2k0I3nwze6/ae1U2385awhPwZXSRNXgFm4yu8luNboYsJknw3gJwb1NoyPe4NCE7jlx/FtHhviG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ocZlStR5; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDzPIfGswabtboUUJzwap51iWM+nRgnIpwB5HZHv8gsLSGqQ8I/orNusYSXcJSnvukVGojfODIGT4rDuiI/zgl5tfdE3siySl3O4UD1bUYfEo0bCSyWUG+H9eN673oMn4lX+rXKrRoVt55c52UrnfFxYjf00t4oiyqDcWaJk71H1QebaNSf4oKOxnQBy3MxRk9LHQb8puInYZSslic19rMsiJU33z4xKxr5FyWDbUznOZ7D511fUCmxVMa6CNWF5DYzN/B1GMHIS9YXe9ZIkJNMwnQE5HWdSU0Krk6OXtbc0GdBjcdPJzmkJvkO9wpphxgGF4UCpMHLIK2o8VUPpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGeyI4nLCXm5Nvrq+AtCzsodogM9Wab5g1wpcgC35qI=;
 b=JpO85nEhlPW9KNpuDzI6W4hOhsh+alEFG8pDqDkcX5g3XDdC/xd+WYkeqrhUNsZKTEpxQykYUttWpG3cIC+lzZsR9/dYCK7hLDW6757+Xy3k9wGMrbyTCiLkaZO6mhHIgEODl5j9uq/wvqRlf0EbYVpS4R5xbgz35nsLAy3dDivBa3ujBnSE6tO5ABEOAdGCFIkW1/1UV9TwUJC70BAqtB5YWmTHIPCNWyU2YhZ8pw42etvOTTKbnSM0PlLCduJ6ktOems3hrF4sLbZ4r3orcMmyokWj8Xnn0PgKATaicLbbnQsuBYmoK2lHl5KG4qk7z0CfvU8PAQIliezSAeC1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGeyI4nLCXm5Nvrq+AtCzsodogM9Wab5g1wpcgC35qI=;
 b=ocZlStR5G6Dx7xcL22QzwMTrxlaNDqtbHhVzZmWBLWVdS9XuUKgOKBBizaoBzpf+3VO06mW4IIP16ewo/X4r0leJ+bBqmN29VcLeoT1s3gGBjdZ5aY+MCBSrkDxxPgCa6WdHHjvzlkezJBb0dgeFQcc3mYQECZaVQ4AeJaaE7Ps=
Received: from DS0PR17CA0015.namprd17.prod.outlook.com (2603:10b6:8:191::23)
 by SA2PR10MB4443.namprd10.prod.outlook.com (2603:10b6:806:11b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Tue, 13 Jan
 2026 14:17:00 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::ff) by DS0PR17CA0015.outlook.office365.com
 (2603:10b6:8:191::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Tue,
 13 Jan 2026 14:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 14:16:58 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:16:33 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:16:33 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 08:16:33 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DEGLok2381510;
	Tue, 13 Jan 2026 08:16:28 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<mwalle@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
Subject: [RFC PATCH v2 01/12] spi: dt-bindings: add spi-has-dqs property
Date: Tue, 13 Jan 2026 19:46:06 +0530
Message-ID: <20260113141617.1905039-2-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113141617.1905039-1-s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SA2PR10MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd4ae85-4c3e-4cd9-e923-08de52ae69b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|34020700016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3RMg5wb397WFQRB6xEiARCDM7igE7mYZiZ03LwjzoHUDlaRn4PrE5MsKRGSJ?=
 =?us-ascii?Q?iamfMGRflW81c8ufYE/x+v+KeEzf1rtJVH+euSPvCRl9kfYqPyJ6L36oUy32?=
 =?us-ascii?Q?8Mc/7Kb3lHy0lVflB2hs9CtRyrN8olb78mlPKfFiJq3b15Y3uPUdBJhdZVPR?=
 =?us-ascii?Q?ZkXyLOmADLEK8dxZM3pVrlHFC/DTD5zgv5DLNqngbBCLm37/VTqi7Yv3znip?=
 =?us-ascii?Q?RWRuJI8AVpfrljJKYV/i/+gW5r4wDhAsDPQHPW6UJmjtWQqc7zMNnrIAdUrp?=
 =?us-ascii?Q?TqqKhJ4Do8jR1lZqsbNLOwLMbUIVt9jcbymsJXLr9HOS/Q/dYUxMOOW5bhR6?=
 =?us-ascii?Q?6I/5cMCiOlKcwZPu4LdmdwZHCPJmGM/kF2YP6n7371vvbVW06TGe2LR3dAIP?=
 =?us-ascii?Q?me3U7Ni8x9ZD9S4X27NYEtPwCtZVQDiHZoFlH7a7kauAJejYxp7bXtYkYwEq?=
 =?us-ascii?Q?Qo93MmRdrYa1aIhlwmvfDAkVDHAoo6qClavazJsQVvFpr4JCqQotekQ8RO+g?=
 =?us-ascii?Q?WLzuxoBVlpwjPuri9He2ZMrm3wUygSTN8GjqcmZ9ajxw0M8WLyr7KCAUlBPW?=
 =?us-ascii?Q?hRfPjKGz48rMfWu41AeBRVkVQv6isQ/xMW1lFsNjWn4TH4w4ffXNKRKkkhJ+?=
 =?us-ascii?Q?3MuKTRRzDNS/OGgtrP87B7LJh1lB7GRpvsoioK5pH/pymilER/vipw98J3b9?=
 =?us-ascii?Q?lFR+FQ2xOcq4bPB0JGE9TPlngyKCguMElroVlOAfg3hCM5mYxnRyEAmj4O8a?=
 =?us-ascii?Q?snU8ZhdPKXdp7Tnq7lnKM1m4iIDQOSvbC5kDDIDzPygZFg5Da2NRnIBFbikj?=
 =?us-ascii?Q?YRSQ6hE7/VX+dPWKiN8FDj2FJLdGdJjbDUopzxE1cQYRiLAnJUAICYHnxLLs?=
 =?us-ascii?Q?JbSWBUFUQYzuwZCAqfSxW2bqyh5QXUsdYRnxwd9qrKZU11fIyk2L9QnGr6yi?=
 =?us-ascii?Q?UchWuV31lEXijlpp0RpT3KYkKpYzgYsilme412dtUCY3qLUy5wmwElWc4QXz?=
 =?us-ascii?Q?eojnSXrhB6n7X3mQIS5M7nMbXAIhvN4kx7xxoHrfeLmWTtXaYz+lu7MTPNQH?=
 =?us-ascii?Q?N3I5Gp0qnROZv/zTqUkAKn3UvRA4fYbA6pdDF0XCOwGHzDHZKe1+uk9WuF1R?=
 =?us-ascii?Q?qMq04KccvGO9rX6VuGbr9SGgcQw9wLd0MToI+gN1fojk5yShAr14PaGqIsiY?=
 =?us-ascii?Q?U2zOCieTcFb18BoL50FoqF9Kd49PAV8zqGH15zsh0yjYkDB8NmrFtHt2LYhn?=
 =?us-ascii?Q?1Exa9PfGuY+Ecg79zXEbuw9scbcbV/4oIGD+Towk5YjzchjRnsxnIQRBslzO?=
 =?us-ascii?Q?YE8VegeCCtnDWnRq13iKnuMAK7Bs8VrLzY/fF6LaIQJL6mN9GE9uW/Ff4jxj?=
 =?us-ascii?Q?Qaq0dTsaOpCmvwNF0h9D+UEHI/SZozM3WjWjOXek3AUwWLhfWRqr+LMlR5bR?=
 =?us-ascii?Q?kyBgWcI48+G/OfGwbPkR7CHnhp4Ms+W8nik8glyys3jG2Vvl9tpjU+/CW0S5?=
 =?us-ascii?Q?yOhbPt91c9ItgxXvpx5nGIqKFgEFMsE22tbXMK82XhpQqkjv6nKMI27yrmgH?=
 =?us-ascii?Q?VVWARTODRSynBXEu/sh67s9f/QhPXECtxnOPE7jw?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(34020700016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:16:58.3359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd4ae85-4c3e-4cd9-e923-08de52ae69b2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4443

Add the optional 'spi-has-dqs' boolean property for SPI flash device
subnodes. This property indicates the flash device supports DQS (Data
Strobe) mode, which provides improved timing margins for data capture
in high-speed SPI operations.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 8b6e8fc009db..c6f330fd32aa 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -89,6 +89,12 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  spi-has-dqs:
+    description:
+      Indicates the SPI flash device supports DQS (Data Strobe) mode for
+      improved data capture timing.
+    $ref: /schemas/types.yaml#/definitions/flag
+
   stacked-memories:
     description: Several SPI memories can be wired in stacked mode.
       This basically means that either a device features several chip
-- 
2.34.1


