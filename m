Return-Path: <linux-spi+bounces-7500-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD83A83691
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 04:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23913BAD38
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 02:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF931E25F2;
	Thu, 10 Apr 2025 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="YFqwplF9"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010068.outbound.protection.outlook.com [52.101.228.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB91E1A18;
	Thu, 10 Apr 2025 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744252662; cv=fail; b=bIzcl7CHALfjgOYaCvnebWaXlN6Tq2l0Dy+Yc75AJhSrifUOP9REpBFukuWiTEjesGm3NJAX2zVQsAfRr55yiqFjuMiQjnqlOXVhjmhDngGu1/kKbkcftE43Z3cJgIUO4Fm7zhPH0mtB+Mc+F8gLkuUBJcYhowUHxEDIUEkrzME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744252662; c=relaxed/simple;
	bh=aiHRI822eZgfHxER0rY0NNbODvdW6VeNd0z0rgO2P5E=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=OQjaphpI9xEPRXG/3DoZ9KOwscs4OJIvY1muVmf/gdfAGP4FHUxdTK3J49eum+gQJVmvwbUr/5HJ4ZHUdK8oioT0YcCbxEFBSfOrzHMh+2GY2KPuqc0lW8y6EJ/5fesWcj73Ec3aHK/trCUP3FgOu8ryuuNWD2lUMV4+Bgfdt+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=YFqwplF9; arc=fail smtp.client-ip=52.101.228.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVPsAqftW0vhtKA58ZDlqFmO1bWJwWK9skTTWgRlEpv6n4qx0ZYGjhlXvWoUamwups49Og1XWMLRxqtzoXzvio9NkvowCMQAE4I/vnii87QU+/3K+JPvCD5ThL2dTnTVMH7d8PM1ycR4aQ9w8Y/+bXWJY5DB1+rZokWfk3RByR0Eg/r1QEvemQSAB7UyLrqlRexczRf/hHGMGN6Oo6Qz2QNCsvy32q4/DoB3wvPV+8/rbt+pjmfUkl9JM1kfF0CdKfy2nP3mST0NhqHowd9F9hpQAvHFknre1Jfkf7X2DEnYlgcgmSHpw0RBoqkVQ+RyuG39ki0l3wSVkY6gH+6oYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQXGV66aJeZoS2m8p9M99CKvCL/7cD5OM8LFloyyv8A=;
 b=gj6vSiiCc2n4LlJSJjhHruqc7MX4Gd9HtOPjNfJqDeKOkg4h3FlypnMYsEopdaeaqnqBMKEYPq/8uVuaeXlGtUguFG/a+BDoRXd3voIytbTt1v+4JCs62RZunqG31JW3TxsSPiF0lC3yeLYnwBU+gesWsJ0JdfKXi548rxZjjc0Rx3wyGcdawZ42BUeD6YNQZdABog9WF8tUDJMnlw7gEDlpRLmDSwgrxxSv/zTVhGa1vJyglEBsbUIT3vu14bRu5fiVQN3JYfuXLal9vzyttfqcFVsOlxYl9gsa7WNn4aALqqVnfFe/a2VRWGDLwEfZiO+ElrhLBagM3aAKYW9T5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQXGV66aJeZoS2m8p9M99CKvCL/7cD5OM8LFloyyv8A=;
 b=YFqwplF9G29EMCX0du94hsChARTgt0blpGVuHf9wk15vZSG3a40ylmmzGXkH3xP7DA9Y9MDCBCM9FNHZShErPYA0hTWsFZevl1UXuzdHQgwYIDUppSYbG66I33xudiodmdNzYTXM3P/x/tA6J4lRFhhgkKXbIohpXY6UhkiNkbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS7PR01MB11837.jpnprd01.prod.outlook.com
 (2603:1096:604:23a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 02:37:31 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 02:37:31 +0000
Message-ID: <87iknclp1w.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH 6/7] ASoC: renesas: add MSIOF sound support
In-Reply-To: <8734egnbl0.wl-kuninori.morimoto.gx@renesas.com>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
	<87wmbu9may.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWL_C-Vg3d+fAK_nXvzeZNNPDkkzPjB1oHRKHh16rZUHw@mail.gmail.com>
	<8734egnbl0.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 10 Apr 2025 02:37:31 +0000
X-ClientProxiedBy: TYAPR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::19) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS7PR01MB11837:EE_
X-MS-Office365-Filtering-Correlation-Id: 2330097d-d9e3-4e0b-e0b3-08dd77d8a49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5So7/NrisTns4olJMz2aJ5Z9P1nttcevAmgCEucLWMsf8+rCuq9CcLXmfTkE?=
 =?us-ascii?Q?xDYy1BZ7kmyxN/lMtt0kvx6RdG+0j1ucV5L66CKtitU8FKkF7JynBRz+U5Ld?=
 =?us-ascii?Q?v3gitYC+3YEJ2cFh4uf87AuZPWWA0NPKnmp266sqDU9lvdI68rfyYO8BwEtV?=
 =?us-ascii?Q?/uxhagMOse488LTDHZab1tffBpI668GmYW322mATmBF20TU+Idd5FnNZU7yi?=
 =?us-ascii?Q?xBY+lxm9ILacCrNUFJCWHdOeKdoqECJDCpljPmdm9WG24UKTro3qZ1K24v4u?=
 =?us-ascii?Q?/k1t3K4ucO/fYe4TTMciBJVp0rqAYEgNJpHQNA276Dx9R5Fz1hKxcefmAKfS?=
 =?us-ascii?Q?YfUt/HQy6fpFJZGAg/O/z6MlgJgNY8yWUqpQgwZQ8zSpIn+/BBKXEjkZsb9A?=
 =?us-ascii?Q?3KoWjM7WQbH6wEVXIwjiNFkfEz7tNdaNrpMHeDjI5JJtpuQoUPntqBqiD+N2?=
 =?us-ascii?Q?bHuPLisjJNx9T/VpukSCJnNy1ltVIO3RJe5/NNc47BRNrBD2SfqLbeXjdmIw?=
 =?us-ascii?Q?vG2z40aWaPXoCezR7oHEiGgLLBlE15IeVVj7B4U83RwzKwfjCPBmktkpR6Xf?=
 =?us-ascii?Q?+7mh9FcBijmcCJAibuhUE/GZL2sivgPCDqhoTFSxMXzt03j+B+3DPWQ3sGPf?=
 =?us-ascii?Q?/8G5B1wzcW4X5+u0zWCaAbzZFFm8IHfH1KtqPDP8rydyGjQ2M5cJGPj/Iii4?=
 =?us-ascii?Q?37oCtmGvQT0Ql5FlNiXyF118pD91iJ6ldijM0OxT34eDmZaaopAp+nuQwGLi?=
 =?us-ascii?Q?kiBZPcUgOEnb+gHnSKrMyTLE6CVK5bMZIalupKu9T5KBRqwOOeXgdywycLHk?=
 =?us-ascii?Q?2L504QiSnh86FDg9pLe/wnhhyK/b0Taz1ClovD17Zs/Wj6SK9XmrbGibLTS3?=
 =?us-ascii?Q?RlKwhTCwiDjcFhWBaAQ6aL0jg51KYio1KObKft1n46PLpkpZFIgedzZr8jiJ?=
 =?us-ascii?Q?D9n0vaxyp28oRH2PnWci26YBKxLkxNZxd32fjOBu54sbwjPRp8M/5L3UEMCm?=
 =?us-ascii?Q?e9/GX7pewUSRQqa5dtxesLQOASdKZjvqLsU2irW7kX0N2HtDyYnFa+ip89vR?=
 =?us-ascii?Q?kHHu463nlL6sdIfHOlKvp5/InicWJH93gsv8k+QbCEtKSLtzgbW1Z6tw1YSw?=
 =?us-ascii?Q?jRGDMHVmLu072fBXse+OuuJeS0SQJCGAZdYkZkrJYwnW2PL4+G+QH3QcrwVC?=
 =?us-ascii?Q?it6KdKPgkyWiLEl/SLdicDqxE0sBPfIFtYwmUfsSR1QNp3Xx1KCCZkTwVD7b?=
 =?us-ascii?Q?czIXP0Nl7uAPFmVUEXKGjH8azrGasiOCQLDuLM8WjBrEYMsWfI+sIVImxkqr?=
 =?us-ascii?Q?NsN5YCmrVzHICD1Z0A15rLEO/UigfPZj6+aBQzH6TupeFa3gWtzMhslyJCNo?=
 =?us-ascii?Q?t+wgGPalvt1c5ZmoVPLqIHF6gA++d5HuxNxqbIxOwoUoefUL7/luPfPXUH9w?=
 =?us-ascii?Q?LBQNcaGxQvV1yWLHseaCKVnofEuSxyhZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?loJOnh9G2EP6JKCf8cc0NQhA5W7IzW+cP8W+geshPX1rOTAYflO87K3vs8oK?=
 =?us-ascii?Q?H6Y7UKDR4KvIHL4BDQNlIFlbhRDDkmBYbvCZ0Kkn4/o8Ai9fFfGCs9cjTtAc?=
 =?us-ascii?Q?c36SvNmPWYodHX8lnKTswLuixu3FCCE/8IxYXY0+t75ON7w3em1kUk7j20Q8?=
 =?us-ascii?Q?6zt5ooz0mAnN7cBHIm4XG+YYEdy5KIbvpoy8C1GMx5PFXJjKGe2GZtFtKMtl?=
 =?us-ascii?Q?dMUIpglqROtuII6PrbQZ3QD5ln33f3CJColwtFgpJpz27KiRbvP+h27+oDur?=
 =?us-ascii?Q?h7DYfzIthYqHJfjPVhzd8/oacTxhlYfOQ/JNNx5H5dzNd1M30xgAPQaNzwDX?=
 =?us-ascii?Q?K/P06U2R0GVEpNLi3oH7aw3jzctbdO93VOXO6ij3uzXTjmFISpaoZuPa6ilJ?=
 =?us-ascii?Q?2nM3NpNxhBssJUbg96oODh0XBGTJCFxpokbjiccgQ1gEVydUfKGwtwYoJe9A?=
 =?us-ascii?Q?COxxScvNC0g6kDisBHOltOxQlSFpkpkOlKYE/lKnBOCH+NZP+y3m0WCJGXaV?=
 =?us-ascii?Q?c3rQdw3vTtqHVH4Gp4bbig+45LSFs9IkLsZyT+pKWgVpfiArgooMuhrgcAFv?=
 =?us-ascii?Q?Eupl51pPEqvhPYA5STA7R5kYPK1uJzn21ByzdUNMvyxQP+7AgY9AmEEQVk50?=
 =?us-ascii?Q?IWkquv1D2j3X4G95iKUXLAHklSKPXaFMaIvYvRMfaMMrXmrsDtYwx6alywhx?=
 =?us-ascii?Q?f3cGWFbBRqNutNw70H1440ZCffFzs+mLMilrajg0g0vNX1HF3Jfmgd/WWMWK?=
 =?us-ascii?Q?YNmMfAZvHX2OLpVgFLkgE4M5u8rQe6DKHIrnojTvuXjpZlF1+kakF+rf2YzU?=
 =?us-ascii?Q?gLzN62+DQ+h4a6r7jYO1zd7e8TFNQSTyPjcQdznlDMeR0ucZfITYVppdhAf7?=
 =?us-ascii?Q?qiIqBZ4hTFboHolOsmkeu6opAoFfDvjUauZgy6oa/vQP2bi0SBjo2p94XHcX?=
 =?us-ascii?Q?6BIAErm3JQTRZ/D5ju3qUsohW67rKOOn46PlkbJBoCaCmaevEAorJGMOIR0o?=
 =?us-ascii?Q?eZzoUsdQ+LzV9satSmp0CIIGuNTPCtpdxidJFRnjyxz56aK2FN+mlXFP5asM?=
 =?us-ascii?Q?Bv60N6D+yvUC5NQVEg6pY3/+sNHebaOPV7QU9y2oT3P3hsln6eSbqjtelXwP?=
 =?us-ascii?Q?BMw16vsiAA2Umu+xOhMopKVEuDKKtQscbMz/zecvOiC7Mypq4oHowhWGJ5yT?=
 =?us-ascii?Q?hG1XldW4uGO6085dQ6RjGuYeNcfc5+XJHdQAxO2dKuAHgWRXL/iVkxnzcmXI?=
 =?us-ascii?Q?+li/1rfi3cB5GZdho1z8lwmKFmQ+qUVT/r3Rai5MJdrMin3Mfs9LxeAIbDL4?=
 =?us-ascii?Q?DSt7UV5PYyhqqfS2l2uNedXvH3MUR7fN4id4JYkkp3Fr2gbriHwBu0iWsroV?=
 =?us-ascii?Q?+wKona2bdpkiN9r7+ciBta6ayMg30GGQt/8WkEpB2EE9Fj5RwFo8fMKG9P/f?=
 =?us-ascii?Q?leM0xSc+mPn3Vlj/fxtFATe11eQJ55Uj3/+Ou1l9qDoo1On1Wl1veko8F6Ua?=
 =?us-ascii?Q?czbOGGKl84JRL+2tQMzoUqZmzDOy6eQSNb4N2MBlbI7ZQsXgGKj+s1vNVzPH?=
 =?us-ascii?Q?hlxoPL5YlWORNlhbTtwD2RVo8s3IEco0jVQctWe5u7RfT+tbTxvZrW8WvmwF?=
 =?us-ascii?Q?W4bbr/uZWMv5s2OJUI+Qvqo=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2330097d-d9e3-4e0b-e0b3-08dd77d8a49e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 02:37:31.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVPIJjyV5AhzNK97u3/QpSXYVtzPeVQZPUSXHyVkU6fd3SmjUAeq1qINFeZYjMZQmJI0VjRVBmXrdImr8z1w4aN4QrsB0IPi+JNm9V4D0YwjB5vkrdRy5CVm9GXAox3p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11837


Hi Geert, again

> > > +config SND_SOC_MSIOF
> > > +       tristate "R-Car series MSIOF support"
> > > +       depends on OF
> > 
> > depends on ARCH_RENESAS || COMPILE_TEST
> 
> Ah, yes indeed. Will add in v2

Renesas category Sound drivers are under below menu.
So, it is not needed on each drivers.

menu "SoC Audio support for Renesas SoCs"
	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST

Thank you for your help !!

Best regards
---
Kuninori Morimoto

