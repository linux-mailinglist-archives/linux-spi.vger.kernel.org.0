Return-Path: <linux-spi+bounces-7580-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7EA89151
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A3B189BE76
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2347813B5A0;
	Tue, 15 Apr 2025 01:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="n7vedf61"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011024.outbound.protection.outlook.com [40.107.74.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112CBF9DA;
	Tue, 15 Apr 2025 01:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680846; cv=fail; b=D1DlHfIH5dQDPPzVzmnplG0sMdaAMNgGsldNhB6MeNEnqH1HeVgOoJ0cNtEihaYGsHSdIRdGlrPj78WeK8/rn3jweuKs8Q3pTedzDUZ1s2PbBpMSX1XXNMb7iwa5q20iix0qocceM6o1Zfyf+Oy3MWpmeo3i+AVeGsH6z8d1lV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680846; c=relaxed/simple;
	bh=6EKmRPQy3PTX/HFOgPZcfBDkoy6UM5AozdJlLUKIsPU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=RjlCc3BDjHIwOnp11BRygtlIhTz8Vmum8qs/kEauR0ZlfCqrkaM613wYUkyIw02esHlwGk90XyFO2yclITsHhn8vdK6gMEHIWsa+TBm3UUqXKRlaETSzSdJDo2D57WucBZ3M74WmAtquLGd8/z+xFENWYvaM27g+P4JR7k7NM0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=n7vedf61; arc=fail smtp.client-ip=40.107.74.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eh/SFY78JYRc1yEn3FkfP0v7bPMIBTYCiNbYPIy4Thca6SMcwOzP5gRlcfxcNc7d1brX/GCqPAet0fS2L07vzUqryiAVBLQBdL+Il4ZMNEp/hOtMZplanGZ5GD11+TjtNUGV3Mc8ABC2XfXyGvm9VZeGizFRbvVGxJxC5KL5wuYl/vDJEHYiIsjQMHg6QL7SwRWqY6Qb/ZKGKxoWc0kvjTCjiMgW6/DeAG1W//xEH3W68rX0XSsegAoEbBSS5bGGciP53X55Efl8kFz7ldDwlhiJn2rLWLwKxwARTYCiV8GIapF69Q3EdHXzybKS4bP0vdQkT0ShjNNFDyxzX1UGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeblINjA3gDd+rLDnU4XjYX/aHvbGiM2WhuEg0FVkBQ=;
 b=qAD4pc59rDtnxfcfjXll7zfa83HJAIS9ncE1w+qfeuXlg7OtlXOVpdn+mqoqS/rJCt2Y80mNXczRxZJV4N5yMlPFwcTUpL8gpOShPhJS1p5VhV1VaPWd8I5hZscN1/Boa3hweBl697U62kh2u5PbcWWkUtw/bW0fahfLaOnt3fVzdurahBtZRZlhcRH1XNlQf2BiRNEDgjhBZLAU0m2qwfJKoXvtx0s2ls6Pph1WmWPsZhJpH3XlBKDHQhHI4WMIUGqwBhWsDtMZ29S9N3xwjR0AUQKhLO0OXQJkmuSq7qmvh9VRJGurNj+YX216ri0uKNO4FIhvC7fya1/8hadejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeblINjA3gDd+rLDnU4XjYX/aHvbGiM2WhuEg0FVkBQ=;
 b=n7vedf61fIMVKOaRseRey2neE66xLqTdGeutSKJ2UTb0jDW1gBApkvUZE0B2b9RtuUsZ4qP4g0CMVEYBGObudjNv2zvr3KGY6qIH8eqK5MGSXaghv4OvFEqNe/Vq2eqqcR9pvsE607v2ynlAK2R1hNXbSZzosP/yKiie1kboWhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by TYCPR01MB9536.jpnprd01.prod.outlook.com
 (2603:1096:400:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 01:33:57 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:33:57 +0000
Message-ID: <87wmbm1a4b.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3 02/10] spi: sh-msiof: use dev in sh_msiof_spi_probe()
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
In-Reply-To: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 15 Apr 2025 01:33:57 +0000
X-ClientProxiedBy: TY2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:404:e2::19) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|TYCPR01MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: d173862b-6f07-42f0-7e38-08dd7bbd974b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?21QSfqIBiTtWemv5cdMt/S40UXvCN9ZI73ajcejY/sxXlOKnMO4FsvkUZxkG?=
 =?us-ascii?Q?gjNth8ViY+30AiMYT3Xud6TcT3zF1XpSaVLDtMURQSYVZThSaqip8Tj9o3/h?=
 =?us-ascii?Q?u7IDhpA3o/huKiMMB2wkWeE/GX2twgqJf6Wfz2SgqKngN8VEPLi+zTUgjglQ?=
 =?us-ascii?Q?aKgAk0CtFApUYoTcgb665bJrvWyQsUh4JcuaEJh8IdNnpetFeMX/AtoyLqpt?=
 =?us-ascii?Q?1JJFelumZ4EdmEm/rujfFrt2//4Yz44Y+jZpZ30NGQR4Q51kAKCPGYNHAtgr?=
 =?us-ascii?Q?HyeTvmMbnsPbNS4WOy9/WMPv2gqQfFQtwPluspR+EDojvHIr3ERG4H6MbnB0?=
 =?us-ascii?Q?q4Ael/JY+oPcuW1NaBtEO8iXBXYVpFoILqe4EfjnrzlD6zsErhmfAT3MmnLm?=
 =?us-ascii?Q?US1T6iMxThkG/UJGcOlMnNeTSjl9EHkwvAwRlam6GJFjpfIE2uzzCOcMouXY?=
 =?us-ascii?Q?5v9f/puBq+RqT5b3tWlwNHKbR5PQzUgjI88y2jz6C1cYZdSrOctOdYyjoxxD?=
 =?us-ascii?Q?qoa8ZNM4wJNVIwUBFQqNHZv1+MitI6W4306yaactljqQ2sX/KP/ZZXXH1Kd/?=
 =?us-ascii?Q?31IAdOokaKI4KlzDA6AwiCVI3zn1lx41k3U0OIBfL6F3o3OuBAg2my0ocu0G?=
 =?us-ascii?Q?+WzrwQxRZXBvxruE0ET9dg3puF1kfZ11aOFs7nAf0cvSYzgyy7ACT4bklq3c?=
 =?us-ascii?Q?b1NADnwOL2fPcdViQnHY3N8uSLryrFaMlMGoE50T5MXmjU3PxYhtMPtoHTZA?=
 =?us-ascii?Q?oOyIwC0H/bvCvNpGYR14z920IOnBrSUEmNllAqa5DDze0t89PLDh29NY5Unb?=
 =?us-ascii?Q?Hu4iF/t4OqdV1k8QGK1m1MvYK3U0mN8eNAKp18BjgcuMNhOBuudXYSc38Qu4?=
 =?us-ascii?Q?shfkMjcgd7+j1jCmjbtbD5AnJ7FQGsb/4mWVLLfYXdxCwA3pZpPcAs2eUpsT?=
 =?us-ascii?Q?MfsMWaBXW4V9VG+0trF6qSRxWfWK15JguAfq8y5O6Ul+p5LLyh6luEo3lC+Q?=
 =?us-ascii?Q?ACktL3qz9RCrjt3TRbd6cO2IH56HyhsPZGratDMQQhyNvNjT6wLkbwTfwfLS?=
 =?us-ascii?Q?u4seXFLdgYa45cZbSp0pnh4BZXGEsO44c/h0gdXCUtpUuckfSs/jrZNEyXXk?=
 =?us-ascii?Q?SgJL1KMjDd4Mag4ypxAFVtd6E1q+gH/hUbcWFEpSiv6sjQjz5wrxn/XxyfsR?=
 =?us-ascii?Q?NdzgVa4Yyzd5GmbTg4xbGnpY1s1fUlBPmg49Uy0o+Co2xFCc50JAs28jSFR/?=
 =?us-ascii?Q?ili4PdMFPe10glduTkm7C/RSzOLrELJ3rem/vWC9nLiAkST+xuyffbl7pcBN?=
 =?us-ascii?Q?V2VZ0W+GVWDi7Z/pVy72Rs7a1kJQFtr3Y9L9nsWzKmkLPp6cPjc8UmYh7dm5?=
 =?us-ascii?Q?Jp6pSEBrVknVfykUbCXubTb8j7fTEBb6wnhCiMKLrP46r2WaHuurYlsCl5xA?=
 =?us-ascii?Q?gE8mpLCUI4RSUb0WN6f6+qjajadgnN+y80MwsI8kdR9f3xxs2A6qIWnM0h0u?=
 =?us-ascii?Q?5f6EmxkQGgpZ+EQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wELnAC7E2nwOd7oEBfwUGVnVG/d8geHLzr/+q9lOKLE+zM9lta0bUdwW/o6H?=
 =?us-ascii?Q?/q1FwP79FQZAiMoyuc6ybO3NIfBtI3f++Pkh+nM6DMLCFgzeQOnMm9y4w1wu?=
 =?us-ascii?Q?AMbVFAJ/u3PQ+2YgnDdZGkUFZneD7QyLQ51kOR5w77KLD0FImwN+IWVbSu0m?=
 =?us-ascii?Q?Qt4ubVJPRfM7GvYISg4fITOqxtsQ9ugoab9nQL8qb2Hu8yGK+Ho/J5sDbku4?=
 =?us-ascii?Q?dDqVbDXftM/DjRW/WII5Tv9D2rfDKbNhMw0oMSqFtJjWZBdZHtJkfSdpNvEp?=
 =?us-ascii?Q?pdmwxVbmyEvEBHikgbjSNlClvRGtpd/sn0WOkdRsBSRlYJ/Aw2tnslu2lVKD?=
 =?us-ascii?Q?ttSc3rRm+GLavhVOd0E0XY6JeZNek+mLXG0/SUoe5jvv5+kxQadXEQU6jhy7?=
 =?us-ascii?Q?ptSSe2Qsq3741qQbIvzaKDnHD7B6u+0oD7TQDpNcGOjqH617MGU0xkjlD8Se?=
 =?us-ascii?Q?8rVQ6uXnYIaQR6kS+XN6wqtQfX+Aq7MB8L91/wc1kRWO5redmXSFBOdqcmtR?=
 =?us-ascii?Q?WSrPRHvDVCztIf3cFXOQ2v+nuYPrOI4kWVIIOpXqNxyRflfPMFJd38Yc9yyD?=
 =?us-ascii?Q?ztsYgdgkOWVl5Fl2FKoQAWa/cjbpFuEwG8sysjR69Q62WsTArr3Olji80SoF?=
 =?us-ascii?Q?eiMVBhf0LPuzLQ4CCPQlFLE4kiFrtOtWR0R3QpfF6MATZBEI0GJt2Kf9lE3F?=
 =?us-ascii?Q?YK/6mNZB8F5kXP4Qeqed54Ifu5dp2oJty/paf4q4khhwtaYqfins6cPFxKrB?=
 =?us-ascii?Q?LTTSI65KKl5PLQ0663igNvwmpKFPF5Pf1LuKbYnI7ydizw6YL9qsusK4IsnM?=
 =?us-ascii?Q?CANsc8wrCwiArWm/0/Fz4BZl1ix9Pg/3t0Ui3TJFXDLkkH4tMPrXgmpE9y0y?=
 =?us-ascii?Q?LutqEYOVCChMRP1D+W0xPj+ErBEjNSNcO2tC2EZR23f3MUlOiHQC+8QUGJ56?=
 =?us-ascii?Q?LlQOWmkEwUYQakhjNFw90ulywAaIs73KpTYonA1pFZnBFq8qmFjoqoCeyY5F?=
 =?us-ascii?Q?jpKNEw+jJWeSOxCBFEviLEXCR6z6WdelHFyLaOjIVitN4+Yz977gIl/Q8GDY?=
 =?us-ascii?Q?qDTk04ez42qR7e52pyowybVvOld24VRFY010nrVcQcmcwsU4+oPMGFwPrrxD?=
 =?us-ascii?Q?t16oLJZ6NTuQ5N3ma0QGdgBFNO0ResopdamFak6YzYdaBMzoyxY3ybSMUExQ?=
 =?us-ascii?Q?nmcwvpesgz5whMqwZk3h1oqyQeKHO0OW1pNDfe25KhPlT25ztC0LRqdBWA5K?=
 =?us-ascii?Q?263XNjAroQz1ST2o3iEUkk7qhJ+CsLtJ1Ty6truFEoUI/TYLsnw84o9Yfubf?=
 =?us-ascii?Q?CLXVas/3gIZfDEcM2+1ILEzVL2sDWqnAoWdDgR8DaQboIVmCkYHbkGn7K+LA?=
 =?us-ascii?Q?9+KUseh70JQc3HQPnD5G6Ea/xL2neN7XA3rDPCp086QnQc/DkbnbvpgbXiib?=
 =?us-ascii?Q?m9qvPFyCswQ0LFAgEX3V4unNIAiveLf5xBXY6iDFzJAW/93ytKlI3mqjRg7Z?=
 =?us-ascii?Q?4cQLYlyJDxX41vQjT17WCClvTXUKxcSV7FmKaSTqGwZq/trfQYihp3w6Gj0h?=
 =?us-ascii?Q?olEHAAKC2URHAqlZB4V7YgMx3Ws/lEBQs1c8FTJJROSOV2QPq7eCa9Lz5w+T?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d173862b-6f07-42f0-7e38-08dd7bbd974b
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:33:57.7802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3O/OlqpnIki5tTSXKHrBY+13B2EPZzoA7DXrk5CRIvLhxTbK/eLxvYtu6D7p+wTL2+VQqqMBBFqh+nfrBe8MzBSn95AdKCloty2nDsU1IFMVzMq3ogH9nWXzuAA/LtnE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9536

sh_msiof_spi_probe() is using priv->dev everywhare,
but makes code long. Create struct device *dev and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/spi/spi-sh-msiof.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8a98c313548e..581cec19cb77 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1276,20 +1276,21 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	const struct sh_msiof_chipdata *chipdata;
 	struct sh_msiof_spi_info *info;
 	struct sh_msiof_spi_priv *p;
+	struct device *dev = &pdev->dev;
 	unsigned long clksrc;
 	int i;
 	int ret;
 
-	chipdata = of_device_get_match_data(&pdev->dev);
+	chipdata = of_device_get_match_data(dev);
 	if (chipdata) {
-		info = sh_msiof_spi_parse_dt(&pdev->dev);
+		info = sh_msiof_spi_parse_dt(dev);
 	} else {
 		chipdata = (const void *)pdev->id_entry->driver_data;
-		info = dev_get_platdata(&pdev->dev);
+		info = dev_get_platdata(dev);
 	}
 
 	if (!info) {
-		dev_err(&pdev->dev, "failed to obtain device info\n");
+		dev_err(dev, "failed to obtain device info\n");
 		return -ENXIO;
 	}
 
@@ -1297,11 +1298,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		info->dtdl = 200;
 
 	if (info->mode == MSIOF_SPI_TARGET)
-		ctlr = spi_alloc_target(&pdev->dev,
-				        sizeof(struct sh_msiof_spi_priv));
+		ctlr = spi_alloc_target(dev, sizeof(struct sh_msiof_spi_priv));
 	else
-		ctlr = spi_alloc_host(&pdev->dev,
-				      sizeof(struct sh_msiof_spi_priv));
+		ctlr = spi_alloc_host(dev, sizeof(struct sh_msiof_spi_priv));
 	if (ctlr == NULL)
 		return -ENOMEM;
 
@@ -1315,9 +1314,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	init_completion(&p->done);
 	init_completion(&p->done_txdma);
 
-	p->clk = devm_clk_get(&pdev->dev, NULL);
+	p->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(p->clk)) {
-		dev_err(&pdev->dev, "cannot get clock\n");
+		dev_err(dev, "cannot get clock\n");
 		ret = PTR_ERR(p->clk);
 		goto err1;
 	}
@@ -1334,15 +1333,14 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	ret = devm_request_irq(&pdev->dev, i, sh_msiof_spi_irq, 0,
-			       dev_name(&pdev->dev), p);
+	ret = devm_request_irq(dev, i, sh_msiof_spi_irq, 0, dev_name(&pdev->dev), p);
 	if (ret) {
-		dev_err(&pdev->dev, "unable to request irq\n");
+		dev_err(dev, "unable to request irq\n");
 		goto err1;
 	}
 
 	p->pdev = pdev;
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
 	/* Platform data may override FIFO sizes */
 	p->tx_fifo_size = chipdata->tx_fifo_size;
@@ -1361,7 +1359,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	ctlr->flags = chipdata->ctlr_flags;
 	ctlr->bus_num = pdev->id;
 	ctlr->num_chipselect = p->info->num_chipselect;
-	ctlr->dev.of_node = pdev->dev.of_node;
+	ctlr->dev.of_node = dev->of_node;
 	ctlr->setup = sh_msiof_spi_setup;
 	ctlr->prepare_message = sh_msiof_prepare_message;
 	ctlr->target_abort = sh_msiof_target_abort;
@@ -1373,11 +1371,11 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 
 	ret = sh_msiof_request_dma(p);
 	if (ret < 0)
-		dev_warn(&pdev->dev, "DMA not available, using PIO\n");
+		dev_warn(dev, "DMA not available, using PIO\n");
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "devm_spi_register_controller error.\n");
+		dev_err(dev, "devm_spi_register_controller error.\n");
 		goto err2;
 	}
 
@@ -1385,7 +1383,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 
  err2:
 	sh_msiof_release_dma(p);
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
  err1:
 	spi_controller_put(ctlr);
 	return ret;
-- 
2.43.0


