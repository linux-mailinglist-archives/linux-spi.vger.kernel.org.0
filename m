Return-Path: <linux-spi+bounces-11738-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2CDC9E55C
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 10:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B318347949
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 09:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81C322A7F9;
	Wed,  3 Dec 2025 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S2xl6A50"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D902D7386;
	Wed,  3 Dec 2025 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752423; cv=fail; b=Dxhni+xgsFHGLpAbqjbkhbyswQEMT52OKD1aHMaTwcY9CgLwTncQCAnYO9cDY04urxqPTBZzv/ZxkGm4XHTQjVGegyrUOzk9oHbLDJ+mepOU08C0XQB2l9z64pYiyUtoL4LASqBJmNJiIGhl9cZ68oznv7S47aWDEAb5fPSsvV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752423; c=relaxed/simple;
	bh=oyI9WTwZ6g80BN1s7P0Cyb73CWhE2fgJL8qtM1k4S9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DnTKdr+aN61aOtjjhaB1FPYHuCIibNMUArCqX/79nCMQVWjxGr3l2oYYlMy/dC0UiKeRkfdZdb91FgxfV0aIfezmWN/SJBICCluKJQqnx8zqTE5ukbq2SB4PGZRXarUpR8eASa3Rt817b2tBg+lVTznvJkB9xeu8krhQURTVyHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S2xl6A50; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjWL4h8ypXCx1S39ORX3TIVId8ms9K8BZm7L4qlZJPw9Wv/B93B3+Z8HxNVUH+ccI5jfqVbtrrY4hZ7c2d+UlX9f8TqEysuX+v8YCLhDuZvU9Vu1QeQhOhYNdLxIirba8KnpVHw7QJ1SAeScH3ohy3K6OZpmVfykr29xFP0Sz/QCAe3H+52zXUPhjbNwCDN7Vi8SxnVpYke3FmRh4ttoEtnoeVAtNVXw8y2HXNkprvgMl/E6KyQAqNLncQDxBNCMrkYaLIPjZp2P0RfbK1hAdJOQtsPi+dwNvxN/o3jh8LI4OqBGWSeeDFwLU6Jf+uTnJel3PFVomACYaVadiwU+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBl7SPpwDmJwl3W407WH9B6rJ2WP4FW7gw9m2ThH9F4=;
 b=ufBlPcJX08wzf3Ybb7fPmYz52eoc6p+Um1eIccT89LbuUATgG3XZINj+sxpwBLmTWD4/G77Ns/dy1B8OB1eHouElj7tJ66FZWfQmK5r8h9v6BJdWWy+xGXAVg1gysBClGHJFP/l6Dya89vPfrLTBb+Ws7vUaUqDawD4eew3XxfyGUSaVyMJqeoGz9frXl4aP2gkbHKfgDtul9JFE2/9H0D5l6Ln9WyYHPRmGPEG+44DwdR8k9GztwW9r9YBkcfsO3DRyI4gYGdtMKvu3gcQcxD8KAh/bT+fgX0MlMoQV1BYsCx8ieJDOr/vcyL+jGuw7NC3Y14F5mvlD5LLOI5NEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBl7SPpwDmJwl3W407WH9B6rJ2WP4FW7gw9m2ThH9F4=;
 b=S2xl6A50z9zsm8EL2sHegGw+mMx//Qznrfz1loSfqbyX25jO6djYcK9fALShcneJGI3ng+64DayPZJg1Ikyv+ctKjluOWm9TcBNEBAg0wnBKugKumA8pZpA53kn+/dlLl3GylV9LCPZLanHSTk/4lT4moM+bor+0xe/u+InH8GTYE1EH6RXGjzy5kGY0NMGfmGxAWdDIk8t/gMYUDKYNJW+XOWo+CyOmM9rpGH0UgTJYW4SIgxuiHsVNCpo6lqGKDIAUYU/PJztrq504dpeftjhJftXT1+iuniKaWGtXES3tcuKnasbUEmGekEKYgHdkbVqxgiGGfQ4xtTcM4awRCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA4PR04MB9663.eurprd04.prod.outlook.com
 (2603:10a6:102:261::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 09:00:17 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:00:17 +0000
From: Carlos Song <carlos.song@nxp.com>
To: frank.li@nxp.com,
	mkl@pengutronix.de,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 1/6] spi: imx: group spi_imx_dma_configure() with spi_imx_dma_transfer()
Date: Wed,  3 Dec 2025 16:59:44 +0800
Message-Id: <20251203085949.2922166-2-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203085949.2922166-1-carlos.song@nxp.com>
References: <20251203085949.2922166-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::27) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|PA4PR04MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 332284ae-3d37-4cd6-4e52-08de324a60db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ODyqLrAdGEyLbt/AyIoQGh7gcpmnjR9hci+KvAGZIDM6rKUoO+cjQbh/5M/q?=
 =?us-ascii?Q?ywu0GGvCo4Ui4gPXY8dNwlx+Il2osRKdR4A7H78WpFXWhwYTvA6eUzc89bmn?=
 =?us-ascii?Q?oSCyWTZuYGkqJwGXFg3xLoUabFEMyejOvxKi2b1YaATBwK31sl8eyv+u355r?=
 =?us-ascii?Q?xF7LqhJVIceaxOC0ZfyltwZl9WAHAPQmyDivtOFGrE08HD+JEsOzVmh/E+Sm?=
 =?us-ascii?Q?zbbBnC6Ht9ydR9bRCE2lLBGxoJtA4aXnCTmMzlcSu0NVQjex8xLYdxCcRVCg?=
 =?us-ascii?Q?uEggkSRMQmXtcLXrI1x4XF3ylC40rsBFwQtY56dib9eZhAiQwckuyWROvOsL?=
 =?us-ascii?Q?bou3zP52ncOYCIX5NYvVRt0ODHb2dF4eVAjphmWsxG18Xf0LjaqLsNT1Y0LZ?=
 =?us-ascii?Q?sbNSneQ/odbCUD7Sab8Q6EkimnfGaYup23K8ecpunXZxI8vUioQTfhJxlyjE?=
 =?us-ascii?Q?ax7pWZVeFwBzC+yj4g+ivgYrTw4gFHWVO6MLQCmdNhJ4BkyeCQMeBC9LA4D+?=
 =?us-ascii?Q?IQ+h8o2n5H/K22VZwvMbF4ff6rRcqLAlZgEnIOVXPaOSJ1cKcrVaU/ahCJcA?=
 =?us-ascii?Q?MqO77U83VRmozE4DoHWdxhQwzTucjEcexbZHkhYAj3UB/26QFtOZCBPNAXYF?=
 =?us-ascii?Q?YJLsRg/ud6gw3idGAMEXWig6Dd5HrS2tdSX+69UR5hA3bZpyoxAOYLsu28fR?=
 =?us-ascii?Q?WyumtiU568+LisrbzsFpXAMxD09SbaLLRY/81rva2CdQ8FD0SYCTdwzM1uZ6?=
 =?us-ascii?Q?fK1EJ6z/JAhbIZtyH/8dn/oHpraDQ2ZXYy78chzA8HxEMfKRtZD5GF9a4igb?=
 =?us-ascii?Q?fyQpbunibi/50DvVEVpKOrKSolMX43aZ8cZyK0bl2Q156FeQC5ZXiW0RSXqq?=
 =?us-ascii?Q?XaUvkHQdKeiZWOY6grPlkgNUfaILim9MMl6dpqXUHE3LUoLz3FY2HeX8uI5m?=
 =?us-ascii?Q?l6kGzbkwUNOl5dlhmAbWqhPNugJSHvt8RjMCFgCI5HCHooO16z7hoPnxaK8N?=
 =?us-ascii?Q?Y3CSXEJUiR6euGlBwbPXYzTLknu+zEcN6Gw9WPbqLBSTz8eHuLt+QjPqszBC?=
 =?us-ascii?Q?XeRCwCZzSXsYQbenC11UZ4KK2cNFNhUVV8hHt/qLNwOz9v9XHE+acya7i4HT?=
 =?us-ascii?Q?6f6X0ojy5bkzEX6TdMcUH1wjVb5S5BroaB2u0MLoCCju+x9EQaljNx1W6czL?=
 =?us-ascii?Q?XDJriWKD7RYqMIRbQsvVeeK/kZwa5s6vBV5n3THdTYbyY+/QVVjOxantQZ8w?=
 =?us-ascii?Q?G0d2DqgFIFA+o79DlVsqe2Yom7wYGTo5KSJonCm/tt1n8/5FPVqlbIRzWbAg?=
 =?us-ascii?Q?sofDYnpRMQxwaxa42xGBdJXIkBCq0WRov5D8b6rnDQU3XPlEjHsEGumN/0CF?=
 =?us-ascii?Q?tI5F/iCJ7XpAiemqQOTMsKulVZEqO4iySsBttUsTZfCMGeBZDrTUvVGRwhua?=
 =?us-ascii?Q?FN+qCq4MeC6+6Oksr2XBZz1bZH9qicwRm/YahOWERM2HcYBLtZRqA4fLNJGT?=
 =?us-ascii?Q?0i7glmjebmrIXlhP/OkhgCvyjSXnjIVXsPby?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n4R4JdCBjKTu9jPNVs6sjqw/DMjVgTUOwzTGc+dqeLMKoEjZg+Xt8yVVcKTy?=
 =?us-ascii?Q?VwcWe4r8ZawezmgVGp1ldK0++8gpUorNNIQNSnZPx8/KxCxyBNJ2DKg2KN0O?=
 =?us-ascii?Q?9X7IwNoaBESKqNiWMf08fhWl0rn+0S4TQN1zMrSwUQOyvoh+Msc9ldZKBBvc?=
 =?us-ascii?Q?JW7fGXcIlk+dAhDq+8XJODINtLV5GCYU6US6z3Gd8VwneRPrO+Tmruo6EoMy?=
 =?us-ascii?Q?u2IlhDEm80WoSIB/qMh3cfatUZgNwbWrJrrrHj2Av3+6/LYGWUK+teQv7w1J?=
 =?us-ascii?Q?vBzdWrWxxWE8Z1Rpsj91LBbndQt7ebcV1nIjSmr1X35zj1St82v9zySjOxFJ?=
 =?us-ascii?Q?CDsyHuKi2Lk3pGlo4y+FXj9b+PZR7DUEEFRsDW7m27DRkqQQbUJyFzWLKFTE?=
 =?us-ascii?Q?2Vls0JXll1iXQzEibfrEzkM5Zoyl0jAXsmJk+Ioi0QPvdUhFrxixeZq9PEuE?=
 =?us-ascii?Q?0vyVA/QzyjBQV4wOfOzFbh8kMcFYmhkzy/fBT4VQoJKEEIe+C8zu4KXnUwPq?=
 =?us-ascii?Q?I2SYwyKJP6nQmvUBmBSvZJvFQ5jnY7GrPFYjNHu/RLGZINhg6Kl3FRxc/KnE?=
 =?us-ascii?Q?qkG5VVAKctott6zmfbRUmiUjxnRZObxbHkvFWKNd7wIz/C2CEeNVaiVgcW3w?=
 =?us-ascii?Q?VQkAf2EIT46uHQX+0qfdgyAfJaxd4u4nOKc+RDxAB92UdN01BLgN1hMo517S?=
 =?us-ascii?Q?1Pc/x5s7d9QOtrLTFXSqJLnwWfQ5Dv0gcYUVwqeFB6h7D0RAyQw96DgCVP97?=
 =?us-ascii?Q?sGcr3yuvsk2u4d55tjK0dIlLL6hT7laakXBuz32w66K2shY0ON9yVyxNI4CW?=
 =?us-ascii?Q?MJnt0Wa79H7UJEmWhjohEvvTS9e7xHGUtFwE50YQe29dRX+5M1PFWL5ttsSJ?=
 =?us-ascii?Q?it9QHEGd3x06Jo2SQrPA+dQQhCtsVLI+eeJk4ngMEpT7F8b19AvN3P5xke17?=
 =?us-ascii?Q?EpG64u4LQ5XRIUAA/vesc86Hj1D+t8HzMvv1Il7E8w/HSOdKZeRWw7XgnySz?=
 =?us-ascii?Q?zq4PmDGw9ME2WKE8lZupggkkY+q1KBHIHdxNP8FeAwmURqMN+GueFCKkrK7Y?=
 =?us-ascii?Q?USr0k3GpEspfO2NZL/Ya/bLGP3b81xxpCOQkkqlDMQU4rXXlqcvIMFmcZt+Z?=
 =?us-ascii?Q?+07i2HWC8osaen3GzlwGAFIKH7DdjztduZlDoHCUqUK9+lYX/nBZNm7knnDw?=
 =?us-ascii?Q?/eXoObMHPL0q9cld0DCi4DdP2IB8s4fR1QwhmfvJQqhzlBSVWVWQd2+9HCzS?=
 =?us-ascii?Q?MZuIb9qo8n/AE9IuRdRHM/b9Luc8JGI2Pbhan2t8HAtPU9mjux3dxssc7LqK?=
 =?us-ascii?Q?JYnCYa4ZOmw27FscmNio91NSLutFhO3ZOPq93NzExOhbg1L8epxD3oCz954I?=
 =?us-ascii?Q?btu4oFFHkWLvze3LhDlzdIhK3nPCaRIaf4SkA5WjnGMwzrl8U7bCEA6HsqH8?=
 =?us-ascii?Q?WjAZ33jeb9YasmJMkSqRBmFUmOsHsBLVJFBBCd+A+0XRkn1HxASBCCOyHMjI?=
 =?us-ascii?Q?TvO5N5aPNVT9SWCGt7vS1hCzTtm6/o+B1Tbm7crSL4FPpdD+HaCwxNvGJSh7?=
 =?us-ascii?Q?B5lY0pfu5CKzDCGHoDVyh84ir+NmuabnoGyaF6sS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332284ae-3d37-4cd6-4e52-08de324a60db
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:00:17.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMW4hmUAifh6JvLqcHTIKIzqqj0MtpozG0v/Sn0h+gHmBhHJT1Wxcj4ibml4a+Rpr8fAgAIKTy1Q5+yZYyTWiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9663

Relocate spi_imx_dma_configure() next to spi_imx_dma_transfer() so that
all DMA-related functions are grouped together for better readability.
No functional changes.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-imx.c | 88 +++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b8b79bb7fec3..e78e02a84b50 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1282,50 +1282,6 @@ static irqreturn_t spi_imx_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int spi_imx_dma_configure(struct spi_controller *controller)
-{
-	int ret;
-	enum dma_slave_buswidth buswidth;
-	struct dma_slave_config rx = {}, tx = {};
-	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
-
-	switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
-	case 4:
-		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		break;
-	case 2:
-		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		break;
-	case 1:
-		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	tx.direction = DMA_MEM_TO_DEV;
-	tx.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
-	tx.dst_addr_width = buswidth;
-	tx.dst_maxburst = spi_imx->wml;
-	ret = dmaengine_slave_config(controller->dma_tx, &tx);
-	if (ret) {
-		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
-		return ret;
-	}
-
-	rx.direction = DMA_DEV_TO_MEM;
-	rx.src_addr = spi_imx->base_phys + MXC_CSPIRXDATA;
-	rx.src_addr_width = buswidth;
-	rx.src_maxburst = spi_imx->wml;
-	ret = dmaengine_slave_config(controller->dma_rx, &rx);
-	if (ret) {
-		dev_err(spi_imx->dev, "RX dma configuration failed with %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int spi_imx_setupxfer(struct spi_device *spi,
 				 struct spi_transfer *t)
 {
@@ -1481,6 +1437,50 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
 	return secs_to_jiffies(2 * timeout);
 }
 
+static int spi_imx_dma_configure(struct spi_controller *controller)
+{
+	int ret;
+	enum dma_slave_buswidth buswidth;
+	struct dma_slave_config rx = {}, tx = {};
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
+
+	switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
+	case 4:
+		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	case 2:
+		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case 1:
+		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tx.direction = DMA_MEM_TO_DEV;
+	tx.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
+	tx.dst_addr_width = buswidth;
+	tx.dst_maxburst = spi_imx->wml;
+	ret = dmaengine_slave_config(controller->dma_tx, &tx);
+	if (ret) {
+		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
+		return ret;
+	}
+
+	rx.direction = DMA_DEV_TO_MEM;
+	rx.src_addr = spi_imx->base_phys + MXC_CSPIRXDATA;
+	rx.src_addr_width = buswidth;
+	rx.src_maxburst = spi_imx->wml;
+	ret = dmaengine_slave_config(controller->dma_rx, &rx);
+	if (ret) {
+		dev_err(spi_imx->dev, "RX dma configuration failed with %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				struct spi_transfer *transfer)
 {
-- 
2.34.1


