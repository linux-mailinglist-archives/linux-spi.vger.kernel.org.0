Return-Path: <linux-spi+bounces-10037-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5A4B58FAD
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 09:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B629520586
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 07:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47B92820DB;
	Tue, 16 Sep 2025 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kXHEnlnZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA7281357;
	Tue, 16 Sep 2025 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009427; cv=fail; b=rcFK4+lca0HSRqz5aRqFewLwpWrIqgdtmXvGvv2R7WkA/W/R2sU5CV7JT5Q5FXdMARG4Jw8vA3OCegmyzWfULjQQlwQ7RfqTMT7Wl5/UCbTmGX8hfV9ugLomwdlV9drWUNJbkmG6iQckBLI/M6PJLVUHIKGvNzQ0e/xXXdKOZvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009427; c=relaxed/simple;
	bh=ucI+0GyXwy3fXCg0PpNApr2FMUmSlVfJEceCnlT2d8Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WI9Kibh6slBfFupQ9B5m3v6skGv3etw7M+omEKeMeOpBLrMHMW085tvNGQRsHeZkQif5+3sd0ulnxPGZGomC39QiyfJve+hNGFh7RLeRkFL2K+egG+meLuQcE1LXP6P/qPcq3wY+HL+wngvAFCg43p3NrwPP/v0OHnqPklxGIB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kXHEnlnZ; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4+lKehf+ry2pe0WlVx97HeojdVHTStO5RwJEyE51XQMy3r7ERxMsxfZUvo4Qachv7qswxr+SKBub2200XSXhYt6vK1YijEjCFqUCFYJyxZRZ/iJXBPAx7rnyRTbWpTrI2gtzh9CSxBx6BQKmW/IhQR78sfA0LkQpeYcglE/LPsWwoKMwplUgqevNa3JMFpavsEWTx+uFNdQlwMH4TqENAOc30l7BWGg6+2309PqSzKmZZaNccEdl2qQ9D/JoJDs0zWGarW1GWnHn2xK/f2ThxhDeAkwc6zi0QhESa0937ZSKjn6qmF92N5U2l22xS9ZOpJ8vNs2S+bqDAn6gaoPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6/LZUf9BPBhEhkt7fQUBTg9tFyM8Z+VLnC+S3elE8g=;
 b=lk4KH4WmcAHAp+lbpj5lXd/GFowhd/xDAqTeZjlhzuK6JZXBOZwnjKkDxm2rMwLRwgf9y99Ic6zVyUSJWjlGmuou6C2h5X5nYvWGNoj8SWMmdGTOie0kB7NPLCIxKvlCjviKoJrExQT5Dq8QMMFpNgv6eVlls5cKF3w4UwH0YoTj0CTPZT2IZs/evejvRXN21GIW7fi0PTHnM+hdMNfmbtqavZRGsxxPDval3cSfwO23s8eFqLSPl7cDFmgeYePQO4tc5CNZeb6LVGG5I8WLoNN/jC19xfdT20+e11iCowEnQLz6Rp7Eo3J2iBz1HEf5VodrYoPZDw1tq73d611Q7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6/LZUf9BPBhEhkt7fQUBTg9tFyM8Z+VLnC+S3elE8g=;
 b=kXHEnlnZ8VGRv5CQYT8gnxdFQEYgpezLgP3VjEu0fhn/V5xjPhoXHCqvODIorvoxomuHISjaP+batl1pKxNbQL1Mo4DUF7BV3n9uKHEim2FK60C5BjeEDRpoAnuapdWWJcaOgd8lxuZQ6aOSNejj4bDTY8L5X5FmImHD+Ln5gwC/XHHa1TmMghi5W5oN3cp6XoLN11Mh0iCefBGF46YT4pbQaVE20rTn/H/KMhZlhi5WZfpkEnZogXOuMF90Fvf40Q1KRV2bE9jC4maIgYqinyvthX7keBJdcx3Q+OE1SqJIJMp0afqs4kzy0fDRqQZ4qSHpp7iIDpbj5mH5fO2ykw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 07:57:01 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 07:57:01 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 16 Sep 2025 15:56:40 +0800
Subject: [PATCH 1/5] spi: spi-nxp-fspi: extract function
 nxp_fspi_dll_override()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-flexspi-ddr-v1-1-69358b5dc862@nxp.com>
References: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
In-Reply-To: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758009434; l=2145;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=ucI+0GyXwy3fXCg0PpNApr2FMUmSlVfJEceCnlT2d8Y=;
 b=YT78UwkRaJBauD0VvXGXExKfzQnU23J3SFXNF2ftkhAG1YRAArAo2ePFN/L+bFw70TQjDzpCc
 vxU2f98bFuCBUp8fR/ohLX/ywhk6yiPIO0huKZ3JC8taFYDF1LfwxrS
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AM7PR04MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: ceec7f1b-c7b7-43d0-6c3a-08ddf4f69e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVF4aFNCOU9RWStDckNNeEdjL2kzVkpCRmVHcE45R0hjUmIzRzNjbnpBV285?=
 =?utf-8?B?VXAxYVNEMmozL3BVK0tjVHA0czY3bjkwTnMwVnJsMGRhVjdheW90MHhVR2lv?=
 =?utf-8?B?QkpGd2xyVmNjWXJHTkJwUENyRzFGZFcwN2dvc3RDTk9tUUExUWg0TGRqcURD?=
 =?utf-8?B?TVd5dkZUNnl6clEwUUR6THc0OE9LVW51a3lyY0lScDFYK1NhYVJDclJITGxn?=
 =?utf-8?B?WitYVmdmNWNPclptTnpndGVIa21UT1dodC9Td3hYTEc2V3NYNFYrWk5MN1pM?=
 =?utf-8?B?ZVMzVFNucGJMWE5rV3liNlF2dnE5NW15Sm1nSXlGN09JYjlralB0TytQNHdY?=
 =?utf-8?B?ZW1mTXJGaGxSQkF0OW8zMDFpZm9HMis1NWlrVHMwd2FpM2VMRGduWXBqcGpG?=
 =?utf-8?B?QmpoSEo4RmlaZWxnSTdRU2wveDRXLzhsSUY1OXlkOXVsaTNnTGdTREhidzdF?=
 =?utf-8?B?RG1UZHI3MjRzL1V2aHpnR0JLZmplbFdDZE1HVzEwVTQ2MDVrR2dId1RmWlRP?=
 =?utf-8?B?WnJOMklDVHJWUEltak1MdTZmck45QjgwM3MvVWFCQjV0NXV6TFY3VXF5dTRw?=
 =?utf-8?B?bFN6ekpnK1MwLzZxT01pa3M2RDF2bHBaYUcraUlvWFlqbTIxR3JyaGJiekcw?=
 =?utf-8?B?cjN4bG4rZEpxNml2U0czZ1VaS0ZpcGxwa3lSYzNVZUpsQjhaSXpBRTlxSE9P?=
 =?utf-8?B?eVI3ZllaZGtjMmpReUNKMkhlVHRRTnpuSmRuZEJ6K2FuejMwOVZJbGNRVEg1?=
 =?utf-8?B?cWdyaVZRTjZVSFQ5R3hBYk1UUHJaaGNrcnROWWFnVmtMck5xWGpkQ3QwQ0di?=
 =?utf-8?B?Y3Jtd3pteW5kMUJnVVVJbnhiVEZkandNSUN0ZldVaEJ2NitvNkJQSXVBSndB?=
 =?utf-8?B?dkx0QjUybUJiQUE3dlE4S1k1QWQ2cUJEV1d6Z0dYWnFySHlXVEFxUFFKUlZz?=
 =?utf-8?B?bXcvQ1NaR2ZPeGpFWDJKeUk2dEl5TFhqaDdSbFEwQUtESGhiNStsZmI4RU1P?=
 =?utf-8?B?YVl0V2N0ZldVamdNTWdIVTViSTlTMkxRcUFEbTZnSDY4T1U3dno5eU82Tzl1?=
 =?utf-8?B?dytYNkVmdHNUd00yRWExTHJCMUNwMzk5YmRreDhmQ3RLMURFbU4yOWdlbHhW?=
 =?utf-8?B?dFE2cnVuQXUyRW90Qit4ZEFOUy9qeThwZCtnazZsRFBMZzBoV2E2OTdXbk9T?=
 =?utf-8?B?aUJwWVA4bU05Z1oybVZVZkVsOTNldzI0bzFkajRuZmIwU2YycG9oem5uY1dH?=
 =?utf-8?B?VXp4cCs4cUdzS3dibW1kb0hPUng1QlB3MDlpUWlpek9HMHhzcUhYajZxenc5?=
 =?utf-8?B?blhhNE9TZ0ZBeDloZ3NzYWpJSFM4MHlUQmtVTm1ZRlFwajBxZTdHL3FFTW9x?=
 =?utf-8?B?ZEpVcjV1VnZKR2dBbE1hQlg3OXRkaVdxR2hqWE1Sb3ZFM3Jac1l1MWUwVjNF?=
 =?utf-8?B?MFFhZE5YejZvbmtFaFpNWFN0OXREelVtYmtjcmxZcEJ0dElDYjhCbGFCbHRU?=
 =?utf-8?B?Sm1wdks2eUxnS0NITUhDOFFwUUdlMEhEZ011N2Fvam9uTkZsTGhhczVJNHVW?=
 =?utf-8?B?N2g2WHVmbUlOWWdXQjNDYWZTTGcyWDVVSE8yTUMxQkwwMTUyelU3SFg4SkY3?=
 =?utf-8?B?VU0zeHhtc3NKWmNsc004ODBFNVhJMVZwNy9FMEcwMG8vUG9ZcXVnT0lmRmU5?=
 =?utf-8?B?cTQrUEZWRkpkZ3A1ZE5VWDhyNkZ3a0FqMk1YVnlxVUs4cW9CcWZyRUU4WUFQ?=
 =?utf-8?B?T1BqQlFUSm5abEdiVE1icjJXQ3hVT1RTSEUxNEN6Y3M5YmMyd0tPcW10ZHJw?=
 =?utf-8?B?RjR2eVpOTXhOY0RNUStDcEh4NkNPM1Z4UE5CczUrUU5wczFmZUg3dWM0bmR1?=
 =?utf-8?B?Uk5hMFE1NmRkdmVrNlB3Nzh2enpXMUE5Q1lXK2I1L1FDZ08vZVhqbWtUZS9k?=
 =?utf-8?B?bStxR1NINmFyb0tzdDVBZ2hQWlZTWE9uQzI1UW1qaVRCVjlnQ3BKYkNKMzhK?=
 =?utf-8?B?Ujl0d3haOUJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGV3K0pPcmU3SUFkZ3l5cENXU2k1RzJPZUhMOGVjcHBPdFVWaExUNDVJWVZk?=
 =?utf-8?B?eU5lSWhMWnZpVmJLOFoxdklRN1dvUDQ5bGJwTTZ4Z0s1eElFYitrLzArUWlo?=
 =?utf-8?B?REdHcU80bFpXSWl4Mjgwd2pROTltL2s5dFV1VE8vSENiZ0pLS0pHQUoxcEc4?=
 =?utf-8?B?dEc0RjR2VVhJMlYway9UUlJrMXhXV0NFUnZ5T3FtTkZIQ0Yyd2tVTmM5T3Bq?=
 =?utf-8?B?Y2hKWVNUVlF6MHZMS3FtR011M0U0dzRXM2l5Y010Q3VzMU9YaUo3bnY5czhM?=
 =?utf-8?B?ZlNLby83cGxmajFMa1FtUGJXQWw1UWVrM21wZ0hoTzBjYU9CQVV4eVZFOHdZ?=
 =?utf-8?B?bSt2dWd2dzdpb3RVN3pyWnNLalVaSlBIQXlobWVhZkFkT3Z5ZkFVVXZSMFVO?=
 =?utf-8?B?bFNBQUszWllQV3RLUTNPS1JCaGFEOEQrcmJiTXc1NENqVms2dW1lZmJEdjJW?=
 =?utf-8?B?ZjdScFduUXhmYkhYbmE3VFczbVJtZ2lQeEhHdysrSmkzSXM2dzAyT2xCNEg1?=
 =?utf-8?B?RUlsVWxtdkt4bU94UFBhUGF5bG44U2lVR0xjb1g5WkxxY0lBUEJpRDJ1aXJv?=
 =?utf-8?B?ZW5JOWRsclpuWmZHUnZpZkIxNjdrdzBiZURPdU9Qcms5SDRyQTloZTVDNlpQ?=
 =?utf-8?B?Uk1hd2wyanBETHprL2x4T244bExFanIyQVlGdnA5dTNEc3FZTG85anBPeVpj?=
 =?utf-8?B?ZkhCc2NiVnhlTzd0VDVjaWs0Zi9kTzVrRnRVQTk0QnFOM3BvT0hMYkEzTkxx?=
 =?utf-8?B?amVQTi9VM3ZVT1BiUFh4U1g3bndPTFY2QWN1Wi9vMTZaZ1h3Nm54WUFYV2Zj?=
 =?utf-8?B?Y3lRNHVMMU93UW92UzJianNGYjNmSG5jWlJNd0oybTlqNmUrMzA5YkdabCtD?=
 =?utf-8?B?ay9Dd2hJQUtKYlU2T1ZBK0M2bkFKTGNQc01wUmZFbFp5NFNtRGUvei95bDlZ?=
 =?utf-8?B?MFp4Mnhra1NLMWR1dWxjMW1OenYwTDdEbmc3eVRCRDU0azF0UDQvbDIzemJC?=
 =?utf-8?B?YktWTk1jYTh3L3pIV0hhK1pUZENzbnl1SkxWNndrcmI2cjQ2QnlNamlpbFhW?=
 =?utf-8?B?VXFMRWg4ajRaREErRGd3SkVtUkhxYXdpYkh2dkpSTVRwdkNhcWRyV2dsZDZN?=
 =?utf-8?B?c0J5SDVGcExndG50R0dTUlZtaExjd0k3WUluZFdocGdtYjFQdDVjMVhJYjBS?=
 =?utf-8?B?Y1NhRGJvdFo0Q1lwTGZJalY1RzJZNWxSU3BjTitQVW1IZ0NibCtaNVBna1A3?=
 =?utf-8?B?REFGeitCUm13MndjVDdkKy91NXEzU3dmNDJ2WW1RNndEVnd1RnNjZGoxYWRQ?=
 =?utf-8?B?YXlxNmQwNkdDWWpEaXY0TVEwK01GMnJWMkEyOEpWQXNYVHc4THlPaUJWbFVC?=
 =?utf-8?B?cXhLeFVSSTd1dTZOU0U2Z1J0RHB0ZWtydWlBaE5mYWUwVmY2MHJKcnIrK09O?=
 =?utf-8?B?N0tJdmVJcUtJYzZ2V0NWdGpRUkFqZUFSZURZR2owWU5WZXc0cnZpZGJ4RFRn?=
 =?utf-8?B?Z21LVDRsOEcvMDdTOTRzMVkvVkZqQUZQb2ZYcWdwakRUZ1NpdEJjcXA5dUFV?=
 =?utf-8?B?QkVTbGcxdW5MVmdMVTk1VFBLYVRibFVKRm1wTmN6bittVkRVcGVwVUdKQnph?=
 =?utf-8?B?WWxVUjQxeXhkNmlqNkF0VGIyMFlYTlFrYmRVUnpyblRpNnNWYTljWUhIOTZC?=
 =?utf-8?B?SjhWOWt1SGROSXcrUm5uWEx1OTJFY3RkNmltNHJ4dHR5ZW9WelhTZ1NocUNz?=
 =?utf-8?B?VEJ0blJ3Uk5SQzVNRmtEamVGNXNrOHMwdUp0QUJpM01uTE5wMCtucHlYUEtv?=
 =?utf-8?B?YnROdEtUS0hNTDZqbENMbjV6RmcyTXg3YUwwdkY4c0xDOHB4cmsybzVZdGxs?=
 =?utf-8?B?Tm1LVTQ0MEtLUlM4aElwWmRGVGVzNkR1eTNxdlJyc0tRUHU2V0R6VmF1b0VM?=
 =?utf-8?B?KzBRdDJLUUlRZFJBdzNtaUIrK0l2dzBHK2VITGo5UE5sOGhaVFZqWi9yaFJ5?=
 =?utf-8?B?QmFJZ0hZWHlKaG5PSjU4TzQ3WTVBeHZtM0dFVmJvQmpadDRyYk5jWC94M2Fq?=
 =?utf-8?B?UjRnK2lzV3lTOHlXVk4veEZRSHhLcjlTOGJaR1RYN3JOL3lBS0UxZU40VHRM?=
 =?utf-8?Q?GqsbcQK1RZ494f+RuLcjcHhQp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceec7f1b-c7b7-43d0-6c3a-08ddf4f69e7d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:57:01.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SB8FwXYjfLdNel1Liy3P5CZggPjO2nYT4tWEU60lLGK3Nd7bWYbSgCP7LMUN37whoP7wGMcCc2sC4rInx4VaTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

Extract function nxp_fspi_dll_override(), this is the suggested setting
when clock rate < 100MHz. Just the preparation of supportting DTR mode.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 848fa9319e36d65e8152931324b8e34eb162f5d3..a1c9ad03379682dc1fc2908fbd83e1ae8e91588f 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -674,6 +674,17 @@ static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
 		dev_warn(f->dev, "DLL lock failed, please fix it!\n");
 }
 
+/*
+ * Config the DLL register to default value, enable the target clock delay
+ * line delay cell override mode, and use 1 fixed delay cell in DLL delay
+ * chain, this is the suggested setting when clock rate < 100MHz.
+ */
+static void nxp_fspi_dll_override(struct nxp_fspi *f)
+{
+	fspi_writel(f, FSPI_DLLACR_OVRDEN, f->iobase + FSPI_DLLACR);
+	fspi_writel(f, FSPI_DLLBCR_OVRDEN, f->iobase + FSPI_DLLBCR);
+}
+
 /*
  * In FlexSPI controller, flash access is based on value of FSPI_FLSHXXCR0
  * register and start base address of the target device.
@@ -756,6 +767,8 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	 */
 	if (rate > 100000000)
 		nxp_fspi_dll_calibration(f);
+	else
+		nxp_fspi_dll_override(f);
 
 	f->selected = spi_get_chipselect(spi, 0);
 }
@@ -1071,13 +1084,7 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	/* Disable the module */
 	fspi_writel(f, FSPI_MCR0_MDIS, base + FSPI_MCR0);
 
-	/*
-	 * Config the DLL register to default value, enable the target clock delay
-	 * line delay cell override mode, and use 1 fixed delay cell in DLL delay
-	 * chain, this is the suggested setting when clock rate < 100MHz.
-	 */
-	fspi_writel(f, FSPI_DLLACR_OVRDEN, base + FSPI_DLLACR);
-	fspi_writel(f, FSPI_DLLBCR_OVRDEN, base + FSPI_DLLBCR);
+	nxp_fspi_dll_override(f);
 
 	/* enable module */
 	fspi_writel(f, FSPI_MCR0_AHB_TIMEOUT(0xFF) |

-- 
2.34.1


