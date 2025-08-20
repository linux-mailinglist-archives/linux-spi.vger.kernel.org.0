Return-Path: <linux-spi+bounces-9548-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F236B2DC92
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6AFB7B117A
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0931DE8AE;
	Wed, 20 Aug 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="F6n/zuCR"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020141.outbound.protection.outlook.com [52.101.84.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069AF30AAA9;
	Wed, 20 Aug 2025 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693209; cv=fail; b=t4RW1qEYZ9D6DJ9SNf7GOeflg0ri7B+ajrovknthIymIqt7iVWq7OFlWsj85jxoTNBw/h9pUXXqFlj40L+Y1fsn1mRnDqqTeZLuN0lHTDxWFrPA3ySeMF0jAZWSeMK24K+zI3TnPMcLmqSpzqGZJnJ8S7JOUvJILcuVlSGxl7/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693209; c=relaxed/simple;
	bh=yfVgRyVAlRoU3SzK1GEy9nQvaGLglKASwFFrlb9QsS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LpVowofSKCnI5+3lyKlc6Hkksp+CI7ZFjI5FB1eM7X6eIMDtRb0rzQ7D5mx4GoBJvTQYHJ+0lNv9tqp4VzbRbV2Wfucjvl2ekU7McCMRySCPyLZ3YfoPsEX7nOs+buPtD2UoUZbl6e0WN0N5YfK3eQ7UIxgMA8ZIno6NcGnaLQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=F6n/zuCR; arc=fail smtp.client-ip=52.101.84.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtsGUmiUHAqZguWd0EptVGQ116ybLqvyZT4qiBRseHFcc36VO9FwTpUaW//C7ZL5EBKROYkCtjIuIPCEiCxcpjv6mMqqXr1myQnY38JCQOSZ0Wl3Tm06ZP8Tp051WUPw/r4zuv2UNzaYn9BI+dA96OBjiQrKPk2M5NndgJkkwaJE+Bj8T9I6wU6TlX/lHlbbqsUcWB1+RDWgdb9EkBJopEsX/K1kiPMxKdHdhAOnIzKooVj5uI20X5WHE9zmYcUSgojDawt5CH4CV2lr1t07/3m+UwwlGvpdhhtjTr3b0pGcttS/5ES/izI82RWpwkuzX+GRtFfF4hFMNBtx5GD25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afEq9bHX/2s3KBTTklyPlyvAIAF9EeHEPeuOYA/bDc0=;
 b=m6CO6nRIdrUpH7MB6GQbIPc4pjsxiTCh3QYn8YwDBK3zXhXp2LBkYRZ0YKLAeB6XeJz9whb9td5Q6VdVbWXwXXKpk0CXS3DI/LQSI0Otg/g0fD/IIYNE7cBRFo5wpqydvOo3sPR6r1wfaFNuIAjkdMO8tQtAKkoiqZE69qS7X/M6knai8nU4T6Vkb/uqLfPkLp4OvkB27FOZ1ZkINZ4mV/I830dgz3iXhf6Amxs34Z/rgAUisLU1CKTdKvuL9dyLKvLdrBfJ5zJNaVciSjxC2SBoH/irV/u7IBkIJ32PRXpCrJyFhohnPltQVX4hqEWNoLWVR4rbNPkBRUlJPfoqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afEq9bHX/2s3KBTTklyPlyvAIAF9EeHEPeuOYA/bDc0=;
 b=F6n/zuCRaI1UV5bM6AfTDUsqV1RQxitFOWUjIeTcKxHGbLJyxaPqeFRuVmw0JVqoahLXV6/1K2Uv4uRsHeh8w3ZxYTSg/KHvzXP6vsUZPUcdmAmKlLZQsFFS0bOfZkAyJySXg7HP3mNqhQMCrYVzMcBC4TBeFvCjV+auA5WuDS83Iwi0/5PWJgbNo2SuwqEDap0yfwv5NOk2yFN6xVVSEFokecfdXoUi8J+f2V+pcpJdTlCwL0r0ntVpL49NE3C4nxLlZkHb3rDzozFCWb+oFQnkYvtA54hjxxW4LxGT9rlcCNpPFEyDX1TD1pqD7KvnROrj9oCEAvK96weBls1+Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6355.eurprd08.prod.outlook.com (2603:10a6:20b:363::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 01/14] spi: airoha: return an error for continuous mode dirmap creation cases
Date: Wed, 20 Aug 2025 15:33:04 +0300
Message-ID: <20250820123317.728148-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 6187583d-3b27-4d6e-5ff4-08dddfe5c1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PSKCpeNNL41cUq64A+k4tlgi1LX7ETSlbvue/vau+DxcEkXvoWrEavGiDlQC?=
 =?us-ascii?Q?EDqbwI7Qfi6/bephpwWCr/lvggHCMtrZzd8nTC+aPrC40+DatDBpr/Ej57bG?=
 =?us-ascii?Q?vxbwMXPbg+aBcxk91OMALH5cr3+F53YtKrD7aA2wpht41ig8cDYY0hg2/b4g?=
 =?us-ascii?Q?OjQ9S/My5keeKn7OQWAtEXQDDIy9Avg8B/gs9q3ZXXBl//90B7z5uoLetgZA?=
 =?us-ascii?Q?hoC3iqKZ5b/l8X7N+JYaJLSAQMtm8qMgEf0JCmMkapRj9Np8wIEFATXGmZ9L?=
 =?us-ascii?Q?1+wP/WGHXJ4Rnuam9Rth2GkPuap5ElMIWBB6nGbGmpGSZcum4U+Hc6hP8KTH?=
 =?us-ascii?Q?zgrWUHD0vD2Fu6S66KZjjR/5TzKWTYRMwBQrnmol9VlkEwxbOyAAPp5XGJAM?=
 =?us-ascii?Q?F5h/98Nla7266Q4Yz1+hIOzjAmIHL2t7Hevz7hCg0MMBzBnuBhlDKHxhhLnF?=
 =?us-ascii?Q?A1khCs7/rmeyMoncy77nDZ5CuVKe6Z1T+qkRx1eOCmI4RIOLyxk/cL5Hglb4?=
 =?us-ascii?Q?DUe2vtxOMtmh8A0eYBvvbOobqMmuTinuInGqW14PQrQjoENlIQ2Gr7LB89Zd?=
 =?us-ascii?Q?Arn/cGG75YSbBQule3o+8vJ3JGMd4Dingbv4/63kERUe++EIsM8L46qttPDR?=
 =?us-ascii?Q?G7HqdqB0nFaLuLTK1hn8ydzB+XQvumVJNIVbiJ1ehsZBCxLSBfMXylaZwefA?=
 =?us-ascii?Q?z6jqUXqn0Fkr+qV1CKUHjyebmMvOPG87lT0duy8RDGFx9OxIpoZ4oB4efp2s?=
 =?us-ascii?Q?Gi6wu7PQqoi404lW8AzTsaI+1h42XxoqJCPGScK4MbXfaNDSs0AeXuFRQbuN?=
 =?us-ascii?Q?u0mTFumBQAIp0tBG+icLxyu3r5d9Cyp7cBSbqjZ+QfVfVFjNJnd6dn1PtgEa?=
 =?us-ascii?Q?3aJn9MCcuznRMT6O7v6Zkgz6ZA9fGF5XQIJSS1mbnP4jWJE0MreFjQ2ePAEG?=
 =?us-ascii?Q?s0JsIFb8ETKuZ2vZMnjlE7PC4Qo/6GNLkaMN0iGmf09zaq7ANOxjpYH/Wx6x?=
 =?us-ascii?Q?VAZqm4XxXyRW55t9GOiBd8kAFJ2C+IlMKjRvU/m6N2z2BJlFfOaU/lScWkPv?=
 =?us-ascii?Q?4kNWIlwt2CE8thTy+/+KWcYYY3dGhD94Ff0lFEG44LHWuZIyaNgOQ3PiP4jx?=
 =?us-ascii?Q?39qU0wMUJil+LPNCsRWEsEqhmOVB5sRA11CMT7qdNjVdcfaTSmlZhGAcsnPl?=
 =?us-ascii?Q?oZDP/th6ePkA+PyMPMwjubvutorPctWBTlXgF1yKdRYWPxhDLbCckFqVHzHg?=
 =?us-ascii?Q?szo+k5xpQtzsvgLHJXz6rFys66LJOFdRzRTPTw+2VtPpCwjyd6VddrGyX3UD?=
 =?us-ascii?Q?foH2gOy5AXToq5zK1g1T2fTSOpPszGlRDFEm6ZVHeSPUJYpVK8qnb/Y+o/uZ?=
 =?us-ascii?Q?meEQ+yhvkRm79N1sTGbDDpmVXtD3tkbFF1RMrazfbetPXaCWmnubH6itg8k0?=
 =?us-ascii?Q?XuoO5CTkPbGtZIt3Usbz5NW3qgw3nPrUO/uN00DKEwvlAyoazOQxYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gc9A8skn4uob7+Gyy6kJvlcLZeOi8wPPk+2DQTPJ0w1RsqrHS76v1a22f6We?=
 =?us-ascii?Q?sr9xylY1d84Si1uzmvB+EVhVEK7eFgk9YjVoNT8N12+CxqAciSO1ZxI6+mFT?=
 =?us-ascii?Q?bSxDy3pPnHy8WIhH/tjFn563yzWnc9+wOhLrQrawiBA5/Povuvn0IfqZz77y?=
 =?us-ascii?Q?rynv0l//67Z02+za7JVc2Sp3tZqLBmzGH62jxTObJMusQdGfEBl2Mu6kJSRO?=
 =?us-ascii?Q?wi3V5jDcOXkCfs3ktYHLZwAafZhNz0r/SDEircjCsTRJbDn8abpd8twb/mM0?=
 =?us-ascii?Q?6YjENjHtodEVYS/52sGHGR3xC37m8OmWkMiHlpnHSlJC7Q5UG5jbm5zH7EsC?=
 =?us-ascii?Q?wgoIpPjYa/CIjJedADcVKSJdsap2jCn3IQ8pejtdH7VOnahEt5BNgZTaNjwZ?=
 =?us-ascii?Q?4UjXHuQo8S6XEEetRfUZWvljVyysKZB/4tkonCWHGWi7ok3KsQD1Y+nWanV9?=
 =?us-ascii?Q?jDk48knx//sv5sRabApqfDdscTdUzgDIzQylhCfiPzmBY02K4bvDEfIFPHQm?=
 =?us-ascii?Q?N0jrNpkzYRBsS6SQXlqVoIHOdLQczVW+B2JutIiBnYVdX2gtpAECMYB1R+lW?=
 =?us-ascii?Q?4oNujlKl3qGlvT5zIo4tg3uOZ5dlv78e/8oRHvx8cEHvjWPJGgFyZQ1RrQZm?=
 =?us-ascii?Q?IRvOGGIamb5FUXFcBptmkKuD2PyPjtcK4pi/lUHDzwk5pbBWoIj54PerLIZP?=
 =?us-ascii?Q?RJKPemRpsGnPpwpj3jBbVX5KSXWjW16Ht8kNcc1WJzKRs2JXicDJafoyVgJP?=
 =?us-ascii?Q?qOcHTOoW64hF7KTvJiHMnCq5B8IPWcGoXFHc0RInaXWORGrbH6AgLs6hb5ZA?=
 =?us-ascii?Q?2O1wba72l8Yobnk1Q4ga78Et6UfmK6XQhC1eTZBmfhJ+7cKbnXjHWp6lGX36?=
 =?us-ascii?Q?pnsUCT3gWoPYfi+zNp+kt+DMM1Z9Hz/Li57P2c4Cc8eVUQmUA6CTpxNe3BpG?=
 =?us-ascii?Q?zQ4tRj/1u+FLkZssvO5hDHAsH5q41U6mOcHT3Q7/9Nd+TKlYfD8tVZGM7t5l?=
 =?us-ascii?Q?nn/2iqQa3XIDUDwpw9Hg5mrXFSiO+V8l78tIzrNksKC6+jshQ829dFYB726T?=
 =?us-ascii?Q?pJcGj+DQAOcMRpWNzxobZZg+MNRHW4ZokJjyGl1hssI7qL1PaxHBvcSLSLEG?=
 =?us-ascii?Q?VKUqRDzrQ7odSFa8NIkte24TApfLP+JvKAu4S9OADpbkfchlnOMS5/vgxiAe?=
 =?us-ascii?Q?6CD2q8WNS/mfShuqcYcSEhJ0mndC5iDksOE4/SdpdzOi+cZ+0X8B/suIHLgd?=
 =?us-ascii?Q?0rAfWhcBlbJ4sHFlrpKQj3mdTJBKUeSm+AnfMRvhtKsWLuF7Wpe5L79CSb5L?=
 =?us-ascii?Q?NCT8OZbkigrojWvmp6jeaF8CMdYfHta/shDiSfMrIeCH+4cZszCFeGEZpJae?=
 =?us-ascii?Q?Fc9ERFvnuURYgFexSz4NEkYmOltpqsVqE1WOLJRrRpEh7UJWl5IcmRR8/HeL?=
 =?us-ascii?Q?mkMeL/NdhHQBs6mJUEDnf/yfLeX3/h5Fzft81N7tO8pPIA85u/8PC/t0DM/E?=
 =?us-ascii?Q?zS53GqRtTRAtPWzewTbuqK7jBIvgOaUhLyLzbROjtrecra4DEGzZVCMoZIhI?=
 =?us-ascii?Q?uaoa1s2O/7Q9TnKfwCcTIsNrB0oKA271lEYC40rok0uPw6ywTP0iVFMZXOwc?=
 =?us-ascii?Q?dCoq8lHG3omdFtrgT6ywRZY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6187583d-3b27-4d6e-5ff4-08dddfe5c1e9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:25.2245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Exl4e2KlfRx4BO+not1DsLOZjijtcpjpY1yLlqLhMOGrLvKmH8TYX0ubV+zvwsrE6+9hr+ppXh7zApMkIn2AxCVJ0FTg/951Dpx3lb6oc1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6355

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..043a03cd90a1 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -618,6 +618,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.50.1


