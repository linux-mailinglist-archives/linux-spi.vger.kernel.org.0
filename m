Return-Path: <linux-spi+bounces-9471-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F3B27EF7
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 13:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269AB1C2183D
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6E1286418;
	Fri, 15 Aug 2025 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="0+M2dFvH"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023101.outbound.protection.outlook.com [52.101.72.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6232820CB;
	Fri, 15 Aug 2025 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256596; cv=fail; b=WVqQTsogSm4bPg/FK1+iy1I5g/YwNkHBUucci5rlbOLFfJrFPW8A/0IV1x+h2W8LZrkolyZKo5ZgPw0JHQQUjzraYZo2REj1YAmiEg7TrWIIMsVvsuQdSDTdGZG6kSD3v9vAm2owhFZY48hN1x0Jy3+MMfwXBbln28GQ9VipMlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256596; c=relaxed/simple;
	bh=xzy2zf7RsVLWv4UjXpjkTlH+0jjtU4PHTMMrytLuE8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGinp4ssYSTOsPQCdbmf0+YocsaqYMsQ+Lu8RlAPVmhl6JFYl06zh90NyEOCY397y5W+NETlWeWteGoxpciym54flyVA9+ZjnjV4hSQaCofdcWcbcJF4Q4tn9ErKbOqME1GaSasjV3IGpdkKVAx3KtpH5XWy2V+35GXvR6B4Vfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=0+M2dFvH; arc=fail smtp.client-ip=52.101.72.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFgKs2saWOy/5nTHGrt3DI0edMHmvS/ci6Smg8R1HJwPQbWBPS5gNFZGz7SZOM/m0lR5JeHvSmsUeHBqJydn/xw8Hqd8AfEGBZ7b+kRdwv7QiiwDxMLvrbNa0tE25z3ms24zK76SFI5Uoz9mYuAUBuPoceUUDD1q7+ra7FVsGue3eVTM5+93FyJOCKo5NUlEFID9uLwSBg+xAIuQiZIAD/zkSLgAFoxNEtrmcfTvFgek1nAvt2H9dwSXp4cWYjRBou+DKf7mkyrwja8FiAVk/QTrLgRQEMLwlUhg64E8cMpLCYJ4uL1FnmchHym3nRt+cOd4tIyu4D7mfyUqvVjo9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfxV8KENwIydT5a0Vq1/8pyIQMv+yY2Yi6hKhT5+n3U=;
 b=yREoiKwmMXioOp+JiJ+X1QnNI4lkqO+l36Fu53LEoGyRv8womHbnFB04YxwEHq0/o75916RekC3dxKmNhhTUStRdGGV9YXVKOTDNQxV7PnsRl7ZEo/lmX/wAuGoilAMDpmO/cLQc/Sa8JidkZR7Mywi1cexDELvcpR56q4pg0Zi8K00z/pswOeDtUPIlWt/ZkOG9TW+k15+X64KioQOp4aDKqPmBT+u5iMk6rw0TP+2aUjmwa/JxwKekQ/vZzgHs0DA61FvOwxCVVNL/4Or5X8dXUSb1ZwNQhhaY5Iw58X878GJ68JxAXPGNwi0j8364VgBZaIh3aBkvrjH8k24I0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfxV8KENwIydT5a0Vq1/8pyIQMv+yY2Yi6hKhT5+n3U=;
 b=0+M2dFvHkOiqUO+HNMBzx9VteddCqSMMrhENViAal05Gz0faqqzLPor6QMTA8Hp414elRLE5sqrxIYrRyo3dttaUXDO7YipWVwVw0z5UcPmi2NQVu/5DNuLQlLfsAomVVnAn96xWDgyVWjKHEzSayCBYGPCkO/i7GymmviVd8In51sna76V5BVJBbuVL9a1Et6dDDHtfStyIm6uQlPzs6y+zaGvC5yY5p7CNq0ABUW2ejk39KLEVgJV/bBnRdQtn6apf16IOTK2mxiyd4cdc+HBFUg6CrgMSA90VqM89VKkZ8D9EqZcrXCzpxPAqpbKA7Oh+P9AvdFzSnZz1DKxqAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10032.eurprd08.prod.outlook.com (2603:10a6:800:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 15 Aug
 2025 11:16:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Fri, 15 Aug 2025
 11:16:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 01/13] spi: airoha: remove unnecessary restriction length
Date: Fri, 15 Aug 2025 14:16:07 +0300
Message-ID: <20250815111619.45001-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33)
 To GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10032:EE_
X-MS-Office365-Filtering-Correlation-Id: e74d3d5e-0217-4948-dfab-08dddbed2e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/naCPXf4aynP8ewqR7dcShYhMILvfwctQ+4ctSkEA0oW7I8OwpCHBgpTpOMN?=
 =?us-ascii?Q?E4jThHsLKf62RavgsHT3X7gJDb5sjamWYX8zEe5P7pT/EO6rPDy4I3IlPUe5?=
 =?us-ascii?Q?lf8N12O/ZB9/HNHZc5ZPfXaTUATgchzzWSR5RA/L9fdblZgcVAKmkrlcHBxO?=
 =?us-ascii?Q?3U29/5YDhaD4D9cPw27N1qD9lsVA/ZWor6eJ89r7vFg6ag5Rqh+Vopn4D082?=
 =?us-ascii?Q?HP8D4D1x0yo+mgwQp8LWNnrqoIz8jMFC0i94Q0xbOnp64Bm+p/ysOvaXRdGy?=
 =?us-ascii?Q?4AUcsq6dmyg5MkRKTfC6gk5N3Q+Mp2dvdAPXuLuBMvV59SVkBdous/a4IJNi?=
 =?us-ascii?Q?YpsjXKasZc3nY8yaCM8xBjENfWKRqLScMBIRqwfPc4ONdXgMdZ4gxfqQQ4iH?=
 =?us-ascii?Q?Dw2booEFbjRwryhW/iE8+63BETfuMmKUw4LWLggHgaIAvN8ebvMagd5AtKN5?=
 =?us-ascii?Q?v14uvi4+BpSzneE/6JcdY2rzl7bBuO1WnZGWS7EsMc38IwS5YPpLsnV9tSMr?=
 =?us-ascii?Q?KfXeRhm6UiI6ebJa+7YFO7OWZ+QsT56uGKF3ky/EZtC8oJmhFGV+eBxhB79W?=
 =?us-ascii?Q?hkkStsR1mNrSgOmbwEpW+Ey/bSpVWRb4S693UjuUftyTuOC06ivu8KYOrc/A?=
 =?us-ascii?Q?ZEJXQ3Yw4lTaGP7ECaBbOeI+gcRKkjLAWS9MntanAXsPyjPpJoSsgv3Zoxhn?=
 =?us-ascii?Q?9pgWOtvYLevXU00H+GiQBUefoLvww4jcvm5zkS9yYtvq0l7ESFJ592JKzdOC?=
 =?us-ascii?Q?ip7lOumjKFa/cB4rBymhGY8TgypZb/1xvYZNQ5Oh/1zRKvc39lTqjjFx8InX?=
 =?us-ascii?Q?m05sX35HSxATwvSStnlwVUrU3o333krPb4ab4RNGx5YtHmVPfLZgX9vsTva4?=
 =?us-ascii?Q?V8HQoTLwSUaL+kR6LmczRCSi0T094YA9uvete/HzebOxtAv6k4ti5473pkAI?=
 =?us-ascii?Q?MKwHH4Y64DsVBhC2npAdICt1UQoChgUva2JvhRRwmmIXfS5OtiPjNCtTX1MX?=
 =?us-ascii?Q?Hb/q/BI5DHcPEbhvwmK5SxB++sPhDRW96LkDJfdX3c0ChNdxwRzAzKQw5K+W?=
 =?us-ascii?Q?adjYC8jSTK1XNHaDVK5fXxF8ZdwMDwmAYjVJ46hqWh8eJcZtGXXAcBNSOYL5?=
 =?us-ascii?Q?TGU0g/C6sW0a+6xb1Fmu2LASozu8Z1r3w2+aniaRuHQdRyjQXk8H5w3uE2aY?=
 =?us-ascii?Q?3JQx8nCuV5vcMFh5kbXN+Yb06SJ3A3K9t91WzoJ/oVLkPVKoER7qSbRVnnxH?=
 =?us-ascii?Q?9RH0G7BlciWu/vE+7EDb/x5G+aSQYkkh5AhU9I82TRKBWWwOWX8f3wGhhfuU?=
 =?us-ascii?Q?HwDznVuRmZPxkfIcl1QrOeHllzS8elm79pHLK+eTI+Urp7kfAuPZnguLJdBQ?=
 =?us-ascii?Q?an7l2aCpVMEfd+kTldMQRzOEd69ly/MLkLQ0aolxgUyNcAYYXkyIfvqV5g50?=
 =?us-ascii?Q?fiNbMJOHZ4pjNkBGKtG2t6jc1llyTO9FbB0EJcfV7zDym5XEnTWcuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F7MxewijA5BXQR0R/el6/KQs8lj0MhatisftqZfhNacnDX31Fe8ETU26ogRQ?=
 =?us-ascii?Q?rhflP7/5+S3d5Sp5D9n02maBJ3m7+4AomIdCmP28ndglB7l1YRZCFGKJLt4a?=
 =?us-ascii?Q?855lxkPBLVUQXYY0Duur5/wPHRSV/L6XBVOkBX/VZtupSYhacZVUngjUkeFD?=
 =?us-ascii?Q?1YcRrU77sTjZjYFJinuPRUMMAjCGgE5MHYiCjVxCP/sCbpp3I76YhUKndmzZ?=
 =?us-ascii?Q?5pWZ+Pe4JE1r/k+eXOjFlgomUmYwuAQQh/Vt/lqjhbbGklHKPbWllcxwvKDP?=
 =?us-ascii?Q?uXX8fVRXdHpcl8L0IxLk2grXFr3RRa7V4pOwySSNTntrp6zj4fMzpcT+qeu/?=
 =?us-ascii?Q?rpV1+y1g/UXP5unr15nmX6gKPmTqvwbAyuJkcFtDQEHwJvatgLxTSvVnCE4i?=
 =?us-ascii?Q?Tscp6B6Q9BUiaM2a7VqzCscoxaT2JKuKviF3yIBsEUtJhsGd6vnXy8t8kRR+?=
 =?us-ascii?Q?QGBd1Or91DBQeiGSrCdUYbGHWiZ9sNGVA+udjW656/OExMv3f4yH/DbBxgPw?=
 =?us-ascii?Q?OU2QdZD24UPKl5QEdPactq1PSyrb6/zvIBmovEzxy36fnLUzgsvhyh3nTwnB?=
 =?us-ascii?Q?okoC8kdF2kHL17X9nRAZFwBv7jYVtUa8txtRkKFqovfKUORC4MA4Adz7uFgj?=
 =?us-ascii?Q?EASBkev+Z+PH40ISG9d4AI7Uy0D3KKuRuEs+qjjpGbaFxSLntN1sR1X3oaaX?=
 =?us-ascii?Q?VdLI/9q00xrEG/wT75C/TKhxaRCjNF5+5BpNHVHp/1WUHlVhhG9IdtbBojEV?=
 =?us-ascii?Q?1FqicJT6GCaoeI9S0FbxK9V/UbHbR69ORehMCdahA1Kq6xo4/NfyoCChzxje?=
 =?us-ascii?Q?adrYPX7z+JaRp5FWvMYsuLraPLBO+doLC1hTrfxH53bh9FLUyEUXl1SJc+zH?=
 =?us-ascii?Q?Yxlvow8zJ21j5AeEf8DL+q5qxW21oi46R41YYaaSs737CN2cxrpKZRRiAknZ?=
 =?us-ascii?Q?RuDkyTVIRGIMnPy5DsFN84kvpN5HBoY/yIgECMp9aQQ8YP1/gjiZVsI4AGis?=
 =?us-ascii?Q?fj7a23bBMBgboJPFTr7MNTrtnO+kyND1jt6Kjvd4vlKcF+/OkTY19xI+n1Tl?=
 =?us-ascii?Q?xvYRLmLXgu6VHGbQssrG1yF8LsaugMJilz3YwHhf/m2nzLdC6fsJLJPvdMw1?=
 =?us-ascii?Q?wPlCllOhRX2BLvnKuhJtsCj8Cjzdq3IATfw5UKAvgjJp++uEjvAKN7SDADMt?=
 =?us-ascii?Q?BmVQG2BMlqmPBRygUAbNCUAsxmFPHfBv5UoaczRAPkTdTOuYW/HkSrLxALXB?=
 =?us-ascii?Q?JeYS0IJrCk3KW6pq/nZ4YHSQOhZBtin1d+J9zUmp3OnC/h0gK3dqJ/+7AFe9?=
 =?us-ascii?Q?4tdS2kawwpCEbMd1nX13nX0Bf4cJ5u3xsdef0xEnaiJ8VDHvs4Ev2rYmJYN2?=
 =?us-ascii?Q?JCf2jkEzL493DBSWYaxFy1v2Ece3/goXz/eZR2DQfJJd0Fcw/C7seZI1ckfd?=
 =?us-ascii?Q?VwOkj5HNlfnGTAWRhfcF925oO0x9DXoGytjRZsPwPwyua3IpWdB4qzTJ0yVx?=
 =?us-ascii?Q?B/dhXmaVdyWyayHOyUw6EOYPK4OwVJa9NXIdfpaAjVWQYxTE+zCR3wND5nDR?=
 =?us-ascii?Q?xm86XPdlG9CwEB/Mirk+EZLajEmLd0bLnwdgJ+d3Y9HAlig1zn2a/K1DmIyF?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e74d3d5e-0217-4948-dfab-08dddbed2e07
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:16:28.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mKjqTUQ3+SpGexwdFXnHB+Uguns0aJd7mIixBWm8iARxOyJ2C/3wP1GFHycupQYT/tmZQhXIjTNaY0cYOBzwDkubnCM4MDl/N+0olal710=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10032

The "length < 160" restriction is not needed because airoha_snand_write_data()
and airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..09dbbca8bd2b 100644
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


