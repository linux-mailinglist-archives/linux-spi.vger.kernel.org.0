Return-Path: <linux-spi+bounces-7495-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B20A8346D
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 01:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C01B65344
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 23:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5A22153D6;
	Wed,  9 Apr 2025 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="e8BW8lNe"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010039.outbound.protection.outlook.com [52.101.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84626ACD;
	Wed,  9 Apr 2025 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744240786; cv=fail; b=FoYiDaHBTJBTSVaiTccpmGaaKUeWaFniYJwKd3zp7weO3oCXOGH+2ckG4JtJBA2ngjafh3Q+b5yHl81tasrYqJBiP2f5vYtgqeJN0SUYhrT5hPaNA0DFS02JP1YsNOvC3rIWgJ6lg78vBwkLRETUnfnRxNBGjAGsgrj21LOy+pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744240786; c=relaxed/simple;
	bh=AZ+r28UUWgV8AzyXqy8KjZ1zajqhVoUkLXioGyCvdjE=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=kV8NbIwaRaE8W/6DfylfuA4F5ymDghA3b6MlbLjq/0K5t2hGKmrLDOCjL/NgbwvdzDKmMDNpJPgEvfxkBLlAeviCCWQhXf3lybM/pObJpk1infXr067VhoGuMSOsFER6LyFtR2jUNssL2OWz8f6S3Ii0QrH8pFaGyA6qMMMXpMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=e8BW8lNe; arc=fail smtp.client-ip=52.101.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGHyKgQ7rZymwrye95yLZayQmP4LCz8kwhXVnKut6SqYFKaGYWjSNJjpg64kPShkXzfIBJZk5OWRQ+OgpzA96+FR1/gZLhSxdEm0gCpOmx5TN0ArKMRczosfzyYZhfdbYvPl5K/2bwXtjglWHnX3VqNz31cDHm7kS3mcy/caE+syGTzkb7CnYpw0uGZfhx49UX+GpsFZJRKGVSxcg9EQY92ZcwBqVYrbcd9uCq/h2LX5AV1IrVZbDjdx9PgEEgayLvyctJ8K6wlHrMdT6hykruq+iwEhinMOF8toyiecyS13RO7myrmCT7XcKddYklsKU8dzL120OL8K7JkMGSH20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yz/DDE03wsXwGq2FjnoGszBXzel445B01bbXSWxZWiw=;
 b=UQjRHcVY6mbnerGvF39uJyilh2/HzSCVWihwWjnX2JwURPlD5XPSG9NKzjMjrtfl1KXkyOHnUH9HKwPLUpZ1LhYoGt89RMdu5n3UHQYnzmUBSwLZizFj9ZoNPRRh6xobzyIR4VnM3DuW6CFN5f32gvo5j8PBSf61gNHz2Tg0j505CjrmDdcMKZptKZPNDfo+JnBhKKsAMW+drMkj2xX80dfui9fst8L005579dIQw8yeBubI3ccdb6jNZWHpVYa19bQZi0ZSFVpRo/fciWdDDtsGBS0evqiye4eB3NHJoKMasqJmGNV5IGbPMgLeJ7YhB+I1v5Un6gXcm693JFQibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yz/DDE03wsXwGq2FjnoGszBXzel445B01bbXSWxZWiw=;
 b=e8BW8lNeoaX5vsUZNWtOKnu50ozS1ipNF3ySpPY5YrPXHR+RQ4ANjjQvJxsYik4Pm04pEiL/OuokQuKujRw3kUhZ9aOENIt9Xjy9RMN9SST48Xp+yF7Hv2LSlP6MJX6axruffNct3Skakp0v9OkCDh6k0iQpQMFTvhQ6eQCeoHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYWPR01MB10631.jpnprd01.prod.outlook.com
 (2603:1096:400:2a3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 23:19:36 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 23:19:35 +0000
Message-ID: <877c3sncs9.wl-kuninori.morimoto.gx@renesas.com>
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
Subject: Re: [PATCH 1/7] spi: renesas,sh-msiof: Living separately from MSIOF I2S Sound
In-Reply-To: <66808fa5-2b81-4145-b2c6-9b0d76d2a6dc@kernel.org>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
	<874iyyb0w2.wl-kuninori.morimoto.gx@renesas.com>
	<66808fa5-2b81-4145-b2c6-9b0d76d2a6dc@kernel.org>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 9 Apr 2025 23:19:34 +0000
X-ClientProxiedBy: TYAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:404:15::24) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYWPR01MB10631:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ecf46b-1cab-4848-07bf-08dd77bcfd98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aa0jcMSBzQV0O9sKMKIKjJ3HQA5WBI3uXbsxOiQruxqzhSc/BmdvyppNuK7X?=
 =?us-ascii?Q?abL2dkvkc830Ki+aVnU6nsN/YfwXUDuYY9jKb/kjyVQzgXhBCsNylbpp9U1H?=
 =?us-ascii?Q?RwwR7sWGVqOqZws6C6i74VxxQNPz+AVLzZELBAuFFQme39qcSPKZ3hRmMN8T?=
 =?us-ascii?Q?XsJNyWLc1bHn/q0r6zc45C6VrUG0AX9DeHeojHnUXeHLphz/QD9Of4vbdKV7?=
 =?us-ascii?Q?UAni0gKTMXqyQNucRVdSGdFo6p0EOMNmjxMVMfiHPcHjP4Helv/ma9ar0TEX?=
 =?us-ascii?Q?nd6t3rHhy2skXeeyVxHcrnVC6RSE4WKZvBJe6l6PZmbGF5GQL2PNcaH057z1?=
 =?us-ascii?Q?7IwZIwvrB8a7rkwajGJaM/ryoqKPyAX8GPz0fWhpW5NOirbsUyhpeseLiIUu?=
 =?us-ascii?Q?cbisO/mMskPbNRsotxgX1x5rOt2A6Q0eXoPuXH0WeuiW2QK58RCtZfQv8uqn?=
 =?us-ascii?Q?NS7qxH5LxDB9SurbIzvG1U8bYXG+GiloeyKoRUIU4l9Hgf3PnZJgqtmXfvjV?=
 =?us-ascii?Q?KUo0hs+fPuJ56v+M9EcAqaimkrEO06lxLXPZ3OKz6imwh/itrbCz/FltIzUk?=
 =?us-ascii?Q?96YyS+EpcOVGcl3ShKGi83gFrPkG2L3JbsBPnfIOdRBkR85ytuo3B20vjpQr?=
 =?us-ascii?Q?A75UEeWh+uzZ3M1rNJYRQVR6bRKibSekhuWFFYIVXEolklRxsPPXej5N2MHX?=
 =?us-ascii?Q?3R4Szme5zdpvdLzqhZygCmES4B5j4wWNBoQALErKj3JMv1Ei4jaKA691xuo8?=
 =?us-ascii?Q?cpP/Pu8O7OWmLgLifxLOjgwuYk2HECXWmdJvZdDySIvpgjNuNi8SKHNHh3C1?=
 =?us-ascii?Q?HziPurNyt6C6j4lilteito8QNLYUZkTYFQyg8MI0xNgiKVIGX+DvHRHvlSSJ?=
 =?us-ascii?Q?PpOyjLLqIpFsivkD83vPecJsFd3bUD1ixzswy1j+5BOfRKOzNOeAEk2xF0hy?=
 =?us-ascii?Q?BFsljsiEHj4xBMWYiMAMu/kTZuiJf23lMZbthCsFkCxddqZjeRYpSabz1rUJ?=
 =?us-ascii?Q?kN62H6S4J7qNhJFc102Pg4I1dHYurbRG5hCuy4y3396weg/DnMLMm9nowYX5?=
 =?us-ascii?Q?aqQGcY4CtDLqq/4Xk119rtxtoKNrQHgG8kbz718ttwCMdaq7ZsbjQVnCODsH?=
 =?us-ascii?Q?asssPLSP6dd28qTZKzCtRWmypJ5dC355WkQ5tOybnECSAEGpwEt6Dy1coDkq?=
 =?us-ascii?Q?xNGQjXR+zAHAzUYbdq7o9wWGtG57c1Yk8CpXJRsnSt7Us6kXwKNUnLiczGC1?=
 =?us-ascii?Q?BAPRvPFI21/oF1tep8XEGz95bBKrpmfEcbjbPADnvKtUB9uT8e1rQqe3Td1J?=
 =?us-ascii?Q?sbHZ2GYDkZA0SMK77Wk1x/ykFlfLI9ab7Jx2Slf89qyG54p73rI+W5VGZmHw?=
 =?us-ascii?Q?mPRGnv+aNcyUZFS1fW7p3luGVf64kE9a4e7mRODelyF9MIHvlkT5Tw4PDy5d?=
 =?us-ascii?Q?ZY3Te2vY9pr5q86Kl43G+OcQWgO/Fju/npnbWQWypHWkeAvL5mfF6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eoKM/d3CFkyHrUr2u9c2nbJpH2Tv68VOgPelckFLSAuOwWyYjDhCtnOQild9?=
 =?us-ascii?Q?c3SX/s++uSZTDy0ouaiIcD6LdbOc9X8m0mn0omQRSjklWr41EjOh5rWyrCoD?=
 =?us-ascii?Q?hDUCjx9VgT9/kOZ7uPpxf5zd8OCOYddWOSACj8S2+GijEb1gqawwv9issKhd?=
 =?us-ascii?Q?3doFz74cw/xPtP/N2LJPb0Tgwc83kLltaYQPqHD9DCgNVIHJr/ve1nCo+E5b?=
 =?us-ascii?Q?Gv6axD8+8kTr+KKQzMImSMarFg6YEI7GAOLObVw8Nl3XMmOXWs63w/55d9w+?=
 =?us-ascii?Q?J+vYCWdCenBPge/9GxJQpjPnMcw7eTsk0zSuKf1AUSTGLuNqcfy0ebG9SPGn?=
 =?us-ascii?Q?lCwtvz+azcSlW5Anrgm8S/J/qlF1bMLWnuVPNwJZyw9QS4UhbX+r3faNuUHt?=
 =?us-ascii?Q?KukHYRY7COewr10rjqgybVPHQUAzeN9Gt/00J2I0UrBF/JXhFd4Xy4Uvvg2i?=
 =?us-ascii?Q?b15W+I1PUXWLSmISd61/i3Rkjek09Sjn5RGfsy4eyLKXSy0ixX9de9XEOlQp?=
 =?us-ascii?Q?dqNUcMpz3qE8t+Quu+/i59xta3VrAM2r14o5QQKjK4hI2lLCR6smtuuKApNo?=
 =?us-ascii?Q?xGlkNXVQHCBCTLA20DjOsrt8xNriSjd/6MKjIQaFmJgxsL8n8QTDeNyAURtZ?=
 =?us-ascii?Q?CTQZSEwF8A5sHNsAinXoxMkeQSwX3kTG4nc4d+5eq0RfxtX+7OrffMNbsu+X?=
 =?us-ascii?Q?fXbLJysHPyAreevH8fzFMq7sTT1GIAhyjNcmPATgAjPBbS8GRtULq/z/NztN?=
 =?us-ascii?Q?Ksd5vwJlEFoWoYvQscf/+AcncSqz8Wxc7Fu3RnbNqlP8kaqDH04uhw2iSHeH?=
 =?us-ascii?Q?ZqrK3SYWUR/vG5i09z9fYvoTooHmeeO+Jy08jdtBeQrk7Mk/bAvbOpCsmgCZ?=
 =?us-ascii?Q?ARg4wE/4mQxm0eQTNLcCKRaoKMgI6YWcaZ4iZA0yTnEPgbsSGhZMHwGd+ziC?=
 =?us-ascii?Q?faQzvJtq/v4uyr80i0/MBoZTVBnAx5zMRkuk68OYJ+wUt6MxKUNqVo+8AUlv?=
 =?us-ascii?Q?TVGeheX5JbRjg9KOvhAO0JaQki2wVJ6Co2uMmezXim6WOFiNOYrtL+/FHpoh?=
 =?us-ascii?Q?+++AsKbhSHQ55lPb0kvWLj1YqXx7QVwGPlKPgRiI1swiXbvJGfbvPu+Ii7/6?=
 =?us-ascii?Q?8mSrosUIBFXlTjz4cV1OvAL5tUU32JTCJfbUcjvIA3tQRFUjaIKgzh/mcb/l?=
 =?us-ascii?Q?XHtqc6vn6vnSxwXdUIEkqnjpVbttxJdanBRjWApJ8xVLoIz8Fsy+cXVLIPFp?=
 =?us-ascii?Q?kVuNGy7yzCEta8UMFmp/wCTGrksF3Dv2sLhK3oX/AgAlu+NooGbdhaLsRGgo?=
 =?us-ascii?Q?NsvNhMnkfBH9xAzlR/ESXXARMT6csyH34lXOu01V5TrwLd/8GhN9aGC+mVRV?=
 =?us-ascii?Q?v0J4IqlBt3qT5OdaMx25EKEo95H2XeYyPPfci8UZzA+g9DiDttYXHQ3fAKax?=
 =?us-ascii?Q?G/lpMk/uk5V11OiilpiKe8alnTbhbTh0YWY/xSw8hQ5S29TrPumKsz+TM/tx?=
 =?us-ascii?Q?Vot7gEfYknuBhGnV94he6skZLxJ1Q4OOjPqkQSZU6RSeNZY4eEYNWm+NOZ8K?=
 =?us-ascii?Q?KAbDFXdpfQnKtLmdlfyVNzIrBLZL2hJikbxSKknJfqqadgwb2DZPJTV/zqgg?=
 =?us-ascii?Q?6ANAlEECOzjl8z2mRkoOi3U=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ecf46b-1cab-4848-07bf-08dd77bcfd98
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 23:19:34.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Zdq4Xq1qEP54auPJt+ETufWX0s+AnXeyPFHMsuQwggteC3L6N51uVsznIgumA84czVVmS+Wn96FORWa2+CmdiIBvk6mW6Yp5WxW8/7piIkv1cyM0bjZGZcqXhwecYLo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10631


Hi

> > Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
> > both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
> > uses Of-Graph in DT.
> > 
> > MSIOF-SPI/I2S are using same DT compatible properties.
> > MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
> > MSIOF-SPI doesn't use  Of-Graph.
> > 
> > Ignore MSIOF-I2S case (= Of-Graph) in MSIOF-SPI Doc.
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.

Yeah, I did :)

git log --oneline --no-merges Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml 

1f48cbd6f00f spi: renesas,sh-msiof: Add r8a779h0 support
a0dcd1ff9629 spi: renesas,sh-msiof: Miscellaneous improvements
aa69dc65e3b3 spi: renesas,sh-msiof: Add r8a779g0 support
f4d381038700 spi: renesas,sh-msiof: Fix 'unevaluatedProperties' warnings
b076fdd02133 spi: renesas,sh-msiof: R-Car V3U is R-Car Gen4
e1e62f05d5d9 spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0 support
5a674d9dc9a0 dt-bindings: Fix array constraints on scalar properties
6be69293196c spi: renesas,sh-msiof: Add r8a779a0 support
6fdc6e23a7d1 dt-bindings: Add missing 'unevaluatedProperties'
aef161f4f1b8 spi: renesas,sh-msiof: Add r8a77961 support
b4f7f5f54705 spi: renesas,sh-msiof: Add r8a774e1 support
6383b118efaf spi: renesas,sh-msiof: Add r8a7742 support
fba5618451d2 dt-bindings: Fix incorrect 'reg' property sizes
3d21a4609335 dt-bindings: Remove cases of 'allOf' containing a '$ref'
97f41c68b83e dt-bindings: spi: sh-msiof: Add r8a774b1 support
9c3c41761f45 dt-bindings: spi: sh-msiof: Convert bindings to json-schema

Thank you for your help !!

Best regards
---
Kuninori Morimoto

