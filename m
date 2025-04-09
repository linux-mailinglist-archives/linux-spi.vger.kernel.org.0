Return-Path: <linux-spi+bounces-7496-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB012A83474
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 01:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEB444276D
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 23:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5623021B185;
	Wed,  9 Apr 2025 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="P4/7IYqV"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010060.outbound.protection.outlook.com [52.101.228.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703FD2135AD;
	Wed,  9 Apr 2025 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241148; cv=fail; b=pkicx/3KuNzNaXcbvAO4L+ccNzr8r3d312/4F6sCHT49YUCtOUge1VL1/1FZ4HbNlk8VP/kVUYmEiQftEZTZvbnbk47IPo7XWpiNbTZPKZh9wSWZLlVwT5VPR+Hdr9rCoYE5kMbBzeCJ9L76Ly3QMMp4qEyE3+OzBQ/SyEf+ACk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241148; c=relaxed/simple;
	bh=0ARhvXZtpRFdc5AjSSL6CC+gqSBvlgf+h0B1hW1Yr9k=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Ta27WZt8AjtTeEkYhBiBwEwD+IFmylp53Zdnw82yuV8QI+jiiWNc8ZjEeqovaDF0iOsOOpKCBTdcjFJVaz3nGqmC/W0QU9hK4AHiSB+prMEOz4MZveErQA+TBHoIqDRH1SypFU8FyXEoC+6upokhEFefnTOSofHij1frC3Ou2Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=P4/7IYqV; arc=fail smtp.client-ip=52.101.228.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7H616R3s5nLzDENivN6q+1CfzuH1MehRcP7+SPeG9pGCu9ok6hnMaQvplL9xD9FvpbDAzzLKxYiFxiji1l3ogaZe3CHByHBXcuZWxZ6q6L8167tmqnFMSL3t5tQv1LY++m2UvFTWzW0XI8SoKkLyh99ffSDu+if04N8scC1jU1umpWSHNgz3AHejmWuzIXIZ4JoxIdCq7KHY/iE2FQ3sz4W6wFKKUyNE99/aVNVcCRupQHKN5buYGKOP+B8k0E0Z8f3RhmqeD6yp6XsSttbf0UJvtwDYMdA7x2vK8yRPxzZYIgNYpjDO22InFSI+nYdoJc8kfn+Ibd1qe1D1/6aHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CLz6LrMhyBUWWVqvBKB41rIEIFcL7uFu3vDIOkemhA=;
 b=GJ8RrvKUzGnWVlBc4dzg2VZwhStRymN3KQZ9d/VcdMO0XHDS/B/cCX31RCFEuiRXUUhlQvbhRuIXiy1rMSqGW2wwINtaEAwrjKWXeWpXwC6iKnbUUhC2Hv8tELLzClQbB9+kRI1m35s9l9t9xBGfwvS6gZx2He2rVqlKN82SQes9AwTwtELN9R2nvdZhNEERfmYopAl6KRGpog5INjwhseHF41S6LCkIGMU4w44Pt/M6ARZfAI0U0nhCpgnN2it+4Mrc8CQdsCfgqQDpEfjuaE8mLnOgkc00BLiu3H04LU4zm/dWTQ2t+ivzOCvnWlAncKdytWBzQmkiJahZ+/hbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CLz6LrMhyBUWWVqvBKB41rIEIFcL7uFu3vDIOkemhA=;
 b=P4/7IYqVMJ4pBe+m5fMfRIDASz8J9Q1o7S+SZ23zpxyOhkbmjsEkNvaY9fios9Ml3N0sag5HVN2E2ltTlEfAKv4vhHAGQlb5yexbLQTvYR9UPmwBu/8OsaXXDarjEBDLMxbJ0yuvuP/WhXbSn8uNeTdLWqZx0AaaNsyZuvCLxz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY7PR01MB15798.jpnprd01.prod.outlook.com
 (2603:1096:405:2c4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 23:25:37 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 23:25:37 +0000
Message-ID: <875xjcnci6.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH 6/7] ASoC: renesas: add MSIOF sound support
In-Reply-To: <24d1c5d9-0eeb-4f59-86bd-cd3690145981@kernel.org>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
	<87wmbu9may.wl-kuninori.morimoto.gx@renesas.com>
	<24d1c5d9-0eeb-4f59-86bd-cd3690145981@kernel.org>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 9 Apr 2025 23:25:37 +0000
X-ClientProxiedBy: TYCPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY7PR01MB15798:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ddd362-78e5-441f-81bc-08dd77bdd5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UhsNclcsWKCckX4165c3W3hMjh4izP7Sk3V+L/E2YWiI7z6kVuSMl7HQlkMZ?=
 =?us-ascii?Q?cQa2IKba732WMpC+x0m/b89DL1UgsW22k+6Az9o/U7xGcXpjKbNf+Spj5LJR?=
 =?us-ascii?Q?HsvBZ1A2EKX8vbmtKza19c6ig4+niM8UQMgCeG87a4D3bfhvSOzTkz/wpjTR?=
 =?us-ascii?Q?sz6B2B7E3oeDfBnhxWW/J4uUnR8s2Vhf4pYPAkgwf7TmYxr/YYMXgjk9wLYm?=
 =?us-ascii?Q?zwe5kcJugdyvMOGBrRGHaZbDzvmoMRey6NyoVvTRSAH+UnSyxgh3MYQb8G8E?=
 =?us-ascii?Q?mxyMyc3dNLjfkigI2o1jmenKW/pazMOTR/15Yk3AwuuadYGTCi50FQUlRh3H?=
 =?us-ascii?Q?KdBVU0TW5AFGa5YT4d9HCiIXp5+47pMa0KwaskEp4wFHid0IDWv/zF8jQ23d?=
 =?us-ascii?Q?Md2uVlJKgXLlpiaBXKnwcG/RY2zCW2P2CYvtzmi5AeUkYx7g8EKUIZulaSci?=
 =?us-ascii?Q?xAlEIiLatoEZOBSlOVQJLRWGRxj5yT2dwFN+c83md2bbKSXTjJhjL2dYkbzr?=
 =?us-ascii?Q?p3zUSO8q0m5LLoOk1QuWLgm8Icb2dnVSpYwf/1WiR3yMJ+TlBLhWK7Y9EmZj?=
 =?us-ascii?Q?rETxs/DaBxUbQFEjyLxelJCRiofKnxXMN2/SmmNfEzYLJyMVzN3bZJ9ixg2x?=
 =?us-ascii?Q?sPq9QzFUWUqrEIc9t2Y7H9ur9wnIEy3arC+uooLCU/3jmszLfS02+I4hRJFX?=
 =?us-ascii?Q?fBrGy6WS7y12vp9Z4kuFsgBHrDFWJIPKu4lrNzVMQl9wXJpWKA/KreilzZlf?=
 =?us-ascii?Q?TBffCyUrCrQEjivdyRidir5SzfX+k+m/yyw5Dm2DdNCk4XadKnUEQynxMJlM?=
 =?us-ascii?Q?/MiDIGi3gOlkLwG04S74uncKoXEy2FJ3Mt4yOOAVlCOnRrXEG5KJNiB4VJIZ?=
 =?us-ascii?Q?LTwhYHqA0MsVopMEEf0294rgg9jdsca7Gr1QEJf2lCkGKa+JFc0GPM6hQ1i5?=
 =?us-ascii?Q?Odv9tWPWiznuLnmwEVApnrIrZ1/wJC/SpBvKjAOeuBl/dkzLsKN5sxRijRIB?=
 =?us-ascii?Q?Uky6C/9xm4PmFZHjTbJF7Op/f3BbhzlYBGUJOz+WP4AkRxCDADfdFE0otHRm?=
 =?us-ascii?Q?gTdx4SC2gQgDA10vH3RwEqlJ/C/fJ9K8B5VeoGhkQQT/wPU9voZu1GYg5qF/?=
 =?us-ascii?Q?r2qeXN571RSfXL5elMzDuc8Uby4Fl6aNoy3T63mg7SWx9Lg4Ryl6biC8honb?=
 =?us-ascii?Q?7f1IhfDssVZ8l6dwZL6F8lD493hHM8wyxT6vi94OWJtLQQqmTyEJljjfXjLT?=
 =?us-ascii?Q?P9Sse3eLxC2czjbpOMimIkm41Qyr18X3BfjVmdkb50ga3wn92wWN8HaaiBQq?=
 =?us-ascii?Q?8WEWfP6GvA/U9p7cbcp1aEw8xDsdKzVtSl7tPy6Qe4Pefn5JLf4Zb/X6+juX?=
 =?us-ascii?Q?cM5sBhTCcnM5dYAfoFKoJJJsRkJo1JT4xVAk1/17mLNHOxk+ykQhKJb4hK6Y?=
 =?us-ascii?Q?44IhEJi+pfXrVVVwvQyBVausiz60OSuMPXB9mOFPtPlsh512mj5fcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QJevoijIOs6khZCjFGwEZEvXPvZLT1nL6RZzBkBADnAkN40X+zbBbPyxhRPH?=
 =?us-ascii?Q?BinKTfQvnHIGiBC1+kgsdSm9jZCYsLoTSEbeO7owCio72lAiLnBYlqjoSHW5?=
 =?us-ascii?Q?a6XL6RhrgtI0mvMSjKQE07LHAphtT5akTM8+j24yDlR8Zfn7kPIw9vFEqIWx?=
 =?us-ascii?Q?muzqXrZwtADhE2J36a2DBmw1nxzh5hVK2TUznKJ3qkktxMZ7zktre8mPEw1P?=
 =?us-ascii?Q?GN+00Jtufj8dQmG3roKatPGNs3366EJyQlct1cDi/iMlzgR8fziv4VT6+S3i?=
 =?us-ascii?Q?DkGZECp3EEsNZ0TIwV9MQP1PNeIUqUNyCcxmfvDml5TKtDVYMIez8RctHlE1?=
 =?us-ascii?Q?MgxnpQdfeKG1AGMrz/U1m1WdRtYOz7lik8LLChbRlq9vpVn6SAFAQIZIfOSL?=
 =?us-ascii?Q?boRTZFvwJQ6ycNvNWuV9K7jXmmsTxqyjtD1Yq88terjnPNuHi+j3RznjkPYC?=
 =?us-ascii?Q?VeqiwkkQaZIN4mH+rNGeNivxfIFD3aJhLDEm4N5IJH2SXqsHfNY0g+eaW5Or?=
 =?us-ascii?Q?f2BIWysF6CSpsjFFzYonM03bx5jTY+LsCMrbVn6YYXpV12jf9XGkXx1KLAHu?=
 =?us-ascii?Q?CdMR58X2Jo3c/Z/vdqMpslIXGR+Cg2NYljGeJAHGBCVkoiDt4uAk4FwqQOoD?=
 =?us-ascii?Q?L4D4DFvjF8Eg/nuQzIaZnog3YHAVvEvM5tAchVig51Wtp+QpJ7pSADvg6vIf?=
 =?us-ascii?Q?57EWzqJGLmuQfTVp9lecZV7Tbfk1bNLeTQsxPnY1sCaDwZb383rsOi1lyfKQ?=
 =?us-ascii?Q?5m0VDOskmNlm0oxQzpBNGXIT4j1+tWxhykIXUwgvnq+sZDidJdZy5K8eRlgZ?=
 =?us-ascii?Q?RgX8XupPzwu5YpyUxeGn43/FTBfDykLXd0CZNqIjg2pS9l2DfDRcHnjPlyDI?=
 =?us-ascii?Q?2/2h3aeXPFpKY+CvMP4Hgmw0MG6yKoPV6fV70peTqCduNoBIt+qbQPHnli3M?=
 =?us-ascii?Q?Z4C2E3WTXE0/ecG8TrZLbo20YLwwPkpdbkaOQzXjzc1x0RVBuUZxrDgwMNBI?=
 =?us-ascii?Q?ZkHhp42DF0eSKL1WCf3OacOTinO98rrTVRqGLkFqK+6kyZLHpoC0oPbedY6a?=
 =?us-ascii?Q?nRLWASSy72hgiF9UOb3S8xAZgxLCn+uuM8DZjSNnG6NVRGrKP5dsh+xmpfUc?=
 =?us-ascii?Q?MW+LGwlvJ6ZaI0jOxFInFyEz6S3pu6bFCA9qaGYd7ckzM0TBSltv2MiDLHnQ?=
 =?us-ascii?Q?2Mn60ZWU/HJj5XqV2L4fI1+qnUisPpy4kA7XrZLdkoKyFA+LIBNbMz0+q1Lg?=
 =?us-ascii?Q?AB3xm2Xwo+CZpPyuVdKize1IFfP+rZfEjwBmc+tiHijDVydRv42bAKXtt59s?=
 =?us-ascii?Q?+ZOhN2KErDwEh50KVf0J3Q8XsXtvRStgngPZ/M2JaHS9fAJ8MhSC9vrnZu1Z?=
 =?us-ascii?Q?qmo1QAIwKLc0nbM7E7WCd7/VMNuai/KZEwwQimWB7UylLZQfWedX+t9+JPXV?=
 =?us-ascii?Q?rQqMkAfbQg2TgGEOqWWdLidN6mx4wsHDvp70Ow93NtVKnhoS7+swG7ZuWI5j?=
 =?us-ascii?Q?YBHXqWhsWUoUXT6gQTbRyaZgtiVEwDP85GbVO5mQ6OTqKq+uXVwuITMP/xR9?=
 =?us-ascii?Q?qox4qrV2+1DOXIorF1SgQlxMKDkAs3RfVZE1xHv2Jema9un7sBPRo8qfIVm4?=
 =?us-ascii?Q?1lM7RhBu6Lj+LeUqhN6mdxI=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ddd362-78e5-441f-81bc-08dd77bdd5de
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 23:25:37.8520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVm24TtLJGdYzWP6g20e0b01R1grICn5TBkMeckIlbkbIWhbs82iWE1spey4WZM4vrULpMAzvTP6jJ0PVM3TdVe4KGqefaR1b3JiaaFOzC8ZM4IyEEQceEaBPlS6y66g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB15798


Hi Krzysztof, Mark, Iwai-san

> > +	dev_info(dev, "probed\n");
> 
> Drop. Driver should be silent on success and simple success messages are
> useless. Core already gives you information that probe succeeded.

What does "Core" mean here ??

> > +MODULE_ALIAS("platform:msiof-pcm-audio");
> 
> You should not need MODULE_ALIAS() in normal cases. If you need it,
> usually it means your device ID table is wrong (e.g. misses either
> entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
> for incomplete ID table.

Iwai-san, Mark, do you have any comment about this ?
Almost all ALSA drivers are using it

	> git grep MODULE_ALIAS sound | wc -l
	249

Thank you for your help !!

Best regards
---
Kuninori Morimoto

