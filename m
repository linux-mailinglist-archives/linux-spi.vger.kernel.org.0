Return-Path: <linux-spi+bounces-11143-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19601C46C89
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 14:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C343AFCD7
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFF2311944;
	Mon, 10 Nov 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XXaOZHHB"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241913112C4;
	Mon, 10 Nov 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780059; cv=fail; b=g7LeUGgAsRa4U68LP23soPdtr7pHTtt8s3v6jh7FkSTxTeYwTDooe6JiH7Pt9vNJf9AEqElVqrLZsPEH0MyyYlpB3nsJkUsb9JEHTxDKfM/b11+ZcqSwlmr6tOTWHiRcWw0pP0wI4YGXlZ/meJttjK53kNcxeCuso4l/m3h7zkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780059; c=relaxed/simple;
	bh=NcL3Vyam3ZOqJeqcirxCRQ4Ynp7fwNuo+ZiiUGf5hcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y7sKnc6lEXokXFzKM78vbxLDNpG7Tz352OxkCb6/hPvF3gzzXaXqK5KM1GJjiVJprDbw3i9cvLPXp68WCMUZzbI0pJ0/4Mk8AmUdobhBRx81sn47n/Rgt2Ep4UH5I+ax2HZZ/DOq30Vogkal95R2ZLEYVxAYa91cLnPG8EwAMEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XXaOZHHB; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bvba4lQEZ8CUuqCSc8S1OuQXSi94jvoa7wJE7U2GWwm+GEIMxJJryIeJtBfdXu8tbidgwUopVIVblrewaqeK6tQe+NrWEGlJJnfvusR4oPXGD2GfrQhJD4BcJx/kjoHbSrJWE0E9nbYjiLtCrUPhw4Oh4JSG1dQNWqIjzsAbkKXrDo8wP8q0+jjQq0A8yCuhGATu0c7VRUbiat8i3qW7m4jlcZdAtqJI1N7xXoNcrFVlnYhDt4J8X3zBnRPjdKOXnRdSErNb3ZNoVmqsJVoH0A/LMxH26WEK2DayhDq644Cn/S2NYIjPt1N7dRwVb7RZnJOdM3Qa6Jj4Ia/25QxxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcL3Vyam3ZOqJeqcirxCRQ4Ynp7fwNuo+ZiiUGf5hcA=;
 b=W/cBEIctxiqX8nz0qRgYXqIdeomTMKoNJPlbLCMu6TtfqCcScgmGOnh1SXeCiwkJ1VfSxkdYccP95Vaw1d7CaSnC9gMOiKaotHPk5XOt+/XtBfSFQApKBbuQ+q9MV8xwn8M/qMJqWeSwsnARDXzXC0W5BCaCaxFPstvgn415B3Z/dnfH7hyYzWDbaDsze9p+2oO606njujmvSLogwpmZfTIUBcyrVvMUQgBlq3RJBdZIGQNNiB9oGrn5rlS3uJB+9OcCtyC7GfF0vmDAZ3CFtk/ofr2s+AvtMtCJPzWtVfPsCocf0e17ZF/5u9sMZn0tlgb8u6jeuL/9HFWDcRZgKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcL3Vyam3ZOqJeqcirxCRQ4Ynp7fwNuo+ZiiUGf5hcA=;
 b=XXaOZHHBWMBMFMmLHi/qBqsC/67aqzURxZUUrV9OAOQBJfptsGKRf48DuhYYH7xccjh6IFWrRYl9vDb9sMS/mr0GHEuoOV/KoB0E9Uq7rpB+9RBKWEvGjTFHtp2swns3nHY/DHgtom9t+ma1pYVHbGUI8az04Ann4HIoVvSAjrPviVyb/EvvvUTseivR8KYE9cY6HDAp90wmMzwelJ3WOrng6uiz4LpjQDyF+NPomaivRy0tdoKFdSyYFtoMkhj15d88A3aTLKy/d/AuAhz0vUaIXKlKr54gyYXUAFRRUrinPrON1m7sBKKX4oFZVdbf2YhcN3Td4SWbDFbsUNtHSw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB5385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 13:07:34 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Mon, 10 Nov 2025
 13:07:34 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"broonie@kernel.org" <broonie@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"florent.trinh-thai@cs-soprasteria.com"
	<florent.trinh-thai@cs-soprasteria.com>
Subject: Re: [PATCH] spi: fsl-cpm: Check length parity before switching to 16
 bit mode
Thread-Topic: [PATCH] spi: fsl-cpm: Check length parity before switching to 16
 bit mode
Thread-Index: AQHcUaqFqe7lXHkB70ax6tVPYAVwRLTr4p6A
Date: Mon, 10 Nov 2025 13:07:34 +0000
Message-ID: <9ff09fa3b2d8efab15d220c88d8bef4cb1cc76b3.camel@siemens.com>
References:
 <07d1ea39a0e9b56846395d79d489a5153206ff5c.1762714267.git.christophe.leroy@csgroup.eu>
In-Reply-To:
 <07d1ea39a0e9b56846395d79d489a5153206ff5c.1762714267.git.christophe.leroy@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB5385:EE_
x-ms-office365-filtering-correlation-id: 1b67ad17-852c-4371-921c-08de205a1d43
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFhTemxZMGk2azk4MjVnQTliT1N4WDJnNVYyS2FrYS9VZ2xKT3BGaStOd21O?=
 =?utf-8?B?eXdLa1NOS2RqSnRRMHkvSzBWUStwT1NGcHRMczlVMkpadDBtT3pBZldBMWlF?=
 =?utf-8?B?SXdnU08wTnVOMmdpYkJRVjBKNVdDd0hGWS94MEwyOHB2UHVCaWFRMy80YlFU?=
 =?utf-8?B?aWZWTWlkVnJ0TUFwV1RmNEdudEFtSkM3ZVQwWjBsSTJuUWtzMDdiRGJSRkxr?=
 =?utf-8?B?WEZINkQxYzh2d1ZwRm5OaFkyUlhEYTV6ZFdLQzIxQklUZDdXMjl0REV2dGl2?=
 =?utf-8?B?bDJYak5PeWE5RjFZelQvWnBwanlaeVovVXVXRlJITCtxTW9MRnVOQjdkL01m?=
 =?utf-8?B?aHQvVE0yTm1hQ1Q2YkkwTUpBd242Y2xLenA3V2pUdXY4K1BTOUEzdnJhdy9p?=
 =?utf-8?B?dUdiY1ZhNzZHQ3UrSk5vSHJxNTlQOEtBanA0V1cxQzZiWXU0amJkdjc2aVNz?=
 =?utf-8?B?dVhYbVNOaUV6NTJmVk9tM0NKOXM3YUY4TjNKUlN5Y1FHS2FGblNwdFVTY1R3?=
 =?utf-8?B?TzdjQm9LdE1ZVjZ2aDN2bEJ1L1dkQUM5QkZ2YytYa3FkejR5ZjlWL2FBalNq?=
 =?utf-8?B?N2ZFa0JpUE1PeEgwOUhyKzhlNnE2OWVIZUtiZ2lPTnNnWStjV0w5Qnk4L3BF?=
 =?utf-8?B?TmZnRDlGeXJSS0pmemY0Q2tsYnNBT2VlUEROZmVNM1NNMlc3b2N5U3hubGls?=
 =?utf-8?B?cm9vYVlUUFhYb0V5WmJaZUFib2taQnphM3pHVXhOby9CK1dYNTRsWmlPRnE5?=
 =?utf-8?B?QklmSWZPdGpEQkRYMlhsMkRIek1mVTVLamhNZ2JrUG1nMTVRV1duZS9wQ2tO?=
 =?utf-8?B?dlREaDRiV3ZHcG5tZG4yUVUyTmNqNkMrWEpORlJtVGNGUnVpZzdaVlM0N1hs?=
 =?utf-8?B?dFdGMnJ1bEtxTjRKNUxSbkdGdFhQV0NXT2xsU1AvcDI3eE5IL29zY0VOcU4z?=
 =?utf-8?B?M2RQWk40SFBwQTdNcVRhMW9OYXBoMExPTWowV0hVWFJkQTB0WGc5NkhMT1BR?=
 =?utf-8?B?NmVBNDU5WGRFTUFzWWgzbWhESWRMWlRFaFRoMjZlOWl5b2VlcUZDRnpvTmp1?=
 =?utf-8?B?akNKZGNUazhKR09OOVE0b21QUG8ybVpjNkRWRW9WeWRCZEpodVMvMmRQMHFH?=
 =?utf-8?B?MS9uaUJhRjEzMUZLU3ZUOG9WR1ZwSHZCeklteXBLSHZsd2U1OGg1OHRCeC9G?=
 =?utf-8?B?a1E0d1ZISCtuZ3JMWmoxaVNMYzMrdk9BVGdLak1xYi9HTEpobGdOK0JMeGpH?=
 =?utf-8?B?MFlDVWJ2UWY3VDVkblNtUFNYdGhHY2MrajFCUnRaZjZOajFiV3hRbm1ZR3F3?=
 =?utf-8?B?TTVBcWN2SzlJS0NJdTBPeDNvQmQ2VEpUSXZrK1YxOEcra1hIUUxRSW82NXZs?=
 =?utf-8?B?cUp5bDJKVEdLQTFRdFhSc2RFNW54ZTdPcnFLaXlZYkNEM0VSZnFVTm52VUNa?=
 =?utf-8?B?TStITm1ZdFovOVhlSnhYZnU3UDlJZVU0YVN1d2ZZbkxWem9Ld1JFNGtaSXlN?=
 =?utf-8?B?L2ZuV3NpM2U0bWlYQ1ltNndadUxyYzRQdXlZNWZNMjNVYnpPcnNYbVV1b2tC?=
 =?utf-8?B?YzRvZEgvNjdHK1BDamhwR2w3NHhHZlJvL3JzNTRLb2x3RDI0WmFvVlFua0JT?=
 =?utf-8?B?NDhBMWM2cGpkUlFzaGcvUDdZUzBLbjBkU0RIQk8xS1g0d1JNUlJsWkw1bHpJ?=
 =?utf-8?B?WnA4K0YvbnFnaEl2d0NUSllKdE01YldLY1dTVkM3M3RYelA4bnNFaFRienE2?=
 =?utf-8?B?RENpcWVLS0NxMnExOXkvK3ZMV2cxTkExcUdNYmFYN0tYVDMwSEtZY3NMWVVZ?=
 =?utf-8?B?S3BiTUs3THpHdGtWSVlZREg4YzVYdWIvbnlzWlFNTG5kUGpQcGVTVmtVMnFD?=
 =?utf-8?B?L1BrSVJMTVpWUTRENXRZSEtaWlFsREI1RjNhdUFlU2N3b3phYmI2ZlZ0OTU2?=
 =?utf-8?B?UXVhd0s2aTZhUm9MQVN3SHR3RWE2b2VWYWV4OER6SHZVRmtmS2FJN1YwY3E1?=
 =?utf-8?B?Vjd2SG0vdVZ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXNndnF2Nkw2MEtsOGVHYzVYdVlEL3dOdFlNdEN5ZWdNZ2kxSzlHcEVKakND?=
 =?utf-8?B?b0ZSazd5cSt0a0FuaEY1bmNFSnE4NFFtd1Q1V1dacTVwQXkxQUc4YjdRWnhn?=
 =?utf-8?B?Qk45SVVkQ3JwaXdsN1dyL25UOHVxWVA5Qmd1TzhYZ2JCbGJOYWFqKzM3UWp0?=
 =?utf-8?B?Z1ZOcVNseEUwRndidlE1VVc5UGE1dHpqQnllSGJQdjZEaUJuRi9QYzFJNFZ0?=
 =?utf-8?B?MEZzTXhHUDhKY2dCT1JmRzVIUHZ2ZlNiWmhSTW5VSUtKaFprc2gzUGRiM3Fi?=
 =?utf-8?B?bHpGZmxJb1U4QnFRdG4rbnZWSjBJRks5OEJndVFxQWlqaWY5TGFGM0dIWGM1?=
 =?utf-8?B?SWdNU0JybE1QZHlldzVqdGMvVlZVNVVWTWY5bVV4c3JsWkd3QlVaYlBQZ3B3?=
 =?utf-8?B?VUlVUXR2OWdLUHVRRXp4ejBIODJuUnFEM2l5UFNqVkpLdlFUQzAzRGo4L0dI?=
 =?utf-8?B?WjZhWlB6QkhHVU0vNGluNXJ6U2pObG0xUHl3WnJQQmpDenBaVU9VMThMVWdH?=
 =?utf-8?B?U0VsU0lGOGttZWwybGliQ1BvYlpHV3IyeWQvc0swa1hzOC9uNFdvalNhT2tG?=
 =?utf-8?B?V0IyYmFoeFF1d3JFOUJiTUtVS3U3NVlBUkUvaHUrNXlDUXpnblhKNHpaalg4?=
 =?utf-8?B?ZVYrNTIyaW52UmlHMnFnbXg1eEFxRC9UK1c1TWpTV3F2TUxld0hDNkJNRFlq?=
 =?utf-8?B?endYa0Q1UFJRZEFvWTg4QnZET1ZZNkZUS1ZXUmFhdHdXYW1lQjZxN1ZTN3p2?=
 =?utf-8?B?V3Q5YS9vS0ZZcDlVc05rZ2VFWGVNamwzaTk4UU9TaTgrSnUwTGxrR2ptblBQ?=
 =?utf-8?B?dVYwdXVUaXFrQ0IycXY1dmJkMmF1dFBTTGdLNHZYOWVkbXZPVnZ0NGVkNkdT?=
 =?utf-8?B?WW1OUDdkcWNnRUw3MzZNd3BKSG9CUDdEd1M0cSt1OFlMalF4dW5QS3JLbkla?=
 =?utf-8?B?WUlja2xsaUJGaXI0L1Q5c2RtdWlXZDMxY0hjUVhKd2ZWREhnVy9KNGNwV0Jz?=
 =?utf-8?B?d2tmempTVzJaMlVYNTkyVjdyZ2I0cTlYVFpNTldJeUM0SHVaN2VZaWw1eVcz?=
 =?utf-8?B?b0hVcnNtbFBNMlZQaHNRSUhwSm03VERhSlYxcys5MHp1RWhlaHc3bCtrbmd0?=
 =?utf-8?B?ekVlQlI3a1JzNzRvbmNlc3Jpai9Pb0RqMFd5MjcyaUxpRUNoV2VKSnBjL0FG?=
 =?utf-8?B?YVNPSE9HMFVyZTZzQnZnUmxMVFlrcDllRmdBVS96S2pxNEVHVmk0WkROdWtx?=
 =?utf-8?B?QVpnVmhPUXErRE13ejVaTHgvTzNvNnJxTVFnS3hGb0lmMEVSSStrU1hOVFpz?=
 =?utf-8?B?MXNzSHdFZjA1RlhsMnZDWFAyMVBFQTVTbkVXNmt6OHZ1VllnVTRQV0ZTTnRh?=
 =?utf-8?B?dDF6UzZpcWdLbkFOUjRWRktuSEJ3RGJ1eVZyMVRkM1RpU1ZvSktuWEp3TlVK?=
 =?utf-8?B?K3Rqd2srcG1YT3NUL1dIYnpuU2hOVmpWc2hHMkR3akRiRVpHL0FhajY0UFRS?=
 =?utf-8?B?c2ZRbENUaUxvSTBqamdvL29EZHJVdVU0OWRlNERmS0xHbjZtbCtaUUJma2cx?=
 =?utf-8?B?cE9qQ3lUb24wcUc0L1VYU2FpSlZtVE1CNWxadHNkdmh4TmE3QU1SV0Q3WEtm?=
 =?utf-8?B?S0RsSExGYXhXZ0s3MG5BYjFhcGZhOTNRRWp4M2RPcGhiM1UrQWxDNTVpMlZD?=
 =?utf-8?B?RDI0cG5FMnBHek1RU1ZucnJDN2VXdnN2MmxFT2RYZXM3Z01tdDdVdkhha2Ju?=
 =?utf-8?B?VkY4L0hPY3QrL1ZTWjV2cG51MlRES013YklMbWpTNmtNZHAwMTZsbzhlQkx1?=
 =?utf-8?B?NWlITExLZjZXSGszVy9KMFgvNVlsWWRuUElqR2dvdVY3S3k3djBUSlVrRHdC?=
 =?utf-8?B?blJUSC9Cb3dNT2lPUFl5K3dEMFA0RWxKYXBOWWtqeGtqL3NMV2JISUZZOCtk?=
 =?utf-8?B?Sm1yV3laMDlNK0xKUGhpemdxYUpoY3V0N1hsYm5IMWFOQjBwR0pBZDdWcTlF?=
 =?utf-8?B?M010cGcvRlRILzJXWVNkQUFTVW9EQlhMYTA0d2NROFErZDRsY2o2NG5TUWFu?=
 =?utf-8?B?dmdGL1lyRXZheStvanNTTDUvaXZsczNpRkFIazc1Wk5KVXRZeDdXcE5VdXZm?=
 =?utf-8?B?SWl4MUtKak9ib2Y0bGNyU0NDS213cklqVWFKb0lPWUsydVNpdnBaSjdJdjZ5?=
 =?utf-8?Q?62U5lX3FbKlMYFkRLnVEiy0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA1C3D4D420AD44C80BA4510D8D2F2E4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b67ad17-852c-4371-921c-08de205a1d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 13:07:34.3100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05Z1dGQuRHtzSYD4iA2cU4xOnPEb1Dq6sA3nWjuLhDHoNjlebrfCN+JqC5BW7uO8HM5G5SvsQYzYtMcvMeXJ7It+vFj/PgeNb1gZtxyUitc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5385

SGkgQ2hyaXN0b3BoZSwNCg0KanVzdCBhIGNvdXBsZSBvZiBuaXRwaWNrcyBiZWxvdzoNCg0KT24g
U3VuLCAyMDI1LTExLTA5IGF0IDE5OjU1ICswMTAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0K
PiBDb21taXQgZmM5NmVjODI2YmNlICgic3BpOiBmc2wtY3BtOiBVc2UgMTYgYml0IG1vZGUgZm9y
IGxhcmdlIHRyYW5zZmVycw0KPiB3aXRoIGV2ZW4gc2l6ZSIpIGZhaWxlZCB0byBjaGVja291dCB0
aGF0IHRoZSBzaXplIGlzIHJlYWxseSBldmVuIGJlZm9yZQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBeXl5eXl5eXg0KY2hlY2svdmVyaWZ5LyJtYWtlIHN1cmUiPw0KDQo+IHN3aXRjaGlu
ZyB0byAxNiBiaXQgbW9kZS4gVW50aWwgcmVjZW50bHkgdGhlIHByb2JsZW0gd2VudCB1bm5vdGlj
ZWQNCj4gYmVjYXVzZSBrZXJuZnMgdXNlcyBhIHByZS1hbGxvY2F0ZWQgYm91bmNlIGJ1ZmZlciBv
ZiBzaXplIFBBR0VfU0laRSBmb3INCj4gcmVhZGluZyBlZXByb20uDQogICAgICAgICAgXl5eXl5e
DQpFRVBST00/DQoNCj4gQnV0IGNvbW1pdCA4YWQ2MjQ5YzUxZDAgKCJlZXByb206IGF0MjU6IGNv
bnZlcnQgdG8gc3BpLW1lbSBBUEkiKQ0KPiBpbnRyb2R1Y2VkIGFuIGFkZGl0aW9uYWwgZHluYW1p
Y2FsbHkgYWxsb2NhdGVkIGJvdW5jZSBidWZmZXIgd2hvc2Ugc2l6ZQ0KPiBpcyBleGFjdGx5IHRo
ZSBzaXplIG9mIHRoZSB0cmFuc2ZlciwgbGVhZGluZyB0byBhIGJ1ZmZlciBvdmVycnVuIGluDQo+
IHRoZSBmc2wtY3BtIGRyaXZlciB3aGVuIHRoYXQgc2l6ZSBpcyBvZGQuDQo+IA0KPiBBZGQgdGhl
IG1pc3NpbmcgbGVuZ3RoIHBhcml0eSB2ZXJpZmljYXRpb24gYW5kIHJlbWFpbiBpbiA4IGJpdCBt
b2RlDQo+IHdoZW4gdGhlIGxlbmd0aCBpcyBub3QgZXZlbi4NCj4gDQo+IEZpeGVzOiBmYzk2ZWM4
MjZiY2UgKCJzcGk6IGZzbC1jcG06IFVzZSAxNiBiaXQgbW9kZSBmb3IgbGFyZ2UgdHJhbnNmZXJz
IHdpdGggZXZlbiBzaXplIikNCg0KTWlzc2luZyBDYzogc3RhYmxlQD8NCg0KPiBDbG9zZXM6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC82Mzg0OTZkZC1lYzYwLTRlNTMtYmFkNy1lYjY1N2Y2
N2Q1ODBAY3Nncm91cC5ldS8NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hy
aXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KPiAtLS0NCj4gwqBkcml2ZXJzL3NwaS9zcGktZnNs
LXNwaS5jIHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1mc2wtc3BpLmMgYi9k
cml2ZXJzL3NwaS9zcGktZnNsLXNwaS5jDQo+IGluZGV4IDJmMjA4MjY1MmExYTIuLmU4NDViYWE1
NmNjNjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1mc2wtc3BpLmMNCj4gKysrIGIv
ZHJpdmVycy9zcGkvc3BpLWZzbC1zcGkuYw0KPiBAQCAtMzM1LDcgKzMzNSw3IEBAIHN0YXRpYyBp
bnQgZnNsX3NwaV9wcmVwYXJlX21lc3NhZ2Uoc3RydWN0IHNwaV9jb250cm9sbGVyICpjdGxyLA0K
PiDCoAkJCWlmICh0LT5iaXRzX3Blcl93b3JkID09IDE2IHx8IHQtPmJpdHNfcGVyX3dvcmQgPT0g
MzIpDQo+IMKgCQkJCXQtPmJpdHNfcGVyX3dvcmQgPSA4OyAvKiBwcmV0ZW5kIGl0cyA4IGJpdHMg
Ki8NCj4gwqAJCQlpZiAodC0+Yml0c19wZXJfd29yZCA9PSA4ICYmIHQtPmxlbiA+PSAyNTYgJiYN
Cj4gLQkJCcKgwqDCoCAobXBjOHh4eF9zcGktPmZsYWdzICYgU1BJX0NQTTEpKQ0KPiArCQkJwqDC
oMKgICgodC0+bGVuICYgMSkgPT0gMCkgJiYgKG1wYzh4eHhfc3BpLT5mbGFncyAmIFNQSV9DUE0x
KSkNCg0KY291bGQgYmUgd3JpdHRlbiBhcyAiISh0LT5sZW4gJiAxKSAmJiAiLi4uDQoNCj4gwqAJ
CQkJdC0+Yml0c19wZXJfd29yZCA9IDE2Ow0KPiDCoAkJfQ0KPiDCoAl9DQoNCllvdSBjYW4gYWRk
IG15IFJCIHRhZyBpbnRvIHlvdXIgdjIuDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVt
ZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

