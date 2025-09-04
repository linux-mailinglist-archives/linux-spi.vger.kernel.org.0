Return-Path: <linux-spi+bounces-9897-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FE2B43E9A
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 206F17B365F
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E359A3081C2;
	Thu,  4 Sep 2025 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="oYSak+4I"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021104.outbound.protection.outlook.com [40.107.130.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870F306D47;
	Thu,  4 Sep 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995839; cv=fail; b=U5rOhh9RoDRtOOtm98Rfp+pQ7zH42zulPU46lDwF3KKv9w2gEQZrgl08+XTsQrQxG9aAo/NZbcmaUqdxLzkVMxcaT336c8N8CMue/kuBTcPdcpZI2RB1n133zWE1Hty4aYIn1NXXuuRW65Nk8n4fYyWnb8Gc2yzR16CoiEW/RdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995839; c=relaxed/simple;
	bh=6wRPZ3JsQPvCRfH1SlYXJi0fdIPN3xQwBEBeQgxM1Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nNDDzmSrP+R1Xw+n7M9SnzBsMAcy3Tgz8n768hQ3AfV29FiDHJsCx5aWCyt7ArrQ6yb0Uxi0vpzsLA6jFIXhKMjlCpSbJlDpTtd67/2HRWlldQsYMWqTayFtOqT1kQ1nr4HSLvww1VkoxJevJvQNrmyyrLPCT87rP89fZ9SdhwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=oYSak+4I; arc=fail smtp.client-ip=40.107.130.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKNFhVma52+uaymNonvezKTLyRNCckZXW7+1u0cTlpvAGeq/wPglce6tehAqaGuCJl/bBk6i/QaOL4PVCnV41x07HffKeCnMON4ajnLbVb6yQNoYDqJ2OYWDEr81q8tNdNfkEiRXGbz8FBwttIElHkQczJACNUobT66QoyJ6yZPjf5SHW8tlN7FmrXNUg3HnUDBAM+KR58qhd27fljCkf2/rqDZX12sasUz8XPuImZxZCJeqMFlN2SlxRISIYJB1sgn3IObQ94g9dzGyCM4IE4wtpYp0b0PZ2HPmobt9D1LbkAKOv16JE9T3KadbpKt6wYYvhP7vFHsA3G3KRpKS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dARcHoCM4HyMpVSyowxjeXYn0ojHi6T9vKH/YSmCFB4=;
 b=CXos9Xi3J1pI1AqyX+YrhPCITLcF6n8EGwf8KtNJ3AkQ7R7D6qebV1GLIsAV1/t4Xu8AgoOqdP/O8J/xrjvimmqA+/M9h71i+VDiE/OCXAIULl19OFNV7QvusIWBk/UN430ab5OPHUH3C88eCuKfpmYuallwUOU63fLs3EM/PeiFiB/n4TKu99QaYLtYaAWglWIkV72a9k5UUgNz4JDWANaz/DwrDU9taE9NsI0H2lDS4c59TC1QTbH8/t+Ok+i4GJzofjoP+cODjycFiKLQUlEipW1ACMmN7XDDBoyMwoH0yZ1RcudAIPL8pmKaklxWXUEnFMCFit6t68aKbL71uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dARcHoCM4HyMpVSyowxjeXYn0ojHi6T9vKH/YSmCFB4=;
 b=oYSak+4IQrik7UjtnYZOfvED4PqOJqUo54R3D8oaPqYw2fwzL4IBWXNT38MXOuSw3m5GejjiyTKDpdTyNW3bVYJdQxDFWpOnjT4z2cVQ6yQC2YGP+x7DCP2fsqKUTD4gz/9XzyCtG8lPisV6Bbc+RUYaSpVMHqOe8wJxBTnsIKIL7MzhIVdtmN/65DOaf+loc4LgeXuTOSHofRLSWBLqvUUOscm4Q5aFyUaIi+52JJYco9yXoFTFTUksasJ/p2JTeEHAHbZmePPrtyDqeG3C6NZumQ9J9XovqCSkpi9c6nsVVNXbpCFl1zZEVs4t+LS9Hct2pU6fHBGNG68sD5lt4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB8992.eurprd08.prod.outlook.com (2603:10a6:102:325::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:23:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:23:50 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 02/13] spi: airoha: remove unnecessary restriction length
Date: Thu,  4 Sep 2025 17:23:28 +0300
Message-ID: <20250904142339.656346-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 108c947c-848c-4a8b-9fd9-08ddebbeaac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FKKEw3DleSLRzQHE0e+6kXxYVF5Z+LTVhtCUxPnfpUOBbgVdu0Ha2lsI6wte?=
 =?us-ascii?Q?yFyZnIg3UPo1TOfZaejuaIWNRSkNZ6lj4rLHzYR5w99z5bBfrXa+sHvVV4HQ?=
 =?us-ascii?Q?UUAfOPPscCS0ZGTYF/UgMb24vA1yQMtcG6HXH14YCzpYfBM2BNw140jXFG0x?=
 =?us-ascii?Q?4Jy3mA+SGMDrau7X3P8n/3JhybzVNGDU1EtPUqVNPsLmoLehHxWw+xE1Wx3H?=
 =?us-ascii?Q?VRkr4Jx9Kw/HxV6KZxGq0iSJpITpIxGF4P11BG/qGGjusBaVOpb5WThdq/nP?=
 =?us-ascii?Q?SP/wyyWUBAiG7iqEzu0htBGNIRfsaTpZDVdF8lSvZrU0MfxYg1OImigkEoYz?=
 =?us-ascii?Q?34ODPP9m5l6nLoZbaDT8nhmHeODH+ymYRzxu1t5Z6pK5M2RmDQkSn9YRfCr1?=
 =?us-ascii?Q?g9zA1pxT73qER6740iQSaepkXlva66vJbHbGTvTwQ3o1FZHceWICQZnCEYxq?=
 =?us-ascii?Q?isUuZer8CSMMzSKVKb8vsotHqFRnOkg4PlFbVeJU2FqUNYWm1fA4ZQUkQTZ9?=
 =?us-ascii?Q?3lNDAc3XCGuJhqLYelcsruKpdN6amPl0Y+acmNpmKUsPwwAV/1nrPizz3YE6?=
 =?us-ascii?Q?z7rsmaAmRL2UGPj1drDB11O2o59MhSEdQEDFbIIzm6cEXXgwVess37nt7Cbw?=
 =?us-ascii?Q?57roMuxXY4OY6lkIImz6Go/hQPHYhku79O2SP1zkm+eyvzELn2X/dy0WPupR?=
 =?us-ascii?Q?hp5AUxpbIQGXmZgr3vggjAsfttnEGu4SuTDpJSz0/m55dHiWXoOIzVPkGpbK?=
 =?us-ascii?Q?BnVUv5L3RvLxsslCUabNA7j0M5VpCMYcHqTGleD6JW5r6ZRSMMNjssY5fHBB?=
 =?us-ascii?Q?hrPyjihd0aPuL5pkNZ9tk9d5NEyi39E77VrC1iwXK79gnYTjuNbLai+/Ndey?=
 =?us-ascii?Q?FIZWFYtMsFzcHuhwHvfOON2VUc6g41gYpaNxh3Wj27+jjEigAYep50i4cB6K?=
 =?us-ascii?Q?m8KZbaSOIs2ZVWbLmywEJdRbvoHqCK6pSP2BzWBMDmiD4r4U1Cjdvmsya9Fg?=
 =?us-ascii?Q?jYWKniam8EHRBglXRWP5yMHKL1bjyqAvYHWXZAF2W9JwdFSzrGyvFcyZT1V9?=
 =?us-ascii?Q?QF4mutgeovjcYywKmGGPDpfkkQv4vaMy15/U+JZsloXQijULHa5aLzcRIW2y?=
 =?us-ascii?Q?mx1dtMSKOGmtftlWTLRNXmQWcL9/i+mJkZ2mKKoayMVHWQS4gqEq/iNnkXZt?=
 =?us-ascii?Q?cnH4f6FI8BFWnLmS2AMX5A4oecsd1vAIV7RGg+lOdEHNeVjWfBU82yK3cLo8?=
 =?us-ascii?Q?3b/Zl1jWZrIlv+Ck+EkqgTvN8pZgrsJJ9gYun18P7vst7wE3UYmMs+ewX5Di?=
 =?us-ascii?Q?TIioO8rTqz1nzCMGBwQ+KQXVI8RSmzw++4fuQ4+k77NbAz8HjrF1fL0zT/78?=
 =?us-ascii?Q?USXwuceOgoK6VBZFssItNCTukmBvljEKh6j6i/hZ/JKy8EX0FUcKU4XJ7Voo?=
 =?us-ascii?Q?ibNKrhrZqMQiITFArUHjDOZVuhOeA53ENSh4yCiF12/L5jWt0MTo8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qaB979OEQTAkKy0945yfkw9mv+0ArSkJ+kw9+BRAs8rRjtg97fCB5Sagd4X3?=
 =?us-ascii?Q?lKiOTP85cTu5qFaa7UaX8qAkaqPj06qgnYzOxx4zwhKGfzJFbFpVEMM3IGfP?=
 =?us-ascii?Q?iOL94m2/ngqHFGQklktkMB2qu/lR7r/Uc+Dr4BUF+JztNjs0ODqmNAcLdkE1?=
 =?us-ascii?Q?B8n51iTh/7gneBZQyOO7GqRe1sACbtEV8FLgD2ZQa4FyX510OasM3K68RT2u?=
 =?us-ascii?Q?Y9R//CG849IUwStOgfrfBUGAAR0441cJDHBHqkFbdv5aWOwyuB1MnbTZobT+?=
 =?us-ascii?Q?oK3gMwtZ/OAG8EY7tpvUBoae20FJtQLClkThhKvtSF89KA6uGgCbsIWYspBH?=
 =?us-ascii?Q?B5z1zxDb9XErI+ecdwSX1gMm7RkF0bR926XT8DZDXn5Eo9OUltjilw39dEUu?=
 =?us-ascii?Q?G7I3vV7wslTwhy7LriNJ78GU1cWW0btExhToAP7vkVTr+l7oxEHQxAWdYekw?=
 =?us-ascii?Q?yPXUBRrOvl6wJXs8n/vcHtkHvsfYLUepgbZA8xaie+cv28ND/3jNwbl0LJi4?=
 =?us-ascii?Q?1qInbTo+SIQPcwYvFraPVdpzAP/NAtz/dkMq466RC467UHeGq4xhnbrmiV/O?=
 =?us-ascii?Q?2J267HolNcJSbZiXM2mRb7sraWoHteuP2UJkNbi6EjSHguQ3Xn9RIfxiYkr4?=
 =?us-ascii?Q?Bim026v/euFmLcJRLdMlcKEY0dM5we+OnpFQquDP+rHo8NIw4vB5WYxu4v7W?=
 =?us-ascii?Q?Yd8Sr1LJaufzDmrU7lJUAw419hOIba7ebdCSQ8sbvnwiY6Vsy9LCNng2iAee?=
 =?us-ascii?Q?48+eS1RzGVQnNIya4cLXR3wjQUqozCypP2QdtmfkpBBjX1PYsdYft8VX48p9?=
 =?us-ascii?Q?N+IWeQtX0au2rmsD0R3ZyozRoCXlqiCH5R/YIUrxVtCiFBQIgrUlur0Ew80X?=
 =?us-ascii?Q?7TB54QY6ge6/pzyiKgurkgxhymcLdQZJt5QMZABteixJodwl4FYX9jVikulw?=
 =?us-ascii?Q?MeaHTvPrSWQwS/x917wdAzxLHVNJ9r/Qe9qb7ZN3cevqg8NwuaxZlRakLKfd?=
 =?us-ascii?Q?Dejmd/uswIymwaoDqT8fNbJaXvoeZm+9JGwGYG/da7SG5RyCUK067o7fnLLb?=
 =?us-ascii?Q?qgPsq33ziNvuAyEgMmkqqMOKSSbNpx79NYPwHawdUcf28KNALn/I6icgTIkD?=
 =?us-ascii?Q?u7j+rwqcvrtMPwanOd1n6CuvilhPx0p/z8rMCR19nA4lCTKi3hRfmTcSvavA?=
 =?us-ascii?Q?sPae8CEa1Pg0SmmGQaAckvgtAUsehtj2l1BDcugLxTtui6Uj0na+eSO0l2wS?=
 =?us-ascii?Q?phD6/xYWOraidCGB8yMoVdmaA5jLdqDZ15A6jbGUK6aPwudpy7p9bHvp0vXO?=
 =?us-ascii?Q?MABaB4n8x3E5d6InJhOUAVUwBRChVOpyjWX8o2VB5n53oStE2uaAXL9AJ4fT?=
 =?us-ascii?Q?IC7/JTa3zfHRjPXeixDqGmaMugJjWWzLUiQ49lszpxytk2Gmvg5datkb6dRv?=
 =?us-ascii?Q?4POpHlmJ30eibDM83jgC6vctpOfbD9BLuBc/4GximTWNOaDJdgqKcn7u0mrI?=
 =?us-ascii?Q?dZEZKfLZmbR9JcwLX2SRJIurI1YM/HM0i+uq8Mboi8QISwgQbn2ols0YpDH/?=
 =?us-ascii?Q?sVFlh+ksc73GnslUbOPpDhBSow/H3vEE3mbwSciNtj2ViD/Y5Z+kDUU9wzQp?=
 =?us-ascii?Q?4feMuuhAVoT2cLWOhp5/UuM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 108c947c-848c-4a8b-9fd9-08ddebbeaac0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:23:50.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0vPGtTkwcc6nsHCoPlffQCg5fU5f5R9QCV0fi+cEbGu9uvxNj5oyAS0nxm4ykaGN4HwB49rpCTzxWWh23q2J722f4IB/wUKxRMtOJDUIm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8992

The "length < 160" restriction is not needed because airoha_snand_write_data()
and airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 043a03cd90a1..bcc464ec9c61 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -579,13 +579,6 @@ static int airoha_snand_adjust_op_size(struct spi_mem *mem,
 
 		if (op->data.nbytes > max_len)
 			op->data.nbytes = max_len;
-	} else {
-		max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-		if (max_len >= 160)
-			return -EOPNOTSUPP;
-
-		if (op->data.nbytes > 160 - max_len)
-			op->data.nbytes = 160 - max_len;
 	}
 
 	return 0;
-- 
2.50.1


