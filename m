Return-Path: <linux-spi+bounces-4396-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72689638D8
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 05:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0AE2B22780
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 03:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506CD200CB;
	Thu, 29 Aug 2024 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OGOKVC7t"
X-Original-To: linux-spi@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2059.outbound.protection.outlook.com [40.107.117.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929772A1B2;
	Thu, 29 Aug 2024 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902534; cv=fail; b=akYQGlOaun7Ez/JYqF+wxpB/Z/IJCOD48WnNiaP9sxlgJ+2JWfNfTFDqYHr0QLY+QbRqMr3GiNrBU471rSff4EZjdBwuWBcuee/wtbQ4tzyPFJxgkEKrKMUX580CIjIrBMXpLnTNYMX8/cI4xQQa0Y4kyXAXIdG8ckpr1cb1Xv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902534; c=relaxed/simple;
	bh=080rwU9unoniJaEVtofES/2o+THi3FeqYD3q2Z9Sepw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TnO7HPe4ENxcmQEweOZCmePDgtv04tiI3hKskZbj+e4xcIqKMm6TEdBtWWlMJMv0/UhypQCtX8ilc9J/5/YNUW80VohraTeZmTj0+Skeqc1ph5VJD1E3T4zZmoVHpL/bgGqMLa/lEU8GQ0sDsscl8PQJZNw2ONzfC5p4yPKKQNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OGOKVC7t; arc=fail smtp.client-ip=40.107.117.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eePDTnN8FcmdMiT0/K8pQMeq8FpHiWICIz6KOdk8qAPHF3n131O7WW7P0OeYOU86GMfARV5DSQLUR5OQsFHz5Nj2AG//yZwkdyd4SiAgmlvHYtqLumZlIiespR7wyEz/EKwdjv8BiznZXDUuVAGIeHy9d9iPQPqWERZz2SLGAJmsw3q98iW03ZFu3L7jgaYFiMhSKxhx0ToGF+CoInD/drMOMzgY4jNASNXHPHjGPYoHJPiDQCQ1d5y62ii4fgISi6T4rrJ8dC3UjM+B4wFrpIjHHCnEa8KFw48TKNA70w+7cVz8A9RzQfhBS+3B/HZG2O/ddLd/Rkp6QJNlZ3AiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+SJyvgGmlr4LJzqSB80oelghqemjzOEvj8gkZqPhpY=;
 b=x6t9y/cmNoJjF5qBs18FVByJu/pvMe7bHN1FOkc5gQ4cKNqYUpnEiZ9qw82pVr8/KPuDePpZc+yl5GCwiUj/Q94sLfruA7ZKfyhkU3+jLSO6X++VzWh2kozPEZTwZMH3RL6LFpJ1H6/YvfCEpkucc1y7LzbikVrJdCAaV+0YM7OeLlhAqNP3wUeIHMZLTuBEESowUIqkgsADMoCQ90SpC4BwWixkuhDNyL2p4Af0PjasPiC89VdOgnjBqg4Gs681azW/RwVTYZtgNt4qtjOC69UTYp8/k6XoNpdK4Rs4yuBjO9QR+WJyv7nj+5pVzWgEgBhKk/6JrKhkbUAXeHNt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+SJyvgGmlr4LJzqSB80oelghqemjzOEvj8gkZqPhpY=;
 b=OGOKVC7t9MURvnnml5r2EIXHJ0xaG+/MGgyHl2tsV9YA1fvdRiajlFmjTBE1IXi/OCuC9m4jIA5xJrzPPLP+vKFqeg6d58n2fq1NTWauCwd3ul+sFsPwo/BxbQwhyGEQbUAd4v71jqRJQNiIMJy9/WF4dAM6Wjlzi4G0DF3R2a6j0eM1g1h+qqOZN4LzKMKehJxewFY/4FTUeDTpGVpS/xKtX/6R3BoP4CtqWWEdKS0d6PofZM/X6a7jqh9Ti50RTs0G8R3PpNGePxiSXB46Qwz7KbOIVUb7d1wapVEFxlual89haXhczT/2OaztWkEv17fBDnJhl16RGC2uYbHawQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TYUPR06MB6152.apcprd06.prod.outlook.com (2603:1096:400:35f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Thu, 29 Aug
 2024 03:35:25 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 03:35:24 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v2] drivers: spi: Insert the missing pci_dev_put()before return
Date: Thu, 29 Aug 2024 11:35:11 +0800
Message-Id: <20240829033511.1917015-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::22) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TYUPR06MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ba5c6b-c538-49e2-9711-08dcc7db9e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|81742002|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5VxRMnYu9HNgenPfOGEn59+iicvLNRyii9WOXB46bT0w9fy7xEydCY4LGOEo?=
 =?us-ascii?Q?F4nU0y70Tq5wnhzgXdiyyd1fXvLDoedJ1WORXCSrK7vPDr2y2eaHswtccvsF?=
 =?us-ascii?Q?SJchO+q2/SP4SRlV5srjA90j4PO4u7cyylwZrmoFSdQW8LFfw5xu58n6BPgC?=
 =?us-ascii?Q?kklt7163sRPUq9pl+akHp+ZaGElHLQxslQw6y2q5vtIiopwzPZjLD2rwcBNb?=
 =?us-ascii?Q?j6dV+NmvVj6xZ3bq7m9PL8JkQiHiGrYOraGpyh4x89n0VNetLeeRcOdkgtlZ?=
 =?us-ascii?Q?6cQ7Bc4a67xhXAx7L6mlGwdEzQC4Pp72/QLsI2VzrhUjBV93oK2BOkGyTgWG?=
 =?us-ascii?Q?thWjUaVS1z2MB6DmH1VWs3pV4sTwtivPLusJa6sirN8Lh1jAIXM44GJLz+YR?=
 =?us-ascii?Q?maDoXEpmI5yvdbQRaOjYNqdr98ZWNlw+LF7UImxzOZFM/FM3dl9Z8JYVSaMA?=
 =?us-ascii?Q?YASOVdULylD0h+VrCA94uZOOAAwihx6/gs68lkjP73nbxL2hBPlv0xslv8zF?=
 =?us-ascii?Q?RzXnPahrOi9ueVMdDhl4geI4YCrxu/cUNKM/6BeOptF6R/RTcVB4Rw9QGwRO?=
 =?us-ascii?Q?awpHScdN9LVk/O9a74SJFHiRNztxIRlcsdEx8dTD3LpNFHj6Mp6ZcBKQmtJ4?=
 =?us-ascii?Q?D7/kR6MqjvjV4zKXyp5PcIE4psVsQWySMxs/xwTKCu91iOXYZXKoh7Q6FjX5?=
 =?us-ascii?Q?75O8YB7IMw3Uir4VJTdnDXfEi4Gkg6Bd9hiGbxKpWQHMUPeRGOPfp9GFRsht?=
 =?us-ascii?Q?jOFvOVf4a7Lrik9Q+83FsYN8ASx2XZivYtaRjA6ALId7z0nzxzYE42x3LS8s?=
 =?us-ascii?Q?4/ZqyzqDLK+SMk3SvAm/U6SyYUEBHweRlBUpyFY91uKcep9h4IUCObD+tJuP?=
 =?us-ascii?Q?6hyqO+AWqZUwuyOjkYGaTq1hsZbNWtKIov4reiE1P/u/cd5sjMD8kSE/KcsB?=
 =?us-ascii?Q?J9OxqYN86yXA6cY8sSlGrwYcAV4ejnJ0RHMKij1Jg2bKSgHoLTm7212lCcMB?=
 =?us-ascii?Q?TXXlotA+PI531d0Nljp6RdkXqXZqvhiYmNA7kZ+KfZJwfjgs6PqCwGWPebIf?=
 =?us-ascii?Q?kBnEaydlX6Bnp4/wLiIfoZaJBV6zo0s/JZtxHGYxhou7QG2EzabU7LDi5Esd?=
 =?us-ascii?Q?qny19pxVVHy4VPPBMY4OV73+HTGEyGuEyqDf1DpuztEsF15Hqg+f6KUVOzrb?=
 =?us-ascii?Q?Fp9MtmuCsbFuJyr6cWQdXYZirPHXwy/XcT4QmAyj0CIklXxM3hTg6A7E12JA?=
 =?us-ascii?Q?7XhUf5w3088BgRgfFcegwXlXS/WK/JMlwxQQ97c3DyY479xvnTM2mYcznLlu?=
 =?us-ascii?Q?uS9TrEQQ+mtvG2ArjPaR+yT17k2HOXD6Rq2p70QMaPWoWUI3yej1ySCqsQis?=
 =?us-ascii?Q?kPdEJeKIJMd+E4FZNUhxKK6YMrgMkIjYbE0ghdZr8b8S3rkCKhJfxHddI7u0?=
 =?us-ascii?Q?9HKW4O5pJY7AjlFHV3jnjSboj/ZcYWUiYCKiXquym45Q74HQ7cay9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(81742002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Cme6RhdPjm5bI01MCJjXYCL1NUDG3yGkD2eZngSn0SCzLNCg0ClOR2f6jC7?=
 =?us-ascii?Q?Wxy4RmUz4Qu8IepbbAGTx2BiQvY8Kh7aTKY1H0AUoXQStRAbSffrqGOZi/wA?=
 =?us-ascii?Q?PT8zzu7XDcbgaUQN7Z3UUhdaYNFqHFmToQCpdNDg2W+guUPxYT1Ig793QOus?=
 =?us-ascii?Q?4hHIfnGrm96taan/B7NdLisfjcSnvDULH2W5hZ/tOreFN+LBZSG9g/J8lggh?=
 =?us-ascii?Q?0anV7UhA4KGJ3mji9Ao6EACScqfoLbrnUkm0/MYqJpmZM/W+RTk18Soqgxjc?=
 =?us-ascii?Q?4+66kaf/ph4hRyAfrnXa2sRMq2dPCLYJDA8eeoO8i7BvAEdnNMuVrYv+6Bu/?=
 =?us-ascii?Q?9xz+LRvfkeHZ719vr1vbJZeASs8U3B0lmk4UxlqVc/N085109UujyE2tBsTE?=
 =?us-ascii?Q?+N3HWR/MDUKxtjRryufZw5FviufuhCyG0m/wdvx4L7s7UtjXhPof/3ubsYbe?=
 =?us-ascii?Q?hu2N8thJVh4ly/sAo6QqwENUHVLaDJWEkgx6hKg7QyyEqvKVnmauEZc10muv?=
 =?us-ascii?Q?XvsZJsGcMl1r8Ky4SaWCaclOX8vFPpHjsdIAwiBbLlO+uvYGT/g8i6HwOPDN?=
 =?us-ascii?Q?mUhGEMSqYRfaFg0EHQiuyOiQT6WFamt1JrN4LL5hJDox5mSNB370XeNiiKzJ?=
 =?us-ascii?Q?dRJTbATThNupAD6SncMjretoKN5Yiius5PXaC8ZPMkzFRfqg+umetEwmPf+c?=
 =?us-ascii?Q?z+m910P3dSE8xLpndnbsx6RSvEkWmEN3gRwpes1vJAn/Aq8AhoJehuVNGt8A?=
 =?us-ascii?Q?RqWkPyRhjSU4r8NP67oXega5Rc2WPB2IqLKM68Jn8MDzp21EAsLkwcLxHyxb?=
 =?us-ascii?Q?kF2n2QgE7E2P444Xt5KIJOtf514ih1Pg9ExLZDvv9QLYA+s7Q2t1oc599VtG?=
 =?us-ascii?Q?LcuqxrO3fwec7Dl75Iu3hDQq+4KvklrGwtnxGLtx4SJ0I+i6UI5HxCcicGRR?=
 =?us-ascii?Q?00Jgba4IsLlA+8GZFIZDpunkpEVsLNWnM9pmLjCaMFVSHJiuBZ9NL2bHXPx/?=
 =?us-ascii?Q?nb4FvWUySTew2CuU6Dv1GR2GsQmtcXJqZMOtfNgLke0CXrO8Vl4R0YXo8CZ6?=
 =?us-ascii?Q?CGWodumjc3pGG9Klc1sJa3eYH2Uy74FHv/QsBcgKseTBG3flpPDCB8ndJGtK?=
 =?us-ascii?Q?rBbzBC5QAiK2vIjJnbpzZ6JTx4vP7nPXFuJXvVnVLEP02Nb/ziJ9oC+qMf0/?=
 =?us-ascii?Q?0Hnm/42BYeiMbipPy1x7Is55cgTSC5LPkEBnyNzalIy7GXzTxSl7VFeVmt2C?=
 =?us-ascii?Q?B7PdJxhPWXj8dvEpUKDRcCHjcZNCuQf58scaNj/kZOIZJWJXQTE71psOLvtP?=
 =?us-ascii?Q?BGC8kmx4coIPRdRaZ4khtd+jjFZmuwMgUU6D3ac8pVR6mQrYl2vW/WRDf/RB?=
 =?us-ascii?Q?tzj2zET1xNriGgJS8ZWEvBtl95lZHxhD1Rokba9MPpkxdZrR/HxazYO0VLtd?=
 =?us-ascii?Q?77XGS/aHKkL6/iwHqY+qX5ZDp+U93j+q/J1b7L8MOs7DwVeLPYYYtBfl65jD?=
 =?us-ascii?Q?8exzUSV3AMEWtwlPoFVsrHcJQ7zo+835E9IzuvIgKvQ43sY8RQzb3YZ00JzX?=
 =?us-ascii?Q?AYe0IiT8HU5QIBmVzJdmklTAuxd4x6HNt+NY/4Nk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ba5c6b-c538-49e2-9711-08dcc7db9e0c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 03:35:24.5234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UR8/gMNN8LSVTLTZW7jo+UzaJu4y8Zw+hoAq9n1nMEjgHttoimOB+kkSFpbwc4GuG+JgmDPHqHsZ2Yvihn7L9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6152

Increase the reference count by calling pci_get_slot(), and remember to
decrement the reference count by calling pci_dev_put().

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cc8dcf782..a7bf4568f 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -146,8 +146,10 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 	c->num_chipselect = 1;
 
 	ret = pxa2xx_spi_pci_clk_register(dev, ssp, 50000000);
-	if (ret)
+	if (ret) {
+		pci_dev_put(dma_dev);
 		return ret;
+	}
 
 	dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
@@ -222,8 +224,10 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 	}
 
 	ret = pxa2xx_spi_pci_clk_register(dev, ssp, 25000000);
-	if (ret)
+	if (ret) {
+		pci_dev_put(dma_dev);
 		return ret;
+	}
 
 	dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(21, 0));
 	ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
-- 
2.34.1


