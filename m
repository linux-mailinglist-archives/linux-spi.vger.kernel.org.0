Return-Path: <linux-spi+bounces-9467-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC89B27AD3
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 10:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3384F4E468F
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D0C2472A3;
	Fri, 15 Aug 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Egqc7YSa"
X-Original-To: linux-spi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013064.outbound.protection.outlook.com [40.107.44.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34167241103;
	Fri, 15 Aug 2025 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246099; cv=fail; b=OIYh8nNbklmxY8rrTNJWrmku4ArjzelPWdHlBeSy+SiX7ZSbwnlPqJsSPh8zeHcdnVHmelan7IDA1mp1D4ewL62Lp2sOLmQ06HE9bdcRr8rUeIEOJttE36GvUDwSPxv/quxxGGB/FM0zEKYmD9Kl2y+dDbPeDJQDhvoEvcbt/+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246099; c=relaxed/simple;
	bh=qWte67QXAWHIcx1gkRSilhH9PSBR5R08Bz63nXLdp+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GQSZ9RxSlBlNicXrUJbxLeR4kyWvRDO5wc+Ak8XBCY/Lv2HLqBVZbVRtcOyEUXUeAt2FsARn5nj6kTpoEsem+dEWUNr+LukfGTOqW6u7gz2tILHmjsNljmsYhNn9C5f3rMBf6PJn1ygukSK+0Gb9/e0qDe4tdJbV08HxqaDI0Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Egqc7YSa; arc=fail smtp.client-ip=40.107.44.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMp6m24KRT8xBy77fumdYJTnh5BsEN6Rb/v40EA3e7NR4cYW5MsNpOZdXDZF7ipT2lUMq7TunwsGFeodeVUOP0UYDqeEqgxIjEYPMpBljA9hT2ggqvUhjj8kjHYuQM81Q75Dx1NQDP+bf01HN8qwTIcNmVPET9iTfDlnGH8ovaX00g4Ib8rqfPJhRdb1BlP9qIL0yVQQSuBa9sYdQGiNLxRRCp1B/BRDB92nKZ3fLOU71FDIFFw3FBNvYtm/I3QI2r8ivAd2pR0DhMW3H3KhW68gSRNDFbu1FD3NC5+3PweiPbyRsGiylM3SiYPcmDQkA0OoE3MMvETe2psEFiuayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOkTYPOpD9rmd4obtS2nuGkNzqC/tM5ZD0fW181CQng=;
 b=zVTDAdpUJPcSHvYaMQLsnmzJ9mNPspw9KwzgzqXfqsf99kFXtZjqH0oPA4BxPqjGHrw2btPPHLCUVhLLDEHUA4kzpV9+ed1MJjXkr+tPgQjh5FiQhaptF8uk+Qjrw/Na/NSTFdQIF6oqM7Us45Dm4lXIme/599ZoED7dG+PP35UF1Kd7XgsnbQqG8goqzds8s+6Fl+NQNaTklvpc1tg3tEI8n2iuIuuEKychLrzm+MZtaoLZCx1PIvPA2lJMTe/3O1aDxB7pJcLpKVqS3SIL0NGA2+d7cBB2t8LA02h9s1+TpbY0sbQXi7IhPO0RljsUIAaGt31q1z1XWEX2pumpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOkTYPOpD9rmd4obtS2nuGkNzqC/tM5ZD0fW181CQng=;
 b=Egqc7YSa8ekvwZfWIl1bz5Y7CCS/l4czC+591hTYZl9EHAudSv/tfPbAh6GGChYefb1sCZ1+iGJONRiYRyyWffQ5hc5Li65RzAiDqpcCAyuGC2UH98TbbGWDRh4hoX9U4pmHUmY2nrfeJB6FckvNvmrUxOen8FvCnTaX4KAy0obEQ6TbWej5EaM8QBX+RE0K/rfz8JHVaWnASXQSO2ZE/04ufXJASaF1LwubrOKr4rO/cNzIw29Kr4HMqEcu0QnI+y+OmrnT75hgnV5L6wk7rPXVkENROs6T3yh2qD/SZKMaltWw0cVzxAtlytKgtkeyFbecOzRVaKK81vxWg9xy/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB7169.apcprd06.prod.outlook.com (2603:1096:405:b7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Fri, 15 Aug 2025 08:21:35 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:21:35 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Mark Brown <broonie@kernel.org>,
	openbmc@lists.ozlabs.org (moderated list:ARM/NUVOTON NPCM ARCHITECTURE),
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 2/3] spi: npcm-fiu: use min_t() to improve code
Date: Fri, 15 Aug 2025 16:21:16 +0800
Message-Id: <20250815082118.586422-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815082118.586422-1-rongqianfeng@vivo.com>
References: <20250815082118.586422-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2888fb-7a19-43ca-c813-08dddbd4bf73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AhSab2M70vWem7yBKHQvEBXlvmm/Xx/P3reobtyWCsUafFtHZCOSEeWpQccg?=
 =?us-ascii?Q?YONBOR6h6/6xIfRtSH59U7sTl7kbMEvsT8gh8sXxFrKlYElnyKL2lRIDUMsm?=
 =?us-ascii?Q?cpvZ7U67gCRDGRkBiaorN5qSHchYnkVtcUozm2Grf2kHy+XO9Qzy4RsPsYgP?=
 =?us-ascii?Q?YMPCZ+jsojaHrxAHO1cfhAXdNAj7AEVFHxmE62jEAjnQycDZEr7drcNfmH8q?=
 =?us-ascii?Q?A6q66rwiWB0JQt4yTArFIu1ro3m/rKvU56IoeFBm3i2r5DUvaAvxfOUXt1t4?=
 =?us-ascii?Q?PW7mlOcuWPVoYK454J7JADsEhbqb9d3Gy7cf7CbQhsAIhIDZNZSDD06W4Hz5?=
 =?us-ascii?Q?PsLa8PjYMNtRgVPd6Oh9NqPcDpFN96ZrVnd+zCD0zvNmAzHFx7QfUQV3swao?=
 =?us-ascii?Q?LrplHzKosM/Fg2YudiV0iLrcM2mZZ5QXsNVvtOU22nsGtPr53XUshS6ALVmt?=
 =?us-ascii?Q?bXjuN5diG/vzsPa7IMd2EA2XNdOmhfSlfLSKt96dD1naOzJaDwviK7KYZblT?=
 =?us-ascii?Q?tjuRsFosKTbzmICUyV9umfLmcVPsB4yn09HLIIZwWzhf+Mkc4qTxD0d/pTqm?=
 =?us-ascii?Q?+lYUvG1UBE6IXVPw7WxYla2ZlmduP2XA1NfV/kOP9p/UwPmdOx532Pfujyi7?=
 =?us-ascii?Q?hIpClX8WnEd9pIwhUhoZFREx2VYIBs38pn3dh0PCAWXoVr5eDJ/+qlhLCaYh?=
 =?us-ascii?Q?agpThyC8PW82+41Zc0Ko3ybrFfTr22VzVq/SQznM6qswFyOY8u8KJESzb37T?=
 =?us-ascii?Q?v5adu3M8XwS5EeyxUv7gMgNb/pfb8PInn3cQCiosGa+LV75WMtOTk2kSHO1I?=
 =?us-ascii?Q?1qOcbnHC4LMgEwMx1MYB905cC3tFsYrQow4fbh53XuugbxvOH9Tb6vcBcRVq?=
 =?us-ascii?Q?ps4OOxyj6cw8v64ESyds+HiIAhgtWrhCRiqSJEbI7vuvvyFKaWN61D9NdmpE?=
 =?us-ascii?Q?7aYmD1cAjDyB6QT76GJl3lmb9ND3l5rqRrkq/bxxWCkqEBU1uLRGBgKyp0O9?=
 =?us-ascii?Q?f8ln05CGXowo/jeCy8ZUEwWQFbj+RZK+vwXN9vSeCawhTUAWZyniWeSH/RV6?=
 =?us-ascii?Q?hZki23iTaLdlOEypWFL0bKwPOS282PlClvdZcHWHQuXvncRfl3jjflSYZ/Wu?=
 =?us-ascii?Q?jwXHITZkeEofMjBN1yvvZ2gUW5N4N9cr2VbyiBeA6rk4RdHM38RQsROI6gxe?=
 =?us-ascii?Q?1YRbZ3oYx+cPvbLol2I9yU1RISe8JOppQWz2u+g7fhDBzuhHmu5QowkvXBv4?=
 =?us-ascii?Q?HSZfEUNqSquaf+ZmnuiXKT0EuMv78p6Tb/hVy50Z6CAFPeKrVAUAmalyQV8j?=
 =?us-ascii?Q?ps3TCgIAOv8lET1ijKBgd0RjvThJnAU2HMPSNikjVYBYxJ9W/fmpcxDKuXCX?=
 =?us-ascii?Q?vnJqfiALlzwlCshwIYoWbh0zYJsJq7DGO2LOtrqWnEJvJt+txt5OCcjXjx1y?=
 =?us-ascii?Q?H/Qy455zjiWys8apKBq5M9s6raaXNurMsYZaETpPRZctefjdbZnG7c+4fLBB?=
 =?us-ascii?Q?iUrwoKvhAenRcMk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U0CK+Ni+AHR9DfZy30u1lSg25QORCX6NPjUByuoEVq5rgaMYxD4xZxP2mAJv?=
 =?us-ascii?Q?36JhxYhWlBS+0HNdjuo11hPumwfgHNCBYmTWq9+JRUFW1+5fg3fCrNaNUHei?=
 =?us-ascii?Q?Oj6s0Ku4fLDqQaZ+lfPr41OFW9jsVRawa1IfFwyG6Xdmf/YcU6C033mLfQ2t?=
 =?us-ascii?Q?6YKNg7+2GjwG51Lg4haROi4xWuitzragVI0iBOX1NJuiF0tV+tn5ai+83E/s?=
 =?us-ascii?Q?zgmO1qeZ6AwVFgM3U+uBgi78D3+DzTyuZ33TwI3ENwqfGzAlZCNgvYXMwm6l?=
 =?us-ascii?Q?Kmvs4C9SLBc0Czf9zEaGRd/MJEygxxLjqgTBC4VHuINTL08JtoiB8KMhfm5L?=
 =?us-ascii?Q?hQ7oIHLKQthKpwwigAF8fwJG4hrActCy3cR3TpnarWkPtudqmnhgOQzW+qKM?=
 =?us-ascii?Q?5rHfezbWIs6Uy6ub3zLEAFPPiegmMWRCn2G9pxLLAmltr0v03BYgA3dxnOOv?=
 =?us-ascii?Q?bfze41pnk1F8t9+ylCZ1DYscn8zYgB9QrzxRiNuJVRuSqldW8yjwt1gwIR3A?=
 =?us-ascii?Q?UO9H18cEe8F+NL/pDH+O/q7a6zHuMEhfzyYOLsIdz30VcjxwuSkyc2rj0fQ1?=
 =?us-ascii?Q?BQX+H4YHKjinBD4NrHT3C7AZUt2bTaIMdWkfcy2kH1KAgppig9OGGdGh88in?=
 =?us-ascii?Q?jBcE4EMYxDgKu2nEDdb/nCXQw3mcDQFPbeMjvfv6o15s/Do9ea8WPvqqdovq?=
 =?us-ascii?Q?9fZivcBSlTakPyoLOV9yNszRmAElZZSQRQL/hnvIW2MlnvP554IY42vSeRYt?=
 =?us-ascii?Q?638vGKXyFzy3ZDm5vhsu8izPNBlPs8fQKTaOU5wl7axyvVNax9JDtrD89Bbf?=
 =?us-ascii?Q?DYMIxNihR9/v8NrZ9maeUz2CVtJq9qPs9O07QRENHABwLjslDejl9Y0DwtK9?=
 =?us-ascii?Q?Wh9NXTYAg+5k3yNb0yTrCU2/QqKu7UFHUICCnN6Uo3rZAKdejgI7fhd2KZzx?=
 =?us-ascii?Q?qzzb+WgtF3evNjtFeak5Buq5++mlDzRHCvPY8AtTFTWvcyH0a6Qgr6MHP4UB?=
 =?us-ascii?Q?kVMmP29ANg/tzqGwKZ4g/CRP28f0duRyPGxcWLRi3NyWzGrkRek5zF90DumG?=
 =?us-ascii?Q?350OYi1moVPmfTq44Ufr7LqawJXerWp6/A11+wxCnMeUitkw7wCOu6IYhc4X?=
 =?us-ascii?Q?bO0fzXKhrB+lrg9NevW049fhgvssppYOwDtxiNNOJD352S6DCxb9rAvCg6L3?=
 =?us-ascii?Q?cAEC8Ck/29HbKe4anDPAAzGvcN8byVx3Rd07hyhBMuBJyVeewB0m4bmQt3Uh?=
 =?us-ascii?Q?iFbaFoady7rZRrSYRcT2FVoSFKeXG0xn+dcubAJ/7/H17pkTmJ23liiDK5m5?=
 =?us-ascii?Q?yAfjUaMoTVXEEvo8swKrZe2zm04OetfqaowQ28PykKmHqAlaOSuudSFwpZYq?=
 =?us-ascii?Q?7teH3HBg3FmhewtzxqiuL2y3P4jWRA+PPSPFMr6yzyjJteltfVOXno0XxHgt?=
 =?us-ascii?Q?gPLZccyt1zM/K81fkpibaIWVL4SqbAJY39wXxQh75BOQ175/O7qbTUCcGTf3?=
 =?us-ascii?Q?iZIl1SLt7AtBjT0JyXWGH3NglMxdYHwyD4KT/2FkKZPMgGW3a8Znc1beIj4c?=
 =?us-ascii?Q?mw4ytPiWw7LXkelbZ4v+1hFb64fK1tM1Jfn1ny/3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2888fb-7a19-43ca-c813-08dddbd4bf73
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:21:34.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYwEBi+kBKjOUq/QNtprCyNNun5KQmFfeNefKSDAYsW11N2C7rXMUDqneoa771N7fb+F3H2SHxbGSOc9CBAiYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7169

Use min_t() to reduce the code in npcm_fiu_read() and improve its
readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/spi/spi-npcm-fiu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 67cc1d86de42..cccd17f24775 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -13,6 +13,7 @@
 #include <linux/vmalloc.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/minmax.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/mfd/syscon.h>
 
@@ -498,10 +499,7 @@ static int npcm_fiu_read(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	do {
 		addr = ((u32)op->addr.val + i);
-		if (currlen < 16)
-			readlen = currlen;
-		else
-			readlen = 16;
+		readlen = min_t(int, currlen, 16);
 
 		buf_ptr = data + i;
 		ret = npcm_fiu_uma_read(mem, op, addr, true, buf_ptr,
-- 
2.34.1


