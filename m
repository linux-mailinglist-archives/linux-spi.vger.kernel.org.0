Return-Path: <linux-spi+bounces-4605-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E9796BA39
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 13:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6D31F225A2
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA481D88C1;
	Wed,  4 Sep 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="inzDVIG+"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9741D9343;
	Wed,  4 Sep 2024 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448692; cv=fail; b=MOEv+uB254RFzM54B4pwYSNxJrTM9b53asGxLq5V8JjyQm7iuFMGO8L7fyIrcYtYgzzqHM4YAmkesAAI+pz37OVb13S9Swi145FG/VCktXRJkWk0iRQYm36UdQlW9U9o/Br8s5lkut2cYw7pKt9Rw0D+k/YNdAs+9HnBGjEftJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448692; c=relaxed/simple;
	bh=ef3YavUqkpzK/XolJEyNggkiy48U42P0Khosyx2uIYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CzmXe8/ZnBSJVb03gcThdZPJaUeSj8t26+3YJgOu+eQ4EbaIkVzTz/hFLzkRptiSSrUVyOdDm3hHX/pbmrwSLkNbG1uwdURSvHiPvxPSh4CnAvIjb12g+pCmodVVH+pPjMPGqCekPvMdtGCHve11N0YNR0iphSZfMao7gb8tMmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=inzDVIG+; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTZLlObxn5cd955qF0qLB7YqnIX5U2ywnJbdM3lUHIXsyhKbUvnuNLozwmmmls4KM/ZJ40zgzKLbCs2SnAU92GhkRzJLlhJlN38RKxWhXbg2r3NApK8Cw3bWDQRj5BuCpJPLTji8NAIjs0nomh8JD/nQFTgjj9NASMHtNoFvn7j8gemZs3Mt2GY4/+frwj9anCFnWteMBAFZYYux02mEiw5+hOPmn9GiEYuVtt9o5PDrezPk2YL01rmRreu+8L0fFEm5VtCYO+9OVNq2qdY8YLRRozPWY57aQHnzorNGF+3zHC+YZxxK8nGV4Ml0XVQxDkKuLY0TkkKqBMHgGFe4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/LSvGv4kZyZ0z/77QFINP2ie6+5UUh1gzZQdKvtdoI=;
 b=VR2a+4RaLO5ehwYLlXVbQZs+t9nvJYJ86/J+GCT9lBHes+2HgHXTa9wLh4QOsZdM9Ms9R2P+Fq1lcoDFSNeSIspcc6mUMkTiuifEjfe+YKJL9vxghZNfxCJixLHA5vnWQEVkvx2l2L4VubyXNM2YzJZ9Ej/yCteNHLZtO7N4Xl8ME6Ror1rD0J51qXHvv9FNBbZ80VZ40IwwDH+Ir6GXrdawFR2Lsij1SxQTmK+rEr9TZ0OC1t5ySS0o+Ri0Rani3C+tKr5dR0ziiPWb4bWB5sBjye/AEcOaGjOzRyf2/5ff2M9FzSRM1t+KJSfm3yiNGvzXQP0DygmH4vOt5TRv+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/LSvGv4kZyZ0z/77QFINP2ie6+5UUh1gzZQdKvtdoI=;
 b=inzDVIG+Aa+C9YhZsTknA5s6MOh+H1JGnNg6RqJOflwFuuwB/NlWSFWdRerXoYBlAZIfokYdym2Oh8a4kwROi+GA6J7403+O7OqgeOUGHXqwpKVzXKXwFvn20OK8S2hgBjFfMfhwkGaPTi8VeAll/bVKCJiHXw94HOTissFiAfqKXrT48hF5WOHPoOWoY9fdIZTwlUkyOzwpqNx8K9jx6jvbP1waTa9vibu87X+qbx34vsnf+sgBr/SS34FgPjm/zKxDhFP+/n2/gcyznAJJlDxHvIwBiPZh7+wmbm2q//YkRfKcley81Da3fP+bHVFMd8qlhNUY6p/gvAp8Tkjccw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 11:18:07 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 11:18:07 +0000
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
Subject: [PATCH 5/6] spi: fspi: add support for imx8ulp
Date: Wed,  4 Sep 2024 19:17:26 +0800
Message-Id: <20240904111727.1834935-6-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904111727.1834935-1-haibo.chen@nxp.com>
References: <20240904111727.1834935-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 8058f473-e5a3-4169-05eb-08dcccd34067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sBl7PxKuH/Sm+QkChW+amq6ZX/0AT+/lfvVOUGq6cy01Y8fbQeER+myT1jwu?=
 =?us-ascii?Q?PNE5Vw2yACb66r3rxsrdvlArTjYLEmoJhzO0JDemWvvvfh3wxKxYoUZ873+M?=
 =?us-ascii?Q?XkMs6xSe71cvGtI5jHEgLWdYOsxAPAZvbeJSOuAMZYHPskPWJd8caWJwAKi2?=
 =?us-ascii?Q?oZQm+GQrR5LmPKinWhg0tVmR414HearSt+lN9gdW/tDu6QzHyVlB+vxebhQn?=
 =?us-ascii?Q?5ocsJ7RTrfPldBUOEU7vdJaToCukQpH4632QNN5l26PYGiLvzWrEyKUljqvF?=
 =?us-ascii?Q?TUR1iCQJfZ9gyhxwtk9c1Hy/k0ZLEHtfmPxU79FciURB7Q8a/s0nqRxSx5mm?=
 =?us-ascii?Q?WyEXPWjWnkTTh+ayoWt8Ip92iCA+CNvmBtgE4PPEnfctzP5q9Hb0REKJ3sPu?=
 =?us-ascii?Q?yzt42iZlff0i82zJuv5sRLwe0Nyr24OmJb0N2wEIQxaj8MnNYZE6aZgSm6lc?=
 =?us-ascii?Q?fZU6HjOKKjcaCvIdwnzkdFxwD9RR0L0pEId4iIecFSi5RP3QJM9kYRMHwaG5?=
 =?us-ascii?Q?m8mC/9vwAQnnj8YhR7S/pOcpg29G1yNjRxv2RLS4ynRO7SbXN1x15M2KOt9+?=
 =?us-ascii?Q?LyKAMFrWpUYc+iKvZBEcatnJYvwnhyjCM8z3L6fn5SbSMULLY0D8DM2Y1TBT?=
 =?us-ascii?Q?jKa4Ri8Exww+iW0cK5tS2PxebZ4r0ayyuAGuQsB3fVSZrU3Ir2SLhx72u+vc?=
 =?us-ascii?Q?DtEwSTmKb3G6uVdD3PEQGaHI7cAFYSKta/Auq1Pu/B5sHmFk4JGrSgRsfCEA?=
 =?us-ascii?Q?i5h6En6fx2RhBPZZTTkXvotT3+manzOm+zG/gdRO5pQ5YyvM791f3MQvfOev?=
 =?us-ascii?Q?zQw0s1NIk25cpcFl/QGAqIHk5Z3L8+bsW/REuWBTHeuLRu5oSP3lKvcXlJEZ?=
 =?us-ascii?Q?wVwqPZxVvqGmwANdJQJgHosuIZWpEDbX5ZuftRkbztBfKepfUGthcEaM94V+?=
 =?us-ascii?Q?vDNTMkjBhsgKTCpnAr3+y4BX/s25MSR307DdhZne43biphQHrCK9ZJa2ysT0?=
 =?us-ascii?Q?RrKDQJe7wpUbnkzLh6vuf6JypxqtnL5TdNEQkeiqAaEd2gl2WIPoW//s9r27?=
 =?us-ascii?Q?5S/ndvU11silztBfF6YCRmjeNZtmzSfysekiglJSRU+69RZodNvc9JYViUYy?=
 =?us-ascii?Q?M/wRRMXKmcHRbx+LRnDvSLBL0pD0MYknz0WnztYK95sCGsllAVMM2TCQSgww?=
 =?us-ascii?Q?+V9oZW3CMizdPf977WoB+4yUHtcyIcQ8Shhlc7y8uzs/Bw7xYzXFKg7FaMKj?=
 =?us-ascii?Q?8ANRHbNTb+pIzg+yDlrJERu6/OwleGfmXJssl7gDjID634EoGdZDcYBCZsvM?=
 =?us-ascii?Q?FtaGHUvR1QsVpSHSng9F79fqZegGOWetzJzTvbMsh6VX4GEBzCmQttvmRsDb?=
 =?us-ascii?Q?vwqiK4O49vRraXLAmkovmDXSUTf5vfWOs7YVw5QipRPX5pF23g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hooBJtsayhxGLy4wXnAeywNgP7mCZAYhlDGDETlBpv1WwGhKp1N8qxTxY1PR?=
 =?us-ascii?Q?CYdPfEBJ34HV0rIpAK1CqAtt234908euXiySH/PfRN2uC4GWwK6LFjY3mkif?=
 =?us-ascii?Q?RbqxMWUQCuY9nk3Rg+/yqA8CC6Rv8+Tk1lqHU9FtZS3d5DTUWbpubh4Yx5e6?=
 =?us-ascii?Q?486iJWN/0Fmv9AsfNjE3Wi9rL61EAU3MgWTSIVx7R4ImgPmGmUl39cBvND7t?=
 =?us-ascii?Q?Od77KBulBYh5EQPheM602g5W0djjlccCBCwmt8IAC04ndDJsuXkWCRdv05X5?=
 =?us-ascii?Q?olv6seGt+vgvQfhS9G8QZwMIYt0GZizXvS8UL6PD/ehqxaJ6RtIBQZKl3loE?=
 =?us-ascii?Q?Y7lFu2ckbSi8dKPT4P6qALXEcj4IkIZYZ45r7+C3MQpvz/QIsPQBtNUoWREB?=
 =?us-ascii?Q?ZcBDg10MOXV6PuZngNwBf70dwQNq/c6CNkbsV+0Yp6HaSu/Yu84+b5g7UxKE?=
 =?us-ascii?Q?SIqvvUFXCQ4z4MFZHQ75Bxx70m3AhEQAeFqVenPz8J46ABQ1YITxUQfplWjX?=
 =?us-ascii?Q?gd0a4vjoWnJ6wcRWw24AFEnzoMiYnishgFn/I4DlN7B5N/H0Jf6KIYN/rNGw?=
 =?us-ascii?Q?pOQKimXoT79GZVVMk8Lw5GAp8NiDFQCnzyvZm0S6ITSfQfLWTdKSQm+Z2lYh?=
 =?us-ascii?Q?SkMBH4fsqlLpyXdfXsna2sEigxom4FQg/63CY1yueEUnvdTN4AJ937RkFMUw?=
 =?us-ascii?Q?eNe/ak5ZmMyb0Eoi0MJ0pnbmph8YmbjkF4UcYrUOknlNUbuHjFcnlFXuafmB?=
 =?us-ascii?Q?/P1wgUKV2fnF7bxp3gimcNQjFPWtSBWh7gOCNZK7XpQIG8OqFaHeKTjpmaTV?=
 =?us-ascii?Q?w13E5d0wQQMr7JVqKmka9dAI76CbIy7D+egVaIHkGC1Ph7PKTE4XzK280xHC?=
 =?us-ascii?Q?35rNNO/IrOnSo0VnPknnAUG4dsUw4JpZqG+Tv1zYIVF6eU8qplLOcOwKYUVa?=
 =?us-ascii?Q?2smkav133zj+8MsRfYv6Un6ZlB92+UreMtO0xs6YnEDOt6G2OtvAxT9nTdc9?=
 =?us-ascii?Q?4qoI/Y3LFUEZnyXax3alsiPZ6zQSBzf6jd3CbfbEwPhwnpoFSawSVdYtQszY?=
 =?us-ascii?Q?994vQ1PlnAEar7rhtLvY0cwpQxhq2eoVMQ+fRxkq2oSpLoXJYAqGYkbnwCRA?=
 =?us-ascii?Q?1dBPk8ghSKWPkTyNmwNVhICOpDzk5oM0XXwxhnAXP9vYPW/ON7jGjIVvHmVb?=
 =?us-ascii?Q?Xz9TS7rgc2zknBW+x7HlHgXbpZz6kXpKruZIedWd6hVFlg0nqtfK8jWVHbTA?=
 =?us-ascii?Q?HtnUGavFCdr+raENn56JFi/uDljML6U35e2mdiQcRqhs1I8SJQyOwqYr4Bsv?=
 =?us-ascii?Q?4jrifPdmPujfmEG0BFs2T0BquXmig18krLF3nLPFLfsKKsoPAUnCJFHtHQqv?=
 =?us-ascii?Q?LqPv7BbzyvlY1g7awOXqyan4rjyyi2mpCSlR4OxELrwyWNwZtc9MkG81CvUz?=
 =?us-ascii?Q?JhY42RY2QwS2Fyuok54USuOjeEhoI3BDRj9hgoP3DrS5TDNIDKQ4yl/MYwYc?=
 =?us-ascii?Q?ksA/EKUBAJFc1KORK8IKCbRgvwQvHV5za2uTaVDsVaqPq+vpF2VtfmBtE4Yq?=
 =?us-ascii?Q?YzyVt/87B1U1lExeeHuX+hZVV4tmrumz5qf8hjJX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8058f473-e5a3-4169-05eb-08dcccd34067
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:18:07.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4SVQy5M1Gx2RILEMmaBKzHdLPIoooumnEdvBV35a0aS+fjpgw1w7zjTaBijyvAR0Y6JHxW8bnbUyarxOckgHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

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
index da110188bfed..96219cea65fb 100644
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
 
@@ -1288,6 +1303,7 @@ static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
 	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
 	{ .compatible = "nxp,imx8dxl-fspi", .data = (void *)&imx8dxl_data, },
+	{ .compatible = "nxp,imx8ulp-fspi", .data = (void *)&imx8ulp_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
-- 
2.34.1


