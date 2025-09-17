Return-Path: <linux-spi+bounces-10062-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB06B7CEDC
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 14:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EA41C05774
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 07:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E03016FB;
	Wed, 17 Sep 2025 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eWqhTCZM"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03392F747F;
	Wed, 17 Sep 2025 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094065; cv=fail; b=CkIwlANutOEh4fBT/EUe9VfCWIDJI0vZ1Nsp48t3lYHnyCl717ZM0F0yNjUb+FCihegrMEWGP6Maysa7aO7OTui2Jh1IxSeZFREF2gX3bJhvcP5MoLE6jV5472c2klelEEWB+uDti7t51l4lSADCHCjckfK/HWi1crzheHIxuYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094065; c=relaxed/simple;
	bh=DvByLpqUfbVxLGbVFGdqzSQfGHY0MfJF2DFSrJLtO6A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ieDMOrze4EH8fhd6nSB8YIsOCfQ4aPLgmgZgmRkyMg2KMuAXcTbAO8cKUkOcOxb6mSoW7iNKw2ta27CBdBc6aRwRMnjAKbl+u/j/iQUBD1ByTlmF8fsK4JrhT6R6AnC+pWTbvHZSVXrlhwXm6doWgcBJzdo7hfY67H7UBpVdjJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eWqhTCZM; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDuqs7O5UstVyf/7xze7TeERZ3J0k7usBIK7CUP3QZMS617Qgd3nHNDNXUtzrfZMTshEztfTEwmr0VssosgoHwpW/0IcQ1B/Ut5nbdOxiHf/f0r5wCmU6q+G9RK9okjoSqwmYLhfzgYKS06NP37+jJXO27hP1hRiAmqZvoX6GICN3FAHRJyUCkAiLiA+GgMjJLuFMLxM7c294gX7Si1AJqFFklRjkX0rmRLh1mEF7KLT/1aFSbJwUiehqtdRb3EaqW0K5ASje82jg8DdltAgjG1vTQ4O8XXLIRSWzPUY48WF2hOjgARj9A9OrqaITpAlfbUfwQsJv0uEUi++oXa4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6k7eNK/49HO/MQ4N989TMDKWKdkaHhbvl4HgCzVskE=;
 b=YwhdszqtYQXYitVmJEhiK+b0aFvdMvbgSW+vNzNGibYhH7NIx1v9vnSHoN53tEXyxIRJfJSht4NUOUK0Ve0KlxHPVpDQdbnQUnLQ9z6pFUsyfsoO7TPCmjxBSmR/yKCk5WjJsruI1mSccsiMtRl7onQRyYgD9VLt/5lXCV0GAL0IcsWpzvUuBN2lvpBwemFt6sIB96iNKCwUf7Dk3Rh6c0iC8Up62sF3+IS36+f65OPr7vOPddBcVuErWPWH8lCSoz5w6GT02PB6x/CpUHkkeVluQhtcypVQZvsztxxQtA4MUpBgAVyFmcEpTWhoi6ADROlK0A208vWaR2nsR3X43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6k7eNK/49HO/MQ4N989TMDKWKdkaHhbvl4HgCzVskE=;
 b=eWqhTCZMZjYt/xZehgzEMHA/ZLeOsageJ65IymeU0ITNCQwTgMa2IhdV+dYZvSuX5XMVqksSfx0BXwm6Ar1Ky+aAJ5pqgsE3+LRHSzWfwuWZJOuPR7YhU4LTxLXKO6Fa9/fuJ7H731vZUhJc1DHmEuJN0SNdd1Y/MGv459r2KMTlMV9Kalj6WWNPvJRRdi79uGH9zXTT81gLPq54+rNFdo4Ut6Ry6XxjEDaCDKXwKoEtU0oNJ0bbB7nbE1dMWyHBvsdFztXdyudVfD+KQpZylCvlpOaJaTvaEa+/3sbz4kt9jXAKI49m363nDsdOpUHTXJ6o5GcykKgjt4LNBfqW+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10800.eurprd04.prod.outlook.com (2603:10a6:150:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 07:27:41 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 07:27:41 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 17 Sep 2025 15:27:07 +0800
Subject: [PATCH v2 2/5] spi: spi-nxp-fspi: set back to dll override mode
 when clock rate < 100MHz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-flexspi-ddr-v2-2-bb9fe2a01889@nxp.com>
References: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
In-Reply-To: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <frank.li@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758094070; l=875;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=DvByLpqUfbVxLGbVFGdqzSQfGHY0MfJF2DFSrJLtO6A=;
 b=l2yyC2rJ61nThyNN3yP3z664DqbWrbCSGBHrzz712CitPw/q/DwRiBQHNRDvPUsTu6UUj+NtR
 ZjRc+2YxVAZBijEIsBZUnnHymALwuzFa43KYwZgG9J85EVh2FN3gMqS
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
X-MS-Office365-Filtering-Correlation-Id: 58f8e7c4-138d-46a9-299d-08ddf5bbaf78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXlhQzkrdjZoT2NBcjZKVjlMZXhOdlQ0ZnJqczhmOHBlTjNZM0diNG5QcjY2?=
 =?utf-8?B?dm9wZDdieWFBSUNFcTh1YXFOR3o1N3orYTEwRnZzRE9PakxPOWFuYXdHRWdH?=
 =?utf-8?B?N1ZaLzNwaDB3M2pkUUhXWXJ5SnNJZlFuSGV3bis0bTFPQVhoN3pyMGlNNXE3?=
 =?utf-8?B?UEZYNFpHVTl3MkIydGVjQk9KVTZLVU5iWDZtdVlUa3JQSE1YejhrOWN5ZEs0?=
 =?utf-8?B?cXpzWTJSZUFmMmphVG9mQlVWeGU3eVRGTHF4SVQ2ZWRhUml0OWJMdFpEc3oy?=
 =?utf-8?B?QlV2NVNRc01xTjR0aGpaM3dSa1hiRytkaStvek9RVERLOThUS3BwZW9rbFEr?=
 =?utf-8?B?Q1NIcy9XVjdnckhqaHZSRzZYM3RUeUpuWlVyak1adzd4K1pCcURoNEVJcWZW?=
 =?utf-8?B?a2lQeFU3S2NMeFAvSlVlNzdRY1o1bVVCa3BDWnV1NlFaVWlPUm1WYkdtNFFa?=
 =?utf-8?B?aEhsU2dwbVlVR3hyYU5NOFBGTW9jVFhFUmN3c04yZ3RpT2VqTlNOT3E3Y0NC?=
 =?utf-8?B?bTFlZ1JFb1dCajB5NlJVaTdTbVNkL1l0RDF0WmlYVWJEU1FmZ2gwS2QrQk90?=
 =?utf-8?B?SnQxTW9yM0N0OHNhc0VXRkszMXZKa3JIdFhlR1BWd3VDUUdZOVdnMVd3Y0RR?=
 =?utf-8?B?Mjc1M1RBQlhzeXEreWl5cS9yajlVS3ZER1NmY3dKYmJyZXZGRVdFTmZmaXdH?=
 =?utf-8?B?VDdWVjYraGZWanM0cW5tVlprcTQxTEltR1ZpSWlGK2gxUVhNUHpBMXBkRllS?=
 =?utf-8?B?TlJyTmY0cC9ndzB2WkdITWRsY1U3SjNIVEMrRzNmaXZxN3pjWDBLdHNDeWg2?=
 =?utf-8?B?TFliYXhQOVF5SXhYbTFwZlVaSlkrYUZBbjZQWW41c2xHNjRiYmZkWXpKcjhs?=
 =?utf-8?B?MHMxdkwydTdLTk9RenkrQ1MrM0Y4VE5jbjRveWxJS1dJUndYbW1seG5hd2kv?=
 =?utf-8?B?eGZtb1FyaGQ0V3VRZHFwVjI5aHpJTnNncVhNTXd0TU5KVGpZKzkrbmsyeGo5?=
 =?utf-8?B?U2hSbUhHeUh0VXJWMElKVnljSEZMZG9rTy9tRXk5aEpCcUN3VzVmQllqcXJo?=
 =?utf-8?B?L2VsVkNldTc5aUw5U3FPMyszQkFZNjY0ZXpjSHlmOVh3Q2JCNEdaTm5Uc1NU?=
 =?utf-8?B?QWdxK29SdmJyTE96R1l3UnBvYTROQTUrdEY1dHowb3MzeWZ1andBdEN6Mmh1?=
 =?utf-8?B?aXVmRlFEK3BqWXJwelZBRmc3b1Flb0Fyc0NLNXBmc0JnWHJqRVBnWXFFVlNN?=
 =?utf-8?B?QzQ5UktxSXpTWXFGaW5mdmxPZWwwRy8xTWRyZGxqb3JQSTZiRGgzdXBJdGkz?=
 =?utf-8?B?b01EOVYvUUwyM0xScXZuMFh4Q3BVblRoT0R6eGpQTWJibTlGQUxaYlFadVhK?=
 =?utf-8?B?VWk2Rll5eVhEY0IyWWliL0xIZExEZ2hzYkFidmNHU2FjQXpSd1psWURneWJo?=
 =?utf-8?B?NzRnVmxCV0lkZ0YvKytMdkc1dFRXMGwxVVI3Tlg0bGNDcExKMk14blFKQklH?=
 =?utf-8?B?dDV0VUVyTi9oQzFYU0VsY2hhN1g3Y1NxemNoRVBrWDhxdEJpL1ZOeHVFVklV?=
 =?utf-8?B?NVk3Njg1MDBpTG00SmdWajE1QldwTEwxRmFYdW8wdWpBdHBrU3FKRmlISGZN?=
 =?utf-8?B?WTFWanU0QWNJL0VLcG1CYjVNM20zcnMzZDRHS0ltUFlSbTYzUmJkQTVxQ0Ey?=
 =?utf-8?B?WUxyVVkvTlhCckFnOGF2dVY3b3UrOTdoc3F0UTJhQlZxaktRNkVHVG96OEhI?=
 =?utf-8?B?Vk9EY1hoVG9hYnlYRWZQU0NkQ21nUW1qTmU4N2QzSDYwTkptQm1zazdpbm5I?=
 =?utf-8?B?ZllQL0svTFFhT2tIQTlHYm9EanBDYXRNTnZiV05xK0JiNC9SNnV0QXNVdytH?=
 =?utf-8?B?TU9WYkRFN1Vzejc2VjlQTmFQQ2NiZWl5azJzeGtTYzRvOC9yTWpiK1dRUHc1?=
 =?utf-8?B?NnRaYmdDQ1NseEswR3prT2NWdTUrTG5sZWY3a2lRelFiam1SdkROOFoveUVt?=
 =?utf-8?B?K1luTGhWY3BnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHFJaWdXdGVxa0hhNjQwWTh3VVB2RUQ2NEN1WWlxOUE2d002L1JCdzZMVHl4?=
 =?utf-8?B?blRhZkFSdTAwRWNxKzFheW52cGJtV2Z0REtuaWRQMUI5VHhDN0FTY0tUV25k?=
 =?utf-8?B?WHZ1cnEzS1RQMHR3UmMxSm11dnFhblJCVzVKYVMrWmNhVWE3cThvT213Rm43?=
 =?utf-8?B?QnhDaS8rYnhVTG0yWnRSaEdnak1KWG4yemhuZWNlSHpuRGFqUFhIZjFMSkVX?=
 =?utf-8?B?U3E2dGRmdENqVkJYVVhYMjV5WmRUb2hKVjYvNExpSkIvOXBVWHZOOUxtQnBs?=
 =?utf-8?B?Ry9CbHl6amI2Z3pvdWNOV1JJRFRxTHdBTmtTRlFZQXlqa2NFUnlCY1p5T1BR?=
 =?utf-8?B?RENoR0R3R2FMamQ0WUErME5uTnYwaldzMnNTTjJxclhwWFhPOXFzSmVFNUNT?=
 =?utf-8?B?bm1hK1N5NXdqNitzU3BPRnBpczA2eldOYzhSemJiRlk0NzRlVFd0bU4vcFFQ?=
 =?utf-8?B?bnlraUJDOXRNdFlob3EzRmVCY0ZqMmw4M2x3Vy9GYUdheEFBRU5jMVA5bXU0?=
 =?utf-8?B?QjRIaGVMRTNrRGNWai90YzFnN1UxazhQaFZQamdlRldxSnRqcTJzUVMzMmpJ?=
 =?utf-8?B?WEdXdHpOa0NPREJwTFdoVmVzREdsK3Q4a0dCUnJ2KzRCZlovR0lETVpCQVVV?=
 =?utf-8?B?eHhWcGVPZ2dPTnV3UFRTQ1M3UTdrelJQOUpocnhodzdEL3l6U3I2K0JzR2hk?=
 =?utf-8?B?Yk5BU3Q1dVZSQy9xTFp3T2pTTDNYS3JHNFN3bGRUN2YyOS9aM2ovaTlvNCtw?=
 =?utf-8?B?Q1A2cWxXbkw0dlJRRFRNSWtOTDdQL3czK0ZUS1JaVXFtdjUwUXZlYXJFVTNT?=
 =?utf-8?B?US90LytXc2dyOElRVnhLdm1NOW1OdXpHeVh3MGVabEVpaEJYVklpbEhzSVI3?=
 =?utf-8?B?N0t4YmhzVVhES3J2bmZraThJQzN3eEVCRVZpWkFxSnlRYVpVekh2alNtRUlP?=
 =?utf-8?B?TTlpejBuem51dUVQa0UxMUNTdFd6VmtkYWhCSjNwYnpCYjZoNWhtZXlmT2JV?=
 =?utf-8?B?elhqK1dIOHFDNFJJM1hJV2ZRMkoxdi9hT1NqR2MwaWRxQ3hOYzR1NkI4ZWlq?=
 =?utf-8?B?bTFZUGhrQWtRMzkyMjJiOTBEL2xYSFVUZXZiM1M2UGRHZ0hkNHMyWUVEWnhX?=
 =?utf-8?B?Q1p1bGxKaVFueHViRWpweFg2ZzU0UURuV2dhamtzOVQ4K3grSUtVSjZnUkJ2?=
 =?utf-8?B?M2dWSmk0dHNYZ2NZRit4elV2OGVuTjRROUwwUDFTNDRFblBMdXc2VmNlQzd5?=
 =?utf-8?B?cHZxWURveHlCcFFZL0p4YlQ5b2tSSXhnYlpGdExBazl6WGlDLzlkZHJVdkJt?=
 =?utf-8?B?b2pRRnYxNVB0VTdOSExJQ0swYm45Z01jWUFJWm9UUmlMaTlJalE2L3pFVTBQ?=
 =?utf-8?B?cnQ0YU8xSzRGcmlwcklrd1gybS9VWjJrc3piL3BSRlBCcEJxdlFXL3c2azg0?=
 =?utf-8?B?L2tJRS9ndVRpTmpmYjFCVDFid01rUG45eWJLOEQ2dkIraHRqLzdueVdnVExr?=
 =?utf-8?B?ZDZmblI2Y3V0Q2Ira1JqSForZVhuQy9QMjE1OEFvT2pReFJ6M1JIV0VBOHg2?=
 =?utf-8?B?cDRzWGJyOEJYSm1ZbnRHUkpnQmJKL1d4SVg0NTdkR0NPeXFJZ3BWUnJYdWNC?=
 =?utf-8?B?SnhIaDU2eFg0VVRHNnFwM0hwdklyQ0JMZkJUcGx4WTlMS0FaMEkrN3RCNTA5?=
 =?utf-8?B?RXFFWmViRDd2ODhmdmpqNThlNG1ZbWwrdVJhZmU2SDJlVHpjQnlYM3pLOUMv?=
 =?utf-8?B?TnNrRDF3djBOQi9vcEg5Wm5NelV4b1ZKNE8xZVQ1ZHZmdU9WL2d5dU83ek0v?=
 =?utf-8?B?TEZGdzVzVGo1blBGS000c0JJOGRUK0pCRWdSSGVrMFhKMERUaDd6bVEwQ29J?=
 =?utf-8?B?Z1k0ckx5cVlWNzRUSU01NkVsRUcvSE4yUHV5a2c4T2h6UjUvVlVYWSt1ditv?=
 =?utf-8?B?MzA2MGphTE5XbmhOaEp4WDJXYW56QzQ3Mlh4NVVIOTdRY2ZhS0owQ3RQUzNm?=
 =?utf-8?B?QUFlWFBZeFdSbjVwV0cvSk1RcUNRNWdrNmVZQXkzRUd0WHp6VmVoMVR0SHpB?=
 =?utf-8?B?NGlSVW5nTDdJc3J4R0hveUl5L04rUzFGeVN0ODhZTjRCVi8zVXlVakRoZlhv?=
 =?utf-8?Q?OAZcxuuGBNPbaMdcFTlsUN4oJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f8e7c4-138d-46a9-299d-08ddf5bbaf78
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:27:41.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bll0dO+Z7dn61ylh8+6/gDFaC0VSD1FCKI5UhasQ7nThuHUlMAmqASZPkKZtILsfe5IAdvLZdfEHIKnOk//IaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10800

Preparation of supportting DTR mode. In nor suspend, driver will disable
DTR mode, and enable DTR mode back in nor resume. This require the flexspi
driver has the ability to set back to dll override mode in STR mode when
clock rate < 100MHz.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index db4b92490de957580c6298baeb8b68a310c23615..a1c9ad03379682dc1fc2908fbd83e1ae8e91588f 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -767,6 +767,8 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	 */
 	if (rate > 100000000)
 		nxp_fspi_dll_calibration(f);
+	else
+		nxp_fspi_dll_override(f);
 
 	f->selected = spi_get_chipselect(spi, 0);
 }

-- 
2.34.1


