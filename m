Return-Path: <linux-spi+bounces-8557-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D355ADA577
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 03:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7F216D724
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F822083;
	Mon, 16 Jun 2025 01:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="GqRvAHT1"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C512DDA1;
	Mon, 16 Jun 2025 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750036532; cv=fail; b=DNDfd1bM/um5uLfEpNLUvTsa/Fhjs8UulHMUH4sLorftjVzcdDEmi57VHJfixxfhwg0d/uMT150dyPao+s94cuvQl7+tQV8NH56ptq7FKUQkvzjAu3tzld/gwc420tnSnbguRSVl2qYC9w9SnMYUis997y0L9/M4wIIBxMi+uq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750036532; c=relaxed/simple;
	bh=ZA3rHm/g9NbcJ0j7tTl/Q7VHl+kaFFV2yvkRncD5ubY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3uTUZMZXW0pqVKT9m3gF640Stwdt5kkPaIprujtfXj2JjjyKGb5L9dE2DmIpJdyn+EZT6Jlfan5T/FrvK30Lm2diTWdWH4KdZyNJcLME6Eqp/N227bbnvbqOJFQuCeqZfjTpqK1hLJXfzmyikKQ1SrkVE7Hvq36lsz+4TTjdX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GqRvAHT1; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dm6biHJzItnJBghdsiRU/v+ZbKEmPmqpmHftWF6B9GKqT/2MbUoSrPR18lD9jnVBioIefw/enaQjOcbpGFOzP1uxirUrzXP8NiXPKHvIh23MvmkQqOn/im3J2ou2JxepoDWjOczm/YUJgnCZ4KbSzuUoNpAUcMsVW11DJq8kFbyDCdHlYcn0rzd7jaqCP8xwQrmiv+aW4KzPtI5lcMdeb58cvfzgX2dd5iUe9omATm2EyQfLgRjQ2MLyj0zkd4cqmD+OpJJy1DFsaU6S+m06T/Z9gn/+Gc8msAUwq4mvxM4p4Yz0PvGrqqcVnEkeQOl9wAKzmZlGwSBitdF/eQXbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrURzx/lMSJW4sWCGkn6aeSRCGytJMetVMCpzKVVTes=;
 b=io8mJ+JKQunD6SkEuSzQUdO1jKmHCKjAPmi674Q/dFf25f0Y/B623v4HmgOHI3NwlCcoMveiEKJXp7GCzMTT4y7xJInoLPA46TMLRBFy47Q983naiMFLV4ucqVVcLVWShtI/dIu20ZyWkWGUVDuwAug5fUSfHttwp4i+LpNTiac/8t/Xqetc/QI4GWWAgAPHqGxgS/DerGcYeYcSJBikBbnZ7m6uBB1qLOmino1vKRxuW8ua6E7VWd3AIGAyHUtQ+P3elxdD+3UiRJdoUe5pllgUk80Ij7XVKxFYn74N/H4CJEpR191m69p5Iv1n4OBmnc43KMpogrFpUSHUBeq+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrURzx/lMSJW4sWCGkn6aeSRCGytJMetVMCpzKVVTes=;
 b=GqRvAHT1zAMlJnQSR/93y3oat4YuuANnrnDaPchGKEC2Aeh8s65bXkRYXde3tT6iROFBgNIzu0pG91P7rL494AD7u1nj1x6R15L80ao0Xb5gCZ0MImekvgdi9x5swINXLGH9+2gaLw1nX0z3XpZt9LalfdJCo8ekHR0P6Q6xvroewtX7VAecoSXQU1t4GJYJIuoKq88ht9PqSR4WwTnfYXPZwS0tEMdlcCJYSSbqcml4BnzwkWA/m9mXSS+kt4j03JFUMhNFMwFSof7XTnby1uqkPQxeSVXdQQeRwfP2TANWkup1bKOUl7g2+cvMLVlEu/Vr52EDTrJkwnFC7nwxWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5017.namprd03.prod.outlook.com (2603:10b6:5:1ee::21)
 by CH0PR03MB6148.namprd03.prod.outlook.com (2603:10b6:610:d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 16 Jun
 2025 01:15:28 +0000
Received: from DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168]) by DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 01:15:28 +0000
From: khairul.anuar.romli@altera.com
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairulanuar.romli@altera.com>
Subject: [PATCH v3 1/1] spi: spi-cadence-quadspi: Fix pm runtime unbalance
Date: Mon, 16 Jun 2025 09:13:53 +0800
Message-Id: <4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1749601877.git.khairul.anuar.romli@altera.com>
References: <cover.1749601877.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::15) To DM6PR03MB5017.namprd03.prod.outlook.com
 (2603:10b6:5:1ee::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5017:EE_|CH0PR03MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: e4402711-372c-4091-1c62-08ddac73477e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGpMOGRnbldWQTRQNGpzRVN6a3lodC9RVGRsakt3TEMzSDkxaHpuT2llL1ZZ?=
 =?utf-8?B?OFRLQzRGU2tHaHFWWVd5WEdtNHVWeUNFVTFGdDllQ2FzQkpYeWRlbWhoc3Vw?=
 =?utf-8?B?VUs2SDZJTk9rajJrNzllQTRNTWJnRm5JTWlwdGpZRmR5dGx5bXdZR205SnBo?=
 =?utf-8?B?bkU1TmE0NU04REJVUUJ6WmI1NnpWbEMvWThWZ1F4eHppb1NncFRlZ0ttU3FS?=
 =?utf-8?B?SWFFVVRJQzJLNFVnaXRLTkV5ajZkVEl2TUc0UFpzNXdLb2tyWHdGQ2NOR1Nj?=
 =?utf-8?B?WXdmNkh2Sng4Tm5UdVdLZHlpNlZWMzFSdXBiUFpBQ1ZieUlHcUtaS1dSM1BG?=
 =?utf-8?B?SEtURGM0OGR0V05IRlBqMlhHeEp1b2ZBL1NMY1A2V1MyWVlNeU1CWk9WKzFG?=
 =?utf-8?B?eEp5bjRGRjRCMGVtZFgvSC9BSXR0aXhMK1d2UUd0aWtzaDV4c29FUW5BNEVX?=
 =?utf-8?B?VTE4dmlPSXFpYU8xQUlNcFZsL29CRGdxTU41cHlFZUtwazVvNVd1ajFsMU1U?=
 =?utf-8?B?NlFuRWltd1M3eXhsaFBQalN1ekVIdU9ad05ydDdQOTd1dWV0dDA5VmNMdWNq?=
 =?utf-8?B?SGhOTjU4NVZLTGxiRGFUdUF5WmVZelNDQlRwNm5vODNoUWVwa0dTakdJTzF4?=
 =?utf-8?B?ak5laTJBbEdqVnJzZnQrWlNWSHZUKzdFZFpReGZhMXgyTDZVbVVkSk5PKzF6?=
 =?utf-8?B?ZGhtV2xnTVNjYlA1cnB4YVlEUFFMb2lpSzl0cFBPczBJdFRWQ0g3OTh3NVhi?=
 =?utf-8?B?b2dGMzdiVkFRd3FjWmFGc1ZpK3VzV3prMmR4bDVWSDRGZXFxNStsYmNGQjY3?=
 =?utf-8?B?U3J0aXhwWDVucW9ibFMzTlRYUVZUUzVEMWs2RGZOTXZleVdEOWpDUFMyTWZu?=
 =?utf-8?B?QnUzWkkwTG50dTFIY2NxaGp3dnh1T24yVjB5eEd3ZFd2eHVFNlQyaXoyd2hC?=
 =?utf-8?B?K0paTDJnQjB6L1RZamJ3Qko3eEdSdjFZU01XTjVtV0IyOWdHenptU3RLaWN6?=
 =?utf-8?B?Z2hKalhCejc4djhPY1FmMFlHaUhObXgzb1lGSGxlTVpsUHBMVU1JaVJobnA4?=
 =?utf-8?B?YlRWUVltbG5WUVQ5WGR6KzVNQUtZaE5yWkx3K2M2Qk1uSFNPRzMxRm1VWlha?=
 =?utf-8?B?TjJVL0NoZ204NjBwWkF0NXVoclJDdXdaK0ltL2hubUpFVHRsTEJYSjhBQXdP?=
 =?utf-8?B?bzlMZUptMjZOTlAxa29NVnc2WnV5Y1NnbkY1NHlLTi9aaDc2MEFjcExmN1lH?=
 =?utf-8?B?cXlWOVkwTG50WjcrellKdEhmUnZrMmJ4QnM4U05PU1NTcHJRWmhPbnNLOU9j?=
 =?utf-8?B?Ym81WjZSNER0VkZ6ZWR0YklXRi9zNldoREoyYWl2cXRlZVIvTkNHZHduMW13?=
 =?utf-8?B?Y2pSckZLSjBSeUZrcTRPUHhtek9lMnNGcnlFUXFXSUZGemxJaTh3WkVFcjRN?=
 =?utf-8?B?aUxmMS96Z2YwTDdDWjZnZmVieFRjNk13WXVxYmdZZjdqZ1IzRDhaZHloSzJ3?=
 =?utf-8?B?bmtTbGVxc1poSVJrNm9EcTBkZ1lVbVhpZW4zWHRHT1ltWTVsYWJJQXdvbEVB?=
 =?utf-8?B?aWx2TmVJY3d3TnRJM1ozQkozbk0vL0lXaFFzS0FUdDBaazZCV0t6blFlT0p3?=
 =?utf-8?B?RFBURmwyUTBsYXIrSXlUUko4U1FCWlk4RDZGc3cySU1JbFgrQXZILzVNQzRN?=
 =?utf-8?B?MHQrb0VSRzJLcnh2YTN4dFlHRXF5RU5KRmJweTUzd3lJa2RSTlppaHFvZkJS?=
 =?utf-8?B?a2hQUk1tRFphdmY0ZzRKd1pwRldTRW1SM3N0c2RFY09QNWdEbXRWWCtDaW1L?=
 =?utf-8?B?ZXdrRWxvYytTVjlRQTl3YW5lSWtzdWR4SVo2ZHJpQ3BoVVR5Nm9JWmZkV21s?=
 =?utf-8?B?N0VxaGxmWng1Z20xM3JHNFJUVGV1ZncwTHV5NU16VStndmp6M01pbk8wZXVo?=
 =?utf-8?Q?9pJjTbKtN5k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5017.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEI0cTBZMUNzNU9xemdTUVd3c0RIaGFSSitpNEM3T2ltRUJjaTlrNWN2NGxz?=
 =?utf-8?B?aTAzdktrK01xZWxLYmh4MnlpU2YzSm15WVBhd1dadVVYZTVFYzVxbEdBNG5t?=
 =?utf-8?B?a0dtTWsrNldDTUNyYXhmYTVBQ09FbGpNaFQ5ZmJwdElpNzNQNHlRZjVOQk9J?=
 =?utf-8?B?NzlGNXhQcGR6SktCaDNuUzUxNG1GZVd0QlR0eTJzZVFKbEVIVm02Rm9WcU9y?=
 =?utf-8?B?ZHJNOU5CVnlZSmZnL3RJTVFRNWJKUEN4ZVdJS1lKVHdSSFRXL2JERDRubWNh?=
 =?utf-8?B?TGRaWnY2SWltbkFEQUdrelNmSVVVUTRsb3E4WXNQRjRuL1pyN2RUY3Z5cDZ0?=
 =?utf-8?B?a0poVk4rUzhwblN4TytkaGQvalp0OFhiVFBPRVQ0TGVXdVN1K0NqQTc5VnhV?=
 =?utf-8?B?YmdXT3ZJVzR3cEdIbHZYQzB0VUVpMlV5dW1HWkVubzZEd2d3WWlYTEJyNXlI?=
 =?utf-8?B?VlF3R1ErVWFkN0FkY3B5akdOWjdaVlVpbEJURkdhR0gzSWR2WU5IYTVDUXlL?=
 =?utf-8?B?ODdWM2VFUk8ySDRBeVNuaTFiYXRSazIwRDMzNU11dnVJdmZsSzdYNVYycG5S?=
 =?utf-8?B?NkN1MFV2MUZEVExMSytFSThjTERKQ1ZWT0NrZ1hJYUhvU2lCZ2c4R0E5RGZF?=
 =?utf-8?B?bXdETWtDRTUrSmYzRklNTnplSGkrdjFrVE5tNG9kMEV2MXo0dGdDbXVzYk8x?=
 =?utf-8?B?SHhhaXhoVDVVRHBLTGIySkVJaXNsQ21ZZFRrZmNhMXVNR0srb3o4SVZhc0RS?=
 =?utf-8?B?SUt0SlVWbGZUb2N6RlV4MzJ6cnpURVg5amxCWmN3S2ZxOStLZm40MC9Xejdn?=
 =?utf-8?B?Z3hTR24xNi96ZFF1ZU1lRCtxNzkrRXNRREF6MHo5MVB0V1BIQXAyS01ma3pT?=
 =?utf-8?B?YlJDNUh4ZzR1anI4QWFTQ0NoektwdSsvMnRra1RSaDlHRUtmNS9DSllDZUdE?=
 =?utf-8?B?RmpRakUxUTlnY2RiSGJ2NXpLdmJVRU4wWUxSVE1ZVU93Q0FaOXM0VkkrbmtD?=
 =?utf-8?B?NmxrUTl2RFpzbFhwSnZqUjJDVEs2TE9UdjdlMy9ZWS9xUit3a1V1TUo5bklX?=
 =?utf-8?B?K0pSVE4vNXllNEpPK0hHWVJKSDMybm82YmlqM3BhVWFUSURZMkQyRnNVOThB?=
 =?utf-8?B?UVBHSmNyVlpWUmErMy81MTVNSkVjWDgwWTgyTG9PY1I3NjViZVlkYWJxUGlD?=
 =?utf-8?B?VDFLZTRZVlRTUWtZZTN5RWNrS281Z285VXd0cVpVaTVMcXUwOHEvS2lvcVJz?=
 =?utf-8?B?c3Fpckk4OWRvNDVsOEU2WjJvTWNhV2pUN0hTNlU0Nkt6SFF3ZGVsUGhDQ0dq?=
 =?utf-8?B?eXc0T1k0T21tT2Q2MkpvTlQ1QVNzTk9ZaTZrdXpDRWV1L3NjQ2lPZkZnTFJD?=
 =?utf-8?B?NlFDbk45L3d0V0RGQklIbmxRMDhjZFlvd0JtSFBaT1VOd1MvWWc2bS9vbjVa?=
 =?utf-8?B?elF2ZkJIZ25BdC9WL2QxY29GbFlzWHFzU2NOSHZRemFKYmNBcDhkRVJqWHdt?=
 =?utf-8?B?SEFLdlpXWkphQ1ljZllQQlR3UWdoanI4UGd6VlFTZUZPMEYva24vbU9idFJj?=
 =?utf-8?B?M010b2crVnpqUUc0bkZWNGZhR2MyUFI0VE1HaWVpQlh2Q2dPWXNld0NlaHox?=
 =?utf-8?B?dzM4eXRVRW5TMEcra1Zla2Z2dXNYdjFkVDBuaU1GZ3JjeVRFenE2QnZYMDJ2?=
 =?utf-8?B?VmVZc1NYT1l2Z3RGeGhqajNUVDdrL2pTZm15MGJMa3Zhb2ZNb1d4WkFRcjNv?=
 =?utf-8?B?aWtjQURsUUlxRnVQQ01PSVpSN3l6MHRyajFSQlRybC9Jb1plQnFYaEVyb2hU?=
 =?utf-8?B?S3l6dTUwT3pKZXNvK3p3YzhJdzAvTVpJYlhpKzVzWUp3VFFsc2dtSEFxbjBp?=
 =?utf-8?B?SklpVmFOUjhFRk9rWFRiRnB6OGU1N3U5Q1FOQTdldUtheE9vaVdFSTV1V2FS?=
 =?utf-8?B?dHBJellKcGVMRmQvd0dnMTJDYUNLWlJtWGpiU0M2V3YrbXNvbVRwVkd5Myth?=
 =?utf-8?B?eU9ic0QrVyttZXpsamkvM2hOdkJWVVZISGw3dzFuelk5N1VnZ2U0b2RuODRu?=
 =?utf-8?B?aHdkaFFyeVkySU52VEwyT1pQdUw1R0RzOVN1UHBFcGlOMDhGYkNTc3hCVUJm?=
 =?utf-8?B?aGVmNEtOd3c0SmNHSlRnRlNPUXhnNTFKZFZLOGdVWWQxaHZkbHNndlhqSFFl?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4402711-372c-4091-1c62-08ddac73477e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5017.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 01:15:28.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNVUrtgeCzXebr9eHy9egafQ2YeK6I6z3RzafdqCGkrekSqJr5te24cKjG9r5ZPJGf43QwN5eAxEFDHvG4xbBpzg8ja2+phrD9Y0ejdQ6lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6148

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

Having PM put sync in remove function is causing PM underflow during
remove operation. This is caused by the function, runtime_pm_get_sync,
not being called anywhere during the op. Ensure that calls to
pm_runtime_enable()/pm_runtime_disable() and
pm_runtime_get_sync()/pm_runtime_put_sync() match.

echo 108d2000.spi > /sys/bus/platform/drivers/cadence-qspi/unbind
[   49.644256] Deleting MTD partitions on "108d2000.spi.0":
[   49.649575] Deleting u-boot MTD partition
[   49.684087] Deleting root MTD partition
[   49.724188] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!

Continuous bind/unbind will result in an "Unbalanced pm_runtime_enable" error.
Subsequent unbind attempts will return a "No such device" error, while bind
attempts will return a "Resource temporarily unavailable" error.

[   47.592434] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   49.592233] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
[   53.232309] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   55.828550] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
[   57.940627] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   59.912490] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
[   61.876243] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
[   61.883000] platform 108d2000.spi: Unbalanced pm_runtime_enable!
[  532.012270] cadence-qspi 108d2000.spi: probe with driver cadence-qspi failed1

Also, change clk_disable_unprepare() to clk_disable() since continuous
bind and unbind operations will trigger a warning indicating that the clock is
already unprepared.

Fixes: 4892b374c9b7 ("mtd: spi-nor: cadence-quadspi: Add runtime PM support")
cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
Changes in v3:
    - v2 was sent without a "Changes in v2" section.

Changes in v2:
    - Remove the runtime_pm variable from the struct, as it’s not needed for the fix.
---
 drivers/spi/spi-cadence-quadspi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index c90462783b3f..506a139fbd2c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1958,10 +1958,10 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	ret = devm_pm_runtime_enable(dev);
-	if (ret) {
-		if (cqspi->rx_chan)
-			dma_release_channel(cqspi->rx_chan);
+	pm_runtime_enable(dev);
+
+	if (cqspi->rx_chan) {
+		dma_release_channel(cqspi->rx_chan);
 		goto probe_setup_failed;
 	}
 
@@ -1981,6 +1981,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	return 0;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
+	pm_runtime_disable(dev);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
@@ -1999,7 +2000,8 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	clk_disable_unprepare(cqspi->clk);
+	if (pm_runtime_get_sync(&pdev->dev) >= 0)
+		clk_disable(cqspi->clk);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
-- 
2.35.3


