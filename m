Return-Path: <linux-spi+bounces-7586-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABAAA89163
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA1A175748
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4F17C220;
	Tue, 15 Apr 2025 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="KKgLHljV"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010006.outbound.protection.outlook.com [52.101.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA90C60DCF;
	Tue, 15 Apr 2025 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680882; cv=fail; b=ETJK5Qa4Ovvbxl5wcXD4XhI883lec10UXiU/UTRdj3gBYkzpBoW/NDLz8O14BnnA5iGOMxjsZpE3Za1Lx4qPOAjuDlIYhKoortA1qD6ppsX58Xcb1QXNCVq5SbhJppBVduXh2zVJrEAjvzRFO4WGxaVSvqQBK6LjXvQK30Irfgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680882; c=relaxed/simple;
	bh=SOFobm56Cvo9O+fPsupaMweri68gmY2Fnv1f4i5tYpc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=shwKLT/DrwWgxj8WjFF+tpWL9JeCL28r93CfFHZu/+s6bUkKuB56vGriNTFkg3/ZZPhHohq/c6zeE61qzjVQuFR630zjg70TAS9EOdwKrnN8AzZA7BqarT1cX4DJ7zZaGltDpprvzZm7gXPSL5jExD5lx0HN4Ozl8t1fKQW1BhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=KKgLHljV; arc=fail smtp.client-ip=52.101.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHf6bMAxeKxP3LuLPjWQWOy7HwSWD8BoYd3HWbTL/NLGerzrwQ6eh9d6e+CwGbI3veS/JeR6YIAf2nC3AQ7Q+3Nwyk9XjwenauIpDz2Gr+tYfhEVfBpD3+e8FsPlbcGHKSINIDxKhSFFQREEt6ZHLTEf8sCsRb3HO9xGLaFETYeyasooA/ir9huoTL8wvSNwYuMHASz2PUbmoHpjzc4auQYseb0wtEX2f8Wha8Z7nwCIcRJrODlZrV2e1y0WIKGZg2gHTt3j517WsTRWuWbQXtXfGa6QSU5rWhkDtPDYhuicjDvOByKhu12mpvKENHJ63OgTF+WPLNJVtOw7YJMJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATQRfMgNPZefPwyniI+aWhOYpjOeFi8eCA0KdcFn7LU=;
 b=KvKPrmthr/SePklP/M4G9YUcOJUGD/nR2o9INqyFbjkCJgC5SjtiFMYcy4oOS8RvC0WtOfCuVMa01IYED3GC3aMsZ0PsP08A1JnnjGybw43Y/nIVIMY2fk2t5c+E1ePNXpJlRruR9P6a9+3jMbExv+/0qcqgvaTEUY/HKwB4qCiY8rUcwo2UF8JRUGDJ4TcsA3XtDeS5eVw4+56Ra4A3JchyRVJ/0izXIWEk6myBwULBiAcm2EUKw6sifSkaGmF9mKEwbxmZ/HvNlX5CQE1+ksPBi/63PtXdaBXteKGs+9qEC/KeGp+a0K0tjzq5v5Z9SnLuIut1vgGkYYCSBHksLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATQRfMgNPZefPwyniI+aWhOYpjOeFi8eCA0KdcFn7LU=;
 b=KKgLHljVaPKYfWP5roY46paGgmGcd57FPdjbaxgarpmh5UzcuvZaKsBH2iX8np121cgh3/FRHfSpkWxFiLWscgCjkTliOr6YohnoNfm3Yl7jMZb0ZGU98SYmVMm46fNLEvNcaQulnzejoVc54Uiy5gMlGpkiDakoYe3IYFZooms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by TYRPR01MB12414.jpnprd01.prod.outlook.com
 (2603:1096:405:102::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 01:34:34 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:34:34 +0000
Message-ID: <87o6wy1a3a.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3 08/10] arm64: dts: renesas: r8a779g0: tidyup MSIOF node name
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
In-Reply-To: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 15 Apr 2025 01:34:34 +0000
X-ClientProxiedBy: TYAPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::28) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|TYRPR01MB12414:EE_
X-MS-Office365-Filtering-Correlation-Id: b5810ebf-53c9-49f4-ace3-08dd7bbdad38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pIHKLGOZADjrGD5aq0I0LDQ5Ln7iz8LozMy73lXB3XI3q+2Lr7a+r2O2Ru4f?=
 =?us-ascii?Q?4gj3ssG2VSe593rRxkvJxTEoioIQnnEvBJCfGyDmI9mF9E3EmbKmda8TW3q8?=
 =?us-ascii?Q?313ZKiXNhY4HGblyHQXJUiYPqyhVhqPdrreFRmgCWa8a1WgYqUZIuTErz28a?=
 =?us-ascii?Q?OtTCFVNhtSiAK9roQ2M15NEeubD/bgn9gDGBggRz9e3W0st07ePh0rLaJMPZ?=
 =?us-ascii?Q?+aBbumGdxtWoCCpcWcorGo53WiSMW56x9KWybC2Y8CjajTJkY8o63wOBvGQx?=
 =?us-ascii?Q?cnJp7yetfDie2xNGEI3jtkvucUHPsWQyJ7Y8KrrxNV2EtjXbdx86MVGXIkTl?=
 =?us-ascii?Q?pfys41jA5jNM/98pbPS3z3E03h1R7l6ku4doVzK+VecpGGzbUpM8snwJATdw?=
 =?us-ascii?Q?HcL5rfGyCG9n6jOls9JxspSnjHiWPDw609vo1dRW3jrMjHStqvIvtB+TOPEM?=
 =?us-ascii?Q?vAgD3cHnQhbOSJvc8dFEPO4oNCbyrtEy53u5m2ly8OWVV2v0/P2QyTFhNLSg?=
 =?us-ascii?Q?SGkaDcZiZ/atIZvdwQvsEbGtfdxnLMua4QC3undrKpwkwKjQVlJcweegr0Fu?=
 =?us-ascii?Q?1BqdrguERoLb/xUmXvL4KQwCdtdTw6phE1oSmyfPGMt5phMZoCXG12eu4nJf?=
 =?us-ascii?Q?X7qOb3dNFyDI/+D3PDnajoIQWKb3Np9BuE4ZkAAtyW9e07m2sBs9Xb1cnNmH?=
 =?us-ascii?Q?o6zkG0rB8bsuJgWVgVDWgEO1+CTZ4I8JHLnF1Gl71AJlgqObWxJRPJVnqr62?=
 =?us-ascii?Q?xlvJVt6qIQJ4Ls21xzOru87dVUw/u9FQlXJFwuHpZoCqB/eEXa3r/8xLNjlx?=
 =?us-ascii?Q?0P+SpnGmynniuZr8tTNTbe1zXiJ3htkFNWL/3kkTvrQVxwViYI7TEUqebSHi?=
 =?us-ascii?Q?gylseI8sjVW0qDkzeDy7/N2dwj8Syvn6wmKdqcqvyW2raeXgdEsUzGNZNNmA?=
 =?us-ascii?Q?Uy/aDqgt/c3rW+E+yqBf1kEZv6SxjbrNylVKlHqkALKFm+Up7Hrca0Ly5sko?=
 =?us-ascii?Q?WZdGJrwgScv6MCrYGP1BIYznMdIOEDB0SOmxTH2Gqb/fcq/y91y3Z9v/CylS?=
 =?us-ascii?Q?kEqfJkE0GZLR4RdY9R72qH97kDPlgzvP2QQ8WsNyeCwio9AwM/d5V/O4HHmc?=
 =?us-ascii?Q?sQdk8BmeLwae2KSA/5C90fiwBwSbdeYgmS05eW4UNVo+OGaxg2rtJfIVB/1m?=
 =?us-ascii?Q?MYgrwZkq09/SCNZg9s/ijPf/ci3TkTNciMBNUsZ8d52S5UQPQJHCJJ5vlT9r?=
 =?us-ascii?Q?OWb3mXrS+sV2Ce6I89zRK0GQEPxwaE6oqwNqyOgzPDFMujUXg6i2sbBdd7Nv?=
 =?us-ascii?Q?AjVOcZKg+W1tU77S5Q7ZP8ywkryb1HIQTNBI24eXZxDAmIj/J9q8P70xvs33?=
 =?us-ascii?Q?85XAUzUeEdptdSOemWi2AMQh09kb6X12ynYe5tHJaZeAtvRja/OeaZnJ9YU8?=
 =?us-ascii?Q?qVOzG19onq/UwWhWSXJ31iNmBqxb2fyPmYFhlpOT/Xf/FyGzn5SaxgjA1LKx?=
 =?us-ascii?Q?b+btqoI5ZhDTx3k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YJiXP5QWC0PNT0CywPc1SiiPk+b0zv4GjqHXLpjT6I9Ih2ob5/AqKnJ3ZnV5?=
 =?us-ascii?Q?rRnPRWDNX1ljHHPFAX8fW4D1tndy1xXDwvHuUe08TVrhosdkUJYrHwrONXsI?=
 =?us-ascii?Q?mGe5iea/8+kREJVg4+ynys9nJzndbPJAmm5BwkOXmh5Is2vUeC20Ot433jJu?=
 =?us-ascii?Q?OPpQJQyWLnCnhXgawtDwYgvZ/uZLO7LNIN0MvClLKUNe9RYorf9rXicSkS3j?=
 =?us-ascii?Q?Z0cNwyJ61SzFPuLXMhi+7DX4whqbTgQSwONWo+tcKGivHGh6ItnkyWEvR6Sd?=
 =?us-ascii?Q?fqvy9jHg/X3utSQJ8nqFRjqDjJiQr7RXmjP810oldDxszC3hoyMGNx2oT8pn?=
 =?us-ascii?Q?UtP5yIP6w3+BWupOEghRZCFmZrRnfTIaNjsC2qXS5o8gdRgBErw8FaSiU3Jd?=
 =?us-ascii?Q?ZgQxF5eGckvlAdAFUc0mtAnlPQdvUuiM2Pi/e06i2JIPSqHuBlF397hkm/xT?=
 =?us-ascii?Q?jLY8J74FTy+AQ/cQ+F3WpAwtCJUp9o1td2kAtUJaVhRFORQfWLJP0vhPBoEO?=
 =?us-ascii?Q?TqEJjTK4nK8dorGbMUYQv6q0qXUKusfZoGjHaBNJ3zGQozpcdrCnEbxOaN2a?=
 =?us-ascii?Q?be11Z0vvuCote8DIIEbPO/G915X9v4Gh0RMKZ0k/gUT+M8UEU5fIbrPBmhOJ?=
 =?us-ascii?Q?hk/xBarZzAYH6LvUfP8GzN4NMnL+e8z7L3Fa4G5s+cHVpuLQ9jDWMbJqI5K6?=
 =?us-ascii?Q?I1o1EPw3PpLYkLPwvZKR/5ekmgkCEcqfkIUTi3egM80evU2mlZtYY6/feNbU?=
 =?us-ascii?Q?hO2zFFKWoSYDiVXfB71tBzmVfJ/vYJzjfe1sOEOy/GI0h/94N3qZYglDWZEp?=
 =?us-ascii?Q?eeYHbqmebxkSePxzB0Z9fTM6RWxXBmN6lUmJUgooQhOPfbcC+dHdXgm5J0ia?=
 =?us-ascii?Q?htjFZ+I684gKA4uZLzncnPBtL/a8hP3boEuTz7E52OdsYj1Oh9PMy8Ws6huE?=
 =?us-ascii?Q?/fFEUOK+2TCA2iT1jfKthfbsbP3PVfrFJv5QNgg2YHu2hrb5GSEMIKsDeYtC?=
 =?us-ascii?Q?iWuGEe2tauxwQnxQp37F4iSX+yCj28c8FiR8FZeRpAeL30mw0BeaNSE1e0RY?=
 =?us-ascii?Q?pa+cbUQ+68Hpg/GVLJYKo8bo8FNBQiaQEoW/ftQ3MvFeIs9pd8Di8jeGLxFe?=
 =?us-ascii?Q?eqW/WOhn2Zdp/0IHI1+9eMALn7/qra/8+9piZCgl+rCT0LQYw28/oeOs0iNr?=
 =?us-ascii?Q?qK5Y6NM6mY+Kkesk7+YrmLVM/SrBdnrV/SV8QxFbVGFMoPtuwLPw0VdnG/CJ?=
 =?us-ascii?Q?9axcyAZmDENl/CwyJJSG46MD5k/mVhWgv+NKmqBOEDeRsxteJ6vm7TIzZKND?=
 =?us-ascii?Q?DESX+6MvnmUUOAri+Yv1MapqR//pQNBgL1VnEukHFz7KsDB70vkZ/4HA9ShK?=
 =?us-ascii?Q?2WlNe+GNq7UEw5aJ7oML+qFuWQ14637YtsjBz23xHRs+AkVMDCHuMZv/2k8v?=
 =?us-ascii?Q?YetZOUWBiLgWg4jU0hC2+BFbgMC/OBEWQBOFIcl/w0UW3LCw0cr/e46tbsjK?=
 =?us-ascii?Q?kuu6A/wTd3NTmqiuQdWJdEX0aXNiZ8aJ3Ra5YmWj3iGDz9EYinJee19KPVSr?=
 =?us-ascii?Q?kfaw7G+QUBd0kWZdo2stVvI64UIbX20ZZ9KdACwbBC+bZgMHpZTBHFnJcodL?=
 =?us-ascii?Q?avUCBsJXZd26qoZuFqr3Da8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5810ebf-53c9-49f4-ace3-08dd7bbdad38
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:34:34.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1pwzLogHmhZIWZJOqu0DoNN7Q/uN3hi74ewEPKUpsDoqlbtXUjYYSvFX5Z7dbB5KaLts4GBcLJOZVOwXN8CI1oqSX+oP2wu0k0WTBFlFfp4hfB3MIXyqGeaP8VNiDjJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12414

MSIOF will be used as both SPI or I2S. The node name is not "spi".
Rename it to "serial-engine".

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 1760720b7128..0b85fa0d1f41 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -1250,7 +1250,7 @@ tpu: pwm@e6e80000 {
 			status = "disabled";
 		};
 
-		msiof0: spi@e6e90000 {
+		msiof0: serial-engine@e6e90000 {
 			compatible = "renesas,msiof-r8a779g0",
 				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6e90000 0 0x0064>;
@@ -1266,7 +1266,7 @@ msiof0: spi@e6e90000 {
 			status = "disabled";
 		};
 
-		msiof1: spi@e6ea0000 {
+		msiof1: serial-engine@e6ea0000 {
 			compatible = "renesas,msiof-r8a779g0",
 				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6ea0000 0 0x0064>;
@@ -1282,7 +1282,7 @@ msiof1: spi@e6ea0000 {
 			status = "disabled";
 		};
 
-		msiof2: spi@e6c00000 {
+		msiof2: serial-engine@e6c00000 {
 			compatible = "renesas,msiof-r8a779g0",
 				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c00000 0 0x0064>;
@@ -1298,7 +1298,7 @@ msiof2: spi@e6c00000 {
 			status = "disabled";
 		};
 
-		msiof3: spi@e6c10000 {
+		msiof3: serial-engine@e6c10000 {
 			compatible = "renesas,msiof-r8a779g0",
 				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c10000 0 0x0064>;
@@ -1314,7 +1314,7 @@ msiof3: spi@e6c10000 {
 			status = "disabled";
 		};
 
-		msiof4: spi@e6c20000 {
+		msiof4: serial-engine@e6c20000 {
 			compatible = "renesas,msiof-r8a779g0",
 				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c20000 0 0x0064>;
@@ -1330,7 +1330,7 @@ msiof4: spi@e6c20000 {
 			status = "disabled";
 		};
 
-		msiof5: spi@e6c28000 {
+		msiof5: serial-engine@e6c28000 {
 			compatible = "renesas,msiof-r8a779g0",
 				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c28000 0 0x0064>;
-- 
2.43.0


