Return-Path: <linux-spi+bounces-7785-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B07FA9ED86
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 12:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825F87A3D43
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB4F200138;
	Mon, 28 Apr 2025 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nqc1ZUOI"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7997262FF9;
	Mon, 28 Apr 2025 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834724; cv=fail; b=P1I06rN/m6wvICgFq3iGhsGSA386BrFtJaxhfFpcl8HBPKXqhLvB2jfqHwurwJdeWR+3l2VRMK/IP5GHHYhJH8yc4TLVsU2kNY45lsc5B2vTgLK8E47D5/suMuOAMwLyYI9o13KQcmpDFM5HppuYNepBLNzjqzZA4lXuWHvcL5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834724; c=relaxed/simple;
	bh=irZFSSYx/TvKG4jJ6voT+6bplOW3bJqw8kZoUAKk26Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UJCusW9MDgIQ2dtewE32cewHXKkWFR7xQk3nst+ZWTftsfnlNZHfbLmWeAx0FyHBbdAyMIlLX956tUEPinEdMnqrSf+kbtIRWAaBPTW5nbjcX0riY544EC3KleH4XegFjQlMbrrZf5eeeLLCWP02tkbIFctGgH+kyM9YuLr+sMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nqc1ZUOI; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShAnvj1h4g5X01cPOaRd9zbRoIEo96dM+Jn4OrZXtf3gvO7H3AVfLkWZxCyOXNJ/4dbSykBdWbA5ZmWVigdFg6aSKaCHchCtdy7d3E2wjevxSXrZWx2WdaYi7LnSAb/kyPhtqlu2OjcaHyQ9/wwd7lDEcQSjxg/hP98css+jCRwnyHaf+PZxzVTgkDIBxcrgrg+SaG7MAfBAp91v8/CGVoYifFUXGiBs4Od81BrJjQYXGrq0PSQwVLkvt40TO4xWiqsy1T+ox+wK+ke7IzaA47bW6ixjrKIRQFNz4DFAS36f8bi3vIIJlNERmrkRJOcXsYdVHuMGq2JEXSdZiSTd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFMmYH8Qt8INTnib5oq7NC8c1iRdxUfjfS25apuO0w8=;
 b=uFLOMFTuXbXZw/2aOP85r2x5IWYDjjdhGWQ6xy7rfk21BoGpzk7zs1g82AYZVKM1vyhipzdIWpxRGwiUFstw9vJqLc7x7ycMBuIiNyZ1yyj7tl4zpe1YLWaDMTCzYVV1lEtLqQMKHvSqrSqVy/KFV+u37SetERCgQdRMUBF8lgpifVcnRyQNl0dIic+dwWgXSWJ6F41t4aurVnLaO+zKKX+XWpcHit7AhGEtjIeyMA1yB57/i2wbRxzIUdMTk38hV7F+GodQxNpl+OJXOitgik8nHVH08m9b/OTa6co+TRVvM/oDDv6FqcuIT1ecil6Q5JoZMgJW2CWZnkd+CaGp/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFMmYH8Qt8INTnib5oq7NC8c1iRdxUfjfS25apuO0w8=;
 b=nqc1ZUOIfdItEG0daxAYcPt+D5U/gvCxc6lau/Ix+ydifdLdXta26o6Zdg/vju3GhSaPb11GphbbEyA0U11xQFWi02BMxeXyLHX0mjZh7AtbXVUb2UzU7BFatXrQkfF2gIdRf/j1f1dVNysaWy4s1/vtoIKrciYNR10vm8+wOc5+sCE1u3Sa3hX26GA4S5jOLCQ2T0icdp4l4qFzn3gb2ggRY2AAYtYeNSpFtleHVuLzmwiEJnwWJF4V/gECmf/Wx8NVWt5ZQrNOrJdV76lmqjqoYjsr72KpCeEf4wiKzCOC1Cri4a1XlMVvIExgVgF5qW7CFixcI+FcmSdN25sdAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAWPR04MB9862.eurprd04.prod.outlook.com (2603:10a6:102:391::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:05:17 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8678.027; Mon, 28 Apr 2025
 10:05:17 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 28 Apr 2025 18:06:47 +0800
Subject: [PATCH v3 5/5] spi: nxp-fspi: use devm instead of remove for
 driver detach
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-flexspipatch-v3-5-61d5e8f591bc@nxp.com>
References: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
In-Reply-To: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745834827; l=2590;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=7KgkJglDrufn/lmGSDkrryOQqmavlyoLMs7rvN6cm1I=;
 b=tJtlkLjONGR2jTwr/28TP8D1iNOIplaJLQzdzAeFnNSfPih3ZoHO9vtZOgI+yIxhsZSIj3JvZ
 kwc/OEMw+bcAUM5Oqqcq73d+K1WrQxNCfz7wANEcEfLDcVjifo2v3i+
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAWPR04MB9862:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9ad8b5-8861-4bb7-685e-08dd863c2d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXY3ekc5eFVGeXRtc2h4Q3ZTbjBXcllQSHdIK08vQUt4YjRDNk5XN0I1aHAr?=
 =?utf-8?B?dlNDdnBiZVNYQ0x0RnpsZ2s5WFRsbnpXTVZvaG9JZFQ2Y3VQbUw5QWxnN0pQ?=
 =?utf-8?B?WjJreC9MZnJIMlJuRTJlcERObE9lUUtGZElnZmZoR3ZhaVlRVmdPeThCT00y?=
 =?utf-8?B?cDQxd3picldteEU3Yy92MTNoLzhnVC9BTVNKSm1oWnZKUnMyR2JBTlhHSWx3?=
 =?utf-8?B?OXhCYzdIQ0VmSWZ6L1BHODFyQUtCcHZDOG9URjFEWlBZdGFnbUJTWjF5L2R2?=
 =?utf-8?B?WWM4RmpVYjJFOWxTcmplNTArcjYzVVJ0WmdjM3FkOFVVemI4YTRGOGxkMUV2?=
 =?utf-8?B?bGp5TDNMRHN3aWlyRktpTXRZMm96aU1MeTQ1aGluOEphZWl2QXJYenk2RUtn?=
 =?utf-8?B?SVg4bkNWVC9ySUVlTmJEbjRNMzFpTzY1SGNXTk5teUsxWHF6MEgrVnBPeU8v?=
 =?utf-8?B?Ym9PYU1Gd1p1WXB2S1Z1N1h4MTRlSUk4NGd4dFc5Ti9Vak0wVDEwNVYwUjdE?=
 =?utf-8?B?bHg3QytqU1RjRnMxRnJEWW0rZEZpVy92SEczV3NrcmVxQzhuL0ozUnlXNFBU?=
 =?utf-8?B?cWM3Mm5aNzNaK2RVbnBMNGs1aUJ1aG9YSGtaS21CcWlRVmNlcEZ4M0RsSlJP?=
 =?utf-8?B?NVcvL3lYZ2piVWt2Q0dDTERRbksyY3FtdXQ1SmJZOWZsT3JhSGJ1NnFyV3Uy?=
 =?utf-8?B?QzRpbktKS0JCVlFTeXR3bDB3dnRpQUdFbU91eXBhckZCdWdOSXVpaW5XcTIv?=
 =?utf-8?B?RXFDUGRYcElDUjVIZWFNbDAyd2gvTnYxWTVKUDZUc1NCSUZqTUozRlo1eGZy?=
 =?utf-8?B?V09ZT3BKaGsxdFZ5OG1qWFJoZHdCcGgzR2dNOEZFa1hhWlF3TFJMTlpCZjRO?=
 =?utf-8?B?SEUyZ215cHI1aFAzSXNxODNQSjBWM0NldHJkTjFrQlBFTUhudHlXd0U2aXlK?=
 =?utf-8?B?WVhObUwzcExSbkZiOGkvM0RIcG9HNHAvMG1aYVRtMGMzTkk5RWRiRW91QU9E?=
 =?utf-8?B?S2JIQXJrQWk5TndBc29MQlhZS050a1lMaEVRYm1BOXNDQ2ZjVkpzRXRRWmw1?=
 =?utf-8?B?cU5TNnEvejNadlFoVitzWFk2T1dkbVlDTjZCdEI4Ui9ENFpmQTV1R3ZJVFI2?=
 =?utf-8?B?bmFWZkEwUUhvbU5WRmZLMkZVT1cxNWh4ZjdHMDVSTlNocENoamthTTBRQ2xj?=
 =?utf-8?B?d1ZGVjdCYWdMV3p2bndNcDMwMWlpUjNrV0VMd2t2RU5yWVM3Ly9CWTEraHVU?=
 =?utf-8?B?aFI5VnNmcHJMQ2ZCT1VrU1BITHROYjVIWDcrN1BQeEdZcVJUTE9BZSt2ZmZv?=
 =?utf-8?B?NU41enY2QnBSRmxseGh0cWpYMTRxVTlHZlJqTWlIOEkxQnpObUJZZ1RQM2h2?=
 =?utf-8?B?a0V4L1BlRUplVTZlMWl2d3plRXRFVjB2ZEE0TDJSNUpWaGVrUEhKbkpHVnU3?=
 =?utf-8?B?UlVobDhqOGlTNXlyN3N0UlhCL2Z5Z3hieFkrSWZjcWk5UE0vWDRESktReUlT?=
 =?utf-8?B?V3pNcTdJWE9FbmhadkpGRHVWOXVDNkVMUEZ4dlZRUURYU09WUVlCZzk5bmw5?=
 =?utf-8?B?bE8yTHNjVFRWS0FOTTJtb3Zta2l5TzFsS3dqWnZNMG1mQjdOdmNxaUlDSEJm?=
 =?utf-8?B?ZWxQMkdvc21MeW0wOUdROUZsa0RhQXZNWmdOVUVrWlA3d1l2QTlPWGgycEF1?=
 =?utf-8?B?UUVWNmdkNDRSYVEvVWdtR3p2VkVPSkdHVmJ0Vk5tRTRmRVdTVm9ERGErbVR3?=
 =?utf-8?B?R0dVTjZiTDdwalFzbjM4MDBLMm1GMFZub1BNT3lDQ29FRWNrOU5tUUh4aUpw?=
 =?utf-8?B?M3M2RU4rTjdWWk9ick1US3dBaWZUREVWc2hOUUJPajNENWpEVFAwU21PRlh5?=
 =?utf-8?B?eEpxbmhzWjBLQzhrTEZxNWdjaEhNT2xFL0ZhT3JUOWNVMVY2NVZOdlVxQUoy?=
 =?utf-8?B?Q0JmdUp2RVQ5c3p5d2kyUmplcXJBY09vcVA3MkFIMk5lODZUZUFKZ3lFZ0pp?=
 =?utf-8?B?VFNlbGF1WkJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFFLMGRjenpvYnZKcEt5cDdoUXpzWUlPNlFiUkFJT1FHeWZ0YXkrMFgxNWI1?=
 =?utf-8?B?T1Y1bXZjMHdsTGNsY2NUTXNzVFMxa0Vsc0RyWG94eFBJMGNnazZUZ09PUDFK?=
 =?utf-8?B?eDdmWThxRThwcjJtK09RREYzTFV6aUg3bk1IVS96RnIxYVowcitpUGhmR1p2?=
 =?utf-8?B?OTR4V1g5UUhKdHp1MG5oY3ZXN3NXLy81UE9idzZoUS96aGIxMWI3TnQzZSsr?=
 =?utf-8?B?clg3Z1JRMHJJK0l2dFdjN2hQK3kvemtmT2M3ZVFIVjlNOTQveW85b0JZbXpY?=
 =?utf-8?B?cWo2ZnFFd1hYcVo5MUlnZzJyc1pzYVRaTi9kbzYvK2p4SmI5RndScytxV0U2?=
 =?utf-8?B?SlFIZVBDOTl0bEk0T0lVVStya1NtWmVmRElTeFVsNHFVS2NNRVBsNjR3QVln?=
 =?utf-8?B?V042QjYyRUJXb3FFQUtOa1l1NEJLbUJ1cCtDUi81M2l0VWgzUWg1b2RDbURy?=
 =?utf-8?B?ZTVVdFJ6Z3hidjBKZmtaQk9RTWU5UjV6QmFsSEdyNm9PWTBneWNueHg5bmpl?=
 =?utf-8?B?ZEtvd0hjLzd2WmYrR2NHdmg2cjBrY3hMa1Y5SnJienhFQlpiN3Uxa3RKZ2J5?=
 =?utf-8?B?N0tSUzZWYnA2dzFkM2JRUHJ0eWNOR2xQUHRacTlrK0ZYdnkvRU15NkJEZWw3?=
 =?utf-8?B?bzN6Z2trVERxRTZ5ZHhBMW1YZHJFb3hLb256dEpWeFhOWWJKUEhsSUdmcncx?=
 =?utf-8?B?clhRT2FVRUdIR1ppTVliQUl3V2xjZUxUb1lOWjM4VE8yTWc2aGhNZXN2R2Jn?=
 =?utf-8?B?MnlDd01oYVlNVzhyVzBwTFNqKzl6UnB4WDUwbnJMRTQ1MkJNSitTRExkRFpn?=
 =?utf-8?B?M0p4cEFNcC94aEZPRkY1amY0NS9FUmU0aCtyL2xEZGdYdkhBbEtpcnNYazA2?=
 =?utf-8?B?ekxpK3pWWCt4aFlQVW40bzNzeHU4dno0aVhHZ2l4dEdxcTlGYlQyZElFL3E3?=
 =?utf-8?B?RnhZNkFpQUE3bGlkQnhuU21rOU1odFR3dHg5U0NXRGE2c0ZGSWhRWktZdjBK?=
 =?utf-8?B?bEJ4R3NqVzd0WFRjSVBzSEFPa0gzdUhIZjRxbkVVTG9Gd08vd0RZZU9EdGJ4?=
 =?utf-8?B?bkZFNlcreVltdlNLc0p4NTFXaDF2Qy9wLzBPNHJSN2U5S0ZQelROWThoTlBT?=
 =?utf-8?B?cGJpRWtjMDdZbCtqRUZPd1dCUkc3akdsU2FJU2NmM2RHRkE3bG0yaE4vRm5l?=
 =?utf-8?B?aGUzRit1NVFyNG9RZmsraWpmajRiS25uMUthbm1kdFRJRC9sMjRNNzAvby9s?=
 =?utf-8?B?VkxCeDYyQUxFb0xBUURQb2JnVnFSeXFkc09xRTZEQjMyMjgrdTBJNEtpSFRu?=
 =?utf-8?B?RU56cUcrcllBNk9sYVdPTHRSZ2FTcXVoM1NHZ2N6NXNtZ1N0Y1VmcUdSQUxK?=
 =?utf-8?B?c1EzK2gwRFpvbEhnK2VmVVk3TjRPd05JL1VwaG9DWmFDaHh3SmZBMm0vcVlY?=
 =?utf-8?B?dXYyUUVycTAySzMyMVlHTVRvNzVRTzg5TVI5VFdGMEo5OG9PUnRUbkNRZnFD?=
 =?utf-8?B?VGNxNlpCbWlhWDY0OW0vR2N5NzYyK1VEcDhLSGRmSDhlV2s2K0R5c1hzLzNm?=
 =?utf-8?B?eHh0R1R0SUtiMUNXbDYrR291UDd1RUVuYW9QdGxzcXRpaHMvaStLQmhFWmty?=
 =?utf-8?B?WjRCdEVpeFR2ZUlxL25HeDZXRlAyY2xKM1dFOUtoU2pFWnVlcGZxYjY4T3ha?=
 =?utf-8?B?RWRjc2ZQM0pUem5mOTd5Rlc3NFhCS0o4VWpCdndzSVg3RlJqTHQrRk5mNkQz?=
 =?utf-8?B?VnZLcnJFVG5OWWhha25PQXRid2JyMmUxSStqMzB1ZGtZT0hRdnlheXRNSjJR?=
 =?utf-8?B?RDVXdWVadGVsY3pTN212ZlQwNmhMOUdLSXQ0d1FwcXRxZUJCZzB2Yk4xc1Y1?=
 =?utf-8?B?ZTVjazlRaTVJSTMxRkFjd2JuRkZoMmwyaW8xMklYZEpsT1VzR3BXcHp3dFVC?=
 =?utf-8?B?RHVKS1VyMkdsYlBiYlQ5cC9rd1NJTHhIZHo2QTBGMTJxTUtaczkwTUU4eVpF?=
 =?utf-8?B?N3JSeHZtLy9LdWpjZUN2Ti9Uc3dHOFRhM0Z3ZURoN2Jxbm9vSjl2YVltdkdl?=
 =?utf-8?B?anp1SlpnZXhZdmM1Y1Q1V3N6ZVJwUlVWcnlEZFNnNVpTdWkvSXBrZ2d5Z0dW?=
 =?utf-8?Q?El2OieGeVLmpyMVFANZEm2VDY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9ad8b5-8861-4bb7-685e-08dd863c2d60
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:05:17.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQRwylI6uFGZxnp4Ahah20/iqlbOqHCCs8ncQc4BrBVLFN6Ocul5ZQT9a0TtVvGygiXgjqDY/FAcZsLjo3eOkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9862

From: Han Xu <han.xu@nxp.com>

fspi driver use devm APIs to manage clk/irq/resources and register the spi
controller, but the legacy remove function will be called first during
device detach and trigger kernel panic. Drop the remove function and use
devm_add_action_or_reset() for driver cleanup to ensure the release
sequence.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 0ea04e77a968b9c8dbd73a76984022a8f9e9b178..e63c77e418231cd0698ffb73eeeebfbe63cc3065 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1168,6 +1168,24 @@ static const struct spi_controller_mem_caps nxp_fspi_mem_caps = {
 	.per_op_freq = true,
 };
 
+static void nxp_fspi_cleanup(void *data)
+{
+	struct nxp_fspi *f = data;
+
+	/* enable clock first since there is register access */
+	pm_runtime_get_sync(f->dev);
+
+	/* disable the hardware */
+	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
+
+	pm_runtime_disable(f->dev);
+	pm_runtime_put_noidle(f->dev);
+	nxp_fspi_clk_disable_unprep(f);
+
+	if (f->ahb_addr)
+		iounmap(f->ahb_addr);
+}
+
 static int nxp_fspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -1263,25 +1281,11 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	ctlr->mem_caps = &nxp_fspi_mem_caps;
 	ctlr->dev.of_node = np;
 
-	return devm_spi_register_controller(&pdev->dev, ctlr);
-}
-
-static void nxp_fspi_remove(struct platform_device *pdev)
-{
-	struct nxp_fspi *f = platform_get_drvdata(pdev);
-
-	/* enable clock first since there is reigster access */
-	pm_runtime_get_sync(f->dev);
-
-	/* disable the hardware */
-	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
-
-	pm_runtime_disable(f->dev);
-	pm_runtime_put_noidle(f->dev);
-	nxp_fspi_clk_disable_unprep(f);
+	ret = devm_add_action_or_reset(dev, nxp_fspi_cleanup, f);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register nxp_fspi_cleanup\n");
 
-	if (f->ahb_addr)
-		iounmap(f->ahb_addr);
+	return devm_spi_register_controller(&pdev->dev, ctlr);
 }
 
 static int nxp_fspi_runtime_suspend(struct device *dev)
@@ -1361,7 +1365,6 @@ static struct platform_driver nxp_fspi_driver = {
 		.pm = pm_ptr(&nxp_fspi_pm_ops),
 	},
 	.probe          = nxp_fspi_probe,
-	.remove		= nxp_fspi_remove,
 };
 module_platform_driver(nxp_fspi_driver);
 

-- 
2.34.1


