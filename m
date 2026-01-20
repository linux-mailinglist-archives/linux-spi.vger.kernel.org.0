Return-Path: <linux-spi+bounces-12506-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F32B9D3C3AB
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 10:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 928CB56A107
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3D63D2FF0;
	Tue, 20 Jan 2026 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fofYft7q"
X-Original-To: linux-spi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB053D6466;
	Tue, 20 Jan 2026 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900972; cv=fail; b=NAmwFWDnPyu7cW4L9K1CEGDTcdKcQrYCgmYVUdeZ4OxZyLx7akitq8ZKY90vRqxjVg9Xrpb0fQ5ZQaqwAR1MYeB21xzNrGOXARWN9jNN0wGdAOSEAX90xAwUT8WxwUuaUprrMs1GR/uB2doru6rTILHApwgaxiqAj5DRM5wgGHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900972; c=relaxed/simple;
	bh=jRrgVPM9lFT6/laLRA+nEMZt+EmsiIN1hR/exxXaXxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MMvFEIe9bdSgloeDlaeNPc9E3GhIGZCUNGm7IFWSQi1siS+G2rGEvcih0Ard9ZPFeGB5Ac6ulbfmaQVaxoQ2CKMyFeQm51UiLSWGY6BLPVTIeypLsS0sMUt8ivacSB/zKcf9RpLGyduw4QxsDq3wbnJXpf/jXUVV3/bbsOGUiz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fofYft7q; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dO0NZo/XPXtXnCa5EwDdbMcNnoe4vSQnCMVDD5re4d2CF9nwIglCJNkExT8IvAon3oCRkXfS9Ny5JZsrOhtLvucFPa026/VXEupDUqHtojcbmd9fzyPoUhvwQ5dk9Xm98R7vXtddCiT2FOQq1E4rg8GunAeUVRK+Veqs3/xvRoXAUueovReTVDfYCmjvFTUxi87XL+gPyC/YmAFJDML82wUClyk6qtitwRmaGCVko25rD4Cf+fo0O9FqS5tl037GNt2SuFv+JAyBenqaqgufU3FYF4yrfkffWAytNwha+iSzs2MDbM+XIJ62fvwGd8Z3mZdTCSvsfoWGDB3vCC8cIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64uXVn3C7QEFViuztSbuaquwA+MXTDoJolrecgzOywo=;
 b=M9FowJo4qMU5H51TXMGqAq4q9a82uaU2uhriGLv/LwhVg79amIvtjjf5aRbpwetBH9GPAPiS4TPMBWzRIGCSAvR0HI9C3zdlChFMgekEFwPFnure9t2pJ8hpC0TjtW5dk8fZkfBuZC6xfHqHhLCipxFiJgEf0kGanKIC3hFKY6rujOswP9Kr8mExOGOjRJFKkffvxElRb9unQKHn4EZMD6vaY5tOUseqdsauM48DCbw4PCR+GU1KpFLgevNeEMsU4abzheYDzYnIZL+ZRGaod1L6NNNsi09Z8fqz7ZvYA6I9T6iY9OWYVXFi/azJVqPEmf7s9Jm2fYx6V4tGQOqvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64uXVn3C7QEFViuztSbuaquwA+MXTDoJolrecgzOywo=;
 b=fofYft7qjjOU61e6Z/rDBzBP0rY2MZRZvrEhirtbbSTp7wyX93B4/auXjJ9Zsbmb0F1gRHQCmqN0cUfH/HmCtLcTiW0+6Z60z1Zs1mfs4jFtRbRx1fpevlAsPm5UQwuXyS2bF4HSMxavvFYGpMFTWZaSmZPJO93cnTi0AqBNuKI=
Received: from DS7PR06CA0041.namprd06.prod.outlook.com (2603:10b6:8:54::10) by
 SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 09:22:48 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::28) by DS7PR06CA0041.outlook.office365.com
 (2603:10b6:8:54::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 09:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 09:22:46 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 03:22:46 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 03:22:44 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 03:22:44 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60K9McbT973005;
	Tue, 20 Jan 2026 03:22:39 -0600
Message-ID: <80e7a578-4636-48bd-b92b-54fa33cc076d@ti.com>
Date: Tue, 20 Jan 2026 14:52:38 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] spi: cadence-qspi: Add Renesas RZ/N1 support
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, "Mark
 Brown" <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	Vaishnav Achath <vaishnav.a@ti.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Pratyush Yadav <pratyush@kernel.org>, Pascal Eberhard
	<pascal.eberhard@se.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <s-k6@ti.com>
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: aa71e4b6-5626-40d6-e5f8-08de58057948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3FYMEFBK3hZc1NsL0hTeG9ramJBc2VFSmNTYWVLeDhQNDIzOGp0ODVYRnNZ?=
 =?utf-8?B?b1R6UWxCa3ZxTzlGNXRaQXp1MGh4RVpPWnpaRHA0UjYzQlVUQVVNQVlnVnpU?=
 =?utf-8?B?NG1PRHllcVJBNFUxUFAwK1VTUnBQSldlUHR0M1Z3emI5TkNrSXVqeDhpZE1C?=
 =?utf-8?B?c2JTbU5aRC9SVlFXVXhpaFEyeXJkNkorVmVqa1djaHRSeFhVRW82cGk1a3VQ?=
 =?utf-8?B?OWdzT214U2xzMVJVaFErUHhkOVJvdUVoQXUwVzZUK2hJN0lpeFZSSHhnRm1u?=
 =?utf-8?B?Ny9mODQ1eTlQdmNodEh5N2sxeUFydWtrTG45d0xyRVFBSTRDc0pHdXBrMkkz?=
 =?utf-8?B?WHJEYWtMdUdUa2FmelNPeVZBcEh1UmdiZHRCMnVJV3lHbXVSbTlHNW1SOCsw?=
 =?utf-8?B?bkhlWVFFT29JamtSblRuMTRoRnNVY3ZWT0g3RVhFV3RmSWJFVlhqOVllVjlx?=
 =?utf-8?B?VU84eDdXVmNuQVRyWjNSSCtDNW5mbTZWMzR2K0tKdmI5ZWd4ckh2Y1hISXhI?=
 =?utf-8?B?bTlkWi9ONGhVbkRuUnhPc01halQ0WkV2OXUvbVN3djFqWGN0RHJtOVpsWlQ4?=
 =?utf-8?B?K1c5VTVYWjhDM0tJa3FSbWErbWpheERzNnRxZWxPUG4rdXE1S0FVYzVGNzFV?=
 =?utf-8?B?WE93dDFiZ2J0Z1Jxb3ZrK3JnMklrYU9VZDhLWVczeVZNWjIzSDR4OVVaVVlI?=
 =?utf-8?B?d3FkTlNSRm1ZZ0JBcXZlcUpDcGk4OGxJMzN5clYrdXVleUFLRWpHdFVqVkNn?=
 =?utf-8?B?M0VIMS90U010VGJ1QndWdUVZUGJqVjM3bjk3ZzlNQUoxNUliR1pQNitJNGtz?=
 =?utf-8?B?TWRmYnh1alNDTlBhZ1BWMGo1UllTM0t6M0J1UHBDRmd3U3Rkd2pMYjlvM3U5?=
 =?utf-8?B?ZkJOR1E2cDB5SWxta0dHTnZuZDAxNkhESk4vU2N0cmkvaXhyakgzNzlLeWVs?=
 =?utf-8?B?anUwS1U2K1ZkSTF1UGFDRFdscG1KNDErNnRnN25BSlFKbzhkQ2hOR2p3MXpQ?=
 =?utf-8?B?SjJDcmJQbGEwQzUwanZkYldKdDRoTFZCN2R3aVczT3M3eWlGNndDb3lqR3VO?=
 =?utf-8?B?TlU1Y21jTG1zV2JvNk9mYms2amJRUElKbmFDcU5CNTFWb2dEOFBaSlJoMWpP?=
 =?utf-8?B?QUZMaXIwOTBYL29NQ3pKbTdhd0RtcnFMWmQ0Q1lmVlY0bUFwRTcxTHVFalRz?=
 =?utf-8?B?MWRCdW1iZTVHc3hmOWxUbVdmUTBwV0FuREVtVS8xQjlrVlkxVER0cDlYT3lZ?=
 =?utf-8?B?ZUFKUVRoakRYaGFLd0NsS01GV0VTQzhJYlUvdlNndjVNdk00bFlZMzM1QVBU?=
 =?utf-8?B?dmVlaXhaODJrZjJGdDUrajlzODRoa3B1Z0czK2RmUEdDUUZjTUltVHhRdnNF?=
 =?utf-8?B?TVc1NS9qdkU2Y3BYeHRyZW1Fb1RXWXVuQjVXcFVaaUtVV0ZGOFhIMUV4c3Z1?=
 =?utf-8?B?YXhqbkhHTkRaQkJyejJVZjdFempwMmdZR3hlMEk2MU5yVU03R0Z6ZjQ4NllU?=
 =?utf-8?B?bkE3eERZdGtRclNHT2s0ZTZUTGppTUx1bHpHVklrZ25GY1NHZHNNSEEvb0Np?=
 =?utf-8?B?d2gyRVF2a2dzM2p0UmNWNTA4WGhQT2F3SmdPUk9GS0tUOEtBMStqZXZtZEFP?=
 =?utf-8?B?dnhkLzk1M21wWmlISStMNko5MFBrSmMvVldmRkljY09sZ1RFQkQwZkg4S0di?=
 =?utf-8?B?Q1B2SmV6aUlzVUpaMmp2M0w1UmhNUmhKY1UwWEVCY0lUM0ZZODdYaXJHVFE2?=
 =?utf-8?B?R2k0T212RFo0UHhmcTc0bGtqaFBBRzhSWWxmZVdGd2ZXVFAwbmhYSGNoUXUr?=
 =?utf-8?B?SzBLbi96dG5Tb3ZqSVJSR0M3K1RDUU5xeC9pbkVZd3FaakM5L1BTMzZ0aXJT?=
 =?utf-8?B?QlQ4K0xZUUI2MHhZOFFLT3JCSTF2aWhsVExNOXU4RllHNEZWeG53VVFPbkxK?=
 =?utf-8?B?YVV6aU5qZDY3aVdwOThSNHkrWGVSQWY2MEZMS1M4NXJmdUFDSDF3NGNzT3Bp?=
 =?utf-8?B?SW1wSUhaanI0RkluWXgwZTcxUGMydkdYK0ZBNldWUkIxVlFpQkxSWGV3M3A5?=
 =?utf-8?B?Szc0Vm5FbzhuYXdVYVROaEtoU1FWTkp1QTIzNS92dXpvMjhSSUpSRzhuVmtD?=
 =?utf-8?B?MmxsV2JTSHdJY3lHUXY4NE9KTlE1b0ZZMDdtZmxIVmk1djR2V0p2UTZtRVMw?=
 =?utf-8?B?TjgxamZvczdHcGFHNlpEaVJEUXU5aWNidElkRmFzWnFqdnhDYXVlejhJRTRr?=
 =?utf-8?B?bEZ0MkJRQkM3NEpDdEFDeGYyM1dBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 09:22:46.5178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa71e4b6-5626-40d6-e5f8-08de58057948
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424

Hello Miquel,

On 15/01/26 14:54, Miquel Raynal (Schneider Electric) wrote:
> Hello,
> 
> This series adds support for the QSPI controller available on Renesas
> RZ/N1S and RZ/N1D SoC. It has been tested with a custom board (see last
> SPI patch for details).
> 
> Adding support for this SoC required a few adaptations in the Cadence
> QSPI driver. The bulk of the work is in the few last patches. Everything
> else is just misc style fixes and improvements which bothered me while I
> was wandering.
> 
> In order to support all constraints, I sometimes used a new quirk (for
> the write protection feature and the "no indirect mode"), and sometimes
> used the compatible directly. The ones I thought might not be RZ/N1
> specific have been implemented under the form of a quirk, in order to
> ease their reuse. The other adaptations, which I believe are more
> Renesas specific, have been handled using the compatible. This is all
> very arbitrary, and can be discussed.
> 
> Thanks,
> Miquèl
> 
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>

Thank you for the series! Tested it on TI's AM62A SK with
OSPI NAND (Winbond's W35N01JW).

Controller fails to probe with the following message:

[    1.868863] cadence-qspi fc40000.spi: Cannot claim mandatory QSPI ref 
clock.

Regards,
Santhosh.

> ---
> Changes in v2:
> - Fix commit log of DT binding patch, following Krzysztof's comment.
> - Fix properties order in DTSI.
> - Rebase on top of spi/for-next and fix all conflicts.
> - Simplify even further the code in the cleanup patches following
>    Pratyush's advices.
> - Link to v1: https://lore.kernel.org/r/20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com
> 
> ---
> Miquel Raynal (1):
>        spi: cadence-qspi: Make sure we filter out unsupported ops
> 
> Miquel Raynal (Schneider Electric) (12):
>        spi: dt-bindings: cdns,qspi-nor: Add Renesas RZ/N1D400 to the list
>        spi: cadence-qspi: Align definitions
>        spi: cadence-qspi: Fix style and improve readability
>        spi: cadence-qspi: Fix ORing style and alignments
>        spi: cadence-qspi: Remove an useless operation
>        spi: cadence-qspi: Fix probe error path and remove
>        spi: cadence-qspi: Try hard to disable the clocks
>        spi: cadence-qspi: Kill cqspi_jh7110_clk_init
>        spi: cadence-qspi: Add a flag for controllers without indirect access support
>        spi: cadence-qspi: Make sure write protection is disabled
>        spi: cadence-qspi: Add support for the Renesas RZ/N1 controller
>        ARM: dts: r9a06g032: Describe the QSPI controller
> 
>   .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |   4 +
>   arch/arm/boot/dts/renesas/r9a06g032.dtsi           |  14 ++
>   drivers/spi/spi-cadence-quadspi.c                  | 260 ++++++++++-----------
>   3 files changed, 144 insertions(+), 134 deletions(-)
> ---
> base-commit: 0afb3ab76ffb521700af678ea931d31192f93260
> change-id: 20251219-schneider-6-19-rc1-qspi-7c3e1547af6d
> 
> Best regards,


