Return-Path: <linux-spi+bounces-9619-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14893B325A8
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BBD1BA89C1
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979F917BD6;
	Sat, 23 Aug 2025 00:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Us1wJEzw"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022114.outbound.protection.outlook.com [52.101.66.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE314AD20;
	Sat, 23 Aug 2025 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908210; cv=fail; b=kL1qYcg3MeIROETd5aQ1Ege2vE29eQhr75X2MXiPmfMdw+1IBJ4Dg1PGGpSZxukWTQ1wMZ/RRrvCV1KBH/aK8y0ODYdBCE9HqXzJgEPLrNgPs4PG0SIBLWl0193WqMbYCrZ9eU35OgOfY87uaGloN/fQVEZfjOCDrdvUjh0xhIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908210; c=relaxed/simple;
	bh=qa6RHbuyyGQnb5Dt967UgRh25JIBiDgCXxuYUJkPiDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxoyPwywYKFKQ5SvZjnWGt09zAEj6XlWa8DGcAcQF0ur98kxTDwwoixF85QqbPBceHp5LSsulLdFRlYlYVJbNMEbE8UZHVGeyzZ3wqEWs8D+nDKvG9N86zEWKpY50rYbJUTJ++bh7OvIqmN1d+2MsnB8EcVB9VS3xptK5g0ODwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Us1wJEzw; arc=fail smtp.client-ip=52.101.66.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgAf0vPPNObPV7aSue1X3cLrYwubtt7L/tJOlwlSNEUL94WILDw+lwgTFxCOjv5nOJ0YGIR2D2w/emmkYi4FCi4SAY0mwk7cksSTq8UnZDt+8jqm3wsVKU3ZpZAo5yDYJcLsHdQPA9wKBoCFH4gytftOGMTHP3FUziKVLZs2XhEcenitwY4eKYM/7Ifn0Kg5EkszOFkOGGjJNf5s37F5c4HcOvq0ZQs5it2ChpZc/gPIIQ3BzFWWitqVpLmjwXp0cOuN1Apu7vMg1Qf+arBhoezQsJuPM39a0V6ljO3mn2siy/SuXow5Oh8mRVGzkrDe2rflN0i9i6MDjdbh0JIH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5s+arZLdnwIjppaVlO0b0WF/pjyzo1UQaNmEWX7BTs=;
 b=fDnw4ity+2vHTcRPBJ7qtLYcUsHBiXCEuEhSG90GuguvK41J+TohAszFZ2Z2yQ7/fYhHhw0fh3yDO2sDlo2jIgyO7xC+qcxZGjb8ZRn+BQS/KmVbO+r+eenbLXpXcJ7Z2z8o9SL/eNvSOrNoZCgDwfZXNYp1nwbv2M130yedm48PzfGSZ5YPC+uIWIU22Rv3ZiA6jr8kcJN1ttc+nuMAJR0i8vXfIFkHbejOg1ABF2N4bHI8KPn/tYQO0EJSuoXuvggRni89pkxWugXrpizJzmZS3IAyqRdGCNOuLT+NI0+FPGTmOrSq8OiEIT4wZ/gIPL5EqSwrKSJWwvU73SR1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5s+arZLdnwIjppaVlO0b0WF/pjyzo1UQaNmEWX7BTs=;
 b=Us1wJEzwDA6xDnYzf5Q9EZITl/P+XP5T+wropztobIhT7w1UnUe/Fs4uKGrKjQaICoPkMQiIHZdKSQYRoUWwnl5g0oGudGWafH/Bu5/8OXHqvlXOONh7MBCsJyBN6jvj07fIOQAL+RXkorjXXqhni5aXST1nYU2TLdenh3ix+/ntqjev27mxp3iooF8WG0mefZ6JE7acXVr8kne8mzv+3J9VpynNJvvblRPA55pCY6PFVzL0JDoiw2/sxb8XROscjRmpUie1dC+h7k6jaID8NsF/I3nYxCPyaCTMEjeck075M/62FvjCWh5TjsOtwjHqyEaTavYWhFo3EtAhjK1sUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6398.eurprd08.prod.outlook.com (2603:10a6:102:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 00:16:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 00:16:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 09/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Sat, 23 Aug 2025 03:16:21 +0300
Message-ID: <20250823001626.3641935-10-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 92914ff2-43bf-4eb9-2f6d-08dde1da5631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w7b7skSw8w46MfHBUuItbcARytQjNv5LLN5isI0sWfQ7IJW3XzA1//SCREV1?=
 =?us-ascii?Q?FhdOVArm2uH7sCpDQpkFXCiS0BMLUjzsT6MOfstiLiTqbHddLoPMspmznZSw?=
 =?us-ascii?Q?bJ1p//i6wEB7kZwJdIBuGu5r1dhLs+bQkuZ1sbHofsJC+6g+MpOtAjHjmY12?=
 =?us-ascii?Q?+ym0fghx/a2NeSZm1po+DAw0AwTjdcYvvHKV0eeCuHou/1Y5+TmwA5nF0D8A?=
 =?us-ascii?Q?UHWfKqaWm4ff387+wJ3ZCqEGmXV0pUfbZrrVdjR9R7EY9ttb74LR88BLbbr4?=
 =?us-ascii?Q?3CtOmHP93eEpd5CDpEWQY95CMoNO6+0W193J+xpVX1DLfemHCUGqqMtpS2OX?=
 =?us-ascii?Q?ql0CvP8RQL6FuPFUCpyAXUsaoNP3pw+7kxWz+m4uTPJcD6eO7LpmU5GCGe7K?=
 =?us-ascii?Q?iZOAMlVA62Pc8XUr3/cwRT+QTkkd72uMlFsm6Nem/9GfNGQqOqslDn+IUlUa?=
 =?us-ascii?Q?g+a7XlneET9YA6TPn4bWm2wYwx08AmfRYchcbMUwl9CDq7j+aE6/2mIWiVZJ?=
 =?us-ascii?Q?MfEQaPDuhk6m77vYbSzNyCqbOWariltNzMgRm0lK/2OVjBRa1Jgg1hoAOI4o?=
 =?us-ascii?Q?LlzXvEoIWIeMEWC1QVBrMfLupzixDGarTeJuLTJ0HMr528GzAkTszV7boOIH?=
 =?us-ascii?Q?Gim+EgG4XMlanQLal8V0RwnLBzYQrcOShx2LS43aUVpEcoRfIbShL64H4ZtQ?=
 =?us-ascii?Q?RlxUwDPXcl9jrgt/zXkNOJycU8AP2wNouK1Yu4ZYtu8sUi6YWG5CFiIVuOnj?=
 =?us-ascii?Q?qMvyRTyYHPg2MmUL6h6ONRHeIYg9qMXA/otzmlUAVRTGd+mB3vsaj+hm2Jtz?=
 =?us-ascii?Q?nJGjrlsx7L61SbeiItukyKtFnFAuw20ktwy19FhvTO+LxtlsRDE4zqcbMCrC?=
 =?us-ascii?Q?x5mC1EUHIAqCQu4LfU9L3h3GscFQkM71O9Wpei8WMZYL67ThKbefuZiEWM9r?=
 =?us-ascii?Q?oFCxvCjex3aBdr9A2PbTjcsOOSlSYAVubxtUT6e1h3jbEFCq1bK/1TcWQn2g?=
 =?us-ascii?Q?2I6jlAOPa+Sav10ZOIUcng6T915Kxb14EVkk8ag9+IVYu6UGb/MS73pptWlH?=
 =?us-ascii?Q?ppmHvSmbXFfyVRIZk6wRE2UyY1IpINUusZIFdic+KR8w983jqxapgIlgOo+d?=
 =?us-ascii?Q?VfjcWhY7uedkWMM09iB83hzKgZRAYZr0/uCd9/7r8RFtw4dumzBfVes+SANU?=
 =?us-ascii?Q?LWGVHeih17PQHHJ72wV18HLS9ReQlSdFtLuB5wZrKTH/jSW/tJ9/tDehLa5/?=
 =?us-ascii?Q?CJk7hyyutfm88ZqtkQgkrgXhZiaHqJ3TpTQA56QhmKGhjP+SP+bUW0DbkuuV?=
 =?us-ascii?Q?p9JkqP9400xcKwfRj5uedyZHs+ATLyMfb6/G8TbLuHpUsuqagqfrPv0KbEv9?=
 =?us-ascii?Q?WezhG6Fudy2OrivNVxN57iX79pFyqyQ3igtmohrcthhev0UHFtZklfS9ZLB9?=
 =?us-ascii?Q?l/FoINajeDXXdX9WtiLQPcn40HOarrO6vGmk/W6Haow+MSg7nYZamw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8DS1FYLnpfR+VircU74uN76+oArMPFLDKNO3la/xyQD9e61EyC+8OJhqDM2d?=
 =?us-ascii?Q?TvF1kaNjVT6hwYyByvLhoBDzjW6zsaX2LA/wAwKw+oTLNpg1xnC6bH40coNF?=
 =?us-ascii?Q?5jJgK4SJHmRnKFOkB0MEhcXWSCJUPKEftxvggLiUXyamevXaIleTyUjo/zUM?=
 =?us-ascii?Q?Yho6M1enC1WiHKSEWRn80BG15FOHaTP3cdtyl9FxtXvWG3FCdWUUnV/1Rk3g?=
 =?us-ascii?Q?iHFoyTWwZnjj6bulR0SLmWTNoHAdXxRlSEyQKLxE1xjAluBmk4YRvr8uz8am?=
 =?us-ascii?Q?uSIwu+bcWCgyHfseAmQu/LKPCE5TGRpE/R2361vcWJQwDhZv3LdyMmnMjFCZ?=
 =?us-ascii?Q?+tCPBla/sm4ZtNp6x8DYn4Fy9fsyHmhVev/TDT4EiVSBsgFIyWMlxQ0UA5GE?=
 =?us-ascii?Q?r2sCzMN89x1kB6jKj39611YobH+/q/LAn5ytvYUlE0NY9B5cTI6SoswSGhNp?=
 =?us-ascii?Q?ZX51o+ir6atscifA+GFRMe/XnW4rfLzw+I929lTkdvzWQB7GJ7rD35goWsXP?=
 =?us-ascii?Q?N0bJ826MbD1HP9KaUlVdg+/UAUnA27yrCegw3OqIAYT16HoIaN+uWiUOnxY3?=
 =?us-ascii?Q?t1Z4JcDVe/5K1enlFqB4mSMgBU+ilTGWr29z23Qf9nynZrvuOJWlUsjEWpsa?=
 =?us-ascii?Q?ka0O0VfGNNOEh3rtxGbjbG27W4CKT+PTFWVJFBERWeCO6YrQvP9cgd3KWduP?=
 =?us-ascii?Q?lW8eg9touAJDJepn9qgdelELPlC9eKliwSBzLLbSAtK8foEffd0RWkyqC8FG?=
 =?us-ascii?Q?3GJ2HWUJWUMDck1KOMyKuVlTYbmdIH0YkewFzLImNULXV2JQ+qvXs4IuhL8d?=
 =?us-ascii?Q?rrD9vEqZ2ZeeR26YuIUII35mCn6DeGj7OdULux7Joxx0PxHTeLWTXFtmwTZi?=
 =?us-ascii?Q?LNdnHKIyYsmHqZv+p3Q4TM8KHdCmArymDaBkw/jKy9mG2TdEpR5CJjZFzwKd?=
 =?us-ascii?Q?foXBV348fLuxMXVExr+Srhq075VJWV8M4hgdMdMdQJe2JOIBYTM2b6sK0qHU?=
 =?us-ascii?Q?15uAcoYoiZFAjleoCEQts/RG2yplSkRPRhhK7ut93MjbysPKDh+F7E7vZT0t?=
 =?us-ascii?Q?xkfOamDn38v5f8hYy0e4s/FpV+0bFpcHr4egPoyjxfMI94LelXwLrx0eIvQ0?=
 =?us-ascii?Q?5u4kDlzAOnt0mWAfManZx+3/5yO1OQ8CtwJFGNt1wlMVY+peZyR3s4XbIDZx?=
 =?us-ascii?Q?HgMs61lEiEidxX1ZUriPjfApUpTCWUBXB3N7DuBA1n/k9mol3DRBrZlODGW4?=
 =?us-ascii?Q?Z+N3CGePLW+i7yUYeRwHRdSM96VudJ/0UPgnwZbpCcckXz5b2/3hnT2XSMyD?=
 =?us-ascii?Q?z7mBSgpnWf87bmVxA4PB1qD92f68CFAsHqP2iwLdOxw4nftlrYGxsKO6a2Dl?=
 =?us-ascii?Q?Cvi7IWr6FOMbOq6QgSOu2kaBLOWDU2WNxekh26+gNTNfFzv1yoOvGMEHS/9O?=
 =?us-ascii?Q?x6ETHYVh4nI8aLvtmEj0kfClnHy0RGW8HWW9ZMptwbsHWMicRndbBquX0iVA?=
 =?us-ascii?Q?N2L5zyr7UfsCam3pzBQIE0sZnJ4cLAmPWRO9skv/ug05whdU69Y1EgYgHXYk?=
 =?us-ascii?Q?Pzt/VpgRxgBl4x0kBTZ9gYpARcsWLWOp30NUYEHXOk33yq1e99sjhIl7RhRx?=
 =?us-ascii?Q?4s15ocauFG1hgg1Cmnk4aTQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 92914ff2-43bf-4eb9-2f6d-08dde1da5631
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 00:16:42.3230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkIg1tbbj1t/lbdevv0HggJKiR0Efrf05tBfd9ti0kvfMhc7ljBseA9H/sFAoXMz+VOWEs/SwhkR8snDCMLqW1ILjYHt0RHZigDoXu7Dr3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6398

spi-airoha-snfi uses custom sector size in REG_SPI_NFI_SECCUS_SIZE
register, so setting of page/oob sizes in REG_SPI_NFI_PAGEFMT is not
required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 -----------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 4587147f9cd3..c41485151787 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -518,44 +518,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 	if (err)
 		return err;
 
-	/* page format */
-	switch (as_ctrl->nfi_cfg.spare_size) {
-	case 26:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
-		break;
-	case 27:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x2);
-		break;
-	case 28:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x3);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_SPARE_SIZE, val);
-	if (err)
-		return err;
-
-	switch (as_ctrl->nfi_cfg.page_size) {
-	case 2048:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
-		break;
-	case 4096:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x2);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_PAGE_SIZE, val);
-	if (err)
-		return err;
-
 	/* sec num */
 	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-- 
2.50.1


