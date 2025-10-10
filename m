Return-Path: <linux-spi+bounces-10524-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6550EBCDA3F
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784031A6316C
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A0D2F7454;
	Fri, 10 Oct 2025 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="z6ejRtoO"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023125.outbound.protection.outlook.com [52.101.83.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC942F3C20;
	Fri, 10 Oct 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108264; cv=fail; b=sxyyWsatKgNmDX5wdMCAYE2+7iYFCF8wWsiW1usKfcXmyiQZOIaX7+cq/5OWXD1Mu2WuViAPKkPf4NHDKbfjwWToRW73p9J6LK95sF9Vm8sLX0ywJD2oRpqLTvmWYYuPnFZokIOg2f9WrNB8oaTjoKMqLqrt5MUciWYkGvLU9yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108264; c=relaxed/simple;
	bh=Nf3QGLJZSgC8W00coZqGheEGWtAK8mS6F9FY4huiw6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HOQv9Wddg1Rbuq//zbrdL884rC9FKpE71D54dsa0vv14dVw6bTr0eX9RoHCnczK27MJvmP6Cea20z4w6t42DAFM8B4q8ashoIP4cIdOpN9ItGvi5HGa+sJUJq0fx3BebjeKVFzBPrxMLaA4Ha22xRJGXGUpnbWk3fuToR8F/IjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=z6ejRtoO; arc=fail smtp.client-ip=52.101.83.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzlvNNkiV564VIfvkAKwJvbuTRgCHhoPlu9nIioffs8MA3PPqXFZJNtQic64bt3GoaXFb22Y0sUVKuiZ4AIUd15zRJRl6IAjrxPv4eLAH/WcvFFyiBGMBHxeoVbKPc6WZcZXzAsJ7QzZvqg0/3WNR6b1a9sELfIJgO8o0ZIoEtJeaakQPjkKoR/iJED8lvOPgNeHWNS+aRpfoT7VYnwVoJVzCx9mKvEqvJFm4PnGhoPckZkNCzfDCdSuHfCHMeNBvNfv/t81ODCLRZuarIlUv1Z0laqQA3GVGOWgtoVk0bpr5L1fplUwZQIQT3HbxGLN2HUaYPocvgV2JWisUUGsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlSSLgS8vVosI5hb4hUKiH+dP35bTpcuKW76tnSjwjU=;
 b=AU4R26QmofFOaqkTYjLW3UkxXPNpPc3jwGMQasGgloH8bIa2+aQQGlyPXHwnnB7y5BVzHZeCQ7EEn1+wffplPnPIUyS48Ok0Guv4UdPhvyJcEnclnblMg2Ti0TwQOy8esRZ63QE3cL4yBaxClnztFDr0SGUowF9fHHRQzf7nhDRxb8jNbK3InnWglQeBnxrV7raoyEywrMJb+Q9ZXyv2RvOrriss6zszUMoxngGEY0Mlb0/6kcuRkjlWGoIcwVCrPPuSfWVnnA/68bI85ZYiKYjnmJ/vguzaadbbPXqD4mOUGo3vSI99C8SrrL/RtD1pxst/ZO/5llw1pC2kV5LOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlSSLgS8vVosI5hb4hUKiH+dP35bTpcuKW76tnSjwjU=;
 b=z6ejRtoOaMD80zO6Bj9VyPswu8QCG3k3TozjoicaUJhNI3MdHhvFG4R9OgVlTU7IibOJ8n12P4+WHkO7pGC4QUVAg9j2TlcBYxpShtp/mU2IMzkDJOhs+KG/NPyfMVGlaHwt90BC3ScfbAc6sjNcU8Gb0ZgHH6dWKjcH28sosc+swdNXVuvG7Z0jzETZvrn4i8aFsm/1WWRtI1Kuo/EvvlcGAwvjmI0V+WmfaEftvOinEeL6bdnj8iELDjukmebRoiG0Vdp20Kq4SwTInwqDsRMbJlBnkswQnKCWAYkfwP7h10Uv1dIi5uwDibkJLXVPhuvi2uKGUvjAJNRbKTwP/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10069.eurprd08.prod.outlook.com (2603:10a6:20b:636::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 14:57:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 14:57:37 +0000
Message-ID: <f709fe24-ca89-498a-a06d-677b703aecba@iopsys.eu>
Date: Fri, 10 Oct 2025 17:57:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/17] dt-bindings: spi: airoha: add compatible for
 EN7523
To: Conor Dooley <conor@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Shevchenko <andy@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
 <20251010033136.1475673-17-mikhail.kshevetskiy@iopsys.eu>
 <20251010-landscape-cavity-88a963e45a6b@spud>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20251010-landscape-cavity-88a963e45a6b@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0446.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10069:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c969d8-e5a1-4528-4ca9-08de080d5a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U081TEdsNlJYaXh3UVZLUHlYZ3dVcWdjdDhhdGhNUmxMRXRwV3ZmZzI1UUlK?=
 =?utf-8?B?WXduV2xXY0QrWG4zekdSQWlvK3dncmNjTFVNbUF2dEJLajZVK2prRjR1Slhl?=
 =?utf-8?B?WHdiZUZ4T0tXUm9WNXNET2pqS29rZjFjTTlWSkRsbm8yUTBWYVEvWUdLMEps?=
 =?utf-8?B?aFlTd2c1UURYbWlvMzcyZENmNXA3WkdGYVE3SWFTVzh3RU9xR09VMTlWVG51?=
 =?utf-8?B?QmtESHRqOUhsbjU4cHRVVjVJSC9GQmhBaWpVcXEydktGTTA1ZlpBa0pqWG53?=
 =?utf-8?B?ZlhaWFNCRG9tYUVIcGZjUkpLZWs4UTZ4ZDFuc21xbTB0S3k5WUFVSlZqa1Ry?=
 =?utf-8?B?UE0rRUhKd1VtekVLUW41bUtwNU5RZ2Y0ekdXT0VwSTF2OUZ1elhWU2g2M0Ju?=
 =?utf-8?B?MnoyMXY2bHFta1A3M1ZXWGdzeGdiNjNTNExNZFJSb0kvaWRNZWdTZ01tenZh?=
 =?utf-8?B?WkIwYVRHWU1VNWxhZkk0MFlhWUEvV3hWQ1JVR29UcUZhT2Y5SEIxb2srT3Zj?=
 =?utf-8?B?bHk1eFJoUlhRcmEva1BDRVVvWVZsVzFkQzIzWm1OOXVTRTJjL3U0eEFNRlEy?=
 =?utf-8?B?Zmk3YVFzYTRMdS9nOE5TNGpvMFZLcTFGSnhET0pnYzRRRER5TEpHUXlpYUFx?=
 =?utf-8?B?REdDQUUrM0pkWkdnUEFOVWdNMW9OTU5YRGsyNmhadWFDVHMvYlJlblRNNHBY?=
 =?utf-8?B?RTJYelVlNHI3RFRIQk9oL2paZDRDTzRuSUh3THR3TXVxQjF5eGtLZndQSEJO?=
 =?utf-8?B?ZkRMelBBcFNOK0dSM3RDekZ3UGQzengrZHRDNFhoenhKMldUUE02RWF6c0ZN?=
 =?utf-8?B?YzlTV0FJNUM2bFY4ZnVxdE5BNkg3V2xVY1U4VkZDUldqTkNXSkczSWphMUhR?=
 =?utf-8?B?V2JjQW1lT3VPWUMxQ2pDbGQwL1VFekJKTjlYR1o5Wm1uZ1FGNzh4eStKaFZG?=
 =?utf-8?B?VU14WmpyWEJKaC9FWnhiM0xkRzJXbFBEcW93K0FQOUcvWlpUWUtzUGh2MDVm?=
 =?utf-8?B?dVdRSmI4NlE4TlNRbHZLRmZwTjc0WXdNR3lja0l3T2RpTU9GekY2MUdmTnEy?=
 =?utf-8?B?VDZWdWhleTFlclg5cU1xWDh4eENBaCthNTIwaXVmWkRNc2xraVZRVnFrZGxj?=
 =?utf-8?B?T2hiek9lcmhnSmZyTGxIdWVlaitNR2ZOamt0ejVEbHBxQWdNNllSNStjbEJo?=
 =?utf-8?B?eVd0U2JZN3cxbkZuaHFQT3loei9VM095NGNDd0JlTlF4eUtyRFpUQ0duL0d3?=
 =?utf-8?B?UjhlTUNqSUNnUnU5MVF0bEdzVFdIbktPZ2l4TUxxL1ZSRHpOR2NrMEIxc2lY?=
 =?utf-8?B?anU0aGJ1eWpEVlhBcGZucURFN1JuczR1RTZDMWpJaGUxUFZsc01oMzl3Y1dj?=
 =?utf-8?B?RktuNnFLOFhvbzRkaXY3QWdvM3hLclhmaktvR1E2UmRFakdUaTBFOWpQdCs1?=
 =?utf-8?B?cDBZVDllZ1U0dHVrTEJHbVBINVdvOW9vejZYVmhkd2NZK2hCdkd3UXFvbldX?=
 =?utf-8?B?dVN4RGRSaGR6eVdNdXl3OG9OWmdxUHoxOG5MUmpzN1Y2Z0hobGFrZUd3a0E3?=
 =?utf-8?B?QWFNU2RUKzVUU2ZCZjhpd3c1a3Jvc3NPd1BRbDl0QlZPc2c0ZmhvZ2xjUmV2?=
 =?utf-8?B?enFrMEwzcTVvZEVNeDB5NkJpR0hzaGt2bi9zRS9sdUlVQW1ZamVaOFpYUjdR?=
 =?utf-8?B?aGVzV2w1RjZjVmFhK0pnY1RRMzNCZWozWFhyVlhrOHpINkFBdGErU1FoVkwv?=
 =?utf-8?B?aFBlUHZIdDFpME9QTTlkZXNLVEtVbUloZ3dsRzVuZS96T1l2RkdWMTBjdTVs?=
 =?utf-8?B?T2ZXSUNtS0t6Nm5ydGVKMHA4bDY2cHB6TXlLSDdzSG9qRXpMQ1VENTBYOFBI?=
 =?utf-8?B?ZGoxd0lqZmx0eEJHSWw0K2t5Zmcwd252TTZ6YVRVT29vSDh4aXl4a0Rjdm9r?=
 =?utf-8?Q?wLijiiaO327hVwg8VzxI0gBUjqJmG+V1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDEva3dSRFBsUDlCcGZHVjVkRmVIWmNYbGxhaWs0bVM4RURwTCtBbmg4N3Ru?=
 =?utf-8?B?emh3eTRuOGhCeDNVRG5oY0dPT2tQcjA1MlNYMit2NkdqdXFlOEFJZU5ZMHcw?=
 =?utf-8?B?dHZ2OUEvNGY3Vy93T05jN1oxWHI3RUUxUTRYZ0pXRjZWUzNRRGtHVisvMUdx?=
 =?utf-8?B?bXZFR3RSakZBVFdocDN5SG81MjNBcHlsQWpROE9yQ2tieUlpU0xlZmFkM2dq?=
 =?utf-8?B?aDN5NnI5TXJlSzVIK1Fhdjl2RG4vWTg2c01DYjNUc1d5b1YyaWJPcHVGY0cy?=
 =?utf-8?B?cFora0pyQm82bjdoZTZaMElHYjBraFhJRE0rQ2hYajQrc0N0clRsSDNZdHhP?=
 =?utf-8?B?T3VlY0RHNCs3dm9mVnJreFRJSlF1akY0WXZSRGJ5NnY2L3lpUmdadXRzVE93?=
 =?utf-8?B?UmZzK3N5T0lSdllrWnU5cFo1S0V3eUtDc2lJN3VmeFRDQ3ZQc29ZM09UUUxL?=
 =?utf-8?B?WkZMQm5qdHgrd29zQ1JtUkZrOTRYZmVXMkM2cWdzMENYV0FueTA4QTlZK0Jh?=
 =?utf-8?B?OVF2aTUzeVpUTGNFbjMzd3AzaHA4NDM3cTB5YTVpUnJ0MWx6VUR3enFZUy9E?=
 =?utf-8?B?L0JCM2ljVmh6ZE5ZQ0ovdFljWnUwejJwaVF4eUlhRStMb0QxazNMbTh3eXlT?=
 =?utf-8?B?bnB4TFpuUnRoK1ZvUUo5cjFLTktVL0xlNThoV3JkeXlFbW8zTjRiYTFaTmxm?=
 =?utf-8?B?VjI1S1lzYXF6aktNVjZsaVhoQjc1eG1tVklJelByS2MxNXdza25hR2ZVQUpR?=
 =?utf-8?B?NnU3VTFiKzlsQWtmOFh5a3RwY1pHSnNpV3cyL2ppYXhjaysxeUtqVlk2ZUY5?=
 =?utf-8?B?dGc5TXJ3c043U3M1OEdWS1k3azEzUFJzR01ZUzZ2akJpcDhUNTIwZlcxUnBl?=
 =?utf-8?B?ZjU2L1Q3c3JWZ29tR3hCM0Z3YXhtcjhSTHV4YUlWWFdmT3Q1V28zNFhldHZK?=
 =?utf-8?B?RVRiUzBHNS9QcVB4eFdXSGQrOWhGbXdISDB1Vmlub09sWnZwdzFlY09BSGhV?=
 =?utf-8?B?MUFsbHdob1pHcEJDMithSFBsR2lnMVFYbjVtbHFTcVdUK0kwRDdudW52Qk9w?=
 =?utf-8?B?a1J0cGhhMW91cVZaMDBPZVFGQUNKSG5rbFNmcHd5YmtRNXFMOUxIcnk0aVBt?=
 =?utf-8?B?UlQyNkpJU20xK0dPUEhUNkZGbEUrTGxaVXk3aVV5RFV0SGI4TEdJWURHMGZ0?=
 =?utf-8?B?QTYrNk9RcnhXaSswaGNHTzltSnV4RFFXTWFsS2srTUxDZ08vTlhYcVBCcDhX?=
 =?utf-8?B?UTRGR1hnTzdJUk9pT0pteU5rK2EySHBjQzFRM3daYkNQbXZ1T25TVFNUU0oz?=
 =?utf-8?B?TDkyaVZpRmpQSlhjMmFhdXhsWXFsQkNLWG5Ddzc1aldCK2x3UjJIMUlpR0tC?=
 =?utf-8?B?YkhYRWtDRkphWTZHWTdnbmtZdGRxdVphTlo2aTNYamZSSGdaSGRGWFZCSklL?=
 =?utf-8?B?dzBRMkMxUnF5ZDNSZTJ2UmI2WG5selo3TXhOUlhvcHpZTkNObTVXK2VXUlBJ?=
 =?utf-8?B?NkZrczJVZXJEQVFkSFNleXhhMGJiTVM1V2MwTHhMSmtMNEMzWElFSGRBaWVm?=
 =?utf-8?B?eTV5YWovaE1kSWg0UDlKemFHTWQrb2ZGem02MGttZ0VhZUxoWm1GRnpSQVRJ?=
 =?utf-8?B?NlBYZWdRTUR3VXFBcnNpVXRCL2dBUVRsRDU5Zmp0bHNsMGk5UitwMzJLdUNw?=
 =?utf-8?B?ODFVampuTzZjQnhjM0dXNU5QZ0ZEVlUrbXdvQkVnSmFuQnY4NjRWSGtnVVlj?=
 =?utf-8?B?YkwrSEpJa0U3cmtoWUNiZTRuS3dVZFdoRnQyQXI5ellaNGJHQXpmOFdRSWxL?=
 =?utf-8?B?elY3a2JHS0VUOWg4MFRDMlVWb2dRMjBTaDZHcWo2d1MxNVBJbVF6a2N4d2Fz?=
 =?utf-8?B?ZFZrRnVIOHZnRzg1QkhDaFlXbkhGaHFKVVpHZyt0bW5KMkJyVWdsYWc0NkZx?=
 =?utf-8?B?RWhGWmlaSnh3VXNoS0s0bDVaRDBLNUtOcnZYS3BSdkpnUkljZUxod2l3U3ln?=
 =?utf-8?B?ZDdhS3VTR1ByYjF1VkpEUzVmdE1QUldkSWpGdzZQcXVyb3RxYkZqWFVJRmlx?=
 =?utf-8?B?cFQ4elljUTJSQ3MrNTQ4a1dBZjlrOTd6NE5WMjF5bjNZMzRUM2d2ZGZTY3Jn?=
 =?utf-8?B?R3M4Nk5qVXFKZ2pkTWFWRE05Qy9id2RTV2xROElZOGtxc3lFcjYrcEdoR09Z?=
 =?utf-8?Q?vwItgcdZcO6dvzgZ9jUmDOI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c969d8-e5a1-4528-4ca9-08de080d5a35
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:57:37.6770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyuqkiHO84XOjc5L6JOFS6JU3PzZMVOuJk3cm6WsVHyvN3eGckaI8uDwC81JRoHODLfacHbt2YJ3udsrHx6euYAlhxW7V2TAzcHxywmhnrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10069

On 10.10.2025 17:24, Conor Dooley wrote:
> On Fri, Oct 10, 2025 at 06:31:35AM +0300, Mikhail Kshevetskiy wrote:
>> Add dt-bindings documentation of SPI NAND controller
>> for Airoha EN7523 SoC platform.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Please explain in the commit message why these two devices are not
> compatible.


They are compatible (at least from the point of this driver), but
 * en7523 is an old chip destined for 32-bit OS (ARCH=arm)
 * en7581 is a much newer chip destined for 64-bit OS (ARCH=arm64)
so using of 'en7581-snand' may leads to peoples confusion.

>
>> ---
>>  .../devicetree/bindings/spi/airoha,en7581-snand.yaml         | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
>> index b820c5613dcc..fdc5b0f920cc 100644
>> --- a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
>> +++ b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
>> @@ -14,7 +14,10 @@ allOf:
>>  
>>  properties:
>>    compatible:
>> -    const: airoha,en7581-snand
>> +    enum:
>> +      - airoha,en7523-snand
>> +      - airoha,en7581-snand
>> +
>>  
>>    reg:
>>      items:
>> -- 
>> 2.51.0
>>

