Return-Path: <linux-spi+bounces-4645-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C07596CC3E
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 03:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1892A1C202EB
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 01:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604E0B677;
	Thu,  5 Sep 2024 01:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oGfgYlzm"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BC17543;
	Thu,  5 Sep 2024 01:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499579; cv=fail; b=EF+v5ihNlR299MjOTXejnrsjqUa/5zNezLDVuYai415OFFhTYYIkwM/YIrxD40yh/CXVIKJ096OooqjRqoiz0Iyw+gtVCc1InshY8yG8AUe1MJED07HyKBOwl7eiRF0tX/bWZdXeWmex1Qi25yJBxe+s3Vk0gKVMIRRhQB7opmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499579; c=relaxed/simple;
	bh=COHGvEEDbkC6urCMT0IgxMy1By/x0+jktW+K7alvtiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mf9/10ImFk9sdwQdDDSA6LykNorgS4CaKWAllSkATZPxgqS2XR9xsChO7jFpWC/siXamr3Yv+2TSfziXI/hTeWKzqRNnWcnzTGQ28MBFtSFqRkC8/sDWQY3vjOWqFGPpBN/yy7e4PMleCAh9dkIOy4w4z4gKfhJI5unzMo0ozAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oGfgYlzm; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSX/865Hf2s5TiouRS7g07SEgaTHduT7FrHooRANZFO8h5fh3gAlCz7FQkXca2SIDNZaN4wGMyumGeaz7EjaeW08vWRRzW26pUC4tKt087vYVWiWuXfYobgv97IDRrLMw8AGMbJV3EQSbHX2kbYE0wdsdQH+iGwKI44jrb3oWtIOeoViF4K4qiN3p02TNVNgrKRF91P82ePC1yKhMyDYKjYUM57PK6GXyp49tu9+XHsLkgf3szcsLuMyXS6tW3a+X4/VQWQCX9muUJ/49SpZCJlGD3o/HQj3vFjpdQ2rPbO9sKkZhSSgLg/lbuzGansplyk1rQU3hLHA74oZFV7kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RccuhLfgNyqF0XvjFoKCN7TbiGlqnMAnJJv5yXWPUMA=;
 b=Of85FJTMjy7VRZ/DnSopwP5q2mDoBZgqyEQkqDs0G4if34gApZhuvfOxYjRrsIWVZQyCpve0/uV/KvYAf7iH7Z2I8GJog+n5LFRgZbJOIst/r7azCQ+qVtujLlr8xuJthNGO59Ueeb0qJ/x8153IAs/t4lKyrs07NPhtN4HZy8nqJvP9gMoCHutPqSpmgUhDarg2Yz0PsGlL0+Je/JnR94b2vxnH9Sp6pPJMg6PIyXeDMxH7wCTAvLD42CTpeHP58JQT49u4pLpfJMDnkWsbdgTAWnMLAuDzFCe1Ey6jDFAsSrWPvnWdx5jr5cVjigO4AfKG/4Y9GSSA/P3XEAt1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RccuhLfgNyqF0XvjFoKCN7TbiGlqnMAnJJv5yXWPUMA=;
 b=oGfgYlzmgPz3YuG68E/KNSCDZ5R/zrYS7Ca4kd2ha0zms0vrv/b6cIFta4opigDP9CpR8A2c25esB+HnhxNluE5ZfeZEpwAPuahO7Pu18GbmPdhyWDWayGg4PW4aJ60ejrYXPZaOYPLeI/bctD2BeVqkd5acSAj9SJWyYamDU4IYBRPmjxRC0tsX/4K+HkIOg3doOZ8ZqbOCSCSHCQg2nPIjXBSA20h3KB2isoMFNo2sXSX/rZxnOFl1UvwV7r++GoS+P7KxVYdD1uEFceTy8f6sacp6zzIqylEbaMpG6MiHxunNGJ8+2OC04PrZ9BoZy+5zKC8CKJyGCs2GhRegyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU4PR04MB10339.eurprd04.prod.outlook.com (2603:10a6:10:565::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Thu, 5 Sep
 2024 01:26:14 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 01:26:14 +0000
From: haibo.chen@nxp.com
To: han.xu@nxp.com,
	yogeshgaur.83@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	singh.kuldeep87k@gmail.com,
	hs@denx.de,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	haibo.chen@nxp.com
Subject: [PATCH v2 2/3] spi: fspi: add support for imx8ulp
Date: Thu,  5 Sep 2024 09:26:16 +0800
Message-Id: <20240905012617.1864997-3-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905012617.1864997-1-haibo.chen@nxp.com>
References: <20240905012617.1864997-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DU4PR04MB10339:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c64a7ed-5e1e-42a2-41c3-08dccd49bb5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bgP0T1SDVhgnaPiW7Nbh9vO2Sq+QFUwBaaV/3gEPzw/Sg7hjpB3VUJ7+JGUD?=
 =?us-ascii?Q?kRSIY60Bfj9w3HGFS3LVi7GbXvQuz9o8d62jOfZuqnRGUKvNxTh0TYd248H1?=
 =?us-ascii?Q?XZaT4+yTenmflYsobRsWOliA4yaS24b3zfFX692uyYNXcYbBQvrizLfdofhH?=
 =?us-ascii?Q?mLiyHAx54xdOM4c/AiF05j0k+gCJr6z0w9qOoORlxzwoW5yKUR1OPwH0U7FM?=
 =?us-ascii?Q?48Ym5CabcOlZZ8tGpoeOXgWE2XhbQKOVRAhXyZtUXywbCZYpsTs+n910yEeO?=
 =?us-ascii?Q?fk55ewyvvnwm6LA66GQBnC7cIioGcfLgZje/TblRYenO99IlMGv4f+DBN0eK?=
 =?us-ascii?Q?wPsoSOVYGv4AXOaJAMbostla+S8GSwv/KDtRb06WX7oAz0fuvI9ogj5XJAC6?=
 =?us-ascii?Q?J5Os09yh8dgs/J+RyAojOvNqigaaVDmfagW9lm+wyuKGRuegV6c60nV1aZZA?=
 =?us-ascii?Q?ajB+oUprVCDDtVu46Q9dOHJeqlSgQBXxeb1hP/mQpdJyO5LnMTHbCRqtZdXf?=
 =?us-ascii?Q?znrgxYuIIOKWQseH6dDuSUGG3OZRlfpiQ8Vp1hTtmhJBL8w0neiK6BHhtn3c?=
 =?us-ascii?Q?xlBh6rHG/TiSstRPfucxGHyA1UP0vDn7ZtOqO/aHt8TsP5nxGblc42VzUr3w?=
 =?us-ascii?Q?p3Nuy7W+fx/GtYfHlHqkKfyNefmZ+0csRJ7hHcgDxwXxihSWF9ivSRR38vLK?=
 =?us-ascii?Q?/q6JEcNKq2uEGmKPu2QbkjZzUJ43LZUOvJ7argJUmcwrtvNxyXrHtSvlNZhm?=
 =?us-ascii?Q?6LWkcQXJWuu6MvzKvCmc9u1witZNqWdnhb8YjvSKCmi7PTYDYZCJs0hWkL03?=
 =?us-ascii?Q?Tnus6xyBD7eJLxWGGNTGi1u5nQLbcjlIn0Mi9e1n09aQQPykyJ4n6a7j5DBZ?=
 =?us-ascii?Q?aXbEdbPgRLpDl2iIqohLzXw7r7JgGeLtNyHJPm/yuflbY10eH/WWJODaUJHl?=
 =?us-ascii?Q?riGe3pawkyM2ZKeQ6kpiBn6O1oRFWdFGPZecdpwM+KSFxU0aqNn/Ul2Sbt+h?=
 =?us-ascii?Q?WlTiC34k6MBFN+LJYUfjimnx792vcb5w+GECBFx0rF3AAMHFB7vATeS7W0Yc?=
 =?us-ascii?Q?8StKepbts9TL3nNbe+EN6GOFNsSXpsuQwHiUd4vUkix0R746k2/FIFJdCKsa?=
 =?us-ascii?Q?Fig5byUN61uoDnQJuY7MVmhluS5pjkH8Qh6AUrzzUdWOeelOAW5JAdHLXguF?=
 =?us-ascii?Q?77xIzrWoaGd6aFlaqHVFwfDrX8VcmqtJxmQDmbHcM7B7+31YVMhVOlxVgcdV?=
 =?us-ascii?Q?N8IiWYzZ6xyefOZIiFA9pNmMNry3zs7RPljzolD2kb/Bjj+X5fjq6L1ZDmdB?=
 =?us-ascii?Q?6BeGDgZmKHN8O213Amn80o0huXxZD2EzS/Qtzr0FwFQF/rlp9uu0bb/8pgN0?=
 =?us-ascii?Q?Dpz9o2jCkNIqCx1eIi8tdaTQ0EDmGTH28SSabgpQc9IkNGdYIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4FTjqY1pctc5IrfDxEH/T8yMyTzWIZHfp2o91rA9Vi4ZsR/vlcl2NhZtJ7Nk?=
 =?us-ascii?Q?yZvcMDnBpG1etds7TdEnn7YxrgrV7xTvs+Vn4WfK+r6ugjMRkDBk3ulHHRfo?=
 =?us-ascii?Q?2CqSxzQKdg3nsILW0s5HcP655j4RTqRaVorlB3dcn7aU4KCeEoNBI5iV9qfP?=
 =?us-ascii?Q?tFg1gX04w8UCLs/nwAv0Q/fROz7TZEhgSHjlzsuH+KipIQ+BT8MghmxEM6E1?=
 =?us-ascii?Q?kpPa+3qvjKjRsX294oEqp4y4JM1B+bkZQMX/pYVn5cLDE2Dzv4Q38hD4CpO6?=
 =?us-ascii?Q?7/aJ+XZR0SeL7lZp+N+KpICv9DyRH4Qp4S7gIPacLRsC8QeTI6kvQc1Dvkl0?=
 =?us-ascii?Q?1Ny/DO5pSL0LlZrHDw6xp6Z7K8enJ/IAcxbtUjyvpzo2/AXZYybpQ7YW4tbE?=
 =?us-ascii?Q?Od3SQIe4uXsCYPP/F0d7efBFfTHR3W9bMtwKhbz9xSMkSI01T5CpZpk5hxX0?=
 =?us-ascii?Q?IDPc+HCv4NoH38hLZTobOgR5eNuappceQjTGg4CChM0obWtfGLG+dXdyTLaO?=
 =?us-ascii?Q?xfjKJMn2yVU+zglloiEnd6aOUpz+dZ9Og8oFxKRJmDdhaLC2vcwpQijEPo2k?=
 =?us-ascii?Q?0RYvK3KRTb0hTrsbVK0eDsVx3GD2cF708T1xkCfnABLR6JCsvimuwGifFmfh?=
 =?us-ascii?Q?RTal9yc//lvm/2utm1OvDFjcqq0lOgVvjYIxsAnZt5NHt6NS+rxGZ88O0NWv?=
 =?us-ascii?Q?UTVhAxCOAvRdXxf4wGU6g0GqG/WzMyxS5Q+lPRIE9bEJ/ZJ8P7EUD0Tc+94B?=
 =?us-ascii?Q?vIXWIMWO1ArYRwQug7/fOFoLFpgW6VrluB9/VwlM4HOVUI1dIw1TK2pbx2G8?=
 =?us-ascii?Q?t3Z2gfaY/kk8BTU5LsI8e5hdWmXoN2XebBsH+N19F/XB7CKKlNzt9OuewmcQ?=
 =?us-ascii?Q?vHUH/Duup/6MmiimbuyX8x2risLBlHEKJF2fw4fQPU1ME+XAIwKKdl2X/Vae?=
 =?us-ascii?Q?EnqoX4Ipjjor7sjySEJnABWtCh2W/GBSOaKPAk7kEfYAvO9hmIW7s5hlt/iL?=
 =?us-ascii?Q?RB8syGcp9RBoUBPlWdYe6+z4VNcM4Aed8OLvodJvep6sLr0YDA2qr6Ao0tS8?=
 =?us-ascii?Q?swLJskXIWiiTPXWCWFykiq50rkI+/xLUaZM8/41avMUfX6IjRb/zpMieYs9V?=
 =?us-ascii?Q?HpD9tUGU3xv7lK91qXvT3mj9nSCyWF/oABv2pKV4TocPNJHfxf7RTBGXogQv?=
 =?us-ascii?Q?8jiGPAr3ASNvRiJSfygwc8L2TcFWuLKd1oOHzf4xpt+OoBKShUEOVoMUG8uy?=
 =?us-ascii?Q?dR+VA/lCsfXNxWRvQBbAzGcDcsxRETnH61RCktyfHwhIQPON2DJFfhgG1w1L?=
 =?us-ascii?Q?P1AE3Knye4ctTF6qkDYP+nWPxmuKpVi1tz/UEVFUtmYGA+1V5YgtDM89WDWV?=
 =?us-ascii?Q?b+ybAmk+/g3YNyoHFd3f+oC5W4B6MZWGCcbFjVUuXUiiM/ImOY0zoscO3pvg?=
 =?us-ascii?Q?Yl4lK4q3hk/8wFQ9rvyXmQJvwmYPpzYaiOfaDacebcr7vafd0h4qqR3zbadG?=
 =?us-ascii?Q?Qpq8xhYNjvS8XsrKI7wfc5RWBIw5W0SvzGVG1P02UUKZQ55HeybjGSOSqva7?=
 =?us-ascii?Q?iPsuv6vZEkk3WeQ8sdNRCb095FTtR7iAhQRe4By8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c64a7ed-5e1e-42a2-41c3-08dccd49bb5d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 01:26:14.2144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8TGSQNlEzplNpgO2TJOXa6gNBZRdXzitH57Hfw7wbFtrofBOiquX+HB0B238nyGp6C24S+zGLie5WJn7xsKDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10339

From: Haibo Chen <haibo.chen@nxp.com>

The flexspi on imx8ulp only has 16 LUTs, different with others which
have up to 32 LUTs.

Add a separate compatible string and nxp_fspi_devtype_data to support
flexspi on imx8ulp.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 54 ++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index fd1816befcd8..64af89323802 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -57,13 +57,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
-/*
- * The driver only uses one single LUT entry, that is updated on
- * each call of exec_op(). Index 0 is preset at boot with a basic
- * read operation, so let's use the last entry (31).
- */
-#define	SEQID_LUT			31
-
 /* Registers used by the driver */
 #define FSPI_MCR0			0x00
 #define FSPI_MCR0_AHB_TIMEOUT(x)	((x) << 24)
@@ -263,9 +256,6 @@
 #define FSPI_TFDR			0x180
 
 #define FSPI_LUT_BASE			0x200
-#define FSPI_LUT_OFFSET			(SEQID_LUT * 4 * 4)
-#define FSPI_LUT_REG(idx) \
-	(FSPI_LUT_BASE + FSPI_LUT_OFFSET + (idx) * 4)
 
 /* register map end */
 
@@ -341,6 +331,7 @@ struct nxp_fspi_devtype_data {
 	unsigned int txfifo;
 	unsigned int ahb_buf_size;
 	unsigned int quirks;
+	unsigned int lut_num;
 	bool little_endian;
 };
 
@@ -349,6 +340,7 @@ static struct nxp_fspi_devtype_data lx2160a_data = {
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
 	.quirks = 0,
+	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
 };
 
@@ -357,6 +349,7 @@ static struct nxp_fspi_devtype_data imx8mm_data = {
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
 	.quirks = 0,
+	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
 };
 
@@ -365,6 +358,7 @@ static struct nxp_fspi_devtype_data imx8qxp_data = {
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
 	.quirks = 0,
+	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
 };
 
@@ -373,6 +367,16 @@ static struct nxp_fspi_devtype_data imx8dxl_data = {
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
 	.quirks = FSPI_QUIRK_USE_IP_ONLY,
+	.lut_num = 32,
+	.little_endian = true,  /* little-endian    */
+};
+
+static struct nxp_fspi_devtype_data imx8ulp_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.lut_num = 16,
 	.little_endian = true,  /* little-endian    */
 };
 
@@ -544,6 +548,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	void __iomem *base = f->iobase;
 	u32 lutval[4] = {};
 	int lutidx = 1, i;
+	u32 lut_offset = (f->devtype_data->lut_num - 1) * 4 * 4;
+	u32 target_lut_reg;
 
 	/* cmd */
 	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
@@ -588,8 +594,10 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	fspi_writel(f, FSPI_LCKER_UNLOCK, f->iobase + FSPI_LCKCR);
 
 	/* fill LUT */
-	for (i = 0; i < ARRAY_SIZE(lutval); i++)
-		fspi_writel(f, lutval[i], base + FSPI_LUT_REG(i));
+	for (i = 0; i < ARRAY_SIZE(lutval); i++) {
+		target_lut_reg = FSPI_LUT_BASE + lut_offset + i * 4;
+		fspi_writel(f, lutval[i], base + target_lut_reg);
+	}
 
 	dev_dbg(f->dev, "CMD[%02x] lutval[0:%08x 1:%08x 2:%08x 3:%08x], size: 0x%08x\n",
 		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3], op->data.nbytes);
@@ -874,7 +882,7 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
 	void __iomem *base = f->iobase;
 	int seqnum = 0;
 	int err = 0;
-	u32 reg;
+	u32 reg, seqid_lut;
 
 	reg = fspi_readl(f, base + FSPI_IPRXFCR);
 	/* invalid RXFIFO first */
@@ -890,8 +898,9 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
 	 * the LUT at each exec_op() call. And also specify the DATA
 	 * length, since it's has not been specified in the LUT.
 	 */
+	seqid_lut = f->devtype_data->lut_num - 1;
 	fspi_writel(f, op->data.nbytes |
-		 (SEQID_LUT << FSPI_IPCR1_SEQID_SHIFT) |
+		 (seqid_lut << FSPI_IPCR1_SEQID_SHIFT) |
 		 (seqnum << FSPI_IPCR1_SEQNUM_SHIFT),
 		 base + FSPI_IPCR1);
 
@@ -1015,7 +1024,7 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 {
 	void __iomem *base = f->iobase;
 	int ret, i;
-	u32 reg;
+	u32 reg, seqid_lut;
 
 	/* disable and unprepare clock to avoid glitch pass to controller */
 	nxp_fspi_clk_disable_unprep(f);
@@ -1090,11 +1099,17 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, reg, base + FSPI_FLSHB1CR1);
 	fspi_writel(f, reg, base + FSPI_FLSHB2CR1);
 
+	/*
+	 * The driver only uses one single LUT entry, that is updated on
+	 * each call of exec_op(). Index 0 is preset at boot with a basic
+	 * read operation, so let's use the last entry (31 or 15).
+	 */
+	seqid_lut = f->devtype_data->lut_num - 1;
 	/* AHB Read - Set lut sequence ID for all CS. */
-	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA1CR2);
-	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA2CR2);
-	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHB1CR2);
-	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHB2CR2);
+	fspi_writel(f, seqid_lut, base + FSPI_FLSHA1CR2);
+	fspi_writel(f, seqid_lut, base + FSPI_FLSHA2CR2);
+	fspi_writel(f, seqid_lut, base + FSPI_FLSHB1CR2);
+	fspi_writel(f, seqid_lut, base + FSPI_FLSHB2CR2);
 
 	f->selected = -1;
 
@@ -1289,6 +1304,7 @@ static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,imx8mp-fspi", .data = (void *)&imx8mm_data, },
 	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
 	{ .compatible = "nxp,imx8dxl-fspi", .data = (void *)&imx8dxl_data, },
+	{ .compatible = "nxp,imx8ulp-fspi", .data = (void *)&imx8ulp_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
-- 
2.34.1


