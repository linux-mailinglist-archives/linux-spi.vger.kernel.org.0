Return-Path: <linux-spi+bounces-10063-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D05B7CFA6
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAA7582ABA
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32506301709;
	Wed, 17 Sep 2025 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aHXIj+ap"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C2B30170E;
	Wed, 17 Sep 2025 07:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094068; cv=fail; b=RbU+JzhVF4z6diybZ9xErzFr8s+eSunLi2Ap7QfZcY741AHw4WyfiotzQL3jvNosubKpB7shR+Tt5F0G663xo8L3RxS0iUGXYs/lazsjbNk5CACne/CsN14tiry7cesJROzfTw05RG525XQb/e+J3gxXimZdHzgK2K0SzA25rDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094068; c=relaxed/simple;
	bh=gQ8kR5CMjyOcapID3MS4MBVmknJCWHyPM8Vvf+wk2ao=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jHrG1mgkMJFm0e46XIohjpJG9+tXRnQwIQbYwbwY2SBkdx23r0dBIj/rTbyUVrun8hMfVzJGsNWxiDDWJTUuah84lf8oIKvg7jfzwUhfjQjAMDOCEnza/L6jM8U2/ywHbppTnk82UbGsXvkgww9fy5wOedEWf1S1UO3qH4i9Rc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aHXIj+ap; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYablo1Z8TDnlRmH/hBHUZWN5qmg2pvXy9MxZD+JO6xj6QsWon3HgZMmShzJ80SlhMVWmBHCfpu0FFrCkwam4Cm0IkCuEg8QUq8LITEdkYjgz0jY8jOCXrf394BjS9vExzrKzrgLMH7emdmpf7UCKz5SkX8+Ug+ObSxSC+gxGCcj2g0hESy/gMEURlsSv30OIYgXanQbGoKVp161ofV1HLK77TKci6xRFd0sbXU+PRkfFr3C1z/x2EXPLH2WnQHMkQXquUeHVh7Bhgl5jzXo8ytcY97sVI69NIrw6GxoJUaIEGPR6MzQySSqcxiAZVTOw3ga0Qrj0ltxhk7J0dlm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3gT+ReM4/doVpbAYVVfIgN8eyQjOsIZteo1Xl5+5LQ=;
 b=JhiMVj4zlmRaJTTwNwJ6ee3tZW/BJYWL4xORlaJADceZViedBZzcB0EJsSe/IEk0P4Xi/hlH0IpjSF78t4kJlUxBgsE3EfseuL8I4oTyGOeKqQL40mSxVl0XohlfA/cJmpLfpRqHghe7A8BLBiL7m4DS6yi6ekTzvP1gpVK5NfjzndpS0z1G23K82mvwCh/PcQwm4Nr4Z2/vmKrS2TrVr/2HhfHHDMxHgNXiTrKmhYidmnCd4qgkS9fhO574fqLYw0Wsl4cS6EBvZ9x7hdMo7du3qJ2qeHawlidkFAD6uVZV5ElA76tpoRCURR0A8WZc5jTxYiWhLKGOCyE11PxDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3gT+ReM4/doVpbAYVVfIgN8eyQjOsIZteo1Xl5+5LQ=;
 b=aHXIj+apG3Rg79+Yy5SFp7LwVyzjI2TI4yG//biojuJGV5RmtUgfL6/cmlocITwbCL8/HxTieyimQXaJeDP/LW1WX0rQkkZgdnybMV02GItKlgZVkP2fxUyrPdVj/+pz4MwjmFeegRjh6KBz1FKhs/yGL1qgCHk0MtAaW+HOALI/+utHDmyLorhfx06tKlpYItSVbuXQPFe4XpusH/T8NB1Deomk+vWw+RtmFaIDkjbkqLEgs4L+K15T2Tu7U9sjKFl6xAFEOW5yVRYAmkoj3Ku7ZwcPVxFSruLGv7f07z2s7BOj4Tw3vPVwdKGkHXN3rBdu+gWUKbMddtf9up+HdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10800.eurprd04.prod.outlook.com (2603:10a6:150:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 07:27:44 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 07:27:44 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 17 Sep 2025 15:27:08 +0800
Subject: [PATCH v2 3/5] spi: spi-nxp-fspi: Add the DDR LUT command support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-flexspi-ddr-v2-3-bb9fe2a01889@nxp.com>
References: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
In-Reply-To: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <frank.li@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758094070; l=2269;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=gQ8kR5CMjyOcapID3MS4MBVmknJCWHyPM8Vvf+wk2ao=;
 b=AdV3x7ICxHkMdEeqxKbcPDmBkwoxxqwIDA0hEjzxWkaqV8kaHEHrzYrQIgctcavCk2ziiDB7E
 6G3mGv60XtUDKwbDmAHPOa8LWPYwUiM5ltpxkOzCadhACACRluIQf/S
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10800:EE_
X-MS-Office365-Filtering-Correlation-Id: 57974d45-023c-422b-d4f9-08ddf5bbb176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDNaMFlyb3oydGRKcUJTNk83YnphaWxZdFVPSWhoT1p4WlNqQkNBU2c3NTB3?=
 =?utf-8?B?RnF2RStpQUdZL0ZzdCs4UmRBMktBU2FHTHJCV3BWNC95UEFHSHlaWHVZNVEy?=
 =?utf-8?B?ZGplZWVKOC9wT0c5bmRSYmV5TnZnK0Jzb0JJMHN5ZFVOWVZnMjBRc1hZMlg1?=
 =?utf-8?B?cjMraHVjZW1UZXNRcjdUeFdNOHpVWVNnUWdrM2FzT0tRMmVhMG8yZFBYME1R?=
 =?utf-8?B?Nk1UQ2wrUFdlOS9MVCtGTXpWbFllSkgrK09zT1Y3UGJkQ3hqQWhCOTdyQmlp?=
 =?utf-8?B?ZHNPdVZITlgxVUpkbWhaRjZvVGd0dlJBVHNOTFBjVzRZOG9XbmhGNU50bGdm?=
 =?utf-8?B?VXl6L21rbG83aktZak50S1I2Zk9HSDdzWExKdHc0SXkzWHpSWjRoTXBncURN?=
 =?utf-8?B?a0VOYTJrb2JyMVUvK3Z1WEtJWXVMNWtZWi9HNTY4c1psOGZNMFJGaC8yM09j?=
 =?utf-8?B?dGFJbmdYcUw3cW1yWGoxVFJBcE0xd0xCV3BVMXlQNXh4MTRHZG1IWExlTjBy?=
 =?utf-8?B?M2FldkxHZkcveUlFT3duRk5PckFxUjRHbVRJVnFWV2xsOVp4MzdwaHJGZkY0?=
 =?utf-8?B?ZmhWVkw2WHJRYjYzVFZvWFVGZ0dGc1ZEYWphT1dNdTFsVFJaTDZOOFlqR3V0?=
 =?utf-8?B?eDFhVElJZ294b3o5MndPcGZaOUJRbm94Y3YxK3pyTUNGcDdicHNNZzBKejJl?=
 =?utf-8?B?WGtjY2lwV1NydnVLNlBpcW82a1RZWm1PUU1sOVIwSEVjUFZ1Y0VVbm5ZWUVq?=
 =?utf-8?B?UVJsT3I4bE8yTXFnWHJjM0hKdkRMcThGYnhDWXZZRUxYTGc3blA0b2hhbWx2?=
 =?utf-8?B?QkYvQnB3WENiU250Sm1kRDhhL3RCanVLTzFzQ01BMGRMdHBFUEJubjlKUFNP?=
 =?utf-8?B?ZzhtVjN0VVQwQ0dXWU9SM2xqUlJueHo5RGJFSTc3cWVlbFhXUVpkVytOUGk2?=
 =?utf-8?B?QUdUWUdBUTFxbHRUNXVEVmswYTRRb2RvY2FQRTlkUWk5WEUrdUNJUzRWaFlX?=
 =?utf-8?B?eWJLNkdUVUhTVW4wV3RKamkyaXpHeVRudlhqVzgzR0V5T2dxMnNXbEFuMjAv?=
 =?utf-8?B?eUZtYWVjemhFK1FEZUdJWVZiV0d2VzY4UG5weFBXQVdpajRBSXYzSlVIcXll?=
 =?utf-8?B?TWpFZDJFYU5vOXVEaTBMbG5aaisrWkNZaGtPbHo5YXhzR3FIODQycGhmU0JX?=
 =?utf-8?B?UUlkVDByWVYrSG9PZEtaNUxTVVMxdlRPYWhyd0wrQitMKzcydkRkVlJJRVdH?=
 =?utf-8?B?bVp1MVFYWWFyZTVQTURua251Q1poM1Z5SlEzZlNkWGI1dUVGbm8xL1NaVTdn?=
 =?utf-8?B?K2piYWNDK0RGc0d4YktVd3A5emFJV0lQYU5laWxONXNIVE1lMGlORkt0T3Q2?=
 =?utf-8?B?bVgxWFpyTmU4dG5EWDFNVmtiaU5ySkF1Z2tSUGl5UXNkU0hkUVRHQzZQQWwz?=
 =?utf-8?B?aW9FeW9ESFJITXY1bFVWa0w3VDNpZFVuV3JjSWVTWTlydHJJa1l2OUVMMzRF?=
 =?utf-8?B?SGpQTytPcXE5SFdBbFNOUnA1eHJMbEh0YXJKdWJublFxRDFkQktrUjJKcWU0?=
 =?utf-8?B?Mjc4NGJTOEp3VnNKeGpLbmUzTTJUeUJscEhVS3pleVFTcHQwM0h1K2tEMEsv?=
 =?utf-8?B?NkhwcWdGb0pEdCtxSUFlcGdQQ2lmQksxaGhBR2g5UlcvQ1hYVXNjSEdRUnNh?=
 =?utf-8?B?ZGhkYjR3eEkzYXpHSXFXZzY3WjY3MFBRU3BrZ0ZWaG1EdHpLaXhvcWZPVVlj?=
 =?utf-8?B?ZFVBdWYraDdrdXVkZFQyRWdicGpTbHFMOUo4TU93K2RCT1AxRXJWUVBMbEYz?=
 =?utf-8?B?ZFA1dHV0Y0hMTllnUFk2UWh3RU5yU1Ixc2ZoUjBsL0dJQUszRTVSOEZoWmlE?=
 =?utf-8?B?SlFWZXFpaFpUY2NIb0pMWVRadHBSamxQcDBJMVNpSFhMRDRDaGhOZFNqZHFG?=
 =?utf-8?B?VnBhZCtER3hPWTFCUTNIQi91eks2UndFQ2o3ai9xd0RvRVp0OGZpcG9aVjBk?=
 =?utf-8?B?TnU3YmV0bFV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3N4WThrbktDby9wdUdPTkhlTUVSL0EwbXkwM1UyU3d1eEhNSmlXTnYzVHg2?=
 =?utf-8?B?a3lrVTBFL0ZKMmxubWpPdnJhZ3AvOGxVbDlRcDI0eTg5SEFzR05LTlVIMkJQ?=
 =?utf-8?B?ZVh3Q1NlWjNFTW5wRlR6aktBa0xYUDlYOGUyTXV6c0dwRU1jOTRtVldwUHI4?=
 =?utf-8?B?MTVmR3ZDTWx6bmtUbGpFSEQyTkMyYXF1TXN3K2duUlFKckV2NzRIajRFQ1M0?=
 =?utf-8?B?L0pseG9uL1gzdUNqMHlTRXBIcTBVMHlWNTdmZzRaMzIvRFF3MVFOOHNMWmdy?=
 =?utf-8?B?WGNocXM2a04zOFdYUHJSbXZiTjJBVmt4aHFvYnZ0bk9hVlVOMnF4MkJ0Ykh2?=
 =?utf-8?B?T2NwMWdZVWJmaEd4QVY0bTJUZkJ0OElJd3BxcURRbVAvTlJuSlNpL3lNM2VT?=
 =?utf-8?B?cTc0L3ZqeFJYckJ4ZDFMNkVTcFA4bUNsNk9NSmswckxsZlg1UW5wTVdKbWZJ?=
 =?utf-8?B?dlREWFB4Q3ZsZDVOK1VYQVVpOC9SWHd2dXRvcHRnVGVkSncydDVRdlI0U0Z5?=
 =?utf-8?B?SG16b1B5NjRaNUdxOUpSdWRET29aZktCaHFmU1J3Mzg4Q1puOU5tYWQrbkIy?=
 =?utf-8?B?dXYyYm42eTdiT1ErbjAwR210emVmcDc2clFRTlhhSWxiME9od3hNdEJleVNB?=
 =?utf-8?B?bGhXcmRpcE14NHhtTE5tc2ppY1lCR2RMR2tFKzRrRGdCcFNWbytacVFEcVRZ?=
 =?utf-8?B?Uk9wbjBVUkVKNkNDN3JaRDV3RXhKRlhaQ0hzSjJ3bHJQMFNzNWtvcFdRaWN1?=
 =?utf-8?B?ZU14YXBrOW1kU3hUaTdPSW5Ma0hZSmczR2xQR2cyZEx1OHpUWXlGTW1jYVla?=
 =?utf-8?B?TVlESmtzU0RpeGtHTjVmQjFJQTJaREVoQ3lDVG5zTkpLT3hjd3lDY0pvUzFj?=
 =?utf-8?B?QWpFSlFIZnRndU1XYU03ditNNUFYOE45S0hEUWZEaFFlQmZtZ2sxQ3cwOVZ3?=
 =?utf-8?B?ZHpCZUVFTEZVOUd3ZzBrSzJvVjcvYitmQ3dKVGthUGtqcHlKV0hrSW9oRVUw?=
 =?utf-8?B?ZUFRRGk1aVpWV2RqekJNRW9IRVAvQXpwSDVQWEl2NXFrZzRHVTlvZnR4eGdy?=
 =?utf-8?B?c3dnRUtVc0VHcjhjN3kzVVFHYnJaUFI0WmF6QkN4SE1Ob3gyK1NXeVRsME5t?=
 =?utf-8?B?N1FlWGpzZzB4ZHNEdDF0ejN6eERTbWJOWmhJUzd6ckN3VDJ2KzZXMGUwanph?=
 =?utf-8?B?ekNhdFpjSFJrcmU1bWxNNzBzakdRdEdYcFA1ZWMra3hDaFNqakh1RkovbWFq?=
 =?utf-8?B?NzI4dWJnaTRXZW1ycmVkSzlTc1FJTlh1RmVPYVlCM1dhb0x3b1JQYjlSYzZ1?=
 =?utf-8?B?czRlS3NlQlZZNEpGNVJ2MTlsak85ZS9hQ3ZvMm10QWRRRUwyZitDVE1mOE1M?=
 =?utf-8?B?WENnZS9Ja2YyTUtMTkdxM1F6RE5abDZmMHVlaVhqS203K1FCcDl1VnRGS2U4?=
 =?utf-8?B?QTNzUk1ieE5mbWxjdmNob0czR0hWdjhtMzBpQmZiNGZqOUUxY1hHNGh6eHV3?=
 =?utf-8?B?RG9YRHA1TkcyWVRlY01vMzhuVExpODc2RnZjLzdRM05QU3V5T0kwOEFJd3Nj?=
 =?utf-8?B?d25hcDh3NllrR3BLd05GYTJpTnRoMlBULzN0QzNJRmV2YUpTRDIzZURJZldy?=
 =?utf-8?B?ckZxV0NndUkvZGt5RnlhRlZFbGtwS1U1OXYyWEVocVhQT1BxN2tqTll5VVBG?=
 =?utf-8?B?WUdjRGJBbmxGWHpFTUJ2MEFvL0xnZVdTSmtIL2w3czdHZnZaaEpWSCs1SlV1?=
 =?utf-8?B?WUpPM3VvT2oxV2pIWUdhUktmTlJUYXFPL09PaDhROTU1bDZtWHVzMzdkUHV2?=
 =?utf-8?B?Z3V2czk2NEJMR3o5c3JqTjJOdkZPbFhBZzdFVmRiWmZ3RkcrL0llaGZLUSty?=
 =?utf-8?B?STVYODZNTFV2K1U0V2t6UVhITWQyVXNRdFB0bjM1QlRvOEtMeC92QVlqT0cx?=
 =?utf-8?B?dGdYSEZLVTlWSGZqMXorOUNDMStTQVFER2NtS2JYQXkzcDJocGpPYXlzdkNn?=
 =?utf-8?B?RnIxVCtmTkVLam5LdnF1VWFLZzJzZWlUMHJma3I0ZGhCTVhCb0pmYnU3dlJm?=
 =?utf-8?B?QWliMUVLd3hPd0VxNG1zcTJ6NmFJMFNEcFNXc1NqNHdwcVVDdXVvM2RwT0tM?=
 =?utf-8?Q?Pt0e9K1Vn8AeHiFpNUQBm5kMq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57974d45-023c-422b-d4f9-08ddf5bbb176
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:27:44.3434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oonL3IOscLlc2O3bnezLTut393OAN2T3YXe79lM1mmPKpjBj6NLYTTk1EAfLdtlfWqYAsg6ZX/Tw+/QfTi/6Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10800

For DTR mode, flexspi need to use DDR LUT command, flexspi will switch
to DDR mode when detect the DDR LUT command.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index a1c9ad03379682dc1fc2908fbd83e1ae8e91588f..bd61f951d6befdb78cdd84d4531aab378a47c56f 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -559,12 +559,21 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	u32 target_lut_reg;
 
 	/* cmd */
-	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
-			     op->cmd.opcode);
+	if (op->cmd.dtr) {
+		lutval[0] |= LUT_DEF(0, LUT_CMD_DDR, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode >> 8);
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_CMD_DDR,
+					      LUT_PAD(op->cmd.buswidth),
+					      op->cmd.opcode & 0xFF);
+		lutidx++;
+	} else {
+		lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode);
+	}
 
 	/* addr bytes */
 	if (op->addr.nbytes) {
-		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_ADDR,
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->addr.dtr ? LUT_ADDR_DDR : LUT_ADDR,
 					      LUT_PAD(op->addr.buswidth),
 					      op->addr.nbytes * 8);
 		lutidx++;
@@ -572,7 +581,7 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 
 	/* dummy bytes, if needed */
 	if (op->dummy.nbytes) {
-		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->dummy.dtr ? LUT_DUMMY_DDR : LUT_DUMMY,
 		/*
 		 * Due to FlexSPI controller limitation number of PAD for dummy
 		 * buswidth needs to be programmed as equal to data buswidth.
@@ -587,7 +596,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	if (op->data.nbytes) {
 		lutval[lutidx / 2] |= LUT_DEF(lutidx,
 					      op->data.dir == SPI_MEM_DATA_IN ?
-					      LUT_NXP_READ : LUT_NXP_WRITE,
+					      (op->data.dtr ? LUT_READ_DDR : LUT_NXP_READ) :
+					      (op->data.dtr ? LUT_WRITE_DDR : LUT_NXP_WRITE),
 					      LUT_PAD(op->data.buswidth),
 					      0);
 		lutidx++;

-- 
2.34.1


