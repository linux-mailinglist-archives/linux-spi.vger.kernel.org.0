Return-Path: <linux-spi+bounces-10702-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F40BE43CF
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 17:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAD4C505F07
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4822334AB1B;
	Thu, 16 Oct 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HU/6Dqe/"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2C34AB0E;
	Thu, 16 Oct 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628611; cv=fail; b=gbw/TRpx0Bugl8ghd4pxz9VABDFbl+xbqpg4qvcd5tn+kZ/t12jIhYTa/aTwClLMBytMwbW29ho5nhY2qiKxG+HfjvJtvj/PaKvyBjwdJ+pBS8rT61qljLHqQCkolqgRLTDhOBWVRa2+4cPQ+RZIUjHwCxvQknSynxRC5Ydcc5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628611; c=relaxed/simple;
	bh=Gp8xQjlF6LKTh/QB8O/ixqSwTltDnWBA0+EA9RsoRB4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aLx1nUhovtbYutu/KrCHEg+GsRQzSUQJDirUzoCl2Gj+im6OhcudpRhqYbZDniWoycTP+n/UtRmHr5gkWmzn9/uqu19YrwaRZ429hbbDqOKlvoMcQsU6GlORQOlvxtOvGaSIvlaG+8J20IgU12ot8hKx/L10NBLBo6E8rmDWO70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HU/6Dqe/; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mE51AKu0/np9h+NzJoLlXJbHgcmvlMgqOO6hadzg7IsaKkDqiAmAm/CSsNF9kOqyXj4vtUw2hsAR4VugB/pQn0B/p/zs/EaCU7dOmuMUMYDeLgFhz87xbOdl6dBaoi5AgB+2k1eN4tv0tFYBsw61KbOE89jfbUjh01z6JvNeLgu1FcgNwg4HswuOzbLFLSbiynFciy/7wwKi0tX9HA2Ol4946HkBi7t15dwnMBe4g7+e7lIlOiAK6RvnJHeaMGwkKGNhkftFgEOsUnoFqbbHI/oEaEJEDqsBhURyTl4JCReWodOgjJ5UD8W4o3EPLHG1B3YBLSbWa7B98JnIAeQIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/MLiJg51SYPDQ0KmRrlhauci0+hgrMX8yUnq9LHGCo=;
 b=k1aaplzHu2+1+BufTAI9qN9/231pi/dnZ20OBarFCKKHMNSENNCqn5c0AiWvkJ4Dom+LeMmDdOpglAhu23SsUPWazK4Ae2Yu/kTh85171MczzAeSuJ7lloa4HgjZ+egUoiMI7EPH0Lpz3beFBlpK78C74vFj/OZq3UyRneswgwwxT6fESDtL72/kTkITlVNwvXSFEcWqbLZWpIxf/wlEl+Z1tXaPdNtxnVMSQ0PmnHj+zdOx8w3b73WNX070Tr1HTaf0g/9UcFsxYCL1R8kUpLcqV2e8ei5dqmHoVVZNW/Mp6kZt7UyD3bzPFrKx8vuR5IE5Y6sNa3ngo+E7k21vsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/MLiJg51SYPDQ0KmRrlhauci0+hgrMX8yUnq9LHGCo=;
 b=HU/6Dqe/xb3ntUvwcmKJ8QCY0OZWslpSi5iD1Q3mX3srMvdcWYGIpM8ExPf2onPoavJa7EzGGmoNfIELDuQ/lzmmtfIKW8sKh8tKAgVb1+AceaGx7vt2oAWjZllDCrXJj8wfOtd9ObtKf5SBjH/8NVziLFdzkT7cc7BOAXYVTcIdlfV9pgN4ZaQpvTwQ2vJ8bdP8HpvBsncnubwaH9Vz2ncEgbdxCCoaeGv83opawwudvVDy6SX5Csy0Ncwg9eo9MtSL+QDzSJ/n1CRiqiG6q1UFLM+nCYPRZsqF5HTZEzkEq1DBcAITXqmsBhTeTprJ3agw0IyZJ/G6Q3wBf7IS7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) by
 IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 15:30:03 +0000
Received: from DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::d6a9:5e83:27dc:a968]) by DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::d6a9:5e83:27dc:a968%7]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 15:30:02 +0000
From: Colin Ian King <coking@nvidia.com>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Mark Brown <broonie@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: aspeed: fix spelling mistake "triming" -> "trimming"
Date: Thu, 16 Oct 2025 16:30:00 +0100
Message-ID: <20251016153000.9142-1-coking@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0317.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::16) To DS0PR12MB8294.namprd12.prod.outlook.com
 (2603:10b6:8:f4::16)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8294:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fc90f6-9e7b-4d13-4833-08de0cc8e01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3yWIe2/i6rcYOtUrwBjcFQRtyYjoaNnbuilPd+JObjoi1kQ5/g1kmdfvcGWO?=
 =?us-ascii?Q?c8uV31NKGNhFjOltv1gKtUclNiMz4sPuFW0Rs0L315KS7JCpFUJ5zpf1BbLK?=
 =?us-ascii?Q?XDSu3wq0+ninPgk+8qu2ceJBmiC0LbTfAMBkZeinsA0DolnmwfqZwGXlv22O?=
 =?us-ascii?Q?QY74ncR2UeeRPWwIj+afmAtfh1q0bMKjyPjoHn7YoQNdaVDYvYqbR1gRytYz?=
 =?us-ascii?Q?a0uSteAb0lfBfo3CVA6y52BdhUswGoRgfxjR9nL41e79Md6AinXU8gLTGFYp?=
 =?us-ascii?Q?lvmncm/USt9MQzVWRagTbZUUnGOF/AM0/q/NqZzI2y+OxyzvLBXJ2H0Flikz?=
 =?us-ascii?Q?it6vjJdlBsU+fp/k87RWrJcT6M+SAMHc1r4W75eEJnDCHqSn6DmnU3axpPdn?=
 =?us-ascii?Q?Jx0LmzDARwscgzWs2bTge1OlhkMDSnCW5nfSirvEuIQyD8eHIWYYWGTvbtma?=
 =?us-ascii?Q?4tnQ7LfTU3wRcI4SsDa9SoXE0yuBjJFkbZQKe94guBImjpFJ1zDm602SWYrV?=
 =?us-ascii?Q?f/VGBAv6ZGWQDQyAMH2VXicMCTkaHocAFmDYrmB5iLv847LOrEDQC4yFYA7g?=
 =?us-ascii?Q?vB+pHxkzk+SF98XWxCv63k2wCboESjjdko9RO6gRozuzN00Z4V7JD1mzMroT?=
 =?us-ascii?Q?dpggbFB0OwRZPfc+0Svmg+ObKjQK5p383Us3Yd06KpInXAA3/2Kl3A2T8A7E?=
 =?us-ascii?Q?hgbVTbuPbyFPeiOWXDjgH1C9t6wuPmOUeWEJ35EvY5Rhp8RDLBipzAhRzhR+?=
 =?us-ascii?Q?ynmssOV3CJjW6GrOu4f8n5Z4PbQHGwdVrcatfaG5prAN/h6M0Rlc8Ue/lRh+?=
 =?us-ascii?Q?aiBas7EF7W93R4nRc1tNoOTEl5KVGVc33FGgTC3ivVcS+hFqekYvcbvNt3jX?=
 =?us-ascii?Q?oBhs9cTJ5p1erjxa+q4SKTlt1GAyh5LNbqlGxD62NK1CZxcE+RakSUqErwdu?=
 =?us-ascii?Q?ZSsJZw3dppUm+XrqTBXOZbZ/bP///Eo04RE7AM+wT37unkU5sh6DEyBvuAv2?=
 =?us-ascii?Q?mrVth+SwMzkkLfMeLDBQy/jmbWUWbACqQh64dlY3EQJYPadRQxeUt7VDFq+P?=
 =?us-ascii?Q?1DoVE9HijkXpLguJFkVFmo17lBZQ0MaBcVLU4FFpWK87gLmhNj22QCiTnLE4?=
 =?us-ascii?Q?XYgJ5bWulrjPami1qWKf1Z2OBZ7Q3MrU51tq/GwqaBGRqAcNjlUfJyUnjWE/?=
 =?us-ascii?Q?mJsdQ52gZvEI1L87vqy918kg4UyUvU3WUtbfIXeMiZdmOWo4MaY1rx/FRTk7?=
 =?us-ascii?Q?/D/8HZJ45Ne69fcwNnbem/h8udNEEN/Gw4Jy+71ejDGbH/221o/oukNI3glP?=
 =?us-ascii?Q?YabBpB+FHUL5oyqcRBIW1qi9aAmChkPxkf27bHKicty0BvYcakS6IGTnQ0Gj?=
 =?us-ascii?Q?SuPrS7NS1RF+x++DoZlqro0DKKjrjjm2KZ6t9wPSPrHQfunNVqkaTBnB3ddq?=
 =?us-ascii?Q?g9+LHowN+ZKYuHFuA7mQlervFrsiAXds?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8294.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NFS6LnUO+5YM2fK29+X4UQFddWjnvc+Qwu0UIpTdIcGOVhlqmZLKCRbVwXuj?=
 =?us-ascii?Q?qf4avjmg0PxH2G9PpUmMxlofSoECTwxBg3MK2jJ4CNVHaFAYs6ol/8fpgdwK?=
 =?us-ascii?Q?5Xf8T+wX+0ICGb2Xwe/0xxw+na2cAB0Y2GS3xOngjpheyMKYVChNlHSEk74N?=
 =?us-ascii?Q?OwTeYhSGFmuEgFV7+1j4lEXU+8Cbr8zheyRREniXgQS3QIdbzfwhNLdjbJYO?=
 =?us-ascii?Q?vuGUMRhAWgaO6CG5aQqDvLIviD4OmVHI5i9hhZ4bBvVfSNZ0OAB9yF4MLmIB?=
 =?us-ascii?Q?Xi23Wy+6yPFowbsHvcDrKUuJNJL7Sb67YjO1jRuI3rsiP2zrjeUUFftclOOb?=
 =?us-ascii?Q?K8CfNqfDKMt70aHqyZlsDZrG4TKfwNagF1yiN6UGdEU0kBp1zCss/8m06Sup?=
 =?us-ascii?Q?lTPrb864PfBLIEEU6VN1iJPpHs/Aqer1+2FrYjuN8bauCKEBRtemKd5EMGWg?=
 =?us-ascii?Q?KSgdp46F3q4FhH5Nn8n8xVCERhNio6JxS96hoWGEoRjv0QJkSyPk2P9vc5Z8?=
 =?us-ascii?Q?L4OilWIHjk7G74psuFvj/G2ir4NeXzJPtCFaxukD/C2+0uJc/gbPd+bSaDYX?=
 =?us-ascii?Q?7H/619KX9zg37p7EV8Qg++8HxwG6J+PCD1OOOfHI3tO4rN3fm4MSwSRoEdMY?=
 =?us-ascii?Q?l/5mHrcU+fkzWJzeuEGiPDuQ7SfD8xxBN+g+G0MAaDze7yZU8nJR6BZJp8b3?=
 =?us-ascii?Q?/jQRkRkZmq4di5WdAu2T/onys6JbC7i8Jhdghr9zaXRGMZbXbVq2+Pnnl2PC?=
 =?us-ascii?Q?/vlyYFVAtQLr7toMv6wryaewER27jvdzkdCLx8J0ABGrHw2aP/Qe2ZnGkZ37?=
 =?us-ascii?Q?43Dr+PClGKsWaGVG5V9r4ENMWWq1gO+HhY093TvBXuCsYb6TkYYtn3lOrcIf?=
 =?us-ascii?Q?ltA+Uco0/KP+/LdvQVxTviK+0HLyMKVABtU3PzB0yRk8H8NpZdhFIunhIjYf?=
 =?us-ascii?Q?NYKdvnGgWrWHR3e1n5EaU5qZndyWI4c+HRePf7Y/ugWM3lFFnqmNi1U+Ib87?=
 =?us-ascii?Q?kFIpyp/k94IR8G0pLdkUwpeD7RiBhjHmG60V8HDcodkEgwWCMQ8eeB0E+o+O?=
 =?us-ascii?Q?qQUbQgxd1IDlT4RINCAAYGKC99AmI152g9FCAso+0hcFQgBgaLXCZ1/jDPvP?=
 =?us-ascii?Q?Iw+60uxsCGrFni6wlDR19aqDqTtdObFocycdaAYKbXCa1huj3/v3M86NM514?=
 =?us-ascii?Q?JVjPjRRJ/+8QywZyP+YICuTH+FjhOdX1jEyVTctnPDsfZV3oG86AE/vy/e5G?=
 =?us-ascii?Q?U107bZBtDAXjSg5wtBZjKkSPg0aCfnCpaoY792ZKaeKdbrZOAiR90Mpq6HtS?=
 =?us-ascii?Q?hTCwsBoyswXpeDi6D5OX89sv9JVgJwB3OePRQmsE2xL6+GHyowV1nYujeeV0?=
 =?us-ascii?Q?nw00Ej2gGRdd0BWx+n+vWWXA8p259LehkBgKiUnWIWM30BIZjsIPImf+3129?=
 =?us-ascii?Q?4caK3R866oVIreKMNhCsD4B1OZXabldzH5FtkT1olHcV/04IcPM5cdmxXb57?=
 =?us-ascii?Q?Z2R/vVqpHymGrdpzGTLrYrIar75ADA+xACBvi9/KA5Z82BNgiJVqq1SIN8cm?=
 =?us-ascii?Q?mkX4axaqgy8uTxHSpbBodBm33OJKk/aHhe9P3mB9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fc90f6-9e7b-4d13-4833-08de0cc8e01e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:30:02.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HtCjBWgmNuhsSw0fZbDsUNDUVZktD4CL4RRN2vaM9EB7KzqMaD+ppIBo/WMqRappSjlkFqu2GqubMf86aLo8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412

There is a spelling mistake in a dev_warn message. Fix it.

Signed-off-by: Colin Ian King <coking@nvidia.com>
---
 drivers/spi/spi-aspeed-smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 0c3de371fd39..f3a7189afd51 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -539,7 +539,7 @@ static int aspeed_spi_trim_window_size(struct aspeed_spi *aspi)
 	} while (total_sz > aspi->ahb_window_size);
 
 	if (trimmed) {
-		dev_warn(aspi->dev, "Window size after triming:\n");
+		dev_warn(aspi->dev, "Window size after trimming:\n");
 		for (cs = 0; cs < aspi->data->max_cs; cs++) {
 			dev_warn(aspi->dev, "CE%d: 0x%08x\n",
 				 cs, chips[cs].ahb_window_size);
-- 
2.51.0


