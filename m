Return-Path: <linux-spi+bounces-9621-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430BBB325AD
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F62AC7354
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD11AC43A;
	Sat, 23 Aug 2025 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="KfiOK4Yt"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022114.outbound.protection.outlook.com [52.101.66.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF033190664;
	Sat, 23 Aug 2025 00:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908213; cv=fail; b=IqAqPEofkEMJesSOqAqNgfQnkmV+P79bnYxs43NV+8MYWBDEhHHF6WcVzvNkYgMYEj1yLlw8n92L3GON43eDBvzQ6sfZyuVDue56q/xbePnT3G0FRpQMe/qSIQd0Vgiq9CUKyloDLUNPrBAUiANqBMEdvirKoGkBbkFxkXIj7O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908213; c=relaxed/simple;
	bh=twXV7QtR9S7ZDf0+JR96nFP9I9Ht3hg6SoKXp3IE80c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQEMv6n8zku4lrYAATHhRqHTnd9l8dNSMCME5LHdpLvQ2PJnjBr9RRdnOTJxWS+B9kqbHpmgo14Upf35z4s7DfdP7qvMhMUeXITXHj2mudKRPc7Q0FIriegUTdfivma+ZFTpuA1QP3lCuFa2PwFHA5Wu/NiW3eAuvqoSPCiW07s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=KfiOK4Yt; arc=fail smtp.client-ip=52.101.66.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBsZUopFlPZ/z1+y63U8FJCUPjii8Je4oOqhZitIVzWVTD4ELi5mPx7gA8xLgZvLrlMulZdVWOb9yA8B+a4hfW9eCtTEdHLQ+jTA1iOLQeyVnxcHNrQGhEb4v+RHfS3L+nSioBoA6JmABFyAXAeahtxCnkPnPgL2XFO43w7FiJ7oJJNlCGvJXqc5tDcMjHAcKihp4UiRiHV/I2yFonNNj+kUsnqak1Ef/AWDudeG/Ti6mIKFPS5f429sT9f7q5LDfVg2Ahx4KoQfR71l/2OTAzscjvDKJCfZ/38Ew4jIwxuswRXQyoyhjqtF2Q3628chGhPHLu5EMI0UiQgWBIZpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgMfy09Jt4PFu6uBixXHZ2RtWjx2cmE8ZSqAos/pNIs=;
 b=EgKZTTmj7z3AdzM6ifgU198xbE3c1dQI5tDWUde7mxlZciyRX2fc3N2Z+CtEVhYtXp+DNC7zP4P6kRXkE83JhnBAmrc4ViO0jmEoNlHyOquDYkzsom09uQn5HNjcDwWm8CaaL9piVU4dmiE0ath1a//MDFzfXhMsFhtMy6xUP8iYy1XZBi+FBLN4NKvPoiR4yEknVwjkIgK1AcQm1+sNEX8I+S5bxH01YkobJZbz0rSTeEFy+u76uCowAgXgP4G+Bv7BiSD9kqO9ElkPf+czvF5HUtp6r0WenxxlbD0u5rles8xn6QhhblG+GpK2QjthpCOB3zgbSV9qtMHjyMr57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgMfy09Jt4PFu6uBixXHZ2RtWjx2cmE8ZSqAos/pNIs=;
 b=KfiOK4Yt2oRsmN+D3Q01/OSrZ64EnLVP4qumCxvzbmKMDYMnL4htKvvLDf3MvRxbkO5NqdeSU98o89fw5G2Wy9lYW+EST4NxKr372IpZvBAmt4futXO1YBmqOuxGJUVn5abqnFu6teVxMxLZRIpPjCF+N3eMjiH/yi1ZIPaIvrkwU3b0TDuDUQgukBSCsa8hgh3cRPq9PbZC9mPM+xXpXM/PWERHsnIZH2Ar3Co4kzugUy6iJiKZd7yxHyhBQRUhHGSAIDBVXCOqz6IsTf5JRk4ctRFZiPCvPvx/OW1nDbruCE9AGNyrUGkaZCADwqAI6dV62OF9TGuvWMOL/rV6aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6398.eurprd08.prod.outlook.com (2603:10a6:102:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 00:16:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 00:16:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 10/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Sat, 23 Aug 2025 03:16:22 +0300
Message-ID: <20250823001626.3641935-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 512a8b57-097a-421e-686c-08dde1da56ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gs7eqLv67+Nju9w4n2ENMyAXl8E9Oj+uO/+3KWKbKMkg+svQ581q5pdf5CM8?=
 =?us-ascii?Q?IXarNunnAKavZynTXwJ4maeCQS9p+BxJYgJTVEsqCYTMEXl3ur0/BMEe/0ce?=
 =?us-ascii?Q?KQle8uGx4Au2qWPbX6Fzeg/lSshQBTirYG+iUJnxLFjdxU1aNUQVvOd8rAcT?=
 =?us-ascii?Q?WYyodoF91w366oG6QvLySUGrcbTpt1eCKWxYF8X5DHNyDzRinglBck858eMx?=
 =?us-ascii?Q?Mqfqwi94lu01Rt93Yy2VoKAUPJKYvPBQz+EAmAXkQfYovWmpnSObsESfiiy1?=
 =?us-ascii?Q?lirCtI0UZ8vX03qVm29EcDXyLgjjOLIVi939ZVc4w6rReybv57ygJUtFNDnm?=
 =?us-ascii?Q?VqaQ38HKX912K6dlWmkO8+h14b9rHlQRXKnz09fr/iNBKsdPN2wePxwwg3Ij?=
 =?us-ascii?Q?nujZnvZnRQ1VIKSbEdV9SNaFnyeUshMBLeIVsMYKJ7AtIIfDhMVmyauKuSF7?=
 =?us-ascii?Q?BEEV5x+su8oTTVD0PqxIsyPGRm2Kv9rodTIakGIheu0nOULqynPMVpM0x3gy?=
 =?us-ascii?Q?bzUCRe/gvHghYWbwtDn3dOJmEMbV+CLS5fHq8cCG5mrJEJ3QjNx9bcy0C2mn?=
 =?us-ascii?Q?W9xtCdVhkFJmRMMwx8UHR6EMzYojifUS+Yu6EV7VPwUNjIoTfHjpJC/K8hS1?=
 =?us-ascii?Q?JM357NSTo0G/a+ULBoaHBhKqwNSHElZwos4IL61xHPKEmnEAfH/F7k8+SG2d?=
 =?us-ascii?Q?EpIRjMkB7bmeztLEu7GJKZ8NMqkhOe2dGkPOe11rR5C4LX2lPkC11V+2Ouf9?=
 =?us-ascii?Q?ZyEEHM7i+C+bxvDY2hbG4I5rvbNmMev6wGNLLL+544QWLD05UPuh/cWxQJ+/?=
 =?us-ascii?Q?G+LSyrtA/LtaKkp5b8Eh0wTrj1R+Bf1D9S6zxCzjdqYslO2d2gKpGpkzFPEC?=
 =?us-ascii?Q?6prBTMcwd7EK2kMSFECA74eUElvI3IugNGbf7ZzOE9+hSlU7bD4CFgESADcD?=
 =?us-ascii?Q?zG9FGLHxO4hJ+Pup5aRBUIt1q8pumw6Gg2h8dcCxxl/tWy3wYWd2m+Xilfih?=
 =?us-ascii?Q?qwds7MG2trr02FE1mtJ7Ce1/EtiiOlAMHmqYnOurxT2y3elBVEDf4OdHRrUZ?=
 =?us-ascii?Q?ZlNYeVKOxoXLtDADaSO5qJ39GhXDHBlCafvd9+JNOx/J2koy85IZQFVvWzHI?=
 =?us-ascii?Q?wSkI68GjqThThXTwCD7iHdgIwRQq1cNYEdDqBUimCHNA05OHxEWA3Nw84hP/?=
 =?us-ascii?Q?Wp87i8WwjS2gnM7rOlR6ir/GQNhGrLrQY2brz2W0ymFndwsz7K6AaQgtQNGB?=
 =?us-ascii?Q?2s5QQ+GyR61WlFG87q1EeNaKSZ2WKfpUlbBnAztOdtqAX4wa+5mStoTv9Wbl?=
 =?us-ascii?Q?746pNhG3gvQ6hItzdGbmP1oQ3/mPMFAoDeUPrEVBVO4mnbBts+L1F2En3odj?=
 =?us-ascii?Q?W3YAbp3u+7eUebSlO19yj3xzvVe/taYlnZ0l18rWoq5YPpQimxbanSY6zLN/?=
 =?us-ascii?Q?kdZneAL7sqWvTuSlmxRa6PXnsIQDY8JlV5sA/ppXPoKyRGuuTLaidA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VhtVVQGVXGxN/LBJ0sV57OeyBY1m3AtIPiA0B3XI2vU+GAt+sQFgQUpfjIE8?=
 =?us-ascii?Q?aLrmt6o88JHR70L4vAybxzGDI+hZjiiybpmpxySw/K3dDGaJvytsDf8aL20f?=
 =?us-ascii?Q?/37fApQrbyGekGa69NKDkgJRkY88t2g8DHso0MqX/ouksqWSqupq1py+TdZn?=
 =?us-ascii?Q?GfwOMcR2Wcdmd/3LofJ5ODRkrK9zL2F10JoZ6Cag1JSVTqQMm7kgMK36KmuR?=
 =?us-ascii?Q?QujtU1puRMjcU2SX6Cyrw5wfvPReUXt/Bz3heXSmUI20HKacuZhyDkREp6Y0?=
 =?us-ascii?Q?nAHBIbXK+qNlesGk7W59M5yDKPGEY0vea6FTYezzq6upOWNezUxdsnOjVLFw?=
 =?us-ascii?Q?w6PzZP8e57WTU9+IaWmf5jwV1eNg9Y3bXNe9xg2zbC9MJXaUhvzHQvox9D/5?=
 =?us-ascii?Q?1sovjwGG0aLH0psFD/qRV0O+byXoNvh5GbSmWDkrHiBmnSN5+CFyqlAv1aBy?=
 =?us-ascii?Q?GNEUAEoiuPfyWqY9NBqCNqBh0agTKrFmoNgBjAWcNeepiRjcwY/LXEL8u2zq?=
 =?us-ascii?Q?p8GXwlMDcQqn79cvsAFkp4Lch/f6v/nbn5LKByDa2YBoWDWwFz6tLb+Nme2B?=
 =?us-ascii?Q?YkYSEEtm79q8UQKAwICJonkCZ2VKx5tU6KcmFiHFPuEP0FuKgoaOqn/7reWS?=
 =?us-ascii?Q?IrA3a6WNSdT1sN+kjkz9ZF4OBDSmIAGolCkLg+DHaxq2/7EJODwdA3J9ShDR?=
 =?us-ascii?Q?FYC+tiaDt3mE+JNCRfuc9I1fM5a4RG6+zcocLwFJ6MfFIavEZaR2/vQ8AJQi?=
 =?us-ascii?Q?GE1+OqAdeR4lXjaPzlMo6lRBEmStMqwtIs09IOH7iTswCMZI5WMKuMeATmSf?=
 =?us-ascii?Q?NTuVAvxmxE4vEcH56R7zONbIEQhf+VwF0b1Yv5rjRrJeOsdtcZ+Yrm7J5yB8?=
 =?us-ascii?Q?m5qBtfW0ItRA0nDmD9+nv7PlO9TDIBpJ9gsi1LKEiHkmn6DYNlC6AvMct0KV?=
 =?us-ascii?Q?h9EpvJHOFSsUPGl/f7khwd7oO+PEP2gueBwoaW5zUZ8/4cZyXh8eAsTwWNq+?=
 =?us-ascii?Q?gjjnJMqeDKBM5QVOAvWTT/x0FLjxO2xhLLJKCgnidfL42Np8uhvU25eNfyfx?=
 =?us-ascii?Q?oSfn+mmv1UOgRKGqNQAnSLLZ7ZwojoE4NE3+ZCyN2FoBQCVE3i7iE7K7AhES?=
 =?us-ascii?Q?ws5CPFVN6WxCWqnVq7n6pPcJXL4wbyoet5JcqKtBZDvkcBY2n9yjqNfUxVFY?=
 =?us-ascii?Q?wB47qBny99eyVVQwEoicsU4ay2dODyr4swYZ/wIiXLZAXEEuWopyf8asIszr?=
 =?us-ascii?Q?TjnWWnrSI2frcoEpypeObvndecwwIMDZLH5V9G+3WJt+iMIwQTellw5k1Qcw?=
 =?us-ascii?Q?dNzylRXLiOKGoG5Uk4XclK9gJAnmdV5mQrS6cf81kJU4ylvwlYwFNrFwG5zg?=
 =?us-ascii?Q?OV8VEJWtKhbeSKAB64iZNGTC2SZfx9O7fFEfAYkWGTMCmccZ9Acf1EZ406HJ?=
 =?us-ascii?Q?kOEEt8sn00VxWColOmtYMAxEtVqtgFqvGGC+xWE2uYxk+sd5bL1pCOZRfPXe?=
 =?us-ascii?Q?GrwzfVxUDCIIFHyUUM0m3ccOFpZjjDkpYFZaCsd3ie5wVoiIXHpWWhzlp9Bi?=
 =?us-ascii?Q?c4KDC1++819n2A/pu7zF9nV61NoldZGkewCtg/qcrI9h8u2d3o6LCqfsbAiU?=
 =?us-ascii?Q?h0SR4yaqs9Lu4iXCyoAiz9Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 512a8b57-097a-421e-686c-08dde1da56ba
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 00:16:43.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQ4YhiNQ28npE9TTzj95nFpc2jA5YJfEoq7l6hBzU7D5wkdVKiKHP4G6lZzvqQZ3jEsZxVnY+DM8VX0fZKfxPTqcGpqvNpBMWHF/RLjrzVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6398

This just reduce the number of modification of REG_SPI_NFI_CNFG and
REG_SPI_NFI_SECCUS_SIZE registers during dirmap operation.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 134 +++++++++++++++++++++++++---------
 1 file changed, 101 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index c41485151787..284ec5534693 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -668,7 +668,47 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(as_ctrl);
+	/* NFI reset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for reading (SPI_NFI_READ_MODE)
+	 *   - Setup reading command: FIELD_PREP(SPI_NFI_OPMODE, 6)
+	 *   - Use DMA instead of PIO for data reading
+	 *   - Use AHB bus for DMA transfer
+	 */
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 6));
+
+	/* Set number of sector will be read */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = as_ctrl->nfi_cfg.sec_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -684,7 +724,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set cust sec size */
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
 	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
 	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
@@ -711,18 +758,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set nfi read */
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 6));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_READ_MODE | SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x0);
 	if (err)
 		goto error_dma_unmap;
@@ -815,7 +850,48 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(as_ctrl);
+	/* NFI reset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/*
+	 * NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for writing (SPI_NFI_READ_MODE bit is cleared)
+	 *   - Setup writing command: FIELD_PREP(SPI_NFI_OPMODE, 3)
+	 *   - Use DMA instead of PIO for data writing
+	 */
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 3));
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be written */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = as_ctrl->nfi_cfg.sec_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -831,8 +907,16 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
-			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
+	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
+	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
@@ -857,22 +941,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_READ_MODE);
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 3));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x80);
 	if (err)
 		goto error_dma_unmap;
-- 
2.50.1


