Return-Path: <linux-spi+bounces-7782-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458FEA9ED80
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 12:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F56417241F
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 10:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98AD261570;
	Mon, 28 Apr 2025 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lyQfjFbR"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0926136C;
	Mon, 28 Apr 2025 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834715; cv=fail; b=su2Fb0NjkMAtJ2IRAqkX4oZhw429yv88bMskKMIhIVwAK/WqBFeWQ7uqUsUwSSfdLcQo9CUo3pP39bj3yUOTMwdEdIOKDj5zzE/pnfBfow4Ldemb8+nqt3ENdRlnG6YtCc+4hYQbKeAv2/P9tY2uj4BvIWAiMdSXRUqv/Z6/6oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834715; c=relaxed/simple;
	bh=R+E0blCnr84VOgWVUzaNmlI5G0tHD3+mnj0wlyBAGLc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=INdcPlnDdJSgNNBTLU1tYs4lJtYtYMQtKlo1kMH7jvqAlx61SQG2Jzhga76CJWGO5/FdKKMX9p0YM7deH3+V0d13ernWM4AC7Ur5e9K3RKJq83OMN5PGmjXONhIOoAwio8C+fxZOpzrHQViNNuQWquwHjtMJyPv8PSLhpaqm97g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lyQfjFbR; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRhQSzgrzgKK+Xx6ZZJCNC2a5oUWY3M6eqi7leFLRAhqDOTFxtMSZrxY0oxVycAw2NcHarNOArT2GUe1E/Tr0iVbmIIisnlOpcUFat2A3988D1Z1TRkdzPhrZ++rV08jwrZJ6u1J7HsjFQxxkZ7N2PB85tz7IFLBDlSIMQYtgWrxIY7c7a7kzjanqvV9XIUJxy1xVCQlHoatJsiyafnPCbk7VJ5eK3q/Gof/q8c3NAVlpUgZndwQRdqBfWLJCY6MTyeBiLE4QAr/KuhLspm3OnGJ4w+zB50y/B09/ei8oNKTSRO2OyOlyZwYXqNv3Cd4CIc+FU1zwe2nCjb+gCl6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkoc45T7BYUh7B6StD6VS++pbiV1SAITGBvZZWupjxI=;
 b=mVrYHVDV9IrEhIJnJEE7YG/ukCUn+fsSQKTWaxMwysXGCrRZ5cj3qfKjNZTOsloci0D8j+eXGRJUPsEDduTAX3rbf+8sZn9GtWv5YH4Y81aUkCbQxzg22884fR026GBhtuuGj9Iizd7c+YllP6c+YsdmkzBk2odUDI5KwuD/MZ58zv6USVvudh5IOvfaRwnEpwNMSv3GsfZp7CKazZF8Rhyc1pVQ+Go1YfACHYdYsSVPRkACb39+OEqBYq8tkHdI5/o+4uQhUHtjfF06KOTmeJo7mestVDwXV7z3gLmzI2v0TbohIabDwLHh2e1qO8yofJfNE260cuM6jkBhm3EPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkoc45T7BYUh7B6StD6VS++pbiV1SAITGBvZZWupjxI=;
 b=lyQfjFbRFnFwe1O1Lket4XULu6/E7s7UFu3l0dhhY61a3r2zoHTlCi99goDfCwJzgmWylSYB2YUcEWJFa7iQm6IGos8HhFAlhcDPwBkOKa7YWJvKOwUqHvynVCP2f3GfD8O6C6nWAIJiIjIiCVSMpmRAOwXpVdScnB4T3/S8IlgUwO6Iyk/arq2kZcUNgiRt5+Zw7hktrJH90rx8OsRtxsjmdAyIydiukEaVPvmSX5EuCBU8aQbvsbH6qI3pUTV1S8zVJ6802znI1w6gb8MH8r41dS7szYK/jOHr6MNnsrBjuMzloEc/zBVk/juaMJKy5tbZrc7O466mEXwZwBqL0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAWPR04MB9862.eurprd04.prod.outlook.com (2603:10a6:102:391::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:05:05 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8678.027; Mon, 28 Apr 2025
 10:05:05 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 28 Apr 2025 18:06:43 +0800
Subject: [PATCH v3 1/5] spi: spi-nxp-fspi: remove the goto in probe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-flexspipatch-v3-1-61d5e8f591bc@nxp.com>
References: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
In-Reply-To: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745834827; l=4520;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=R+E0blCnr84VOgWVUzaNmlI5G0tHD3+mnj0wlyBAGLc=;
 b=Dt/5jF6GbjUYTxhe602jhSPIWg2Wr89MFJA+LAzqsz/nCdvGZe4Yx+hQYhWUNxgCHp1MyfKje
 kHlS7g44l2rD3CDUmoe5EuVRKqbN6woxJZHsSijCkSi6lNRojtGDICU
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAWPR04MB9862:EE_
X-MS-Office365-Filtering-Correlation-Id: b8194e40-7f6e-4ca3-4865-08dd863c25d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUNndGVUUVpBYk9XUUxiaWhCR2tmcTd5b0srR0NzYkNIVWFheW43bHd1NGxX?=
 =?utf-8?B?YzZoS0VSa0xRSmI3VnZkYWR2dmxBWXYveG5jaG1uZUxNRGhkcXB5c1VjMVlu?=
 =?utf-8?B?YVgrcVQrS3R3dFI2VHUxUUN3ZUxGVDMxcithQzY5cFhQK1RaRmdGYmsweUt2?=
 =?utf-8?B?SUlOWEV0V3BiVGJNSG1lTU1GWDVFaDZHdTh4bjE1TUM0NnZiMEQ4ZkppTExT?=
 =?utf-8?B?RTlhem5YdkdGd0FxR2ZHNEx4L1AxV004akRYV1FJV2RIcFNwQ01XRmJmN0hK?=
 =?utf-8?B?c2FuNFJ3WEtHMDNmQ3ROWVVCTDdKd3QrUFhCWSs1K1JFK0pyQ3daalFyRUk4?=
 =?utf-8?B?dFEwRUk0ZEY4SE5Vek5PWEpEekh4TzRGUWRjYmpOc1NVUEpzcWtFVHdmcTFs?=
 =?utf-8?B?Q0tJS2w4NWFnQzlaajk5bGdZSkMwRW04cU9NWnBBaWVZbndrOVJSaXZUZWZu?=
 =?utf-8?B?ZmhrQjFnQm03bGF3ZjlEWjlCM3ByWkJCZW9VN1VXbngwNWk2UGMyRGU3L3E4?=
 =?utf-8?B?aXJVQ1pZOGM0aXk5SG4wcVRjc3Y1K2loSWJQZncxVUw5S093UEgxT3Z2RjNt?=
 =?utf-8?B?eXFXZVlZSm9iSGl6ZXNFNG5TOFFSN2ZOYjR2VkxZYVdsdDMxeGhtamVTa3ZW?=
 =?utf-8?B?bXVlVE5yQVVmZmtwUVMxYXF6UUlLNVMxSER4eU5xMlZXeml5TXIxN3NHbDBL?=
 =?utf-8?B?Z2ZaaXUvUU1GdTNxek9nckpQVXlMZksvK3NvMHdSdWlmK0NrR2RkblZNL1dC?=
 =?utf-8?B?L1VMWUE4UXBLMjRSWmJQLzJjQ2h0aFl2NW5uditnOGhCb055ZHlncDY4NGtw?=
 =?utf-8?B?UzF1T3NFcXE3SVNxTGhaNEo3dDZVZHZuakV4bVFCVWtZUnVhRzN3ZkVpeGZj?=
 =?utf-8?B?MUQzelYrWHJKMUlVeUtkTTcxVGJhQ1BpTGVsdmRneENIdFZEcEpDd2ZEdG1n?=
 =?utf-8?B?R292T0F2ZkcrY0NMN1BBVFdYQ1BOYjlHRlJERGc0M01tTUcrL2I4aitOa1Aw?=
 =?utf-8?B?TkNCcTEyQmxlMGlIU0NLOE9VMkp5eVNpMW16NndmZlp1YVZEZ0FVaDBsVWlC?=
 =?utf-8?B?S0swUVVSczhiZTUwT2F6UXpNdk9UVlF0OHRZRFpTMnpIU3BCb0dkbWRvdTJt?=
 =?utf-8?B?Sy9IVjl3ZkZLN04zeXBqTkJQTGliMWJpbUNXY3d0ai9mL1VwdERSTlh5RDNu?=
 =?utf-8?B?Rk5PUWhyam5CL25zMXN3cnBFQUh4VkpSQjl3Y2dkQno5aW5CWTNCa1UzTlVq?=
 =?utf-8?B?ZUNYc1kxQlBCWkdSdi9icW55aVl1RFBwd3VMQzBGdmU2NjhacHdPdlZXMUQ1?=
 =?utf-8?B?L1dXaklQbzJvOFIyYksyRXBjSUpsMXMxaUxMbGNpVE0rc3NucDdRU1RDcE1Q?=
 =?utf-8?B?VlB3ZXdtK2lDN2dqRElYeHZCZWR1QllZZm1RNzJWYzFudThSM3lUdmVIRjZr?=
 =?utf-8?B?dUhNaWtrZWdqSTNYVG5YaDl5WGMrNVBBMDB4eVhtbFFzMHZGYzdTcmVtdlIw?=
 =?utf-8?B?WWZRdi9HYTZXZnQveUFuR01iU0dwbHFYTDBrT2R4Slg4dG9jMnhmU211c2Fy?=
 =?utf-8?B?ZllJQS9UbjVROFQxVFo1emdySWZNUTRSZmlTZXY1V0djZWVVOHAwWlU3bEt0?=
 =?utf-8?B?c25GR0N0MWp2TTY5bWlNZVUxcUI2aFdOUTN0YUIyNFJjaG51UnRxamZ1eWlO?=
 =?utf-8?B?cHpuZUExZCtjVFVmWnJkS0JuVWZpTFN2MDV4NnptK3k4dWFWR09adjdSZHho?=
 =?utf-8?B?OWxFMVNNOVFnK3luVXdBcTRPWW5IdHhPekQrN3dDakdhc3JLcCtMMkNpNDlw?=
 =?utf-8?B?QU1lQWxaNFdaeFZWdWUrWElvY1NqUEVnM3lTK0MxZ2UxNWxHMVpYeHJaa3lP?=
 =?utf-8?B?bW5zRUxkdllYVWVCWEdJZkZkcXpqdVRZRzBFMGZpSmlDL3NRZnF5U3JUakIv?=
 =?utf-8?B?WDAwK2wvd21ueStGOW93WGhNc0M5NFB6Z2Vsc1JqL0tIVTN0M3dkUk1KNis5?=
 =?utf-8?B?Z3pVL3dFSXFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkVLbHdRSTQrOUs1RkhZODRYU0tZV05BV205azltSmV0WnZSOVBwaTRld096?=
 =?utf-8?B?T2hOZEcyOVpwQ3pCUHZLUk1iSFJYSG5vcW1ZSWludWdqK0FPMDB1MENyWWp1?=
 =?utf-8?B?cVJ0SEgvbE9FcFFTS2JBKzVhS1hDc1FLRURDQ1B1YUF2M1J1RFhyOURDcUlm?=
 =?utf-8?B?UElnbDRKc3Zacyt3ZjkwMHNybzNQcW9renVoaFRVdmYveEpucENXT0hRd2JY?=
 =?utf-8?B?ZytMcnhENE41dytTTFBNRW5iSFNCZEhNSllpYmlXK0kyR2hpaU1kajZqMHln?=
 =?utf-8?B?eXk4dTQyM2FVTUl1TVYxVzd2MitBdG9BaGU1VXhmTEg4SzVnTGQ0YjY4YTdZ?=
 =?utf-8?B?b3VFVjdaYW9LYmVtcjJaUHB6c0oveDJlNlhWdzhIU0xsNWQ4UGdhZklqcFhj?=
 =?utf-8?B?UXExQ3gwTnB3YjgvaUw5ampwelZUYktBSW83Ukc5Tm85QTVGY3lTeVcyTXJ2?=
 =?utf-8?B?MXF1RVEwUTN0d2cyVFhwY1hNWGlIU0V4NTFuUm53UkYxRzJ2Mjl6ZmIvaTN4?=
 =?utf-8?B?bGhUU2htRk5DYlpOeHFQTWx1UG5kc0VMOGdFcUVIaUEvM3dPQXpycVNQcU1k?=
 =?utf-8?B?ZHhiSzVhdVFLUVNWdkNxWnRLRnVmUHM2VmtoalhjM1RQTXFIN1laZ2V1cGtB?=
 =?utf-8?B?VS9GUFJOdWdsd2N2VGdKVHhtYU9SS3k2VmlPc3JXcXRQTlpSVmRNOWkvU2tW?=
 =?utf-8?B?S1FVS3Z6L21oVG4vQkVyZFY1NVZOc2xURnRGeUpuemJrMWU1U1l3QjB6Q1pk?=
 =?utf-8?B?VUtBMjVDMVRjYThaTG5rRGh4RmhWbG95d2dVR3U4bW5HQ0xzbXFNSll4Sm50?=
 =?utf-8?B?bk5rK0ZuS041UFI0dCtacHpwbFJMa0xZSTN4Tkhpb2Q5SEh5VzBaS28zbmhW?=
 =?utf-8?B?WUJocldBVWV5NDZTcENWOVlxNlJ3MFRia3IzVkhXWWM5OHFDUlBhNEVpOEpy?=
 =?utf-8?B?Q2RseXFjUno2dng4UHFobkdGV2NCSjI3T21pY1lYOFlyWSs0bENDUjY4MGZh?=
 =?utf-8?B?ZHBPS09mS0hKREN5WlJUQy9iWHd5cGdrbUt2a2trTG9zaE9NMTcvcGh6UGxx?=
 =?utf-8?B?bWFUOU4rbEdyMlo0ZnBIb2pTYkJNT2pRZTBaak5oUGhnejIzSStzT1I5bDVj?=
 =?utf-8?B?T0tDVjlIeFNRbWtRSncwSEJEZ1pLUytNVHdtZ1F3SGtWcitoK3lMRnNoNlFE?=
 =?utf-8?B?NXkxcDB5anJ0dEl5TDkrNUkwUGJXQm1Ea3JJSWcwUjNUVmg0V1VkMkkyQ1Z4?=
 =?utf-8?B?WUJsZ2d4YkpUNmx2WExLWFNPdkZRaHY2NkhzY1BaZHZaR2lYMnlCa3I0WkNk?=
 =?utf-8?B?cDMxNGpNZWtEa1FidllqZlF5UnkwTVJKa3FtMVd4elJvTWhwSHh4TzhuaHpl?=
 =?utf-8?B?TUEyeFE5VlVZZk5hbjdPVUxpZ2M2UjNHcC9vZTdZZDUyMTEvMlRMRm44VkJz?=
 =?utf-8?B?Q3M4ZEM2ZDJ3MURNTklZcUZaamN5eWRjek5BbmVxMGhLZXBwVGMvMUpjUlZO?=
 =?utf-8?B?N1pBZGRFYnNMUjZVS3M5TUhQYmVyZFpLc0QzdTVVdW5MWjh0V0plSCt6bkNT?=
 =?utf-8?B?bVpFSTlkWUhHVG9McHYvZEtKSTQ1OTNQVEU1dlRIdHAyNGIxeWtRSzE1cC9q?=
 =?utf-8?B?bVBzcG1vWnJyR1c4U051RWVqbzBTS0o1OXhtV0tYckpOeGIvblFzTjVGc015?=
 =?utf-8?B?OVBuenV6UFFhRjJvODBTejZnVUpPdjdjYVJHQzVlS05WWG1GSG5RWnpncUxj?=
 =?utf-8?B?bTBuL0t3cWdsQ3FXYUJ0K2VHSE1vMzkySkNZUWtIZ1o2b1ZOOWF2djh3SEFk?=
 =?utf-8?B?VjY2dUZHTWZ0NWVjMm0yWWFFanJaTE5PdUxJUmkwZ1JCeVJ2NERmMnkrenlx?=
 =?utf-8?B?Qi9RL2VXMkZINDJ5Sk9XNWc2Rzd6K09iSkZpSUZsZEpEWnJienA4aHpZQzd3?=
 =?utf-8?B?QW9kT3h3V2NvS2FVN0QyRVZ5TWQwak8wNThoa2lxbnh5RDBYaUgvQlI2Nnhn?=
 =?utf-8?B?NFEyazJUd3FsR0c4YWtuRmpwWVFDSm1RV01ucXovcUhTYVlOVUFNbGQ1dk56?=
 =?utf-8?B?T1NCQ1NQaTJoQ0QvcWNSTjRlVFByVHdEQk41ZmhCNlRkODM1cUN5dEgvTnhp?=
 =?utf-8?Q?Wnc/e/WHoePqH+JEwXHNAjDGv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8194e40-7f6e-4ca3-4865-08dd863c25d7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:05:05.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yuvX8kZMZNgUSLhZUs47ZYFXayCmtBk7stncaWRObR9oYJD924Q4vBdIykTXp8EMLaAYv0nQRVRuXvMLeL9sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9862

Remove all the goto in probe to simplify the driver.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 87 ++++++++++++++--------------------------------
 1 file changed, 27 insertions(+), 60 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index bad6b30bab0ecb90d0aaf603b6de5bc834d19de6..00da184be88a026bf562c9808e18e2335a0959e9 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1161,10 +1161,10 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct resource *res;
 	struct nxp_fspi *f;
-	int ret;
+	int ret, irq;
 	u32 reg;
 
-	ctlr = spi_alloc_host(&pdev->dev, sizeof(*f));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*f));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1174,10 +1174,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	f = spi_controller_get_devdata(ctlr);
 	f->dev = dev;
 	f->devtype_data = (struct nxp_fspi_devtype_data *)device_get_match_data(dev);
-	if (!f->devtype_data) {
-		ret = -ENODEV;
-		goto err_put_ctrl;
-	}
+	if (!f->devtype_data)
+		return -ENODEV;
 
 	platform_set_drvdata(pdev, f);
 
@@ -1186,11 +1184,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 		f->iobase = devm_platform_ioremap_resource(pdev, 0);
 	else
 		f->iobase = devm_platform_ioremap_resource_byname(pdev, "fspi_base");
-
-	if (IS_ERR(f->iobase)) {
-		ret = PTR_ERR(f->iobase);
-		goto err_put_ctrl;
-	}
+	if (IS_ERR(f->iobase))
+		return PTR_ERR(f->iobase);
 
 	/* find the resources - controller memory mapped space */
 	if (is_acpi_node(dev_fwnode(f->dev)))
@@ -1198,11 +1193,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	else
 		res = platform_get_resource_byname(pdev,
 				IORESOURCE_MEM, "fspi_mmap");
-
-	if (!res) {
-		ret = -ENODEV;
-		goto err_put_ctrl;
-	}
+	if (!res)
+		return -ENODEV;
 
 	/* assign memory mapped starting address and mapped size. */
 	f->memmap_phy = res->start;
@@ -1211,69 +1203,46 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	/* find the clocks */
 	if (dev_of_node(&pdev->dev)) {
 		f->clk_en = devm_clk_get(dev, "fspi_en");
-		if (IS_ERR(f->clk_en)) {
-			ret = PTR_ERR(f->clk_en);
-			goto err_put_ctrl;
-		}
+		if (IS_ERR(f->clk_en))
+			return PTR_ERR(f->clk_en);
 
 		f->clk = devm_clk_get(dev, "fspi");
-		if (IS_ERR(f->clk)) {
-			ret = PTR_ERR(f->clk);
-			goto err_put_ctrl;
-		}
-
-		ret = nxp_fspi_clk_prep_enable(f);
-		if (ret) {
-			dev_err(dev, "can not enable the clock\n");
-			goto err_put_ctrl;
-		}
+		if (IS_ERR(f->clk))
+			return PTR_ERR(f->clk);
 	}
 
+	/* find the irq */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get irq source");
+
+	ret = nxp_fspi_clk_prep_enable(f);
+	if (ret)
+		return dev_err_probe(dev, ret, "Can't enable the clock\n");
+
 	/* Clear potential interrupts */
 	reg = fspi_readl(f, f->iobase + FSPI_INTR);
 	if (reg)
 		fspi_writel(f, reg, f->iobase + FSPI_INTR);
 
-	/* find the irq */
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		goto err_disable_clk;
+	nxp_fspi_default_setup(f);
 
-	ret = devm_request_irq(dev, ret,
+	ret = devm_request_irq(dev, irq,
 			nxp_fspi_irq_handler, 0, pdev->name, f);
 	if (ret) {
-		dev_err(dev, "failed to request irq: %d\n", ret);
-		goto err_disable_clk;
+		nxp_fspi_clk_disable_unprep(f);
+		return dev_err_probe(dev, ret, "Failed to request irq\n");
 	}
 
-	mutex_init(&f->lock);
+	devm_mutex_init(dev, &f->lock);
 
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
 	ctlr->mem_ops = &nxp_fspi_mem_ops;
 	ctlr->mem_caps = &nxp_fspi_mem_caps;
-
-	nxp_fspi_default_setup(f);
-
 	ctlr->dev.of_node = np;
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
-	if (ret)
-		goto err_destroy_mutex;
-
-	return 0;
-
-err_destroy_mutex:
-	mutex_destroy(&f->lock);
-
-err_disable_clk:
-	nxp_fspi_clk_disable_unprep(f);
-
-err_put_ctrl:
-	spi_controller_put(ctlr);
-
-	dev_err(dev, "NXP FSPI probe failed\n");
-	return ret;
+	return devm_spi_register_controller(&pdev->dev, ctlr);
 }
 
 static void nxp_fspi_remove(struct platform_device *pdev)
@@ -1285,8 +1254,6 @@ static void nxp_fspi_remove(struct platform_device *pdev)
 
 	nxp_fspi_clk_disable_unprep(f);
 
-	mutex_destroy(&f->lock);
-
 	if (f->ahb_addr)
 		iounmap(f->ahb_addr);
 }

-- 
2.34.1


