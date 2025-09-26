Return-Path: <linux-spi+bounces-10299-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C913DBA3398
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 11:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B6B4C444D
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 09:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9602BDC00;
	Fri, 26 Sep 2025 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sRL/JlQq"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA792BD5B4;
	Fri, 26 Sep 2025 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880015; cv=fail; b=KYOpiR33lQlro4j8/1YC4J3pI0duxUQY7tAqfRgZ5pV1iPeV9yDx5H1vEQtuI3HrRrYcOPTlQGqC+PJEsW/x4PdbnBGahO0Ms6aY5L24c+dNzyuOJznoPTYS0QhGMzlnoREa1Aw1SBmgLI4CXvY78eq+i9YxrM3Qn+jEQM2ZJE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880015; c=relaxed/simple;
	bh=aU5pWDJZEQ4C3f69zNFdjC3P9Kz/0as00t5Y8C0U/j8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pzoFefVaBaG/L82UdVCTZLuaNzPSKb+wz2aliFRcj7oBPoQlvSMAMCR0PX+mO8YAyxr+TzhGTLIiIeMcJoizCnNxw9fqmO0KiP3H37+wMH2CmT4nytywzYntmQHmQtmvMne3fI9K5uhD06beviJloHr1pWC3vieAJauuywVLjc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sRL/JlQq; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jal5iPKIrD+HX6btaXOHqGkE882j+BPtSLHcDhESlMGhatuEJYO7XjdwUZGFElYwuNZRP/HFAlHlscKhDCBAWhM6jhkc79GXp7XwXHSdmajxXp1REEPrIZ8FmxiB51EtjnIEoAlXKJJI5pOGh+IZQp/JsxkmrysogroyVxhlcOYtTe22+wAM+jtmpl8XAl8GyU/q23g2FTvnax6cAM/orKS4+wM423d4gnFTxbjYZotgGTh8Gn0Q+AjiEKnBA5AN/pQCbPsojSBCm13tj6G5dJLfSeC3Mg379uxXr/1E2ScUq1gwwgJ6ZiarvTjQa2euIXB64vWeCno2mxbRwkGf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CisllzEtNQHacdIzd1ln8WaUt6qLBaJWw9MPFYaCosw=;
 b=Tvu9npwpytJ+rAYocCzUy5eXWG/Pi+bIMcfpAI+JFClnBr9p/5bIdC28sURb/bSTNAj0BoA/UYojpbCsTzfxPFdLzgHSWqsBf9cc1WEBC20lLtI4oNfWHUiJJh2EX7I7giwedARl17yeued6SP8yVd8yNHwbQqXw8EUY7aofrjdnQAdwBMOfKigpGn5J3ZlqkY/VajDGghy8kXzxdSVX1zahTVFvvmVqMvBdssZKfxXWkXk9OMxLz2Pa/QoXEDvjLWY1vPADNKTIBtjQ+LIbu8cTBjXXuraTA7Xwn0Fo/UMUfauHgM15Qn/UMCq+8zXDU9MiZStEI1tGWh4im2IjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CisllzEtNQHacdIzd1ln8WaUt6qLBaJWw9MPFYaCosw=;
 b=sRL/JlQqlzCuQaKUVFHVBSx/5bF3ezu/UvazQUx/SmnjypQk3AIM6XnSM4WuzszZhEO7Kz12zoVUstQj5GFoN8Aeo+Fk6qEuQQQ0HIPqdexMnDUKGnXiyeGTw7DSVLIHZjhiDwpRzeozpnrE6syl7QAxcYqHG12l+ep7cpYgw9bbI2YclFYKBfcsEABSbYXPgFHxhZIS1jzQYByAcwB8IQi/1/PfiOU6g2TQSpg1ydSqw3XrjIvz2tbQ1B5UPWj4xxaikc3YINf0XrUZvOqScRFWO04iFSF1Y0Z6zj2aYLO9A007iETDyVNqbrV49g7ZEF0z6uVJ7gVW/z/akLzwkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8719.eurprd04.prod.outlook.com (2603:10a6:102:21e::15)
 by AS8PR04MB7958.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 09:46:49 +0000
Received: from PAXPR04MB8719.eurprd04.prod.outlook.com
 ([fe80::2ccf:4715:2885:70bb]) by PAXPR04MB8719.eurprd04.prod.outlook.com
 ([fe80::2ccf:4715:2885:70bb%7]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 09:46:49 +0000
Message-ID: <76ce7d78-5870-41c5-9114-9d230caeb2d0@oss.nxp.com>
Date: Fri, 26 Sep 2025 12:46:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] dt-bindings: lpspi: Document nxp,lpspi-pincfg
 property
To: James Clark <james.clark@linaro.org>, Frank Li <Frank.li@nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
 Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-12-9586d7815d14@linaro.org>
 <aJ4ox8+OLhIir2bU@lizhi-Precision-Tower-5810>
 <bd59344b-9dc0-42bd-98c8-80ab9ca97123@linaro.org>
 <aKNJFJDf1Clnkbex@lizhi-Precision-Tower-5810>
 <05701887-f78c-4de5-b7fa-d34afdb53af9@linaro.org>
Content-Language: en-US
From: Larisa Ileana Grigore <larisa.grigore@oss.nxp.com>
In-Reply-To: <05701887-f78c-4de5-b7fa-d34afdb53af9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::21) To PAXPR04MB8719.eurprd04.prod.outlook.com
 (2603:10a6:102:21e::15)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8719:EE_|AS8PR04MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: aba2235c-266c-4dc2-04b4-08ddfce19d59
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFZzbFNRVThRMGlxUlNxejR2LzkxNTFoY1h0RVMvY0MvMHFvd0lxSlVGeDVO?=
 =?utf-8?B?alA1ZFczQmZTL3BYdXZjYjIvUVJWN1lWbzUwQkNGRlNUOHBmbDRSMFBRVVZy?=
 =?utf-8?B?S0dRdDZrdFVIekFJODJZZ0U4TGc0elJRak1xNmlOZS9BR2c5M0NSVWl6aEdx?=
 =?utf-8?B?OUhacUQvYWUzK3NHS3pEQkFaMy92ZjJhRHhjcXlOMjVMWjNRdGY1bFYzVEpC?=
 =?utf-8?B?N1kydGNVczJuaDdKUmZBdmxjWUFBdU9BZVpUcjdMNW1RTTBERE01ckNXQlRC?=
 =?utf-8?B?TGRjT1kvZlMydUVNRFljNHhRUTE1MVJFMG5TdUIwUDRJeUE4K2t3aFpwWTM2?=
 =?utf-8?B?R2hSdWhrSlhHNUd4SDVhMXJ5dGdaRFlOVld2L05Ib1BPd1hiVElrSENBL1Nj?=
 =?utf-8?B?bXFkcWJEU0FvZ3NpRzVSYzRJckdxaUdnYWhDV0xQUHZYc1dQYTdLVmMrQXA3?=
 =?utf-8?B?emRRMWwzS2ZIdGdDSS92czJsdmlVWWpuYndydDRWYld5aGVqWENqV01PdDdU?=
 =?utf-8?B?QXp2MVMwaFVMc1pJMm5HTmpVbERtK0lOUkpQWVdSV2FidjBRZzQwNGNaK0Zj?=
 =?utf-8?B?aGdkY0pWOUZPcktoZXJUdER4UHQ5bDNocFVGUEFReDYwL3pHWHFGa1dzZ0tI?=
 =?utf-8?B?SGVxUnNpT0QwbXRRWmFobHA2emV3T25kU3lMYzU2YzVobEZqRjFKMENjZnJH?=
 =?utf-8?B?bG5pRW5ySCt4aXZRQnE1aXplc1hhOUVZSkZ3Nnkxc3g5QXNnMVBIRmd6ZFpl?=
 =?utf-8?B?aFV2YStoWHo0SFRneThqMGo4dXhVZVJhbS9jbEx4elhNSTVGdnpwNG5VRmc0?=
 =?utf-8?B?RFZheUhSWENRSm1uOHRhc0JVVmV3QmpvOTBsZFRXRlhjcnBHUTNyZGFQQ3I2?=
 =?utf-8?B?RDlHb3h2ZXdoM3dlZlovbGFqdWQvYXNqdHhXaEJtRnVQT21IamFlL1JVSGtk?=
 =?utf-8?B?c0lJUm4weFU4b1k2UWRuWlFvaHdLZExxRFd1cTlBL1NwL1JmTlNDaE1EVkEz?=
 =?utf-8?B?Q1NQMHFsbzhvUzBRT3lCeTRGeUN4cFExUmR2UmM1UDFlWWlLTlhuVHo5TFhZ?=
 =?utf-8?B?YlpqRXR6bjNSZ05mZklQNTRSZGh0amwxNm1nbGNqc1hKa1ZiQ2h6R3hqbUtp?=
 =?utf-8?B?YS9md25yVG00QWQyWUlVSWZyZlNhQUNsRVFRU3gxTTZ0YzV5a3VyVXZTdm8x?=
 =?utf-8?B?dlc1TDdNTE41RWorK0t2VEY0VU1hb2VEZ01YOXMzWEtjaWxmcmZkMGxTUklR?=
 =?utf-8?B?SnhyQVFMK0NkakhHYzFXM1pORG05aVhVc2lhRGI3M29KUWdkczJKbXpVUGxX?=
 =?utf-8?B?bmhqcW5OQThSdmFLV0NPdTVlaDFTRmFKK2lEQU5WekFTMTBOWEI4VGducEY1?=
 =?utf-8?B?d2loa1BhL3hoYWg2cDZiVDU1c2ZpcXQwZ0o4b0cwYnFGRHZEWnpDanZ4cExv?=
 =?utf-8?B?eVB2clV5bXNzMy9idWZYMmVYcDF3Zy9uLzZja2ViWUFrS1ZaRVZKMjNpN1ZQ?=
 =?utf-8?B?aXhMbDd0ZEgxbHF0VWM2eTRpOGJkcnNwS1BtaHZuY3hGQTdTOXBVMGZra1ps?=
 =?utf-8?B?TUNHVFpJdVVwb29xc1luMXI0aTF4R0k5THROeWlEM1QwLzQ2Zk9Fb1NuQ3M5?=
 =?utf-8?B?dVhOZlBYLzhpYWlrWm1LRkttbVVkUnhhWGF5UmxjK1dsYmZLVnJkbFR5UXFu?=
 =?utf-8?B?YzhkZ3h0L3RFanplc2E2WEhEM0piTFpKSDh6dUJxdC8vUkt5aFU0ZXEwRmNS?=
 =?utf-8?B?WmNtSWllMlE0R1BCY3VnSFRDbmFQb2J6ckhUSWowYlBxNEV0MFl4UXMvNEYr?=
 =?utf-8?B?aU4wRVIzeGRVTnhGYWJXS1RHUnlTZ2wrdVBqbFBsR2srTW1icGtQMU02Tkdk?=
 =?utf-8?B?REVwV01VbFFjQ1lHZkdHMDdnRDlsODl6UGFSMzBwMnFzaDNWanRpNFFsbm1t?=
 =?utf-8?Q?ga4YhV5qFsQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8719.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1VpYzlCa016SkpKVnZXaitPSGJ6dG1vZVJqRVhmVmNCRlpvZ3A1dFZmeHhp?=
 =?utf-8?B?eDY3NktzNGIzblRCL0JDUGphb1pQUXUremQ4L0tsa1Z1ajYyeXFXdGg4c0Fm?=
 =?utf-8?B?TTl4dC9oZ1FLOEVrU0MvMHRneC9QVUFQTGRQVk9UYmhZSG13cTc5NW9VY0lG?=
 =?utf-8?B?U0FaWHRBbHNvMWI4SzdPRkpyMjc4S3B0LzNINW10KytCeE05eGQ4UWxkQVRj?=
 =?utf-8?B?WTB4QTQzWUs4WjU2a21RNHJlY2tPUUUrZnpIZmxiQ0J3OVRPVHQ0SkxlZ0hS?=
 =?utf-8?B?cmZMNEhYM0JzeUJMNlJ3K3Z2aDE4NWlqNDB6dGs1Vlg1a0FqS1hRRkYydHJy?=
 =?utf-8?B?b0YvNWtsMVNrU3pDd3JEZGdwOHBZczRXQ2lZa3VkUmZKbXVwdW1oM2RJK3hE?=
 =?utf-8?B?ejNMOVRNNk9DL1RYWVJnV0p3Qk4zbm5UZy9FMnNDcG9YVkJvTWZBMWZvTG15?=
 =?utf-8?B?cVorc2Q5a3cyWURVTFdmMFFic05ZSVAraTVDN0NLY2hXMmhDNDNxTUhZLzAx?=
 =?utf-8?B?N1pzNHVTODBTbDZlczNOOStTY09jZm1uS0NybjJYMFlGdHVMK3l3cUJETWVW?=
 =?utf-8?B?RkxiSGNhbVZQUVdHSzJuem5nZ2J5ZlJrT0licS84ZnppYU5odHR6Y01QWUtw?=
 =?utf-8?B?RUZCNmRzZ3MySGdWUjVjRUdMcXRQbDVpWlhVVDgwSlMrV3VrMjBIYjU4dkcz?=
 =?utf-8?B?cldNcTB0TWYxYnNuNExHWDJKalZWRldjRy9FZ3NTdm1ReU1PbVlMMGZXQTRI?=
 =?utf-8?B?QUlUZVJQdlBYSnQ1MDlQd212YytBWTR6Wk1SazFrdXJBbXQ2cmwzTDVuOXp6?=
 =?utf-8?B?MzdsQkxiVCtMTXlEakVqUnZJUmg0Y3Q0TlhCemdIdlZiWWFMZzBuNkkvaWVy?=
 =?utf-8?B?MGlpSU9Yb2s4ZGV3TzNTZURWWFJRSDFNTWNWWi93MHZGQVA5Y04xYkNqYkFC?=
 =?utf-8?B?SlZ3WmlDMWZ2VXV5SnZXOHRkQzhEQTNkanEzNlIrdE92MkxaSEo3bHNHOS9C?=
 =?utf-8?B?Y0pWTE5aT2NpZlBtTk8yTVFEUEp6aVdEdHo3bkxDMWZpdnhDaWdmbkM0Z0p4?=
 =?utf-8?B?ZkVBdkd0UTMrendpaVFDVnIzSWsxNU5hREVjdWRaTmRvSWlZWmFpNGU0ZUhq?=
 =?utf-8?B?aS8vVEI2SEhzQXNsU1VSWW1ZK0VtVE5Ec1dMR2daTndTUUg1VWVxWW4vYkc3?=
 =?utf-8?B?eUhnNFc3ZHREN0lKQWEyMnFBNlhDY2p3WXVjYThFVSswc002ai80SU8vVjdj?=
 =?utf-8?B?ZG5Pd1liY1dHeFlVdit3OE1QT21XN29PdmVyUkhtQlJmQjVzRkYrZ3h2d2Fn?=
 =?utf-8?B?RDdCRUhxTzdnWmpzSGh2MVphSFpPSTVZaFZxSmJreW4zdDV0Z3diYUxxbEZy?=
 =?utf-8?B?QUZ6dDkxd2RLMGwvbWdXQlVkVUdmUFBNdURpWXllWXBVUVBKaEsvWERIb1V3?=
 =?utf-8?B?bEZ2NGo3VnNnaFpwTC8rRE4weDlncWJ3dnVzK1dmMm5saDBzMWluTEx6MkVI?=
 =?utf-8?B?VUE5SzVUbndqSGxOMFY1M2ZoS1ljOUdsL3F1blJ4T3dPc0w4NitHZ0pQY0hV?=
 =?utf-8?B?MUFJeS9iWUtoZmpxRWtZNE9TVmNGYnYrMXdzWkMvZVhDSlBDWWN1ODBDWkpm?=
 =?utf-8?B?S2hYOW5qSmVkSWRIRmxTQ0hrcmpYYVNkMGdzR3dRL0tlNnlpWFhzU2g4LzNG?=
 =?utf-8?B?SHZIQTNRTm8wNUNTRXcvUWdyUklQQmY1b2ZreFJUWndydlFydGNVampLalZ4?=
 =?utf-8?B?bHp3djkyRStZSS9CK293MGFYZVNUUS9YU1YwZ1dMNzdvaEpscjRVVFI1bjBN?=
 =?utf-8?B?OXVrc0hYWmhjbjZrOWtBNmQveG9wTkVBY0IveWxCYnZ2ays1enpuNXVpRDFn?=
 =?utf-8?B?cWNURkFNc2QzSkgwYmcxMDM3cWRrU1p5Nnh6aTVudzg2cFNEUHhnc0hFTUt2?=
 =?utf-8?B?N0lSQUdyc01NVXVZVEduOEZrREh5UmVaQm82UjJGaE1WMWgxNXA5allEejdI?=
 =?utf-8?B?VldCNjBGd0QyTWJ3d3p1WHZrVkU2TjFMdktVT3Zyb1dJc2NBSkxNRjJJeFVk?=
 =?utf-8?B?L25ERFdMSk5ZQ1BLSFVhRkpueXRRb1BiaHZpNEhJQ21uOUhiV05FRFRqMHlj?=
 =?utf-8?B?YW9GYzVOejFXN1BKcXRDSDhSYzY4SEFiQjNZWDYzSExHNXFxYmt2UlRMcFJn?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba2235c-266c-4dc2-04b4-08ddfce19d59
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8719.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 09:46:49.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psFAurkNyYaOSo3ocYydxWGxD4L6M6GREiDws/7OALiaAkOSbdRyiHi8PZYe8j6HgVO2KYDRm6RedhOSEvejeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7958

On 8/19/2025 12:52 PM, James Clark wrote:
> 
> 
> On 18/08/2025 4:39 pm, Frank Li wrote:
>> On Mon, Aug 18, 2025 at 03:47:45PM +0100, James Clark wrote:
>>>
>>>
>>> On 14/08/2025 7:19 pm, Frank Li wrote:
>>>> On Thu, Aug 14, 2025 at 05:06:52PM +0100, James Clark wrote:
>>>>> Document the two valid pincfg values and the defaults.
>>>>>
>>>>> Although the hardware supports two more values for half-duplex modes,
>>>>> the driver doesn't support them so don't document them.
>>>>
>>>> binding doc should be first patch before drivers.
>>>>
>>>> binding descript hardware not driver, you should add all regardless if
>>>> driver support it.
>>>>
>>>
>>> Replied to same on "[PATCH 10/13] spi: spi-fsl-lpspi: Add compatible for
>>> S32G"
>>>
>>>>>
>>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 14 ++ 
>>>>> ++++++++++++
>>>>>    1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl- 
>>>>> lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>>>>> index ce7bd44ee17e..3f8833911807 100644
>>>>> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>>>>> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>>>>> @@ -70,6 +70,19 @@ properties:
>>>>>      power-domains:
>>>>>        maxItems: 1
>>>>>
>>>>> +  nxp,pincfg:
>>>>> +    description:
>>>>> +      'Pin configuration value for CFGR1.PINCFG.
>>>>> +        - "sin-in-sout-out": SIN is used for input data and SOUT 
>>>>> is used for
>>>>> +                             output data
>>>>> +        - "sout-in-sin-out": SOUT is used for input data and SIN 
>>>>> is used for
>>>>> +                             output data
>>>>> +      If no value is specified then the default is "sin-in-sout- 
>>>>> out" for host
>>>>> +      mode and "sout-in-sin-out" for target mode.'
>>>>
>>>> why need this? are there varible at difference boards? look like 
>>>> default
>>>> is more make sense.
>>>>
>>>
>>> + Larissa. I think this might also be a question for the hardware 
>>> designers
>>> about why the feature to swap the pins was deemed worth including.
>>>
>>> I'm assuming the flexibility is given for routing reasons. If you have
>>> another device with the pins in one order then you can route it 
>>> without a
>>> via if they happen to be in the same order.
>>
>> DT team need reason to judge if a new property is reasonable/ 
>> neccesary. You
>> need  mention the reason why need this property. Here, some board design
>> swap sin/sout.
>>
> 
> Let's wait for Larisa to reply. If there's no board and it was only for 
> testing maybe we can drop it.
> 
Hello James,

There was no board. You can drop it.

Regards,
Larisa


