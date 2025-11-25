Return-Path: <linux-spi+bounces-11503-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B5CC845B1
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 11:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07F594E904E
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53689258ED7;
	Tue, 25 Nov 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Gcib1rLd"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021133.outbound.protection.outlook.com [52.101.70.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429E257854;
	Tue, 25 Nov 2025 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065071; cv=fail; b=J9RlxrNL4l34IKXQotN9ERHzXxKdx8ZMZYb/0MmblotSus2MzskVkychxejJFUEAS7y1DClR3MXHvCk5HPm1Y0EPSNy8Iu4VPBX4gN0YWlCzYKUUcNCY9l0nH2MGOazyF5FszcdpAZXZuy1nVVfP523vyYmVboJzwI9tIVVHW44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065071; c=relaxed/simple;
	bh=D9G1LV6VAJpbAfQh3cx5D1vSITDWqaPRzGRyzMORmAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oSymw61/tr5x3mXpjM9Rqh3N4PnXhfsM1LmCSpbv78qPBebZF2z0caiZbzs8nuvLr6NEx1b/dny2N+2kiGtF6sniyncrkZ7rs7NILAxdhSLBe2Oja4udiu/+Jps0jFWEbWjGJbW/s0eh07gMlMSDAFzYytnGxJLkilFS8rrN8s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Gcib1rLd; arc=fail smtp.client-ip=52.101.70.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6qAy8JPZ9A9zGviaYYu/Q6Dx2WZJGntXvNAJVl6MG0E3yfuh/YyA35MheXZP1JcTpg+6b/fL+t9tlMMHYakmg1nxZRjxn6aDGciUHfwJsDiz1Y9GO3Z+A/rEYgKcq2u7vNfhUopbyAydGG17pQE6s5OvpJVSOTi4e31zO048lH7Huashglm08W4/QTbjYqsgFYC9xG9eEz7kSkRPCONyIfUFDVCixK4gshy9FgpawmxSOaAXFctIzwc91AVLKDv+aIh2ORqFOn71alVcZo4Mlnwd6OPyL7DrbsNFuOEsAm6XbR4ymZesewzM2oFW9DW0BLoF2yOdM2elPzpKe63kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rI9Om9Tnouz5jqpV1cYOr5Ap6EHyoZ9rUvmc1r750ZM=;
 b=ioGeDRg6XvkGWrxqe7Ke5o9+ROocBKxesGM+/NkmEjbGVeA21kFm4qdqk2XoE4JMxenk1oak6ENA8lo6egrO7tI7VKsr8zrUzOxcM26kbBkv3TfTVWQJDsVQiYJgN6EPvMk5F8OiJ7e5ut/+/zRz6C9J4sczu5F3lERRnRxG5qPxRbjMnHPso1g8F8ghqIxqllozFdnKH0ffGex4lAmFMHUceRXYk+VkykzKvQZPPSiUzJwUBca6PWLeHiPFielkKb7tevysem4HNFf5tBELb6KrqgypeIQYiC5Z688tOn0lPnzrW3IPoWh9fChtV8XhxFSztL7IEQj/NYZpAIIdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rI9Om9Tnouz5jqpV1cYOr5Ap6EHyoZ9rUvmc1r750ZM=;
 b=Gcib1rLdQmEBJRIR745iPieXI3bdWf6nllJgJ5kvJoMgX334s0qyKyACxKJnrl7yF52VrLLHbF2yzNv5a045cZ0T9F/1eIxWy7GXnhz7O2Hsd3eMkW/zlVwhMQUKTzD8ACT3r3ZlnYrvbzTl/XiXX9ptUW1wGapwpqR1yKSo+gGpCC5FKmVZV/z2UaqAkglyvSgaUyPFeysIpbPpd/KIY4XNya82UaTsrlypuX+dGuLhigvbQYoDeJmqkhGUhGBBSWEWT8YLv8n+ahAIfLDuep/bMe6ISrJ080dlAdcy/Y+Ixg3QrVpDkCg+CWffGe/oLZ7trd/nenCXcgQVw5h60g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6121.eurprd08.prod.outlook.com (2603:10a6:10:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 10:04:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 10:04:22 +0000
Message-ID: <83a15a9d-8dfa-4949-b483-020bbcf0847a@iopsys.eu>
Date: Tue, 25 Nov 2025 13:04:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] spi: airoha-snfi: en7523: workaround flash
 damaging if UART_TXD was short to GND
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Shevchenko <andy@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251125021051.857159-1-mikhail.kshevetskiy@iopsys.eu>
 <20251125021051.857159-2-mikhail.kshevetskiy@iopsys.eu>
 <aSVYShXLirW--bYe@smile.fi.intel.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <aSVYShXLirW--bYe@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fcf89c-5741-4b03-d60a-08de2c0a017c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUpHb3E3OGJOQlVPM3hWb0syZmNnYTFLUmNCVHEvanYyc3hIY2tPZ0dRKzFl?=
 =?utf-8?B?THVoWEMybE5jdmRObmhHWXdEeHQxZm91NHR4M2ZnRWpSdUQxREhpQ1dKbURW?=
 =?utf-8?B?TEZCUjFabVNqblFjZkVBWWNMT3pZUmxmemZtd24ySTE5TVpuaFBXK1F5MFZ4?=
 =?utf-8?B?NmI4RHJBU2dDZkNzLzN1bXI4eXJjOFZtQ3N1S05wbzc0MTIyUVU2NFZ0a1pJ?=
 =?utf-8?B?eHhlK2VlSU5RZVhXU1VYdFVTaGYya1pqd3FhVWNzRk1BcldSZEpONmM1cHl5?=
 =?utf-8?B?d2FLMjkrWjlER1g5cURkL29jRExSQjFHREpBR1Vwb3ZNK2Q3dGFRd2lRSUor?=
 =?utf-8?B?SHhlRWZlRFhWMTJzRlBjZ2lNbXRoUkZ0Tm5adXh3M2puR0Jaejc0Q09yeHR4?=
 =?utf-8?B?TTBjQ1ZTTTBrT1pCa0pUd3NxMThvdXFvWWVuZE1RVFJYdzI3bk5tb1pubDho?=
 =?utf-8?B?LzRMeFFPREltVEJHT3hvNUs3bTlPNGt1R1lOVkpoSmNZa1JXL1ZTaVY4YjVn?=
 =?utf-8?B?U01uL1dJQk9mdzhCU3pnZWp1NWlxb2kyS1NZbm0rKzZ0MEdBeXhYWldPVUVj?=
 =?utf-8?B?WXNvMURxQkJqN3F0WWRKbjhhNFlJNmJzSHVhWkY4UURqSHFicFlmVURVQmc2?=
 =?utf-8?B?NHhBZVIzNFUwc3VpRld2ZHQvWUZQQnVXZEhlM2FPNUFwcFZ3RUY3cnVlaHRS?=
 =?utf-8?B?ZWhtR1NhQWxPekV0NUNSUXpBTU03NW04UjdiekZ1emI1K2RvYUpDNzVrbE45?=
 =?utf-8?B?aXVrbGxKaUZNUTRDMjhMa3Rpa1JScjJsWGxZMGZZREN2dFllK05rOXliZGNT?=
 =?utf-8?B?ZzliTk1uUTkyOFBZZkhTSUxUdm9YY1g1bEF3T0dHQzd4T3VsSFNDb2ptbERE?=
 =?utf-8?B?YWpPWnJNN0pqMXVGcktHVit6elhGZUcwVVEvelZXVEM5VHR2SUgvTXVrUCtK?=
 =?utf-8?B?WEx4MXVVbU5LWVNPOGg4MnNCL3NMUDNURXIvMER2cmlqb0Q2eFpaN2xGeTNM?=
 =?utf-8?B?ZTlYSlFpSjhlelFMSWtDSjNXMlBWZTJtaHVhK1NrZ2pqMVdBcjJDZHowS01I?=
 =?utf-8?B?azhPUXdhRkl0dXpHZXdWV0NBYkZNdDZObFhIY3kvNkVkc204em56dEhBNjdQ?=
 =?utf-8?B?a3FrN1VoaWptQnVsT3RqdWdWcDQ5ZHhrT1lKcm1ScVVEWDZSdU1uRDNPZDZa?=
 =?utf-8?B?RU9VbCtTRllVNkg3UXJwR1d4YXN1WnU4c284NEJpSkhuZWdieG4vOTVrSkZK?=
 =?utf-8?B?bE9kcHhFQXhuOEp4ZXpWbGpmYTZGZTR6dmNXVWxMdEsvNG5BcDRzYnZyeU5Q?=
 =?utf-8?B?b2ErRVIzbVJobW9GZWs3RStiRWZTbHNRRGlMcG9TSXpTM2Vzd2Y1VjFpUThl?=
 =?utf-8?B?YXRWU3pIRnVLSzdFcTA4Zy9PL0VhcTNBZU1OdTZINzJac1hhWk1RRERMN215?=
 =?utf-8?B?RTd4VW1icnB2QVc4aUJvWm85bUI3NTlFSGJWVHVDVC9aa1BGZ1NpQlpOTFZk?=
 =?utf-8?B?bERRVnlnQ3hsdWZ1Smk3NUtjZWkxV2Faek92MzM0K09FM1NDWHhpejBhQVI4?=
 =?utf-8?B?NlNhZnE3cGo2eDBjYUc0QncrZFRiRUtXbDc5Z2ZXMTRlN1gxZnoxczJvQTg0?=
 =?utf-8?B?Mm5BbUQ3aFJhYm1ZSVJIMWd1UVVvOXZIUzVVQm1kdWVlUEdoMCtkdGZyYmQ0?=
 =?utf-8?B?dVBaNVp0bFRlRFZpZ08wVWlJY0diSGxoZ1RyWEd3c3FpaEFUeCtqVGwrWk1B?=
 =?utf-8?B?b2NXWTBuZS8vUmpFR0dNWjdlTkFNSTdORm1FYjNaUWdDRkxZUk54T0hmNTgr?=
 =?utf-8?B?WGRXc2FsMEYyZzFvTVpBU0JLTTY3TTgvWFc3QkpMV1JLWW43TXhoSDFXc2k5?=
 =?utf-8?B?S3R2NHYrbXhoSFMybUZlTEN5b3ZvNVFSK2tXREF4ZDRVYW8xL3Z0L3JtN2J4?=
 =?utf-8?Q?oIXHtCYAclVhVzsx8PEbCNriO1fOxv9f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjJBSVlYT1VKeDcyTVU3ZzhhQmxYQjFacGNiNjNkclJVdVdqb1d6c3NxTjRJ?=
 =?utf-8?B?RytxcWNSeU9FTEJ0Wmt0NU94d29pSXRmbDIwL2VRZVhmTzc4WXE5OGJXUWNI?=
 =?utf-8?B?SGVieGljOTBGbjJUYjIyNEpXbEcwNTlpYUZoZGNlNWgrZzFRVCtZV0ZEOHB2?=
 =?utf-8?B?Z1k5a0o3TlhsemRmclNBWHpOdnBnR2hJWEVCYXNlellDS2x4bU44UGdOMnc2?=
 =?utf-8?B?by9QZTFPQmdBb01iN0h4RjNiOEhRTC9ac3VCSStEcjJFWkQ3YkxWOThOR0t3?=
 =?utf-8?B?RzN6MHllMmhDZDVLL1N4ZCtzUmNCT1o1TGwzcWxTQjIxbFVPWXVwRlVaeGpM?=
 =?utf-8?B?a0JBTngwajlEV0J5bjA1TVVWdUxJM29RMnlZczdkUk9ZRnhiSVRBdkhHZmUv?=
 =?utf-8?B?N2xScDJDcmtncnhpVEpUdE12SE1xRzBEcFFHd0xZT3gxSDdoNHUwbnVydGtZ?=
 =?utf-8?B?Y1NhUDMySVNNdkQ5cU8wV3lrelhsMHNxZ2d4allDVnd2cEFKcFhQSlUrOEJK?=
 =?utf-8?B?WThXdWhtcDQ1Q0Y5ekVZQVNnUHhadDcxeVdjbkdZR0xNOHJXT200bDVDNEpT?=
 =?utf-8?B?SS8yNTNpanA2aHBxZzMvYU9iYzJHaVlOMlVZVWI4TWNsUG5mZlhIdDhIRkxi?=
 =?utf-8?B?czNsd0syUlFRZDVjaSt2NjBBZjFkdWhTRm1VQUhPUWFxUDRVL2VBQ0grZ1Mv?=
 =?utf-8?B?cFdtSnhSek1VTFhINmRudk5ldXNzeWtpcEdtWWRDODlwNC9vR0U3ci83YkVl?=
 =?utf-8?B?alZxN3J6SmtpTGtlNGJXdHNhZnZIRFozbXA1TlU1Y2R5RWNITWR5MEFqN0Z2?=
 =?utf-8?B?czQ2Qk5RMUJ4c3VmOHVEbjZpMHdOUkc2K1NyN040MUh6eGxpRENteEJVcEVU?=
 =?utf-8?B?SHJmQzBLZ3lCNWJaUWVTT2pOanN2VHlZdjNoNTkrWGJOYndjbmhWOVZ6ejdM?=
 =?utf-8?B?K240ZTdLZDRia3ZWdnU1MVlwOG5tOVYwRng3NHJMK0t2SXp6YmRqNXBFNGlw?=
 =?utf-8?B?Y1M4alV1WkxiUmkydVd6YjVmb2RJd3F5RmtLS3p1dmN0aWt5OEwyOVF4RElV?=
 =?utf-8?B?ZTMxTURUV2F3S2hWTkM1S1k1TUNQL1p1Q2ozKy9SRENhS2k2djBRY2gvSHUy?=
 =?utf-8?B?ODBLckZjWm5zWUZXdFFWNjRaTU5zOTcwZkVPazR6enJkd2w2QlpPMHJJSTg4?=
 =?utf-8?B?eVFwcEJhd1RETWFBcG5FNXlCdGN2eHMySURTZ1kvRDlzVkU2Uko1Lzc3RnlL?=
 =?utf-8?B?Zk45Y0pNWm40b2lCYVJ5L0FpaWVxRXBRMElVakpLQnRaVmhYWkVqc1NWeDRy?=
 =?utf-8?B?ayttNWFxQlNIa1lKamR1eDVURXJ6bUg2WnpCYkZWMGxNZExNUkhhTlhVbXRT?=
 =?utf-8?B?RjJxOFc0NGtQWGU4bndPUCtsVmg2NHlNV1FpZkVBR0Q1ZmRlbFQ3SEVzMkcw?=
 =?utf-8?B?aTlRZmJTb1BKY0ErRS9meG9UR1QydjdwRDNtbEFwYWxUQTF6MnhkSVVNWkt6?=
 =?utf-8?B?c0ZOTlkwalIzbG5tdVNuT0s4WklPczFrMStlWW9CaFpuODMrS0ZjWEcyZjlV?=
 =?utf-8?B?VGRqSmF2cUExYWtXUG5jSWp6WUU2eXdEQ0pxbDAvVzltTzFXamZKTkk1OS9W?=
 =?utf-8?B?aTJ6NzRhMTVmMnJhb2FkbU5zQnVEQlZaUWhOWjhtL0JEcHFXNENRemVlUjQ2?=
 =?utf-8?B?WHpJRTJZbWUrWm0rTDllQW1QNEZXM0ZLMTFUZFBjemZvaUZoN3k1eXJhek1p?=
 =?utf-8?B?dFJiTEJVWXV6ZEorZEtVaUc0SDE0ZUlxckh5dEpKR2NCV0JRbE9FcVdVMXoy?=
 =?utf-8?B?bmRMWjNmUUYyeWNvUUk1SUwvTjg2TTlIbXVWMDlpOWQzeWJKQnR1OFdrWERZ?=
 =?utf-8?B?N3lPUHZjUTFMWFdiL3JLbEgzSEdMK0pmaDlRZTJlNTdqTjFCSUFmcnFPOFZR?=
 =?utf-8?B?TitYL1VXNTBIVjRuYjUvamsxaFpzMTNQejJWazczdTR0cnhLSzNuTkJxamdw?=
 =?utf-8?B?eUxnWjNIVy9HNXZXaTJMdGpDNzA2cE9YVWhFZGJocVFFUWJGQUNsL0JrN0J3?=
 =?utf-8?B?WHNYMlhkTGloYTJUek5SV3V3dDlCc2tsMlZmQmdvMFRmZUFkTmZHL2xzS0JC?=
 =?utf-8?B?OERFNUxHZTIwejE1NGlXR2tHdUVDeWU3RS9FQ09LV093b1F5dzhPSkdzeHpl?=
 =?utf-8?Q?C0rNVPDZ+egBQEqTJvIn3fw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fcf89c-5741-4b03-d60a-08de2c0a017c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:04:22.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8BECgfeQwzZyxfF+ZDrCrfveC8eCi+hUGb00sL+cG4qUQCPKidQcPxwyo6MvAofTWhkMy5GVgEhtpH/qhMDb7byb2PHDJZOZ1fHZjxwi6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6121


On 11/25/25 10:18, Andy Shevchenko wrote:
> On Tue, Nov 25, 2025 at 05:10:49AM +0300, Mikhail Kshevetskiy wrote:
>> Airoha EN7523 specific bug
>> --------------------------
>> We found that some serial console may pull TX line to GROUND during board
>> boot time. Airoha uses TX line as one of it's BOOT pins.
> I know the term bootstrap, what does BOOT mean?

yes, it's bootstrap pin

>
>> On the EN7523 SoC this may lead to booting in RESERVED boot mode.
>>
>> It was found that some flashes operates incorrectly in RESERVED mode.
>> Micron and Skyhigh flashes are definitely affected by the issue,
>> Winbond flashes are NOT affected.
> NOT --> not
will fix
>
>> Details:
>> --------
>> DMA reading of odd pages on affected flashes operates incorrectly. Page
>> reading offset (start of the page) on hardware level is replaced by 0x10.
>> Thus results in incorrect data reading. As result OS loading becomes
>> impossible.
>>
>> Usage of UBI make things even worse. On attaching, UBI will detects
>> corruptions (because of wrong reading of odd pages) and will try to
>> recover. For recovering UBI will erase and write 'damaged' blocks with
>> a valid information. This will destroy all UBI data.
>>
>> Non-DMA reading is OK.
>>
>> This patch detects booting in reserved mode, turn off DMA and print big
>> fat warning.
> ...
>
>> -	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
>> -	if (err)
>> -		return err;
>> +	if (dma_enable) {
>> +		err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
>> +		if (err)
>> +			return err;
>> +	}
> Why do you need this to be conditional? The settings of DMA mask should not
> affect the (in)ability of the device to perform DMA. I.o.w. it should not
> influence PIO mode. Can you confirm this?
>
no any particular reason, just see no sense to set mask if dma will not
be used


Regards,

Mikhail Kshevetskiy 


