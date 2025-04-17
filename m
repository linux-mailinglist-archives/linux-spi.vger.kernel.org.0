Return-Path: <linux-spi+bounces-7657-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEE2A92E37
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC398A638F
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC99221DA0;
	Thu, 17 Apr 2025 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JbD547st"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010018.outbound.protection.outlook.com [52.101.228.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C9A22171B;
	Thu, 17 Apr 2025 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932200; cv=fail; b=mYd/Use1LhEumO7bTdnUxhAeAROIJjN0/hWlUsdybu3DSHosPMKQKcGGiOmAT/L2iDYW3eposPcjetmfWN/pSfo13NVgGAZrmqmfXGX9ikhRjjnKc1HekZCC2JMiHb8DF1SYiVHLXQ0+VhcKFC7nLUHP28qCaiOpJdhEKmpw51M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932200; c=relaxed/simple;
	bh=ftR+dhN3SiqmlT4BBOoqu0CtNo61rjNO37RVNE++R18=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=R962q18J8UbF+QNr5ly/tv+qQDtiZKM9N5EtM36s5QcspSKwuYqdmkwNJ9DwaHe8tKS5JULDH8vGb5MhEoIzj/OPHF0yUaVVntu0BMgxJ1EOOwbCzOxfXRpUjlSDENdG3NSguJMimwcl98XmwGp0rEXkNigHqm2itkX3uvgQ/jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JbD547st; arc=fail smtp.client-ip=52.101.228.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFtqLzahPX+8WchY0w6TBnFjZKfc5PpXAPwF1njcC8wih8t4ui8nczfltpp8NaJegMgmTu85m1CFmgwNPPOZC6tSHVVYSPYhXI02hqbuztpMFWbjQG9onTuQcsTUgF+d6Sz4/VMJCHGOE7nXwO2Tu2nTE1l/PoDcOcB9N3txJdTj1dZ5jCukgeHT1oHrtasFNXlFUMmfYhlcWsbnsqFLaCIro63bbNDuigXdufF+dnPk7+eNt+W6n5vj6On+Sz7j2RMgXWqttvv9rVAocLnp4dJIh8qrmTDDEliTEXAbl0/zTxJ0w+gqMRTspyPdkfWmbj6faLL1DIPPzKV9YLjhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKF7YfI58MwJ0l27gOSeSwyBpnPLz2KCM0mipGn2DyY=;
 b=WGvOqOO8YoNnMwpgaa/lxEvFgt5AuH+L2vpJoyN59klbcJzUBMQMAVsk5Zq7AcdiTyIqGcwJEz2qaIvyI/pEduPAs6/Gs7X0iYpU7YOzTBGH9iZ4/ybudqI+HkI+yucpEekyAAVj9V7TXXRb65wa+dVC4g9hCdtPb5xArnaVDbJy55suFbrBbOhO9BDbA4GvG83pTNwJMFTsdkM1wt5fuFdPSezkS0Rkmjel7A0f5eECByb679SXSR9wziH/zI2YXArtnVYVBvWcAVHTcyQV/BWHY2GXsakp6ewToXXtriDIG0ySNFRB6fHXef6Kvh6bt2ZGhvyuFqLkZRscq0baig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKF7YfI58MwJ0l27gOSeSwyBpnPLz2KCM0mipGn2DyY=;
 b=JbD547stvksRALR/ag3JDX8su7LUulcLkAL88RvcQ7IFQ6OQ7Imq5OR4Z/VJBAZQXfLEqPWt52Ye3ny87WhwWeepbTxqE53m/uu4uK7BTOE4E385yZ2kthF0qCWOw6lMS1X9YrJG6HerDUPOndoDXEtxhS2fSCNz0vtZZfdt7Ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB9998.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 17 Apr
 2025 23:23:12 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 23:23:12 +0000
Message-ID: <87wmbi2x0g.wl-kuninori.morimoto.gx@renesas.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v4 3/9] spi: sh-msiof: ignore driver probing if it was MSIOF Sound
In-Reply-To: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 17 Apr 2025 23:23:12 +0000
X-ClientProxiedBy: TYAPR03CA0013.apcprd03.prod.outlook.com
 (2603:1096:404:14::25) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 999a4673-536f-428f-ba3d-08dd7e06d283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tzsr0TlhsE005QWuc3FTSu5kk5mgOeNtq/ac/wezYzy0pP2DDdvWkvOMM3x7?=
 =?us-ascii?Q?QJqMqj1sT/vIMlZ6VFuvzCeYjY4ETvhT2XfkyiN/tqDZuHZN+YXPHGFxtFWi?=
 =?us-ascii?Q?yNuaFs2cq1BHs0gZysMUbL0rO6fVRhmeyJ4a4KwLaXK1VXVzFv0hUHJcRWdU?=
 =?us-ascii?Q?OE9gKzLMUtHRnCnmV+Pn2QdXCMTR+n0G4cVy8ZZugy+GraCl5XtjOaCbQBU+?=
 =?us-ascii?Q?3/vv7+mGfZBb/38d3m1i+N+jczOFTYAa/jfqGqfYZo42kX5SnQYEnmshC1CR?=
 =?us-ascii?Q?er9G2tGCbTTU0r0zcbMila06JbXB1Qgw2ejMMzzsTYAOIAL1eL0V1dusBI8T?=
 =?us-ascii?Q?7+XS1EVC2oB9yWfKSA1X1gdWVwJL56fR5+fT+YN9oSNdzLDOBmnMRK9DC/wS?=
 =?us-ascii?Q?LOOofK7Bx+JdbIZa6OaZSEgOEBi1RGXJohNLZCzy4sQvwlQBoWzLoNGjg7jP?=
 =?us-ascii?Q?dORZ75g/vKhLqjASkwWIlNZ2QT4YjOGnIAS9ClC126zWAeak9bOfxqn8wxm3?=
 =?us-ascii?Q?uhxl+xXLg6P0RpP4dXkAp1Dhh3d03KbZjDLtG5HjrXy62XM75epV5U4ZIoO+?=
 =?us-ascii?Q?FUgqBtZA6pEEztr+rCqX+Q26z1la7PlUQ3DfAhjSMlKo6g6knhypbJnimgfM?=
 =?us-ascii?Q?ovMpQWd+WCy3iAg6NICf/Deo7HspcTi7oV1CCUdazdgcRtExmkSLCD1izGRN?=
 =?us-ascii?Q?Neqdpf8qpMyGD1unMVJmBwnYCrO8IpHBJgc2GauKk4X6GgjDHtELb7DMB6gO?=
 =?us-ascii?Q?NnDySJhuXQNuP295DJRQZRtiKzIDBgcqv7MvB3RODrkK8T8Q72ojxapHjfp+?=
 =?us-ascii?Q?JNbi13vuRAvLvukOOK2eT8b1W0RjQrbGkQqmNVTBYv1EEs6DFOjZea2FCH9k?=
 =?us-ascii?Q?WtQIBeXCvVYAa556wBsEykCrhhH/SV9ykRqXpC8d3LkMNbmAJocnKyFnTRGq?=
 =?us-ascii?Q?7vMJePj6JucIolsJ8plY4naKwjevR2Z8Pp8iHn5JJzQA8rpIRGwDalpFI0CR?=
 =?us-ascii?Q?sWHAcRSDZwfe39ErynQfz+XuU3YaIO2Yk6DQZTCVwI6nbltaMFXsiQM6eIm6?=
 =?us-ascii?Q?CIe5IPS1IJeCz+KSXhnjsgD06X/nsTbehNSPoW4R1IuWQCJDyoVGoa1a6xtK?=
 =?us-ascii?Q?K7ZujAbyhhkOIHdXTwxCYH1eERdFYkQTipLeGMICPvL0Fbpoi1UDj6V90avw?=
 =?us-ascii?Q?1h1tQdF3wSnGCNAPYZfDE9gfUk7phkXvBBZEqqvBTm2667+YUvqhQ3fbZyD9?=
 =?us-ascii?Q?koq0Q1p0hwU8Y5mwImTt0U3zu4OqibbmjNL5r5vvp4q0NKdnd1XF1GridodB?=
 =?us-ascii?Q?B09/5DDDlbEpxeOoKCEi4xck+nfvnbI5KMabEDox1emirvVG9p8j5l970Apy?=
 =?us-ascii?Q?KL2XeWrSG455shHGe30okL8i8k9mvyVBs6VhKMxtwa5UEXy8YOZFKChIRDvQ?=
 =?us-ascii?Q?abshmoBKB3Jt3AqLKSD9tzomH4pDGv/QCG/SY3RFLHiGQS5Pp9PIQeNuPky3?=
 =?us-ascii?Q?kumEuHUMwFbq790=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vEw2/AvavPsBGgiQz0Y1eQGgDiXIF1SaD4qiAARAYNRnmCfFdOKCdfPQcAhT?=
 =?us-ascii?Q?sl9NgrqGgzYTIgV0WluXlgYPcR3HHvElOJH51i065k8Ahs7Tzs+g84clqTHd?=
 =?us-ascii?Q?7butqSWz9NjUTZLozoP3nDpg9bLCF9QnQbdA5dHg7c3ozW+jpNJNQ0zlY1SB?=
 =?us-ascii?Q?2oSeP5er7D3EFPVJZVsPJP/LVCgL1AnM91jEmn1SnUw8UB33D1EBhA9q6yuD?=
 =?us-ascii?Q?RTqXeBKIEBWiFuswdytD5ppYgWzK8M4c4R/DsEzGZMuTa6J3hPU51szY0dqf?=
 =?us-ascii?Q?8SOr+Y402uRgY1ubstm6b8hVVw8fzyMbIY50xGh3jfQszskIdHYcdSsvjWc6?=
 =?us-ascii?Q?mBPeT4PrYRzKjRYpeB7CxhO4Cto6ifIUZMsDgKsyF9Bzbd0kTnrqcC6f8yBq?=
 =?us-ascii?Q?0Jd3yECPkeSOCK9S98oGAwYdPOBZjCp0+3vtLo+ayZg1PMK3yVjfciYlvaYB?=
 =?us-ascii?Q?aDTxkib6M6ytC9oiRJo8HuU0uvQaHjrxUPdgEXwghPtqswCpxhpWogudx6wY?=
 =?us-ascii?Q?voxbG3muzmny4uvtAuSYu5UZLZYsexTkFek92SE51ZSVNvdv0+24O9Te5oPL?=
 =?us-ascii?Q?T6j4BScr91AIetHstuEuGP9j/NKzzMQ1aLtwr39VtWtMMVWEZ8o3RKaHoZ5c?=
 =?us-ascii?Q?It4ws2qurWvHNvFSDRJgyTMmYbjYzK6nOXtIoRmC7Ec4CJpjFVK9yfXzNsSq?=
 =?us-ascii?Q?FR2ORrZU3Y281DVtTntdLWpXFCfpx0bOUV1EXnqVQx7rekZ5/oFZSfJ3M3AW?=
 =?us-ascii?Q?sBHfwV25gaxKWioz6MNor9bRu/3Id2EyrpeRkjAiZiOp+gh52elBGm7GV6K+?=
 =?us-ascii?Q?vzMt/XAkbjyWVn1Dad0a5iyJomO11MYVrjwwi+3diWpzbywE1Zm8zy7K2q1P?=
 =?us-ascii?Q?LEbtJhVl3E7KimKaetKi+85ftY7RdhgLiF3+CZtrs7dJOfzl9J4PUTQOVexm?=
 =?us-ascii?Q?lpQc93YXAY4TGHI8RCMpDgeWdZBCsMs6OgUx7nCiEOn/XLuXDolmikZlgWAd?=
 =?us-ascii?Q?RLMF9uCUqsi7fw6mJI268lFH6xBDE3iLB5i4ypnRnInTOLswkelsppYGACvf?=
 =?us-ascii?Q?1fEul1zQDaf104jOISR/ftPS+H248SrVdtCiGSY/yJCFghRhoqUW3k3pJq2e?=
 =?us-ascii?Q?SCbXrCIy9TyiH64C90a8OJad+jR/aA4KcKK8Uhka5JBmY6WEWbKka8JkpnVe?=
 =?us-ascii?Q?oSqy9MVvTxLYfZ357OMapKUEL0Celr855c7ZLKTcdN0vRszdWPygk5bTnkGH?=
 =?us-ascii?Q?mgQ0RmrjegUuXEJbUu5qqnnJfvFfBOyQlxyRc8TS5P0TdQtufRPMCctAhx35?=
 =?us-ascii?Q?g6y44D03VWGh+cZKZSK/eccOtxknq4FHRkMGdl/ePHmCLi7anRbNTQJZaFGe?=
 =?us-ascii?Q?vvb/RclVCfb4KNolySFRHn8+g288aYLzRjtxqOqa0yY9HHJyE3hCpy/4Ta3Q?=
 =?us-ascii?Q?lG/X+C/eORMVSAlzh9jvvzt1QwnfNLHxWv1+3iv1J2HI30fGAM/I7ZaOnTKI?=
 =?us-ascii?Q?T8wQHRXODI0+RwvWfoJkVNr1wSZMydB/nOt6ulfGgSXknelTYCw5rqomR6U1?=
 =?us-ascii?Q?mtuoYOsF+13d3xEtfsPv0Vpc2aaFcPulWldO2pyg79oRm5UAENHw2CljseQB?=
 =?us-ascii?Q?bshpcWFYCtMiDwuA3Qoq6zc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999a4673-536f-428f-ba3d-08dd7e06d283
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:23:12.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBnAg0gYUxjDGUbIUEEQDmH8oAKTcNgG1A6wjN7nPrUQ08J1WqIewEkzNFEPd2tFtauloxTkcvgv+XshfRzUoHEUPa1dA6hp8cQ8Q57/Na5IbszKTM/4FdWhJOHVw9/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9998

Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
Of-Graph in DT.

MSIOF-SPI/I2S are using same DT compatible properties.
MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
MSIOF-SPI doesn't use  Of-Graph.

Check "port" node when driver probing

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 581cec19cb770..d9e3d83fc7e84 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sh_dma.h>
@@ -1281,6 +1282,11 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	int i;
 	int ret;
 
+	/* Check whether MSIOF is used as I2S mode or SPI mode by checking "port" node */
+	struct device_node *port __free(device_node) = of_graph_get_next_port(dev->of_node, NULL);
+	if (port) /* It was MSIOF-I2S */
+		return -ENODEV;
+
 	chipdata = of_device_get_match_data(dev);
 	if (chipdata) {
 		info = sh_msiof_spi_parse_dt(dev);
-- 
2.43.0


