Return-Path: <linux-spi+bounces-10418-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA63DBB1FAD
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10793ADF54
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB8C313291;
	Wed,  1 Oct 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="OyLxFIOp"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020102.outbound.protection.outlook.com [52.101.69.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7E312816;
	Wed,  1 Oct 2025 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357456; cv=fail; b=kB9S3us/wYgvTSCC4gQq5bu787iC4KWBMWYHdY9ZW8jDO7yz8PQqG2bhf7fbDg4/Gi4vzrFSjH8x8JPlMRYgF3E1Yw/t74mACuSnlTeqxuOWaRmAP7vhPz9qz7PJMaPTo9OH6e2v52jKjhLD7DrJBS4Up08mSUk9J17zAfotWB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357456; c=relaxed/simple;
	bh=RiKbo/qwhlU6jP31RsuFL9gEwPwjUa/P/53eg/G8Wy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qdN5MGuALSax7NG7wYnT52E6apcvd6/WqaBaUtY29teVO+k+hwdHMFvG4IfdjWGzHup02JAc3DKWKDS9U4FszUfbBhqdgWjeWRdhkuFbF3oBV0fRciKdKMsIElezIFTVDm++fuQ8P9cCA/TQnY8HVxzulbrxOs9/Tq0/USArk6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=OyLxFIOp; arc=fail smtp.client-ip=52.101.69.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gErU7mwb4T55aY/0L/ZGE88SHMfha5SI1APsFvsYKMdzgam9cnybMXikxJjFV8ScJcRRNWe2+TwZHi5/MZJgGb7wQ0kdeKYku9KeDk/KF8qyg8mPOiODVxNTNIhxZmru8diMLDgHVGxjhy2Ukr7qETNnTrXy/lKnHrkTgdDdi+i0jxTPfh3T37ChSJha6KkVdjJhMtv0Axs8JcYZRLXz7I7Rxm5FcMb+qP2ByUbfYJygVUUSp350RVkKL0Su5YKKo/K6ScV9V3LQFz5tufhwjoN9vZ+r1/hRYKBNOyBtqyhYTRpiQIcwxmSKSRMXBBp7YcNYDwumlv10U0/5+TWFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSyv9KzWw/RI12dwfNpi4y8uBoDZVv0XdyTCW2gY7B4=;
 b=VLz3/koZRV+3Lgp/LsC3jIZG73+qEKZzNgU8ufyoSFuhbTKum6a7+9yX4Pn4RdwXddgQ0XRvZW/PnKm58UjERNU/39hGtNc1+vW4PeVJBI7IzmmJRA+pAMrTACIqa9K6vfP/Y9/s+R6Ohzjq8fnvW9cjLG+VOt8FX4zkS3qKQlUp12dFu3DZ9UTVdvd+rYzlU47z1rGu2kZvRVOmW6sIfm+as7ogq8PwwgpRW0ZFnXG/KKO9Eq6AV1sXIjSgKbEX50WVWVsYBMsuSM6FYOw7hV6KXF1pgtlOoOreZ1eCosSLrBHmivVzYSExGtPlJ8kDIB4fSkSSxOa2D9KR3+wllw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSyv9KzWw/RI12dwfNpi4y8uBoDZVv0XdyTCW2gY7B4=;
 b=OyLxFIOp64Xo2mvWWsCQUHh4xBnvooG3loq4xGPS84D0p6E6haNqBiYgIm4ZCyFXbSDfVwDsO8O25MGRNDeIm/c+ewvKdwL3ypghOZ/r4EKPqML25zKxqY2jgAPMSBUF7BaGzWthUWFRSekUQ2u7ysXg8Rjl3liZrsFFAJceraY86ti5ruKAAtSgbIJb5F5AUAk+lLHeL0HfSD1Kff63n5iQnj6SMPx3nmru/b+8dYD2P778eEgofUQvdpZiCXO0z2dQRghoXn6tdRD+5TCMbPwXCeh63tYEZFzld5d8TrV/n7YN+SgNwItje9LROwZ2jeboFRsaZYBdBUNcoYLK9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:24:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:24:05 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v6 11/13] spi: airoha: set custom sector size equal to flash page size
Date: Thu,  2 Oct 2025 01:23:44 +0300
Message-ID: <20251001222347.3386506-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3a060a-9320-48a2-20cd-08de01393b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/0I11EGevuvyMEDt6kq64wqjL+vNVgXDfrD6rpPw7F5Slt0eLQPhgasvN933?=
 =?us-ascii?Q?xPkSJU5zAO+lIea/tSgK+kB7LB+4HstOEIeGKdGGrquvTGXMDkywBXMScAZ9?=
 =?us-ascii?Q?UERalIkkrG0jcHz7pv7BdRJtarIvMIqUxzQDxWdH/QU4g5xoeE09yBCR2GrX?=
 =?us-ascii?Q?CvArmGjIy/2mH6IDnhmKx+EBnrPtTYwXRm+6uuZzzkNG7tOUnsD6xfmzbV8C?=
 =?us-ascii?Q?c/GzYRMb7H52yXwixKfwYW2PsWk9xksF9DOOzkkMU1ls/zVWwemmvu2wbgSd?=
 =?us-ascii?Q?6CBoBw4L3B2S/JnlSMFLqe/1zmh8eYt4CK98gxdeDFeijT6b2DAzlrRI877w?=
 =?us-ascii?Q?IhsJbZlZH8QBQazzyxEYZZFGEMSKB+CFVv+MvAtcJg/9Yy0KkEjNyOgMDCWK?=
 =?us-ascii?Q?wjUMUC//+qciniFaf4a1lKLRMFTDZg3ZEYuLyYLpekNmtLYlr4mqX5BZ0YXG?=
 =?us-ascii?Q?4DpmxsseDWEOBQA+KGZv1DCcj+RDTNdGWmdTCaTGLn+saUbZ8d21vQRMAxFM?=
 =?us-ascii?Q?LWyCPVy+sKkOCGuAa+SR7LTUg2weH8cJIaPKgy9oDWUerVexdiqw/qDjf+PB?=
 =?us-ascii?Q?gDXFpybRgYp0eUdrWzgQfXufSfMchoOTUq/iyAMpZf5pODlfvBnbfNrxvgw2?=
 =?us-ascii?Q?OQDssW8crXemNwApiaa4KENeunmsKOWHjEVAaS9ueeDJV28l7cc10/2BNZyO?=
 =?us-ascii?Q?Wt+z+BmfmATJphjtGfxyG6VCubUwO36x/D9sMRsFS5X+iWpXt1kA5BEQ6Rdk?=
 =?us-ascii?Q?zx2Uc3XT69kUKFyiFvgGEuf8flTEIAqn06OT5TXvcLO6x+oaBnwmmVBooi8Q?=
 =?us-ascii?Q?uYoMNC9aR5QPJsl+toPcSQikQQVxmPNoK1PmbpQ6neu3XHTBpQD7AfTki8FQ?=
 =?us-ascii?Q?KSTVGC01R/qtFMbDISUeg+V2vSirbs30WvAb+aBqbqTAy+8P2ImUTdFTRpN1?=
 =?us-ascii?Q?EFWpAlA2j33T8AGJnlcujPOCEI2CpvlFM+OUpBEIyiAuyOrbvaoNANC2dzAV?=
 =?us-ascii?Q?digDnj3FB0TV0sKgv4K/2+Pl36qgUBYOvF8dgqcJGobXC9mTxvn7MUE9Z/gr?=
 =?us-ascii?Q?B1EPT9fGW3y4G0dm3m8U3bw0N8aQMOmqjnpIFocOPBj1thWzFlRE5rtmJaec?=
 =?us-ascii?Q?MN4+SKbsKMxr+hwNFDX/fVVPwAIedIFEbeoHhm5Gt5J0vMjsnZnh98+3LE0w?=
 =?us-ascii?Q?GU3qjI5S6zjfjx0jDM3v/hSD9wYXyVTkkE+YlWZ4lna/mlWao4z+oKgK5I1e?=
 =?us-ascii?Q?Ueno6V0xpDx/tgZgo2ECMm/px3F5HOC17Kz1M/cc4zG/53dhnIZ5gvWYZoy6?=
 =?us-ascii?Q?5jm55FsyB+IyXHi1Bma+K73lyLaYpZ2DZMyKB5ujdwp0R3eCA2aKMNxx3T+5?=
 =?us-ascii?Q?7THcHDTEoFrJ4lQCr7Bo5q34xAAtypOyYrn1sqbvpe+eZgVqLe8YXttIkgqf?=
 =?us-ascii?Q?9iN5FD5MNkaJ96cRnPFgmbxHLR2GdZE3rikDu5cMmKG1o8TFxHc3F6IwqPCx?=
 =?us-ascii?Q?7CwXlvHOQFOiwBVU1fQGXklfKiVdsHH/Pf4T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FU22JyoiUAGBnyO6w1872ZrPghaU0Fyj+NiV2Ms3g6WC3H2TZsVCExRgfJor?=
 =?us-ascii?Q?Rd3odOV3T6O5gG1i9fK7F+35t9Idujm5AturLL1CCE41y5FpzQGO0vfeQkww?=
 =?us-ascii?Q?rH0eY24/S4PSePPHbvOpsfd7F/hNSaw/1bxIHdx26qkN21e808+rUKougUCN?=
 =?us-ascii?Q?BmUhvCRlptXZ8feJMpe2aTW5ipma7/uXwT1cENv69jbWEQtofAmrFy1T06aB?=
 =?us-ascii?Q?YF1WXVDAH0q7W4Bw6gR2xDOIG55TLKupicpu22u6Y7WEK29/L57a02fS8MLp?=
 =?us-ascii?Q?Kqp1QiXIXZC/VEAO3ychpGLHoffQTB8ZzF/20OeRS9Y3x175BD8DbBbXTPbd?=
 =?us-ascii?Q?rVn5VVomVn8QEsEq0p6yQABlRJeJfQUSQyHCBPIlycmqtPN9Ne9fOvoAlUGU?=
 =?us-ascii?Q?p5zHnAELvOpMEo/Mhnrg9QxTVWuQTy8ujKj4dr8yOgMmSjHZiit3z6VxQoYE?=
 =?us-ascii?Q?LHFXvxFPxR0cHCm9eZimp3NvpBSCVuwovUanUbWgcqu/7H0DA/gMEzgv8k7g?=
 =?us-ascii?Q?04A/rnQR3WWycQtXb4yXQlh/tICxndD0+pwmpQVbYDAEaGIiDgpVSzlin1Ud?=
 =?us-ascii?Q?pki6X6Q+aWRdycOzfjdrUtPsjzd+QV5kbw/d6Fa/q7jL8eN0CrSMmvrAZb2/?=
 =?us-ascii?Q?I8YJ7Da4wizubf43XSyXayttghtGJ/3htU/CR8/wPsxJThkRWuYfVzkZit2G?=
 =?us-ascii?Q?Mcm0DW/p1YaWkW6SZssBXNOj+ctAoFE08Ti46cfacl77cGXEEOg3AurISoL6?=
 =?us-ascii?Q?1qhNw5hFv054elQ20y8qmCENydV1EM70+0sp70AlTlfeD+EXehzkYCiTB5Q9?=
 =?us-ascii?Q?wB3K5dl18+dKOQGerXQyyQNc+gQQh+VTMr0jNVlZrYbDYcJg2K41AACfX41U?=
 =?us-ascii?Q?4i3p77GPIUY8fxVAoCV6KdJwCLmDF3C3oEorwL5LLjYNvqWSGBUEyYQ4/+LE?=
 =?us-ascii?Q?CYNiJgPsL+wAgWaqPfBm2OeA3UlY3N0mGm52hTR7LgWwcpPR0OwnXtQBgz2D?=
 =?us-ascii?Q?PzC3bdNx35SfpEe8BORN0dgwIqgCcDPU/Yte3JTKCgftqx+NQksmvInVdsFw?=
 =?us-ascii?Q?SvW+86EoNPayldFwkkp2PiXeyTvv9CtJTbHwPK3cGeVVY0e65Kl/Mh5MP6uB?=
 =?us-ascii?Q?xAS/Q/ooIgsCDNMiPEZxIq5Az/7AQhVnnMiSSgdDqO/hHNlwD87sZv/j265R?=
 =?us-ascii?Q?drATOOYkkDY5MhhhLVkT1wvruByW+YAu9KTZv0z8gmx2dZtWiIe5MR1hVKSA?=
 =?us-ascii?Q?jCSjndHotK2S4Fmyxlz5DIcGsegfMt18xEGjM6P5HM80dg4aqlANAWsf+LxF?=
 =?us-ascii?Q?bhil/4tToWxLNBBO1Lo5lyOlsNhPU7PvPelGOrJ7te/+jKMx7XN4wCDytTCA?=
 =?us-ascii?Q?srkXQIx45e3JxyKJCDavl3Jsj6+732waOF4Rf9AN4jaybplZTcbI9Qw3gfWc?=
 =?us-ascii?Q?daR9rSbGT7u0zk2MUuIxb+L9j9LaJwzmMgcKdvWBq8BoVYLVFb1CGa6Wg0V5?=
 =?us-ascii?Q?CCF/wUBaxdTvPk2ejst42nLrNgKeIq8JCD6VTUK9jzJZEVDKBNtJenzeIw4X?=
 =?us-ascii?Q?WFcNy6M3hI+1GAeADf57frE6zkyI+KE5Vok/wOPEKB5otIu/WhlCCWGO7Wmf?=
 =?us-ascii?Q?ybFDLMIadLQwLP59bXafYKs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3a060a-9320-48a2-20cd-08de01393b62
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:24:05.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xu78SVMfFWEXH68GVblyvi+C4MuKIB/feLZOoIzugYM/dsK5N9LOgvcKh2lGHyO6M3AkPgV5oTiVv6SD0t+fGe0uY7Fe0OZLgs+SCkUVIO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

Set custom sector size equal to flash page size including oob. Thus we
will always read a single sector. The maximum custom sector size is
8187, so all possible flash sector sizes are supported.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 3fb76e2dd5e3..babf7b958dc3 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -519,7 +519,7 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				 SPI_NFI_SEC_NUM, val);
 	if (err)
@@ -532,7 +532,8 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, as_ctrl->nfi_cfg.sec_size);
+	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
+			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
 	return regmap_update_bits(as_ctrl->regmap_nfi,
 				  REG_SPI_NFI_SECCUS_SIZE,
 				  SPI_NFI_CUS_SEC_SIZE, val);
@@ -635,10 +636,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
 	u32 val, rd_mode, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
 	 * replace them with supported opcodes.
@@ -697,18 +701,17 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be read */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -733,11 +736,10 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_READ_DATA_BYTE_NUM, val);
+				 SPI_NFI_READ_DATA_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
@@ -826,10 +828,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	struct airoha_snand_ctrl *as_ctrl;
 	dma_addr_t dma_addr;
 	u32 wr_mode, val, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
@@ -880,18 +885,17 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be written */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -916,11 +920,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
+				 SPI_NFI_PROG_LOAD_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0


