Return-Path: <linux-spi+bounces-10038-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF28FB58FAF
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 09:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1648F5209E2
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D9228466A;
	Tue, 16 Sep 2025 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gG/7mdrt"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7128315D;
	Tue, 16 Sep 2025 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009430; cv=fail; b=c2sLb5VLsK/oLrL+VXqyXb2zsVXJ1ApaARUxRaWOIw0zDYOGhKhpNuiZ8P0pqEKxRf3JgzIDGkV51Y7KKYofVR2Vjk3D0/1WE4G+bTjhORoXdHeRsMi1WXJ3WNEe/VsiK3obXEB3UAwevX/w+pdX+o5YFsDp7ruaRIsdsYIhuvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009430; c=relaxed/simple;
	bh=jakVd4+aRBGkJP79DTg60q5z/66mCHxWohBiq02MpRM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DXN6PH7aMisAqvFhN6sAApF3SMY2DK8Fe8EDNmgSqs/dJ4rlbx/vVXMaE5RhaH2vO5QASk+4YW6M9cFtiC3bUHocuqrDcdJGAb+32roQOYMXcrkSmolFVckv+DFEsN3RfRQd99sWSfLWDuf0RIJoSA6OE7asATSVXZFSQ3AhJWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gG/7mdrt; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0kfhIx9gm/Yh6C567x9Q9x0E8Dp6xCaEXUIt/vjKDD4vjr+t30+c25ROgni7nHbOiNdhpa13aidRv6fLYB0lUqsoEjFaXcLMsJfGkWPsQxUosy9R37zgXHayrCjmEpVUGhUuGkNYoO3l8ri910hFgZT+8A5WAR8wobkAnMPF3GBfy1KsNoZelHu45ORYEnAMnYE/nSjthIacVLdzM0nlE4gW6aZJVqAUyVaV8MyBIue1U3+am2tOT0hqfPNF8O/yi9bf5L3VdRLtmiRjVIK1n7AFrF7vT0gk6ucOi2C/h9bIL6hgGmLKRtTLIRNA7clnxFKNoSyAJdgimiXYnOatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jgyox9gT4mgp5j1IS5EgihKwlCXUe0O8rwskyxOXn7w=;
 b=aNFOQcuSaUq4N7W9KMIQV+eYexwqjKEtEcRz6HbTBjTdUx1dW1/9aGwZZuVsjgngCjR1pXOTbsrPtwhB8XIhXLVgvheAiNd/XZFBc2V8CFvos2Mpsuw6KI5y4Ae0bDzzpbw+ojtttEqRU52jWv89NXHV+uA+gf/7GkjW9XX8bb/aOmZI7yRplwvHIsdRV0gJw5NXk5yDCrYUvTT5HdODMtO57TOH8N85XMEYTgLlrh4OUoRODqZ/lphbKsrduS335cA7D9BM62B0h6CYtquN8o/3PzLQssDCx/wDJC9YgQdESiKM99/0HlR5Zd0uUf4R8nKgHFrvnCIcyrJHR+8iqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jgyox9gT4mgp5j1IS5EgihKwlCXUe0O8rwskyxOXn7w=;
 b=gG/7mdrttFBi4JYXIjMxEZsKiJyssm3wfR1pnbUNMnKlTG2fARYIZHVcBRU6cRGSJg3+Zmzac7UMoWH2QxX9vbdtJWiwsdaITq9rBDdzQvUVvMRwn3Hv7aGQSQmL1EtWImatE4pfWL1u1dJJOm32X/q2IkCItNj8H5wf90ewNS9c5cVnMSEiq8j9Z9a6XEsJfNJrE/EK2ZehCVi2iPG6/PmUovPR9M2h9aSSA42X9arW+FiLJEdmwFJg/jgvDqc0+QG/e718p/fbw0Pc/0j8AeSchfyCRyIALrxPj4SDE2eSiJUBSYiXsmxMpsR/9jDxhzimoN4xy+Hb/y1i+Z5iAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 07:57:04 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 07:57:04 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 16 Sep 2025 15:56:41 +0800
Subject: [PATCH 2/5] spi: spi-nxp-fspi: Add the DDR LUT command support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-flexspi-ddr-v1-2-69358b5dc862@nxp.com>
References: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
In-Reply-To: <20250916-flexspi-ddr-v1-0-69358b5dc862@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758009434; l=2255;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=jakVd4+aRBGkJP79DTg60q5z/66mCHxWohBiq02MpRM=;
 b=7yKxCp+5LXeZ7Z5bAqmBIxIMq36+fReNWvVIUNpfVdmA9A6fcuJb0r3X0lXUOVAqMriLSDjCN
 xrfqP9Js6zyDuvp+wuv9Xm1+uE4ZsdO9P7aLaNEFvlHxeOXzRpiTypz
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
X-MS-Office365-Filtering-Correlation-Id: c2dbeb71-df0a-4ce0-14a7-08ddf4f6a02a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1g1QXVLRHlFNVZiMDBLS21lMENjdEcxWTdpMWErQ3JuQ2ZrWk1kVnlhOERs?=
 =?utf-8?B?dW9naVdwMWlSOUlHa1VNYnY5ZTM3ZUhlWnUyTjkrdnRZQkpGbEdOZWdNeUpi?=
 =?utf-8?B?ekl5TmhlVUtDTTRlYnYvZ0xkbUo1cFVvanVHL2MrWTRsR0RTNzVXZE9DT3hh?=
 =?utf-8?B?V2RkdmZNSXlub1FpRkFMSmhvVHFXRFp3ZUV4OWNzZW1tRFlrK0t5RlUyMU9h?=
 =?utf-8?B?a3RHNHNjNisrUjRBZDJBYVhuUytMZWdJMEF6RnNqck9MaUMvMEJISTlaTHFi?=
 =?utf-8?B?ZUowbldlVU5PRnE5OVZRYk1EOGxzcUVYdjcyeXpnVkJLQUtPZWtjNCtaS2Vp?=
 =?utf-8?B?ZFhTdVl6Ni9ZZ2lNTDA3Wk1NeURWMEpHV0JVVitTajNwYVZnUHZpU2g4SHRJ?=
 =?utf-8?B?UE1VMXU0NEZtTUg3bWorQUpTQnF0YmNQdHlwdHdmczJCaktHdWtvdC9wbG85?=
 =?utf-8?B?aHJWZXBEbDg5ZWsxakFLMmhsbmY5VXpDT0FScHhkN09SNkNzNkc1MG1WbXdj?=
 =?utf-8?B?bWl2QjhjQTVIRSttZG1DZGk3eGZUa0JqYjY5ajkyeExHcDBDUW96YjRkOVV0?=
 =?utf-8?B?WUVnQ3RBNGZwblp4eUQ2WWVkTFNYOVFZS0MwYjQwOGtxaUV3Y1NxcEtseDJH?=
 =?utf-8?B?Vm9aNnhnRHZQaXlkcjBSSzZRREYvS2p1aXNnRElBZkRuV3k3ZFI5VkNpLzBJ?=
 =?utf-8?B?MS9CdXRBSkIyZGxrcUp0aHdXMWVORzZzZ1l2cUdtQjhob0wwL1JMb1hubHdX?=
 =?utf-8?B?VXh2ZnMrNnNDMEtGTXBPNVhVeHVrY0VjU3pGdWNWQ0cwQnpGU2V2UUJsVmtw?=
 =?utf-8?B?VHVGZElKZ1haaE5jdmVwZDBHdkhjS1ZsM2ZDYlp3ZEk3QjZ4VlU0aDF6T2NV?=
 =?utf-8?B?UzQ5NEtGbDkwbGhQQUVBWm9zbklnMk5ydnBvRFJmK0tqbEY4b29FQnlUZm5k?=
 =?utf-8?B?eDc2QklIUWJZYzRHa1JpaU1NRFdyUFp1dUE1N1hUR2dOZ3lsWU8yMXRTdm13?=
 =?utf-8?B?TE5xQ0gzU0xIbmRjQnc5QWdQZS9aZGd6M1M5QkRZd0hoU0lQTWxQL2huc0dF?=
 =?utf-8?B?bnIyY3Q2eFdMQUUzdGw2WWdnaU1Qd09Ib1dEV3l3NHl1WFdhaGZIc3lZVm9h?=
 =?utf-8?B?YlR5SkFvL2lqcWt0WWdSMEVzRjQ0MXAzV083Zm9yUGIwa3RPL2dyaWZuazdW?=
 =?utf-8?B?aXl1dzhWRjE4QklQZ0NMTWljcEZ3NjhhZDBpRGxGdUhyVFJES3lkVG11UllZ?=
 =?utf-8?B?OElyNWNqNC9McVp3VFUxeXRGRzZNdlZuREJXS01QZEw3dUZRRGlLZUZCRTFr?=
 =?utf-8?B?M1JyREh2U21RMG1HVTBoT0FaN0ozVDlwU3dhbGpIejQ4OEFKdEYxMTlLQ3F6?=
 =?utf-8?B?TjFsN0RXTzlQZC9Ubi9GOGtoUEhGK1I5R1lsUVRtcFE2OFFEdm9RQW1ZaitU?=
 =?utf-8?B?OG8xK05vclUwQXd6akFPZlllN3ppaE8xUnNGZ01MYUcxbUg0NG0vWHhBNGpG?=
 =?utf-8?B?YUpsOVNFTGo4NS9vRjV5TFZRMGVCNmRpOGxVenlibnA2S1hDbzNac3NVWGcv?=
 =?utf-8?B?RUdiNy9kNDRoWUVFeXFNbVltOGIwYmgyaVNXd1BNdjgvejFOVlQxVXJBMmNC?=
 =?utf-8?B?OEdaTGRZRXFsWVNhWEIvUG1vZHl6enZTcWV5aC9qejA3OHNrMkxjYkcvQStP?=
 =?utf-8?B?bFJhVFgzb2RxWm9IZ3RrTFk1ZmtReUNzaFQ5MmVqWXIrWFJTNytVQ3N1aHh2?=
 =?utf-8?B?aHV1ekMvNlFGNWxhQXhRcVBiYTZHYjRtOWV6aUVpMjB6WlRMY0VnYnphdG5h?=
 =?utf-8?B?cWpOdFphT0RMSFp6SVpCWTNsSWlHSDAxeVRvMFBXYkZIdUpaeDUvTzJQbFhp?=
 =?utf-8?B?WElXZkxmaDh0VXAxTXV0anBzaVJ6eWhXOGNxS25rVUx5UFpuZzllOFBuTVhn?=
 =?utf-8?B?Y3JnYzFya2hxMzVZay9ucGRVb3JkR2kxc3RwU0lXMmgxQWxyL1JkR0grM1Q0?=
 =?utf-8?B?VHFERXloZDV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elloNDd4VTFBaUdlaEdpRjlINElwaGt0OHZTSW1WclVFUzhMQW9USHpIUkFl?=
 =?utf-8?B?YVh5NXhqYnl5SU05Mmt2a3E3anFQSjFoNEw5VDAzZFVOVGpKTUVKSXRBdEsv?=
 =?utf-8?B?THN4T3BXcjV1UFVTT1BjZE5IbnlERzl1YVE5RDhzYWtuTHBNUndyMi91Qkpm?=
 =?utf-8?B?emhEY3ZWNHg4bXlRc3M2b1pZV0lXU3hhU29HdVFXZ20rNUhEc09xR3VRUjRp?=
 =?utf-8?B?dTQxM1IyNUx1YjNWbTd5Mmh0dnJ5d2pxT0tTMUZXZ2t2TzdyNHBoaUUrQU5l?=
 =?utf-8?B?TkhCRnA0ZFhvYlJpK3Q5VytoYjFmQUpzbWF4OCtDWlM4KzBRWG1rRkMrUlRz?=
 =?utf-8?B?UWtGZXBzZFpOeWlkM2VHdkI3ZzFreS9pRldxSjlIKzUrcGhXUjdjUTBqQkl3?=
 =?utf-8?B?dk5MK25sL1ZyMkRIK1Nxeld5ejVBOW96ZkN2YWozUksvdjgrbDA0YjNzNWlJ?=
 =?utf-8?B?QlBtbXdoTDNyWG1wQWdUU0hNSnVIN3IrenR5VDVWR0RjZy9jTHVrRUVjazBE?=
 =?utf-8?B?Q3dFL3pMR0cxeHQweEwzOUdIUnd0SWhlcytzSGIvVEV3dWJld2RoVHhxaTdh?=
 =?utf-8?B?czRJQkZTY0RUcysrQzUwOThBanhRbENCeG9uUkdjVWRpbDNWSzRIdHlDWmFv?=
 =?utf-8?B?MFRpZzFzZUZmaW5pbVJlbmRCZVFSa2g5RFE3c1IwemhCRndNVzF4UDNOcWVy?=
 =?utf-8?B?K0tIMG8wRjljVW00N284a2NRWWQ2TGs4WTQxeXEzbjhMYUpXbEVtemh4UThL?=
 =?utf-8?B?bXFpWUVCMHcwd2Q4bWlZS2FCdGtyZVdCZk4rTEFDQ0kvS0pqNlpwL3dUUlJa?=
 =?utf-8?B?MHkwOUhMOHR4eGJOWURLR3lteWhieEo1djVXRTBDODZrLzdMZnFGcHROcm9n?=
 =?utf-8?B?eHhzcEs5NFByWlpOY2RSNUg1MGdFeFJFQXlvK3JyRTV0ZVNPSjNUa2MxYUhy?=
 =?utf-8?B?NUxsRjZMV3Jqa1N3NEk4TGtZNVN6eTJzMzhIbHZ5MklpV2VxUkRiSWxQUVc5?=
 =?utf-8?B?MmRjRWZqdVdwaXRpcVk5Zi9pN0RtWERVcVFFT1hZSTF0SmFaMTRCbmRKMFVX?=
 =?utf-8?B?N3NMbzgrVjh0Q0w2T2R5N0k1ZWhEZi84dGc2RGtMY21IV24wSDhndXUveWRk?=
 =?utf-8?B?Wm5TanRXVFA5N01WcG8vOUhxMWxNKzhGTjhFN0hHRXlQVTk0MWtFaXRXQnRu?=
 =?utf-8?B?MlRaeU9yMVlmbXNJcUY2WjNBdml0RHZnck91MWFiL1Q5L0NUTmhKZmVTR2ta?=
 =?utf-8?B?V1hzUEVwWEpCNXZaemlQRGl4blBra2dBVWhiNGN6eUFKY215YVUyaTJmL2c1?=
 =?utf-8?B?NHhxV3NPUmZXdWRoSjVnVDY0ci9IdjNuQmdoVGFCSDJ3N2V2TnQwYXpHVUZV?=
 =?utf-8?B?R1dEZVhEU0JNS2lDS2JwNFdVUGx5NjR3VXEySWQ0SWFGdDlyODZzLzdVaTc4?=
 =?utf-8?B?VGJpcEJPWVNwTFdiWUUyWlduQ3RuS1QwS1VCbDA5UVRJZEVZOWpUbnQ4K2xD?=
 =?utf-8?B?M1p2VnNEdGtuYWNKczFKOFp3WE4zU2VuYW1UY1NjaWE0UWJCQ011a0VtSW9N?=
 =?utf-8?B?VFRpUDNlNXB3TzVyYXFLeFA3YURvMEplN2J0V1RBM0wwaEkwZjEyMkhkM0M2?=
 =?utf-8?B?U0xOWk91cm1qL1lzVHpUYzc5bXdnY0hxbWdRN25SMFR2ek9TTG9UL1VkeVl4?=
 =?utf-8?B?NXBhT0NrZHFpcWlxbzZoem9wTnlJSjZiVkliREI0dWlya3lsRGJNMmpBYnpF?=
 =?utf-8?B?MTRWdmhRSndWVlM2eU5NeHZIMVdDSHJTU1RRcmFyRnRJaFUyWVZMY3l5S1F2?=
 =?utf-8?B?aDlkSDVWSHNnVXJtd1pzeFNsblJSQTZ6N3ZrY05aYTE1U3RlQWhqUGpyeW5S?=
 =?utf-8?B?MXNQVkVpS1pTNXlVWDJXK3NTS1lwVEdxVGNwRjhidi9UMkRDTms2am52cG5N?=
 =?utf-8?B?S3dvOUQ3UGt3MEJiR0hCQkFBcThMKzRaclZlS20reGtCZ29KaVhBLzJuY3BU?=
 =?utf-8?B?bkdyM0NwNVJPaVVERHJ3SlNrV3VZSjYvMTdCeVZmR2ozTHV2SksrQXhVbm1w?=
 =?utf-8?B?Q0hqMXlNaDc1K2dNUHR3SlVFcHFRSjdER1dCTlB0MVRTRVdaWWtaTUlZaDVN?=
 =?utf-8?Q?MDGA81VWzRvAwVp+e1FkS4wJL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2dbeb71-df0a-4ce0-14a7-08ddf4f6a02a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:57:04.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aB+Mu87ov6jFp/FpR3sp0JJ+SP3xiesCul3IX8kMHXOyoa3hicRyqoRUAD6P80sz2CEhX6YPMkX6w5SKtpQ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

For DTR mode, flexspi need to use DDR LUT command, flexspi will switch
to DDR mode when detect the DDR LUT command.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index a1c9ad03379682dc1fc2908fbd83e1ae8e91588f..6b3e6b427ba84734a2359a964635a8f05cd146fd 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -559,12 +559,22 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
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
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->addr.dtr ?
+					      LUT_ADDR_DDR : LUT_ADDR,
 					      LUT_PAD(op->addr.buswidth),
 					      op->addr.nbytes * 8);
 		lutidx++;
@@ -572,7 +582,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 
 	/* dummy bytes, if needed */
 	if (op->dummy.nbytes) {
-		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->dummy.dtr ?
+					      LUT_DUMMY_DDR : LUT_DUMMY,
 		/*
 		 * Due to FlexSPI controller limitation number of PAD for dummy
 		 * buswidth needs to be programmed as equal to data buswidth.
@@ -587,7 +598,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
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


