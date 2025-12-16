Return-Path: <linux-spi+bounces-11930-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F55ACC0B3D
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 04:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57CE6301B5BE
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 03:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AFD261B71;
	Tue, 16 Dec 2025 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mnDDIbtq"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8241D9A54;
	Tue, 16 Dec 2025 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765855180; cv=fail; b=MXIKTRHa9l1l2T+RXclVtncDVTN0uImieC0gGJ493xP/Ok98ttnRyKfjQNY66felyeJXQj5JjpZqtWOlvjdOXoE1QldXevS28Srvr5uSH5sOSdfGNcBg464WhWeL+zSZa1XOYHBNPWE2wEHrqynKTAXUygwkm3/973Y5jSVTNqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765855180; c=relaxed/simple;
	bh=aA0wFguApB2fGvCfSkKS1IhaC/wDRZFeh2hRA/lYMZI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=nXYpwx4cCbms8pMEww+wGFZEIZVPsUrgfexzPV4DcRbZsHZMthpl/ddl+mFtUOdjnBpoak/5MlLQRPH3cpC/EBIOBxmv3nU3kW86lgf3P1UI68Demt+Sg4cFIsY1XJt9b3cxzUmx6BVRzdcznN6XcYkgQ4r9Bblz83zQexEjrfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mnDDIbtq; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMR+O2VL+mB0AFCtZWNwcTbA8atGmVN2XlodZkaazHDGGMdVJZS/hpK7Xx3PW5U+MOzO9f65MsCKiUlrbEoieEbYbFX17fwR64Pd5z9zW+0Tmv7lpWXf5k1VcbcG08Gmz0yI24vOx67r44b3/JYVuW95NL7XBHHEBVZwmjDB0UOt0PBXXpzHutwTcMwAMbYgbRL7oM1bAUCm3ODyr6LErdDqrGguz7marBGBs0koJHzKwZfmOz2LzR7jHwDiee70Ej54Pbrc+TD5V99Lew3ytJwXtSLqVfDzigBUw86p051qcluIpA2xXPzCugwTNNe+/wE6mYG4GrxCRjtrSMGQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgZQm2fZDZp6KlYgX+7dMUcvwkAG0po4rAbDqkMa7Ko=;
 b=I4LBRY8m0DI8fkbE6OM2BaPgLJa3TMx6vN9TisqtEOb+X5242wjffElRanxSG2U21bWPVMKoBMJ1cNyIiTHFl9/nFqcj2XxOlWM2PxuRPBfbS+yzxf4Scvq9jjmy16LmW/JXL0uo1dIJ4Uf1iuZEfMf9i1iaFVDN5Wh03calNefESC23E4mqvjYYd03N5bcTdmaJiMzxVfwzsQRLFKQJcbjeweXnTJchdDdkgedJlpaGENBqJpXUXWbjGntSJN3Di+EGPDciXswoTqigXKUAic9iY6s7pJVxMBUQ6B3ZPa7YMAqnR+3bFr03kASOWsb7aF3Ew4jTv38q3QqFDT8Vog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgZQm2fZDZp6KlYgX+7dMUcvwkAG0po4rAbDqkMa7Ko=;
 b=mnDDIbtqYs0zEcbRU0Fs80DHYacGjm31A1V5fmxcFWMj72CrzdGR7alIQjl94nASY8qZCo8Cd5juwSMu0YLtVFXTiFKJHCAXYUTMLXcy8265fHCPVuOsjRGHruycWB/fQNiXkyp76XwqRaHE3CL5u04fwMVeLBt4EW+C/wd12TrD8UAZ1Eq3cY9YamLy35d5EdKBpENZlXoZcHS/UbaEWcbJoP4ye4+LEuSvFywpBwn8AIstjvMw/YmU2s8CtafMllSkKcEwAgAy1Xfd4s6tJy3mu2vS7Ihx/5T5fLLEnprZFwx/xXJTuJNtFqCIKuzfdHb3wsT6avI3ivFzrOjdYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV2PR04MB11935.eurprd04.prod.outlook.com (2603:10a6:150:2f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 03:19:34 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 03:19:33 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v7 0/2] Add support for NXP XSPI
Date: Tue, 16 Dec 2025 11:20:12 +0800
Message-Id: <20251216-xspi-v7-0-282525220979@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO3PQGkC/13Pz07EIBAG8FfZcBbDDP9aT76H8UBhcDnYNsWQm
 k3fXbpbI/X4Tfh9w9xYpiVRZi+XG1uopJymsQb7dGH+6sYP4inUzFCgBoEdX/OcuIteOLDUW9G
 x+nReKKb1XvP2XvM15a9p+b63FtinjwIQ6lFQgAsOuhYq6wIp8Tqu87OfPtnOCzYE7EGwEjIaJ
 Mq+l5HORLbk+GaRlZggXQ+D6bz9R1RL+oOoSpzS4OLgfZTyTHRD8PcWvW+JQUhn/GCNORPTEn0
 QUwnigBhICx/cH9m27Qe245nUlQEAAA==
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
 Krzysztof Kozlowski <krzk@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765855251; l=4567;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=aA0wFguApB2fGvCfSkKS1IhaC/wDRZFeh2hRA/lYMZI=;
 b=IJ5R3spweNXZHpIuZ1Mrl6tYUvqAb8ZMSSMOARTZ1mZNpfaWkCsD0zUCNnH5Xj8/t967NMwEU
 EMzqOgWSgk6D3c3wAngC9Svhu+PE3Yh1/9lg4yYvSFuCFryWlqzx4DJ
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
X-MS-Office365-Filtering-Correlation-Id: 0da5dfe2-59e3-49c4-ad0a-08de3c51ef2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RElJSGQrTDVqMWw3Rnk2TnlXejZUWTVnUkdWTVhrcWJQTnlQczZnR3ZJYzNy?=
 =?utf-8?B?MVB0M2dHYjFubFNuYXBvSHlJYWFrWkF6eTB6L2Z2Qk5CUnNmRGFwa0oyM3FD?=
 =?utf-8?B?OTJxOEZjSFJTTTUwcnU0WVIrQkJCSHQ2THNtL3ozMkhjaWVTMk9RcnFJaGMy?=
 =?utf-8?B?OTV0d2JIbWZicS96d0pOK3NJMjRFQkZHd1BVZjdRM1ZUMDRHakJiVnluZXRj?=
 =?utf-8?B?QThFKzQvZDVtb3pjMy94WWdqVWwxMUNQQWZ2Sk1rSlU4ejRWY0pNSE5FcEdH?=
 =?utf-8?B?UGh3WE02ZWZ0Y3hoZ0taOUI5SjEySUFacXRUQ2pwR1IrYTE5U0Qxdm1teDNw?=
 =?utf-8?B?NGdQeHdLZ0NsL2ZldXdXK0E3RE8wcVFjT2NPQUdMR2tJMlgwemhOVyt4eld1?=
 =?utf-8?B?NDNVaDVXeTlxcDdmUjZtdjRxWEY5Uy9SWDNMYWFsN3lqcmNMeXV3ekhuTnZR?=
 =?utf-8?B?ZXcrblcwd2JrcDZMaCtEY3pBQTBjOWFxTlh6bVhjbFlRei9JdDliOWwxaGNr?=
 =?utf-8?B?eC9CaDZuVkdqK1VTSEVkb1lua1ZLQU5hKzhkTmYwaDg2VDduTzhMUVFQM08r?=
 =?utf-8?B?NTFHSHRRdEh5L2I3Z1FXa0pWZnZqdW9pMFBnRHNoekQ2dkJkT3FYeGVnR1Fw?=
 =?utf-8?B?S1R6Zm1EanlQRFc3eFpvaHcyS2M2amtXT0ZYRTVDdFZ6akJvSmhqWEd1ekx2?=
 =?utf-8?B?SWhBQklZY0ZTak5UYU1zOTZuN3d0K1VwbDJoc2l2RFdvWXhGaVVKWHdSU1pD?=
 =?utf-8?B?eUFaeWRGREFVZ0RHcG51Nytpd1BHTUFuUkVla2JMTDIvMkJiYWhYK0dXWEZP?=
 =?utf-8?B?VXBVQXNocnNLSHlpNVNhMDF5Y00zdmlPbzdWbnQ0N0JoS1V6OVdPemJyb2JO?=
 =?utf-8?B?U3E3Yy90Uk1kTDRuU2ZjR0tXclVzcENvc29zcSs5c0R6emFtVjNrMmNaZTIr?=
 =?utf-8?B?TjBFRUEvVE9NNW5QcSs4bGs3RWxydFY5dkZUYWZiWGNidXc5ckdadllKbnFU?=
 =?utf-8?B?MXd4V2hnRGx4MEFORGV1VXA2MVpFTktyWXpWZXc5WTdYM2lmTUVUNWJlb0JJ?=
 =?utf-8?B?b1U3UEplL215OGx2bDFWMGRkdGEwQ2o1eXFYWDA3Mnd6aVJ2bVZhTFF4RUVY?=
 =?utf-8?B?UHhJVzQxK2NIeWR4NnVzL2RmTjU0dEJieHdjdXJlSzRWNk95TzQ3aHpOL29Q?=
 =?utf-8?B?ck5PY1hnbzJ0UGo4NUpwbzVWeUxQSi9jZDQ0amZGUGFmaFgwblB4VVd6cmJx?=
 =?utf-8?B?NVBPYUlrYXVRajRQbGhYZXlieWhmZ2pyMUdCM0Z0dWk2T3IzSmVIV2h1Q3hj?=
 =?utf-8?B?eU1UcE96MDg5QTVUODhBUzdFZFd0c2pKRFlpNlBiVEsycE54bCtqQzFSR0p6?=
 =?utf-8?B?L1JDV2hEdkhOZTl3SUpFL2h3aHJyQkhRMzBTOHRoWXJnQ1NLcGFRMEU4M1VC?=
 =?utf-8?B?TW41TFBBK29WNkN1dGYxakc5ZHUxRHA4azQxUmV4SVBlZU82Mys4Rk9RUW85?=
 =?utf-8?B?dXFaWlA0WkpuY1MwQTVCdVZhWjA1TEU4NHhNNU1jdEtRWng2YXF2dThkaDhp?=
 =?utf-8?B?QUNEejZxc3A4VVE0Zkc0V2tBYjd1Z2MxRlBaQmsrd2lPM2RIWFJMdWFUSE9m?=
 =?utf-8?B?cjltOGNiQkQ1cmhmdTd1UXhZS2UvN2Z4cDFiT0tiRlQrVzdLYnRkYjU1c2dR?=
 =?utf-8?B?ZUs4STR0WGJJUEs4eGNhVHZ2NXAyQ3dwV0NJTzByUEJQY1FLZkZiYlNSVDhV?=
 =?utf-8?B?VFovYTAza0dGYVVOd2Nrb2dMS0FXOUY4UzNoQ2VyZlcxZ2FBbDhxeU1MSmJz?=
 =?utf-8?B?QkdkMnNmQ01FcU00S1huYXBqV2g2aTZucDhXT2UyR0FteEhoamZQZTFhWlJY?=
 =?utf-8?B?clJiQmNaSlUxMll6dEVNbjkvaVJPMTlNckR4L2Y1RTBKS0RXdDFGNDh0bW1G?=
 =?utf-8?B?aUs2ZEtrUkxyU3hBT1M4a1N1WTBIUXc2dTl3eXVrZ3hldWpWWDdPaHh3NWpN?=
 =?utf-8?B?VmRoeCtpTUhDaEtoR0I4R3hTb2pubyticjBEY1VDbm5md2FuU0QxM3dNZXE3?=
 =?utf-8?B?OWova1JFSTdHSHZEd2lkVnJmZFpoSTczS24wUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDdLb2MwaVJSUDJGTkVQcm5ObXd1UW5RMi9kOCtFai81QkZ5VFNNczBCbEt2?=
 =?utf-8?B?NXNhUW03TjhYTnFBNDRVWnF0aUVRYXV6MlBDZUNoWkhWcEtkQ0hQOU1nVzJw?=
 =?utf-8?B?dWRaeGZmSjd3MFhCVmpFd25Dd2xJNDYxN1NYbFh3RThObXhFVWJ3YVZaaE9B?=
 =?utf-8?B?a2hxV3p5d1BUbVJMQU0vN0FGMlBOQWpaMkFSbDNQdHdUbmJUN2NVMGlWTjJr?=
 =?utf-8?B?MzVaeUN6RkRBZmVWcnZCTUlnOTZYT2hKUkYxUjBWM1I3b2xFYjZDdmhOZjh1?=
 =?utf-8?B?aVdYZUk3R3VrcU52R0c5b251amI3MWUvakpsMzlnQ1M0SjFtTDM4b2IyOXdD?=
 =?utf-8?B?WktQYkhmVmRtRXplSzMzU2ZydXRTdmIyRlhZTUtlSEtEWGFvUTFYVnFxeUpX?=
 =?utf-8?B?dzd6ditGYnd3a1ltelF6UFJlcGlTY2VYMlMzUnRIbmFhK3p4d3ptTVZnZTFY?=
 =?utf-8?B?SmdwQmZNL3NFeFV2eGptVWtxeWU0bXFpVFZlYk8zUlpJcHRUUWVuZ3NyTjUx?=
 =?utf-8?B?WWlPYzhQaEU2RGlSanl2bUU2ZzlGUFkwQXFMNU5GS1orZ0w2clNNYXhJakZS?=
 =?utf-8?B?U2xKRmRGam9NeW5iNHJzd2lwY3dTUmhRUXpnMHBWRFMrUmFZdEMvU3NqclJI?=
 =?utf-8?B?cXMxOG96bXBKQmMzNjZDNHpjUjVrOXJUV08vR2lCaTFQTUVzdXpySlVTcWlr?=
 =?utf-8?B?MGV5aWxoWHhjV2tvWkpOMXBsYnp6cm5ZdExjQnZadXVGOVVpTDFud1VYQWh0?=
 =?utf-8?B?RUZ2dnV1Sy9FREMrdWxhYmZaejNoOHZQTU5yNTZWRFBWYXdzU2R4dFJkeFph?=
 =?utf-8?B?RzNPSTd2MTlpZFJkZDQ1WWdvWUNwOXN4MEZjbmxWUWMxRWM3ZUdOcmYvQmJE?=
 =?utf-8?B?RUhMZ0U4Yi9qWDJaTWIrOEUyL2RxUkVpckRRWlNXTUdRdkFabFc3T0V6bTk2?=
 =?utf-8?B?VGUwR011dTRHc2lGWWJYcWlZQ09rWE44cVIwTG5uZHpadm1LdlFTd0MvU201?=
 =?utf-8?B?QVl0WnZVZlBraTRhYkJJYXJtdDB1TlE3cmtCSHd4U2cvSzQxSjlDdWdBbWZ3?=
 =?utf-8?B?d3cyc2RZT1JTZWlyT3VGY3dmOFNORzNVWGk1WlVqMCtsSmZwTWFGS1V2QnBm?=
 =?utf-8?B?RksyckpFYnRUV0FaMTA2U3pObml0VW1UMTAraTNGaEg4bFROZkZDYWNOWThF?=
 =?utf-8?B?Qmx4d1dxcEw5dENyM0QzYWxIZTExaUVTb252V3BxUDYxaDdwam5VdlVjQm1z?=
 =?utf-8?B?bzhVZitlNTFEb1JpVHR6L3hNUERtUzUvTlRjNlcrMzF1Wld6LzlObm5KZzZ5?=
 =?utf-8?B?RWQ4NVd6TGRiVVJZTm1oTUI1a3prSDhKaDk4QU5VNU9Jdzl3SC9qVEVCZTNJ?=
 =?utf-8?B?K2ZDcEREWlUrbzRvcjd6NHR6SFhBWmJ1aXQvVEp0dlpjOTViejRaZnY3MXlu?=
 =?utf-8?B?SGpTZEVQYnFBbHg0bGtmNmh6ODNOclVudk9GRlBCYUhjeVNYcUlSSzFaeGFF?=
 =?utf-8?B?K3Z1VXVIYXJkOGF3Q1lJYmMxeUFGMWJLT2lDNlJuaWRmblIxTWtteDlyS0J1?=
 =?utf-8?B?Y3p2WEpmdHdiM2hiSC80UERidzZmc3NTWjFRYnBUTHZiQVp1eVpRZ2x1Smlu?=
 =?utf-8?B?cVZLMG9XS2VnMWdyOFFQUmt0K0pHVHdsMWVwS0lnNzlPYk5ZMjg2NW55V0Fj?=
 =?utf-8?B?U0t0Yml3MjF3NDc3L0owMlAydEVpTnExcWx4ZVRhaFZSRzVBemt5dkVUVkZC?=
 =?utf-8?B?QUowQUhOU0h3YjZaaHBtL1d5bGN3cVNKYzJEdEp2RjNjVjZnRXplc0plYWx5?=
 =?utf-8?B?T2ROUWx6RlUvMXNkeGZWbVZTTHl1SnJhb3Q2TWxObkNCdEpQNnZoTmk1dGVW?=
 =?utf-8?B?RS9nZWdHTnd4OFBRRnNnTTZtdU14NWdKSmlSczA5aUFhc05RNkg2K0hTLzhV?=
 =?utf-8?B?VEtpU2VsWitqWUZIQ3cyTzMrSmp4RDkwbnpnY3htM213eEJ0MnZLaHNseWpq?=
 =?utf-8?B?aEJYb3JnelJ1aCtVS2RhOTdFS2M1ZXlBMklPOWQ5Y0oyd0hMOFdZVUpIOVJ6?=
 =?utf-8?B?UVdNY0VjZElVcEpQelFTWU5UdjV6eXI1eXBvb3pINk0zKzF3dHQ1TmU2QS9N?=
 =?utf-8?Q?2PnAD8/Nc9WuoQDUbTiFQViz3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da5dfe2-59e3-49c4-ad0a-08de3c51ef2e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 03:19:33.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eMm6s/Lhb7T/TV5ylaTbRhLBkbAVNoRePj8P3j4vu1AFDxVodtWt6YoAT7qHmmeXb4tmj+4c6NyFELUmmSi2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11935

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
Changes in v7:
- PATCH1: adjust subject lines reflecting the style for the spi subsystem
- PATCH2: no changes, just wait this commit ef8057b07c72 ("PM: runtime:
          Wrapper macros for ACQUIRE()/ACQUIRE_ERR()"), so that current
	  driver which use the new macros PM_RUNTIME_ACQUIRE can compile
	  without error.
- Link to v6: https://lore.kernel.org/r/20251125-xspi-v6-0-22b22de50cda@nxp.com

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
      spi: dt-bindings: nxp,imx94-xspi: Document imx94 xspi
      spi: add driver for NXP XSPI controller

 .../devicetree/bindings/spi/nxp,imx94-xspi.yaml    |   88 ++
 MAINTAINERS                                        |    9 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-nxp-xspi.c                         | 1385 ++++++++++++++++++++
 5 files changed, 1493 insertions(+)
---
base-commit: 563c8dd425b59e44470e28519107b1efc99f4c7b
change-id: 20251028-xspi-afc0a17e9708

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


