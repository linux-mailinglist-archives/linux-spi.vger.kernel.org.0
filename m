Return-Path: <linux-spi+bounces-10504-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A581BCB864
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AC094F0A54
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3627467D;
	Fri, 10 Oct 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Y3giv3Du"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022141.outbound.protection.outlook.com [52.101.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9C2737F6;
	Fri, 10 Oct 2025 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067125; cv=fail; b=T+iYv2Hq9ipzZTNFrA+1zs8uqzJWSRjexG8YKdhAfLGmfK6sxxvrH2yM4nyLh7YTPOCcO889p/BmJvxvVwpuwVvX7U22H1biyFNKH201haHYr7ugW3rtgZKmMgqlqk6/LxfwcrumnlrLuYz4xmoBtZ8+EskMsCbvrK0ggF+RsqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067125; c=relaxed/simple;
	bh=E2M8lRG6zN/Y5R2EJPWZ8XXbtiAD084miYqnGi5jqec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qD9ovL2N5+5ifERMvSKh+COC+4zTCn5N0ErW6jJl92TariJdpQPPvmfL7oCj4MnnZJvL/IuKjZJY+VJMH+vGOwvv59sythlorxOyQ1c9PIRerZcJVy7Z+sFzNlDBf/Yl587e/mnV6ElIs198bkKQkQavWzVzD6SSjPAh/bFL5rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Y3giv3Du; arc=fail smtp.client-ip=52.101.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IU3wlVPoSaymk7JwY+VaTrtbRM5BtuFbWxKlvkgo6eLtcv7bqhX64WWndA4rbMafZPPgCEDC2SdiIJHBEgfTmmEN0/5SS6R9LBD1hBg5sIUpM8ZsXvPzg2ebFKlFvyJQhZoCqbQbZCVF5i6Clsp2tdE93tMcmHjDxr9d53FTtzI9w59cp4igmQeRacYKgb8Y+ObBRVzp9YN+GRLQdhUJryqDogkpe0ByKwnRGPwwfkfiSEdtIQFH+Co0Lt3jmUgkJIVATUpQG5p8RPh6efueJgMvw+b3En84pv0kDfzmrS6ywAv9pR3brDnTSAt9gG0QCqnjMW0Bujx4Ij7MACsV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2snrpNrzRAzTOeqpJ8KPLiTOapJVIgdfhM9IUrv732o=;
 b=swqez0BiPDZLPNof4DTUrZc9lBNDiH5TroppQLb7PKC3vkfoQ1u5x7hAOaferhdNTbtve5V7oW7gSEcLngZIPOc7cOg0P/3DM3Umi0bfX6I2bxqAcUK3cccjwk3r2l+lzDhqa//JLFXF8hbCAUdf/68IZRvjkWsiSynHx0J73LNitcDU6SFU8yK+ATTvGF+diB1RiYCyPE0UjdsfDcgYBzaptLYAy6DHDoHWiJG0x/MzUoMseNI0H5/mUlOLTvqpIXzWmOPA4yfBkVdjHCBuKlIHVYxGoaO8aXjbRPiWdO6wimod8x19ydV1q3uT3Rm/MNBdXO8uGqNbjuXH2sWL7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2snrpNrzRAzTOeqpJ8KPLiTOapJVIgdfhM9IUrv732o=;
 b=Y3giv3Duh3XhN8HT3Ul+CEl0fTaBp8CYy5pYoEp7K6DgEBJQ04wzD5McjKWhYxkGYU8nNn2dzYkDJMXim8nIuj9fcuAG7wCgx8G7nt9nbYXmgkmMJvZHZ13rGso/piNyxDKlNUhtf+cUfpFBW0HTQqAZYdc5TxCegXa7BFXPX9GhhtYfSpELRcmYpzoC1QhUppS0wNz0sL+VEA59PgiUB0aCc2EwlNmHg+JNVFkmy8ttQDDxdbN4gJRDopBcn2SjBrIh5zAtO3hvDqZQ60JRr0cf0l5JXqlRBDna/dowLpZuoiROVyFT6Fe1FMrb37vBFNCD8eMfP4p/A8HNfNyMIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:31:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:31:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 05/17] spi: airoha: switch back to non-dma mode in the case of error
Date: Fri, 10 Oct 2025 06:31:24 +0300
Message-ID: <20251010033136.1475673-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cf7549-a9e0-4334-6a8b-08de07ad8e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rG1VpV45q3nOYtaWHzANoxdRH+fPxzwy0+PuEY4PLBU/0SwxeeQjpd3W/POa?=
 =?us-ascii?Q?gvo3Ehs4f48uyEBb65kqGfAi/GdkVg/hKonroX8nuNcXG53aEPnsk5qviTys?=
 =?us-ascii?Q?BpvPC51oWv37tmhsHVk7bpfPSQwEuUPLdVzg6TTWqyfkCmc50uqmtQaQeGiP?=
 =?us-ascii?Q?7WtEAm5QvY0JP3U9Pj1839sJkVPQkZyqwQO+5Nbm5sdo8vL/cTChraRMuc/0?=
 =?us-ascii?Q?l+KMA1/pqNzDpkEeNwuiASi2N+FyYAMk+wsNBCUAgMKZKExQqRt/O/ciFHgX?=
 =?us-ascii?Q?I5bHnxdMaE8xhS7Ep3hcpT/zBCuOUeEsBH61FvWoVHTczyJ+tE0q7SUbWR2p?=
 =?us-ascii?Q?ha/Cprqr73MWCRSPjOBS98ACRtoprYMtFuHdIH97MXG8ajndNa805f4ZY7SG?=
 =?us-ascii?Q?Huyn6PrrI/lOmLoeJb10uB6BBlwQUdUYUN+EcE/DHjpnZV1mZWL1C3JjIfd4?=
 =?us-ascii?Q?kpDmLIlgjwHdHSeNxluUxQzW++UJ05CSD48ZeTmuJGBByVI/zo+Vx5NK2mju?=
 =?us-ascii?Q?YATr5wOA9Lr1yLGKJEf7V+X6ZxStycXQdRupPH55sITdOWDAtHXAra1kXJBu?=
 =?us-ascii?Q?RCaOj045wgfEjrTZLa7PGZ0SjqJohs//06MOuiVc5A6A5wkDpXsEK1hX20Bg?=
 =?us-ascii?Q?gzn2Zp6/Or8VqJEVdiT3LVVPtGsBee2324iuBZ7Qa7hZPLzWXGyO2z3HuA5H?=
 =?us-ascii?Q?XJCKf5hppFR+7lLqH5A7aWBZM+lNgkLkV7xn1oiQjuX+TRimzmUsM0G/5+/7?=
 =?us-ascii?Q?/X2/ohTXC4HL4xSP+9WsDhL66rysEWNS8egXj5TL+Oia0SYhTDIJQfmpH2oa?=
 =?us-ascii?Q?PNkGh/SDiRgucKjjXphSLWwZfjnm/00cZ+Nx/hixjqBV0C9qEZW751FCJ8gv?=
 =?us-ascii?Q?FHyGIjjYFI6h+zNU5pShzet2g2zRc3hb6Jea6vqbVFhc/a+fc4AIL3AoHms9?=
 =?us-ascii?Q?1gzojcu1fGYsHhxwFl/e6PBOBdGuZPqf9TlwA9LTrPgCdXePGokH8br1f48X?=
 =?us-ascii?Q?05FFSHeQMosPbmtCGXeU2a3Ox9eh1Ss9KSXzmYdACotlj0+BhZvuhjC97mjZ?=
 =?us-ascii?Q?+cX9Qpai41qGQs9hNdQKj4j23BjC5JBa4V9mO826dPcoqoMnwPnWypRTn9rt?=
 =?us-ascii?Q?sLm6m87GnzvfaGph+4TDrRLOpkWvrekJMbN0t8vhlGo1VjndeP+6V6xLWoDR?=
 =?us-ascii?Q?DrZXvNv3GLBPKEQG4vwpc/3fkJNowpGowldh7vb0sdw3tc/fWhc+t7E4txQi?=
 =?us-ascii?Q?j3GiDEtbua+EeVwrUX3bH38N+Y2AyOWLTE1jDeItDBua5oGQUUpoWZsOJVQh?=
 =?us-ascii?Q?e+PmNkObvRsG5STcI+9X+75p6NfwYNweVUSL3FpJLRKsj/oP/ISunx+1iRpx?=
 =?us-ascii?Q?gulYxbuMJgmNUcQljkRfyKi+WhbdU8Ot8LnXTdIkse8QGSGhwLuT7QaKahoS?=
 =?us-ascii?Q?pGDVb6mmd17TjWYkeOEcZQbWnHtNBIoP8DAR1EDP6ZNZ8uupLolVFTNhGEOw?=
 =?us-ascii?Q?9TlWyICjwnLkzQJF2e8PT6+hy1SSSPeD9DMAUr+/iX0WFBDnvjqqYc9Mxw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Tlt6Kc+jNTcwVXBflDhtWaYlKYcRYrv8iy57r79e/qg9I+Npf42S03h0Gsc?=
 =?us-ascii?Q?9QWX9SDRBVaGrSPR+muKpyDcb4GIE8SdpoIPtChwwSCNhsM7O+tDnWvOLewB?=
 =?us-ascii?Q?UBXWsRtPBC/yNARhYAFNsJmca1BuhVlv3O6FDHPt74JwHODPU6/B3hk8bi7/?=
 =?us-ascii?Q?GrLZE/WpsNXYTNTAbO9IvWwExcbizyR14i+9eYO+teIcJPnahP5+e+VjHXE+?=
 =?us-ascii?Q?zbM9bUZjFqtNwiW5aYZluW8wP/WPDyMp8V5GvkFgUhu/MiREWTIM5v94ez8C?=
 =?us-ascii?Q?qc23QtByg3C/wGnvP+gSs5S8Tc1oZB2U7LIM/2brULUyN2CKKvzM56S8IUER?=
 =?us-ascii?Q?6Rijrk9aTBY4XAeXvht5rkn5oA03tJ/TDW2dyFNzSvpe7K5CZOrcvA6wu55w?=
 =?us-ascii?Q?UytU7R1lkenUofQEPJQqiOnTt7q0ALdonf+EZ7BfGy4eUYnxNAR9T/lKvAt9?=
 =?us-ascii?Q?sZVpl46LVyrxjfaLrEHBRECim525ujAM8zAsFWGXnIjT1zxdVK9tuvXjO/BD?=
 =?us-ascii?Q?oicbz/n0AfDZcOliQLK5ztp7ouqE2KePXmYoxnvHM/L+ryUVKf0XVNG2d0dC?=
 =?us-ascii?Q?EexaFCkMgNxlCTZFJE8+5Td49Jme2aIey/z1ZUlTtcpexHwKEahYpJWXs2Ok?=
 =?us-ascii?Q?YH3GXS5YinZtY3Fx5xMOxhrjZqN+FWSpK3TYD5hGToH/sJ/qvz2ylQxe3BVP?=
 =?us-ascii?Q?xqP1LGqaG6/kZ4MvthdorMrek94siMTY1F784RTx8OY5O64r854pJJtvf+OI?=
 =?us-ascii?Q?WYDN9mgIPbQRUJwZMbTik2KO3aNtUmMr6YAysrtE+qZl9E31CLCm+JdRj2SI?=
 =?us-ascii?Q?0pHxMvECVTGuyCEJnEBDA4okbfE5fjt5hVlzx5sg5Y8tfnjekp9Uv6ffAjl4?=
 =?us-ascii?Q?sR0toPISJqen/i1Jr7cpvZ0WhkxgB46T1Xgl1AxPGbTB3JbMN1+VCISieL9o?=
 =?us-ascii?Q?EtH+QUT7zWm6sHUq6+LuVqMiWg+z9lg5zpwcpKWDj8f8ApTM+7r/C+LpWVLd?=
 =?us-ascii?Q?dnuXAjtDzaLgOa7ZX7FUMYozc4ttiS7dUyyKCWW/njVvj2FYbJft0Vp/YCDw?=
 =?us-ascii?Q?Mh66JuTQo+eh4uy3vNPAOVqozjoU+2qIru9NImkK+cGPB+Xh6qLoZ+cetAhU?=
 =?us-ascii?Q?dd0MDQ4Wtq4m/XuwnkSHNJVmDbCj4BmwjLzzMPBCIa5GIkJ5vgWL3f5ecuCn?=
 =?us-ascii?Q?RFqVWOzZbmUwbrsynt9FQ+KBX7YbgBImJulT6lX6+3Y+rQIZS3TNfHZPP7Uv?=
 =?us-ascii?Q?bKxVYU44RcGZmzU0k3QavOzxDhMCZc9bdgYLeEN7qCh3qtAtlpMuPWbjmkDx?=
 =?us-ascii?Q?ZDDSFR6XX1i5ZqzwxoSJB8dSM4yWL9Eu3mDdPzbwTMqzlyx/8hit5c/cY7Te?=
 =?us-ascii?Q?OBLdP+pzJs6mhFUeJkL292XtAjAUxi/dxOTf7acgm6SXkV+WWJQPN0/Q53nF?=
 =?us-ascii?Q?c3cNwIHuBm41b6Dnty4z7BDwrqSioI03nUdKYJHDubCRZjW90TqHdU1ieLU+?=
 =?us-ascii?Q?OMZYjO0hlvXuZB8qyswRPD3OtISzmUmds80NdVFGx5KykVelSxEGKRCIzGmR?=
 =?us-ascii?Q?MVsEv+BdZHSLwQ191LoAjhUI10WresB/063WdimV+wfRlJ/wqBRK504cyT8n?=
 =?us-ascii?Q?d5I2ud+7wRLNsV5L1cKVHpU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cf7549-a9e0-4334-6a8b-08de07ad8e5c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:31:53.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfRoct4xRvygsV44kbvNmSiO2kR+RZDc2BhIFt+VNDj9y1j9qwezWNLZZb+/leN8ZGtxUsqiW09Ueg0b5BTsBbJpxitgLIq5G8S1vxo9l9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

Current dirmap code does not switch back to non-dma mode in the case of
error. This is wrong.

This patch fixes dirmap read/write error path.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 2d86dc62dbde..a39c3ab4af5c 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -691,13 +691,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
 				  DMA_FROM_DEVICE);
 	err = dma_mapping_error(as_ctrl->dev, dma_addr);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
@@ -797,6 +797,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_FROM_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
@@ -926,6 +928,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_TO_DEVICE);
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
-- 
2.51.0


