Return-Path: <linux-spi+bounces-9617-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C25B325A4
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1C8AC6A00
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AA51519A0;
	Sat, 23 Aug 2025 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="v1lNTA6S"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020080.outbound.protection.outlook.com [52.101.84.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD10912C544;
	Sat, 23 Aug 2025 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908208; cv=fail; b=XZTuNqPGXf5jFfHwoSdKYce5grgO8s8ZaHWgRW2L5gbDB8T9KQtbAyB/ekt4VA+4XMddh9qwnaPCDlUpKyvfMFlKKjT3fEq4GgLJmEIat6WJEM93NojXKGlxIVps2I9wKcZoU4gBus4kjOKyvQInawazPFeg3W/4ZQy4oiluGCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908208; c=relaxed/simple;
	bh=Kmt2r7+5maZ8YY+BEdbBk8SiipnO2qDo1lPZMvdD7dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pbuW6eDkJ5t6yLYpDixawtgM/PK808KY5ULT1yq4lIR2B8JPtn0617EHgDH0ZilC9L1FZeetH+ot7pi2+9Bx0D72NFtd0E9WbkyhlebZMqljPaINHnflyZfZ4HnA3MHag46IyuY2utvDzJlQV++blPWukx2e11z14d2XhfZmaaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=v1lNTA6S; arc=fail smtp.client-ip=52.101.84.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOH7lvmOQS4Qw22OUgM3RDZpF6/g91a85QY3Fc+e/piHXUFWaEUBEm9PZL63oB79oKaTLjQ56jidl0hKw2ncZ/1DK9yibmw6pXGn6ZCGcg/BoZEDuBDB/eUsJnoeVHC2tezIYvJoK/Yoieg+c3B8IUbbEFlkkI1tpqukGFqqawGzkO2H8Ha0JLD3g6vjzy4ChwdHyAEk5GOSL8I1F5GcHlMD8w/qs9miLd4dAG9tz3VKpTYyhgtatFg/QgQuoyezpl/pixxSS36GV14zXkiUYBRRt5GYr1t+MZx+qLQOLH9Cf2ecO7NX83WFM34atKlDqHHMn21Kn6dj2KV9yIiOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osdycdhGmwRiBksVnkrzsGkfdGIw/fyNFUt9fyp5XOo=;
 b=oCn5C5VZCik/PV4ztMxowFa1sMhzqf+diGtuHH/87J56Eg+1EdfiLFBQPG4JwVBznxbRHv0uqsq7BwWFdK+DVlWIf/gPmKHRgEEqSmlwYHbiI9GQ7BsR8ZfkCi/TnqZMcS1gJajrb0SexChqZzEG1ASBxPuHA62fLclY5sQoV3+dQv7Zcu7fnX7LrvpdFrWqeFTVt/ycHx+dNUvzoQniWpWtNzutg3x8Su4hEcR+lFe2v3zAnYt36sO0krKVHOo4UD82/M4NwCpAHWxv+lb6PkHoDes+8CA2uj0HB9sypUOs5KvcVeXMSycEsAeM44Ob/8Ov499Oeg6nprG+CozZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osdycdhGmwRiBksVnkrzsGkfdGIw/fyNFUt9fyp5XOo=;
 b=v1lNTA6SPmVbE4+5tU+IxvSxTcCtHEDZd2vqtF1hSMAyHeQkZJwj5gLezSBecTixKIH69T/0fnrgipLX/++H2wX8/mwXBez7nSXkrPM0GJ9aJtCim2TKmGiL+mxkZj+82hfxFD1Bss7n/vZy5DlmV1u3TLEvubvl6aeeODfhsdVGDFDGHWckK8VUYYJCaIjXXOH0QRSR4gVszNz/bIhcHsb7RjVHAulf+oOGXaMk0yozDCS+2HoikLpWcDlN5cK9ymVwlqCxuO/09E40VYo02EWwHWTlNjUGm1SaEQR25O6OU1D0+jZ7ew2qrwl5En7Z/ul3uI9/BFeuCDDetGnlRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6398.eurprd08.prod.outlook.com (2603:10a6:102:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 00:16:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 00:16:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 08/13] spi: airoha: support of dualio/quadio flash reading commands
Date: Sat, 23 Aug 2025 03:16:20 +0300
Message-ID: <20250823001626.3641935-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: f5539931-d7c8-4986-04e9-08dde1da55a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6G5t7Je7v3MmyYELNSiHC+WbVZw+kvhamNswb59XXbIYEzVa3etTn7Cjtksy?=
 =?us-ascii?Q?JS/6ao/oEEC4D6LrrcnAnGHqapAYd8Jp/4Y+VlO+nw1H7WI+dvmDjvOJ1XjA?=
 =?us-ascii?Q?ac0lttdmW6cvw5dPWo65+qXWoz90O2nLYq4Du+R1Sp0F+W3Jiwh1xNidJ8UX?=
 =?us-ascii?Q?eZDtgmZH2JRvJSQAWKwImEidhUB7hHOD8bBN+/uEwGaZ8EY5MkkrtZ5ATCtf?=
 =?us-ascii?Q?Vgy/orhDFsLvXLP1U4h3DRzYfV/qUMaiZJkjvdL8+IMsNE+4t+EoFu49O1Aa?=
 =?us-ascii?Q?z6OTmKTn/g2obkjRQksa3YR+4yFYD14X7xBS2RXVIvHOjIVYYXKodZy5tOpY?=
 =?us-ascii?Q?Gm9XXDfyK49s+oeJSCCHMoXdSBlTjhXXMedZeA8h1/TTThyCpYQpU02pKAaF?=
 =?us-ascii?Q?JOFoIs4I4sgLq+ox2kJRdrScKejMcAN2dxjiyfuoQrhAgXQZkVqQ8N28ovz+?=
 =?us-ascii?Q?wFpkaKbh3otsv7Z1w5TcB8wyhMqyYA82uRUM7U22AiXTCTBYU4qagdCv2eyU?=
 =?us-ascii?Q?L/SyhQ3/TxaAnOnWQnFsChoW/yYl7PfNeoZoxO7Lm3xs82+FJGWsBWamHXbH?=
 =?us-ascii?Q?1/5HUh4f6bmsvOsPtAvfpak1VQDfXhRnXmNbwrS0jXTgZEyYYIGpMOVLQcbl?=
 =?us-ascii?Q?+wl5aOUnlj83qpZ/UGM7fazkCK1+grbnKT++L9nHLm0pFcEfhiNk514SyWbO?=
 =?us-ascii?Q?pBNsNvPNtuPd2blKD6UpOAJGDk7Is1J7eHc52INMxq3T/c55AjvyP1olhGMo?=
 =?us-ascii?Q?q77uQ8ukw5hAYq54rAYgKgQ6ey3dNGBkM8FH+OWyHmj+Wpzvad9Mcb1f5mPQ?=
 =?us-ascii?Q?eLFeA4t25W8IsbVFCl8pUFwK+AUSGoOjxoQtkE8z9nGPGG18rx7zP+QnwLuJ?=
 =?us-ascii?Q?yWT0+rLpg0BRDxUwj5OBx1FIiJuPrMbCH3sME0N1cMFe5VLeWQvndBdB7PyG?=
 =?us-ascii?Q?bDwOX6+MslfGM4IWKu+CMNQvp93rnN6NXH3rX3Ih57ETzi2KXMmFI/rO5bb4?=
 =?us-ascii?Q?bhEUYsrKl8kgTAZ24eW5umsTO1ty5ExOn6SpIaKBkSrvu1qeozmPYOGSOe6o?=
 =?us-ascii?Q?03DSMb71TUxo2HqeiaUjwQS2S0uD92dvGfEfoGiw7lcSon3av5G0TGNpAHym?=
 =?us-ascii?Q?pxsAi3ZaSZSR/0I/WXtzXjsoUdCrnbT+sol91wGFftu1CJV8yjGO/zep3dqq?=
 =?us-ascii?Q?sY9ar39OUsPvOPnfNuud6OasqNdSVZGtZYW4aKBYzicJ5a5ZdnR8COwwICup?=
 =?us-ascii?Q?Toyuagw7M15ZY4BmUTKE3KR6mwrJZ+ICo2rfueg+cUuX3u4PsQzBwTBdVOYp?=
 =?us-ascii?Q?TcQmgYlgeu3aBxi86IiGyXTZ/nU049lQYkM6/uOiwrwbr50WF4f/L1YiJ65Y?=
 =?us-ascii?Q?fmQNTO2EDks5TdwvTohIDP7DWi0OKkW4S3mSWf0mboDdE7n2bijXpVTIvdyG?=
 =?us-ascii?Q?Z07Bopu7SIkh7QxmZ31oybCh7jB8PKL6xx6ENUbcs7vuGefLlL5pBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FXPzWb1aQcYWY2/+GYBzVYlFZA2U3fCr6RFQUX4hichGmWUHxjBpi2zWSkml?=
 =?us-ascii?Q?LPrg3WL4tI/ID0muX+i7V/FzBsC/hZ90kGMyUPQSt2jjA6Y0RKf+jBONwS9F?=
 =?us-ascii?Q?2EvHW9rhAM+x3YxjdnZfMQv/rSZaKDi7RGq05vQHmT1FqZ1Od0LkEErQp3vy?=
 =?us-ascii?Q?lHT4w9Hhfp3d9GTLoahPlotxt9G62FASV/jgdcLNEG5r7WfyB7rGxNptZTjE?=
 =?us-ascii?Q?7Xt6Z+4RiyMw3vAo2EUe+q1nHPYefXRaO1cUzu1lJ8S9Eq8jOi/e+NM0LJjV?=
 =?us-ascii?Q?JTdEGaxV746RM3PYllIyA7PrG1hGTNtgf3rR2Thma4/ZRI9EgAVoduglFi6X?=
 =?us-ascii?Q?EUPiQEmFpMpQRdzeGvftPbml7i305rdajGjfhhNlqERP6J66fGziuzH9X0TI?=
 =?us-ascii?Q?+frxMyRZqfVIR/y51tXa5TsJbTkkD7jO9XVkQQj8ZuxXGKku5UhMu8340xWK?=
 =?us-ascii?Q?/qrCCSEpnFjJJG2Aur3sjCNRMTQLbgxPrRDJEYraxw9XpQdVuDEvkTdEAMXv?=
 =?us-ascii?Q?5a9IipPsK7p9rGJBpy5IAqQNmuGu8HCB4bq0AqeUvV2s3FELpn9NKMeW1dUD?=
 =?us-ascii?Q?4SYqasE7+7TDPa0ACQCfFT0FW7PaFIZAk3+l5a/tMmtBOEwV+QPDkfj/L0Kk?=
 =?us-ascii?Q?yZ+AAn9dF934e3bdOfndI1KqlPyOLmrjw/D4HydBmumDMoGNgK5VD8gKvR5K?=
 =?us-ascii?Q?4M3GpsCS7kbNve5mH+WCtYini4XEyXJn7tSg9M7t30bgd7de92PMBYvrCxzO?=
 =?us-ascii?Q?UFn7Vc+KPJOxoNXP0rEMXsnQ6Fa4O5FwjI/7p7mf4Ndc4bZNYhM5CKlvbE3+?=
 =?us-ascii?Q?I1/T/cAQL975snv6JHfg95OkZAHe9hQ/MEVd3vWfY7O1t6Gg/SqhDDTvrAvj?=
 =?us-ascii?Q?Dq1y5uiv5Va5dFgG+dJzOyvEUVrX9mL2XLDMEpXnk8KZvOgQLj0tbAP8+1qz?=
 =?us-ascii?Q?iRALddfcXygo2RRQC9OmHBEID7K/o+PECDNI+fVz8IuRh1mMcXyDgBghz/Z7?=
 =?us-ascii?Q?yz3luMlxmDnBTD9BCz6J1MZi0CokSB8hcl3ydbwVP5qaKB6oy2JfzYZMq8V6?=
 =?us-ascii?Q?sAZte4u0+1Kw+QBv0SL8Rjs5seelOixCt4Ai3SPc1R2TbNUt2t4y+jZIO8UO?=
 =?us-ascii?Q?0Pk/2BnTQrLQXobeHDGYa9QkEootNGf3SfEWc7MYwbp4l4IEl89y8HK+X/cv?=
 =?us-ascii?Q?913en1x4ayFWY8WaXtNqQMQnquoTNKZ83CX56hXysi0hCWGJ1L+Lbx33XH+f?=
 =?us-ascii?Q?FhNpxxXwuYF/lFdFbfvca25gEXroeRm0rQD1rry2g4CtEIYtxCHRceZsmQyu?=
 =?us-ascii?Q?v4P3cEMTKA8PF97p2pmW35n1pBXx7LbkB3VdZuck0AaOPFIkufePz/7ZcwNi?=
 =?us-ascii?Q?oYqtubE5qsXzBdSf+O4rr5XjtfHcD4pmQHzmHCUNX4kqW10WOVufhZwrjjmz?=
 =?us-ascii?Q?iea++VZFMtwSi/dwENGnWlV/u/R14h0IR0QhSWYrYck2m6XwyaEz1FtdNwJ2?=
 =?us-ascii?Q?CBbXnXNmM/VdwpBe56qwA6SKSRYRYzfwERLF26cHK8HZ/Ic32I0MRvLGpqcF?=
 =?us-ascii?Q?haruZO876W4cnu7/dWS/E2ABRsnkxf0Xn2u28mZO6Hx8ZTTtOsEseXB07C9K?=
 =?us-ascii?Q?KZkntzu3TDNbg0arb7Xcb+w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f5539931-d7c8-4986-04e9-08dde1da55a6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 00:16:41.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbvNJ89Omq5OG5zXDi1pRGcyqO5IH6h7cn+ZI3Y7rnbjJSd3VuRZkTjPUb+xFG/uthWbOX9o9GScqM4j2ZfvcU/VxGXSQk9Jae915fGnjXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6398

Airoha snfi spi controller supports acceleration of DUAL/QUAD
operations, but does not supports DUAL_IO/QUAD_IO operations.
Luckily DUAL/QUAD operations do the same as DUAL_IO/QUAD_IO ones,
so we can issue corresponding DUAL/QUAD operation instead of
DUAL_IO/QUAD_IO one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index df2d3d717c00..4587147f9cd3 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -147,6 +147,8 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+#define SPI_NFI_DATA_READ_CMD			GENMASK(7, 0)
+
 #define REG_SPI_NFI_RD_CTL3			0x0514
 
 #define REG_SPI_NFI_PG_CTL1			0x0524
@@ -179,7 +181,9 @@
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
 #define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUALIO	0xbb
 #define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUADIO	0xeb
 #define SPI_NAND_OP_WRITE_ENABLE		0x06
 #define SPI_NAND_OP_WRITE_DISABLE		0x04
 #define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
@@ -664,26 +668,38 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_device *spi = desc->mem->spi;
 	struct airoha_snand_ctrl *as_ctrl;
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
-	u32 val, rd_mode;
+	u32 val, rd_mode, opcode;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	switch (op->cmd.opcode) {
+	/*
+	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
+	 * replace them with supported opcodes.
+	 */
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		rd_mode = 0;
+		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+	case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_DUAL;
 		rd_mode = 1;
 		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+	case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_QUAD;
 		rd_mode = 2;
 		break;
 	default:
-		rd_mode = 0;
-		break;
+		/* unknown opcode */
+		return -EOPNOTSUPP;
 	}
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
@@ -717,7 +733,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	/* set read command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL2,
-			   op->cmd.opcode);
+			   FIELD_PREP(SPI_NFI_DATA_READ_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.50.1


