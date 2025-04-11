Return-Path: <linux-spi+bounces-7541-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89254A850D9
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 03:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D6D8C3719
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CCE26F466;
	Fri, 11 Apr 2025 01:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="VAL8PY4n"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011024.outbound.protection.outlook.com [40.107.74.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A66B652;
	Fri, 11 Apr 2025 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333427; cv=fail; b=jlYV+y96hNjX96LVNiYgnT/T1CpSxGCHrejktDf+Qh5/7DXl3N6M9E2uVT4QYxTHjBjzxu4F+QluS1AAID3Ot8vTukiT91hl8thZXpYdgIGLdmaJtK2UHDTcio5aLegmX8bs954XrdvgmOhsge6YtXfcDN7qTvkZoVn5vBWGRlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333427; c=relaxed/simple;
	bh=anowNrnL30sliY5BrGOyosSHWetaDujKhZR1HjnvRbk=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=BWjuYT5xwk0wGpKteAEYrmh6t+JdkC7CTWMERRRAz7hIgA6i5ESaEB4ZhSJ0zTyBgW06rSofdxoupVG8RxhotRTLlyMHJmgcBY5XZTISi+C8Kjj3fOnZuFgEX4MBYkfDCo/j2/z34APprnH05c3mLa61qsFSAa6oC/8icqxiD8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=VAL8PY4n; arc=fail smtp.client-ip=40.107.74.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmU6RGyfviS/CnKb4Jbh+4rYBSJNRqvOnDWvAGkpgWrdL+p9zWOabNcOiK8yLcdWIO8dbIzNVf7e6cG6K5/uu1kQ7T748R1ztATk0GUn9lZJZdruGKx4LY3v1uBQPrFHy76MoVraqczx2Np0kK89d986zZxbFT4UkJOfl9Ffw8TdFEMzNfc8vzVNZZ0ITipavUqMzsgQMECGPDPxG3ob+4Vrq7Ge5XB/Aa9yPM+MDV5eOjdshAqPOFZd0MgRIoLXcz38YVwcfvCxsRniSxlUCgrJALC82pfiFT7/ICZJjapjweqDF3NJoD3Dbn7fiQdapwocgu6/+i/H3Sbg4fM3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OBrN4ryYBMSnBmUyBn8Go+ckE7Pd5NuK68kK5v00Ys=;
 b=hrUcPDzRd7FFssbsR+Mr4xlbNL38kl5p2Q6FRzutRIDUYP3SEzLsASA3/KL+IjRBQYWT35kIGlWoXFaWsMeNYGyWV1gvFk00/5OyVJp838YulAyGESIRJYRZdmtl7zGC5tL8ZPU06tZ2YgCyvilNeHJNdx5Gz4VfhRMn29wbDO2pxYd5zMqggIIYZnfCDP2xZkZ57n+TciTL/2ffxU5WWVfA9lI2/pxMsyLHMvpzWDh2o/ysapi0VHeTwPbwje7wGQrHVTLjIOX6TLDi0QgmOHWtUlVJK+HNFFxoknGFBgJBI8cvOnKBiUV9Gsg2++6xS4izHK521lEGB8zyqfUFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OBrN4ryYBMSnBmUyBn8Go+ckE7Pd5NuK68kK5v00Ys=;
 b=VAL8PY4nYQNmq8sKGYReYzeFTwc+20mlyIYkcKa2i4WxjahORAbQe8lsF5Ht2cD6Wdzt9MBiyL7RLchWg4gCHfRONQ2S5jSxKHbp6USBL9IyO9bu9AHtxk2MZoWTXuFr/1OS8cUZUbTZ7fj1V3G6fqfzzRZnyuk64RDpsYsck9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY7PR01MB13579.jpnprd01.prod.outlook.com
 (2603:1096:405:1ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 01:03:39 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:03:39 +0000
Message-ID: <87cydjh5lh.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 3/9] spi: sh-msiof: ignore driver probing if it was MSIOF Sound
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
In-Reply-To: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
References: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 11 Apr 2025 01:03:38 +0000
X-ClientProxiedBy: TYCP286CA0109.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::6) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY7PR01MB13579:EE_
X-MS-Office365-Filtering-Correlation-Id: 0493b317-86f0-499c-90d0-08dd7894b1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?30GW1khPF33IhFSPrmKIlXScUpbfOTEbickkmzi+TKdf7iKNPSvb4SImn1wt?=
 =?us-ascii?Q?RfMiSfjWXxrynda5xX3/4oVahJjynmaO6vyBIFmdbdnFxSGnuJ4eNItxoAIX?=
 =?us-ascii?Q?cFSgoLSGbFu2YZno0OW7VBM4t+dNY8NOYXrkHM/mB9IlyfghCMX+OXhvYMrB?=
 =?us-ascii?Q?02lW/3FQOZGiRVYBXPcSjqiXmmWhBl2XaFnhntlsEMh7lQ2vTN/bj1hPSF3w?=
 =?us-ascii?Q?t6qHKrHt1aZC0LNpja4FqXuZnOu4FGfwokarOjjE2LHasDy/9d/qh5j+p1p6?=
 =?us-ascii?Q?TEcpZkCyDsqC0rRmi7ERa9EPn6+dy5CEdbF1vj7VUJopOmMMuIJ9MFnSQcak?=
 =?us-ascii?Q?OXNr37/wmvmWGZ4VnE4sm72EXeT7APzF9EgiMYmJkS4GEKuOlOSoFZXqre/Y?=
 =?us-ascii?Q?NOkid3C2Cq9LpBBURWU2betcOn+5P/X+2E86wSELZPTRhcelJJ8mk9CoC7eC?=
 =?us-ascii?Q?OMrfYLl4dGEfpBYQULh4qUYG/rNFmuspmcku4gSgnblfZgSU/eX8ZuIGMa0a?=
 =?us-ascii?Q?cmcAarRzAp+1Eb+3Ozmz3avap/n2iIs8id/oEad+VR3Dq6gs0D7NNdTooUPg?=
 =?us-ascii?Q?fGaVC4rlcx4uZyHDmGuP+PBUZ10lzqP+L1knJREzm04dni4sx3BFweYbRePm?=
 =?us-ascii?Q?egfQNKwNIubBj/jNlPTep4uR3anvyLw3Zo1Jm0gofRE6ldRTm3ktGpnDTODh?=
 =?us-ascii?Q?ZYcrSwcH9A2B8fnot4XCStQFxwVrseEp5tbNB2AQsbFtbrAJi138HDwa7ntL?=
 =?us-ascii?Q?9bGIYDVtBHALDoTiTo3o+8FcxiMHEdDouN4qL6mAoxT1qldNhMAZjmXcpUCl?=
 =?us-ascii?Q?GYEKEN/zxkUevDzBLIgwF14RvzAkxetoe5EpsA0xY/8svE25pP0eT5ganjFC?=
 =?us-ascii?Q?sDqOcprzG+StChVV5sBgb3fQLGbUuy8rWrKiG28hUr3AT/Tfnq8JadLQBxSD?=
 =?us-ascii?Q?nLAwaUatvgZ5cpm3Yp4ZtOf7KJ6w+ndSi6K4/RnILNA/I9SpUy3AdWthQ/MG?=
 =?us-ascii?Q?du0NBWtVT8AIzaQUX9gVsdXwwvnQey+MPDKDRalPXQQeueZIo4WEa7hzUAej?=
 =?us-ascii?Q?DKPnBranp9P4LFBimLUGGjbTjjiYcaev7lnXJ1bBCiTUaBpSRrnHn+6RPRzl?=
 =?us-ascii?Q?TJwzNsulgcG/dJLXn8HpbsZXJT/og93/StIJALctT8D0h2+A9ZyynhhBxIs+?=
 =?us-ascii?Q?dUeTHsGi+mhexDQiZ6w0OOZgr523tFEFpSQrM4G00+Ktm0jrXX4mJzFqbjcZ?=
 =?us-ascii?Q?M4WGsVUwPaUlCYB1eBtzDGkrgyUx8RzqZxSrZVnmART9jJJiZD7qvLPm1LZ1?=
 =?us-ascii?Q?buxabMTM0ORlx2nVUvDrD20R9vsAcUsocPzanUMCOc6Y1CgqHJ/QIjRhj25C?=
 =?us-ascii?Q?uc6QfiHhr3BFnEIxMfTNZ+RjRf9XoIPHOI8v/Cw4FV8eROIuWoje+b0NSCvL?=
 =?us-ascii?Q?7oGoY/KZDI3iUwl6mvAhwLBPad/Ov7kwV7iNDKwEVj/0Oo/AKCAqnEQ97iOZ?=
 =?us-ascii?Q?WK5R9y+Vy66Z7cg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kwT5Su0GDG3+rU2HFwqbqQXj1pUk+h2bue2JH8/nqfAfO2BfOKKg21RHx50P?=
 =?us-ascii?Q?TymLOTPZIKm4IqL6bHObvs0C9zL6zU1WPMXB47QB4jcdEJiS9RcU0olS+Yv3?=
 =?us-ascii?Q?yX8h6ucKMTWQUQGh/d8pZxCZoMyvdSPtg46I2QAlxoEjwV90gwf65G4M+jTD?=
 =?us-ascii?Q?aAWwQG1kGA9z2ntmEsN1TFR65R0hRC3EjkmJxmTvg/cPikebCfmFxF242gkD?=
 =?us-ascii?Q?KlE1XUPrIzfAdlqmKC0rc5OHYyNhiO3eswwbrWmPO91/Q+Q1MkVgcWfGiB/Z?=
 =?us-ascii?Q?y4KMwJvF2BQDZVCYxQmLv9fLPltauGPVA0hl8jxHB8GuIKcKwtPsC0/KgLWF?=
 =?us-ascii?Q?DDyDHz3dqXMdNwhBjjCqNQ1f4ea9m+HffWRapI5nM3w/18AzGh27b2ZnotSQ?=
 =?us-ascii?Q?U98GtHjp84b/6mF8riLlKECMHi0ZksfR9pqGGEcRYLlW1pSiUJDvV1/HRi2W?=
 =?us-ascii?Q?MV4tnIbHyb4bgwbcCxVMfZz1iFi3ybVbrmQELU10t7Vak7Vcmgop8Kjo8EGe?=
 =?us-ascii?Q?FCb4SCGstVxIjBh/3z4OtN9JMBzP42dZrEsGUTHIp15EpPagoLCPFBTS82WG?=
 =?us-ascii?Q?LHha5p2biCU/9Jb2WS3yfdHNptDzZ4L5eqIn6cuD7gPrPH247J8XWyZi+Rfg?=
 =?us-ascii?Q?h9gxzcrE4F72Z5bWFm2ilIBWtmo3hfpSXROcwTpmv1zrTe2DAgVxGMOt5AVi?=
 =?us-ascii?Q?NokmaoeugNvUM/wMYlreoe5Sh+JvDHfbBXJnMxTYwrQKoMwB0Xqa9VFZIrSo?=
 =?us-ascii?Q?Wv2e3du5TDv2tNDzrU3yE1Fk69U9r15g4mcMXlBdrLhDqfdPDcLK+AQxCBmD?=
 =?us-ascii?Q?if2o6djMFhUxACKhq2YIL1oBO1rQb7G4NRWzjtZtNPwpNkDUthxqhI7OrgFz?=
 =?us-ascii?Q?ca4xFDXle1XPXx0sVkXIFmBgF+XmX+OMjSeNLs6uienVPPnxq+Amkl8E/zXX?=
 =?us-ascii?Q?l3LMcybGiLy8o1lwiACCldIbfuf7qhhljgQZwlRn7MNxpuZKRd3V9os8l+0/?=
 =?us-ascii?Q?lOv17MatvlV7Fl8vc9aA7Nb1Rmr0miTU5E3loWN7VqKKmpqwdLjmvYk1GhSc?=
 =?us-ascii?Q?HU+KUciRR3BT4XB+SSmRQTXIGLNw5Vk2GDWf1fSoqk9afPURovJzds6T/An4?=
 =?us-ascii?Q?CN4fjbNOYZlD4Bf8ntbpL4IqNVFy3iCNCXEuqmZoBHvKZHk3flqdTfQSNrel?=
 =?us-ascii?Q?8P7mbxbN9/7eq4a+mAFue9del+QJr8QC7XI2qeGJJtiuju4YVKO06yUMnAeH?=
 =?us-ascii?Q?ifODTWDdnyOulHryqThE9QyJ1FifPIbVrO2kt1+lXhLy+Hven/4vhG2bIDEi?=
 =?us-ascii?Q?0wz9Ww4IJTYUVM+2xt2rOJEPOnuBsGMmDgW17sTz6xWxE2u4Bo3AIwDp0WLm?=
 =?us-ascii?Q?Dehc3BnSocCyPqlG9Ogt6gPBZMUkuDd5ESmh4v1os9fhXGNEt/FpxpIEa+SY?=
 =?us-ascii?Q?ipTR2B/FiEqIOvxTJujeD+ORTH340VixnRnWJayVjhq5K5i56z/qTgzuRi4o?=
 =?us-ascii?Q?Gnw1oZ5lTEty67BwLv7KVaAraMKGfQbM0YWXeguGkczf5zzVHX67PHfFxkN3?=
 =?us-ascii?Q?F/L6ETUtewgKWX4WH3b/9a7be74jGZ43bNbPsrtYS0HxLAHU1tm9OyvGdYhq?=
 =?us-ascii?Q?Iom9hT8p9Em/u9yEuew3iBs=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0493b317-86f0-499c-90d0-08dd7894b1d8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:03:39.2051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yToJW+Ay087eyEn3D4+r15JEoyyCs5hEzIhE2vld7kW/NFB9M2fabwMjTWRav4Lecia2I6olXS+F6GJjPL+G/o5OeuAVWnfNFtAjnee944InnGARh1LuTVGvHPIg0gP2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13579

Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
Of-Graph in DT.

MSIOF-SPI/I2S are using same DT compatible properties.
MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
MSIOF-SPI doesn't use  Of-Graph.

Check "port" node when driver probing

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 581cec19cb77..d9e3d83fc7e8 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sh_dma.h>
@@ -1281,6 +1282,11 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	int i;
 	int ret;
 
+	/* Check whether MSIOF is used as I2S mode or SPI mode by checking "port" node */
+	struct device_node *port __free(device_node) = of_graph_get_next_port(dev->of_node, NULL);
+	if (port) /* It was MSIOF-I2S */
+		return -ENODEV;
+
 	chipdata = of_device_get_match_data(dev);
 	if (chipdata) {
 		info = sh_msiof_spi_parse_dt(dev);
-- 
2.43.0


