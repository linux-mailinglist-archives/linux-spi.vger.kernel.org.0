Return-Path: <linux-spi+bounces-11473-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE74C7F9C1
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6F9E4E5150
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82856263C8A;
	Mon, 24 Nov 2025 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QXZ7CYp1"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C12F4A12;
	Mon, 24 Nov 2025 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763976288; cv=fail; b=cq/QEHfWFHb3sgTvXEeFX7Fl450UfmGfc8irM3++R4HQuyliQ/E0aWJCv4nokJc8e0d+lljmVaNm0ITOiw7v4ijIzrM/t9j1z9H2saR6T9DKz9Ti5F3+UeZApG8XcElkOmym3jO4uz0LomXu8ookafrtbN2GlzKNHhInbsfKGIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763976288; c=relaxed/simple;
	bh=TFB4O8/nHoN68t7d/w8vHSqUlDAdeu2Ezn4N7PUr3mE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=EngX3n0f6Pw++UQHlfirptDP1JuVMyUgwzk2DP7OPiAny7XDfwnOVDNw+DYZ7dd9ffm/XoVTlaMZdzPDwBDWQKRcjUv/+0s+OlmJ7UzNjppDUGoGNOBax6oc5MnZ7G6HleBjhJh9g0BQlFNqrBrv1/5DW4KLkWJaPwi8s3s6k8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QXZ7CYp1; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2jQ7VtQbNj6zbHvzAQ1NSk5i+X59eMb1dS1GWKj41DaC0kifzlt5GI5neckS4tjadDzz8Gnn5ECtsdXH+iAS5u6lrt7M5GI3Tc6xOwoCYnaBxgTwh99uxcsL9jFKqC6rP7BWATo+Bh0npmdySrhz1xzPEvDYkisgYrBDznQMy8WPZDQ7gr3pxkryK3r1ZG/8dTN5F2AVSGkwGpAX4ekvzuCS1QQ6LVmR+A54G6KON9Bn8DjGXayKx1jV/fhAytltX0nzL9OPgx04GhIx1PH0ogw/aT3A6nqW8/oM5cRwdWIV5kUg7YFTtPwDl4HRCpGk7s+1V4849poKbw7OmdSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WCCtlSCj40I2V5mvfAb+0r2UHqfG8QhqxHO9aO6TI8=;
 b=LSI3TM/lE4mLSyWsS8OlYam38HvPB8Qbn/Guhc6EJwCAaQJjmneT+TPO2BC3gnp5s4mxTJThsG4SbNy77CeKbLQXLliWt/Wg9pV+sGiypVWcRVSr1Xq146JQINre2FsJoyCZu9kiKvb/K8myN42DADBjLt3kn7VB1kKDryi3/KFk09usMNMysM1aFTnpCDeZA3E2AGbrCsDRPhf/vdCICRv5Mt0Gm65bZe8Po+LJL6Px9riznqRnxii6CbphWh2AU4K+AiRyvA/LyMReTOgiIRJmdy/07eOFFuI40ZEZDwP5k/ySJn7GMmwT00Q6u8FcTU4xHLWFqvAaHzSt/k0KHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WCCtlSCj40I2V5mvfAb+0r2UHqfG8QhqxHO9aO6TI8=;
 b=QXZ7CYp1jLvyz2Fv9I9noChoYh/btmVoVFwUhKEaVF3j7vZJFnEE5VvLJ9Usf4mCRBLU7QQjdLqtJ8LJgjfJuDgI/UA6rkgpx4dOJaV+KJYr+P6Lh9arpzJE9EmoTGUfTaHu52Yee4y+Gwy1v652aATV0s6pPMd3Q8154bIMzEN3Da6eDKiK/qgVPddDH0vqDQKEnrw7LSuTw1d7ZiH5bJmeIjX13pw+ZkY2YqfAH5h0U3r1kfLSZDXrPEjWbPxzVsqjFoIZTbA/Nb27PoBoKfOb17FtbrO6MPBtbk5SQAEO62nb1dpHEcG/Zv7OXKG5XB9T+FPYmcca2iN0iLH1AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10697.eurprd04.prod.outlook.com (2603:10a6:102:482::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 09:24:42 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 09:24:42 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v5 0/2] Add support for NXP XSPI
Date: Mon, 24 Nov 2025 17:25:20 +0800
Message-Id: <20251124-xspi-v5-0-6fd03a6cb766@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIAkJGkC/13OTQ7CIBCG4asY1mIYfkpx5T2MC0oHZWHbgCE1T
 e8u1SZWl9+E5w0TSRgDJnLcTSRiDin0XRlqvyPuZrsr0tCWTTjjChiv6ZiGQK13zIJGo1lNytM
 hog/jO3O+lH0L6dHH57uaYbl+AsDkJ5CBMgqqBKW2LUp26sbh4Po7WXjmGwJ6JbwQrBQILowRH
 n+J2JL1m1kUUrXCGmiq2uk/IrfErEQWYqUC6xvnvBBfMs/zC7N4zicvAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763976342; l=3947;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=TFB4O8/nHoN68t7d/w8vHSqUlDAdeu2Ezn4N7PUr3mE=;
 b=BSTybqUaP5GyftM368kpWUrPi1tUbNBWXOo8aCuOr9B+DQE3Cg6UP+PT7c59JbfaIovufykdd
 3FTD0Lng01sBFInCBEEYHz6YvsdVGn18/o+OpdnspiD3mit9VAADt37
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5P287CA0252.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::8) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA1PR04MB10697:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f291f4-59af-49a5-fba8-08de2b3b4c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a082ekhrUHN3V0dERUwvUFFOeExJNGxDWGJRV3FkaWlZRVNIUTE2L2ZwZFRF?=
 =?utf-8?B?V25ubXpLRUpDT0lXUytuUmtsNWZQWXkzL1lKUlU5aFhIQmRha3JkbEZOdE1j?=
 =?utf-8?B?b2RnR05JNkdKTlhUcmZyS1h2dlRFdXQ1a2FLcm1veHVrdGcwWkErRlpBb0JK?=
 =?utf-8?B?dTI4M1hQdDBMOHl1Q1M3VjJLNm5jaGlTK3NINGpIREZFczNmUWQzYUVZSkVl?=
 =?utf-8?B?TWR6Zm9xNUZXWW96NkNIYUhzWStNZHpzRWFqTVA0ZG1rRVg1SFFjMFZUNjRs?=
 =?utf-8?B?VEt0bEp5SGhtQyt0empXYmhDN3BrWjVDN3hyWjVaR3UrMnBaNk4xWmlGYjhX?=
 =?utf-8?B?RkZjL3pVZXhlT1lOREx5ZkxxWlNlZ1Fjc0hkVW1VU0dPV1gyNktzYXAwNVg4?=
 =?utf-8?B?UXRiUWRjOTU3UnRBZkhIZEkxb0tmK2IybFhKa0N2aWE3MG9xaTJlR0V6VTZ2?=
 =?utf-8?B?NGw3WTJiSzZUay9XT21jeVdrZkRMZTk5SDF0eTZwTk9SaTR6d1BobVU3RktX?=
 =?utf-8?B?ZklnUS9rNlNDOXIwbUJaRFJsNFhZNXFSMVhSY3BPSlhzeXBXOUJkK3RTYzRL?=
 =?utf-8?B?dEhIRmxtcEJiaTlBdUN4ZEsyemV4a1czRGY4VWVncmFBN0w2emtiRjNRQ0RO?=
 =?utf-8?B?ejMxSFFDTVI1VlBDSm1WYWFPMXhzYmduV1Fxc0YyRnpNa1BJT3UrbXcrUWN5?=
 =?utf-8?B?b1N2eXFCSjlvREE1UkNJeTlYUFF4Q1JKbkJJQWpWYlZEbElwWWJjRDQvKy9y?=
 =?utf-8?B?NENLa2FWMGlFMmN0dTk2cmFzVzdqeUpISW9tRVY2aFIxK3B6UUFHOWhhU2w5?=
 =?utf-8?B?R2k2MHBlODRySHRRQ2pPSWI1OGNyVEJMc09TRitmT2daSEppbWJFR0hjUVgy?=
 =?utf-8?B?aXJ3OUVRdUR1ZU9GV3FnNGJ4eU9aR3daSWVtejF2a1FFRlVGU1F2TWxXSGk1?=
 =?utf-8?B?dzg3QW1oRnYraGN5NFBLYzBuU1dZdld3V1duQWtiVkcrWnp2c3dtdTBPRWhk?=
 =?utf-8?B?dzNqNG5USXhVMXJra1hDWmd2SXBlTmtjTitUb0tGVWsvUURuam1PcUNqcUxx?=
 =?utf-8?B?NkwvMlhsaytydU4vbTh1WFB0NUI0UWllRmQzamc4cXhrZ2JwZjl0V2dmV0Iv?=
 =?utf-8?B?LzVtK0Y0aERxT1hIL3ZHTlZPZ0pnN082dENzeVhTRVExKzd6R1VQODhneUN4?=
 =?utf-8?B?c3pWQjZ0dzdQSWhGSXJiNDM4N2tyd3NobWZhR2d4R0VoT1p0eTJCbUJuOG1P?=
 =?utf-8?B?ZDVLVEtlNEpqeGFHTkVSd1B2Q1JaU1pFcjFDQWg2blFOLzZFcXg3a1RXOVBR?=
 =?utf-8?B?bVZVMGVua21lV1g3a0xsL2JSUk5hL0Z3MFZBQUtzQWhCeENXR0wzQkh0SXFD?=
 =?utf-8?B?L2JjT0YrSkRjWTQ4bTEyM3VkczZWbVlKRVRjMGtPZVZaTEtxbmRpdWFmMkph?=
 =?utf-8?B?aVFOOGtLdEZEbW1XbDlvUHgzU0NNTkVZNGpEYlJRQUM4WVNkb3FTQWNqYS90?=
 =?utf-8?B?Y3NQVERkak9wRERFc3haaWprMTI2aDhoRzZSMktlNmhHd05kaWVmR2xLMTlF?=
 =?utf-8?B?VDc5YjdKNC92ejF5bTh5OXNkUUxtbCs3WDdLQkxYNDQwMXV2dGgyc0tVT1c0?=
 =?utf-8?B?M253ZU1HNldSYnFLZUZsK09rbGZvSUdENkNhRmsvOFBJRVVqT2laMmZvMnVN?=
 =?utf-8?B?WHFOQmlJTCtxbmN1aGphTHFyTnBYbDZLQ1IrVnJ6T1R3K0JTZ2c4ejk5R3JG?=
 =?utf-8?B?bHMrNEphUVJPVC9MNkZjZjUzakpObEpuZnllekdxR093RVJ5T2RicmwyN1py?=
 =?utf-8?B?bzByRjRjT2lHVlIyYWg4Uk5sTTNlRWNhMUJmRUp0blBlUGk4TEdjZ2tDVFVG?=
 =?utf-8?B?Z2JjY0ppSzRYbWcxME13eEhZdXZFaVZEQ1FFMW9aVHF0TWpvOC85SEx1bmgx?=
 =?utf-8?B?cXo0NVVhUUltUklheHI5WTFYYVY3VDZrWGdwbml1YmY3Z3FrbU9lV2hvcVJm?=
 =?utf-8?B?UDRneVcvN2M2MHI5YW9UK2ZHampXZGhrUkh6Sll1alJhWWxNSW12MlVnZTV2?=
 =?utf-8?B?RWpiOEJUTU1aY3NvbGtrbG94enpFWUoxWWU3dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0JpTGozK0NEczQ3anhFdFVNZnFpTWhGWDZqSit2ZE16dUpicGN5RlplMk1v?=
 =?utf-8?B?MmNXOWZyZ1ljUlpWQVEzVkZOOXNRaXhsMUp0OW5kdVNDTlJKdk9uQUpzMWJk?=
 =?utf-8?B?cnNicmVmcm0zbjVDSkE1ZlVGY3JMK3ZibXFiVkNyMXhySGxaTlp6L0pKNDky?=
 =?utf-8?B?VnFDOW9IZjMvV1FoUEE5VXJGSzRLbmZZZGhYU0Evd3RhUUtzZGpQb1hEUVRl?=
 =?utf-8?B?RU1na3ByOUNVU0V2bldTQ0RZOEh3SCtoU0k2ZDZ5LzB3dUxqVWtrSi93NjBW?=
 =?utf-8?B?SUhyeWVNNWRDbUxQMVMyTWRxRytEdFVGbEQvMXZVTGNGSFVKUWFTNXJUSVp1?=
 =?utf-8?B?bWpucWlYWk9rVzlBeW5HbSt3WEo0SThpYWVhN3lIWEhsTzRscnVCYzlNRldv?=
 =?utf-8?B?K21SNFpmdmpFL2hZVVlxaGFzalZJUkM2QVpWbHBQMkV2Zm5CeTNBbUJMMDdT?=
 =?utf-8?B?WjJpS2RKdTR1M1daOUttMmQzVk4rSnZkSmltVHl2Z0Z1UlphSlYxT1JMQTNG?=
 =?utf-8?B?aW9NZlozSEVJTWJpbWJUc3FKL2R3TEVIM0h5dURJNWd6OFlGNHVvVkhxckF4?=
 =?utf-8?B?RXgreUxtdWMxZjJ0ZmZucVFIZTNpdnlQUUFkYnRlZTI4Y1NYMUxQRjZTNUg2?=
 =?utf-8?B?QUNNanM1VTc0SXJxVWRiVW90T1lSZ0tOQk82Qk1iUktlblY2K2lRTmZMdTAz?=
 =?utf-8?B?Z0g5Y0drQmd5dCtubk4xaUJtMjdQSWx5S29UMzE0c1NZZVpqWnJJTWJpR3Ny?=
 =?utf-8?B?TXFjeldCYmdGeUV2UkhtUmZCUFd0dE0xaENMSUZaakl5ZGM3LzF3NjdpdlFX?=
 =?utf-8?B?TnpTeXhhWXZiVURGWEFwVzd0TXNkdkhtanVTMHJSWGhCQ1pwdkJNUkRuN2Nv?=
 =?utf-8?B?d1JtNWxRZ2hkaGRQc3krNk5raTV1WDdjZGtmVkxoUHpYYlNHTWdacFhGTWQ3?=
 =?utf-8?B?QklNSE4yS0t5dlFzSVlIWDM2dkxtVExOSUVzQm1CQVp6YU5lTmtaTHppNkhh?=
 =?utf-8?B?RDRxNElKbEl6dTE0NURJSzR1QThxbmVYZmFsWm9BMUF4SkhmTGpCUFJIeXpr?=
 =?utf-8?B?Y1l1d1Y1dWhXUEpKekpFRHErK1JSVmF1Z3VObEltY3B1SHJEVEFVNnhYQ3VI?=
 =?utf-8?B?ekxHRmFYOTFodHYyY2dKNklQMEZSSi9VSnFXRVg0SkhGYnNvMTY4T05Dd3Fi?=
 =?utf-8?B?TzFkQ21ETmdWMlU5c0NEVXI2TENVaCtqQnMySVU0TFBLUDVPOWkwVjFqcldB?=
 =?utf-8?B?dGlYM2ZoMDNFQ1JqbjRtMjU4eGcxb3E5QXZwMEx2bzN4UVZkejdPNDFBN2wy?=
 =?utf-8?B?Zi9TNHhGeGRnVGlvUXpWTmJ3eUFEOHA0MDdOWkhhNlNISkF0TjlSYmpYUjYr?=
 =?utf-8?B?RlRpOVdUb00ySVRqQmM2cm40VVZ1ejVoYkkxSG84VW1ROVZXa0VSV1hNdWxM?=
 =?utf-8?B?c2xOR3dnR0tJd0pOblRJSXJYOVl0dnVEU3BSUE9ENHorTGsxd2ZQWjg3ZEJU?=
 =?utf-8?B?b0J2dTNzYmJ2c0w1ZDQvYlFNRUxLTTBkSEkzd01SaG5QQ0wrY0N2QWJMUXB2?=
 =?utf-8?B?WDBTckU3YXZVU2ZOTWhSMTJwS3ExZENsVEdMTU1mbFZHSC9FQzFvSDdZTHIv?=
 =?utf-8?B?UlNqZlV2akJUbUphT282WVdLZnNGeHpOL081UEdtbWxrV2VkMXJjYWdsNGQ0?=
 =?utf-8?B?RzhFak1KYzJtYTNoVjcyS2FkNFJ0MllyRU1KZ0Q4QjlOaTlRZ3QzdnhtTXVH?=
 =?utf-8?B?VHZWY3pTYWpTajhKc1dTN01EVDdQdXd0OVVFTDl4dGtMRTdnN3ZZa1J3Ymt2?=
 =?utf-8?B?QmNER2JsYm42djRzL3BEQ3Y5QUxPUzNwMTFON3hEOTlSZkIyTWhXa29YQ2tV?=
 =?utf-8?B?MzJ2MnBmQUMyQjl0ZVRmM2JocEpST3IxN0JEamQvNHBGNEx4cEhSR1ltZmda?=
 =?utf-8?B?c0IwL0NucGV5M3lYUGN0V2ZoQ0ZoQTQ3U2hvcStmZVhFd25qNWZyQXYzRVpv?=
 =?utf-8?B?a0JYOXBTYjFmcFoySGFmd2lQY2pxNi9lS0tZT0Zqc3lKQUY2Y0I1R0NUQW0y?=
 =?utf-8?B?QXNqektDOFY5cERXTnkvMFdjWkxtQm9VazlsNUVwazZ5TkViZnpiazBiOTJv?=
 =?utf-8?Q?9fik67uAlaQ9wp1eFxhOcZ/Dz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f291f4-59af-49a5-fba8-08de2b3b4c6e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 09:24:42.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEbm4fxtzHiBNQNTq+cLHCFuOYi8CXZNklBXzRvYwJ0xUfQyhqsiv7ShfF7n6Cz4LMxmIXJpBMfLd2r6zO9H1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10697

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
 drivers/spi/spi-nxp-xspi.c                         | 1357 ++++++++++++++++++++
 5 files changed, 1465 insertions(+)
---
base-commit: d724c6f85e80a23ed46b7ebc6e38b527c09d64f5
change-id: 20251028-xspi-afc0a17e9708

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


