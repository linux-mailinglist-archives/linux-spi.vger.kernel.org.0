Return-Path: <linux-spi+bounces-11931-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4990CC0B43
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 04:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C84BD302AF9F
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 03:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2980430B52F;
	Tue, 16 Dec 2025 03:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sv7eWbRR"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D6284B58;
	Tue, 16 Dec 2025 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765855183; cv=fail; b=XWWA/Djd1wg5kfu4TR5cNH2Wt1kmWAdv/0Au9bltFw6OBcHZzC02ZcAK99OWyKz27Tde+0bpFrYJNsZPrPy9jLuCPvrP5Rg7Mlc+2XCXBqrP1UUcwDZ5DlENuEA6md7RQl5zgTscJCvD7pKKM6bAG4aRlAC0nojgwm+wQfB3SrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765855183; c=relaxed/simple;
	bh=vStgZAppLKBnzALM7U3Vo2QC9qgbad+yCAmPhO8DRJM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HKBInwga3ftifZtwNuWwKCxaKDLsM+2OUkSWKhh51zs0CJas/myqN/47xJdLd+bOVI8Tm4A91qfkZbyqfpz5BswTwMeJwaBUxz31ZjxDHJso4Oh5zujjnRDakx1IkS1gYawRlMssXuz4m0h45SqZjJVb9yu52NDDLHSWJf6/bLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sv7eWbRR; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ek3X57MjJ0fxAiO52kC/k0Vk2xjXo9K4o9rdL0jHsTDMM5ML9XvZm2JL7qim9QaWLQb74F6V7Gv7eIQfsOZ7LwD5eYSOKQmCuHBKaPS7+QiwEVcKLNJxx3c65b5WaTnWm0T/U2TmJMHOfSLe+ZhE8oa/uxSvAt7ZzSgvt9z6hNY6Zz1rTISEog3svJF7+u3B85p0PMhe7/m4b01B3TwSzubByk9926BJpsRoNvVs/1FDYFtgD6vGEZo6Col65x4nLXCBRJMdCqA5IHH61HcfswWeMAwxA5bJJhK0ctrYH3QVP3JkMheAiZu7hnvxY6cGgUQj3aEpj8gKfDQq9s/I0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRKisz7VFn/0TKqqiRNEZDvdHdzjpSupg6iEjZs67vA=;
 b=ZQOYjy4lPOlb1Eiikii7bCBpul3LvLTG387LDOyjlB5OSo5oBTi8c81BejbkHivIb8Xjns3E7ObOJUKQUJ+42dFmXBHCYaC1QYNIAeWzO5Xo7nwFMf2/7GsKjtKzd6gQqQMl45XRI8dFP3KJlYIQFTKf2K9geG3R4XhLirsNkZiFtX5gJTM2vmZEep6SknGDtj67PvEMoVEktdfPGxnWuOKfdYA2IOBVxi2rch4FUBU4uijvQ94u8ZP/cx+z2wzMGf+Z6ON/WHolvW7JgsqGqVGKwJt65CjzD++TKGV9m0rPF+xwmEe+EkLAp36PianV40zGVCIMZJgiER/cabGBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRKisz7VFn/0TKqqiRNEZDvdHdzjpSupg6iEjZs67vA=;
 b=Sv7eWbRRFzCxm7Cu8Va2Ls/1lOVnB6x7vNXNZdM0P2lSiAoEj4QvMvsS14aY9VusVZbUF6t8J4GCrqKpPx5z+4Rz89tGPN+u2EHAGEa00aA+YIQLIlgJwQZ6rCxAj9lVBeei0A9PfMe4eeV0UhgO/vXbvkc8XBrnK1oc4tRYbr3UnHQHgVfI5jXRPoHoz4P4h7J7bq8Esc/pWt4ZLQaXfInU/+2i2hgA5VnVBt+fk6bwQGHRVLBPN7Ly+vrq6F2Bca54+s6QEgJ9dmr163bSZ7wZH9+xXQiSvH2uOXIx4xXKXWqfd1+bpz+PNVXZqUkCdaYUbSWQzzOC+3J3aX6Btw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV2PR04MB11935.eurprd04.prod.outlook.com (2603:10a6:150:2f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 03:19:38 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 03:19:38 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 16 Dec 2025 11:20:13 +0800
Subject: [PATCH v7 1/2] spi: dt-bindings: nxp,imx94-xspi: Document imx94
 xspi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-xspi-v7-1-282525220979@nxp.com>
References: <20251216-xspi-v7-0-282525220979@nxp.com>
In-Reply-To: <20251216-xspi-v7-0-282525220979@nxp.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Haibo Chen <haibo.chen@nxp.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765855251; l=3868;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=vStgZAppLKBnzALM7U3Vo2QC9qgbad+yCAmPhO8DRJM=;
 b=SaSPP7helcpFUK/lKtXAQzauIcCCOSCORNNlWuvYImvXK2NcMqjht4u7cjWvBSaEo9ydUfmkk
 NVc8ZGzSRteBmcGU79z2StdcJJyW1noffIPG2azpUJXBBNNZu4wDL1B
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV2PR04MB11935:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f2cdf1-3b8c-4a19-60bb-08de3c51f205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlM4Wm5yQStlMGU5MXpXVUJJTHhSdjBDWjkrSW8ydWVqYVF6V3ZJKy9zWldU?=
 =?utf-8?B?dFhiOERnY1BwTXlwR3ViRkp0cGZ3RG1CUjMrQUdHOEdNa1dJbnNGekQ1NVVG?=
 =?utf-8?B?a29CdlQwdUt0MHVoREZVbWtOanBjTmR0eVZHdGZOdjVlL3B2TW96WlJJcjBl?=
 =?utf-8?B?bk5sNXdhdW01ck5QSkc2a0dvNlNYRG9nQkhueXh3QW5tOFJFNzk0YmRUZk9O?=
 =?utf-8?B?cmpHWHZuR3FrbEFCeHBXSUxJbkxiVnF0OEVIQ21MazdZSC9Hck53OU93Qzh0?=
 =?utf-8?B?b1RvaUlBWE1kd1lCU0RpUXBBRUx1Tm9uM1dXZm9pUTlXOWdkQzd4NE5ndEJC?=
 =?utf-8?B?ODFCbncvODV0K2JCZDJjbjNYNzlabkx3bHlDdklWV1NpRmpLQ1JubzhFM2FF?=
 =?utf-8?B?bS9PanlKNjV0bkZTcVBHTENLTElOVytnbnlRNUpWc1cwY0NZRC9TY3ZGZzBP?=
 =?utf-8?B?Z0dCRFg2QlFIK3RhdXlrWlNyd3gzSE1YOUFnL1loYlNHS1JNRHRPa2p0R2hF?=
 =?utf-8?B?KzhQNktNVHJwTjJLQ1hBMWdqcWhWVFlpZW5pRkQ4L293V1JGdmVHR08rSTI0?=
 =?utf-8?B?eUZSaThFU0c0N0xvOG0rc0IzOU0vR1dFbnhOVkhLWlF1dFhyUm95WUMySFpx?=
 =?utf-8?B?ZVNzSkcxRXZQOWx2eHB5djVQQ3dsY0xOSEZuanJOb09hdTRSQXdqVm5XY1Av?=
 =?utf-8?B?cXBjRTZVaVpmWStJT0kyRzh6bGtFcGVNcDBuazQ3dkV5VkNtVlZra3BSOTAx?=
 =?utf-8?B?VWY5TXVCRFZZQ2tUYVhNamJCSmtkV2MvVVlUM0JXZVZFU0duS3BjRXRxdkZo?=
 =?utf-8?B?Qk10cFNqWk9pNVhCejBQNElOcVNEM2VPK2RJdUxYR2htOXhJTVgyZHNtSjZZ?=
 =?utf-8?B?UlZKdkhVaFFsODZxOTZyTmdYTVNGeWRMdjc4WTJIdm8wY2dqQVJjSDN3eTJn?=
 =?utf-8?B?YlJlaVhLTlhGUWNpeExUdXFnTmY0cGdhV0w3V04vM2tBazZJU0RKZ1VsNXhs?=
 =?utf-8?B?cGMzV01FdExSWVFKN0JLUVdtaFh3aU5CSGJya2N6U1BXQVlEcnBiSWtPNU9H?=
 =?utf-8?B?R3RzbUFGTVB6TEF1VW8vRk5ybmZLdTdIN21oeDhaNGZJRU90ZHNkZ1hDbGtM?=
 =?utf-8?B?KzVnWHN5U2tEQllQL2tSZm5tOGJ6aXpCYmFxclNxK09NbnF2SncwemNrUVRl?=
 =?utf-8?B?U1dZT09kay9lc0pnK1hnQTBFK2hJSk1HaTF6Y3JsVjBrZ1ZhRlRReXhqWGsr?=
 =?utf-8?B?OUZjT2ZseE9qVlQwL0JHYldqa1hNbGVqSDZqSzdMUlU3eGwzMWlPWi9zanRj?=
 =?utf-8?B?NmZqQ2lBKy8yVXpteGdtRHR1SDBsVWcrMzFyaU5LWGlvRTVzMDJDZUpwME5Y?=
 =?utf-8?B?elFucUkxZkVSTlo4WHE2RVdjcThzbjBrY3hjS2dFdWdreHBpRHpqNERYb0tK?=
 =?utf-8?B?cWZNMCtJd3JjVHpzTXlsdXhSWTl0L0VnVTNSenF0TjVGMDdtY2M0Ukt4VzdT?=
 =?utf-8?B?c0JlbTVQdk9EK0l2S1JCeEdzejN3TjEyS05DK1NVNmN1eC96RWZzd292Um9D?=
 =?utf-8?B?L0xHTWx4SHhybjB5VkJyRGY0cE5zUm5nTGdqRDVDV1JXeHJ1QmlSd2l0SjRh?=
 =?utf-8?B?NWVhdHJrYkhKdGdDY3RodnFVYmdEWUt3YUpYQTBLY2cxS2lMcXB5VUkvUmZt?=
 =?utf-8?B?UHJzMjFDTCt1UXQxbm9KYWhaTnJtLzh6a2lYRUIxWGF5MEFlYzBxdXQ4TWZ6?=
 =?utf-8?B?L2N6N3ZHdzdhYkg3L2Q5cUlLSy9Icmp6djljSnRuV2gxZUtrcGprbmpwQ0c1?=
 =?utf-8?B?T2VycFduWjRkR0FBQllqayt3OGhZeVVnNS9kR3ZEZHJzVWkySXhzQjVoSWNG?=
 =?utf-8?B?ZGZ2Z3F2ODBHT2JDTWFqZkhpd1Y5dTRkQTI2VjcvUkNLUHRpbnZ3dDRDWkpK?=
 =?utf-8?B?ZVhwMWNTN2M3MW42ZkZveklUNGJ1Z1VKWEVkclhTV09TUGVPYkRHTERpOFFL?=
 =?utf-8?B?aUtBb3VqQ2NRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OCtZRHBJMXQ2cTB3UDF4SG5WZ3lpcDRqZmEvU3c3UDZoeXEwaUU2dFJpU1hT?=
 =?utf-8?B?QURNY0g5NE5EQURyaktVZGgvbk9weWsxU3ZRL3R4SVZaQUUyTmNGS2dQZDJ3?=
 =?utf-8?B?VHRldFQrS3lnTldjaE1LbUVZMnI1ZWdJSDF3NVFjTVQ4MWtDejNCYWQ5VDcr?=
 =?utf-8?B?RXVRU0NrSS9LSWdXU2FTZU9RMVpIL0NkYXN5Qmo4TWo2akVsbkhTSWx3T2Vl?=
 =?utf-8?B?ZldHcEtQa0lOa3ZzeWxKano3RTc0TG5ZekFOWmtNZVA2OHV1VkpJVW9lcCtL?=
 =?utf-8?B?RjFoMTdRYnpjYUx6dkpicTc5SHp2RkJLY3Fld3A4K1Avd0JrRUw5czVmcVdW?=
 =?utf-8?B?dUNheGkyY1FjZDVJU0pHVGE5R2thZkxqQldZOEt0dGN5MTlOMU5uRGxsaEha?=
 =?utf-8?B?VUszY3o2S0pHZDNxUTk4blpQSmthVU1KcXY2b3VwaGFpMUY2YnppWVdLcU9h?=
 =?utf-8?B?eUc0NUwyOGFhWjhNOWxtV09meG9BMDJJTldTTzQxcjFUeEZoci9YZlBWSnpW?=
 =?utf-8?B?S1FrZGVUb1dtUlpLdVVYYW9yQ3o1a2NVSloreEpta3RidktiQjIveFYySlp5?=
 =?utf-8?B?NktZQlV6TlJBcWM1QjJoODN5TjI0MDRFbTBZR2p3WmpyMndBQTA1QXd0N3g3?=
 =?utf-8?B?eVkxUWRVaWp2UCtzWnFWalRtZ2k1bGRYd2ZCQU0xNmhJbWxncDF6SEVuVVlB?=
 =?utf-8?B?cllZRWNyU0RBTnI2M29qaVFucC9Qb0NKNHBnZG8rWDA4N0tpL1U2VjNieHNN?=
 =?utf-8?B?Yy9qVEtrNjY2NjgwaytrUEUxeDRic3JzcDhYa001a0RxSThLZXJ3VUN0Ui8y?=
 =?utf-8?B?UC9oQTVRQXg2UTNWUzNxdWdwR2FLaVRpcE1KQVYvZlZ5Mkp5RGFzL1ZIVU1O?=
 =?utf-8?B?K3V0cjJCWERPZzlnT3NoSVNwcU1IWmtEbjh0WGpQRFkzTUJaUFM3dnNQTUVT?=
 =?utf-8?B?R3F5cXYwZ3BDMnlkRlBYd0Rwek5uV0o0ZUFicUN4QWpmWUhoN0drTXV4U1Ns?=
 =?utf-8?B?ZlRvYmRnVHNoL1BUY3NhZkk0ZHpDZG5BY3lmak1rbklFYy9PUnVzZXFSQkFq?=
 =?utf-8?B?TUZFbENhWVkzaXd2dkZPSWFYN0NWMzB2dnpMMnVzZDhTa09vR2hNNnNtU0Qw?=
 =?utf-8?B?bVpFcStjak0yMjNsY1BxZ1QrejR1amRqamxjcGFtNyt1ekp4UmZ1bG9Qa1RC?=
 =?utf-8?B?cTQ5OW5DeHVSN0tsS0VGU09ORElyZDRUbU5SNk5Vc01QTDRkekIxcFJWVEhP?=
 =?utf-8?B?dUZ3UWdoVmhzTkVXbmx0NldJSHc4NXdBeldGL0Q5K1E5bllpTDVNaEg2bmkw?=
 =?utf-8?B?RFFSd25Ea0tSeWIxTEtXNUpLQXg1SS9ESmQ2Q051Y0NRSTlWVnhQdWVzaXZO?=
 =?utf-8?B?WFV0YzlHQmkxdXJncFhZRml6SGZCMmszWjgrUi9vMzhCZlJUbFFwS3U2QTlC?=
 =?utf-8?B?TTJlRkpHYzMra2xtUmJpcVptTUpFME1LbWlaY1UvZEg5bDMxcTVoQkUxVVpF?=
 =?utf-8?B?dVI0QXFWNjdxcFE5dzk1NHZaMHpMUHlIQ25ZaFVPeVhTdmNTZkdUSnFnWmUy?=
 =?utf-8?B?aDdqM3BpdlZHaEdzdnMxTno2STgyY0N2UEE2djR4ckJPTGVwbFpQRVRxL2ty?=
 =?utf-8?B?MHV3UEwrdGMvVlE4Q1M5cStPVXVMdW5qR0UxTS9oWWhMVXJoc0ZXbEE1MkVH?=
 =?utf-8?B?ZEhkTmFzb205ZG9Mbk90UTNvd2h5VWhSMU14UlVuRTEvT0hEWldXZUwydkQy?=
 =?utf-8?B?YllHK3RmOVZzUldMOVZWazFPM3FlMHJDeFFoMHVFOXZ5MlJRNEhzQjF5ZG9I?=
 =?utf-8?B?cHpmc1k2RVBHNkNBVm5zN2Rmb29Hbkh2bFNlbnFWOVc1VnNQYmVoNXF4S1pu?=
 =?utf-8?B?ZGxCUGZlMnBmdkEwVEVtTDhEQUQ0aDZ1ZG5lZ1FSV3YzelNRaE1WR0E5N3du?=
 =?utf-8?B?dHJ5WFFpQ0tWVVA3dnZNY1QzdVlBclA4ZXlzZk5XNDkwQjhPNW1nMFhyWERk?=
 =?utf-8?B?TkhTaGswQ3ZCRmVKbTNVOCt6Q0N3Rmk3S3JjcUd1SDB5N09nVVZ1dXBYemZn?=
 =?utf-8?B?WVhSeHRMbjNVU3N2WE5sV2NLWEl6c3cxV0NYZzErZXlSS3V5cHdRamg1SVdY?=
 =?utf-8?Q?5v6xQ/wjkxIlX1O+tlxwyOrJm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f2cdf1-3b8c-4a19-60bb-08de3c51f205
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 03:19:38.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvqV4y1+1wz0nSMols941hfES8w/eOoNqRyVATIWo108e14+QMY4txnafac3yleMidndSfJzHK/E5Q1IQYM3Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11935

Document imx94 xspi that supports interface to serial flash
supporting following features:

- Single-bit SPI, Dual SPI, Quad SPI and Octal SPI.
- Single Data Rate or Double Data Rate modes.
- Direct memory mapping of all AHB memory accesses to the
  chip system memory space.
- Multi-master AHB accesses with priority.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../devicetree/bindings/spi/nxp,imx94-xspi.yaml    | 88 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++
 2 files changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a0f4b162c85855c55d06c6ea1a2417af5121fab2
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nxp,imx94-xspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP External Serial Peripheral Interface (xSPI)
+
+maintainers:
+  - Haibo Chen <haibo.chen@nxp.com>
+  - Han Xu <han.xu@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nxp,imx94-xspi
+
+  reg:
+    items:
+      - description: registers address space
+      - description: memory mapped address space
+
+  reg-names:
+    items:
+      - const: base
+      - const: mmap
+
+  interrupts:
+    items:
+      - description: interrupt for EENV0
+      - description: interrupt for EENV1
+      - description: interrupt for EENV2
+      - description: interrupt for EENV3
+      - description: interrupt for EENV4
+
+  clocks:
+    items:
+      - description: SPI serial clock
+
+  clock-names:
+    items:
+      - const: per
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        spi@42b90000 {
+            compatible = "nxp,imx94-xspi";
+            reg = <0x0 0x42b90000 0x0 0x50000>, <0x0 0x28000000 0x0 0x08000000>;
+            reg-names = "base", "mmap";
+            interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&scmi_1>;
+            clock-names = "per";
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                reg = <0>;
+                spi-max-frequency = <200000000>;
+                spi-rx-bus-width = <8>;
+                spi-tx-bus-width = <8>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e5b1342ee2a660575b5246a11bc89baefd973388..2808b91dae1aeabbdb79408461b0d912cdd44c39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18958,6 +18958,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/trivial-codec.yaml
 F:	sound/soc/codecs/tfa9879*
 
+NXP XSPI DRIVER
+M:	Han Xu <han.xu@nxp.com>
+M:	Haibo Chen <haibo.chen@nxp.com>
+L:	linux-spi@vger.kernel.org
+L:	imx@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
+
 NXP-NCI NFC DRIVER
 S:	Orphan
 F:	Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml

-- 
2.34.1


