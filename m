Return-Path: <linux-spi+bounces-7585-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D81A89161
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54510189BF89
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF1F187858;
	Tue, 15 Apr 2025 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="aDCfvWUQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011004.outbound.protection.outlook.com [52.101.125.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674E60DCF;
	Tue, 15 Apr 2025 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680877; cv=fail; b=NK6NI1ZJ3G5VEi8RoM+w20ExEGHab93Ype1UhVNIHMv86vd1xYJ6RF5kgqSNN8SLhgygjE7SiTzT1sRsiCjp8914hoQELoP5KzqKleqqRqYgQgYASMqiGsBXdurC7P7JaeT4/2rFLaIeEIhs/i2xgja84pqh7LnqXgBM8WVd8DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680877; c=relaxed/simple;
	bh=VFcQL01w1aOFiITeApmf2x3zpuag9Qdo0eqbp8EWXLo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=c8Trvat8i6yz3qxXYnBt6Zr+kS+1PShY9KDoFNdu4OgJkKhdG0yWCg/xWeQtpdgTI3NzjaU6Is6EJxpxCh6XcW4KvjuvDfNywYoCrXqhvfWwSyWQei+gsluTCMVGWgRuKPpjpAYTfBBEDv8lekqGQQr8s3WLZsqWNJIiiZAgXVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=aDCfvWUQ; arc=fail smtp.client-ip=52.101.125.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srf0OTkIbiaUUNZ2XjoNCI8eQLF6cJQjHE/6WMH+xB4nVx51fNPWFovIJqB/4b+i9vGPE0h1ba6ZFBZ0Yltdmj+pZlM7ppEGgzryGuUvyKT3VC1Tup/H5rNu9YlirWdgwIJTTHM9tAR6Vpa3+iQzy6nAdFKjdL4E7BFwRLGLh6qVSb/VRFF25AXOy9d9nRca++mGg79SwnFB8ha8F/l8JTiC2+o0H98ksbm2Si4QtjPbdvpTo+2ODFEKbLtvOcn5M8IGslZTcGcjcVEHf26e+0kjMnhhEQN9A0mbMza011Lj6QlMeobe05aLnOTT6ZwNF01koo1+8wq2uEN9VL8FVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBTg9LJxjAjG8EkhqBOULd6hpilGgq7VZj/xOESMr10=;
 b=l33BL3sJs9Ww6f0rq9ZW4nO1iJ8XCTBtE7kvAYzhL4jeABflFVuYg8TJxZec53mTpv/Nn6W/HA/xRGB5HW6wNCl6F3sOJ7Q2/xfjzMLLbdBiQgQB1wUAp5zUrDFMLeCGtvf/Hq5xKdZ7Wu0QDSJNfDF43PXVGpEmUSzkrNsg1nqs6gnqD1g2OavBCbEFKHHr2GxvFsw1nLy1AEYHDSSd7dPoQaQ3h7f05ACpRJqeXmMklGZGP1TY9Y+4Z8ToZ8KD1u9pOuF4H8RagTQnMzvJ2fkqU81VQ47ir4Fu4D2B4D/NdLGaZxKwinGS4bFzL6CQyI7zYHakHpswwF92nbwdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBTg9LJxjAjG8EkhqBOULd6hpilGgq7VZj/xOESMr10=;
 b=aDCfvWUQKuWSBwmh1hsNRkPMrUncd5XCa/ynxtXpFu6LZcbZLf3igo6DZq18PtR8SBuz5ZCopxhC4McKkFwaGewyPXvYpARCNSdmRFCjxwqSmwZximQAudTm306e8vB4qU/L+B51ZZLbOzisFTdSTovplEhcjc47jHNFeEOU6nA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by TYCPR01MB9536.jpnprd01.prod.outlook.com
 (2603:1096:400:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 01:34:29 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:34:28 +0000
Message-ID: <87plhe1a3f.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3 07/10] ASoC: renesas: add MSIOF sound support
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
Date: Tue, 15 Apr 2025 01:34:28 +0000
X-ClientProxiedBy: TYCP286CA0105.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::15) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|TYCPR01MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d87e042-d6f0-419d-f474-08dd7bbda9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RLKHBh39mnZtSPTNVvY7NMaSS0dGJb2f77XikmRVuJ49pVCvqbryYXK3sIvj?=
 =?us-ascii?Q?4roN8WbEOVdoeTLP/7DrbZUQZfUyZOP+bcmVsF1zeI1Smz6spVZJMthUvwui?=
 =?us-ascii?Q?Fq9QrdBIy5MfnqWRYih5lFXUohnaCkER5j/vl/zBw0ZVVDk3bq1xyQmFyRMT?=
 =?us-ascii?Q?DpFVo4Dn5UebEoBhfYIXKeqvGe+v7vXVH3zbSOs42D5Efqo0RKHIqXA5bEfc?=
 =?us-ascii?Q?SWwtp+CAR1aFg73I9GgjoP6jGhvhOpR4h+wLYJ6S2oDRQhtM9uv9Wjoi7x9h?=
 =?us-ascii?Q?/95K8778bcFVZmuFThvNqITV+nDAV1QjAhOhdh9/vcOEl6gKveqIFEFOv4Fc?=
 =?us-ascii?Q?/TA+Cbz0QnYb41KMPj0JTDAoVj+RIvKHkatntKDUdiW2tQvExb00colQDRXE?=
 =?us-ascii?Q?VWis3HT9YW/e5Sj6AVsce4cz37hjNKHzm5+ruNYnmKpFRo5uiEJ3Ur60vK6j?=
 =?us-ascii?Q?G9huabpESnIpJBTTV+d5wBJXAf7Z9oRn3+uCmOmpq5Sqo7vB1yIwmvp6VhHi?=
 =?us-ascii?Q?HMxOR2DsvFaqmMYGiQDryuWibroHzjpQRk4hA+ZYdLLB6b9BV600t/8BaV6J?=
 =?us-ascii?Q?xF2ArW6KaCd3yOueBZLvLPUXHM/M6Wo2MYY95GsVyD+o3Nj/X3wtAaLMRPWo?=
 =?us-ascii?Q?7oygYZZMVNAZYGVJfDWaUDHcmqGHjWmPw7Rpat1pVTYIzpnlDZszKkAGgfPT?=
 =?us-ascii?Q?jfOKBcVxXZGwJf70PY5QEtSUG3HzlwIccHfogmhCXC3zPZvfW+rhOThzYmiI?=
 =?us-ascii?Q?qmQvqMH/qWYtbpOrXbit2CScTc/Z/aOCGpMZy+73bKS8vcvyl/UExAn92g2Q?=
 =?us-ascii?Q?yElut7FQ5qmG7F1fxWBi25VJPOqDMxfLFn0D8fK5fn/1uufgmUCm331QLtkH?=
 =?us-ascii?Q?tgcn78jBKlo3E+WKeQOO5iscs7o0p6vYefkQMjLcsL9k2FAUWdY06SrWpInm?=
 =?us-ascii?Q?Ax1MU05xUR6mRZMuXUPZy1ECN/fXAQZWOKP7WtUTrs5/x5ZYc1Cb9y0+F+aB?=
 =?us-ascii?Q?kvefeVmL+Y2V/VmARRxrML0HZFU3PfwSEKvxEruUIwOjFwzWBGMJFcNgqXxX?=
 =?us-ascii?Q?pjkdawdIFpfJgdUW/WPGaNfb0mFpcpsf/8ZVHWDsvUu1sb122VU6SkmMB7nX?=
 =?us-ascii?Q?Nr5zoQ8uu0N6UrStOoCRUpdiuqZPs5x5zxpP79EPW8goSDdagYGyjBK/Ob4X?=
 =?us-ascii?Q?2rZB5I6Lt82bYZUiWlLg63rodA0u0WzUAGEgjT49nSyGcfLoSkHHMqALAYUw?=
 =?us-ascii?Q?npElGbftveM/Ua+b/T3e4bMDv1AFsYCkGFd8WSox36x2/U31KM0RkScFaBKn?=
 =?us-ascii?Q?B7pbWyV80VVrBSVTLfpH/EVquwLOQnov0V+blbhnASse9g7XqwXYmHNfhbd8?=
 =?us-ascii?Q?X+yuTTcsICoCRaDCH2uh96uK1F1ciROtmU4zkvpiKjzODI1eklr6DOKawMmt?=
 =?us-ascii?Q?SiJEEWTjdfAgLHTZgCoWD8841EiGKVlYVYRyjVVrKNYEIdTmd/laLscxzX8e?=
 =?us-ascii?Q?Hnwg+CsIR3VVfKk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k9QGx0HqxlUr9brjdm2YiAapWltnWythg3heazbx/kjzKV7iBlZl+cAR3wsb?=
 =?us-ascii?Q?pZ/eD2/Jq3ljPMQQhM4yy4D2PTy38aKCwJ+BMG9LJPRI2AwRZa6jwnl3A4WA?=
 =?us-ascii?Q?5+RX/EPqPTsY/WVItnewQ/F7MS54jmt5PC5nlsiDVzhT/aG26XN612dgna83?=
 =?us-ascii?Q?JPvnLRoVnRy1TIUSmmVsIPGFKjdXAPb5J1NrF+h4FoMQ4AGB2bo6I0l0EEvw?=
 =?us-ascii?Q?NhJNam0N33twj5xoqV3RfvExGNNFNLraPo5sA8YJX9yV1LceqVnEnAAEoghY?=
 =?us-ascii?Q?LF7hHxXZHCLIPkNaTr8JnTYcz8zxAoEaU6Rm6IrhTag4w/qSpIBZVHeoIoRf?=
 =?us-ascii?Q?b8jam5jtmcp/qpQM6l19SSe4AUw33/Waqjfl3XJH+dlYkgmDjpnnym4WhZ7U?=
 =?us-ascii?Q?f+QnbYeUzuYbptOBTlm0xTlltDerU1u4Pu3DPB1tSv/McDEVBvFC7eKPRUPY?=
 =?us-ascii?Q?giYyeCUrvTdK4KZIsbUYmfYse1p1hIhnI4VaN9EBjWDzlTt7KfejBRWJg3WF?=
 =?us-ascii?Q?ftLFiCXtrprLMQzmt99/tuTWNdaoRJngq9PiVm3S+JAXEfWAN7qjtFdHedOv?=
 =?us-ascii?Q?od/fpFXbJrdCW/Fe63sShHPMgF7zfjX8vpBZBee6o7LojT6hbYfQYwwfteyC?=
 =?us-ascii?Q?bZ+kC1dghioBUSCarMZVFn0EdFtd7VNok5Newa5zcisk7Y4hA9rwNzNfSE+B?=
 =?us-ascii?Q?B+4B01wDc8T2XJX7Ywa8HMgT+VmNz+FMbg08lB7CWBve813IG1Zvwo1+X36O?=
 =?us-ascii?Q?Q5sKDux7q4PKw7MndpS+5ATdmQEj+aNQ9KidorU8TfjKkmeU9JeoY4kyL2Os?=
 =?us-ascii?Q?VAmNMJMuNA5ZbrtsV45w1yldYOy1LsZJCT8/Ykb6DlikTXd8sjQFH2pkJ4yf?=
 =?us-ascii?Q?4opevyTEiOeF8S+tnK9xfPmFqToHtXiGqnFe2hzr7+CpwT/SohGk2VDOZhgq?=
 =?us-ascii?Q?BigvFtX+rs0tEtfFnPJhJIrtuEiNkqcToouC4gI0+kXDj82QCQlCq/Vrv+So?=
 =?us-ascii?Q?JODJQVCKSiYCwbH0pl+EydbMip52t7Ds2TWndM8JbC5vmR+EoB+ttnemuO4P?=
 =?us-ascii?Q?YHLPZNvyZmhW+q+UskNaAu6BcLavDPWAq7VClRsekqjlCjudLHpvHKzd7BfU?=
 =?us-ascii?Q?ykojKr9um0tjCXS/sTPw15ofDEQ7RMZZ0B9D9LCHevLN0eTUGhpXa65d2p0S?=
 =?us-ascii?Q?gxqvovDn9KyEsOwUaMD30gXeZrxWSauredCzzKmT4MRRVh7tajpVXJSGEQrc?=
 =?us-ascii?Q?E4Fzqu7pafFyctIqyvLv1UAxOr041xTnIe83XdsMmw1KsOHGoHJls89c3eI4?=
 =?us-ascii?Q?9BRgvufn2pk9l/m7+wNPHCy721rnBluJUgwzLPc2WPIAd5p1OSPIpnSe1QVC?=
 =?us-ascii?Q?DSzYVWNQllDdgBkP5PS0tgTk9ijP99Ur1f66NoaoOpHcSt0XXmfwjYHbWZG+?=
 =?us-ascii?Q?MemAr5taYd9MKZbHarqNcRJlenoCgCnvGikb7tgJNlPQdgr4Uxv5eJuiJSa1?=
 =?us-ascii?Q?smJ97ulnIV3VJL92gZhYaJWouQvKMTbbkSdyMivVWrECQQ0r949BJ3RJG+lS?=
 =?us-ascii?Q?Kau/jsr0z/QdQ2X+0+cZiYnoTbWvqCvj6D+lRD4NiTOCmMCDMD0y7dcUtiqf?=
 =?us-ascii?Q?b0xGZiw2RJpT7y4nPchC5rE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d87e042-d6f0-419d-f474-08dd7bbda9eb
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:34:28.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afnplsxHKvbi6nd78Va2ZHUiGi+y0k0RQUjh5i1Kut23we3l6Lbuo37CoknutMYjm5WkSKRc5L9TPKHG63RaLBNFH4hqb+SdG20T8BkNbx1OqVpl6bsIGtyQQhDD7i2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9536

Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
both SPI and I2S. Adds MSIOF-I2S driver.

MSIOF-SPI/I2S are using same DT compatible properties.
MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
MSIOF-SPI doesn't use  Of-Graph.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/renesas/Kconfig       |   7 +
 sound/soc/renesas/rcar/Makefile |   3 +
 sound/soc/renesas/rcar/msiof.c  | 566 ++++++++++++++++++++++++++++++++
 3 files changed, 576 insertions(+)
 create mode 100644 sound/soc/renesas/rcar/msiof.c

diff --git a/sound/soc/renesas/Kconfig b/sound/soc/renesas/Kconfig
index cb01fb36355f..dabf02a955ca 100644
--- a/sound/soc/renesas/Kconfig
+++ b/sound/soc/renesas/Kconfig
@@ -46,6 +46,13 @@ config SND_SOC_RCAR
 	help
 	  This option enables R-Car SRU/SCU/SSIU/SSI sound support
 
+config SND_SOC_MSIOF
+	tristate "R-Car series MSIOF support"
+	depends on OF
+	select SND_DMAENGINE_PCM
+	help
+	  This option enables R-Car MSIOF sound support
+
 config SND_SOC_RZ
 	tristate "RZ/G2L series SSIF-2 support"
 	depends on ARCH_RZG2L || COMPILE_TEST
diff --git a/sound/soc/renesas/rcar/Makefile b/sound/soc/renesas/rcar/Makefile
index 45eb875a912a..3a2c875595bd 100644
--- a/sound/soc/renesas/rcar/Makefile
+++ b/sound/soc/renesas/rcar/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 snd-soc-rcar-y		:= core.o gen.o dma.o adg.o ssi.o ssiu.o src.o ctu.o mix.o dvc.o cmd.o debugfs.o
 obj-$(CONFIG_SND_SOC_RCAR)	+= snd-soc-rcar.o
+
+snd-soc-msiof-y			:= msiof.o
+obj-$(CONFIG_SND_SOC_MSIOF)	+= snd-soc-msiof.o
diff --git a/sound/soc/renesas/rcar/msiof.c b/sound/soc/renesas/rcar/msiof.c
new file mode 100644
index 000000000000..2c9c7eebfd39
--- /dev/null
+++ b/sound/soc/renesas/rcar/msiof.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car MSIOF (Clock-Synchronized Serial Interface with FIFO) I2S driver
+//
+// Copyright (C) 2025 Renesas Solutions Corp.
+// Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+//
+
+/*
+ * [NOTE]
+ *
+ * This driver doesn't support Clock/Frame Provider Mode
+ *
+ * Basically MSIOF is created for SPI, but we can use it as I2S (Sound), etc. Because of it, when
+ * we use it as I2S (Sound) with Provider Mode, we need to send dummy TX data even though it was
+ * used for RX. Because SPI HW needs TX Clock/Frame output for RX purpose.
+ * But it makes driver code complex in I2S (Sound).
+ *
+ * And when we use it as I2S (Sound) as Provider Mode, the clock source is [MSO clock] (= 133.33MHz)
+ * SoC internal clock. It is not for 48kHz/44.1kHz base clock. Thus the output/input will not be
+ * accurate sound.
+ *
+ * Because of these reasons, this driver doesn't support Clock/Frame Provider Mode. Use it as
+ * Clock/Frame Consumer Mode.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/soc.h>
+
+/* register */
+#define SITMDR1		0x00
+#define SITMDR2		0x04
+#define SITMDR3		0x08
+#define SIRMDR1		0x10
+#define SIRMDR2		0x14
+#define SIRMDR3		0x18
+#define SICTR		0x28
+#define SISTR		0x40
+#define SIIER		0x44
+#define SITFDR		0x50
+#define SIRFDR		0x60
+
+/* SITMDR1/ SIRMDR1 */
+#define PCON		(1 << 30)		/* Transfer Signal Connection */
+#define SYNCMD_LR	(3 << 28)		/* L/R mode */
+#define SYNCAC		(1 << 25)		/* Sync Polarity (Active-low) */
+#define DTDL_1		(1 << 20)		/* 1-clock-cycle delay */
+#define TXSTP		(1 <<  0)		/* Transmission/Reception Stop on FIFO */
+
+/* SITMDR2 and SIRMDR2 */
+#define BITLEN1(x)	(((x) - 1) << 24)	/* Data Size (8-32 bits) */
+#define GRP		(1 << 30)		/* Group count */
+
+/* SICTR */
+#define TEDG		(1 << 27)		/* Transmit Timing (1 = falling edge) */
+#define REDG		(1 << 26)		/* Receive  Timing (1 = rising  edge) */
+#define TXE		(1 <<  9)		/* Transmit Enable */
+#define RXE		(1 <<  8)		/* Receive Enable */
+
+/* SISTR */
+#define TFSERR		(1 << 21)		/* Transmit Frame Synchronization Error */
+#define TFOVF		(1 << 20)		/* Transmit FIFO Overflow */
+#define TFUDF		(1 << 19)		/* Transmit FIFO Underflow */
+#define RFSERR		(1 <<  5)		/* Receive Frame Synchronization Error */
+#define RFUDF		(1 <<  4)		/* Receive FIFO Underflow */
+#define RFOVF		(1 <<  3)		/* Receive FIFO Overflow */
+#define SISTR_ERR_TX	(TFSERR | TFOVF | TFUDF)
+#define SISTR_ERR_RX	(RFSERR | RFOVF | RFUDF)
+#define SISTR_ERR	(SISTR_ERR_TX | SISTR_ERR_RX)
+
+/* SIIER */
+#define TDMAE		(1 << 31)		/* Transmit Data DMA Transfer Req. Enable */
+#define TDREQE		(1 << 28)		/* Transmit Data Transfer Request Enable */
+#define RDMAE		(1 << 15)		/* Receive Data DMA Transfer Req. Enable */
+#define RDREQE		(1 << 12)		/* Receive Data Transfer Request Enable */
+
+/*
+ * The data on memory in 24bit case is located at <right> side
+ *	[  xxxxxx]
+ *	[  xxxxxx]
+ *	[  xxxxxx]
+ *
+ * HW assuming signal in 24bit case is located at <left> side
+ *	---+         +---------+
+ *	   +---------+         +---------+...
+ *	   [xxxxxx  ][xxxxxx  ][xxxxxx  ]
+ *
+ * When we use 24bit data, it will be transferred via 32bit width via DMA,
+ * and MSIOF/DMA doesn't support data shift, we can't use 24bit data correctly.
+ * There is no such issue on 16/32bit data case.
+ */
+#define MSIOF_RATES	SNDRV_PCM_RATE_8000_192000
+#define MSIOF_FMTS	(SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+struct msiof_priv {
+	struct device *dev;
+	struct snd_pcm_substream *substream[SNDRV_PCM_STREAM_LAST + 1];
+	spinlock_t lock;
+	void __iomem *base;
+	resource_size_t phy_addr;
+
+	/* for error */
+	int err_syc[SNDRV_PCM_STREAM_LAST + 1];
+	int err_ovf[SNDRV_PCM_STREAM_LAST + 1];
+	int err_udf[SNDRV_PCM_STREAM_LAST + 1];
+
+	/* bit field */
+	u32 flags;
+#define MSIOF_FLAGS_NEED_DELAY		(1 << 0)
+};
+#define msiof_flag_has(priv, flag)	(priv->flags &  flag)
+#define msiof_flag_set(priv, flag)	(priv->flags |= flag)
+
+#define msiof_is_play(substream)	((substream)->stream == SNDRV_PCM_STREAM_PLAYBACK)
+#define msiof_read(priv, reg)		ioread32((priv)->base + reg)
+#define msiof_write(priv, reg, val)	iowrite32(val, (priv)->base + reg)
+#define msiof_status_clear(priv)	msiof_write(priv, SISTR, SISTR_ERR)
+
+static void msiof_update(struct msiof_priv *priv, u32 reg, u32 mask, u32 val)
+{
+	u32 old = msiof_read(priv, reg);
+	u32 new = (old & ~mask) | (val & mask);
+
+	if (old != new)
+		msiof_write(priv, reg, new);
+}
+
+static void msiof_update_and_wait(struct msiof_priv *priv, u32 reg, u32 mask, u32 val, u32 expect)
+{
+	u32 data;
+	int ret;
+
+	msiof_update(priv, reg, mask, val);
+
+	ret = readl_poll_timeout_atomic(priv->base + reg, data,
+					(data & mask) == expect, 1, 128);
+	if (ret)
+		dev_warn(priv->dev, "write timeout [0x%02x] 0x%08x / 0x%08x\n",
+			 reg, data, expect);
+}
+
+static int msiof_hw_start(struct snd_soc_component *component,
+			  struct snd_pcm_substream *substream, int cmd)
+{
+	struct msiof_priv *priv = snd_soc_component_get_drvdata(component);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int is_play = msiof_is_play(substream);
+	int width = snd_pcm_format_width(runtime->format);
+	u32 val;
+
+	/*
+	 * see
+	 *	[NOTE] on top of this driver
+	 */
+	/*
+	 * see
+	 *	Datasheet 109.3.6 [Transmit and Receive Procedures]
+	 *
+	 *	TX: Fig 109.14	- Fig 109.23
+	 *	RX: Fig 109.15
+	 */
+
+	/* reset errors */
+	priv->err_syc[substream->stream] =
+	priv->err_ovf[substream->stream] =
+	priv->err_udf[substream->stream] = 0;
+
+	/* SITMDRx */
+	if (is_play) {
+		val = PCON | SYNCMD_LR | SYNCAC | TXSTP;
+		if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
+			val |= DTDL_1;
+
+		msiof_write(priv, SITMDR1, val);
+
+		val = BITLEN1(width);
+		msiof_write(priv, SITMDR2, val | GRP);
+		msiof_write(priv, SITMDR3, val);
+
+	}
+	/* SIRMDRx */
+	else {
+		val = SYNCMD_LR | SYNCAC;
+		if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
+			val |= DTDL_1;
+
+		msiof_write(priv, SIRMDR1, val);
+
+		val = BITLEN1(width);
+		msiof_write(priv, SIRMDR2, val | GRP);
+		msiof_write(priv, SIRMDR3, val);
+	}
+
+	/* SIIER */
+	if (is_play)
+		val = TDREQE | TDMAE | SISTR_ERR_TX;
+	else
+		val = RDREQE | RDMAE | SISTR_ERR_RX;
+	msiof_update(priv, SIIER, val, val);
+
+	/* SICTR */
+	if (is_play)
+		val = TXE | TEDG;
+	else
+		val = RXE | REDG;
+	msiof_update_and_wait(priv, SICTR, val, val, val);
+
+	msiof_status_clear(priv);
+
+	/* Start DMAC */
+	snd_dmaengine_pcm_trigger(substream, cmd);
+
+	return 0;
+}
+
+static int msiof_hw_stop(struct snd_soc_component *component,
+			 struct snd_pcm_substream *substream, int cmd)
+{
+	struct msiof_priv *priv = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
+	int is_play = msiof_is_play(substream);
+	u32 val;
+
+	/* SIIER */
+	if (is_play)
+		val = TDREQE | TDMAE | SISTR_ERR_TX;
+	else
+		val = RDREQE | RDMAE | SISTR_ERR_RX;
+	msiof_update(priv, SIIER, val, 0);
+
+	/* Stop DMAC */
+	snd_dmaengine_pcm_trigger(substream, cmd);
+
+	/* SICTR */
+	if (is_play)
+		val = TXE;
+	else
+		val = RXE;
+	msiof_update_and_wait(priv, SICTR, val, 0, 0);
+
+	/* indicate error status if exist */
+	if (priv->err_syc[substream->stream] ||
+	    priv->err_ovf[substream->stream] ||
+	    priv->err_udf[substream->stream])
+		dev_warn(dev, "FSERR(%s) = %d, FOVF = %d, FUDF = %d\n",
+			 snd_pcm_direction_name(substream->stream),
+			 priv->err_syc[substream->stream],
+			 priv->err_ovf[substream->stream],
+			 priv->err_udf[substream->stream]);
+
+	return 0;
+}
+
+static int msiof_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct msiof_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	/*
+	 * It supports Clock/Frame Consumer Mode only
+	 * see
+	 *	[NOTE] on top of this driver
+	 */
+	case SND_SOC_DAIFMT_BC_FC:
+		break;
+	/* others are error */
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	/* it supports NB_NF only */
+	case SND_SOC_DAIFMT_NB_NF:
+	default:
+		break;
+	/* others are error */
+	case SND_SOC_DAIFMT_NB_IF:
+	case SND_SOC_DAIFMT_IB_NF:
+	case SND_SOC_DAIFMT_IB_IF:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		msiof_flag_set(priv, MSIOF_FLAGS_NEED_DELAY);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Select below from Sound Card, not auto
+ *	SND_SOC_DAIFMT_CBC_CFC
+ *	SND_SOC_DAIFMT_CBP_CFP
+ */
+static const u64 msiof_dai_formats = SND_SOC_POSSIBLE_DAIFMT_I2S	|
+				     SND_SOC_POSSIBLE_DAIFMT_LEFT_J	|
+				     SND_SOC_POSSIBLE_DAIFMT_NB_NF;
+
+static const struct snd_soc_dai_ops msiof_dai_ops = {
+	.set_fmt			= msiof_dai_set_fmt,
+	.auto_selectable_formats	= &msiof_dai_formats,
+	.num_auto_selectable_formats	= 1,
+};
+
+static struct snd_soc_dai_driver msiof_dai_driver = {
+	.name = "msiof-dai",
+	.playback = {
+		.rates		= MSIOF_RATES,
+		.formats	= MSIOF_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.capture = {
+		.rates		= MSIOF_RATES,
+		.formats	= MSIOF_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.ops = &msiof_dai_ops,
+};
+
+static struct snd_pcm_hardware msiof_pcm_hardware = {
+	.info =	SNDRV_PCM_INFO_INTERLEAVED	|
+		SNDRV_PCM_INFO_MMAP		|
+		SNDRV_PCM_INFO_MMAP_VALID,
+	.buffer_bytes_max	= 64 * 1024,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 8192,
+	.periods_min		= 1,
+	.periods_max		= 32,
+	.fifo_size		= 64,
+};
+
+static int msiof_open(struct snd_soc_component *component,
+		      struct snd_pcm_substream *substream)
+{
+	struct device *dev = component->dev;
+	struct dma_chan *chan;
+	static const char * const dma_names[] = {"rx", "tx"};
+	int is_play = msiof_is_play(substream);
+	int ret;
+
+	chan = of_dma_request_slave_channel(dev->of_node, dma_names[is_play]);
+	if (IS_ERR(chan))
+		return PTR_ERR(chan);
+
+	ret = snd_dmaengine_pcm_open(substream, chan);
+	if (ret < 0)
+		goto open_err_dma;
+
+	snd_soc_set_runtime_hwparams(substream, &msiof_pcm_hardware);
+
+	ret = snd_pcm_hw_constraint_integer(substream->runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+
+open_err_dma:
+	if (ret < 0)
+		dma_release_channel(chan);
+
+	return ret;
+}
+
+static int msiof_close(struct snd_soc_component *component,
+		       struct snd_pcm_substream *substream)
+{
+	return snd_dmaengine_pcm_close_release_chan(substream);
+}
+
+static snd_pcm_uframes_t msiof_pointer(struct snd_soc_component *component,
+				       struct snd_pcm_substream *substream)
+{
+	return snd_dmaengine_pcm_pointer(substream);
+}
+
+#define PREALLOC_BUFFER		(32 * 1024)
+#define PREALLOC_BUFFER_MAX	(32 * 1024)
+static int msiof_new(struct snd_soc_component *component,
+		     struct snd_soc_pcm_runtime *rtd)
+{
+	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
+				       rtd->card->snd_card->dev,
+				       PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+	return 0;
+}
+
+static int msiof_trigger(struct snd_soc_component *component,
+			 struct snd_pcm_substream *substream, int cmd)
+{
+	struct device *dev = component->dev;
+	struct msiof_priv *priv = dev_get_drvdata(dev);
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		priv->substream[substream->stream] = substream;
+		fallthrough;
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = msiof_hw_start(component, substream, cmd);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		priv->substream[substream->stream] = NULL;
+		fallthrough;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		ret = msiof_hw_stop(component, substream, cmd);
+		break;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
+static int msiof_hw_params(struct snd_soc_component *component,
+			   struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params)
+{
+	struct msiof_priv *priv = dev_get_drvdata(component->dev);
+	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
+	struct dma_slave_config cfg = {};
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	ret = snd_hwparams_to_dma_slave_config(substream, params, &cfg);
+	if (ret < 0)
+		goto hw_params_out;
+
+	cfg.dst_addr = priv->phy_addr + SITFDR;
+	cfg.src_addr = priv->phy_addr + SIRFDR;
+
+	ret = dmaengine_slave_config(chan, &cfg);
+hw_params_out:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
+static const struct snd_soc_component_driver msiof_component_driver = {
+	.name		= "msiof",
+	.open		= msiof_open,
+	.close		= msiof_close,
+	.pointer	= msiof_pointer,
+	.pcm_construct	= msiof_new,
+	.trigger	= msiof_trigger,
+	.hw_params	= msiof_hw_params,
+};
+
+static irqreturn_t msiof_interrupt(int irq, void *data)
+{
+	struct msiof_priv *priv = data;
+	struct snd_pcm_substream *substream;
+	u32 sistr;
+
+	spin_lock(&priv->lock);
+
+	sistr = msiof_read(priv, SISTR);
+	msiof_status_clear(priv);
+
+	spin_unlock(&priv->lock);
+
+	/* overflow/underflow error */
+	substream = priv->substream[SNDRV_PCM_STREAM_PLAYBACK];
+	if (substream && (sistr & SISTR_ERR_TX)) {
+		// snd_pcm_stop_xrun(substream);
+		if (sistr & TFSERR)
+			priv->err_syc[SNDRV_PCM_STREAM_PLAYBACK]++;
+		if (sistr & TFOVF)
+			priv->err_ovf[SNDRV_PCM_STREAM_PLAYBACK]++;
+		if (sistr & TFUDF)
+			priv->err_udf[SNDRV_PCM_STREAM_PLAYBACK]++;
+	}
+
+	substream = priv->substream[SNDRV_PCM_STREAM_CAPTURE];
+	if (substream && (sistr & SISTR_ERR_RX)) {
+		// snd_pcm_stop_xrun(substream);
+		if (sistr & RFSERR)
+			priv->err_syc[SNDRV_PCM_STREAM_CAPTURE]++;
+		if (sistr & RFOVF)
+			priv->err_ovf[SNDRV_PCM_STREAM_CAPTURE]++;
+		if (sistr & RFUDF)
+			priv->err_udf[SNDRV_PCM_STREAM_CAPTURE]++;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int msiof_probe(struct platform_device *pdev)
+{
+	struct msiof_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int irq, ret;
+
+	/* Check MSIOF as Sound mode or SPI mode */
+	struct device_node *port __free(device_node) = of_graph_get_next_port(dev->of_node, NULL);
+	if (!port)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENODEV;
+
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = devm_request_irq(dev, irq, msiof_interrupt, 0, dev_name(dev), priv);
+	if (ret)
+		return ret;
+
+	priv->dev	= dev;
+	priv->phy_addr	= res->start;
+
+	spin_lock_init(&priv->lock);
+	platform_set_drvdata(pdev, priv);
+
+	devm_pm_runtime_enable(dev);
+
+	ret = devm_snd_soc_register_component(dev, &msiof_component_driver,
+					      &msiof_dai_driver, 1);
+
+	return ret;
+}
+
+static const struct of_device_id msiof_of_match[] = {
+	{ .compatible = "renesas,rcar-gen4-msiof", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, msiof_of_match);
+
+static struct platform_driver msiof_driver = {
+	.driver	= {
+		.name	= "msiof-pcm-audio",
+		.of_match_table = msiof_of_match,
+	},
+	.probe		= msiof_probe,
+};
+module_platform_driver(msiof_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Renesas R-Car MSIOF I2S audio driver");
+MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
-- 
2.43.0


