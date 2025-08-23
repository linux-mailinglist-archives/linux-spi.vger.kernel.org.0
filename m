Return-Path: <linux-spi+bounces-9640-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2EFB32A5C
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 18:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2983B794A
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36182EA461;
	Sat, 23 Aug 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ZrMVCdJH"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023118.outbound.protection.outlook.com [40.107.162.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F42E973F;
	Sat, 23 Aug 2025 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964897; cv=fail; b=EsLhGRbmnnGpWVmgd6q8hEwXA3KFeVqowd5HJRIuV6M07JdDh16kePngqv91JslxuPpTFkVsRgqo30S63VrbU5MS/NXx6A4jGvU1smGBoslNAsog/mMxEM84Nd5kbw4U0G1eN7PKfmjhFpjX3xekIVqoofH6Y/gPvFo730rT1CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964897; c=relaxed/simple;
	bh=jSVuQhcbFXq70e0hw4Ww8FncuvaAtq2mDt7RDNDbzRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OjLQbdmKzeDdzWwO3B2x4+Z2PeE4u8DqV9X50OgoZFRb/cWYtgQs2RwH237zHrPHMTipqmZUxTXYpXocaWqGwoEKhzEnO8WdXzP9ayCYF4kHf8K4vsk4K9rLilP8kTF0KSkc1T9WSOnhb6kZpqzsjOEQycwE90U3/XCnFwOGzfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ZrMVCdJH; arc=fail smtp.client-ip=40.107.162.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCKAoH2oraFtGJjl1GDNj/GVIGBWcPhiW6tbnVIfQVUfIrHnIuRdnrWecQU7C4yUYGm3Ndkr3PWdRC07mseiVS5WTdRQM+RYyTaSh1Eq9emez5wIiRy+lrvA1XX5cCRavdiC6v/UbzNDyerNg4T013XJK/PcwUx9Fg3fZgEMQzww/KMQSAydjoNJHLW+NlGiDQKa6GLwgJKBLize9tze64QH5vRei0G/IFjwJHfL3DWjTtaRbfrM1zMuFWdJXDQOvKbhsuWjwm18EcFnPrN7REHzIy/jExhQFQ0wih2vJmdNiDFMH4rIA7K129korFk7ujPQCdWw4jus1YEsFCBNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmqk6nuuKvzdPF/l6IJlcU0ymhTCFF7IF14geICk288=;
 b=SteB2E/GTOoLWXW91oVa+Ku5yW6rK+elT50qkqzjccxw+8MbSmQF43BI6NmYsxkPjNAJ6WJnjO8k4e+G+hDdilP3rhqLju1/GRejqhlDz39k/k3rBzuqGayXqyKp65aVkjmbEcNvc0hQxqD07sc5gGcggIJl9DL+HPrnthE32ynGJ88GMjpZ/OYYSFDN0PoSc31MFoBM2CNXt4BPayaQYpAoMCK8NkPb+4uSQHgKxALPNnRqZIUbJ1cNERmO08/J6JFa3YvWBtsItLUjz3RlDpWS0BU2l+LqRFsO1D93Gv4Bd0i3wjdWCGcfc6Jn4DCWT7LPa8wpvJyCITiEBDaa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmqk6nuuKvzdPF/l6IJlcU0ymhTCFF7IF14geICk288=;
 b=ZrMVCdJHDFiOlWxjgTETNOYHyaBImkXSF+DUCSkRhv3krKvvqf0sGFo15OdkZszXArbidT2N8spxc1xv9GNsZG9EJxG6R5+sVWdVs2W36J6gjuESitQM/8nmNfDHZ7gpLXSmTx+NAJD9fjWtaMSRh836EM8qa0/XIDSGAFJDXALzN0+Gwd0IK4nOpIsWXItBAzemNJjBaSt2HGdNRClxeCXwX4Wuzgz3U9gXjy+upHyD4eFRGn63voLCVg5sxjnBhdcivTfRXFZ6nZRG5Lqe//P1hm8sXouMFDbn7W26tLyMS592/k69HVyIqGSDvKKCZT26g2jjzrIom8f+DpuK/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7519.eurprd08.prod.outlook.com (2603:10a6:10:321::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Sat, 23 Aug
 2025 16:01:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 16:01:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 05/13] spi: airoha: switch back to non-dma mode in the case of error
Date: Sat, 23 Aug 2025 19:01:08 +0300
Message-ID: <20250823160116.3762730-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007568.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3e6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2198eb-b6e0-4d0a-1b1b-08dde25e5261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4MIl19QOFdSMNDjP8NHccRzG1hjQQCagxk9tH3kxLMZzqfeELI5LMvsIPTGb?=
 =?us-ascii?Q?CLsl116+e0Mn6hacDb5EbtJ8jcB5fDxeIYJD2I0kYvS1i8aSBHzHhqf2I0M/?=
 =?us-ascii?Q?NTNS9LTCjHnGHigQq3l+/UoN9k6fJHI2ba31KnRRTG7O71fQoLfgK1bqpvsh?=
 =?us-ascii?Q?khbQmIOVdXIiVHDtryS+u1HCFUrjpfybM5r9zznJ9RebqhuCnGUIluYzdQ7w?=
 =?us-ascii?Q?s2A0dpvrojTBA2oUuyoZqWmlxVdnPFv3u7KSutlcosDdMFp3za9U+m9baFct?=
 =?us-ascii?Q?uniz6uGpF32Hk4E1wA8sA3RuUEHMCW34EyuAahZQG96E0xwhXZfTwiMlFgA6?=
 =?us-ascii?Q?eZvtaLqCnZlE8fokccsO0WXeuj9rXmo4UTPVjXckoOts+mebvRSy6HfmBlwN?=
 =?us-ascii?Q?uOVt07WSqFwPxg0ISWSMRYrTE6ZrG19CXrX75vRSPVXbL3r63rLaKoSNcwap?=
 =?us-ascii?Q?34wQ9apF68ZWuF4R6xLqtrqcmWSUz91U1GEum+cWiOYo9iAyozG4Ct5y4+jw?=
 =?us-ascii?Q?r+BwsymVjF7DuXW6jO5pr1t4J87uwILGcbu42L/xH3gAHccf6GNqM0rLzqP9?=
 =?us-ascii?Q?0x9odIag5g4Ujxwi+sK+zePSbOMwW0rVJGiCuE7hsUMKuCpUZGjsXMlbFfm8?=
 =?us-ascii?Q?+1pXRVyvuMh75BsqALSxVxDh4XfO+duMCcXtDjJMmmAXzqRvFsjrbHqQC9yC?=
 =?us-ascii?Q?JrshR0dcyUJts59n07z+1OGZJmyKJJAVUwlZJryuWVt9lEehh9htgQ+NU2aX?=
 =?us-ascii?Q?/uayxVm13I8am9Grx1D6iKsIPzHP0BEtt+e+JmUSzHVNy8W11F3sCXLqCAD8?=
 =?us-ascii?Q?UNvQpqoyAcCRmFFe9leNqtRgxl9ggxdr5zmyk9LIEN3XIBYnzz4jQAJW/0uH?=
 =?us-ascii?Q?dub0gPGLKpg+2eUdPHOoRIpFXz9fVOoY+sB5LlBYbycWFpOH37RuCzoHI7x3?=
 =?us-ascii?Q?dl0arbnYCXI3QWI4SyrR/h4ED84Cjlc37VZw36q3ebdDyJNa/QX2HZ8A8At1?=
 =?us-ascii?Q?w+HX6qhngZ6Ja4fYzSgdtqHwzVCfqnqL0PigD5ZgYtQeqBwvZBPIUb5zDnZT?=
 =?us-ascii?Q?VOTBzfnAF/Qlb4jkFpx4jFueB8QJwtE6mPPnLhktqUCEt5DG2R3PCC3n1jR+?=
 =?us-ascii?Q?aJoRgwWNCuiz0tK04O31WEPmszW+p5v57CVz2sjaQpMdwodWqewDn4mTj7gS?=
 =?us-ascii?Q?58WNL41aJMAVPvIe/ErwnepYvgR/zhhFaqXMuUfn14ciHwhOK51UxpB2YDFh?=
 =?us-ascii?Q?zpfkDmNCW+tcANvgB196vtWEdTSXvJq8mqBypkhLdFlfQfZDQ52HTEg+uH/Y?=
 =?us-ascii?Q?fLDOfRhVB0pzDZv/edv4opl2569YPBQh6+noWGNhAtoitSkHh/YFbmyTaAgb?=
 =?us-ascii?Q?WmUZc3Itr73cmtaTzJ+HRCtoyHD5OMf4/BusSCH6THyNUlnU2CUe3Yb+11xD?=
 =?us-ascii?Q?iCQrsv063gTsOr1MbdpMfTT4+hIYQ4Aj1TCPzLNCpsYIbBzjy7tL1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5LJ9mJEbgO0kK8L/C5xCrHkaXuyaU2gZkYBdu1G1WvG9kQJ726qa28hqvjNt?=
 =?us-ascii?Q?g2uRb2Zq27s+Bc3EX1I/ZoOAfOuC6JzDfS/OMqARuRJ+U4ZOZbzsW7EVJys5?=
 =?us-ascii?Q?WJQFqUIzx7uD2Siy9MPNhlk9/pYl0/YWlzAW9d1MZ2X3iiATSMSGfBv0SJNy?=
 =?us-ascii?Q?QrZI61ARaZk6NVRJW2yDoDFaNH0CArS4fMGkGTvaU8HfFD7TMW483JMdpI9D?=
 =?us-ascii?Q?SEjOOfCs5zOT2unA598aMRo+cmbrak7glOp5iqfUuYczBkhobn8U2jBS1QCA?=
 =?us-ascii?Q?7PQD07ShZOhHFWI+1jAaGmL20N6zmsmRIYfQXBYgaEoNE+PligHpVWsy+OGd?=
 =?us-ascii?Q?JvJ74q0sVIbuxejH6fLYyn05n8DO0/F5JFTrGBidsYjrmEW4CHqKKUMIpk0+?=
 =?us-ascii?Q?DkcgB8fKQ0R4lEFOaJsi0u3GSmiOVYuAJgFnAC0Y54WfHhP64892gQxMTG/w?=
 =?us-ascii?Q?EiMYtb/WNCqxzJflA1RjmgKJM1LN14ZlxAocQFpELck4zayyQHy9UplnLeDD?=
 =?us-ascii?Q?nMDeQhiApUrAzUWHU89ioGpgMIQmzD9S8VKK15UX3U9tRjDmmRnqIcIV5sAN?=
 =?us-ascii?Q?ShBi6i5LlKUIx8TDsxj5+OQfJMyZKwsfuzgdOCca96p+MRoFvYDv6oo3dsOj?=
 =?us-ascii?Q?9Lngbw4MdIKO3r5zSgch4KBGi8XGpitb1H/mcA195FJxTaoGUs+6GZnYC+WP?=
 =?us-ascii?Q?jhCTveeiU4cGSvx2S2bcPngMMNacPIYEdm6BNn2pK/Ah7GlrpOgGG11gKwaC?=
 =?us-ascii?Q?Y6W/Z5aV4QmLTt/5Ud0fZPfPOayspWH9mmQIT1vLWhJb+smELfvQEzDryx3q?=
 =?us-ascii?Q?2FBtBEYHwashj5EfYKqpkXHaXjozu8sQqyHpcLV51fPvE2FFvqfW45/+TzSw?=
 =?us-ascii?Q?vfw+BnizCYXP5wPFHOBCjHVCsPTz2m64JB38b9SRoLaJt9XM5A/cz38TviHV?=
 =?us-ascii?Q?jzvv+FNbOktk0ky7sz5b42bYDMBd79snH69x+nzCYI5rjVaoZrBVdFIMJoy2?=
 =?us-ascii?Q?KCz+SKFmCU+KAGTCHcCmE6QRexgDUqNTy3Ky4KmrRZ9D6vVMtL5IoCb8rZxV?=
 =?us-ascii?Q?JI7AT6fxpg/qHWlZJAbZfYniV+uqdl8ehVl5wWrRuokrXhGmyF3iEKdMhUi4?=
 =?us-ascii?Q?wsMRf3e4fB/s5DllJc9nuT+FRWjkDqbnWEQZ5/5aiHyS2Y4O39giE86zF6LX?=
 =?us-ascii?Q?55E40yxdP1qsRcg/RJVyDhkMQaZecdqMDB5z5z2eycswS7P4qh2nh0h5uFKc?=
 =?us-ascii?Q?yMr42GUs1ONjl0Yf1YLEQ0D86Na7WkS9JgtdjQ3bOP/ioAWHCncHTsJWPoic?=
 =?us-ascii?Q?2MQVb6FBl8UKeVQCAIaT/tGeOzzqE+NXx5nf6d+oMopnBy/v9TgEAD6NZ1n2?=
 =?us-ascii?Q?sDyY8ouM3jWLy9PGjlzZ4Rl5l5x4sgqokdKvyuI36IKtrDY03gYYs91nmTnC?=
 =?us-ascii?Q?7pMGOBTawzQ8X+2mnVzkriS/Xyq4n3+pglDsZX6Ei3y34DYDT7SIOBf4ok8Z?=
 =?us-ascii?Q?p+kxTlds2yOIQxfsWwoM6XeMPSCHZWCnpf6OzFW0LrUiLIdGfDG9DjPGHNbl?=
 =?us-ascii?Q?M4eNYQLAnWUID/kohIVYZTHpKUSiFz5dOmMGXyQ9k8k3M4KU86JDQ70JKyco?=
 =?us-ascii?Q?i5sBvv3q8bChkJ7HuOIUE3g=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2198eb-b6e0-4d0a-1b1b-08dde25e5261
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 16:01:29.4873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rGlXLa/ED7wZrEd2qy3z9qUHfWdtYAEJ+WS4XySZee7PjYr1qCdILsH6nA8kFZALHDbmOvOpWRt5B3dPKmzDQDOVaqLoEWTG5FV1KmDo58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7519

Current dirmap code does not switch back to non-dma mode in the case of
error. This is wrong.

This patch fixes dirmap read/write error path.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/spi/spi-airoha-snfi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 2d86dc62dbde..a39c3ab4af5c 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -691,13 +691,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
 				  DMA_FROM_DEVICE);
 	err = dma_mapping_error(as_ctrl->dev, dma_addr);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
@@ -797,6 +797,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_FROM_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
@@ -926,6 +928,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_TO_DEVICE);
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
-- 
2.50.1


