Return-Path: <linux-spi+bounces-11499-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7730C83C10
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 08:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD4884E12F9
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055152D8398;
	Tue, 25 Nov 2025 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UV1x9k2T"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEEF286881;
	Tue, 25 Nov 2025 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056503; cv=fail; b=oZzESHguw28dtP9vbmcHa4Xf8WzwZZiW8k4eP6KxiUzAlHI8jHw/g1OZeQ9Bw3avXcbFf71CSVO2p5RjhUtp3wjCRKYVIquHMVkjD8huII/7gD0WlbG6fguNAB0WZtYluHHSkl7wi/Fvl0FLUn1/02NcaVBqgnNtrcwSEr9Tu7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056503; c=relaxed/simple;
	bh=3WqOpi+QO5LNXdm7zNd+NTZC7LLcAsj/e/6AILGJPBg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=sNbOg/m2EXEoAJVV4Q7NbSpL0NLjGKGidd9IUxgpMvxj/vidwqbs6q8ezKsnZfF9pWWf9BZv8AHJw93znqSvlYmKSB0XJsnd6GW0Wx6+FCaPRiOqDc6Mt6KA/y6RrCR1Y6iwsM8VZezhcUJdlLWX2Z7fqrPmFhvDeFurjnLXFIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UV1x9k2T; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLfmYeJi9iEkfvupW0fAQUOJ2V53GtSueTMMatOZa3kiSkAAN8EPR76P+ToqNR/EGv+XT7ZH6IHfShqT0EpzCOtwr9noFmsVN1oU4Dwk0Jk9+xIG4C+wUdZcByvee+m/1OkQrNJvex5m2CMFbWKIO/M51Qaa8SZOowQMQ9EyodNRU/YTL96oa8ryhKDO0C53V9XTF5XCOzRah2fUABklqP4aWXQlGWjWzzTW3rJsIJP/i0lWzPQBnxdHyjhd5pqvSnaP9/yN4Ctz/If3W7L073Niw79plDNjeGFG+fYwpgXHjnMfnq6DUcHmcIvPOqGUhB1x3mBEFtk3P5+SdLbIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2618iRQHWuLA/17OAmE2QfKF8AbuJ4V2T2rHZAcwmw=;
 b=dSRw3Ye9fn+lIuG2lJzwkfygRqtSZKaH5GuZolZr79FLFtB50xoGgrBXAfSh1JXHvHhjD+cWgria9EREztoD7UbUSzZjAKiNTQJJLMZp0jtv4QmKznguMfmGtoMwwq91D2CJ3Sr9PbdVfhb5hIdZxLNjNryrCfJvVcRiXmOZSJGf+cUWtKWvkG2saRnWrD4Jo4Vl5Z/pMfE6J85FxmiJyBup+vRtpxFkxbNkMEEXbUTtegyMk+Pe23L6OeuBBpb+wSgb1mjHCXk696Ihg9mIycmLdC3NIFebGnR8R6xmLp9iBi2vM87SZTlYgMzAJOkaMTQzCFpKSzWmEUg54sAJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2618iRQHWuLA/17OAmE2QfKF8AbuJ4V2T2rHZAcwmw=;
 b=UV1x9k2ThzsNxouy2bLP+f1eG7X7pGNRkyeBKXAoVVk/qoOZEflTQmq3nR9UdyOB0sYGWNyfR7lxNSGzk0RgdVnf+lm61jhOTgYEd7CXqTvJ0FBMUbcKCdq38LLsSTeamgOqUTyNbG4dVqGDnvW/Gvz2v+6+EFGhtbBJ6ue/OR6APhJg48KzSpXokaC/1ph5DIqFAHZNcm7ckBGbqZ3PIJBGcCJCDGoDbAA4LXCrvv/kOsnV9hOR4b3aQWMnzqT2aZA4dBJCYkfUTeHQ70XvUQ7yD/xF5BR4O9+00W0173SB4PSzv4WGZfYX598am/mMk9W2Jqmztd9qOq3EYFTQaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10699.eurprd04.prod.outlook.com (2603:10a6:102:488::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 07:41:38 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 07:41:38 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v6 0/2] Add support for NXP XSPI
Date: Tue, 25 Nov 2025 15:42:17 +0800
Message-Id: <20251125-xspi-v6-0-22b22de50cda@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANldJWkC/13PTW7DIBAF4KtErEPEMPyYrnqPKguMh4ZFbMtUy
 FHkuxcnruJ0+UZ8b5g7yzQlyuzjcGcTlZTT0NdgjgcWLr7/Jp66mpkUUoOQDZ/zmLiPQXiw5Kx
 oWH06ThTT/Kj5Otd8SflnmG6P1gLr9FkAQj0LCnDBQddCZX1HSnz283gKw5WtvMgdAbsRWQkZD
 SjROYz0TnBPtm8WrMR06B20pgn2H1F74jaiKvFKg49tCBHxnegdkX+36HVL7AR6E1przIssy/I
 LU3Xtz2IBAAA=
X-Change-ID: 20251028-xspi-afc0a17e9708
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Haibo Chen <haibo.chen@nxp.com>, 
 frank.li@nxp.com, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764056560; l=4145;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=3WqOpi+QO5LNXdm7zNd+NTZC7LLcAsj/e/6AILGJPBg=;
 b=CGF7ZTGjM7djT6WcofgEaUStk/2IPA8nxRkidM+RGYxfbtPhusGEoy3l7Cg6bCRIgVbz3NFMP
 MTX+rb1c1fcAQQ5YPEMFVmFg/G6l/GOAtOilPrS8YsCIbDIb0KiWX1h
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA1PR04MB10699:EE_
X-MS-Office365-Filtering-Correlation-Id: a75c3b90-68a9-4be2-a61d-08de2bf61136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXdoNWZ0M1haQnhNL0hBaWNsRE9iMTQzQ21PODdZcVhudFVISSt2Y00rbVBJ?=
 =?utf-8?B?K2c4am9JKzVlbTBIMjU3UVlpSEtKOHBWNDhCK1hFRktMdU91R1lDVmFJSEpj?=
 =?utf-8?B?ZytaUHV2dWxlMTlPcGUxeGlmaVRaT1BzWHhtMVp6S2pJUEthb2NGZUhSM1dG?=
 =?utf-8?B?RTRWMm5nb1hpU3ZXVDZ0amg0REFKU2FqWmpsNzMvZnhZUjBhRHVWQzZXdkgr?=
 =?utf-8?B?WUVwVGpFY3lrM2dlOW5ES25udFpMR1VVd1JseVgyQ050OVNmZUpzV3RxZENV?=
 =?utf-8?B?SUlSdURYbzRjdm4zbGlnQ2pneDRMWUJpaVNsMXdDbnBWSW5jM21mS2NVb1lm?=
 =?utf-8?B?TGdVcU1XZUx1d0d6YklwLytlRCs4UDJFR2hPcWxlVUdZTFpZTDBCT2xwTXA0?=
 =?utf-8?B?cm1UQ05JYkg4UncxcUt0bGtwZ29uZlR6YkV6Nk1STDdkOUxEZWJ2aVpxTm90?=
 =?utf-8?B?R0NBMTkzTS82YTk0ZWhFRFQ2aHhGOTZ1TzduaTFEQkR5UFRQeVltcDROc2Zt?=
 =?utf-8?B?NmhKYmhDek9yWE5jQjB3bkdDSnRWZHVwTUE4U0hvWGY5Wjhzd09HVDJCSHB6?=
 =?utf-8?B?UEFFRTFoV0NxQ1RUbjRReHpNSmVOb1N6QXppSUZ5QjZORHJqQzZQSW0yVzc2?=
 =?utf-8?B?aTdRV3ZFNFJXa0g0TW42RU5OQUNsWmFVdnQ1djhIU1VIb0VyTjBhWTFlbWlj?=
 =?utf-8?B?aW1aVVVsOGxTaFdrZE1OVVQvUlEvZWxIc2NOZXg0TURQN2xUbzJUbFhDUkxE?=
 =?utf-8?B?QU52eEY0NC84ZUQ0RThGYk5XSElmN2JGVWpNV3JnUGM2NnZhV2tWWjlHaW5p?=
 =?utf-8?B?Z2JYWVYyYURWVnBJSEo0aSttY293UFhqTDZnRlVqZlp2NEhnZHRiaC9TYURx?=
 =?utf-8?B?WTJsMVBrdDhicU5qb0JYVUhZbVozRmx1RkZ0b3A4R2JHeFIyeWN6YVdFYW93?=
 =?utf-8?B?OVlrYU1Gb0dWKzl2WVUwTVFTaWs2REh4Wi81eDhwOURUK3ZnTmtSVi9lTGNk?=
 =?utf-8?B?YVJYdlFSSCtMMTVSZ21BWjZMVytKNHZ3ZFBnbGNrL2lWNlpmcWJjYmdPWWo0?=
 =?utf-8?B?ZEpmay9PSmdqVmFUcEhBQzBXSVg3QVUrQ3d6TGVtcUVxZk9KL1RFTWNkSW1Z?=
 =?utf-8?B?NC9LRVlmR1VVTUl5YUdkbVBEcnVSd0paaDdxa1k5bWZaTTEwdXR4N0ZpNWY0?=
 =?utf-8?B?WktoblZWbkFSdkhYaEJoalZ5aG1DU1pOZ3dqaVp2UGxINGl4WFFhTkxzOTl3?=
 =?utf-8?B?Y2M4cFFTa1pXNkNNb0puMGwyT2JYb2RlRUtHLy9HRmFyNnZ3MkNhTEFiRXQz?=
 =?utf-8?B?OGtTTUlvdW84TFg3VHQ3aFVwSWpRQmx0ZHQ5eTg5OUMweDNrdkh6R3d5UExF?=
 =?utf-8?B?VzR2WDA4Z1lteFRNbWVITjdWWi9tOGY2bzlUejA0OFgxOURZZGJBYm1DV2xX?=
 =?utf-8?B?MUVzd1hJczlDMjB5aTRBNTRva2RJVnp3amJIMno2UFdMSDVYaEJBZ3FpSGl3?=
 =?utf-8?B?S3dQQkJaZjkxeTdxYmZPV2doc2JTUG9oU3BLWHJmbjk5b1VaRHFDNXZrTGwz?=
 =?utf-8?B?L1ZEWmt5K1paTHFIYkZ4bFJ6Zmg5UlAzbDFMS1pYL0FScVowUHM2UlZTNkNm?=
 =?utf-8?B?U1U0ejQ0WXkvbEQ3VUE4L2x3TnU3WFAvd1A5U0IxMEtQNTg4bVUvb0ozRXNx?=
 =?utf-8?B?WUgrR0tqTWJUQ0RVcmR5RTNuelhOM1B2RHJiWUlJcmMxeWk4SnZPanlzYzk0?=
 =?utf-8?B?M25rVWRxZWtDWmp2ZjhHcjBldTdxaGptRi94MCtCYTlVMjJxY2J4aU1qWUZz?=
 =?utf-8?B?M1hrVzhYMFJiekFabWYvdVJEWlFKcGRqc0xVWUhtMHpMdS9aQUUrTVdWSW9T?=
 =?utf-8?B?ejlmYjdvbjdvSzdaVFNodTEzQU1EV3N5TVBzM3JuQ0Nibm5hYndRbnhEdU9r?=
 =?utf-8?B?NDBZMDBKaEFpWkM1MFFBZEpWUWZ0VjYvR0Zmay8wV01hQ0trYkxUdFE4MU5l?=
 =?utf-8?B?NGdCWmhxMENIVllzRXhpcVRCUmhKcXVraWtzNmRuMXBKZ2ZzMit5OE5id2Jj?=
 =?utf-8?B?M1kyNUlrb2oxWWQyVGxDRHhlRWRraHlnK01rUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzhHVDFlemdMV1F6SENzcmVCYlU2TUlYQ1JkdDZBN3BoSXNQbzhLSEhyMEsv?=
 =?utf-8?B?Myt0eGp4TlY3aHFoSFo4MEkyWjZ2V0RIakY0anBpL2J5VTdpUnpycWpYcnpx?=
 =?utf-8?B?OWwwc2E2S1pSNlgxa0J1bEFaYnY1aU4zTTFucDFTSWJqVUkvRU9pNWNsekY1?=
 =?utf-8?B?VjJ1Q3NDU2RkRXRTUVU5WUV1dzBQd1E1eVZoNXVnSXp5bzc4T1hSQnlNVy9n?=
 =?utf-8?B?c0g1d25tSWNmVUlackJaNTNicGZUamVyUUc4ckozRG9ITmJmWVU1OGl3WFZp?=
 =?utf-8?B?elB1clhTelErM203c1pkTkJXcEZwQVdTUStaNWxuUEdUNUxqMFBnSDZJSDcy?=
 =?utf-8?B?bGw0dytiK1l3NVMreVpGOVdBa3pTS0Fnd1RKZ0hEWUk0N2E1NFdGWWVpZE1H?=
 =?utf-8?B?MG9NVTBCdE80aXpzdlNQR2xCVlZiSDhDRnYzMThpV21kMTR6VzB2cmFhWi9v?=
 =?utf-8?B?NUZ4eXc1ZjVOdHdOUGs5L1BUZnhOZEVNNkFrVG1OQUVTWHZrVlhoNlM1anMy?=
 =?utf-8?B?Q2k2K3piV05TSUhlRzVrU1FjNmU3VTUwUm5jUWhTcW5idWN6MnhjZWVNRFFQ?=
 =?utf-8?B?bFlzaFZtRHIyYWd0d2Q0elhqbm56UllQMExVbUViSzFZVlpmekYveDRCbmVM?=
 =?utf-8?B?bUtxNExCVUpJMkt5MmkwTjRta2tFc0Q4NFIwcVVXOGMvT0w4VWFxeHIxYXgv?=
 =?utf-8?B?MXRnMzdNc05GK3Y4bjdCQmkrVGFpdjVjZytZcFExQ0dubWl5VU9MM09mTzJa?=
 =?utf-8?B?MCtUZ2ZRNTkxVE1YbWJPVVRYZWpxY1dQS3I3QTVYVFdIU2VEcE13N2o3eWRv?=
 =?utf-8?B?RGx0aG5qV2llTGc1VFJHMHUvazFndjlKZEtyQTFzWTVxL0hRMEtGRlVjeUJW?=
 =?utf-8?B?cllZb1VuU21udy9kUlIrMjNTRlY4OElqK3ErcHB3Ym9GQkhsQlhsZnlqMGxn?=
 =?utf-8?B?K3IwZVIzbkZTcWt6aEIzUjJ0Q3V4bkNZKzJNYjZpbVZWUFpjWUxsakpUMHd1?=
 =?utf-8?B?b2pLY0V5aDBaRUZjaEVYdXBnUko4b1hJRHUxMHE4K1Y5d0VoaDVxdVJmWWNk?=
 =?utf-8?B?bVdFRlZwdW9nNVRSR2pEc0FSV0d4eE90WHVNNThEVEFuc2hoYkZoSzRraGgx?=
 =?utf-8?B?RWVzN3ZhUVFGa3RKR3RiUmczWW9qaCs0THMrclJBa0Y4eHVzN1dydWpmclJU?=
 =?utf-8?B?N1JZdXlmSHV1cHFHdmZjK0xjV1BvSEhGcTRYM1Zvd3E2Uk84dFRJWGw5ajJ3?=
 =?utf-8?B?NE44bmhMQU95cGFFSE1oYVlDcjA2ak9oa1BjelAwRlBNaGdKYllYakpndGlu?=
 =?utf-8?B?T25zUFhEeGdTeGtNb1B2NDF1a0xCWGNpQjFCc2RXZGpieDk0K3Z0RzJDMTdj?=
 =?utf-8?B?Z1pQYWpZNE1pcW5JWG1BMkRMdzMxaXladms5WTBaR3B4ejMxM0drQitiZkVS?=
 =?utf-8?B?VURvNGorVlh5aGVFUXZ4alp2WDRZNnVrTFBibXNId2RzWHZFNGp4QllEV2FN?=
 =?utf-8?B?clJWdDdtSmh5VFVib2xrWVFua3pna1BiUXJvYzB2Z1dTdmxoWGY4OEFEZ2hz?=
 =?utf-8?B?OXpBcDdKZUVBaFNvTFBoc2Mva0QxTWJ4dE9XekNFMGFUdnQrT09UTGZTcloz?=
 =?utf-8?B?aFdRY3pBTkVyQzdOMkFxWDdlL3VEQW1LMzJwRlQ0bzMyYldWcnUwL2Yxb3F0?=
 =?utf-8?B?STZ1RWlVZVBjdTgwbjJ4TFE2Y2ZVQml1dWtFZGlXdVNZVHdMR0FtcjREQUlt?=
 =?utf-8?B?cXhyRWJ1Y3J1NXdFc1N4SUJ5clBtRlkwaCtNaTFDR0JEWXhjWEFnL25VK2lM?=
 =?utf-8?B?WlFhNkdpL2lneFFUT09CWjlOU2Eybm1QWVZSVHkzWUs2SDJNVjQwSDdTU1c0?=
 =?utf-8?B?SzljRkpEQTFRWmtMZndzRjZUMXhyTXZxQjYrVEx0TCsvVUJvUHBjUnoxbFUx?=
 =?utf-8?B?eDd0azlkOU82akdDMVBzTVY1ZjA4WWNlV01KVmFWNzhEam45Qjg4dG95Y3Zl?=
 =?utf-8?B?bnl2SUNVbHBFMGE4ODgvRlorVFRUZTFLV1lINFQvc1V4VWRCSjFxSStSdmdC?=
 =?utf-8?B?aVFFZEJpRDJ0WlMyTzU0M1R4QXFaTEc4QW1vVUgxdzEzamNGR09XWlBkOUJt?=
 =?utf-8?Q?ueOhZHw7VATgg/kNp5mPD/MZ8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75c3b90-68a9-4be2-a61d-08de2bf61136
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:41:38.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1UklvSBz30LGw/RlZjLM8pCvJFIkny25eHK/S4SqyJ3uEswuzn8drCspG2xUwtMDhu0mNJdWCJ1CW+KdL9N2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10699

XSPI is a flexible SPI host controller which supports up to
2 external devices (2 CS). It support Single/Dual/Quad/Octal
mode data transfer.

The difference between XSPI and Flexspi is XSPI support
multiple independent execution environments (EENVs) for HW
virtualization with some limitations. Each EENV has its own
interrupt and its own set of programming registers that exists
in a specific offset range in the XSPI memory map.
The main environment (EENV0) address space contains all of the
registers for controlling EENV0 plus all of the general XSPI
control and programming registers. The register mnemonics for
the user environments (EENV1 to EENV4) have "_SUB_n" appended
to the mnemonic for the corresponding main-environment register.

Current driver based on EENV0, which means system already give
EENV0 right to linux.

This driver use SPI memory interface of the SPI framework to issue
flash memory operations. Tested this driver with mtd_debug and
UBIFS on NXP i.MX943 EVK board which has one MT35XU512ABA spi nor
flash. NOw this driver has the following key features:
- Support up to OCT DDR mode
- Support AHB read
- Support IP read and IP write
- Support two CS

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Changes in v6:
- PATCH 2: check return of devm_pm_runtime_enable()
           return err when trigger WARN_ON()
- Link to v5: https://lore.kernel.org/r/20251124-xspi-v5-0-6fd03a6cb766@nxp.com

Changes in v5:
- PATCH 2: fix a typo of GENMASK to avoid build warning which reproted by kernel test robot
	   -#define XSPI_DLLCRA_DLLRES_MASK                GENMASK(32, 20)
	   +#define XSPI_DLLCRA_DLLRES_MASK                GENMASK(23, 20)

	   do not write XSPI_MCR_MDIS to MCR directlly in nxp_xspi_cleanup(), instead
	   read MCR, only set this XSPI_MCR_MDIS and write MCR. Find this issue when
	   do the bind/unbind test, find some reserved bits are accidently cleared and
	   finally impact the data transfer, because the reserved bits[3,2] need to keep in
	   the default value.
- Link to v4: https://lore.kernel.org/r/20251119-xspi-v4-0-a451afbccf33@nxp.com

Changes in v4:
- PATCH 2: add changes according to Frank's comments:
           - rename XSPI_RPM_TIMEOUT to XSPI_RPM_TIMEOUT_MS
	   - rename POLL_TOUT to POLL_TOUT_US
	   - return IRQ_NONE directlly
	   - use min_t() to replace min()
	   - use the new macros PM_RUNTIME_ACQUIRE_AUTOSUSPEND and
	     PM_RUNTIME_ACQUIRE_ERR in nxp_xspi_exec_op() and nxp_xspi_probe()
	   - refine nxp_xspi_cleanup()
	   - use devm_pm_runtime_enable()
- Link to v3: https://lore.kernel.org/r/20251118-xspi-v3-0-6d3a91b68c7e@nxp.com

Changes in v3:
- PATCH 1: fix the messed ordering in MAINTAINERS, add Krzysztof's ack
- PATCH 2: fix some typo, and add IRQ_NONE in nxp_xspi_irq_handler()
	   also add {} for else when the if has {}
- Link to v2: https://lore.kernel.org/r/20251117-xspi-v2-0-e651323993fe@nxp.com

Changes in v2:
- PATCH 1: re-name the yaml file, and correct the compatible string and reg in the example to pass binding check.
- PATCH 2: involve changes according to Frank's comments 
           - use GENMASK and FIELD_PREP
           - remove little endian, use readl/writel/read_poll_timeout directly
	   - use fsleep instead of udelay
	   - remove pm_runtime_mark_last_busy()
	   - keep one style to use up case
	   - use SYSTEM_SLEEP_PM_OPS/RUNTIME_PM_OPS
- Link to v1: https://lore.kernel.org/r/20251104-xspi-v1-0-1502847ade40@nxp.com

---
Haibo Chen (2):
      dt-bindings: spi: Document imx94 xspi
      spi: add driver for NXP XSPI controller

 .../devicetree/bindings/spi/nxp,imx94-xspi.yaml    |   88 ++
 MAINTAINERS                                        |    9 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-nxp-xspi.c                         | 1385 ++++++++++++++++++++
 5 files changed, 1493 insertions(+)
---
base-commit: d724c6f85e80a23ed46b7ebc6e38b527c09d64f5
change-id: 20251028-xspi-afc0a17e9708

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


