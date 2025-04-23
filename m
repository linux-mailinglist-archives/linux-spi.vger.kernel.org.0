Return-Path: <linux-spi+bounces-7723-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17BA97EDF
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 08:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7154516AAEB
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 06:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8562F267AFE;
	Wed, 23 Apr 2025 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZXMGYeor"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46317267AFB;
	Wed, 23 Apr 2025 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745388643; cv=fail; b=uWXFUc+2ahAwKL/LD+yRUBgWVk5Vxo12h1zjbqehc1Faif8mQiNKbseTiSQbjJv6MxDzfqKR/JVfkeYFsfc9OSMsOW0nWreAgqIH3cJEtStVN4htWbYXhdods/Mr6jNxcYDY9q6mpkL9Tw91Xoz3Bi/mgR0JYQ0jGLo7U7t07cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745388643; c=relaxed/simple;
	bh=7OEu7aDcTNZBTqlMwR1UBHg27fDe35Sf0beeYZ/xMGg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=e1VWrxIzaqRoP59J9SQPu+C/qj8qh+LBbiqHxN3qPM0VIy1LSTnkivjdPrnQSz8zIiiHR/Gdn0Z3e16V48R7H3sSbWPDYwxrYcAkqQvnXrw4H/0Mmqqz/Dvc81y82RR5a/sY6dwW7/lOlo0Axkv7/hUoJ0gjG3Sb5/kALtv2eFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZXMGYeor; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDfS0sbZRwiS3A/Cv5ygHocXteAan09zYJ42YjNNAwr3LRaMQDhIwcefj6BgImEtfG3wj1QGzVqCJTLPjJs9R5FILgagHUODUsSFzuAg/HdAmvRKpRFtI8S0OpXBo7vm2BlJAlVhrYWD1r4yLyH0wTMojrMipdoXz1yXtZUIYbLm9/FkQeMKWiXTKBdueGe6hLES8AfzQs0a7ewi2z1TJn+F4Vh7ONtCgbqq5jc+js1MjCZak2n4ucgqLm1dyqMlndFbiaSVkqiCUYpS6MW0bcDrQgUmfFcvaUfVaXDz8G+awZG3zxbF3hc+l38JVvRvbMe7OrfVCc94X80Zg3wNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o13BacnfkHfvICZOS7uGaToiARqOiA3zTd0p91FoY5U=;
 b=W1M3v6jIHPi70c2OetQJnlKUyb4VV41jqd+G5qd2d8xN4zo2jafVUOnkAM7ckhHQvuWqfEIE7WIndT6JdlYH6WZm9khaae6HviAuU+0UwSlsbtqeNGSZ8Th22T32hoJ67ns1apMhiIS6OyiAlqpiV9MTY4AO18m6554S/18Km1l/oY/3R7xSndBVLDgPhSil+jbsrwuvnlnFZfF7VNr1wvG37hbXR5LTPOBChDXzMBYY75R/Kf89lDxe/HvOCg6btZHc62VWuHFI8Rh87PlARa828ZS6AMCSkBWdnNYS9ZKJwV1DPL253nvtx+t2krFBtUpeBvcP3hCCATI6T3teDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o13BacnfkHfvICZOS7uGaToiARqOiA3zTd0p91FoY5U=;
 b=ZXMGYeorAKdt2e7gueKPGKjjjRz0/GijS+mys/6yveP8gSkHDOVC17qQNFnbcj/xtm3YAiWZl19J/ZSkXVqVBjeoNElq1nFgSwHRm09+5oZHSXTlpkE0fnyiFFx6YbjDY1vDUWn2x4sswxcWdf9+dABBaJI+u9XjA72IUjQEMXLpdebGINnlja0DAUiwUoS/O31kF3F9RQ11SW+zWJz27YpmtA9fnW7Mkf0vV4Okri/nBCjK/OIwPvsjZZ8ZRg1vmoCYpV3jMbtFyo1MsDQXNewcRzN7dmTRHMaRMHY35n6ACHNt4ZepoT5giwpA94+8w3nOfyJMu3/bwxBhLwLDRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB8734.eurprd04.prod.outlook.com (2603:10a6:102:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 06:10:40 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 06:10:39 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 23 Apr 2025 14:11:42 +0800
Subject: [PATCH v1 5/5] spi: nxp-fspi: use devm instead of remove for
 driver detach
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-flexspipatch-v1-5-292e530509d3@nxp.com>
References: <20250423-flexspipatch-v1-0-292e530509d3@nxp.com>
In-Reply-To: <20250423-flexspipatch-v1-0-292e530509d3@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745388747; l=2545;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=5lL3LkkHmuY4xCbvDZE4rLc6eGwDA+AN+svgFhE/Z0E=;
 b=dvVqBSVsVM6gA6pofZtOCSTmB4Yp0+msTRgw1GVzFFXXZSnAJcpsv4HKWt4oS2sYUekhyMHpW
 mHun2Qgh6cODT7pD5t7qzWIcEh81iomb1eQKA0YcE3GR/J6N7H8N6gV
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAXPR04MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea4d4af-a3dc-4c0d-76ae-08dd822d9256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUNlRzJZZXFjSjBSaGFzLzNiR0dSQk51bERaVHRPdnZhNit4eG9rY0dkd0ln?=
 =?utf-8?B?ZGdGZGQ0cWtvbHlCeitLb0RrUWxURm9ybHV4RUFWTFp4UTYrWHhGU3VKWkJQ?=
 =?utf-8?B?VjFrcFhGSWhjYTlpUWNzTkc1bGQrVVZSNnh0eU1XS0VBT0ZNVko4a3dKY3FG?=
 =?utf-8?B?Mk5XcEU5SHM2ZjVZc1FHRTV4ZFMzQU16N1pnMVpmTnU4Y3Q0UERseTA4cE1O?=
 =?utf-8?B?cnNHYm1pVlJ0OUk1VjRrT0FuN09Ga2ZjMTk5OSt6MndKRHBPakd0UDliVWs3?=
 =?utf-8?B?KzBlWElqcVBwSHhUZ0pGbXFpUkNqaGtEWlFkaERkRXRPZ1NSMmRlR3ZjTkpP?=
 =?utf-8?B?NzZ6QzYrY05HL3V1L2VZYVA4eVZyM2NnMTZTdFJSMzZqZ2xxcVAzUEVzVEx1?=
 =?utf-8?B?S3pkSSt3ZHJ0UTI0Z3d3V0c4TjVHVXhBVENISzVKMElCb045QUhjd0paandC?=
 =?utf-8?B?QmtHMWRCMSt3MlRJMGlwZDQ0Ymsvc2xJS1N2Y3lqM3NpcHJVQm8welloWmlM?=
 =?utf-8?B?VHA4cVpUVzdWd2ZvQVg5SEY5c0hnN1B3VXQzQ3UxNGZyNEdjL3dORWVxM1g1?=
 =?utf-8?B?My9aU3NtM3NMQlpsZmNYK0V5cEJzOTY2ZkNxMlhRQTZpd3B1YmdGRVg4ZzhE?=
 =?utf-8?B?UEtzZGM2aFhOSVNwdmxOUGRNdlUxekJBeXZ6cC9ia1FCUHhXYkFPNmpqVjdp?=
 =?utf-8?B?NVNLWHZ3TmJqZ3FUb1VSU0xwU0FQVUd5cFl1alRjcmlGQmVwaU9Da2paZzNs?=
 =?utf-8?B?UE1DcGxNNkdhQzhKL213QzVCRS9haXUzdm1ycHQwR0lzdmdaWXdVMkJJbnVn?=
 =?utf-8?B?d2FqQ0RGSTE1QXZXOFBMR1ZRdDRxZlNsT28xM0tFMm5zdUJhNkZyTFZsR2pQ?=
 =?utf-8?B?MU9OWW1FNERxdWZCSlIrK2hxTzlBK1plRUlQRVh3TFZEVmJ4Z0U4QVprcWVz?=
 =?utf-8?B?aWg1WlVJdW9Cd0FTMTNTRjJES3p1UW43NEFZSFpqWmdkeFhPNkJiU0NQNVZN?=
 =?utf-8?B?c3ZqMzBhL3J0eWxaVWxSMzlZQzd5REY4bEo2YWc4NjJDSkxOYXgrd2JzWm9t?=
 =?utf-8?B?VlhOUDBBVkI2aFVwNG1ncS90cGh5T2lPNnh6d2JnbnBYbzdkanppL3RzVWVm?=
 =?utf-8?B?RVJ5b2xCbjlMOXV2TXgvN2tyS1VFTU1WTmVPWE83a3ZWa3BpRUVGSEhUTk1t?=
 =?utf-8?B?eFBwQjNMbjh0TzdSMWUzSjM2WTRnWkxJN2Q3akxwSllIdWdtTGd3czZrR3J1?=
 =?utf-8?B?UEJic0wvQlRYSWw5R1R6Vjhza0JUZlFtOHV6TzNzcC9jS1BTcHd6ZzZpWXRz?=
 =?utf-8?B?Q2VKcmlqWENyaUVqakkybTRHZy9FUUp6NDN1YnkzUEZLd0VVandkYUEvU0xG?=
 =?utf-8?B?T1RhYjNVbnJXUWx3dnVLY0xUMTBvK1dqNGNKbE4xanVwRExkdFV1MElzTFFw?=
 =?utf-8?B?SmhKb0sxMnVxa3NkdHBRN1ZBakEwcmhOM2czMnVWZEVLeFJINGI2MndZR2Mz?=
 =?utf-8?B?bGUyY3h0bEZGbmhHQ2Y0ODUxRVZZWXVoR2p2NGZXQ2hBMjhXaVMxYlNFb01u?=
 =?utf-8?B?RXM1UTNBUUptUlhJaGdLSjN5K1NnaTdEMk5yOE1kd3I5L0d6cGJ1N0ROT0c2?=
 =?utf-8?B?amZaYmJDWWlucUdvbzJNRmxKRFFwZCtmb1I0Nlo2aFdrUEduNXhsRVByaVMy?=
 =?utf-8?B?L0ZSdjZmZGhYQnI1cngvNVhKWHJ5VSs2RTNyZmJCTDBQYmx3dkJveHZnS1Nk?=
 =?utf-8?B?UXJKSkxFNnJLUzA3VnF4LzRPTWJJYmJQeDcxSEkrY0JzMVRMY0QwYm5wVEtZ?=
 =?utf-8?B?Y2puS0JjQnNPb3FHRHhJRVhQcld1U3B2WE9NUHR4T3dwazdwMjNzRXpQUHBN?=
 =?utf-8?B?bEhPb05uLzdQakV1T2lGN3FaMlhnUG11RzlIdEJRZUhpZzF3ZTVGYTNIdm84?=
 =?utf-8?B?bDJjQVMyb2RPSHQ1c3Ftd3VrcERKcEwvdHkrQSthVzRRV3hMTUpQdmpRVGZ4?=
 =?utf-8?B?Sk1lQk5DN0VnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1FuSlVsd2pNYnlOR0dRaGV2V2lCQ0hEWTJOZGMvcFloR3ArMlo4Qk81V0Nx?=
 =?utf-8?B?YklubTg2emlsNURtaHBueENNa3BrRWpmamRzTzcrWE9NbVQ2cDg0MUUyNFpY?=
 =?utf-8?B?OUU4VDZGSkZIaUxEaGRORnptUXErekV0aFdGQUorNmV6QS9WZkpScm9oS3ZC?=
 =?utf-8?B?bllpVDhqMjE5MkdYWGYzanhiRXVyS0NmVHNzVDVZQnBkOWZxRC80aDg2TzFD?=
 =?utf-8?B?QUNIeHV5NWhjbWNMTnp1RHFZRUFGN3ozQ1pSdXZoM2d0WGlKY09ndWNDL1BI?=
 =?utf-8?B?cUFnS2VpUFRhMjRzckRwZVAwNk1jWmxleHdXRmpDaVFpK1hCM1RZUnFRSFUw?=
 =?utf-8?B?TEpIdXViMUtrd21COTVYMlo1cDJweEloc1VQYngrdk5wdmE1bTN0MW5KaVA1?=
 =?utf-8?B?Z3h3NUVjMi9COHVkMERGeXlVSGZlQ1VWV1lmY1BRVXQwbzZmL0VrQ1RENVZQ?=
 =?utf-8?B?K2lsaFJBNnBtTGkwV2hhWlVyZlZLODZ2TitnNSszdHFMWHhvQjZYcnc0UDJq?=
 =?utf-8?B?aHcwN1ZWWXFDbTBJakk2SmxPTDR1cmhabXQ4TkRYMGJuZmhnS0Y1UUErOER1?=
 =?utf-8?B?S04vVXFVYUdFY25IUWp2NTNseEwvWVo4WVo0QWJLUWtpMHY4UElkSSs2MDQx?=
 =?utf-8?B?OVU5emxjTGs1aTM4ZTJXOENUeFIwTXhVazhBYWxsYTdUMy9NeWJCK0hvdEhK?=
 =?utf-8?B?QTV4eEtmekY5SWkycUN4Mi9wL2t1L3ZlZHZDbDMvRG9qMTljNTZoYXVJRFJB?=
 =?utf-8?B?bnJiRUw0Vjk5RlBiWVJDRE5oUmFFeXZjdC9wektZK3Y2RzB2NjE4Tk1HTjlE?=
 =?utf-8?B?R0lNbGpmRGJLdUNIZ1l1UTBUMklzTEhOSkVxcDcwejBWeFc5NFRpMFloc0tk?=
 =?utf-8?B?WFdRWjdrRCtDT2dWbmxva2xVcnpjTis4UjBTeVUveEJOeWt0MFJvQnhvcFpj?=
 =?utf-8?B?dGU4L0g3QTBIVEVPR21wbDNMQ1ZLRy85RE5YSlNnR2wrWHk5bWdJREJwTnhE?=
 =?utf-8?B?Nzc3K1VGTTFOVTR3anl5bU1TNGZCTXYydCtvL296a1Y2c28vSnYxaTgxRk1N?=
 =?utf-8?B?bENsTWNSdGtFNFZHbkZkZDRLOHdTdGRMVndWTHdYM2NybmJ6dHRKL0JlQ240?=
 =?utf-8?B?VjdtME1PeC90dGZlNnJVVVc5NnJ1ZmFiL1lkV3FkcjNsSmVxT1BNSE10YllZ?=
 =?utf-8?B?TDFhWVBsTmNIRnNPbVE1ekZhRldySXdRMFFLRUxFV2xuUUQvNVMzLytJYlhM?=
 =?utf-8?B?dXZXK1J0eEFiNHhzK2hhVS85YUdzaktGVWF3MWd3YmxRM1pLYnoxTldBWVA0?=
 =?utf-8?B?Tkl6cDdZc1AwOGRUUEV0TWdLSlluenQwMm1TQjlaa2ZKTGFaTnpOb2JaYXpB?=
 =?utf-8?B?Q082N25LSkFQZ0I4SHBDeEZIOWVmeGNSMzM2b0FFNnpvdnZSb0hKOGx6RlhR?=
 =?utf-8?B?c0ZOWFRrWXBFclZSbnVPdE9sRDRxNmxpT00wYXdQVnlYcHdpMjJVZnNpS3Ni?=
 =?utf-8?B?K004c3ZUdFNjSGt2bHdNd1JpSEFRK0NSOW13d3krZ1Y2UEtoY295Y0ZUS2t0?=
 =?utf-8?B?ZzNaY0dqMGFUaTQySjVNUFlCVFoyS2p0NmZRTUtTaWtveFlWemM4WngrUkVu?=
 =?utf-8?B?cEFjaXY0Zk4vUVpLeW1nVERCUUhVL0pRSm42TUpqc0hkQXpPQ3gyaGhPSGRu?=
 =?utf-8?B?MG1mb3B4NmljYzMwaGdVd29uMHZ6WEs0TGovZUVMNkM0UjU1ajBEaDFOdFB4?=
 =?utf-8?B?ZnZKMXhpQ1dQeUhTR3B0M3ZwNEpnbmF3SHBYTGFkQnR3dFRKVERVMVpoNmpL?=
 =?utf-8?B?cmVuY0NtWVViMnMzUzM0REpJdmdGaEQ4UGhVQ2Rza1RUakNlTDlBMVJCakNI?=
 =?utf-8?B?SWFVbHpNWUt1cEVReU94Ri9nYzAwY3BNL0NGWnl4OW9XbW5tUkdlR3VPT2lj?=
 =?utf-8?B?akVEcVZOVVBkM01CK0FtZ2E2Z0FDYnhmRkNwLytvbk5UZXJLeWNzMnp5Vzkv?=
 =?utf-8?B?bGdGRGQ1eXMrYld3dGMyNU1MVGZrNllzSDNVMWFwaFIzamw0YnhvSjl5MjV3?=
 =?utf-8?B?TVIwcUFuc0p1dUFibTZKSFI4RmNNeVp5ZnFuT1FFYVo2MkJFQVVuREpQYWNK?=
 =?utf-8?Q?djeiEFkopeNDaFkKVZesjyKRU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea4d4af-a3dc-4c0d-76ae-08dd822d9256
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:10:39.8848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBXUmXc0IxxDGkzHr9Z92WMUKnPWkGxpxR9fwWm4/wmX6e2BUo0YIX9a3mtkSxDols3ro/vol/zg0vCnqmoEiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8734

From: Han Xu <han.xu@nxp.com>

fspi driver use devm APIs to manage clk/irq/resources and register the spi
controller, but the legacy remove function will be called first during
device detach and trigger kernel panic. Drop the remove function and use
devm_add_action_or_reset() for driver cleanup to ensure the release
sequence.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 45d7b5fd9230ca122a61fe66a6e05dc4f823444b..497902acebedf37bd6b4f0a5f5f6d8a1591543c1 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1168,6 +1168,24 @@ static const struct spi_controller_mem_caps nxp_fspi_mem_caps = {
 	.per_op_freq = true,
 };
 
+static void nxp_fspi_cleanup(void *data)
+{
+	struct nxp_fspi *f = data;
+
+	/* enable clock first since there is reigster access */
+	pm_runtime_get_sync(f->dev);
+
+	/* disable the hardware */
+	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
+
+	pm_runtime_disable(f->dev);
+	pm_runtime_put_noidle(f->dev);
+	nxp_fspi_clk_disable_unprep(f);
+
+	if (f->ahb_addr)
+		iounmap(f->ahb_addr);
+}
+
 static int nxp_fspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -1263,25 +1281,11 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	ctlr->mem_caps = &nxp_fspi_mem_caps;
 	ctlr->dev.of_node = np;
 
-	return devm_spi_register_controller(&pdev->dev, ctlr);
-}
-
-static void nxp_fspi_remove(struct platform_device *pdev)
-{
-	struct nxp_fspi *f = platform_get_drvdata(pdev);
-
-	/* enable clock first since there is reigster access */
-	pm_runtime_get_sync(f->dev);
-
-	/* disable the hardware */
-	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
-
-	pm_runtime_disable(f->dev);
-	pm_runtime_put_noidle(f->dev);
-	nxp_fspi_clk_disable_unprep(f);
+	ret = devm_add_action_or_reset(dev, nxp_fspi_cleanup, f);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register nxp_fspi_cleanup\n");
 
-	if (f->ahb_addr)
-		iounmap(f->ahb_addr);
+	return devm_spi_register_controller(&pdev->dev, ctlr);
 }
 
 #ifdef CONFIG_PM
@@ -1363,7 +1367,6 @@ static struct platform_driver nxp_fspi_driver = {
 		.pm =   &nxp_fspi_pm_ops,
 	},
 	.probe          = nxp_fspi_probe,
-	.remove		= nxp_fspi_remove,
 };
 module_platform_driver(nxp_fspi_driver);
 

-- 
2.34.1


