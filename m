Return-Path: <linux-spi+bounces-9460-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FEEB272E0
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 01:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82C11CC5650
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2F28F937;
	Thu, 14 Aug 2025 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="aGCCHd7k"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023077.outbound.protection.outlook.com [52.101.83.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765128BABC;
	Thu, 14 Aug 2025 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213158; cv=fail; b=LBNTEuLnqvMU5gMiyfrfAyihaH3fbzxEFLQCDUsnaiZ49OM86GBVAZykOvReSIZxntW0M24CttzW6Kxtj0YE4VrnP91TB4N9O27uY3LIRzzC+X7rtjG+SPT4tjpbckcHOHmPmH+eC1YKRq2/B4amgAMLFG0xUNLOgB2+aIWQ3q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213158; c=relaxed/simple;
	bh=So9hhE3fgNXeC8u1Flp7y3PYqXCxeZfQB0NUtGUuS9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eO3wHJ4N8IPts3FhyWA2rsWkVAo9Nzf7DKnV/XRGUgCSxtCtCIQkalOUutQZq4jZel8U6TBceviffQP1hgWme7j4+NFtxIecyJxQgFsnVGd3OfuXq7Bi1KERyPeQD3mc60iiGWaioIFYwMm4elBF3CO3Pfmr7zFQivEJRKI5F90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=aGCCHd7k; arc=fail smtp.client-ip=52.101.83.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUANCny9C6SKQV/gIsYy8AhqWeDHECD3pkfmdp2DK6EUbFmOJ03UIJlOEUxyhVVzfvMj6TMgRn7CwcAUuz5oEZoXc5YeoFF3SDshvx6ocZJAHSX/se2tAeHy7sLXfqpxxb1r/zwKdnpuOf71VmpYiQ0ZhbSiDk3f2Kf2WFHXcqA/GC5pXpMupRBrl6oliPetYn9VbsoBdTWCif87G3jT1U3QZDYPgW7WVNufSQaCzz8juKgICWQqbuuNwm0TnTTsKhxR2UxICt5ohifgRNqXQEeqSXlZMGslG0hcZ/x133A0vO0spgtvwCghTekRzqsRdwjlPcXX8cLVq0a1a6KHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKfNVf1BgR50d3+YJaFs+0U6nclXilPsn10Y294FR2E=;
 b=MZGzVsLcmcPmXlw5oqZ+XOiTI0KTvgvR7YIr8ROieTDWwaC0rY5tJHYWOTogZcpMl8pzEseYqZOnp0DTNKcT0EUn7iyJFiO6DR693U4JnWDUdqQpZwP5CiBVUFu9SGyLypE6jLCZKTjgPmkEYfpamEva/8mf/AIeacUaRAwOHr9ui4Z18fe9ZrJye0AnGdKD9JbWiYFLLhzryHy+2S8kf+T6TPJZkz/1IGyKpsR25IsOwgSbiUcE/QeYc9loyawyKLnrRroK+PpTzGl3fxhDCBntrmCMhMP4FGXpdaBhoMNbigbvlqq4ggO06pJHgJ2gfd9GLf5ceJ79OJE1aUWEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKfNVf1BgR50d3+YJaFs+0U6nclXilPsn10Y294FR2E=;
 b=aGCCHd7k457jLdV2+GUDrw5GBo44s0SzuN69rHQPeoCpiOOJQXGFgxhZrY4iwVkPXCRZ6LH3e3R+2+u7kJ2+GJJAsaCJBDVSfmDUZbPcMBJmbvSMc2TTGMpnFxb7z5E5VRWLkdPCgoP25idiPr3rykD+szzJOIXTh/QAPgLKFsjZVkHTKCRUl6mYLNwfbWY4iKfi/XGPpivf7LLrPZUG9cIvqc/darI85PfImzwnnFoKjfZ0inxArE5w/HKBJQzz01H3RRJ50/RyI22T/SE9hDixQBjW54AVPCSxgmdFJVwL8kF0QN51tjRKT/tksdjPxH14jU6GgSYZbgpNR9oXTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6032.eurprd08.prod.outlook.com (2603:10a6:102:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 23:12:26 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 23:12:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 10/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Fri, 15 Aug 2025 02:12:07 +0300
Message-ID: <20250814231210.4174427-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: f993db29-eaa5-435c-7ebb-08dddb8808bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FCjemR7474BFK1dv/IYmPQzEovQtWEVmxNUgTkUQbXhWmRERqFgtIiNpK4o+?=
 =?us-ascii?Q?RvnxysEFXLd2MKRj5ewwrxFTgZxgfwqoyme7CLQI+DTp7vXtYkWaxdStwf2b?=
 =?us-ascii?Q?z8LuPK5y58a70R0MbxyUKjSNEapga59BSKAxpQQ+LZwrbX7GK4rvBjAxSDZX?=
 =?us-ascii?Q?4IYps5Jh2/vEPoztZN639xGB3VMGBBWWpo9aJG9WshlIpnjuW1PcHIDwo8Cl?=
 =?us-ascii?Q?4EdshetWrwZetNMkr1zNjj9kb18C2SeRWjXycdUqsM+kw9N3Yehy4cawSjhU?=
 =?us-ascii?Q?7+X3HWeKxBC45YNVwr2J9zHSt5ofxXPWGIRNLz5PIUg4G8vyyX3bw2xhxtt6?=
 =?us-ascii?Q?Jpt9UfHUFHu0Ya1h4c5QE6op6PCC5kILpLY5sk83C4NS71Cn/y+V+Lt/Gu9K?=
 =?us-ascii?Q?mT+YpXL3F4IJKJvMEIXldgN25wnyY7XKijHpsAiOklFtEGg6C6CroA2t7TtM?=
 =?us-ascii?Q?igEgIHYC0HqzZH4VkVanpRiFLxp6mGPbkRHNyZGRw/iq3UvEeWQyp59xSsbg?=
 =?us-ascii?Q?gJ5Pw9TAOEOzgxltOMUO3fzxwk/jswsTYMcUBZEBIYPxOiWkt7qrhUtLa8Dk?=
 =?us-ascii?Q?L5UjVudjOcsF/I4l2k41N0/U8i2eMXvPcYx7k8Wg9u5aL+thlzs9ub9hEka5?=
 =?us-ascii?Q?vkNlDRr8Fv78xbcMmVub29M9JeV6bZBn5l3mv7HupUE5v8ZMlFVx/TWYJOvA?=
 =?us-ascii?Q?lL/vwOlsFKb8yt1aT5zXS5+4W4XOH6NUBEm50SWi+tzGPOy6SY1A+Cw+eIPC?=
 =?us-ascii?Q?9fr81RVbIBXuUj2P6SnKLtcyxLvxFTr27zmrkoY9tRTEETMOyV2vlM2wc1/Z?=
 =?us-ascii?Q?UUwhL+UooIKZ26NbZwDlJ5xzsNnP/l+Jc/E7WYRCq8aGmDLSBLlNc+BRGnjZ?=
 =?us-ascii?Q?u9S5stotJBaQ14CqOJz8mQ/m/xS8kBWj376OAxnn7HxM4p7hOvViAgtyOXca?=
 =?us-ascii?Q?SYwW/J4oF2dgkAdbHkI+gZFGCE1fdw4bTwyE/i/xWhib9qlN99a4b1DJC34A?=
 =?us-ascii?Q?bk5nnKJcAnBbRkw9MyoYJ4g75jIda3x54G7sS9fxzQn3bTDTG8McRd7YOetW?=
 =?us-ascii?Q?5ADmGpOSqbcT3BVWa8fvcsxwfBZKTHVZLl33y666M41HFlXI66ANBdBSWn/e?=
 =?us-ascii?Q?Ja6L/fAtv6MSIA6lqamhQNnqeSUlrNKkwoaAEP3EcR2x2/f2faPGegDiuU+h?=
 =?us-ascii?Q?zZQKqj5K0U4Lvs5MwA99T5D0rSCjX4iroKd7gFOZZ6GuqS/3WROkfVVdklLj?=
 =?us-ascii?Q?v2lxVgi0pHgL4xwzG4+nG/R4cHaGWkMrznalWoHQfoDdUchdLCAft28Iy/gW?=
 =?us-ascii?Q?GuveBohMhVbqZFVBrBUvhyFv2KMPKcZh11XiKAXI53EIVLaA0OfbsCI89mng?=
 =?us-ascii?Q?JRP5VEA3pIyTgs+5BxzDd+8t0ES8AQtNWr++6sBU47S+a21zdk5t+v7ABrNC?=
 =?us-ascii?Q?Ij6nPlsOfEfrq9ilAXPoDRVVs0q1s3UNURM6IG1U3VBPPCesu3nPlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BkM8dfuwfm/yUxrDM4F1gdMHZGDu75a3xGgQzbOiwXnywO+RGd6ig8CU8Lra?=
 =?us-ascii?Q?oyL4vieBcbWFUavz2gkK8ZZje1SPOL9xLCiOZF5aUPMyfUwZg1npTOZ6Mh95?=
 =?us-ascii?Q?ihKxf2qcOxllmF/VTLfbJRIAOnSnpS56NxskmSfW6L3AvXoVpbBnNSvVr4rw?=
 =?us-ascii?Q?kLFjzQLU5gXL3rV1f3ovzz4p3CaDH4j/rwulfwQMPO8iBqDs9jyT8CYM3yEM?=
 =?us-ascii?Q?Ceh+4549eK5FaKW3zPGtq55O/1qqTZpevOOcDnPxQzVdMvJGubAmeGlTdoJS?=
 =?us-ascii?Q?5lrm3O2/F5I9H3SIsZ2lHrKI4PT8EBob8EfjiCr1HkAcOKowQBVyR4lPNtqF?=
 =?us-ascii?Q?vqToK9ILE/I4PTHOizhibgtWUW5/ncyeb0rHkG76uFwF5T3FIjCS/azQfqyt?=
 =?us-ascii?Q?VktvV4A+JMnNeQ/6r50t3m9yXy86dODyn/zCwllpLJShptoD0EYS7V2q/cBd?=
 =?us-ascii?Q?cU2NRAcuQLCHEZY5uQvg1WflIl/5dCIBk86nfk6HvmC+0jFisM2Z4x4Dc6q5?=
 =?us-ascii?Q?YaUVUdNtVov9MYsiJgJQ7QDb5uYGz/ieG+jmNcXMxBTCfDZjUv+4Iz6AiBtQ?=
 =?us-ascii?Q?7v2h3r+AxFI+2vKB/1acNEW+NJnBap1Vs+XmgzgRALLopATlRh6VB1+mNwMn?=
 =?us-ascii?Q?TRnndzkD4UzL5MUXegBMllBlMZhCJcmTjdALVSejKOYgnlT4sZa3KtojMatw?=
 =?us-ascii?Q?q/vwRYAsKa2IbJcR4TptgUeb3jpKgRwzI7psIiljYkHa/ICboo6Vut4JoZyB?=
 =?us-ascii?Q?D21InI/pQapMrnMzZiTN6o4boIH/kQhwvCKOtHLQHWlJ08zZ3VW0kjdPh/Pv?=
 =?us-ascii?Q?7NEnq4aWIZYIFYiRdwYD6a3YPmkBz34Q4NUobzzPceDkS7Hq9tvGCkYif4aC?=
 =?us-ascii?Q?g+w/okXnRbet7hKaBdD+kDxlk0gcLHyoERUR231yI8SqeuBmhZGhoh/DOuGx?=
 =?us-ascii?Q?cG1aYYkR99M++IbIkHRt7DsbzM+UckVK0IkmRyl/nJ/yN3NYoXecTDOL7Nkc?=
 =?us-ascii?Q?0eeTG1/+pBv71NwTUDkbply/Fe0BW33ZxrikAsIhcsRbUHHm3c9YBOx0j4w6?=
 =?us-ascii?Q?FpTPUGMvOmF0Z2J3eaXi9e6HYSgFgUsLKui5/VR+t+d91OxsgWQ6xfOKlWPo?=
 =?us-ascii?Q?8kDoRrM9lp3ypjxzZpAb/ZZuABPJ2QE7VmtV/2BgSgTWumFht6JR+i8vtDuo?=
 =?us-ascii?Q?QQyZdv79RsQpaemIB4lpN3vxf1N/K6pQP0/4ijfttj34PY1ViSY7cfSm+CjZ?=
 =?us-ascii?Q?YXWgbVvZ4N8GblMAwyVEdIj6OCTLTkwF8YgnTGglRCqPk9GSlYHLrZPf+PwJ?=
 =?us-ascii?Q?4mpSg5hM+2Ptc32aztQjuzrAZna6XKrTLLWaDh7WqQ9e5pZfZqS4/NeQDJSb?=
 =?us-ascii?Q?FuuiYI27XZreqjbAiM6V5lSH++h5EjXXssRuQnuCz+b3/KT4LZ14rWDeZ0g3?=
 =?us-ascii?Q?Y3HNMCqWwhx0KeSLXV9iM57mrLXGdOG3tOzjCGGDUNqVykffPekdMdtFDkaX?=
 =?us-ascii?Q?tRxoHkGZlQ8eFoC6vLW3Pyu+SIBJofCqKgknwnrqqgn96yC7BVgAfLoPYSEp?=
 =?us-ascii?Q?MxxgWuivrqCXlAzBUW2eFQhMUcQj+70XFpccbWRRTlw0P6bRgqKIM8gMZEo5?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f993db29-eaa5-435c-7ebb-08dddb8808bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 23:12:26.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEHHKI3lpANe2TC+hiJZY4AVPL1gNKXLoGGQnzUIzYyrcN0eMxBx1drJwLlBCoN3XY3uxZRfcxI0m1trrYXZrxLDDPSHOPQVcZr2okTQibQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6032

spi-airoha-snfi uses custom sector size in REG_SPI_NFI_SECCUS_SIZE
register, so setting of page/oob sizes in REG_SPI_NFI_PAGEFMT is not
required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 -----------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 7cef38c6f823..e21d7c8c2e3c 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -516,44 +516,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 	if (err)
 		return err;
 
-	/* page format */
-	switch (as_ctrl->nfi_cfg.spare_size) {
-	case 26:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
-		break;
-	case 27:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x2);
-		break;
-	case 28:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x3);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_SPARE_SIZE, val);
-	if (err)
-		return err;
-
-	switch (as_ctrl->nfi_cfg.page_size) {
-	case 2048:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
-		break;
-	case 4096:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x2);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_PAGE_SIZE, val);
-	if (err)
-		return err;
-
 	/* sec num */
 	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-- 
2.50.1


