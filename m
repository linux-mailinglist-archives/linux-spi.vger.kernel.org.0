Return-Path: <linux-spi+bounces-9612-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D850AB3259A
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F5C5888B3
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560F1CF96;
	Sat, 23 Aug 2025 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="5zoO5ptG"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020080.outbound.protection.outlook.com [52.101.84.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8412D393DDC;
	Sat, 23 Aug 2025 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908204; cv=fail; b=GvYong+y87bX00RvSN/lb+NFAWReMsxLPRt6aU71wUL0KBdQ7H+56xjOdXbLtLCULsdVOKc1JZEhHtWmjSOLbC5rFMEaR0loUQtdDdcOaZv/y+In1jGaVyj8MbPJOhHXy+62RpLjR7t85k0gh6nKJCe+Dd0GIeYe+Tr8rXrPnN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908204; c=relaxed/simple;
	bh=3BA/rvhjXAcwDwN+DEZUBMwjeV15sgpedNtM0rGDGDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LIeXy9aGPM3dhO/JVv9Dp7FnaD4+zipk9qsyw+6SyQRA7vd5rwUawR0Ep45K4GQn0mvpbKUy9sZBVC3DHBa5G2nXHrdk7UJGxq3rTArEqTJcC5H1Pcp2qiOY3V54G+CpLAV2We32SWxIciT+iopOXhkKc5yNLIACg4QN3BJSEuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=5zoO5ptG; arc=fail smtp.client-ip=52.101.84.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL3E9k4+0htGzARXjIG8Or50b5HwLZgKOeJd8/KjtiE7Sj85r9s7VVsOzKyx4iCDPSqjT8P+un153AcUJ7MLdK1Hk4G/KHFL/TR9o2JO1tqfWyhzCg9NEI1fhJ/9zLaVaMvv95z/9PzbcwIhMJ9WAscFd3HyI/HSTVCv3/PETdT9nzwIbx5h3b/7R2iCQ/y/ttOmUzdWuIBGGm/RC2cwbNA9v5ZMf7YNvbW35e+NSXOAbwDwHBBFSrS3cYRICEtgS0MX5FpGDT/8avY8T6N3l6ZgfTlM9Tw+PMTMJK5RsmjW/h32V/qdG6c+XkwBJm8JRluTsYmP05F8ITAPbRRAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5aaUigeCIMRiWRR29XHPLvSrDNINTjNlR0OmlAuBXc=;
 b=lm6egnvasEDn4CSm6fe83ASmGbWAM5mlAHtsVZ0qZrtJS/BRNQNsMmLs1fGPQ4A3/WTqyZrriVqjnEtB0d0MMjHYvTFZXL2hq8dAzNfEJY97p7NRAalgVAxDuJGfxpeGKU8hika47XYeYZUmOBTm6dcg7rJs8HRDx1fHoWLNYrlmCaqSv5S/jkq+Vh2TDpc7tFz5K6FUds5XD1f/uWXoD4zQqs3fCiWSDq+/9howA8jIQWhcCY0z8zQdFcOKenqE7+qt70HGH+gA+Zj9Q7io/SNMTXP4H+2A19/x5mz+bA6h6DYhDNWGMB2HvyMzp61OrVat+2zSWE52M0a0haJRCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5aaUigeCIMRiWRR29XHPLvSrDNINTjNlR0OmlAuBXc=;
 b=5zoO5ptG+N1wERPoUUEldqz9aiChiws1CBLeje0qUx3BR11Zv6Jazi0lL1zVf8yRpRHMOZEaWGN6l6PdD9lH2evfd+nbC0gGgcBmBmtwbEMkR7DPFcTYRgfVkiXPbS9srrcqq2PdK/xL5Ef8wBWVPNz+UZxSSGS1mkZ5jQhBPtNGVlc2ztll1fTGSzSXdg9QhHnH6/HtD6U0HoD0ZXVe2zFwZGNCY8qokDfdc3ZpxvvmuPnyN1cEmj4gibwesNRWSWOAb/kqnAWVVSOMp0vloE3V4jyhfXo+2K5MEzVkU+koM+jO9s9OnjTBTvIFPi2O/+fYiezOGS+im5v4FRcrMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6398.eurprd08.prod.outlook.com (2603:10a6:102:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 00:16:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 00:16:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 04/13] spi: airoha: remove unnecessary switch to non-dma mode
Date: Sat, 23 Aug 2025 03:16:16 +0300
Message-ID: <20250823001626.3641935-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 7314b645-0af6-4c54-e4b7-08dde1da5380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?soH0EdZRtatSFHB6+HJSPHYHKymvrQggMpFzF5kOS8alJez98QFB6262bPLF?=
 =?us-ascii?Q?bOprBVB/PNrr+rLaHJ/Hl0qsarYflw8PxvjAdmHHvdRigRIUPPOSHhBOZVr8?=
 =?us-ascii?Q?jyCcZkkYOHfMpNW9DG+mxM99tvfwEMA3Q2LLev62gAdnPvlh3bdpPqLDT9R6?=
 =?us-ascii?Q?OXIAcxftXznCevnhuslss4628cIzi1JCLq7rNPgOfMhSnBnEz++r/IiCB4FP?=
 =?us-ascii?Q?ix750Xvjl1aL2P3vP9+VQJppg9rArzdsAztH9hsZ6KNE7emNjiQagHnJrNtK?=
 =?us-ascii?Q?j+Z740ERVzKkJNCvbd9tJyB1ZpWlQveQo+1bCp6EkCZ8+K7ASKxCnCNe31Ra?=
 =?us-ascii?Q?WSYLEBMXLyWrIitDBuAENzh/GeluCrboLcT+3SErlwrb45PNCqQPtNqSmksV?=
 =?us-ascii?Q?+osgEMc2/4f76fWzhLlK5zGmZCCf+W+QX3ZKyMeFsqMQM0CLpOlWkqme16Qj?=
 =?us-ascii?Q?uxbMh/4lIbn2y7disIsYUmZ6m+hUl7Dqp2CYiyybtZYjwXzX45k87xAh3DJn?=
 =?us-ascii?Q?a3eJx/PnD/7QuPG9kL+1vFlXf0wXrddZzJxIdScxAd6EB/1hiIRAIEooIojT?=
 =?us-ascii?Q?jL+57q+w/etfiVph3X8EhGz8XYsMxUHczeo0panaFXXWDa8a12IOAWRc4ON+?=
 =?us-ascii?Q?x0+pF/crGgEmhqnD9rUWpUM5HndaEuLB4pebGGTpiYEBkFjbL+Aq6k+8NVcp?=
 =?us-ascii?Q?SxPhTjdBb/fKsG5mZ0869+dm7rI3WeJRPnb3Pwxia1Wc9pf563cYvI/pxihx?=
 =?us-ascii?Q?Lvwo4iOLRGLxF4sWK3T9NNSsxR6KoJt4mS3IegUd8kbl8lHQO0KTekSF/zcV?=
 =?us-ascii?Q?QkY2fgnG/AxA1vFxcu2slu7G5DDyzx8gJF0Mqn98ftBHF0B7t5oWKUuNEej+?=
 =?us-ascii?Q?UsRWalfe4W7dZ4IGg8EiP+3kxqybLUx9/OwYKgGGcvTuSYd/fMWvzXVelpXK?=
 =?us-ascii?Q?X2pkns7hzphYPLePjKqBFbT5Erbc+5qFlKUJVBjIzYr7Nam8LUDsTEoUGD+v?=
 =?us-ascii?Q?wUE9RQM+eDRA49FYeF1RyAc2csRHA5ceJe7XrXomWpmVo8N7rJGe2+EVlmGV?=
 =?us-ascii?Q?Yr8N53ZsItUVfjJ7KDvimOEFxKT7kWesW0gEv9VXDg+acGe6xrUvCzYs3uaX?=
 =?us-ascii?Q?QE5/dVUkO5+Nos5/fOVgXsUUmO9B3/f8JhB2aV8XztzELZvTEVt5XIp+TVSC?=
 =?us-ascii?Q?tF5XYtfnkdkdcqmRjg9S/l0cH3ILR1JsSVH2ukdKLNZijsJIcSIg4B6Qs2Yf?=
 =?us-ascii?Q?7jggKpcoGSlFQsTMfEwyqONr0DZXJmoGOwLqVGvKnJwq9IbUQopBnvVpXaai?=
 =?us-ascii?Q?2nd5UEbYExOeXiPHhZ6HIkklAH/e7DQkyKMUdY4QToy4TDEFd1d+0ItysdLw?=
 =?us-ascii?Q?sslQepEhS8p7Kel0AZX1B54dJ3OF1+gEDAK0qSsF9fA7zfvZfMF4ULx9lw8+?=
 =?us-ascii?Q?Wy3BVSoaOp8iy+Gv0u/3HAnr9w1ojWTURCDnwnQvWkfVwYMQoedPdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ViNbD9VENW0H6ljwZmXnXZB/X9R/6CU2qJLPKuMy13choln6lHblCIVDjIK?=
 =?us-ascii?Q?kkpY3Jnu1teSLDL73WiGJ8J/ot44pPgjH3Ct2sNvoX01lZbZsozSHyPudS62?=
 =?us-ascii?Q?Ph7SoopSbdKLGJdzif1ooN6NTaK5jJvOLIPfP6UrtxwRG2EP3+rLBCwCpeXm?=
 =?us-ascii?Q?ZyFH4/FvYNjg5LBXrttgm74VT92PZQSOY6/w4Zcd6D/pfxW0uptPxU3EPw86?=
 =?us-ascii?Q?++26EKpPVqOv8ajFgcBpjWk8KOqJWjSgt/g3DLZMzejBHaI7NGWfk1UPhkvz?=
 =?us-ascii?Q?DaYphNeju9sNr1F6R35f2EPOWyGr3EMHI/eezfJcoDApfl/T+yteNRElu6Vv?=
 =?us-ascii?Q?CzX5zPS4QrL+DyYudT8vnxg6TB8KroY0mtI7XlE65cARZSs5fwhj8OAFakN9?=
 =?us-ascii?Q?V1cpGUZlkUcP/xaTI3mEQUiWHS9uVT8SFr8tE0HUuB6NOpbWPIg/4VNTsvJt?=
 =?us-ascii?Q?UWxN+3kXCxuzGTPYNKcvOHgP3YLRebdZs+GYAJY0vJs0mwSJHztzqT8dIqjn?=
 =?us-ascii?Q?vZ0cMS1jhipWYYeMPlNNUZF4rRa8AtbFOgvyjDTDI6tIUtNzGX4/zE6jgYPt?=
 =?us-ascii?Q?REAIXIOsqKIyzZ3m821XkFGqhka84FeoP38MBRP3XinVZ5KMbaUS1LhvoTOS?=
 =?us-ascii?Q?uBTnroO26MzfQ4rZJHtbNxBc+saeT4G3DsWlpASrF4UZ+DdhciiF2txCL226?=
 =?us-ascii?Q?nrfA6kDE/KroM3q2vglVfbMXsKl3RoAKi5VXvg7PrtawjjBx+MOVuWMc0dL6?=
 =?us-ascii?Q?PKlKVmqgdlyJc7ftygNXdVb6mglsnylrMcUVDyZpKjrhhbSCtlql488k+lED?=
 =?us-ascii?Q?sGrh92XKexwNSLdmXjvzTe0tlnPLziiGzZi1YyVpJ+v9kwExCVNOsAYctFdC?=
 =?us-ascii?Q?NWqjUb7i6AevnJU5WGfF0OC6ElWwsYczdE3vbqDBUnyoF+pFNZiI9l2SPcMX?=
 =?us-ascii?Q?WhJnUUVXSfxk6v813+UQo/q3uGsoqXmKsi/fMNUN8GdMZQAZuAKqOQNePtCJ?=
 =?us-ascii?Q?MqomD58eIwp6/V8s9P6vJoFHZwK0Iiy/E6BhQ/i/fn8lxopaI0FBrJqtM9gg?=
 =?us-ascii?Q?pMJkXoJ/mIaOiMb2LnPgJu+BNDmzFpvPaqT8HhOfR6PrHdVxDQcyA+G8bnQa?=
 =?us-ascii?Q?WfOqpRPHGbMV6QjztmxS7FUUX1iGjB2JXgLFSYT+CXKl7ImORSQM3e9AR6PI?=
 =?us-ascii?Q?J7tQX83B4jRicyTpJHO8vCTIEZunCa5vm4kWET9jJ0SIkS0MMFeuO3tzc/9m?=
 =?us-ascii?Q?Yded/zO2H8gycUrbrTJiflI93HmTdzwxuavjcp6t274Hcu43+bWsS9ZeQxiE?=
 =?us-ascii?Q?wj1FoA9+Id8nb49hlIoaNNPKLFzPSQN2VQvqWPUY2IwD8LMo0rX2fXGm5bLw?=
 =?us-ascii?Q?9cigBoZic9S1mgHe8xjCKBJei/jLBpMjbey/uxbucAEoCpN/UdrIoPsv0C9i?=
 =?us-ascii?Q?VX+eJz84CPs0u7iwgo3etSphvXKvzdAlN7j6wY5KI+Pk1t8xkgjYqhwrkXSM?=
 =?us-ascii?Q?uH7X1MkPBim4c3kB95tB2UVePKjvZWhrLGgsPiDlBnl7XwiFR14ZI4QG6JdR?=
 =?us-ascii?Q?XyQT6lugmeoOLAub6x5V3admJLtvwzs5qAhXVDFqVExWixtIQ2lU/RcXWbMf?=
 =?us-ascii?Q?ubJ4fzY7us9mVDs/5RoVx8A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7314b645-0af6-4c54-e4b7-08dde1da5380
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 00:16:37.8286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1OEFdkv6imdlenf8uW912QSAv0kWujwHkgmZQgSZPffpc9Lu8jlz/rEsEs2410eo4YzsQdcVstPHeRkRd4aJ0bg22zXQgWveEcRZ7sXyeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6398

The code switches to dma at the start of dirmap operation and returns
to non-dma at the end of dirmap operation, so an additional switch to
non-dma at the start of dirmap write is not required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index d64a687c07de..1ebf7def7ba7 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -812,9 +812,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
-	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
-	if (err < 0)
-		return err;
 
 	memcpy(txrx_buf + offs, buf, len);
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-- 
2.50.1


