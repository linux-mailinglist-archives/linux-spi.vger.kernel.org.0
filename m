Return-Path: <linux-spi+bounces-10985-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E884C2F10C
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 04:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CF1134CC26
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466CA2571B8;
	Tue,  4 Nov 2025 03:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c1V/ZUFk"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575526F291;
	Tue,  4 Nov 2025 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225641; cv=fail; b=aT2j9Nwl4amTqpkxuxNBETHrpO6S88NKCh3C4WuN2ZtHGz5ldAApot+gLcjHvlSCMBJ1Vss82F5j1bLDgsq29yLUZkIq1xtB9lJu9Io4hfrUGtMEbVnX2r3ylsCOEsNRtMkk/dR/qQNXUiKfDTSlFU5yOYl+eLcBCU01E1MBqIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225641; c=relaxed/simple;
	bh=k7ePX+ebercAIx7lj1pGpklS2zCtotuKQ00X/HeTIg0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qdJS+SyprhOnC24VfEAf9xlnrNKy5T7oxapG9DLe39mK7qhg5pyfAfIXEj5URGjFWDaWZzHoDHucfjTq8pTLyJrJHcOzxK7Di7I9KuZJA1VNS4LXG3e6AXfKgWBMgUInt22tcylWLkoic7OnO+GYPIDX40uGyx6n4Z//fKmxhtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c1V/ZUFk; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+sDRwSsuwlSBkSzbqg/xNd0cPM9uqaYtxHL4nBkK5UdYMeYKI+W+4dwlRui8x15ainxCnRpodmEs5+4liekpKicQAOoOgMSYKvdVjIVNSrY3EkkgOaq4XNL49hIoTIIqieZK50bPxaBz+tA1KAvbZqu6i5SKx3qIYKrTDjRIhq8VqnnQCoPWQIpbeOm+9DvxpI/Wr+GyMVaKvnZpbD/qZ5cZXpqqhe/CKAYB+HKAvVg3f47AYhSzspqIaO4gSI5YwsuVbD4BRRBC1QLLP7FhTFmsX6C5kK6RZz/ZiiTIoTrtJPoFEGegIHIO9jzJTQHOu6z5QVbZPa0g2z5cotDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koqBZPEMM3AiS04L3e26Iv0FVaRaUiBQc/s50dmU+6M=;
 b=NHON+COlwlgA++mLFOyOC1lzj5ZLE9ghrXXtJ+ELDpnCZroeZOlZoNNxfnvWNQfOfhGUZlAzK79IWH57ULBavLsXPHvNmNFg//qEhs7a4Jvihhrmkb1ZklQUQ2a3dBxIdO5rgX5lU8/QEmWUpUWWWtNkhOloFMFNrmMNqrKS1k8Gn0bb5cj7lblO61d79rndIkk+EZn1gm4O0Kr9sc1tkXuKxdQyHZ9rPPeFoAqbPYbLRKmzBJ0o7IaU/6x48GBnM0QIvS8j0WoF0JIHQ+l1+ePswMilnh9YTJgoYBf3hWjUworKQJh2aMffduEta4HDd8MM8Ea2OCjtJun4TVWtlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koqBZPEMM3AiS04L3e26Iv0FVaRaUiBQc/s50dmU+6M=;
 b=c1V/ZUFkXYX5WxAKPYD31Q3e2tSqxrvRFcYsxuIQPEfH763c0YRM5TAIsJNaCWaQpVx6N0bnHB2LWPYAgnmQd1KhaaqtYt0vTXkYOUlwKxC9YRFiSdGlXBuXxR4Czylfp+m1bZlsngGPjQLHb8mKfhDdH+GzISdFiJ503TB4AizoJG+5+FkxxgjwRPMGpg9UKfyjka9AIxJFvsvAB4I0rBIrcyJk3g88KT8m4+BwKEmSOu+H4MnLx93LSNjF2CVs41MuEvwPheQbfoaMtyHrlzS22TAyPvLFDMKXFrB7VJhHsqB9VXrsaUfSaKgCMX744NFyp6f6QsksNwnXUmP4uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA4PR04MB7806.eurprd04.prod.outlook.com (2603:10a6:102:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 03:07:17 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 03:07:17 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 04 Nov 2025 11:07:36 +0800
Subject: [PATCH 1/2] dt-bindings: spi: Document imx94 xspi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-xspi-v1-1-1502847ade40@nxp.com>
References: <20251104-xspi-v1-0-1502847ade40@nxp.com>
In-Reply-To: <20251104-xspi-v1-0-1502847ade40@nxp.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762225682; l=3586;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=k7ePX+ebercAIx7lj1pGpklS2zCtotuKQ00X/HeTIg0=;
 b=soYSUbf7Qk53XNAiVBuGcHTg9Yu56GpPl+ki7zQVbwF6/1kO2IoMC/T5KBpSmtSFW05yHDX8H
 fE0INs+Mp1MAm3ajIJhdGs5VTHYjX7bBmiu1b7+i/axyOeNEzAWPQB0
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA4PR04MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc56638-34a3-4a8f-de6b-08de1b4f42d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWhYNnl1ZVk5RnJRMlRyUTZMSW9QRUxERzlNZmpCb1dhV0VOdW43QkJ2cW95?=
 =?utf-8?B?Y3Y2c1BxeGVOMUJSMWg2TWNPNDc5SEJiaEd1clE2emdaUkJLV3lhbFhQK0pJ?=
 =?utf-8?B?bmZBQUw0UDNXc3hJZU9raXdpZjlRL3FrK25BbVdhSk5SMDhWdmp0QXhUK0hO?=
 =?utf-8?B?dnM4dEROMjZ6ZzFxaXpwQjdPelVkNGhVQ0xMZnR5VDJiYk1Cc3VIZy9vZjln?=
 =?utf-8?B?N29iV2EvcnhFRXRUUWJYMGlYOERFeTFqdVIxWUtiNW1oeGNlRkMzRnBvNFdD?=
 =?utf-8?B?cXg3QjNveUhSNXFHQXRGQXJPWmJvQlBrRkVSU3RpcDlhSmJQWTN0OGZQV2lZ?=
 =?utf-8?B?ZGIycHN5TjVTTnJkU243djVZY2lyemVWT1piQ1hlQStBMlhWT3cyRzBLN1NO?=
 =?utf-8?B?N2FsR2FLcjR4WTBtVFFia2E2V1ZwWXdiQ2o2ZWVrREUzTUUvN2lqeSszRTNR?=
 =?utf-8?B?alB0aXFlUFM1L09ndHEyYnc2U09ZUHpRcThDaHFIdUxVZWZOOVZUNHc0VjBk?=
 =?utf-8?B?UjB0VmxOUTFXZ0srTm9VV0EwazZNZ3N0WW15ZXQ2cHBPTkNtcStqMHhwdlNZ?=
 =?utf-8?B?Nnd4SXRORWdabTRibmVYQ2s4VlY2ZHU0YTFPY3FOVm9kS1ZJWjUwZUNYclFa?=
 =?utf-8?B?SnRFcDhxWkJzQk8za2dmZExLcUVWM2FUR1FpZXJYZjNPRk5KaDlFRlR6Ym9S?=
 =?utf-8?B?TzZiV0lKcFl0a1MxbTlNOWM0dERIVXRNTzNORGdKRUJDQlN4a3pDYm1MYVJR?=
 =?utf-8?B?TE1qbzlmYWhMTTJQc0I4K1JyRVlSTnFyZGpOdGtTSU1wZkdjVElEdzVNenhv?=
 =?utf-8?B?dkYwWitUZ3FiZTVCS0cxNVBBZFphL296VEZrZ1lpZC81Wk8xd3VlTm5JOHhE?=
 =?utf-8?B?VWF5YUR4TUpyZFFSQ2p4VWFnNmpSZ0p4eW90ZjBKd1RiZlp4WmxTQ2prSXMx?=
 =?utf-8?B?VzdpN1lVNlNheXlzWWN3K2Y5T0VvYjZ5TXcyZ1B6TWNJcGpqUUVSZWoyN0pH?=
 =?utf-8?B?NC95dmN2L0R6aHkyNnQ5OFd4UzNiVC9RdDdUa3g4WHFPK3BSRk5MRTB5TWhD?=
 =?utf-8?B?T2VnUW9jTW1RMVJ3UjU2Ykk0Z2NBZ2djS1JYMWJLZ2FoZjkwQ2k2MDVWOWEv?=
 =?utf-8?B?K1pYbnkxOTBxaFdqNnVYR2RraUxnYS8wNkZ6S3FIZW55T3FNUEI2SUxWQ0JW?=
 =?utf-8?B?ZlZOaWZNcXBvTCt1Und4amYwV2s2L2p1QmdvaGxLcEwwK2dNYjZCZEo5Skhh?=
 =?utf-8?B?WXo0ZmtJRjJDMnl6ZWxwSUJGVEFCM2liWTVadXJXcjIwUFdadFB0emozbWNS?=
 =?utf-8?B?M1J1YlFmZlp5STBLV2tDM3ExUlJGTThuaHJnQkV6V3FvejhzNys4V3FUSTJC?=
 =?utf-8?B?WE8rUS9GdjYyZXQrTU92SXdlUW85VTl1RkRkWGM2MDlsem9uaDV0Y01JTXJX?=
 =?utf-8?B?MTM1aWRuTy90cGZyeXhLblhZdVBmcDY1YzlYOUNhMTM1N1R6a1RCeStkUGs2?=
 =?utf-8?B?VEtlNk9zVFRlTGhScnZJRWJ3Vm0xei9sTENDTVl2RUIxa2VXUy9HcVpyTXdU?=
 =?utf-8?B?SDdKQlRPNldVMWZVNWdYQXUva3hpSEtwekdhK0xFZkN5Q3k5Vm9UdmJFMUht?=
 =?utf-8?B?RUx5UzhBRjBRKzZWb3oyOFFOd0RDYTlwWTExMnhQYjdrMitxNnRoT0ZubUph?=
 =?utf-8?B?WU1UMUhRQjJTQjNxQ2Q3WmRyeDlnYUdiSS9xc24rTEJiTkhwY2I1ZVM5U2hm?=
 =?utf-8?B?L0NvVXQ2bXp6aDNZMVRMd1RyS0M3cHJOa1UzOUVrUTNBNVB5V3RQalAyNVVP?=
 =?utf-8?B?ZFVsdXdYTXdlSUtGcGR3NC82dGdpRGQ2OVFxREVEMzNZQTFQclBreXo3djQ5?=
 =?utf-8?B?WkZGWWZqOE13bEtsRnQrejkxeWFJMmQzZVFhdUV4OUhJTFJsWXFMSGYzOVBL?=
 =?utf-8?B?KzZvckJ6ZWhsVnNkR21UakIwWTRyamV2d0Q5R1RRUzFNOFVCdW1HalZlNmVM?=
 =?utf-8?B?ZFpDcTcrSWNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TThRWG1YWmoybkQ0dXh0MXJVSEhmVXAvVVg5cFpMV1kzSXpzVWlZcXVHWXFD?=
 =?utf-8?B?VDJGaitJTkIwNzJvYXV3QTVBS1ZTV3hGOS8vUDJnUzFuYUlvMnVpNkZuY20r?=
 =?utf-8?B?Y055aFJIQ0FqVGtnenhpOTFRdGZQWTBrN0ZtSUJRTmZENURnaWRaZDJJODZz?=
 =?utf-8?B?N1pIWk04cTNWRU9lMDJhaWxPUVNQNXB2eUN0MWpjN0p3NGcyVEtvbldoSFI3?=
 =?utf-8?B?WlBaa3JObU44U3ZhRjdobG0vWG1NN1ZTS1pHL2FGQkcwN21iK3orZTV1dnJw?=
 =?utf-8?B?eUplL3ZnK1p4aG0vUE9yUHVTZ1JGQmVidXhpQ21IeC9uNHYyemI1NlBIcEJR?=
 =?utf-8?B?aUk1ZWtzRi95eXphRCtRVjhZMERJa3RUQ1RrelkyZk1HUFZqQzRaM0JlYVdL?=
 =?utf-8?B?eERYYkQ2YW9UbU9TTGwrbElYd2psVUwrSlJDL2J4a3E3T0MzUGhVY1g5aDYz?=
 =?utf-8?B?TDRtMnc5cXBuT2dKS0pMckpiM1ZsOWhOVU5tYzdDUjF2WnZvTVJUNzlQZ1pj?=
 =?utf-8?B?NEhmVm96MzZQYkVDbERlaER6aCtMTk1WbkxLZW0vcG81cG1NdHZhRzBuWGY1?=
 =?utf-8?B?MmlrVnNZYi9ra3d4ZnNPRnBtNms5TW94eXRRSkRJaVcveHZOczlTVzYzZGx3?=
 =?utf-8?B?cU50M0YzQUZISUZxTGlGbytiUmJRQnJCMnRFL3Uwdk43Ti8xL3RPNHJrZW1T?=
 =?utf-8?B?RnF2T0JnSGVvalIwTndLZ0h3V2VZTDJWZDRQYlQzK1BYVUNhRDJwKzZWc2JH?=
 =?utf-8?B?cWdrL0FFU0tFTVNRNklhOFF6dE94dGduajhYOGVpeS9ldG1qQ29iS0FWVHVy?=
 =?utf-8?B?MWR5SjZHSVYvVFZQUnNQSlQ1aE1RelRsUU1PbmhGaHRheFFNMC90YndPeVBE?=
 =?utf-8?B?b3QrYkdXakk0aUtrWXBlczRyZDVOME9lU0tWZm5hMml4K2pPV1JZWnIwSkJD?=
 =?utf-8?B?dFlBd1lJZm9IbUVYZzVKdXArOGtuQnhRUjZ6RGQ3eXlhdWd1eS9JTGFPU2Nm?=
 =?utf-8?B?TXZUUkRoRTV2VjZFb3c4MUU4ZXI2a3JhRlhCR0xxTExhd25mZGwydWpHZXFQ?=
 =?utf-8?B?U3F0d2gxYnNweFNuZ3R3ZXk3T0w1K1BxeHZNTXFpa0VhUFdxV1VZRmJhM29q?=
 =?utf-8?B?QTRiSldhdXQvRURaMzFGQ3gzT2Q4TmY4ZlJmYkVJWHFvVGszS2U5aVVWQ05M?=
 =?utf-8?B?aExaeGRUWHlUNXFHT01WYWo1anJhd01OcWlmV3hRWkl4UVBDZDVhWnViMnc0?=
 =?utf-8?B?UWtveE10bGI5eFFRbGRmS2dBQjhYLzdiN3UzNGdldFJLeWp3RUkzZ0h6bnMx?=
 =?utf-8?B?cTZvZW1sc0swUTY4ckpmNGhEdGtIaHJwK2xCVDY2b2lPMUZrZmdnaitlOW1l?=
 =?utf-8?B?cW5TdHdsblhadHY4Yyt0QU5ETWVLaStpNXNWais2Y1pOOTlwQVlHUHIwcTBQ?=
 =?utf-8?B?a2ZrRENqSTNLdk1sK09VTXhMc1BUQlpRVVl4S0E3Y0FUTXZrMkkrR3VLZ1Z6?=
 =?utf-8?B?Rmlld1pCbGNVMnBVMGVzV2JsN2kwVFJWcEx1WDFqaHdXcnNQbzRONFlCZlJZ?=
 =?utf-8?B?NkR0aHhxblJiQWE5VXMwK2hIby82eHhYbXVFekhWYXAzQzFkOGJWcjQ1aStX?=
 =?utf-8?B?RXY4RVlFRCtka2VqRk13SG9ic0NNdHN3VExaMHVCeCswTFpvdkN0Y2N6SUor?=
 =?utf-8?B?bDNaeEc4QUQzVUdBL2l2cHdxcndJalU5c1lBNlR3bmNXR2lUK0NWM3huUHhY?=
 =?utf-8?B?c3o2RmRZeGJXaUNEazh0eXgvQkJ1SUliVjZVN0xqcnBIdk0waVJXejN5WjZN?=
 =?utf-8?B?d3MrNlRqMGtaNDRMTXR5SVpFMnlHbVlpRnpUemY3a1N2ZzkyNWxjQXpMWTU1?=
 =?utf-8?B?aTZoMTdrbjBNWTZ6VkZiejMrVVBJSVhJSWRaMjJoYUthQmNvRGlxM25hdTB5?=
 =?utf-8?B?SFVYck9ha2gwKzI1aWNSNkZhZzRxNWZCWDk2SGVndWJYWFJOTUJ3M3BFKzBG?=
 =?utf-8?B?d2pBdWdIdytSOUhQZW5RdEpUUERicnJ2WXE1c3FNMHpQRE94SFJ0b1JFSHZC?=
 =?utf-8?B?a1JNZnp2WUU0NVJUWUNsTzNQUHBPWWVLbVVkT2NxUlN6R2pkWTlTWW9vZlU1?=
 =?utf-8?Q?seYd21GZazkTeROr+WYpmvH5D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc56638-34a3-4a8f-de6b-08de1b4f42d3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 03:07:17.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiJLeMft0rLpYl27bWryTPQaN/+CBzOLN5KJodHazigwvKXvKECpTJSONBmmRALihGVPIgzdG9l/K0O/VQ15Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7806

Document imx94 xspi that supports interface to serial flash
supporting following features:

- Single-bit SPI, Dual SPI, Quad SPI and Octal SPI.
- Single Data Rate or Double Data Rate modes.
- Direct memory mapping of all AHB memory accesses to the
  chip system memory space.
- Multi-master AHB accesses with priority.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../devicetree/bindings/spi/spi-nxp-xspi.yaml      | 84 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 +++
 2 files changed, 92 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..36970514036fe8e776908a15ed1ea2b21f2c4c9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-nxp-xspi.yaml#
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
+    maxItems: 5
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
+            compatible = "nxp,imx943-xspi";
+            reg = <0x42b90000 0x50000>, <0x28000000 0x08000000>;
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
+
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9c92d43af5e22ae57877e239b47fd70decdb3fb9..2a47206cdb290b27ac6829d3a92289ca65d28d46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18622,6 +18622,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
 F:	drivers/spi/spi-nxp-fspi.c
 
+NXP XSPI DRIVER
+M:	Han Xu <han.xu@nxp.com>
+M:	Haibo Chen <haibo.chen@nxp.com>
+L:	linux-spi@vger.kernel.org
+L:	imx@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml
+
 NXP FXAS21002C DRIVER
 M:	Rui Miguel Silva <rmfrfs@gmail.com>
 L:	linux-iio@vger.kernel.org

-- 
2.34.1


