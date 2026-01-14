Return-Path: <linux-spi+bounces-12358-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ECCD1CBC4
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 07:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48AE4305FFC0
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 06:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D7A37417B;
	Wed, 14 Jan 2026 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eH71g5Vz"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9810236E47C;
	Wed, 14 Jan 2026 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373481; cv=fail; b=Tv4FrN3TtDMg6k1heiC88JdOo3yp3BwgQOqpw/rNax47LOTJdw8IMhPmUyHTlunsTDht7+R/WuDvYPoJJrllFmDnuHrFRnVuKd/x2TxlKxtY6CuoI+wDYWkL68qVuNChZF5HGeiUaZOMog/bDGs+TTI8T+jESfiMajPGhmBrdjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373481; c=relaxed/simple;
	bh=4rKpY6jUelm00TA1gGvLi9jliY4aso4/wJ4R3IgSS60=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Wu0sEMGFEOAhQp89MHs28PGU5DzNL8uh699DkRdu+7/kNWomq13YMY3h3os5jymiuydRHuLcIqddJBMzZgJGKcnApSMw18/3FxBIeQ8GwzXUqK0d0/Ff0aXnQxIWKJmLVC1wIoMRy4olMJobWnw+NsqtX2tyemnbmVlVwUXvhh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eH71g5Vz; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUyJOYAXd93fNnhX/M3guRX6mS+biUoQ830VFEMyKlERA6UuQg/W8w/MqXi7kFH2Z5OLbv1HQr6fdV3e1ExNUdLHJuHNQTFtugq371R/zXUDFpy7EmZyhuFMIeFTVcVFhX1Kr0NRYLnffYsrS5P++GxCskm3mn/zT3UXBU6qHiyILO+z865DNHH413j8vd0ja9CJSbOY8YLjllvUyiRMVuKY8eZiuUtls8JNoJcaMDdm8KBqVgrbfiepGH69itBn8hikMioyh1UL51o5K9LI12Fid/n7LfPSnu4P1vUHXGbsjvQZVDa4LGGKjphxPG9esIgbYUrZkHxdxkiHgPkovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+8+FS27iMWkYLcApdXkmEDbZRTF8+gCh5qz6tevu0U=;
 b=uMzM4ni5w/+2A728D1xP36Bmq95Qnr4GeBOY9ryYl8LaFNOpje/ZBR4gdOpVR9adqINNpuj9Sv5Bln7aD/2ZVQJoeJ6bV3ToBunaHVdGas+v6o/QPhfWNPakwSQ6iaHgEwuL+zF0P0HRDk2HM5vvi9jfviOqK3KUmgt4hX822ZaCi+qT5d1jXDDJSSpBG34seExZ7HSxBRpBRe6fb1m/aDdiJqgUy9PG9fivR2vwDY8EMDlbc3PlaxY/mgPmbc7pYM09h69tYnYW1SH7qKigJWotUkYpottnU6pDY7Jv0yb2gU5yqO89W6a0TARjUaHx19WVz6sUpER4ZLEpMH7YRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+8+FS27iMWkYLcApdXkmEDbZRTF8+gCh5qz6tevu0U=;
 b=eH71g5Vz7RTnC1ug6+CLgpbyKWNYxSPfQH5IhjfGK7BEOzN/lygNPGq/dEeUFy2zm5wjPgInGn3zM4emrwJuaEx3IMCo+Ml36nQ/h4rsJ0cmBc8da4JI0sYO9fbq0RASvUglx/0t79jvocK2s4Eg97t8i7+F//zpgTcyEopW0b3bCbr0E81iatSnVtoTmxwc2f7irG8VOkt0OIv5KWZyWIVrBSnxKNtYBsC/YUxRBNrtf4tF80JLnJK9DUWDJ7+gApCGeQK0FgTDGkIjY6Az2QZaIVwI8WtsQ/zupZTPxJFhYIqO3BtX8aJ5ym9fNHhrfwqvZMOOPCmEKxXVcspZkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 06:50:28 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 06:50:28 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 14 Jan 2026 14:49:47 +0800
Subject: [PATCH 3/3] arm64: dts: imx952-evk: add MT35XU01G spi nor flash
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-xspi-imx952-v1-3-acc60a5a2a9d@nxp.com>
References: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
In-Reply-To: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768373406; l=2197;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=4rKpY6jUelm00TA1gGvLi9jliY4aso4/wJ4R3IgSS60=;
 b=JgZ/Jw0w/SpxA80qLOD1QGBbrmoPWZa0hZ5ETpn8qw2zgBAZlu7O3Nzvyvd6IsJKD//5EBv4m
 WFZ8XdTv1k9DknowOHjcCJa5XLP1+/YbsyOci2cOlUSIC0mbE3rSxDI
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS8PR04MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7260ad-8ba6-4e8e-5cca-08de5339341d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1VJbjhkdjF1eVdCWkh5WndjM1paK3BqenVMMzVHYXBQaGRVN0wrdlREWkll?=
 =?utf-8?B?Ym5MdHBEN3ZSczBDNnFXbkxHRDVXUGw5Y3Y0dDZuMkhUblBIbEhUejROcVor?=
 =?utf-8?B?d2NXQW1aQzBSK3h0ZGJnajVuMjVBS2N4TXN5V2Nad09BSExUb2syNVNjZXVI?=
 =?utf-8?B?azVYM2wwN3pZY1RtRHN6NTF0Y2hzdHVYcTFDL0FnT3k3Tk84UWZ4MHJuUkQ2?=
 =?utf-8?B?bm9SSkxYR05ueTNmUytJSE92VHlLQkxKT2VlZ01xTjZmd1RwdWhaaEZ1M2JH?=
 =?utf-8?B?UGRpZW91TFN2OE1xT3RYRkNwWG1tTENXbkY3R2p6SFFaa0J0VHJmWGs5YjQw?=
 =?utf-8?B?THFDa25iaXphd1ozM0RxT2QzR3VaNjBVSHJOTHY1RVVDV2dzWFh5d0JhQUJ3?=
 =?utf-8?B?ZllMKzdpRlZqNnE3TDY5VkN2MDA1cWIrMlEzQ0FMWlFzSjBjSWsyTlZsQlkr?=
 =?utf-8?B?N3NkUy9qdVZRS1NDQ0JlM0RhbS9HZThYenRPM0FUckdlVW1ZU24xeGFKWmkx?=
 =?utf-8?B?K2o1N2RoRWtDREQ4N3N5SWpTUkJDNnBva3k3eXVNNEhRTkxDZERFNW9KSDB4?=
 =?utf-8?B?VDlXTUhtbU4xNXFwNjUwSmR0R283em5xSjY3Rk5IT29TWGU5aUs1ZldFc0dS?=
 =?utf-8?B?UE1qQUhDNURzQUhRVEUwSkF0NVBQK2QwRWdkY1VCSzk0T2U1OE83OU1ocmhJ?=
 =?utf-8?B?Rk5ycUh3Sy9qYytWNU9VN3VYQUQ2TkYzMldIOWtKUWY4Y09nRnN4eFJmcVhi?=
 =?utf-8?B?aVBCWENFUFp1aUFKbm0zbHJYUjBMSGRxQ1VUekFlRjV3dTlYWERpMzZxWDNs?=
 =?utf-8?B?WDFES0dFWFJ3QmVJLzhUM0RLdVA1UG5QYmhRVGtRalBiSGdyNXpPZmxPQnVl?=
 =?utf-8?B?SWw3STZSK1hISTNIYjUxSGY3NzN2Q1pCUndCSEptZ2J5OG9GTmVYWnVEc01a?=
 =?utf-8?B?S0FJUXFhZjJSbWcveVg4MWN2dlppQVcrNnVBM090Q2tPOW12SzQwck9GUldG?=
 =?utf-8?B?VGpiSjU5cU1TNFg5Uzl5aDNMbWJzUUJxeHBBMWk2NWxQSjB6K0lNMUVXT3FX?=
 =?utf-8?B?U1hFME9scmhBbjFCOUFSTk1MQ1g3dW1Mbi9DdEZRWTFKdGRRVXlEY1E1V2RC?=
 =?utf-8?B?VDYzVGpaS3ZxaElSMURzRm1rN09YR201NWUzRFltcjAyaHVMWmwrQjREK05z?=
 =?utf-8?B?NElPd0xocUpZR0dyUS9YeFR2TWptYWljcktzNHN2TnhpMittYnJCSGp3dlEy?=
 =?utf-8?B?OVRLOHhaald6QUxqREI1cXVYV0tPZ3hCc040MmVKSjY5STVlT2JHWGc1RTVp?=
 =?utf-8?B?bUYzaEdYTmc4aFFOakZ0M05zL01aVEdjdlpUdnNWS3RBVVVjVm02MXUyaHkw?=
 =?utf-8?B?KzZPU1FwcU5zRmFEYVZpS1VRUk4rZVVLRGRUQXlSc3dmaWxicFJkY2I5MHV0?=
 =?utf-8?B?T0pnaUV3S1U0bW5GUU9yenJHQlgxdWRvaC8xaUFDRGhkWmJmSFEyQkJpWHdG?=
 =?utf-8?B?d2pNVEdaY0NjOXFPSzBFZlBGVU9Vd0g1TWF1V21TdnVRTFVwQzcrMHVVZmh0?=
 =?utf-8?B?QnY1ejVuYlVNM1FpblhicXZBK1R3eXlEV1VmVFpaeWdLL0szYjNiM0ZGMyt3?=
 =?utf-8?B?c282am9Pd05UZ3JoUWlKTlQ2VUswenlISkV3cEtTUmI4cmxSNDJGeUdMRm5N?=
 =?utf-8?B?ZnNOcGE1bEtQeW12NGVac1FnU1k3bkRYMG5za1lqVXZIZWNlMm1zczJMS1lj?=
 =?utf-8?B?NWxzcUR0RGsrekN3em5oZGxSaVV6Zk5kdG5kM2MvamVlRjN4NHhtL3VJckYz?=
 =?utf-8?B?NWJSNnFaSVZMOHJ3MFNmNUo1WHRxKzNYdWVVVWNab0NDRHRMQm9wNk5Id1M4?=
 =?utf-8?B?elpUQ2hDazlmekEwZ25OUFJEdTJnS1ZQeUE0Y0FzclAzRVJKcThSd2Jja3Ay?=
 =?utf-8?B?NldHMlhueFdIZ3pWMStLTEVDTmIyMVVjN0o2UTVKZGU2RnovaWRiMExBUUZC?=
 =?utf-8?B?dGErbmFaNUhWOVZEaTVSVnlIV2Z6dTBHWmk2alkySHByR1ZsdW11TFhEVi9I?=
 =?utf-8?Q?Pd2hkO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFVLWS9STWg1ZDdodDhvTy9NNGFURDRtRVA4NUI1b1lsNkhKcG92Vzc5N2pn?=
 =?utf-8?B?aHNobTBUeXhURlZrZ0I3eSt0MEJkTEN3VUU5S3lIZk1QeklrNXpXdVRiUGpi?=
 =?utf-8?B?NGJVekZQMjNTN2VQYmd6T1hIMG82b1czMzZEVTd0cFM0RHBQSmpFN2Zpa25I?=
 =?utf-8?B?d29KS2VwandnVkZieHZZNGMwNVB6NmdoajN5eVREeW5uQXBSd3VBanRCOHJB?=
 =?utf-8?B?cU15ZXRORnB5UUdlUXh1cm5MSlYxYlZwd0hzMG5mMitSWjFZUms2MVFzbmVW?=
 =?utf-8?B?Yy9oVU1kaDhDUWszM0VYcjBBUHovSkgrSUJQakpVQlIzbjYyNUZpWnpmN1Zo?=
 =?utf-8?B?dG9BcHowQ1cwS1N4RjYwM0dtWGtoUjNXdjN3Vzc1OEF0LzlqNEZLSFlxUFJM?=
 =?utf-8?B?QlN3N1dhZ1o2NlJKRGV5WjcwRk9XclBDV2tSUElITGo5OXk2Qlk0dE52dXJp?=
 =?utf-8?B?SkFoa21mMzNKbWgzVUIwZEtTQ0d6d1IzYjVjZUdoMVRwR0oycVNKd1BVSUtM?=
 =?utf-8?B?NEhudmNyVGFaM2JsUVBSYXRkOXZkUDU5R1hTQU44UTVpamJqTDQ2dS9NUDFh?=
 =?utf-8?B?UlF0MG56NUxkQ0h1NWk4bmFaTnJHZFp6NmxUZTVRZ0FXT1ZWdkxUcjYyQ3JU?=
 =?utf-8?B?VEVJZU5uSTJpVkZZbVlMSG5RdE9vTnpvQ0Y2YmJ0UGZKd0ZPQzJjVSs3Mjcz?=
 =?utf-8?B?Y2Fra1VtdzJMbFNFMTlQZ0FkUW5keWpLWFRiMmVNSHJKR2FMOWc0NWlNZ3BM?=
 =?utf-8?B?OGhTUU41bC8veFRYUnpsaU5jbldFUUVzUEV6RUFLaDBSc1o1UWhVQldiWWx3?=
 =?utf-8?B?ZnBleU9hZ2RGWTJRNlFvUUZtMkd5R0NsS3UwdGs5M3g1QzVoTnRVUlc4UUto?=
 =?utf-8?B?S3R3QnY5R3crVld6UmpTVm96NGZSbjlwZkd5RGlYajJsT3dHaGI0NVZTWFEx?=
 =?utf-8?B?RFpMT2xsc0hjKzBWL2xIQmlUb0ZRencyWFlGaDNITVc1NEIyUVZoS0UwQzZk?=
 =?utf-8?B?NEwvbVRjQ0lqTmZHVWl1cU9Yek85eVRiZXd5RHJWcFNyazlpaG1JTlI1aENN?=
 =?utf-8?B?NmRKd3BTRHZqSWkrdmx3cWgvcTBiVEtxU1pXV2dNOVdCd0x2QU84V1NxeWNa?=
 =?utf-8?B?TTc3aS9hTFRBSGE5c2xJTkNta1o2a1ZtLzlXc2FHNXBEWGN3VTNyV1hwZTFS?=
 =?utf-8?B?VHZadjNXeENCSnN5NjBxejkrRHdGWlFpcVpENGVMeklZMkowSHZDaXprdTB3?=
 =?utf-8?B?SDhURi9ZUlM4a2ZoK1J1TDYyWjB2OTlpK2VTWXgrNm5ObEtNWXNqeEtGYXhH?=
 =?utf-8?B?TzkrNjF4Z3F4ai9TanhkSXg0Uk1NNFlFUXRSb0paR2Jlak43ZVF3NzlINzZ4?=
 =?utf-8?B?M3FyRlp5YnBuL3orc2ppenBSSThBMytDUlJsSGVSRDZ6dE50dGk4aUN3R3RX?=
 =?utf-8?B?cnpISHNxcmR2dzVMOEVVeEl2dTk4L25VdWZPZzFScXhBekM5U0RINFdlMWN6?=
 =?utf-8?B?ZHBaVEpkcFdBZDJZMW05WTRVY2VheFBEOFVVS3cwRXBoRmVzejJQNGphSUNj?=
 =?utf-8?B?aEY3T2l0azNFbDdZUytHbzU5YUI5T1hwL2Q4bnN3b21nRlJFRWc5b3MxMHRh?=
 =?utf-8?B?ZnY5Smp6L1JZTU1udXV0MVdUaHBPZTNzNlM5alV4NkYwTC9lTDVxeGdDWTlM?=
 =?utf-8?B?VjZuekRYbnpITnJCcFc0RmtmYXJoWXppM1EzT2d4ODlkYmc0VUdDa2JtdXFh?=
 =?utf-8?B?Q1RuWm13VDg2ZVZOSFRxQlNGR1ZSNS9DUnBrWkxVQWh5QnpaZUdYZ0hocHJo?=
 =?utf-8?B?S2NpTTZPa1JGRXgzVzhxKytKYk13ek51MThDcjlzeE44U3BOa3FobWV3bXFv?=
 =?utf-8?B?OVBqYXJ0SEs2cWtTM3VkeGY5QmdwZEQxZGZvNWRmK1p2aWhOZW0wR2orWm9k?=
 =?utf-8?B?NjlKN2dCbEtwWUdoZVNNeTFxMFhLOTVqdWhSVS9ISXhldnlpYVFvL281c1Rj?=
 =?utf-8?B?VU1OcUhvbUFnVEJhOUhqbXpDWGtxSjdORHlZNm50UURKOThQaDJTREdaV3pm?=
 =?utf-8?B?eE9xZkR2dXZzbVVFSndPdTBHNlh0dUVNdTU1VHVvSDVsd1FHWDM4NUpNV3VS?=
 =?utf-8?B?dUNsZXpYZ1VGdkIzU0xwbmlSanp5WTQyQzJVSVFzWm9pS0g3SEllR0RZSkVx?=
 =?utf-8?B?ZW1tUHlNeDJjOFYwY0MxVnR6QzltU2lDbXNFRThZUUwxMDB3bnVYWEszVW8x?=
 =?utf-8?B?ZHBwMHJ5SEpCN0lYWUJvck9rRURjNndyWC9FYXNGQmZuaGVab2pDWXdrSUtz?=
 =?utf-8?B?V0hpOVlXNEtNa1VmSjJxVWhHeDFNaWs1cWt4ekRmalpGT0ZoZFBwdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7260ad-8ba6-4e8e-5cca-08de5339341d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 06:50:28.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/k9kPdsSPevTry8oEwQPpu5zlLlZbS95GQFINqnCmdVow6A8D+QU3WfT+EgQJ15VYrMOzw+QhV++cRE9GJEBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8673

Add spi nor flash MT35XU01G support, it support OCT DTR mode
at 200MHz.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx952-evk.dts | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx952-evk.dts b/arch/arm64/boot/dts/freescale/imx952-evk.dts
index 2c753fcbae3c5d545f5d835bd70492667061d626..534c93e527d0f3fb14ff3f21114993aae1d88a88 100644
--- a/arch/arm64/boot/dts/freescale/imx952-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx952-evk.dts
@@ -111,6 +111,25 @@ &usdhc2 {
 	status = "okay";
 };
 
+&xspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_xspi1>;
+	status = "okay";
+
+	mt35xu01gbba: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_xspi1_reset>;
+		reset-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <200000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &scmi_iomuxc {
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
@@ -214,4 +233,26 @@ pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 			IMX952_PAD_SD2_CD_B__WAKEUPMIX_TOP_GPIO3_IO_0		0x31e
 		>;
 	};
+
+	pinctrl_xspi1: xspi1grp {
+		fsl,pins = <
+			IMX952_PAD_XSPI1_DATA0__WAKEUPMIX_TOP_XSPI1_A_DATA_0		0x39e
+			IMX952_PAD_XSPI1_DATA1__WAKEUPMIX_TOP_XSPI1_A_DATA_1		0x39e
+			IMX952_PAD_XSPI1_DATA2__WAKEUPMIX_TOP_XSPI1_A_DATA_2		0x39e
+			IMX952_PAD_XSPI1_DATA3__WAKEUPMIX_TOP_XSPI1_A_DATA_3		0x39e
+			IMX952_PAD_XSPI1_DATA4__WAKEUPMIX_TOP_XSPI1_A_DATA_4		0x39e
+			IMX952_PAD_XSPI1_DATA5__WAKEUPMIX_TOP_XSPI1_A_DATA_5		0x39e
+			IMX952_PAD_XSPI1_DATA6__WAKEUPMIX_TOP_XSPI1_A_DATA_6		0x39e
+			IMX952_PAD_XSPI1_DATA7__WAKEUPMIX_TOP_XSPI1_A_DATA_7		0x39e
+			IMX952_PAD_XSPI1_DQS__WAKEUPMIX_TOP_XSPI1_A_DQS			0x39e
+			IMX952_PAD_XSPI1_SCLK__WAKEUPMIX_TOP_XSPI1_A_SCLK		0x39e
+			IMX952_PAD_XSPI1_SS0_B__WAKEUPMIX_TOP_XSPI1_A_SS0_B		0x39e
+		>;
+	};
+
+	pinctrl_xspi1_reset: xspi1-reset-grp {
+		fsl,pins = <
+			IMX952_PAD_XSPI1_SS1_B__WAKEUPMIX_TOP_GPIO5_IO_11	0x39e
+		>;
+	};
 };

-- 
2.34.1


