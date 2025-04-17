Return-Path: <linux-spi+bounces-7654-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A772AA92E30
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D0019E644D
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749BB221DA0;
	Thu, 17 Apr 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="PJMt8nTw"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010002.outbound.protection.outlook.com [52.101.229.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3522171B;
	Thu, 17 Apr 2025 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932170; cv=fail; b=pFuG17I/TPvJEjGBnHjocE4JD1XPWJCcstjEU0UiS6AB+lJdSbMw8fsvyPaeu8Rm5lFFbX3T/jaVpOawzvKa9d3q3+f5LAIHsWQqrnAD3RxOM40nHtHyV/eF8dk9ku9rCCnmZOrz/ThkpqKKKf18HVGnmVKY8r4YIZoeGaZTrck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932170; c=relaxed/simple;
	bh=T4y+HFPE29lMsu8WmpmPY5hy0xghp6v3laSPvCxcuHs=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=QqT9QWMxG0XGVpSk9HMclsND5cRoTNdx/N/1qSyGm55lys/T9ikBkJ7cMJuKwYVVqHPDPerwr45JlH8GNrktC1/35jlT4leXHf05cfUR85nNFhcOPkKZszhz4SiXLvC6LV6qbyETCbdaNADHjZ42+VixS66tApFgA0LlAx6xBHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=PJMt8nTw; arc=fail smtp.client-ip=52.101.229.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqyAD9ce3pJGQ0OnW2ESokVIX+Ai5TpNNiSvDraM/XjXtWg8fV+xbOkYq4xrTkrCfhbMrnbbDHiLzyRzuBHUj6KzA8lje8n3XpO8FYoiaraox3IX7fosS2HL/V1J/Q8LE1un+K+HEvtwiwlrsWv8lo5oZE27OCHX4t0XA+uFtZPs52vFSiOWiLMtCtAxk7A2qFDcw7B9W1oJN8iRCpKG9XeOyyEU8exJj9ozlgVfxYTD7uI0nRYPyLRSLIznl59TFOol/s+92Y7J1UOYNSloX8IZVlnu5YsF/Oz6uXTphYmJHsEZHtgI8xJqFtxhG4/0pztqvYDvyQZlHOMv3KsNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTmBaMJ8sqvOgzT6lyuIX/IKY23xArgla2KVJIyMSeQ=;
 b=frka576UrnyMRpUD0uu1yCUKIXY84u5J+ya1ajRWMynLl9Ht2GmcKZAEKFzSBw6Tx0GFFfrtrYgPJSsQNtX4biww8vdWMCsHzvOM5XgFvT7dvPvMbG9yBf3p7JqzJb1+N2SSRehIp7btYL8PTya3u+9jLZVxqvdcimO6sY6VW0EAjuZptXznXWJH1d7kPsTfIub8v0AQQvkEGMgQuuAPN0dPYFPQQYEKhw2hoD6YslSBbt3KUytT4KseINIzMCne/1e05fzbn/fF7AoQRZAfpcFZpcEYn6Aqf/adP+cT6vVXIgIWdXJyFDNp986rRS82ME5jcmOE9zsecAcrgq1M8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTmBaMJ8sqvOgzT6lyuIX/IKY23xArgla2KVJIyMSeQ=;
 b=PJMt8nTw0+PeqX99bSCz/c4RUE9CwcydnzmDsK3KSTTiMvwSRyzAImyJ+6rrzHBXYgg8O0S3bS1m0yc3t9gCQtuuutHjIeyyVX8lMeG//bl39IO0oLMSRpth81glJlLSUcsrlmMvgK1elC2OpZ9Fz22q2sBAtO5k7f8/k1G88u8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB9998.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 17 Apr
 2025 23:22:40 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 23:22:40 +0000
Message-ID: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v4 0/9] ASoC: add Renesas MSIOF sound driver
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 17 Apr 2025 23:22:40 +0000
X-ClientProxiedBy: TYCP286CA0251.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::20) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ea69b2-bf3b-44cf-9495-08dd7e06bf82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DyCjOzGJ1UB37TYltgr8Ghgs17TaPjKImvxnmtDrEDs8DlEhk1VCbl1xNf1b?=
 =?us-ascii?Q?N3V8+ApzU8Zb8iiFmmsSN5ORXZTETFhB59RmMOwBFo6VByXM1cn/2b7VsJIM?=
 =?us-ascii?Q?+CyVtqGeXTFLJMTdESC4Ss4Mh1JieOX3ElroIFr9RL/fOp8bFrbFGmIluwPY?=
 =?us-ascii?Q?FbqTU6YTHwafU3bpvNwmyxNMpadh77RFU4seUEpNOAdei8BobvBRR0OcT6/X?=
 =?us-ascii?Q?E4Gr38R9r6IdA4ZiWYiEhABplWjGBgGUdBxjLJ2ihmV4kpT0/PdL1VDj+9Yr?=
 =?us-ascii?Q?xxh23Gg+T6pyFlmFrxoHOaAtOmsLs312/QYz6mqSrbQzhT9t/Mb3tWX8ikc0?=
 =?us-ascii?Q?/zdr/nZrp7LEYfw9N1BUbn7fS0yVXkJaqciEwWssbmZMskExg25DDIwuu8+w?=
 =?us-ascii?Q?AZtP8QV+iFqVCXtT7gpdMxkdMboWzVbHbRsrAmZr+/IvQ7b68I0Ob5tGF8R7?=
 =?us-ascii?Q?i2pMnAar0kCeAH7rwOGlhGYASnXbI5wDSarFPP5/BRGmNw+zw5F36xu4dLiX?=
 =?us-ascii?Q?G6MVH6AGN7MD3oJFiD6LxP5ZH2ZDcnz7S5LwNFO6Fe4NU+lSn1ktRm3l6aA8?=
 =?us-ascii?Q?bhno5QEdUw6ywDeZSHISGliirlA76U0C+b4ly9DvtZQA0bemeAbqE9LFMGGn?=
 =?us-ascii?Q?Uu6fg0RBiQd5UHE4OBGmcmam2v079aetFEmk8j4B2jdnkvAEUH5kcOWGm/NW?=
 =?us-ascii?Q?PWZldpnBDheaQM2nZHvRYuud30xUd0LgjXe297Nx3pTY/FreSGb93VvNYrIv?=
 =?us-ascii?Q?jNk65thIHSovS8ToptbN6arFl2Qtyg6CZLdCg23x3eJvf8F36RsgOml5LKcj?=
 =?us-ascii?Q?wt44KQXGVlp3365oYC/4Cfju5EYfowfHi6pCldkK85IkiddGkjoiCSVTfE8k?=
 =?us-ascii?Q?neMNzuxD0eeplv0Wgz6sNUWsP2c4o2isvXC5paCGk2c0igYVGrohLoCURThI?=
 =?us-ascii?Q?NNQKG2VmH5si+ms0gtsVRpBmQ0A7lDw2Cjk70nUel7w2BYvlcVVc66vLZvoK?=
 =?us-ascii?Q?4y7GmAcID3lMbdnF/z+TRHyk9363mxF5v0en0cLtxJUgjaQfJC5BuwqG+i+i?=
 =?us-ascii?Q?3xqIapvrfgAkVV6JYC2gD7kvsOFQ9RaL8GmfcEJE6+hXkArh79OxEGUYIR4h?=
 =?us-ascii?Q?2A3v31n34Yh9D6YtZXDD46KEk5QwAiTdrg+EtCWIa8SRQDSraBw5xxuivHrF?=
 =?us-ascii?Q?ZfOQOXMxu64bTsUeTCFc3OyxSMLFqY4MLuyFtc4rl/Q/pQq84Os+6U3PN0Hb?=
 =?us-ascii?Q?cH8mOA3iPCC2Uc+WPvaYQSE5r0neXcgqUjyyPxfz2iZXA9l1mAlFPwIl9nKA?=
 =?us-ascii?Q?2wPyo5UxIjms1fr6pd3EH4LygAs9+5bXEK+nHIXnzQkvW4NvwruLSMaW92li?=
 =?us-ascii?Q?agkI83cZ8AU9bCY/56dAW1ZncHyMZ3YiJemx5TPUke7VTcaptGDEeppAm/1R?=
 =?us-ascii?Q?cCHhpiihs58u7iYu9CMB3cUuYFoST0m4u/VYPjDcfUlSjEB9pVop+DEn183Q?=
 =?us-ascii?Q?kn0OASUSzrv75PNGsAcudM98i2j8d82Hk5zS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BTIQcVieXiVo2LDCxpPDeg63ITt9JLKHjvrS0BbihXQHocskufBqZJN44Cgz?=
 =?us-ascii?Q?pkNBTretiAaqg7K9PThdxbe7lIuoZU+n+41OfYUSq8Ua/PESrBZiPmeuh3hP?=
 =?us-ascii?Q?rMcMW17EN8Z4VzJ3zVuSJZy7kWsDhgF1NAFO7fMjMRmiD8jV4MrJXiDmhL+6?=
 =?us-ascii?Q?dW678bhBgZL5C8bmES0UnIYSmAVNHKWK+8EktvieU82FAVCDd3E2NaF0tSZf?=
 =?us-ascii?Q?L2RUsdj92h1Q8W0riblMisQV3LvfzFEzL48ajPZi0sqIoUYTWNigGAH2fBFO?=
 =?us-ascii?Q?c+5Vm9MFEAZKYXbvrNl0RqYHkkrBwKooDnznTEY4MZ43m7a+FHJrA1JygEdH?=
 =?us-ascii?Q?ZF6HcD8SGtKx9P0+hq7mHONuN968fvgdQqqVi+cnX8aipHJmGwqn65NKBMH6?=
 =?us-ascii?Q?yBJx1E3sbh3ZwqpH5bGSFKGjgrVrecPz79fMzPy7nLfxGes+R5Yy7T5AROMm?=
 =?us-ascii?Q?AFUI7rZ5FX4xwx3hp/pS4LTWnTp0LZ4OgsFS5m8qcKNHReW1W8gyPbZQPlQE?=
 =?us-ascii?Q?ZvOCOAjNR2kMM19+MH3JMisRf1y+/Zu7hOkvdA01NHGqt+ve2N8t4J5RQXNA?=
 =?us-ascii?Q?wLz5GsQxfnwM8pwMKM7IwTZTT/7+TPzam6ELumLi7tnSziT+NSEWLFIBjV1y?=
 =?us-ascii?Q?WQX7YQHLgNhZa+a2rMhGecpWbHBflPh+KPbdCVQB7RAE4/ek+tzdK4qFnpjN?=
 =?us-ascii?Q?nF//oHmsObTlK/X/Jj7qHsg37ZK3rRp4qlmNTVKXgoHxNAXb0gmf5fK5xdqq?=
 =?us-ascii?Q?+Y8fMh8LKI5VT/9x3Qz86H5B+dCUwr1U92OiAXZgmrx3I5A1Npoq09b6b1o0?=
 =?us-ascii?Q?umND4btTgFolNas4By4H8TcPcVJwWa10c1YQr+qbaGAQBZpJ8RBJc8y878L7?=
 =?us-ascii?Q?QPZ8mHBh0VljqbAgyMnt6pO9SJxv1K8u8qG8LsREIKq8gSGWpBr0oQD23QJz?=
 =?us-ascii?Q?fvA8VqYjSSKGUOUUq4GQpfeLZAYA+Igqa98qpP3zByDlYtCqqDlHUG3TBhR9?=
 =?us-ascii?Q?w9OyNA6nMLPk2WP7xPxMqJ2MaJrIG11PHQl939dJEwevXnOKc1WPpA2SJ+bo?=
 =?us-ascii?Q?m/AIP/zPO+I9a29htogjHDHZ1tuXTXgAgKREeR7+njn7wkxQx/Ufxyt8LV/E?=
 =?us-ascii?Q?Cmft1zji2xBVxdhXp+KbyrPU20sVHTFUnxD8QDnsZZ8IsMBVf2gQfaFUlQ3f?=
 =?us-ascii?Q?Hm5urkYSMXL5c1hvZrPs9rbIL2lFqQltojkt/pgK7Jaj4gmUKNPqcxrA7j7E?=
 =?us-ascii?Q?4ST2YYNFmwRaJj9Eecq4Y2M21/+2kfgYwPQ+ISme2Rp8iwxXhbGMhNnB252z?=
 =?us-ascii?Q?TbkkEYBkQOFLLE5uMrWAZULlIhjRKrJBAngaKrDMH1jbiiTBZMxZ0i6rgws6?=
 =?us-ascii?Q?K2GyiBlvs598i5Ti5BQrIkfBXyeqZrc4Ch1Y4R3dWszInIM9EEIDTDdwdupO?=
 =?us-ascii?Q?ZvMaVFMYpp7o+dLZHCodWQmlQULWNla8dbrnuduk7nkhP30kX2/VGGlK0XtQ?=
 =?us-ascii?Q?qUI8tsLjbgu0lN5P1AMp3fC8T9fLpBpM+slN5SppmiDg1g+suy5qRk0vPIPE?=
 =?us-ascii?Q?Q5Fi+KLj+uP1xL0/3jTEzo/4f+aZLK08TVPU7qaHKj9vWwcNDsPdf1wzX4wH?=
 =?us-ascii?Q?ZqIMZo1g0J4hSfOp1w1JIJs=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ea69b2-bf3b-44cf-9495-08dd7e06bf82
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:22:40.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvDQ3/jEsBjEsfhvFxx3aMp3tEnOFPUE/BX8lLRvpB0JN5Ybkq6SHxrMi0+BGT90u6MVIQFLCon0Vnqeux5etdGnu5Z9UvPCr6QKh5z13oQPx5hHY5bnC/VpAmr2Fv1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9998


Hi Mark, Rob, Krzysztof
Cc Geert

Renesas MSIOF can work as both SPI and I2S.
Current Linux supports MSIOF-SPI. This patch-set adds new MSIOF-I2S.

Because it is using same HW-IP, we want to share same compatible for both
MSIOF-SPI/I2S case. MSIOF-I2S (Sound) will use Audio-Graph-Card/Card2 which
uses Of-Graph, but  MSIOF-SPI is not use Of-Graph.
So, this patch-set assumes it was used as MSIOF-I2S if DT is using Of-Graph,
otherwise, it is MSIOF-SPI (This assumption will works if SPI *never*
use Of-Graph in the future).

One note so far is that it is using "spi@xxx" node name for both
MSIOF-SPI/I2S. DTC will automatically checks "spi@xxx" node as SPI device
which requests #address-cells/#size-cells. But is not needed for I2S.
So we will get warning about it on Sparrow Hawk which uses MSIOF-I2S.
We have no solution about it, so far.

Link: https://lore.kernel.org/r/87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com
Link: https://lore.kernel.org/r/87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com
Link: https://lore.kernel.org/r/875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com

v3 -> v4
	- use "spi@xxxx" node name
	- check Of-Graph ([1/9])
	- Tidyup typo ([2/9])
	- Add Reviewed-by ([2/9][7/9])
	- Tidyup return value ([7/9])

v2 -> v3
	- Tidyup MSIOF dt-bindings schema ([1/10])
	- Add SPI tidyup patch ([02/10])
	- Tidyup git-log comment ([04/10)
	- Tidyup ADG handling ([05/10])
	- Tidyup typo ([07/10])
	- Add Reviewed-by ([10/10])

v1 -> v2
	- Merge I2S DT bindings into SPI DT
	- add "dt-bindings: " in Subject ([1/9])
	- use dev instead of pdev->dev ([2/9])
	- use __free() ([3/9])
	- Add Geert's Reviewed-by ([3/9])
	- Tidyup top NOTE ([6/9])
	- Remove unused defines ([6/9])
	- remove "probed" ([6/9])
	- remove MODULE_ALIAS([6/9])
	- rename "spi" to "serial-engine" ([7/9])
	- add MSIOF on defconfig ([9/9])

Kuninori Morimoto (9):
  dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
  spi: sh-msiof: use dev in sh_msiof_spi_probe()
  spi: sh-msiof: ignore driver probing if it was MSIOF Sound
  ASoC: renesas: rsnd: allow to use ADG as standalone
  ASoC: renesas: rsnd: care BRGA/BRGB select in rsnd_adg_clk_enable()
  ASoC: renesas: rsnd: enable to use "adg" clock
  ASoC: renesas: add MSIOF sound support
  arm64: dts: renesas: sparrow hawk: Add MSIOF Sound support
  arm64: defconfig: add Renesas MSIOF sound support

 .../bindings/spi/renesas,sh-msiof.yaml        |  43 +-
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     |  98 +++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/spi/spi-sh-msiof.c                    |  42 +-
 sound/soc/renesas/Kconfig                     |   7 +
 sound/soc/renesas/rcar/Makefile               |   3 +
 sound/soc/renesas/rcar/adg.c                  |  32 +-
 sound/soc/renesas/rcar/core.c                 |   7 +-
 sound/soc/renesas/rcar/msiof.c                | 566 ++++++++++++++++++
 9 files changed, 760 insertions(+), 39 deletions(-)
 create mode 100644 sound/soc/renesas/rcar/msiof.c

-- 
2.43.0


