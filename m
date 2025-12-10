Return-Path: <linux-spi+bounces-11839-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 682DCCB2502
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 08:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B01D93048DB7
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 07:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F6F280329;
	Wed, 10 Dec 2025 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LybaGphQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59220102B;
	Wed, 10 Dec 2025 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765352513; cv=fail; b=uUICfVhR/W7o3JC+JPH8s/aTTnlCqYNceZuJNfWDtvmICeKvpozN28b31EkP6CqBghd9yUM60fLqBCZStR6OptLI6GunRI4cemlHFy9kDkoYgmAM+hxSpy9wqPBPn2op99prApSEL9kanBIZBvsSXFmvzk9xlco+vq2rXX1cjWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765352513; c=relaxed/simple;
	bh=Njx9BHlHzeZh3+wOW+D9tBaw0FQfJ+Apir4U3ULCrkk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kgd6jabJvJlc78cG5bK530kVwImlH+YD+ssWzNOMJOXho11y3ijhdWx9cZK55OZQrarIZF0R/7T/bl2kzkFJL8d2g0HhENtvNscXbL+JAgsYqsR9GfOi2JBldwI38jp+J/88vS2carisMnyJuuXdFNl3Pg/vaw6Mwo7aILPNGJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LybaGphQ; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/VRFzfOus3b+qju5gXWG12ZIU9UvqPBvPwo73e1D/3fb+fbBjXnckExupkFFDAHV2eQkMhnUfPV1pfUPjlHxkwxapK6JDSbILK3SV1Ovf7qRwfJuqw/98ctsCqmzXxXBlAbOKwgFfwqg/pZe7GV4+ExrCOEp0EJeUNc17FgJJcscDGwEiIAH9Tlh4/9UO8GvvUwRN4/DYQl3SnqQzD3abGXSsznTxBGmg9R0geUDyvphaFU9nqPMPbyPbjWRzdlfV3vT7queCArXDC58CPONOJiqMcOwElbK+TRhNMH9lixdo1wsU7UDVfVoEBh46PcCR8lJNHQ+TjmNBzbcc4Vsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbYVE7a+Xb5zzlg1sefkphUJZxhAp41QSDjl0T6X3Bc=;
 b=CArJvlUk4h53fRZBp1z5uGLSHsGLtNZYh6GOFAw/bt1cKbmMHDu2Z1NuZ3Ue/qDC2FhSmlwhy9gxa/5dGsaTCvLB7xRgEdOe7JtiEc0PHZVLubwXdaZjHKF02K/E7o6tMDouq0Fyc4pNov+qaYfvsPFQCRA4X/qHHltjw+DOLyLrE8K1Z5Hr/6TIfq/wdYknKLBUU5ASz4DAB7s/cHUTwzGn3jxM5f/WJ0jGGxC4Y5HWkGNc00GHY8dkTI9lxCtkYkmPjUVmFpFnuIGS0RJAsx9eVcRbSDBQ4iTaQsjJazbZzcE6LkQNohCtw2wmmlop3aIzkOfx0oh/U65ZCGhcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbYVE7a+Xb5zzlg1sefkphUJZxhAp41QSDjl0T6X3Bc=;
 b=LybaGphQAyF3LMR/evEpJMlAWMz7xKGnPTPziJGzQJCCImOBg2lIrOh15jHC22Dk8SoO1covGMh566snJuiu4FgEaQLg+Pjh2y53bVgjzvL2rlRtNR+5aO6k+/VhD2ECAkGYTwz8rXaGB1sTjn3eCNT7gCL5jlcDHSOVEOlthKm+aJEgorioxtKV+gmv44XlejVkt5702+1N7w1KO02FfgtDFXA/ge9P1/2v6ICtgH/FHKeJRkaz3dvHDXJEbXCS8fUm/C+Sec5BXa3CXFpnRF6goRll24lfMZz/hrNMcsoOs9q865NpUth7qB3lZFA0/dM3UUhFDZd9yyBevaKyIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by DU4PR04MB11032.eurprd04.prod.outlook.com
 (2603:10a6:10:58a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 07:41:45 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:41:45 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank.Li@nxp.com,
	broonie@kernel.org,
	daniel.baluta@nxp.com,
	carlos.song@nxp.com,
	david.laight@runbox.com,
	andriy.shevchenko@intel.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: spi-fsl-lpspi: convert min_t() to simple min()
Date: Wed, 10 Dec 2025 15:41:15 +0800
Message-Id: <20251210074115.3883180-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::35) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|DU4PR04MB11032:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ffb30d5-c871-4ccd-08d5-08de37bf9175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OGZ2BuUMfclvkK1tqS6QYQl9FVsIKN+jcS+HwkPgimbQBXa0N1vq1b6XbcTJ?=
 =?us-ascii?Q?Dl0EQq0rkudMkMkTgYgu1/Bz/8wmAasWftC4rTBpRX47eSbkj4JuDjCs1psS?=
 =?us-ascii?Q?N1P7Ly6fpjbhaXUS1gImLuiuCr0rg6o2E5gF3YnNzLcH+OkB6u05CAmn20kn?=
 =?us-ascii?Q?fAguFzVeMEz03QZOMDvK2ttnj5AKMjmQYo8MFrKTRYI98SiFpU94mcyBA7jx?=
 =?us-ascii?Q?PJpGk/l+Dl/rsYsPoz8GEg9NpTw+d+5T1w7xzdSyjDxeSYxtniEuygk5ddsH?=
 =?us-ascii?Q?MlEhntH3SwapYTH4+sfMsXuUdr8cX9F5QnKVxJbeHlwAj5k99iE9hEhhz9mR?=
 =?us-ascii?Q?Cp/EK2APuHXiLQpYIGeTQUSZ7k2eDBnZjMugSK3At2kamHjYRlYQpkgk/nsi?=
 =?us-ascii?Q?Tg22FP1GStuDal3hKQkFgNM1WS4tyMigr/cmQUS9gNGOR5mdiSqklE0EH6ww?=
 =?us-ascii?Q?SBuTah8r8Mm5ESK6b3Vrb/t9x4smC1dlIk3pGxj+JxHgZKwuCtsyRNQStUaY?=
 =?us-ascii?Q?AQ540AeRkGH8OruL8s3tvNxXD4CyB9guyljuu/jo+6Ow60mtWU4R3nCqt+HW?=
 =?us-ascii?Q?Rr8i1+YGH/TZFCJjsn+LvnyR71M/UVKiGOKt/4eFllnT0qr6OlAdi31UVuoV?=
 =?us-ascii?Q?xwvBuU6xbgX7/wDniLeAuIAEJt5slsC1e1YJ49dfgvR7ZN+hIVcgE21yWQSf?=
 =?us-ascii?Q?iNlOTcjipmAYeDpDL9SNDICWs4MeinZmFcve3At8m/XJkNiM88f9JOSDlPvN?=
 =?us-ascii?Q?9UZXsBGg3KYMX26e3UJNgbyH7aqQhtjiYEClRtogjQ49/Tqufbm/Tojobapu?=
 =?us-ascii?Q?3lMyCs9oUljUa1GattEzAEPhMp6900InNSd5m8TpjWHXjDTS6pIzmaeYJLt+?=
 =?us-ascii?Q?aXjrBSCkmS7+70wRhnGLsWQmzIrUJey5OsX64cfJwpHW382S2a4Hx6Q8AtWk?=
 =?us-ascii?Q?4N9x4hym/E0IjjDCYiNCVN1XWUCm+4jOYjthuMcY6AszjIqgOF8oaPxOoVgL?=
 =?us-ascii?Q?pavAYhpoVdEwTfI9QBwliCkH3NqOYD0I3jcefGEHA9fmFKOnRGW4+8TxmxHg?=
 =?us-ascii?Q?dAQUBtI7j8ixyj0l2FLtbwKAtwzH/zVdL7xBQ5qB/baIt9H+TQfiraR97bGv?=
 =?us-ascii?Q?uq4EwxLr+uScSIQlXCsqpl8NcvBJvdeDrbheUzTUrAf3uf1dN5FhoyCSPplB?=
 =?us-ascii?Q?swG1OVYPacY0y+Y4fcbr+6/CiKv/JIqr+65VarnH+c9GHPcf4M7LujZf4AcQ?=
 =?us-ascii?Q?Xr5M3LdqjrJIhbPzwPriV68f0hSvY0nCAg0FpI8qH/1B3hEPtz3DYlU+IE+e?=
 =?us-ascii?Q?1asvgrwbLGei+yl5+jGp7bC/ZkCVVolbG4bwqEmt6jSJYJ9mR+ODaw91+O8Q?=
 =?us-ascii?Q?U32LBDRvGNqG13dmRTIDM9ROj38x7V88IjX08smC/oxl7vi6/AQe5bHtt9/l?=
 =?us-ascii?Q?KtPUwZqCTuTL4lOBLRTuxAC11UnuIkndhh0swXYC2jCTriftM6q1Z4lvBghj?=
 =?us-ascii?Q?AdQ34nkVFKfsWavwZyISuAHPbfJHW2rxBOIs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O1mCciFW4Eo6m+ONs8kSmqHrUqQ0b2ZBKPaalHeHTx2PIzY5TzRw35vZJTk1?=
 =?us-ascii?Q?AnMEZe+FRzDlDJrY83Q5quki+e0jfROaDDBBzYuSLcZcnNpP2iwWo+ZREpNr?=
 =?us-ascii?Q?mGacRLMWtwHcQdxkAWn1cIi2CQffVXMd5D+lmIe8owpwINC9tkq4vcFEUVV8?=
 =?us-ascii?Q?VH2JbEJaUCIBBbSkdPLReLmwo+y/JEmBoHo7/sMOKdBykfNP8GLf2g69bPFa?=
 =?us-ascii?Q?FVH2D9e3OQ8B9/PMGLDKi6Hyqeq+BQ/OkbEkFo5S2doyIdTnAx5vxoU6yYDz?=
 =?us-ascii?Q?dmi+rHnH+kL8uNbxvyPUIgAf3d4pJA+SBoaA4c8QYbVByjQzngXbY20EtEuE?=
 =?us-ascii?Q?iV8UHl9aAZpABZ0kdgTBUTXQuaI1zcx9jWjqL927zn8V1d0kNlu6XBH06Mo4?=
 =?us-ascii?Q?KBf1oNYLAqJLv3X7lE2/O4eydmUImVjvHG9KFkSWo3ASLmyN6epbb0OY5FcJ?=
 =?us-ascii?Q?kLNMUNEEzaxQnK+cml8wBamWhM/UHizP17CH5mVGO6oAS40vzl/LKfwyzVQY?=
 =?us-ascii?Q?aRdmWrSZ8hup09N5Z6a9/tzVzee8tcllzpreD8bdBhHAAAfI8i6mfWEOclHm?=
 =?us-ascii?Q?E71ps6OOfCG/lWrmhgZ2fu16ZLWFWU3r1CPGqmJV6tIr9tUFPsii7TuhO1PW?=
 =?us-ascii?Q?0IXq7Z2wJCqzFlsaQC1os5jMNrKWvDIqO6anlmDn61VK1FezFly+iP0TIVR2?=
 =?us-ascii?Q?b4wDlMwcQHYIQvOJpr2Pt85+nCC/gD3+96NivihnAsj+YiSPpKA6WgshN9l1?=
 =?us-ascii?Q?gs5ORXauZ7dR+cKwhJkgwKS/Ogrqufeat39Xb0sw9O+pf/WE3hDosVTa4qb9?=
 =?us-ascii?Q?MuK2zRwfxk4/q9cL0tab54Zz4J8WjnAbJ9vCGhSrrinAj/8cImva9ROH2G8r?=
 =?us-ascii?Q?i+HmKy9aEPwDn6HB9q3a5n+5rNxscryRo5pbt/sDaS4L6yEKc5CNcnBjv58l?=
 =?us-ascii?Q?1ZALT/lVMgb9iAue87gxIL/sIUNLACxK/WT/ApkVMG36OodrJf7o3Q8M07JD?=
 =?us-ascii?Q?skrSTb7lIhzvFeQo8WfgXFADoZrLyW00M6y8zOo/DE35cZwA3t/Tps1UvSOX?=
 =?us-ascii?Q?A0om+i0oYpjAYbLdmAYc2bKuxVTHfoqey6mKahCyM0h4xFqeiTPUpS8y/pGL?=
 =?us-ascii?Q?PXcKBd+mGUGaqmG0p3CS0YsUhg2H3Qa9Sb4axQmQq2+b1mT3Zp4DzIrQGk7+?=
 =?us-ascii?Q?hHQEmAClUR24L/q2ol+kxpqJCgBjJTY5J7EWwTD3Utp5Rc9TXiFbrS2hOlN+?=
 =?us-ascii?Q?ztpBHEhgJsev6t4eIFoMQ1UVuqcJDfNBnPJs/M9+KWWJm3tETwLi2vN7FhyB?=
 =?us-ascii?Q?jL3J/NxCSOBCAb09BX1jAGe9M0uXk2gZOeRajwslWYO8tvoHrwwCmmQizpzP?=
 =?us-ascii?Q?SnJCFS7eUmlR5EYEmVvkKfezJ9wNFgyrM4Egf3N2x5fM3kE89jW8ojPeexBY?=
 =?us-ascii?Q?ka8tHqU8E3zR1lNNUcGiHTDdpRH0FXMZ6B6IeJ5k9tQGaGSK5N/hdFuu2kCI?=
 =?us-ascii?Q?yPUOSG5Y84nLCAURJ27buuyh6P1QtarZlqZklwJb7aEEMt0nj2CyIyEqEbTE?=
 =?us-ascii?Q?t4V9MU8vxMS7q4D02Oecz0pWKBQ8fzgFRl+LJm4H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffb30d5-c871-4ccd-08d5-08de37bf9175
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:41:45.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0kIECx5hAaLDnrN3y42FJjfRjk/YEsFkTHSGUa+EmfMVlUjFhB+jpm1DSvAz6yTJ4x1ccDmtfQ5JwV3LlFa/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11032

Current min() has supported comparison by normal integer promotion rules,
so explicit type casts or min_t() are not needed.

Fixes: 9f0c21bac5a8 ("spi: spi-fsl-lpspi: fix watermark truncation caused by type cast")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change since v1:
* remove unused comment according to David's comment
* improve commit log according to Frank's comment
---
 drivers/spi/spi-fsl-lpspi.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 065456aba2ae..8f45ead23836 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -486,15 +486,7 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 		fsl_lpspi->tx = fsl_lpspi_buf_tx_u32;
 	}
 
-	/*
-	 * t->len is 'unsigned' and txfifosize and watermrk is 'u8', force
-	 * type cast is inevitable. When len > 255, len will be truncated in min_t(),
-	 * it caused wrong watermark set. 'unsigned int' is as the designated type
-	 * for min_t() to avoid truncation.
-	 */
-	fsl_lpspi->watermark = min_t(unsigned int,
-				     fsl_lpspi->txfifosize,
-				     t->len);
+	fsl_lpspi->watermark = min(fsl_lpspi->txfifosize, t->len);
 
 	if (fsl_lpspi_can_dma(controller, spi, t))
 		fsl_lpspi->usedma = true;
-- 
2.34.1


