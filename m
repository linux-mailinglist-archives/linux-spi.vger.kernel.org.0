Return-Path: <linux-spi+bounces-4660-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8D396D3C6
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 11:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E25DB2187E
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E171991AB;
	Thu,  5 Sep 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TjIAKZ8H"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78102155730;
	Thu,  5 Sep 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529509; cv=fail; b=awtGBAArqZn/E90A5sRzbN/0YYjP+cE9yJFL+ysKxGnCVki+r71S9kUq2mlUZA7xoceD2NmMrRl2LpZO0BTYTupQKsMdgDrcP2jQMYT7FSXjmoYuMFJ6BuyyWdjbmuPQWyNQC3e74asFxAtgCkZuO+ocGTvt0ZQUhjxNWqL0+Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529509; c=relaxed/simple;
	bh=pG+FJnagx3ncsCDAviUT5rNeknV21ooMIieQiG0ZydY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JpfxaGjeuw6NkhRmbVfamvjsYSwLSZpRXaidyt/RL7THFqxML2yrsDxETspJmY52yweMv13xT//MxZmdyniBCJnjqq642h2o67uMal9YtNdrJBcOshK2nG8+iLssajIHyCK79F0NSjuYCajgeKM/6UVyZlul+812A5RJY1fSNTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TjIAKZ8H; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2fvlrqfQhRnXemYRCjPc58eRAbtSBZJojozMvm1C3nJxkYO0lP4IEZVlntVN+2dGVjh9t/UdC9RsxKkotcCKh6OAwVKGHLZM98FoECBZqJ8ZaSeHfwiwvq7THhgYRtaZ1bSpEgGLqv1wuk301dD40QSzXQfuS4CQGWcug2fzpcerLBJ44NWrpRBCc6w8tBPOQMlSe+eY69h789US1USpuRpq5EJWffDxIuUFfI1e5j281fFfb36OkZLpCXkmdM8Kw+WmNkYYW6fPJkY7JJ8GQ87SKctnCky673T9vefx66bLS7cQwTUfuR1i+5KoH8jLJeXujyzoXZx5IKqXedqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yp0ahkYmTGtbcqQDrUUmhX9lB7qI8K2udlUgJ5jZ7y8=;
 b=mOAgy/gOr35A70jG7LZOnZIybHByhKhbaHd9+ty1eFIumIplTJ/ALlf22BOaRAT/ES8w6Q9LVNZMAVSba9bdFXl9sRwG8qC/KTNZ9a1tLdWhFNKwb0U3qkkKiVziZ5DMNU/NyP8mDILeuw9ZdN1aa0hOMzQNxG/oUNUgr/q//eQK5R6K0rmtZfSETLIAuSaj8dzMbM7jHymyLsr3gxu+K/Of9AV8jNYlpp6R6gCGuh4bNHQhkhehnydTnHPmFBv+pDKVhw72eq3eejc8cWEstwIU03ujEtulOi2tgwbQ9KpX45hcp3im/yjBxdGYteCvCYlJNX5Glb8Sm2deeZSjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yp0ahkYmTGtbcqQDrUUmhX9lB7qI8K2udlUgJ5jZ7y8=;
 b=TjIAKZ8Hp0Yyeo0I5qc0a1k5SiDNjLKM0IEhr2lycMsrwm65pWVbyKaPQ3B3YPPwgWcG9LAGzMOHz2mrMK3N7hfUULrxdcJRSjsCbZ/BQ6n0VivXnGHkYrPnUNHnF2HrEIjp9EZjffgEx5MFx67lKfrs1KAdDksKnKWHR0Rkg0hDBnNd38MMefHHxKJsfHAO8AsUu3k4/bhGT9M0i0wAdx/lcoiDUk85YQuZHDYk1psuNESokP9GU5bkBNzpu7P2udnlxxjJ3WxPtLfhpZLH9gK69ujrubIDSLK2ssCEBHVbytKES+RZZNQM6xRg8ExNGdQtvFfayItv6109XPbw0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10306.eurprd04.prod.outlook.com (2603:10a6:150:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 09:45:02 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 09:45:02 +0000
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
	haibo.chen@nxp.com,
	peng.fan@nxp.com,
	stable@kernel.org
Subject: [PATCH v3 2/4] spi: fspi: involve lut_num for struct nxp_fspi_devtype_data
Date: Thu,  5 Sep 2024 17:43:36 +0800
Message-Id: <20240905094338.1986871-3-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905094338.1986871-1-haibo.chen@nxp.com>
References: <20240905094338.1986871-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10306:EE_
X-MS-Office365-Filtering-Correlation-Id: 452c234d-70a5-4f1e-df8b-08dccd8f6a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rc0/UyKJ84frWv9P1C5cNyWtIEpt0Kz3nb+sxz436/34CW8SdqKaPYz+qo/F?=
 =?us-ascii?Q?+84KViPeUk3t576Ti1x9T2rTS6NSmB5O4626NWm49lvSZxDD4dl4TN7PL0eY?=
 =?us-ascii?Q?FEqSjYyhr1wfXbDhQwRP5+ZAytzHDTLbMvmJuQgbBtRJxOXXk/J5Pa83YdGh?=
 =?us-ascii?Q?7mX/DNBO3FfdcREiX/YuflW6MuBGfq/kTcTGST/j6xovcGLuAepNPqmD4dyr?=
 =?us-ascii?Q?aWqxJ6yS1MgLBsYoV/gK/rlSkj1oV0z70uaH6jiej9rYsmE5r8hX/FmqcUeW?=
 =?us-ascii?Q?CUQ0WIokpPFwHnZ1cAH+tepXbjjFuihbhK5NyurIE0QxVx4vXiR6FiLFKuIa?=
 =?us-ascii?Q?r/nTkJpIGSP4Qii351lgPY2TwEsQsagKt1os/+kngY3fqphbCDv172LM4foa?=
 =?us-ascii?Q?ux/bkRdfMu/JUcWAOwu9sY1ZC2tr2Bdw3jZtqKueEM8KU2RHu/D5RqHjBKqu?=
 =?us-ascii?Q?18cfAoa58FaimtrY6E+IKq+9dviGew9n44fbZT78wJPza4/7aMrjotrxphlK?=
 =?us-ascii?Q?Bs2z1zfiGDIcTf4+6UW+od3tZlEIQnS6Q71HtUvOyxRZlAq2bYsyRynrAVFW?=
 =?us-ascii?Q?7KAlu4AP2/xMnuqmucibB5TVfVuvXybKbDwgwvIaVI8LNDxxqW/GgQipRZMq?=
 =?us-ascii?Q?IZMTsvXhqybmTg3nsff3AvjD8oOL95m0ZXbQFBI55ZGPBY4Q2bvHw4cuADxB?=
 =?us-ascii?Q?HbzZZhn3z+wFjnHAsqdY0iqN3itO/OzELdrFaUM92xTSB6QGKyuGzRtR0Y8G?=
 =?us-ascii?Q?wBmzaXhOlfwb28A2Fw9xJRoQRa74SRuhyoEUZ5bTED/kFFc7CPI2yEPPSXpJ?=
 =?us-ascii?Q?JaJyi++N4IPsbnUQLWPpTe8ZeCrEbh9Iwfavq3s5S0ZTMDeK6QeCWBMXFgdj?=
 =?us-ascii?Q?DEGgehY9txg+PXeWjb/njsiS+xF06JpEkoRgkPIAO9pBsRV97NqOR4rOIoiL?=
 =?us-ascii?Q?61SLF/XmxaP7wgJugh7SY8/l2K/3EY++ydd7gRtj2ZhAUnYfdZM+4HooIfJC?=
 =?us-ascii?Q?+1cLenombCP5DUIOY9YlQ/iilPFoQ5YtEhPBEx9pgBq9K2R8Jvoa+XvBVwGz?=
 =?us-ascii?Q?TRTCFvYiO8dUBu/eSkJE8P8W1MNt2cxhK+lX/5LaU9bYRkQYAgnnXBX9kaFn?=
 =?us-ascii?Q?IKAkmo2JPk64TDrLdOf1+0lbATwegatpgWINDndFR7/Gf6a/IeIAnVvFxFy8?=
 =?us-ascii?Q?sxRmKShtKpOqz3xu471hFl4VNjyhSEztPAoEX2cakLD+rRkdwQBfmxUODqgQ?=
 =?us-ascii?Q?jxdxu4ATWwvuOeS5tWWtgJpzNl79vS83zyntyVi5YsJ7bbE8Dmgaf7UmIR3H?=
 =?us-ascii?Q?755w/mCQwNfLGXu4xL6EE5QhllELwxf3m7U3jIBhJxoDOWbQvf5CUlPQ/d+j?=
 =?us-ascii?Q?2P+2W/wA45We6xIOvvsyLrjN5ALU8DCDdt1ACTVpbyx/mhGdAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FBmyjqUSCl0B+w2zirs0SsHOqDBl7MHRgmCZ6vLSvNeBFgWwgZoicm67PTij?=
 =?us-ascii?Q?+hMocfLLZjH0nt9DIGkxHdu+mLNmWwkCWuvohMzGa4iRZWpHv0X/VA+9kej6?=
 =?us-ascii?Q?+GaQdIUE8ZyF7G5PtM2VELREpLg3T0004BwO9aksWY4pVZb66VoMwkFv3hlH?=
 =?us-ascii?Q?1rVl2VNjtqrIbHPKoAkDZ/1XL3cdBdiYTs2E0fWGY6V9bkhlNMlDWmevSa3U?=
 =?us-ascii?Q?2ZTxahh836dFA8vnPvdRrkZefHetTJwwloidD/V7ZuW7tk/346rykDaZ3Bip?=
 =?us-ascii?Q?1Be055sBTMZWOezkmb2O7oPrLytjB09BZeaKikScoG5W3vQVImf4+SmgqhIp?=
 =?us-ascii?Q?U9LeXB0azXJ0NFXdE88vhFZDUM+dTTwuiFUM0/KwHCftFJT/7KUb9u5QFtbB?=
 =?us-ascii?Q?JJiV7s98zs3ReEMWt1vMcTd1y4Jbbaxk+92BaN2XJkQbnJRQiTGPWyYtKEc3?=
 =?us-ascii?Q?fDpYwCCtCA6N8YPhWpMjIf7O7KftmPnPoEuePXqoDV+K6IVr+P8hRscYOi4i?=
 =?us-ascii?Q?pEOFx/Y+ibzDkHriSli81Tya3AckbdFiXOvTSOnQNbh0A/ZCmXwi6aFBHiur?=
 =?us-ascii?Q?nbb8SV+o+m2vdcMB/T+Lj+DlR/3hB191PiilO7d6P91DJVlyDg6ijbzzZyO5?=
 =?us-ascii?Q?rwZxTLCRJsnxrxjjTm1Y0ZwDzLwa8S7uO71Z6UFt4bubuREcgWTuBoMhadQC?=
 =?us-ascii?Q?ig2TkLtamlaYYtDn0GjqVJ+bcGpfp26dqPZuyy5fmSTprHL7X5nVTmu0a9z2?=
 =?us-ascii?Q?/EVU9FMyAlRg2lk5ZhxGFP8nMFYPkUZFQF7d1efwYPu9T+E9/MABiynAYovK?=
 =?us-ascii?Q?r8oyrkWTckbUc0Rju/X1P0BPHmAP+vbI03/KbNJAcO7GAsZ+pmy/ArLA6l1O?=
 =?us-ascii?Q?TefqRtoMjYqt53xuCKV0v14QGTp92WMTeSf1U0BFKDWvFMHiqaasRnv5SnH+?=
 =?us-ascii?Q?QjwSDcHVzAivxDzVmctkroKSgOEFMwayrsB7QZfie9Q4mK+AOokgYGeyFfo2?=
 =?us-ascii?Q?9vzvaLSoIlCwEe7bnK5r1mPFcwX98kCd3RENT8nOY1qa8ObeL5PL6yFpdWUg?=
 =?us-ascii?Q?mR/uriX6EfrNwSxrpTGHu/VUG6sc4RVTpPl2s8B2u2GCSWhFGW9l32piOwTJ?=
 =?us-ascii?Q?jDUIyOLRgqpeQ4xLhyM8OW26sc1Ph3rdzovACTIGyluh08IOS9vMvQoWhv0O?=
 =?us-ascii?Q?MgqmXuiERtNv9qX5GFrCU97ZE4wJ+Xon8oI5LgrQHvM3JayLA8BmJ56Kg2j8?=
 =?us-ascii?Q?cuP7MDh7oUWtzG1ofSnMjMuPgTttEipgW5X/heYYcuVS8nU+C048E4ynveKQ?=
 =?us-ascii?Q?mYw48ny56z/UibhBkON4zqvbTBz8FyJNt6iyMES/Ww2RDjNC6V0/CVJ4WWLR?=
 =?us-ascii?Q?MA/ChVbF0+YYiM3dbRrZVzFdq16WHP4hJ81mWaWW5UfdF0flWBRy2IIOb9K7?=
 =?us-ascii?Q?PBDb8nmBjGBH7uGvodLkgRoLSo+phCjOaGPaLDXN9UIi4UgnLdTnwEy1bH4A?=
 =?us-ascii?Q?1C8h02wZ0zn38H0jJJm/KWpr77BZVCn4tstTfGcEVLfjcV1w+aMseO2A3lxn?=
 =?us-ascii?Q?pS7R+MxR3B61oydaKeQAoU+GEKN5ADUEjURDqdwy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452c234d-70a5-4f1e-df8b-08dccd8f6a18
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 09:45:02.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbevghjBZESYmCOHFDFGN7wJ6QsOpQtaFhwmYinfAUgLXNMyKMgaadEIBW8ARVy/mxmgniCMGL45cF0wJFJjhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10306

From: Haibo Chen <haibo.chen@nxp.com>

The flexspi on different SoCs may have different number of LUTs.
So involve lut_num in nxp_fspi_devtype_data to make distinguish.
This patch prepare for the adding of imx8ulp.

Fixes: ef89fd56bdfc ("arm64: dts: imx8ulp: add flexspi node")
Cc: stable@kernel.org
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 44 ++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index fd1816befcd8..f42c14d80289 100644
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
 
@@ -373,6 +367,7 @@ static struct nxp_fspi_devtype_data imx8dxl_data = {
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
 	.quirks = FSPI_QUIRK_USE_IP_ONLY,
+	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
 };
 
@@ -544,6 +539,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	void __iomem *base = f->iobase;
 	u32 lutval[4] = {};
 	int lutidx = 1, i;
+	u32 lut_offset = (f->devtype_data->lut_num - 1) * 4 * 4;
+	u32 target_lut_reg;
 
 	/* cmd */
 	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
@@ -588,8 +585,10 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
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
@@ -874,7 +873,7 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
 	void __iomem *base = f->iobase;
 	int seqnum = 0;
 	int err = 0;
-	u32 reg;
+	u32 reg, seqid_lut;
 
 	reg = fspi_readl(f, base + FSPI_IPRXFCR);
 	/* invalid RXFIFO first */
@@ -890,8 +889,9 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
 	 * the LUT at each exec_op() call. And also specify the DATA
 	 * length, since it's has not been specified in the LUT.
 	 */
+	seqid_lut = f->devtype_data->lut_num - 1;
 	fspi_writel(f, op->data.nbytes |
-		 (SEQID_LUT << FSPI_IPCR1_SEQID_SHIFT) |
+		 (seqid_lut << FSPI_IPCR1_SEQID_SHIFT) |
 		 (seqnum << FSPI_IPCR1_SEQNUM_SHIFT),
 		 base + FSPI_IPCR1);
 
@@ -1015,7 +1015,7 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 {
 	void __iomem *base = f->iobase;
 	int ret, i;
-	u32 reg;
+	u32 reg, seqid_lut;
 
 	/* disable and unprepare clock to avoid glitch pass to controller */
 	nxp_fspi_clk_disable_unprep(f);
@@ -1090,11 +1090,17 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, reg, base + FSPI_FLSHB1CR1);
 	fspi_writel(f, reg, base + FSPI_FLSHB2CR1);
 
+	/*
+	 * The driver only uses one single LUT entry, that is updated on
+	 * each call of exec_op(). Index 0 is preset at boot with a basic
+	 * read operation, so let's use the last entry.
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
 
-- 
2.34.1


