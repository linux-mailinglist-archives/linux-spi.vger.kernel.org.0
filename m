Return-Path: <linux-spi+bounces-10201-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A5B8FA42
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 10:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACD6C7AF714
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F594280033;
	Mon, 22 Sep 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fQz52i7p"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752D27F74C;
	Mon, 22 Sep 2025 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530848; cv=fail; b=VeaLMPgMOLeBk+byqInTJnmV3YBy5BDudtVuVIAYBZii4lk9v73x3P461RFyWywOcdumNdI87oIOBr+2dvO0ZHf0xojFM2w5KaiIXKYyuLfd3+EtMjlLPM9vRqXKBgizBfpoVmwrkqiQ+7i21jieZqOsgPR5WtlNfO5kCp0id20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530848; c=relaxed/simple;
	bh=OlWKvb2LLNf4RpzvC26O4/p7AhSFgRQOrkw8Kbm+Rxs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=FbQOb5qFL0+wA7RKiFQA93ss57m6/eb30WaSCZ2bvGwEcodx64MZVqIuTETKqKH0B0WjoijCHSDWGORcOPvvWy4+HyHFovaN83hHsuwwkV9Vsg5cbvs76eBwRTLA94HjLMfj85VKBjLOjzqakwwhIaRVRCE+2qhvTQ03Z9B5tg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fQz52i7p; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH2Ys9wt98wEoR6LLiDzVkDh3NJ3v1yWi6oLNilKTBItvJTQRr0U9AjepTzrZkh0ASd1dOrGED5LJjMBkDL3F63zSVUc84oHvE6ZLfctT1InwsffIethJLaHW1w2qgzl33Jp+KbCZzGcPX8nQfQkrwi4RupkyhBw+nWXZ0HxeyT6IFNpSVr+0qAZ5Pn1TJuJcS70gyHSUjGGP9szsSkkLHRz6q/+ircreCTuTYPer48iqroVQup8MdDNnDv410MrKJIk/XacXTSMLZ2S64MAfoU155/08usK4lzGZ4tTIR5ShzpMVBqrscKFnQy1N0D+uD5ZxsvsNkVEeSyQ1To9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwgUs1PiYSGmDhrYFizdj51McvsGVeOrA0+BBSwgSNs=;
 b=PULgw60b4e08xQBvNg71b2fDN1eL53sXaJDeaGREVUHR0emUu1RdQqq/BtMIkRWpHGtNuOabiMp9OUbuRtlOmeQ3jbuqHgLviF4NKlWSID1eakVTrErohcM4n1TmcmwyTi/fo8kKIp/RxQD0JnT9LV+m3iGxEkUns82cZ2v3T008bKvuBYIKyQUVNiQK3Rm32SX7hvKENnPepHHIZYT4u5I50LDRLZM/s4SPA8RpxYsY26nuhtJ06QO9vY/CLokLrjhTITbZYBHm7IhQMSH3Okdy9gSmGiFtv0hux3KL4oG3dH1KnpIuUT9hRKtFCiLvHfZRRSTLP9+zFJ7WLe4aMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwgUs1PiYSGmDhrYFizdj51McvsGVeOrA0+BBSwgSNs=;
 b=fQz52i7pyyKr0b9MCKFStPI3OaHBYDKEAHypFx4vDIH9RpfhaiCtQNiOkUQzs6sK+wfsICt21l+aWnceHOs1aSeatAm8b8ZQp4KBBKUk3D45YVQQLB2EjHoBAETtsrb//EP3feMrmcp1voX2G1o8kX5HPe3RoC+7BDDCDb5Eh6gsvpYaiYOVcBUUonbu/Xqivs6nMSU99+Ss6iwMembAuFCP/K9H9n6O454RZEDOVwZgQxJfoyKOqidXa2trUlqqB2133LwyFNhv9OfCWXIB8+2QrHHu0iXQf/Kx71O9bdMiFg1LoyTbzfwkT5qWDv79hUThLxZ7j3FBqa2a65aUNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 08:47:22 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 08:47:21 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH 0/3] spi: spi-nxp-fspi: few fix for flexspi
Date: Mon, 22 Sep 2025 16:47:12 +0800
Message-Id: <20250922-fspi-fix-v1-0-ff4315359d31@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABAN0WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMj3bTigkzdtMwKXUOTFJNUA3PDlDTzFCWg8oKiVKAw2Kjo2NpaABq
 D5elaAAAA
X-Change-ID: 20250922-fspi-fix-14d4e071df7d
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758530860; l=1192;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=OlWKvb2LLNf4RpzvC26O4/p7AhSFgRQOrkw8Kbm+Rxs=;
 b=t8pgpBu/svlMmFBlQZhD0E6yXU45HAlB5SYiwmoE9Luy0yi2JsTWsxF7Xo6SkIp50koWzwqy/
 lBiwNzW3VrADMZozaxQinWPGiJOTiAGPcEqW/NUsa+ycFEMr9K+zNr9
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c524ce-78ca-4ef7-8960-08ddf9b4a4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEoxSitiK3V3WGFRczlqREVOOEVQL1ZHblJjelRRV1lTNWRFVHdyS1JZOG4z?=
 =?utf-8?B?V0pmWUJyNUZBMGJ1MTFtRHlLVnJ4QXE4eG40bjMwTHVEclBxMTlvaWZhUldS?=
 =?utf-8?B?cXRVZ2cza1NpTVJZQlcxSUFFa01oeGg4QzlCUXlMY3hGNlVOTS8vbko5blpm?=
 =?utf-8?B?L3NGSGV1cTJJTVZNTEFWZ0I3WDd3OHordnlYOVdXZUFiNllNQ29SVE42WmQ5?=
 =?utf-8?B?UlVCSjNQWG5RRU1mLzZvSURUWHZ1RW5CK0NrVC9tY2VyMVg1eU1iS01RRXhU?=
 =?utf-8?B?L0tvUzE3VVgxZmpJVHN4b2ZhQlBOTWxVby9acFExSHZYSWt0SVhldU1nSmVH?=
 =?utf-8?B?Smg0bU5NZDJTREpIcFRLcThIekdYbExReFF2TGRWWDROSFEvcnNPNGZJQWtj?=
 =?utf-8?B?M1pnRkVMUU94d3UvOTA3TWtyNi9BU3JEazB0b214WkJzOFhmbkZ3aVV6cGpV?=
 =?utf-8?B?OG9aTnZHQkVxdWNuMVJYeXVSaFVWcTYvcTFVdFRMQlUvT2NIVUxBSitCL0tx?=
 =?utf-8?B?QmhubUJSb0h4V1Z2ZTFPMmZSc1g1blVvUm96Vk1JdEJrQVRmM2xvSlUydGZa?=
 =?utf-8?B?VSszc3o3dmg4eC93RnFnc1RxNURrLzRXV0hLUzhiNFQyV0tjM0RVQUhqeU5D?=
 =?utf-8?B?ajA4c25PdnJEeTdNc291Qy9PY0NIZkFUZ2thdExuUnVHVEE5NnhuaHh5a3Fh?=
 =?utf-8?B?c3lxajNkVFphaEJvY2oweTFBUHpzcDRaMFVwTXZYN1dpUkM3TmpiWjVMZXc1?=
 =?utf-8?B?cDFpNHVrTUVFbkVycERkYituSGs5MTRxVmJHS2JTdGNyVDBLVUQwTWt0Y3BI?=
 =?utf-8?B?bHlqTFY2dzVYSERscWs2eXJ5YVNuRkJRbTZ0L2svRkl1V214NW1YclhyRGZV?=
 =?utf-8?B?V3l2a2NKQWEwTE00eFVsR2JWcHVlOC90N3NhUCs3SnpLUkxZdmY0ZVdZNWNB?=
 =?utf-8?B?aFJsaUJnNlpta2h2bGJhV01NOHcxaTVmdEZqVWd1M2Z4Y0ZhSCt3OWlIYVBQ?=
 =?utf-8?B?eFpqeHNaR1duajFKWk5PQ1Jrb2VuczdKN2UxblNLTEFBQ1NYS2h3dEFXQkxC?=
 =?utf-8?B?S2RRNmczY3JYZG5uMENmZFNjM3B2eEhpOW50cVlHdjRHVjUrdjUxZzUzcDlY?=
 =?utf-8?B?bGJiSVo3ZXRuaWpiSE5ySzNtUnVWOEdPSlg4am42WGx2cWI4dkRUK0lLQkNz?=
 =?utf-8?B?MFNnNEMyeXVyMmh4cDVobVVadjFEdThnS2lDVFpxUG5iRlBsNXFyWE9ZbGgr?=
 =?utf-8?B?TlhGelV2aHBJMnJyWklJMmpWRnI4WHo2V0h6MkE1aW14MUIyeG1JVnB6Nm9z?=
 =?utf-8?B?WWF2dWw4bC9xUmNqZlhKM2lvSTJNZkRUTVAwNjFsaWkwYjIvWHlVRHFBOUdG?=
 =?utf-8?B?VDRUbHpQN0UyQVhaNlE3MEtHWU9KUGdZd2Q4c2tYV2lYKzZoclhuL2U5a3cv?=
 =?utf-8?B?SWFiUzg0eXBQdmUzWFd6NWgzVGRTZnBsZ2UxT01lSzFVZHF5M2c5blRoQXhJ?=
 =?utf-8?B?Mm9PV042MFFBaklyTlprcFRrVW50MWpTenNic3YySUIzQXZnWkNwSU1xSk9C?=
 =?utf-8?B?T3djUVlqOWp0Wmp6SWIySytXcFdBV0diU0hIZDVWaDE2ZW1WeStUNlk2bEV4?=
 =?utf-8?B?SVN3eEt4M1dhalNETmNIcFhaamxBbXlZc2hSYXJiaVhRVXZBYXNPV2E4M2Nw?=
 =?utf-8?B?cEo5bXY1SGlxakhRdzVkY3VzM3NuWmJXVEFleERRTHJFelNXTnlhNnBXRGpB?=
 =?utf-8?B?MVZIa2QvNWRBbUlXN1Q2alAyNDZVVnRML3ZEYm1qYVgyeVQ5Vnh1UmhkcjM2?=
 =?utf-8?B?UlpVcC9hOFB5Z2NpeHJ2QVFlMnh6c0lDckRWSzZlbUFZL24xMFNKZ3YwaEJQ?=
 =?utf-8?B?d2FxcC9tOERQcVF2dFFpN25USmN4NGhYNFBnTUxwV2JNN2ZjVFp3L09YazJj?=
 =?utf-8?B?VmVYcjVIbmRZZjJFUEI2S0NwaXNOa3hnd2JjUXY2blErQmdHVDdlTHlmblg2?=
 =?utf-8?Q?ZnU4WsifPgmIUatjl5GzCio/eey0Gg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFpjSFRMRWtMbTMyMm9ZWURtZnlWTjRtT1E3K01TOVhPNkwxY3lsOGh0Sktj?=
 =?utf-8?B?bFNtZVBxNkVUZDQ1dmJWbEhweWI0WGJkWFRBWGtQRkgrbGRFcDNwMkV0cTYy?=
 =?utf-8?B?MG8xVzhqcXhGVWpyMER3b2FzQkpwUjBHUXpCamtzQjAzUlVwSTR2SC8wdFpR?=
 =?utf-8?B?ckt3ZzNaaU5MNDJ0VzQ3WnN2MDVvd0ZiamMzVlhXYzQrR1h2SGZhZHZMNHJB?=
 =?utf-8?B?TzhTbnZwUmwyVUdHSFJSRmJEYzJvQm5Sd2doYzVaQXZLeUs3RUNzdzJZWCtB?=
 =?utf-8?B?SmhjQU1aRFowWGdCK1Rwb1crUUlUVVZuWjZJRDVLVnpDc3h1RmUrMGZyTjU5?=
 =?utf-8?B?d0JEenQyc3VEQ1JONFhEK3ZlcWIzRWZlRjcrNSs1ZDh6SVdiUlZSMGFRUmVM?=
 =?utf-8?B?TWZFYjFzSU85K0RuRVZ4cC9JZ0VkUWxHVGQ1QzVSRHlrVnA1UDU1Y3JEZ2pj?=
 =?utf-8?B?dVcvU0pRQ0dDK0lHN3YrQ0R5eU5tamlrZUI2RW5na3pzNzVyRkZKMlJGRUJ5?=
 =?utf-8?B?TTZjSzBwYnl2ZlRqN2VmNEtHNGpkN0ZWS2htT3NXUUJ3VkhVRVE3THBrYm5m?=
 =?utf-8?B?N1d3TThCVGhXQ2JWRlZSUDNTczVITy9Fd3JDK2dxZ2E4UFNDVVhObTk2YVdT?=
 =?utf-8?B?Sk1hMitFNlpOKzRrWjdCV2pqMlFlczhnaGhuZ21FZHowUVBkcW44K29XMlI0?=
 =?utf-8?B?NVhXYkRXRzhodHJpcERzb2s2ZHF4U3RPTklSTzkxS3JFemh0aHVkVHhPdW50?=
 =?utf-8?B?Tlc5L0RBT25PUjZ5cXZ1c0QwS0VGT2dmNzg5a3FNcm5qWWE1cXFIN2tIb1h4?=
 =?utf-8?B?SWYrbHh5Z2IwRUlKMFdHTGw3RzRKclIxbHRGY3NDcmY0eDNicUd1VWo1YkhL?=
 =?utf-8?B?T1ozUDMyVTZRY1djSm1jVERPcmM2U011SXNLUzFOQ1ZZVEdCQzJKVy8waFU2?=
 =?utf-8?B?dk1VWWwzcUdyanlTL21mc2lHUU5KWFg1V2FrRVNLVndIVDdNREo2M2tBcGVE?=
 =?utf-8?B?SHZkL2w2cUs1Wnp2aEQ1YTJkVWYwWDVQTExPeTRwOHdnVFVxZXl1QW5HaHlm?=
 =?utf-8?B?Z0dnRkRWQy9ScHdVM3ZtcUFOc3RjaDNvTXZMU2xrV1VrVlNqYlFIcHdJYWYw?=
 =?utf-8?B?YjM0aTIvWjg2WXlKWVBMNmZNMzJZS2pZd0tXM1RzdVJHYWVDRXM4cnRSbWRE?=
 =?utf-8?B?azJmdmpkb0NuVlFRQ1JOT3BRalFINDZuRjVwbWo1dlhBcDdzOCt2Smg2UXpU?=
 =?utf-8?B?R3dXY1NMR1dVeFMwbGhzQlJ5WFZDTUJibUpLeWJvbldYTnQ4RGdxVElQeWls?=
 =?utf-8?B?MElhT3dmdXlqTGFtemRuYnhSbVJhZkZoV2U3S0FxdUgrNHVtMWVrazdiSlZG?=
 =?utf-8?B?ZlpUem5ud0p0eTJVN1MvN3JjMWdWWE9kd21IaUZJS01TS2F6NkNLMFRPbS8y?=
 =?utf-8?B?VCttbEhLNU9jckhkbXVVWmRHOThwOUJHdWhjb0JFRE9ZVzZXTU1pRkNoTGF1?=
 =?utf-8?B?SVdHaFh3WnR3QkU1TWlCN1RSdjZXQ2c0TEJ6cm12VlJ6aHpacWM3QkdWVmNN?=
 =?utf-8?B?VGdMQmJqNFBCRkcydDZzZjRwc0VaMklMMTBkM21iTHd5TVd2SmgyTWJJN29w?=
 =?utf-8?B?UTRrckZLZUNNWnFnQWJrNUNOMGVtSU0yN2FRTTlvRlVFRjAyejZ0VUFLNDZ1?=
 =?utf-8?B?aWpGN2hwYVg1TjBQdCtWZ0FleDBuVnQwV3ZwcG05alpwVDVuUXlLa2VRNmlE?=
 =?utf-8?B?V01uVWxhUjg0R0gyRms2UWdzVXFjR2huSzdlNEVmMjlkYjljd0tUaGpsTnAw?=
 =?utf-8?B?RGlpcVNsTStQN3Rla3B6S2VsMkMxR1cwN2p4aXY3NHg4YVlQckdWaElhb0dV?=
 =?utf-8?B?L3VQOTRURlJCenJTQTdVTHBrVTdoN3hBWjBhRTBXL1lZOXU0WHlROVpENCs0?=
 =?utf-8?B?N2Z5dk80aEtxMG1DajEvdkYrVnVseUZycnd0SEgvaENrc0dHZWJaVjJpNjgw?=
 =?utf-8?B?ZUwxV3NXQnJIRWVOcHFpRUszZ2YyUE1JVlhhLzRqQnhheU85YkwyY1RYcHZa?=
 =?utf-8?B?YlFXMGdIUmFWSkJ3WExUTGRqZWRxdXplQVc0Umh4dHJyYzRwRDgrN0k1bVVy?=
 =?utf-8?Q?97PFeglJKCfFOJtux8T/ngVVt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c524ce-78ca-4ef7-8960-08ddf9b4a4ca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:47:21.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShlyCxgIw+M/d/RztaTGLu573/cYKey0lQNoAdkFUSTNY3vk0eaWDn9BOcvjTWBHvyum3TPI2QnLdfo36MgJYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828

PATCH 1: different operations maybe require different max frequency, so
         add flexspi to handle such case, re-config the clock rate when
	 new coming operation require new clock frequency.
Patch 2: add workaround for erratum ERR050272. Since only add 4us dealy
	 in nxp_fspi_dll_calibration(), so do not distinguish different
	 platforms.
Patch 3: add max frequency limitation for different sample clock source
         selection. Datasheet give max 66MHz for mode 0 and 166MHz for 
	 mode 3. And IC suggest to add this limitation on all SoCs for
	 safety and stability.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Haibo Chen (2):
      spi: spi-nxp-fspi: re-config the clock rate when operation require new clock rate
      spi: spi-nxp-fspi: limit the clock rate for different sample clock source selection

Han Xu (1):
      spi: spi-nxp-fspi: add extra delay after dll locked

 drivers/spi/spi-nxp-fspi.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)
---
base-commit: 12c28f647e5eefd08796c7b161acc9c46bd7057a
change-id: 20250922-fspi-fix-14d4e071df7d

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


