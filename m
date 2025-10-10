Return-Path: <linux-spi+bounces-10535-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3132BCE592
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DF4543F58
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63085301703;
	Fri, 10 Oct 2025 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="l6YY75I0"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023129.outbound.protection.outlook.com [40.107.162.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002D3016EA;
	Fri, 10 Oct 2025 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124059; cv=fail; b=QS+9USD+TSQkbRyH+Ney+/o/Ei+vX6bp4nnHJYfDHukXiJ9PBNhBOMlB3y0iiAPQtJbRzdA4T0jicBR0A305/K5EAqNCRozJQNWjj5xot+IhIFnyEvKstORK4MOLBH7PUs8QI5mkle8lRcXOj4bVyNWrAnCKgHJlKVh1Hm9iJQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124059; c=relaxed/simple;
	bh=E2M8lRG6zN/Y5R2EJPWZ8XXbtiAD084miYqnGi5jqec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dh4QcBRc53Tr8EcewdFvVmfOMPFhzkb90EvP88tw15CIrRbUxgQqgIs/3geNdaaryACIpZgvz9L6qOF5rGx6pxaLCSSsbQiLcV/lhOLL8dGTy3YFAkWD3xkXp5GoKQtu5FyuPiTK+PtjIHvCzGHOGVMDxVAGHCqOzuxLI/q6kRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=l6YY75I0; arc=fail smtp.client-ip=40.107.162.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0tbJEHfvqYwo3ZokOqKJseTS0+oQayb+ML0rzOMw+nXqcl2qY6BszlzwpHBPG4HsuN++qa9BtvgGhdQM0txnDFTekDmgCh+e8dcGv7kLP7oXiQo3r1V8ql5FLnJLLp5fCm7KV70UxBoMpNQISdmFMC1MXBKMwDgaSVIzlgqq9og22NKNAm0Yi4Z+Qcuqoym409V41XQCN6xBNYDTWGgwtEu/z+nxr+rklQGqbBV5mNmLOeJmEhI6kMeneuq+dqinjkSoYxvevO4qLx77hmRaGN+JybEINE40l6qJvid1fSDswlZl2R+9jRGs5NBbyPjzI1buedFeFu0dbya1BKQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2snrpNrzRAzTOeqpJ8KPLiTOapJVIgdfhM9IUrv732o=;
 b=ASJKMEBHrffPmmAg5pkc+qtH8xSdqer5DLdSrsV7wszTMgOnpZTghEaACsjQYvAF5XexsOln8mooFXJC+LUAqRVtZDvRvaHz7vkpWZX07vEw7bZ61clyQ5EBlumRaxObzRegnc6271jnUspvkV5C1EEiIDW+uJ2Rh4KhOFl+xRMdQYBvXXsL/MpvygJqVymqVsjjTFvsaIq0sx9KbPmQb0RjNnDfBirnB+SWuCpunPINM05+NImBwKa8ADD26uazSbLkg67dlUo46RXxuso1LhS789Tqym1zyaeWQ7cy+lsvUA83L3CcHNTGR7oRaiJ7kefVGTXR5xDBcUWKHOXEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2snrpNrzRAzTOeqpJ8KPLiTOapJVIgdfhM9IUrv732o=;
 b=l6YY75I00/wsKeVfrfKT4BMz3D/0Ql5wAP0MnjgbzGdoRx8Qc41JFhkqwuxN74s117nw1mk160diOtawuOm35mB8qM2M4XJeVhQ3/vUlaqw/b5U9u3UYHPiBpRRUdX48M8ncYijEPasj2KzED3rqwx+aByzvYQsLj6mSUZanxublKOHVKq1XwGgDKtjUQW84KTb8JGT/UjuY8OwnDIeosAw+1bndkyP/PljIM0FPNE5OyopBZTVw1qmJAYxwfWHuYM2BZx4FvNQh7qJXX4iNSPXuFE94LqAgTN8agOzb9anw+onJXl51iSG9JJhD3WvMMbwf1WFGQwQiSI0cp9NzXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBAPR08MB5784.eurprd08.prod.outlook.com (2603:10a6:10:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:20:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:20:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v8 05/15] spi: airoha: switch back to non-dma mode in the case of error
Date: Fri, 10 Oct 2025 22:20:28 +0300
Message-ID: <20251010192038.1592889-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010185940.GA715991-robh@kernel.org>
 <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBAPR08MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edaa4d6-427b-4159-fe22-08de0832214e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W2iSJpv3Jf7cDkMrwKbDMB5luVAxNaF2p0/KzImfCbjnIWxi6vS6J7/OMOIr?=
 =?us-ascii?Q?UfSPzPRiGIqvJGA5l5j2yckrPj/UNT1M4cc1UMUAetMB1KokX5CnUTytOU//?=
 =?us-ascii?Q?YVuDo8ueg8HEXwkJBvB5QEbDP44bSnBiv7SzQSEnq5EktzuZqjHhT90hAvwv?=
 =?us-ascii?Q?ZtlFEbcTuOKU9x2yiLJ6zhky1bT4fnQPKyNtkmDofKaqy/aoaeRsHfA47AeF?=
 =?us-ascii?Q?U/I3E5vM3195feQokWWwY6Runo5R9oV+/ta9+vhYTIoZBxYM64RhkN866FnY?=
 =?us-ascii?Q?5lo2gu3pEHrc64DF0D6ZeasvNmWxNtf3q9Bo3E95FndSlZ1wKoDnghwJGcik?=
 =?us-ascii?Q?tVRjIXOCZaTmY24vBFnxfECafvax0hi9UNyQJzZ2FmPfRx+4Lo0sBAx/F+Cu?=
 =?us-ascii?Q?WhN/qWhdzL5Xp8EUp87UqN8dYdMpnaK0ZhIMj68AyoEoPJg1/C2Ocg5giQi6?=
 =?us-ascii?Q?3VKtWn3bLNxSgHMbvo5EHiROEOh4/2xcKN5XOImZUHK/NSAqL/uJ5B/F2eaf?=
 =?us-ascii?Q?cLsAO4aOuLZpBRO3CBkOkyUjWkic9eePIIf/NEWtEBjPmbJFglNooMlIPPlT?=
 =?us-ascii?Q?E/72LnAbkXa+Qxc2UA4jeqsNWwyij2jrTgSmbM0Jq128QGknyzCiuOSgeRQc?=
 =?us-ascii?Q?r0P7kAl+Qd4iGSvTc4Z4fFEa9nFE1OWhHl7LX7uBx8AsfJKHBxvRej8KJJNv?=
 =?us-ascii?Q?yFRdsWR53hZq2YI4BzxW5VCBZQCS2sf8LoyYgErtt6mFw/2r9wpsW/ZCjgx3?=
 =?us-ascii?Q?o0MDRNen3RLq7EdSzQ6jIapXKX3HeRlVXB1f7PQoPrc7sUGrAv+yGAkMHBKf?=
 =?us-ascii?Q?XBPKep57QsiKThCDcfL8q7CwKrdhueJ1RQQaSSOl4QnO31bvKJXXcG2FrOPz?=
 =?us-ascii?Q?iMxfgMni6kkX9t9r8mQhUdx3meLn4NQBlMYuefFCJO/AR+pi1e1uV84Af37G?=
 =?us-ascii?Q?xry1/7dLnTLVXUFHvOEbfCbB9jgF3+8d9Bqa6kzDh8zBQHeYHcLTJzvTHw3m?=
 =?us-ascii?Q?RjBWylOb/uUU1g7KEjD/uGvON0pUQB3dU8zKOYlvL5DE1RxciMkqUNe2ecm8?=
 =?us-ascii?Q?2iJ4+g83sMtFDA8l1/7i1j/JN4HQB0hVRqyCDJu2SA9sHUr1WqOZihJ8o88n?=
 =?us-ascii?Q?dIfXL7yrKixtvsZ5KVABNk3vYswzipdyMYyqpApIFBWJZ8DosUCLm4tI/lwA?=
 =?us-ascii?Q?VnN+2AlTOFiFM+AjPTRrw28v1gb4oo5H1JCvbreWkpKQjAxQ++1+MqFJkGbR?=
 =?us-ascii?Q?7Te1RF6N46wSjCBXQJQJbQdJtOtGgkTlnjI5mgnHm0JxAhmCtVr5Jh9lnRMB?=
 =?us-ascii?Q?Vv8DI3ZZVPrIq8OLkiGlfiWwPzOxVDfnYLbmeSo7c5Bd05I7dZg/dpQTSym3?=
 =?us-ascii?Q?fets5CopWPlkKLs6FLcMS4ELXzFFJ89pBgHR/6AkJwhMLj1UCMXkX0C0cbBw?=
 =?us-ascii?Q?Sp63vvfIeFm1nRM0uYrcSYSsYQs9sonEH3kwYmEykceTJLG/SQj3y2yJ6VEX?=
 =?us-ascii?Q?QwloQ4SuZoSWSoVKNObqirn3OOg2syEJWHmtUJOtMS/xh7JpT4oTmhuFIA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RaBAO+Vky6g3U+TdUI8wSVpa8mI3yDT80/DJVaEqm2FgvHKXPg8DLPX6fRhK?=
 =?us-ascii?Q?H2A+0tzRqKRlZ4odzF/A13Mosg4Cl/hexxiRQv3noS6ld1/hs56KLluU2cPu?=
 =?us-ascii?Q?TQGXbtArX10ggXA44sUk9ByMjKvDcWNalx4wattBZ5HsBlUT2nfScblKWEAB?=
 =?us-ascii?Q?V/4T1R0rbTn9tiCy1ksG2zb42bSTf+P+QtAqaLeYVxRCOIOUXObv9lnFllPf?=
 =?us-ascii?Q?RkGL5sEXY5Et20kDYe5/8nsWKzgV9NXtcGcHKHkLiq0HScmiN+mwQffeqq7D?=
 =?us-ascii?Q?UC9Jyuh5DrIw2+wQb839B0Na/p7DpdPVXEGQ2uFceQA6sfePN1lK+fV+pGIP?=
 =?us-ascii?Q?S5TxOjT8eZyTavUJNoox7mhoG/xY3OJXbkfkh+07WXrfo5kEfuSIoQYgxcdU?=
 =?us-ascii?Q?XhF7/eSTIT8B8jBM3pcIuE7l2jGjy28ZwafF61HEFoYSTCxoNDbA9HTDUwKy?=
 =?us-ascii?Q?gEK53kDgxTmr/iTSOtaMapiOvsdZZCIjJDsbvf2w4bCT2V3innrpQmaxsxDk?=
 =?us-ascii?Q?90h/g+UIDdp8ovTfX7M4KyHh8KCt1Ed8QDxcqQ0h8IiPkzlVrZxNnElxI+cd?=
 =?us-ascii?Q?qmb/ey75h5LVi9UmRYgO6YMajiqS3twJhuJoA7aqLUNV0IiENg2hz75EGVBc?=
 =?us-ascii?Q?i2bQWysOPVR5WiAjwN8dvFutX2HHPZGDKySpxtzod7lF0UJgwSYvlf0jhRz3?=
 =?us-ascii?Q?9xf46SedVmVZ0p3oyoF5R4Y17RgouYJ8D32ju8IuzJK2JRLvypctxNvlRupt?=
 =?us-ascii?Q?MAaDWF66TXwFjrdNTN49yi15ovtcJs4CbAbReckRjji/4aJqGKMR8J1I9UJH?=
 =?us-ascii?Q?zxDyO0s0TmhciZ2/7Q/z7Hge0CX+x61/+DOeQFbj4wYuZn2LB6a9BbtSP5zX?=
 =?us-ascii?Q?77t+0AjpAp/Is9Qmz/z67OHDEoaGuailSMIdEIWR4zkxkY3tgKFs5zXiMjx7?=
 =?us-ascii?Q?I+kHSG/H/o1tmoai58Kf7RQIVRrJKVFaARAKNv5XdvlHefQp+WX/i25AnoGd?=
 =?us-ascii?Q?MsHcaYnk8OzQtro6Wr3eaqrUtZg0VwFXy4xnV2+B7KrYWTW3YGBfyFDeDty+?=
 =?us-ascii?Q?UffP7l7dWrbIxodiYpvBUx81gTIQuj3WviUhbZDQSdsqR0S9HxY0V2YvnfJs?=
 =?us-ascii?Q?jtqO6ImXlizkeYAVmo6t6bsLBqNEa0v4sP6cE3tKpSm6iMiGV69WO0w9YnDo?=
 =?us-ascii?Q?jXMQrI+IxkiyLuMxiO3QS/bwfJs+X0qx+L3ejn0IoE3A+oUVmwxy60EJ6rCN?=
 =?us-ascii?Q?Sq4lfzNQyRfT32mJ5ANDHmhgJCIlduNlyIvjTGSp/QZXH1LAqe0AE2M17s9/?=
 =?us-ascii?Q?bz9uQ+reDtibvb8d7NE4sHYoigzp3KmgxwCyoYL2PiF/SZliz2D/j4oclmPj?=
 =?us-ascii?Q?J5wLnBf4ONJ+tZRryjR0suR1p/v3TS3pni3fNAzTjc8U+1nUbqz/Hrqq2g0O?=
 =?us-ascii?Q?dUIPJxShDX5Uw/9Lojpjx96X59E3hXCf0D4a3iwokUkjF5RGkDF9/f7nhZsL?=
 =?us-ascii?Q?5A+S9afN8Eu//HuYy1Xgf0LJHh1itc7M9VfMJsO4plrfZi+WOx4yue3PNny2?=
 =?us-ascii?Q?n95ZipVeZzMejtH4TWDOVL6WEFrcdu7H0ViyQtlRO3HPaHKu5Sjywi0INZIn?=
 =?us-ascii?Q?nTydmgHAJPFyHtKz4COJg6Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edaa4d6-427b-4159-fe22-08de0832214e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:20:53.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaypKDutP/83JHqKA75Q+dMv/l9dtUZwOmY9H1Nu+PsKv7R197C324Ti1kMgBVFOmicbZFfzvW4EO5gR8DTpplgoi+If3XiNqVNe1KVDp5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5784

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


