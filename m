Return-Path: <linux-spi+bounces-10812-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE508C046CA
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 07:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8931A65A8D
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 05:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E6D2248A5;
	Fri, 24 Oct 2025 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FopAQrjR"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6B26AEC;
	Fri, 24 Oct 2025 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761285155; cv=fail; b=k7A+1P/WqlGCT1UXKciyc9tTUt2Sk9v0A762ywjwSNU9Gsw/vkD7fDErjVaZxEGDqjeh00QuVJr+WL+NBcWdynWs2pXvsevesdwTsuQ1GH+4iqS0ksgJEbtOqVCD6BAKNxdwdcnxUeNN3limivLBuANgD3X+X4t4WCtYG7ADNNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761285155; c=relaxed/simple;
	bh=1X7Ta3c6+58Jjjxk4ccGvuAGflOsUaIIWzLc54dJYfc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iWY5fK0qA+ZEjersqaHoftbXNVZVE5iboW7QMLNvB/0zCYvXfA/P35fJzsX21tGqDiyr0S7zZ0SvyBRGkIchGsIkfK8rkh6FDo4BkRE3EsuA1rO5kvQee3l0YUrgIjOZJAZwfkbtkDDzvQigXvQ6PD0Gi5i8myAMfwRtV28UDpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FopAQrjR; arc=fail smtp.client-ip=52.101.66.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAyLkHb5LoYQRDRlOP+NGV86Qb52VpxBBFkNf0EZcm+HoYnaY/oFKABHqERucObCyfK1U64Zu8rHrJ9fS8+b/JbDeoYocSwszKIE/o1X7XK75cJpKCKTbCDEHdRXZy5gZRrpru5XiDiZP0ZwOABzKKJLEfkOVUCUr7gC2M3piUEyR5qHWMQra74c411AxV/J1P51JhxwGS+c7FRl+n7A046kqB/hPBWlhOoQblyjL0CItAD85AIohqUJN1areZNzXlC1BqJoEXMaCI4KOdPoRnS0qTJ5+3/lTClotj8uHG1edRpHIpLM9tghlrE2MaSnbaAFV6sH1In8MOVDZ+BQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG3fe6FVUjnCiR+rJW6w86oh/74x4zj+WNbq98QPkaQ=;
 b=dNckdkHVjNoNc8Ikgt+ULINtVNL+6/yRibqGeinimnSu+POZwS8+jpcdj0//BMB19AjccyDjMs8bdsdBxN0w0wRtzbPs1Tfo3brkT0TsBfT2zjQ9HYskwjQJgnv8daYofKz360gQRODCm4OH71wz4RfLjO879sjE0iE33tWM46xnR77zEhLRwNU3UibSPgg6V0ma7YTY+OqKfj15T9xJUwyZlZza2boKIUTzcwGY1/mNL8tii0DYZZrgcMJ0c0HgJplXS+8VeSn31c6aZyzx5ygBuURHC1zAFq2gaAEsMRFRvEW2ub8abvUQRt0Uyqu7vVKXgueP33QfZCWmIzsYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG3fe6FVUjnCiR+rJW6w86oh/74x4zj+WNbq98QPkaQ=;
 b=FopAQrjR/6DHL3mWMKzn/prdcioGuaNfhtTArPMkQCQEVMZrlBSO/8SnbE62wGFzMmRZehGR/7dXYPtWVvO4x/CzaGITfnYzcuKR/HpklHY95HcbScF4ZbDAwZZqSW69liVQKMPNzAhKxK0Wph9/UB7vFpjxRosFUEMP9aaL/6F0M8GbnEG64ODe0s3XfK6mpeyQW0iIuN0IIO+rEDxqeatnNC95Qc0eJ8+ueM/c7kv4q94rNqZMPLWo0CZrafj+A+WfwPvHzo71JBZC3JEp9mrpyJOyOKjiFqVQEm4kYHM2hEdxYUpZrlhl9G82Ep3E7clYtA/XV3QdDtEWjSPu7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA2PR04MB10123.eurprd04.prod.outlook.com
 (2603:10a6:102:403::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 05:52:29 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 05:52:29 +0000
From: carlos.song@nxp.com
To: frank.li@nxp.com,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: imx: remove CLK calculation and check for target mode
Date: Fri, 24 Oct 2025 13:52:11 +0800
Message-Id: <20251024055211.408440-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::9) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|PA2PR04MB10123:EE_
X-MS-Office365-Filtering-Correlation-Id: fef30e71-1f5d-44ba-b22a-08de12c18464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sAr91ocGHG3WLk0jrDp0Dx6XRl2f2taKp+Gqh0knLEBh927nsjsmlnLfWBQM?=
 =?us-ascii?Q?3VmZEdcB7IXPCeAvmRMOm150AxG1/p6Pl1bgtXj3ttK2jKlHx3kasY3SirRV?=
 =?us-ascii?Q?M3CPM55T/QzVlfdb1QTnEdbtFCFSCwvY0T+ZWoAcMrVRMTbONMlGu4If4YZE?=
 =?us-ascii?Q?FUlL2uRKaCTdx6pgGluIGVqkRNFq6PKAuZ61joIF21cKl9VCryuBw5HCdm8y?=
 =?us-ascii?Q?EgggfnPDBORgOK2bd/6eggqJ+8O7lb6rd3LVDZcqCY1J/AcrmChaxhR2Lt0R?=
 =?us-ascii?Q?/GHpU96BBi4t4EywjEOO50Pb7U4lp51I6lTlpIDPQwekCMTmZVoz7T1idlU2?=
 =?us-ascii?Q?CyXmHeAy3vn9XW/GTL+3Gy9N5tTXvf5XPRTq265/5peXkbq8rnSbEh40q8hh?=
 =?us-ascii?Q?FVGKBUfEc6HB6V67KV4fZN6dzezC8D2zMLFViBpufgQVuTkQLMuZatX68u+s?=
 =?us-ascii?Q?OCFBEeyTp7GfTQ3FqB5RbDI+SnPIUWdszp3yV3VA30Nf1rgKFN1kLkRNOkir?=
 =?us-ascii?Q?v0GtRzkuTw+bCgF8gh4Fiv78ObngwsrjB1gTS+ErRrmOS39OlRI5tAxz/jJ8?=
 =?us-ascii?Q?U+6x3blq0zS87tzGlOA+2oXvuGZ09CDXR/0WsPzP5G35ZRtXZhUKEx+UgIZr?=
 =?us-ascii?Q?62kUjN3Al2EPuc5FAvbpt9pp+TANyn1iKjVSlLsIur/kZdaWsFUkTh/SQ//o?=
 =?us-ascii?Q?Do1JMiHnx95AEmu+mU9wI3NYCy3L6OrMZDn2U9bCJLc/t3kSvam7ztvBEjzf?=
 =?us-ascii?Q?Bj79Yd65bx+joQl3MEXMPqz4vRcXBA4C9uFp0RhRj35qNHb0U5VepWw2mbKK?=
 =?us-ascii?Q?TK34s2lLy4w1g1z+dqEgHHreWLszJbW29LV7xN/nfO3/wiVuPn9ri3JBu1Gv?=
 =?us-ascii?Q?PBW7dcNmlUy3uKgdBRQjjLNqNX/5V2ZfWAN9JPTnnyz7uL9dooSXCAN4Rqut?=
 =?us-ascii?Q?wy+N9awSQUOrNhDrVE6a2tJqmyEOlVgQc1+U2kC7wxl3GqkiUVqJt4KBQSvd?=
 =?us-ascii?Q?yrj/XRtK0wWNY+63dzrpPgOw3JueDJmVaskIFNdbZdwReXzZnIcQNA/OT9aK?=
 =?us-ascii?Q?iYF9QlkkN1q35e2GzLPS8uC6DL9BBVwTqKPYiXg7M2H+XYT2udUPOjWtjwkz?=
 =?us-ascii?Q?DioRPFRBH7pU7ajeXW1QwqzQgrJBAVHsxjXh1pC0TmmcAYjtlt470SeE1aQB?=
 =?us-ascii?Q?35cTTouJcd10ycFnyQySx1YnyNqKIK8CII7a17r813TIgpLkg7U1D3lxocYj?=
 =?us-ascii?Q?tOEcK3vYk5sYndq2mXogCuILzGOKYHiaoN5zWWt0dkOVe2hLgoQJ7Gj8T2Uh?=
 =?us-ascii?Q?UMXioi1aojNqlX4N9xMhDJ8ch05xuuHQ1iL5fSgSW+nSoIBPHwqcFc/9VlXP?=
 =?us-ascii?Q?vyNxmAkkzVrnzDWGR+Xg0+wKvHuA03TVO7a1Lm8K2P1723M6SmcW0pexBA5p?=
 =?us-ascii?Q?skOD5Hbn9NpmAYzg6zA59Sz99Crie24T2KFXwAc58zdEPf8yD0MiOvmW7ztT?=
 =?us-ascii?Q?UPtZfzpsM8IyOVMW+XuGRjAAjgPoDQ5Rm1MK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ztt+mzkT440JYV5ftoy1pkJkdAUgcPdL8tLAgQd8Lax9Ytriu/Sta5rAT3Cp?=
 =?us-ascii?Q?6daczmfeBUSUSUr0qGll1ygrc/6QGm5AgYSwd1h/oxR+l9/OzcHnEbNOf51I?=
 =?us-ascii?Q?IHxfHzhqVUXVhDLERSEcCHX/mD77FiiQkdIaRjj/mQO9r7kMUWe4RWcy43pa?=
 =?us-ascii?Q?h46OhLqZMHa0SqELX3VpQO3cSU+EvDFlUivbEAiMxy/M8r03pv6PTv34uO4g?=
 =?us-ascii?Q?7H7Piad/CXeZWx+FfVHSXNSGiTEsAa1HUCq2/ePIzc2ogLAGps2/B8I3UKZw?=
 =?us-ascii?Q?EJNGt/DhY2WPIfks4R2R8yRbV3LPl+uzLts9mayvJSDTk/fz+yHREIlRVb9d?=
 =?us-ascii?Q?mA9OCxDbvyjZbbxACi7YD+c4Rkxtl0V66B6RHC5UvLV9EKnx7sWgKR6hq8q1?=
 =?us-ascii?Q?9AvBWxAXXdCi5x2QEQqDe5jP7qMQkOlX6IKJblv5qcTdlioRsV/+EMGkKaJK?=
 =?us-ascii?Q?F4Whc0wewBMCmAf8V9kopv5oNrUDJJQWnDRBM/lrdKNOkNcJ0Zjcr6khHJr2?=
 =?us-ascii?Q?cGws8jylghx6y5sxG+UwPwSPmB2tHFrhGLDpUmkUkbZwvRPbcyxufan7W5cW?=
 =?us-ascii?Q?Bu0w93EA60tcRRTFesgB5hkjR/o2XY2vZlyJtdDRWh2NtXmCP6nUnONspc8K?=
 =?us-ascii?Q?WXsqVFkcGFgtsIVv+brVswD03wf4t6Wwe5UifW9whrrlvSdtXO9iuSX3Ck1D?=
 =?us-ascii?Q?Z5zPZ+jCgbBLVpufOhPXbjKTU8WCsPLT3sWupLnbxPSewf+rmtLHX4cR67js?=
 =?us-ascii?Q?8ZBzWUTFCnejLS1BipTt+WLdaJLHGTL6qaKZNe6LBn0/HMSvDCR98eKpfHY4?=
 =?us-ascii?Q?e2TK9TOSQKEFpYU6p4G/e+pr5O6rL+XLBLFd0neQZC9hyt7SV08/pYrWT1Az?=
 =?us-ascii?Q?5OKeWWrCHXNff9QstLUK1a/Y7677xXXT07iefn7WCpdAeGgq7d32uzWoqiry?=
 =?us-ascii?Q?OqConxjoUsAT24ZP/MwGILMTThJJ8PgJaG42bK7fCIsw7hHnCLWuLCuWLVmm?=
 =?us-ascii?Q?GIx/DzrcFd3l0dP1neu9Fteoer9sKTqaPF22bGiLDhzXiKx+Tthh6zpEbIIa?=
 =?us-ascii?Q?ZDqA/MV8NOxlLsqWM1UlpaneZ8XdTyEN0FQ5biQ/V5hgexSaM52NCKtAhowR?=
 =?us-ascii?Q?nZEVOArQtRUb8pjhdx/Kb+iQlHynBOprWcib53LjwKAFkqQ/3CIc4rcgxjXf?=
 =?us-ascii?Q?BJvAH6zKJRAiNv36kBp8zVPxxo+i5sL1ZQHWA1oQV0UOn51ZdKXA+5VsMKD2?=
 =?us-ascii?Q?o0YgBlhuMSUd+eediRHsJgm34HQhvyqV84gRdhkN+Yaek3GysXxHlUGYjwnZ?=
 =?us-ascii?Q?wFYcDihh4NcuTMDN9cRGdOwrkT/ZiHsOv+5hG52zJoct7aMGMHHxkr/ZarIy?=
 =?us-ascii?Q?ZihiMFlfufjNdG8xBh4MsnicN5r5u1cDHRdUTSYbFoNUcDakty9XnDhS0HNw?=
 =?us-ascii?Q?0YcJnZyYKveWW+oN+oLITxt8x1SEr8LETYPwcuWbBzcTmplRZxTfMfKIw2MJ?=
 =?us-ascii?Q?dGPH4aCHVbTI6WZaEym1VG2L/Ar1314O3oK8UYm1CXnjoDah5GEU0wh55le2?=
 =?us-ascii?Q?AUjUZubgAQk7VdY9/BXn7EuZ30tOBMbfbLmkC6G+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef30e71-1f5d-44ba-b22a-08de12c18464
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 05:52:29.6582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjPWHdLLj/G/5+ICX+nsFbXGLVnA3kVrEQ4aTYxFeUOBwkRWccTPjd/sw3HJfk7sB/oTK2hBb72f+QPvsPp2Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10123

From: Clark Wang <xiaoning.wang@nxp.com>

In target mode, the clock signal is controlled by the master. Target does
not need to check, calculate and configure the clock frequency division.
The target can directly use the root clock to sample the SCL signal.

Therefore, remove check, calculation and frequency division function of
the clock for target mode.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-imx.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4ffee6c5d5c4..6eb4bfb7be4a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -42,6 +42,7 @@ MODULE_PARM_DESC(polling_limit_us,
 		 "time in us to run a transfer in polling mode\n");
 
 #define MXC_RPM_TIMEOUT		2000 /* 2000ms */
+#define MXC_SPI_DEFAULT_SPEED	500000 /* 500KHz */
 
 #define MXC_CSPIRXDATA		0x00
 #define MXC_CSPITXDATA		0x04
@@ -692,8 +693,11 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	/* set clock speed */
 	ctrl &= ~(0xf << MX51_ECSPI_CTRL_POSTDIV_OFFSET |
 		  0xf << MX51_ECSPI_CTRL_PREDIV_OFFSET);
-	ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
-	spi_imx->spi_bus_clk = clk;
+
+	if (!spi_imx->target_mode) {
+		ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
+		spi_imx->spi_bus_clk = clk;
+	}
 
 	mx51_configure_cpha(spi_imx, spi);
 
@@ -1316,15 +1320,18 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	if (!t)
 		return 0;
 
-	if (!t->speed_hz) {
-		if (!spi->max_speed_hz) {
-			dev_err(&spi->dev, "no speed_hz provided!\n");
-			return -EINVAL;
+	if (!spi_imx->target_mode) {
+		if (!t->speed_hz) {
+			if (!spi->max_speed_hz) {
+				dev_err(&spi->dev, "no speed_hz provided!\n");
+				return -EINVAL;
+			}
+			dev_dbg(&spi->dev, "using spi->max_speed_hz!\n");
+			spi_imx->spi_bus_clk = spi->max_speed_hz;
+		} else {
+			spi_imx->spi_bus_clk = t->speed_hz;
 		}
-		dev_dbg(&spi->dev, "using spi->max_speed_hz!\n");
-		spi_imx->spi_bus_clk = spi->max_speed_hz;
-	} else
-		spi_imx->spi_bus_clk = t->speed_hz;
+	}
 
 	spi_imx->bits_per_word = t->bits_per_word;
 	spi_imx->count = t->len;
@@ -1839,6 +1846,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	controller->prepare_message = spi_imx_prepare_message;
 	controller->unprepare_message = spi_imx_unprepare_message;
 	controller->target_abort = spi_imx_target_abort;
+	spi_imx->spi_bus_clk = MXC_SPI_DEFAULT_SPEED;
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS |
 				SPI_MOSI_IDLE_LOW;
 
-- 
2.34.1


