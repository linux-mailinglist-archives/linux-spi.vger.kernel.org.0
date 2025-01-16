Return-Path: <linux-spi+bounces-6390-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB1A146BE
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 00:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0778F188C9AF
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E17D25A657;
	Thu, 16 Jan 2025 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="gApPnt0H";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="gApPnt0H"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023124.outbound.protection.outlook.com [52.101.67.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F825A620;
	Thu, 16 Jan 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.124
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070939; cv=fail; b=C9uVeTL7UaWDtittnr5hyNEsp+w+Evx7p/ZhwE+wgcAShig5WgZuFNWGiuSctmbi4UYKlyw5OkwOxwuI8ZWKN+WcwjyX3L2AG6S15WQyxMaJBnYt1wQIb4aVOguTMlCJvjsSvZnwfjOwXDML7hwQtHWiZ3DpwW+SrS1LRDh7KwY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070939; c=relaxed/simple;
	bh=H1xnKYAakFwoGLpn0qgYOt3DraHSNrEHKkBxXt/oGAk=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f2M0JQuClnGG8MPnSDzh0SiyLaTprYPl+EzQBUUkE/KBolix1A0YhiX0JzLYSDeDldYsutQKhTb2ctY9GImAYhhv3zqjPpMPHBFuz4wgjw51MegEwKX9BW4Jam8d0WaHyo4QH6PD6+1Iq42JUHB2d9L2myVFdvemRKRIvR6QrLU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=gApPnt0H; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=gApPnt0H; arc=fail smtp.client-ip=52.101.67.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xf/arjCi0d+m9jiWuBbDL5S19hIsOwSsbfo2KXp+qFanckEnOcY8T4nNk2zEaszrStWvqe3O4qJ4cqv+xyX3i7vQ6JcPlBA9byf6f6p81fdnrfBzqL5cEaxUb046uQTVmOZGmy0Fs1IJqvT/y3VNOVEiQ4uJzzVGQu5jy86kXOBQcngFlwxxk7W08GeKQ2Jz+3ELIZyCH2x/90En5fslbC14GAoOFCsVvR4Mbn9ycOa2PADQLqPIXDxCORX8m5+gWaYuWdJq5SJ0yOeFPMqxNvw9k8Btkx9TlUT0463N5dmQrTjGQde0SMjrsq4XEPV5xjfFDjNDA503hPqCZ4YmJg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBB//VLEhK6g/80agJy+E8dF4neQcyILYM6j4yk/LT4=;
 b=vDBZUh43dcLr1SEdjmjUzOSvTQ0PRDrp0D7TRop0d15gZZqevDPj+9jPoiwAl0wVA77IsiDRgWu8kp9f/fkALVq99P8NOuW+tueyGAHrkh7HYwIY9YYiEpHLogMP0f6FhRxeJhhvSu72e7UdFP7ulDRWTnseIGKpbdy1ZYs191OHd5EIPJcJYVm9OopdndN47YpMutNOkhIS1YLBsYvL3IvE/groS5doyKZtUpelfxPMgXEi0qujmG6XULMEi6UmN2IEKbeKDfK0Rth44r349dP4eljF2TSadUIuhpqMgvV8L2CezoYtwxPKIszW3N0vz5+e2NjRDAJHAVNHdERPKw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBB//VLEhK6g/80agJy+E8dF4neQcyILYM6j4yk/LT4=;
 b=gApPnt0HDX22MZL8UCYv7qhzcxYVglMj2H331WmAqVz336+zlz5CZpR4PIzQhmwguN8VeNum4naES88Qd4470r60HK3ppzUDi3j0wRGlC87dAC0fpD0DfzToPI2ZEjRGt9sui+HNBakZFylRieemYhfUp6nqmAq50h3Y7PPH6U+/fYDpsKpDrIQSXg5DgQOre17Jcl7Y6OnYW1skWAdMak/YtZ41pG74Ymjx1Nuhz3sP5Xe49Q4mkYD1nZpDwnrcv0bhUTKLzxcUw3KZRVHFO21BrMNUo/ya5oaVcasrUCEGkliTom3GQldy8VqPTpBlcowDlrY1V3KA+Efe4I32hw==
Received: from PA7P264CA0277.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:373::9)
 by VI0PR03MB10282.eurprd03.prod.outlook.com (2603:10a6:800:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 23:42:10 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:102:373:cafe::99) by PA7P264CA0277.outlook.office365.com
 (2603:10a6:102:373::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 23:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.11
 via Frontend Transport; Thu, 16 Jan 2025 23:42:09 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 7565820080F83;
	Thu, 16 Jan 2025 23:42:09 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (unknown [40.93.64.30])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 1BB482008006E;
	Thu, 16 Jan 2025 23:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tu2VW7a0nlW/8f6eyR5jM2vREW0rEaaHK/Ncur8RCDiDLgfFDQQJCbGajP9Kcy1CNM3X2z9sfQt3wZkuYoz3ykhqCYtcZlrjty1ZNIx3bB4Zm7LGIsDFRCRJKfOD1+u953VahjLHttbbUK2NQyWhBlUD7N9zaOQfXX1tKJ9rkmYcqYc+jUB/DRvkaHHF6Q9BSMb8l/najHL+kEqZksopwMRexc4f4QEmkPngQHjcaKLPVUg+gXgCcEfYe52JO+CMMhwGhOWx3wmQOfrJ+g44xo0XwchJM1CNDY2AU/AWPB0B7a9DOTph6G7Uqt7nhHEI/+9+4P0Ux5r5wG3KPQibAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBB//VLEhK6g/80agJy+E8dF4neQcyILYM6j4yk/LT4=;
 b=sE6cTf9iVVEVpS52cu6mv+Spg9kSZtRTGM0vztGu/I/hYtGue5rornKwQbRNaIiHMifo3QS+hKawZpvDYbyQc2UwNOO97qWYzYpBl8CfPxfj+1q/kiKmZDOiNkN8UT2c4Q4+KjWlUc9ouT9hHsl77OpNvkD7q20opoFnL6ivkdWvTe//5zXcttqUqEjcwAVuGVWd3YIxgAOJt3OJSlde6kP89WtaUGepOAclM3o+shvb3D1pvd8I3hXNiFeEhR6+cEFwpECuC0EoESGbqjKVf9fd1Jn4GnegJg+Bs83hyhDNdXFmwv3AxkzAf5sTwFfang4Fwg6Lpv4zt+YwJsp+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBB//VLEhK6g/80agJy+E8dF4neQcyILYM6j4yk/LT4=;
 b=gApPnt0HDX22MZL8UCYv7qhzcxYVglMj2H331WmAqVz336+zlz5CZpR4PIzQhmwguN8VeNum4naES88Qd4470r60HK3ppzUDi3j0wRGlC87dAC0fpD0DfzToPI2ZEjRGt9sui+HNBakZFylRieemYhfUp6nqmAq50h3Y7PPH6U+/fYDpsKpDrIQSXg5DgQOre17Jcl7Y6OnYW1skWAdMak/YtZ41pG74Ymjx1Nuhz3sP5Xe49Q4mkYD1nZpDwnrcv0bhUTKLzxcUw3KZRVHFO21BrMNUo/ya5oaVcasrUCEGkliTom3GQldy8VqPTpBlcowDlrY1V3KA+Efe4I32hw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by PAWPR03MB9107.eurprd03.prod.outlook.com (2603:10a6:102:33f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 23:42:00 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 23:42:00 +0000
Message-ID: <a14851c1-9ec1-46ef-8862-97c94a1a633a@seco.com>
Date: Thu, 16 Jan 2025 18:41:52 -0500
User-Agent: Mozilla Thunderbird
To: miquel.raynal@bootlin.com, linux-spi@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>, Mark Brown <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20250110-winbond-6-11-rc1-quad-support-v3-17-7ab4bd56cf6e@bootlin.com>
Subject: Re: [PATCH v3 17/27] spi: zynqmp-gqspi: Support per spi-mem operation
 frequency switches
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20250110-winbond-6-11-rc1-quad-support-v3-17-7ab4bd56cf6e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::28) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|PAWPR03MB9107:EE_|AM3PEPF00009B9F:EE_|VI0PR03MB10282:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5e396b-57d7-4182-c841-08dd368764da
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NEZRZ3RvVFpsTG56VnFxYlY1ZjRhY1d6SmV2bUVBMng2c216RHlyN2dEYU5u?=
 =?utf-8?B?UWRkUWJjNUdJeHk2alppLzhnbmE2dzVwS1p4UUNZOHhwMzQ1T1VmaUlwVkxB?=
 =?utf-8?B?ZVd3akZOS2pMTENtNm5iSmVvaGVYaDdJdmgvK0p0a3p0bVBsSThlNWdxenlB?=
 =?utf-8?B?cTZNY3M4Ulp2Q3FVbUhXeHlwSE5NVEpDNjEzYTk4cEQwaisyNEkzclJpZVhw?=
 =?utf-8?B?THowNkRNZW1RQVRPeDVvaklKNVhYUVdxb21VUFJTMVYxYnA3NXd4a0Rtb3JT?=
 =?utf-8?B?NmYxaFZkTDNLT1dPZ1VRMnhYdWNSTGZ6QnZIRG9TdmJvSThkS0JESWljc1ps?=
 =?utf-8?B?eEEvZXdjQ2FyeFR6TFB4dXR4Ym9NaFlTZE4yMFd3NmRyRWw1Qzlpd0E1UDdl?=
 =?utf-8?B?T0JnQmNyTit6NlFqZnZJTmFxZm9GOTNHYmdZUmZGakZMaTZBaFA3eDU2ZVJC?=
 =?utf-8?B?enlZMHIxdmdyMVYxQnFuZmloZi9EM01CQWVFd0VNTWJORVp5UnhuZjBDM1pL?=
 =?utf-8?B?Tkx2enRTMGIvUnM2akZ4VlNhWHNOK3gvTExoT2dWaDNPMDg0TngycmxscXBG?=
 =?utf-8?B?Tzd6NTdmYTlQK3V4NWVranYrSTcwMnAyZ3Boa3hCd0YvK0R0SmR4RW0wQnVy?=
 =?utf-8?B?MlRLay9VbVpkTWtobFpqMHM3am83alZWVWJJcUNkY3lDYXZQTEMxT2ZjS2NB?=
 =?utf-8?B?MHArbk5FaFo1RHJHTWxUYWJFSi9JWTlWUTB3RGZ5TUdQZGJHVWw5R2pMVzIx?=
 =?utf-8?B?dm9uOUlieUdPR3hRSEd6Ym5zeE5vaEluQndGODNxZVB1SXN3RTBQenEvYTVL?=
 =?utf-8?B?cElLay9Id2JUSXZqdTFVM0RGQWlPcXd3bEpBYlBONy8wTDhVTnpxZ3BtaERu?=
 =?utf-8?B?TVJFSHR0ZHVJWEZLRlFDMlpBVEtUUEIzaXdDenByUW1qQWwrR2pnajJxTlZr?=
 =?utf-8?B?M20rbkNYV05BWE1jYytGaVdjeXpZY24wUzdMTlJjMjY3czFQbnFKenppcnFP?=
 =?utf-8?B?Q2ljWjhCWjBoOXl0WGs4bHRIbEZjU1JwU3JFRzh0NDY4YjRpYy9BUjRsbzc2?=
 =?utf-8?B?RVBWOGhCaDlOVjVKcndXbC9zWW5GN0EzMW9Md1VISWdveUI2a2hycmV2Y0Z5?=
 =?utf-8?B?OUlkRFI1b2xWa1AyaktKQTRHeFJ4WHVhMkpmS3lRRHZFSzRBWWNKZmFEQmpT?=
 =?utf-8?B?MHpPRVRsVjdYc0UyTmgwWXhmUGlHZkdiMTFrQmlUcjF2U1hlUFh0cHR2cUJp?=
 =?utf-8?B?UDVSZXFRYlpUYk1WU1h6eEx2aU1OVzRsSU5adWJ2eGNJZkU5cEEyQ1JuWERZ?=
 =?utf-8?B?U0RObVBXWmNCeDBEc0FQckNIeWFhQmwwQUpqSUJDaHZmckcvTi9rS0U0WnRx?=
 =?utf-8?B?OVdnTFZvdEdJYWJFRVdHOXAvZU5MODhPNmdUYmtNVEdyS1h6K2FyTnpGV3ps?=
 =?utf-8?B?UW9MUjVCWGFRbWZiZFQ0UnV1bFZOc2FLQUkwSGo0Wk1LUTRBVUQ0NDVXeldq?=
 =?utf-8?B?MTlNZnkwYndiQnp1a25oVkZhTkZQckwvOFBESFZqUTBEdjJVemt0WlI0SHRy?=
 =?utf-8?B?SUhBc1BORGxtNnRGdzlsazJIbEdQMXdJN0JVT2c0aU1RK1ZRRXlGY2tNL2Qz?=
 =?utf-8?B?ZWVLQ3FUSG1ETFVuNW1hK2l4Y20vUUd6VEg0YnJHdFQwUFQxbEh3Vmw3R2ZG?=
 =?utf-8?B?NXZYd1pHMDR5VmNKNSt6dTk5SllSWVk5VEdaeWJGd1hyaWhmZGpySTE3NzM2?=
 =?utf-8?B?R1NnUEhESmNSL085UnJlTVZJNUZYSGlRTjlJVmNhcjJyNUY2by9RTUVhVmRw?=
 =?utf-8?B?dGM0NmVPY3VtZEdSMThCbmJSM1Z2bU5JaHRVbE54Z1N2aUFwazJQQytDQXVW?=
 =?utf-8?Q?Wkmu8/Gf0D17u?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9107
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c3a29bfb-44de-4c03-ddb1-08dd36875edf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|35042699022|36860700013|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjJEeXRaQTdTTlA1RG9aekw5Wnk4Z2p5cjNRZVBNbUNPNmFNTlByNDlkZ3lN?=
 =?utf-8?B?NDh3QjhUamhkWURQTnBHR1dQWUIrT1RhdFlXZ2pTVlhiLzdyeE1RMGQrSTM0?=
 =?utf-8?B?QzRZZTFtclV3OUw3eEVPQUVZUmlpNDV5ZWpiL0tRZTVZNnRnU1Q2Z3FqL1V2?=
 =?utf-8?B?TFRGR0I5T1Z4cWVDL1lKZ3NkcE1JWXBpMVovMUFKQ3lSaXp3dFVaNnc5K01C?=
 =?utf-8?B?OUNlc1I1cnM5L0tqMWwzemM5Q3h4djY4Z3FKTWFMRUdxMFo2QmxrZWNTWno5?=
 =?utf-8?B?QU9tM3hXWjR3UHVTVXdGUWJ1dFcvazRHUXlnT2J5Q2o4aCtISjVRbjhEQnNV?=
 =?utf-8?B?eHE3bWhka3M5K1dKNHlsalVCdE5jT0VIRjhZTGFiOFBVcU1id1ZML28vVU5H?=
 =?utf-8?B?R0FwbFlCaUZaMjlaU2lhazBVVDZWajc0cWQvb3hia1hWOXVGUVZCWEFRNUxU?=
 =?utf-8?B?bVNDWGY4SWQxUkdvdnhXUjNMYzE0WmpuZjFFNGQ4d2dVV1k4NWpTd2svMTdW?=
 =?utf-8?B?ZU1SUGxaNmlaSHVCYWJwbk9RcEpLeWlvV1daWnU2MHNLbVdHTXRMaU0wMm1U?=
 =?utf-8?B?WFlSNkRTeWZxOElvZ1A0V1I2SnFrQ3hac3k2OTlDQjFqWDltczZ5ZnZNMDh3?=
 =?utf-8?B?b0MyMVE3cWhoOHVVYkdTNzdic2Zvajlic0trdlFjcnI2ekk4U2cwaDZCSy9p?=
 =?utf-8?B?VDdRR3dQN3VVdnFJNGJwUCszemg5V3NsTlUveXZkR3ZHS3ZqU2hXNkVGbUZR?=
 =?utf-8?B?Ti9JRXdsYVlyL1RsU3A0MVFnOU9aU3doYTR2Y0ZPMzJpQnM5bFNtWkRWd3VB?=
 =?utf-8?B?dFd4OW1qN2x5S3FhVVNBZnVrcG5HTHdnclgvaXhOa01BRUdmU2JTQVBsaG13?=
 =?utf-8?B?b0pvR2VQMVVZdEJZQUNHd01OZVY2M1VTb3JTZXNzL2I1ZkJPL0QrK3N4eTNZ?=
 =?utf-8?B?dlJrSHdjMlBiSW9IN1VVRkZJaVhHZHo3bnhwbmROcFB4L1JkWFZJMldIN0Fz?=
 =?utf-8?B?NE0vTVFCaVlOT3UvMWdZSWpoN3NNZUxwREZVS0hpOE5rUmE2SktZeGxyekla?=
 =?utf-8?B?RE5OUlNyRTJ1RklkWHd2aTRWWHQvc0NWa2x5blRjaWF1UlM2SjljdGNIMXho?=
 =?utf-8?B?emFhbjFyMnRkUnBicnlzZ1FpL3g5WVR3RDAvV3N4OCtQcjFiTUNYcTJIL1d5?=
 =?utf-8?B?dlo1Snl5QjdyTU1jUVRaTlpqT0xWMDJDSm82Ykl1OENlc1BsTEpSUXBKalFo?=
 =?utf-8?B?ZE16UjRKVlZNcUN5SHVQbHBIWDNxZnE3WlZNbVd3YXQ1QkxkQXE0dTh3aFQy?=
 =?utf-8?B?VXVsMnp0c1JoU3VEdWU0VmxhZ01jVVRBcXNOYXlQNzltRW5SZWxkc3BxajdL?=
 =?utf-8?B?cnp4bnNUUjVUMEFvUzVXUEUyemxncHNYSDgvaEFydFhUcFIza2hGY0ttNmU3?=
 =?utf-8?B?eEhmSVlnK292UC9OME5PN2ZMV0Q4eGhGM0pVaE1vWGRNamo4Z2VUWlNQMTVw?=
 =?utf-8?B?MFpRTTFFczBLKzFTOUN0OU4zVDFrK2FYZWZtYjFNZE8wOE5uZGhYejV5OUN1?=
 =?utf-8?B?TEs4ZVlzL0JvNzlEZit2RXVMUTllaCtnMktoTXJCSHNIUmQ2VE5WY0lacys0?=
 =?utf-8?B?ZStuWmpxWjhNUGdMcVNtU2VUZVE4MDZuVXhoVGhBRzdQeHZtQjBERW9XV0dT?=
 =?utf-8?B?alVYUCttdzhCdFdFNHdneTRUZzZmWnFSUlAzQVk1R2lqZHAvY3liR1Z2ejZY?=
 =?utf-8?B?ampkb2Rzd21GV1BSS3FEd3NUTWprMUFNeE8xRTdpM3lIY2cxTGNQR2xvckM0?=
 =?utf-8?B?cVc0cm8yNkNXQ1VVbjgxNUZnWXhEY3hybUZZOXh1K1NlZzRNVEt6RzA3UGNK?=
 =?utf-8?B?dWdxUlBsWTJ4NkpRSTRBUWJxS3J5Z0VaVm5MMXg3T2tKOUZ2VFNHMWp6RkJP?=
 =?utf-8?B?VTJ6ZXpBbVVoQlgwWnFmVzVyay9kbUtDakhyOEtXMmxPdE42djlJcWlBWXV5?=
 =?utf-8?Q?mKKE0XMRcBsID9GkUhQAyMuqCAzBls=3D?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.87;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(35042699022)(36860700013)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 23:42:09.6710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5e396b-57d7-4182-c841-08dd368764da
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.87];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10282

> Every ->exec_op() call correctly configures the spi bus speed to the
> maximum allowed frequency for the memory using the constant spi default
> parameter. Since we can now have per-operation constraints, let's use
> the value that comes from the spi-mem operation structure instead. In
> case there is no specific limitation for this operation, the default spi
> device value will be given anyway.
> 
> The per-operation frequency capability is thus advertised to the spi-mem
> core.
> 
> Cc: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-zynqmp-gqspi.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

But this will conflict with [1]. Do you think you could add that to your
series? With that patch, you'd have something like

-	zynqmp_qspi_config_op(xqspi, mem->spi->max_speed_hz);
+	zynqmp_qspi_config_op(xqspi, op->max_freq);

instead. I can send that patch by itself if it would make things easier
for you.

--Sean

[1] https://lore.kernel.org/linux-spi/20250116232118.2694169-3-sean.anderson@linux.dev/


