Return-Path: <linux-spi+bounces-7547-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85A8A850EA
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 03:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECBF4631F9
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38725B652;
	Fri, 11 Apr 2025 01:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Iu83iXeD"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010069.outbound.protection.outlook.com [52.101.228.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9A26FA4B;
	Fri, 11 Apr 2025 01:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333458; cv=fail; b=psSbcU28ogAF2yDxydRrdrrbZswF140+JOtS3SiKwTNDNo+zDcardTPZwVE670B8xGQ7oqaQ17Qu7iH/V5D9aNasubXz5NyGUnOJQ1Vz7k/a3XOffyd3Z0jOVR3Sq3JeBZ/w7A2hiJDCX8uKRZ84tlpPIZC6CA2qCSS6SzoDEeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333458; c=relaxed/simple;
	bh=20icTfEAdZTTolApSXUOgU+IoAIZeCZxXHutITKOJqg=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=jPZLMMD65lHepgQZSC4niQreITSVtJy1U63ibknEI/PzbIn58WtOlK2Da5LAwvdL3Rkmz57OH2kgArJOimQoiI3zvWGASOjpleM/zCFzEvxKUd5tnwpeeFSA07HbHu7tPL3ZKcC2SYSHC3AZNpfKmwB6QX4qzPmdg340p5CQ5kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Iu83iXeD; arc=fail smtp.client-ip=52.101.228.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpjjPimc+rs4iFoWKwQc0B9mXj1c0HCdfpP/3Z/O2S+IwTdGhjoO5gqKcZtncpQt4FpQgR+s65F2NVjPeisCcTvWzTTXRZKBhZtOQ9wsgsMT5zmAQzg6j/d0YyIZJVNTLJdQhaldWt+Gu6JDekJFhIyl1piIZXmKrIJn8PK7sgQhLRSpVu4SALO8Fms1YaPeRQzAS7hzCKyrknkhqfCKcnmy++Ef7n+HWYUH1O8TyBddp7rBdL0zPe8h0c20XQ3ATO9tXwGuDDy/fGBxwty0sab/fQJkKKh9UipNkaeN5nyZ5JXEGFoSvelCEOY7PmHDebJhYKhbdH8m6eWFPBdaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWqQxkvNC5CQHhlIMUcZxvSumQwyGjHj9VULWH5cfF0=;
 b=OsBlc13v5sg5chiPgMuktefuCEinUG9xpUyb6OTDHhvsIcMfl36hoScVQf2Xn3lWRHznAlGddil6Oj8BwyIF5K386lteQJI+D+rD1Hw0WgBLOGrBWovASASRFHq7nD63iSr3wb+aiUB8Sazu3cv5fi6t1SprabrRyqG9sJQe5NJBZq2FA69Clippzs0SnbQv42SDDP7gOW1D2cKkhefbQN5TxF04GSQol+iVbDRdMvAg+RWTEthsROa2EiHxoFeOvq/kBSvo07DBb0I8JG9r6wWNKVnujrotG6IAHWWqlxbqVvUCLLQ8o/0GOvoWc7LWRweZvMPXnQOBw7zhiTiGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWqQxkvNC5CQHhlIMUcZxvSumQwyGjHj9VULWH5cfF0=;
 b=Iu83iXeDtAG5LMHsDH7st0dKF6+JxK+hTlC+hYiaI2zJaxMyYFLqq+wMcRDwkvQZdNDXOCgta7y90GwqnKAt20emRSjrcAGB6v1xmFPj0AxLdsPjz+aiNnbjTeTUDEpfFEWXr7SH6qv10xvyUMUHuYh04EU6AxZgpS+RZ5duVdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY7PR01MB13579.jpnprd01.prod.outlook.com
 (2603:1096:405:1ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 01:04:10 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:04:10 +0000
Message-ID: <874iyvh5km.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 9/9] arm64: defconfig: add Renesas MSIOF sound support
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
Date: Fri, 11 Apr 2025 01:04:10 +0000
X-ClientProxiedBy: TYAPR01CA0132.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::24) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY7PR01MB13579:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8847c6-dc46-47d7-43d4-08dd7894c47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o/AJx1O715Ba4sujSFIJBD3kP7kqjws2uQcuq3oG1HNFBGVB6lw4zrVVvLx5?=
 =?us-ascii?Q?/0cjOG9idCkcrzNflOLvXnFeZ5d/vtBrK5cA6UPKfXFoRuIHKnxco4iX5/OU?=
 =?us-ascii?Q?3dEQjR1M02TT7NS12UZTV1B6FKX+1XncINbslo/89l+2wp+GEEDFmg2icZEz?=
 =?us-ascii?Q?ktEBLLx2Lcqp2CjkGBbW/g/kYoJ3P6j2nu4Be2v8X7bQLuQq4RzEbqZxd13z?=
 =?us-ascii?Q?VGxNUYK7b8zwP7+gQkGtWM7YJ5W4F5kWP8szrN+l/GLuLbd3hu7g2V2avh/7?=
 =?us-ascii?Q?0GyFL2I7Mr7UCTp+heacNl2JU7kJdq7sJkDD9xr5w3aNsvY8z6K1sNhMYqzM?=
 =?us-ascii?Q?7VXCICXrBnHZu3Bmw6ZwF5S+k8/kDdcPGCCCVXP5b4EhgJeEQi285s1S6tGB?=
 =?us-ascii?Q?8gpHvkMrF0qiBo8PI+mMzD0PM7CuFhVXs/I92OwSPyv4KKZxdfPY5SPKk9X1?=
 =?us-ascii?Q?tgP/iW19UlgGr/JkKFBCG9NPw/46EdCEd/GRSFPNk459QBmrt9NhWuuC+Y1m?=
 =?us-ascii?Q?VeqoOawqU3nvV5izGI+t2DFWA9vizl7WR2Z5i/y+x/SJNfqzVLivGnqd45Po?=
 =?us-ascii?Q?hA2QyCuY3RsZdZ4cpQKOBEuz1/wqtHcl/D4YgySE/k6ySPLQabqYCkuxqy+W?=
 =?us-ascii?Q?RNlSrUTY8rChlUkf5guHqJOyLfqzjFcTeo2bp8AOTCTN/zPWF1wgEhADOmr5?=
 =?us-ascii?Q?mpCajACdiYmdlY2xytsgHl3FliTWwWaJRIZm/wuwExatSuNRfTDazEkKallF?=
 =?us-ascii?Q?zBnoF2z9EXF0+UYjHBPrZV5zlKNugxQuNQ83e/ru0/XHOPpPum5fwcwkMqak?=
 =?us-ascii?Q?Y0/OfrObMrYQPjGnf/y/4GxGBns+qoXjTT7fHW55ZpVnGTZAj8Uy/pTX+apX?=
 =?us-ascii?Q?GC3R4tAYmz9Y1777tfTKgluF1JM1KKUSPQ1t4ra4yPJz+tQ6jJ7HMPHIQFAy?=
 =?us-ascii?Q?SWDZFwPJSM3wHIlQp4vc6P5P1XfVbtvUB2V6Yj08WAVnDauiKvUihb7eg7pn?=
 =?us-ascii?Q?WNE3GlYAms5JEfDljrV5IMuxUqyplNe8gxOrHcp/W1IKIfpmU+yb0j/6bV0J?=
 =?us-ascii?Q?PWLTm/96E8IkP8OibIVefdu1PQ0miEN3bsnopU644fEVfj0otCsob4UmXIxg?=
 =?us-ascii?Q?5caZ+qFgDneYG8SSrhqPbEbNZlaVdA5Glc/KiqBh1KPqTzTG+S4mqoXZRkv1?=
 =?us-ascii?Q?b4y5jMoyTySJq/cV8aVq/gNdotuubFwtDu6TXYaBjuIYFKb4nMjpAUN9seKk?=
 =?us-ascii?Q?H1yoJGbEcc9aDoPJuSU5hM+wCppjCCPxMcf9SyDw/wzIFG/5T00puKgeQ1Wb?=
 =?us-ascii?Q?qdtstIWhh7AJPHpl0aPeL65+mN2tsSokwOloT/JF/fa1Q4VAYh9a3AGt1uAT?=
 =?us-ascii?Q?Pik857YI6LISUChfpIHojZIWS3BIj3STL2N52T3QbeZJxdU/SWVzY8d2Re9R?=
 =?us-ascii?Q?Gg6O8pITMWzKYaxveua0Veww45EsNTII2hfluGFxPjtgXiMQKf7PKscKUHB7?=
 =?us-ascii?Q?8PWYbfcKaod2quU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6paY/3WwQZlvjZXLaEOHDBJC1wa5VAQgr45syZiGPW24rBjXXotbBW0nD6fs?=
 =?us-ascii?Q?P7MA+U3qLqxPlEP51QvUUU/sWEWiLY6lZLLn9M/TmiyBtTwEmLpJLavgUt/j?=
 =?us-ascii?Q?CWLRFF7Z4qFECDee51i8KvHh1mVkiKMlINUsoCZEG98S33ceHBpTlCvHUwMU?=
 =?us-ascii?Q?ypl6LOf02ufqhRmhYGdZntNa04+AzroskMppze2LS0SWY2LQeGgA3oaFugFi?=
 =?us-ascii?Q?HcQ8zT3n+Zn6nigdTk3O7Sl2b6VeuHeSoKzMpiMfesCs2h/E8Ixvu4sT/Y4k?=
 =?us-ascii?Q?awvM8jBnsfuRAiWO5qqOaf3Ia97GXrSdz0i38ZN1rDUo0jqmmTJlL+5Lj6fN?=
 =?us-ascii?Q?UjIOdV5IcQWc+PQ42/6ijJrdOPirYp0Ey7uFI/TrWYvnbvUDsT3LNySGgltO?=
 =?us-ascii?Q?/Hl3rtyz3Y09EYv2ZGMsK/qBW4QSLSj/WlXYNkY3gJN2xANTr2JdPxmShz54?=
 =?us-ascii?Q?Om5olJrZzsg+M3nzs+hcJljOnL4/v1RfVWKVKxKioY70H8ftNG++K2pia9mY?=
 =?us-ascii?Q?mwp9ZBNR/1lGgeqvy5pJSks50rVXjeE5g5pKGQf1rqm8HyM8TX1EsEige8Oe?=
 =?us-ascii?Q?PPWZJaqU83F25Gzb4NWc4fzMujXD+ZOhlixFZmyxU83v8fUqYvaqxJbxedO2?=
 =?us-ascii?Q?05Njx40SKlRdjTdh7ImO+Ni3CSEYdCAupqdftJePIwGDw0enKJ9Vxg/4Wu86?=
 =?us-ascii?Q?Tbs86+9BelwlOjZgMD1LhlpwePkGoy8s83L9owujnUDFfph8yOkE079Lfqjv?=
 =?us-ascii?Q?CtGgEilVr7piLNPz4EjykdlIu2XGOV7pykYNY/2Hh8S8vMcNjfmtZrKkTWtq?=
 =?us-ascii?Q?d4YdwVcTmq2Aza+IZbGFseRv+9z43CfdNZIuGmI8/ikTAk5DdOb+wi4o7lSv?=
 =?us-ascii?Q?8IomJkcWkimjWMqhVDjwuIBVnk8voFfTk9Fb2uvlmiJGMiT4vkBt7AacOf69?=
 =?us-ascii?Q?8Dk1SiiLWFjGmDFpZKzbWw6CxCjCBaNPLdMAUyB5FAYlwLRAhXX9SdJesBPi?=
 =?us-ascii?Q?/1a4fcK+dSKwdlat9zxmAl8wMR9UoI00Hg4ZmMuVtIohNXoyHpwR7y5Bk8Jz?=
 =?us-ascii?Q?/Q6nIXxP2M6Nm3xXAlhC3Oe/IrJ5I79UI5KpeAZPjMiez4h6IPz2jI2tH7kl?=
 =?us-ascii?Q?s1AD62xuZGRv9e6Cm+7lVK242l4/4UjzxQn5j2DbetD8Ck9xRLEhO7+RJJFb?=
 =?us-ascii?Q?HzSIwhXGzoG4jN9XjUFy62SotA+7rUE5hpXjKRL3mmkyiPKQjoYZS+OcW4cp?=
 =?us-ascii?Q?ZtbPL9tkqvWPW0onaLOSF5O7Z1A542ghRa5U4Yc59A7ycF57kE03Uz1RSXRN?=
 =?us-ascii?Q?4Avc1NqC3KUmjj78sPF6qYnBOFhYOrq0s1a1cBkD3PbzHMl6GvZRQ1bH/8Yo?=
 =?us-ascii?Q?JGbd+bEBNtE+TnQe505v4vADHarJ9jXnfpABoG+p9Kq1d+SbL1FrN0WYLo4w?=
 =?us-ascii?Q?nIIVpeAUC13Yr38WxdeDv678vzFDp9+AeYzBNdQiUyl9yjHQ8D5N5A4Ug3QQ?=
 =?us-ascii?Q?8NI0TJmsrH6pry2bJCbaN4+lI7zkFegDNg/UfamilTsuvqfA9Ij8CovMurzY?=
 =?us-ascii?Q?XB+xdqtqzAWa6GDsaK/P/VwlM2ph3cYDWDwhKS2oernzn0JD/eY4ROnhtELx?=
 =?us-ascii?Q?lvEI/y1RiXm3BCFGFj/E9aQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8847c6-dc46-47d7-43d4-08dd7894c47a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:04:10.5773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPw1qQS9PoiztoXH76nmKIRDw40bHivO5iHfkDPnOhz4fQXMkfxDD3UzA9rrqKxQmnsB9yNwXoKCes8+mfmdKZ/QXOMhwN8lDsS6CB4xS9B70eHj79VjqrpF4QQ76R/R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13579

Renesas V4H Sparrow Hawk board needs MSIOF Sound driver.
Support it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5bb8f09422a2..b74f5810e0e6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1010,6 +1010,7 @@ CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SOC_MSIOF=m
 CONFIG_SND_SOC_RZ=m
 CONFIG_SND_SOC_SOF_TOPLEVEL=y
 CONFIG_SND_SOC_SOF_OF=y
-- 
2.43.0


