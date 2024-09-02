Return-Path: <linux-spi+bounces-4498-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC7C968047
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 09:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9EF1F245BA
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 07:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CE515DBB3;
	Mon,  2 Sep 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oacA8w3s"
X-Original-To: linux-spi@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2058.outbound.protection.outlook.com [40.107.117.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694522B9BB;
	Mon,  2 Sep 2024 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261360; cv=fail; b=tjHrqhpBX5/a+xXb/a2o8fpCwT8SCK80nXYiML+X6WbcA7QweSSc9s6Kw8SkbY1moDIUNhRHXosovVYb6rUIiKtkh4oWECO1F1EB5E/JD4s1tC0a2bsAeYVGSob0lP9bHgA9ugOOBCAhjqk8WRlw+E2Ubu+PDvcDsSmiz1WdH/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261360; c=relaxed/simple;
	bh=MQbnna28hGgcMbdPyP87oM6FtOFiHcIH+DTTfyttU54=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MWcLnwi3bZ7IqGcGs0ZpbCi7CykvfIMfysb7+buo0y7cuoxCihlrG88PvZ5XIHJ96/WmmO9liCmJRRXeK7Gnt97qSKeMZ9qUIycE6SdK8zWhtezQxaWRzZnoBV+qR7zU6+9hEeQjgu5yk/Hov4FyKMGGfQYSo9LYd5pZJgSaPiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oacA8w3s; arc=fail smtp.client-ip=40.107.117.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTUUlm35zlrZVGbwCudpjPPuYQYk9dd7shok+0CVFeGmSuiNarT55Y0yGnU3voh/T+612sLuP0fcY5+jL3ELMU/WSjFgzSBrpFQEgYUOHToFnGIWCPhuienttDLuilne8N8Govh+7k8UzhE0dTuYzM43LX65aiC2vVDl4zi3st1qv2+AU6H4lrfoWzEfvRzUC+XnWM/2+Mq4iplxWvgt3pWFP+WIBfuxRaxfLdBqm3R/9rpDaOZqQnb4FxmQtEY9tKtydU6OUj4Ri4FarG2ZgORFsxAI9+qHazZWX5aISGdB2vVjHXOwnN81CrIGdjRr20cVB45SrQUCN1eimjrnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TcRTUnx0oejxdM92bFUaWmGAnBAUpuPBg8W6bwMp8c=;
 b=MEiHV22872kYr8rP3drTXV8QcRxshTMce3uCdQMWljdHbJI53h9c1IGVDkOF0ayvQr2fuxWNP4KF3hrsSU/S9ai6B1VHTeYedMi7XMnZ2i8Hlf17j+4YYsRz4CT7U8Fk4U8TRWxKILLun3GmrtXDNenPtD89vHJVGLRXHD4orXv7UYdl/FeMkxuTVLpOfYO2/c9bGI66gi8Tukv3lvsNtWylY1tEjIopzQ8fapU8qHu7H/EHCUXu+RFAqCUlmYBN26WCiHUQQbAPnoQn5MRykOM0kYnHlBUhSBDk22Ra2v89yB3nK7MTijI5BVl7mcXSigmqiGxx40D1NHdfczbxbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TcRTUnx0oejxdM92bFUaWmGAnBAUpuPBg8W6bwMp8c=;
 b=oacA8w3s3LR8MksmB7PVFKwJzl1lowq+h2u471QD82NwAfICKH5uP9ZHNtgiCpiZfyZtuEbjLOIQeeWR/GZHZE1Y6krUUv/4vq8OKl9ratB2AivvIMwKOPg6jvQOQe2EbWH2Wa4xU9D4AoHOzQFL6hnY/6NzHYgndmD8CwIJhQQ9j8i9U7wvJtB79XhSUBMRXEtge71wDWHwn7GbqWOqKcComJHxbRady0YmHkPY2An6wsfEr/wU/6DlygaHVuC5mUsjAfZZ/MA4cFt4DWC+kB0v1Kg/lwM3TCCM4lFa/GHIpaUpuORFt7/2HatvwN+FZbo12Crrm5163amPWqJPug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by TYSPR06MB7160.apcprd06.prod.outlook.com (2603:1096:405:89::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 07:15:53 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 07:15:53 +0000
Message-ID: <b397b47e-f1fa-4589-9f07-d59ce743ec89@vivo.com>
Date: Mon, 2 Sep 2024 15:15:48 +0800
User-Agent: Mozilla Thunderbird
From: Yuesong Li <liyuesong@vivo.com>
Subject: Re: [PATCH v2] drivers: spi: Insert the missing pci_dev_put()before
 return
To: Krzysztof Kozlowski <krzk@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang
 <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Yang Ruibin <11162571@vivo.com>
References: <20240829033511.1917015-1-11162571@vivo.com>
 <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
 <4e2ad62b-b11e-40db-9cd9-a26f7642c735@kernel.org>
In-Reply-To: <4e2ad62b-b11e-40db-9cd9-a26f7642c735@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|TYSPR06MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 385fdfed-db86-4225-5a73-08dccb1f14c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWN4N3BDTEprdHRpZld6NnFhUjB1ZFkxSFJJR3dyOEpWY1ZJV3JpaEpWZGFB?=
 =?utf-8?B?bUF4VXlGTmRGUkhqVGFNbGQ4OEpHSTVKN0MwVnVkOEd3c1N3a0RYc2lTQ1dD?=
 =?utf-8?B?MmhaN3g2ZkRSdjNNMnRvY1dKUzJKZTB4RXdGek9nMXRBSkhKRy91YTBtbHhC?=
 =?utf-8?B?RXNKaGVEa1RXcjlNTG9wSVl5SjBCRjlLYjRpN0ZOeWw0VEdkenhXcnpnUWw4?=
 =?utf-8?B?Vks4M2t5dXIvQXorQUFWZGREUzZ4OFM1ZDZqL2s5UlZMT1lyRWpLb0NrOGMv?=
 =?utf-8?B?cWU4S0JRR2NiNDNqYnYvdTFRYkhtaEVBa21MTmVkYjUrdFMzcWVRODZpKzdS?=
 =?utf-8?B?eXJzMC9BWHpOa1o4SExDQVZmazVSQWxISDBTZ3NYSzNDbmZidlh5bFVpYUtr?=
 =?utf-8?B?UXZOLzBGaWczYWM3SnVJalNIZE1RbU1OSmNTenZId1RPaTVTSXpKMEduTnB6?=
 =?utf-8?B?RDdBRmVCZWlBTXpRVWNrZGpEWDcvcFVWenVjdjdnN0c2ZVg4emFUd2NVRlZ6?=
 =?utf-8?B?Y1hKS3NHZis4c3RHNzkvbXE2M0IvVWlMbG1FeTFadEp1Q0R3azh2MEUyRzV5?=
 =?utf-8?B?ZGVoY2VTdVJDRTlEY1ZDbTN6VEFmSHVUbHpwNUpDVzlGQzhDbzA1ZWN5TkFV?=
 =?utf-8?B?M0x1Y2RZa2ZCOUxZK0ptN0QyeUZpNERFRXc2aS9WbUlDS0dZTG9INzdJSTQ3?=
 =?utf-8?B?cERuTkZaTVNtNnFYRCt2dThFQU1MQm9IOFhpMjgyVC9IaUhEM1NmWkgydzB5?=
 =?utf-8?B?V0Y2RUd6TlZDNGtNYXNjeTJqVko2bjE5eVUwSitZV1gxbFhBY1d1ZmR0TXpM?=
 =?utf-8?B?MjR5Uis5MFlzWGVuWHZ4R1ViV0tPL3BIblREL3pzUzhwUjJzOUNqdnpVNFZL?=
 =?utf-8?B?MlZZbWNsNUZFYlZsTXhUYVlyclNkazNVcUEvQlhValFCdUZ3S2FWdTRPME00?=
 =?utf-8?B?T2RERkgvV1l1RlptVFZPZUQ2eGpPdlZ2bkQ1dzdXZkxTV2xpRWs1SmI5QTBm?=
 =?utf-8?B?elZVeWNNUFRhWlJWRVd2ckd1aGU5M21YbWVtSlpnMllpdjd0UHA3cUJ1N0Vs?=
 =?utf-8?B?MWh0WkdEWEZBeUVmcjRnMUJkZXdVb3V2UWkrOGhWQTFQa1IyU0R1bWNGS1hE?=
 =?utf-8?B?bVRVSTBsaFZod2R2bHBzM3lkcUJPdTV6SEo4dTRhYmJoVDBVTHRVQ2l2R2Y0?=
 =?utf-8?B?aTU2blZhRXBkUHFFbTl4RnNHclVjUWxMbm96REFOZ08zWHhLRFVqZmVQZEpu?=
 =?utf-8?B?cXJjeHkzTU1aY3JmRWFoTTZJR0x1TDI5L2NLeFJqZFNPTVhEOUhEenRrNFYz?=
 =?utf-8?B?bHovT1R0T1gxTVI2OEFFVlh0VGZKZUE3Rk5pbXVrcGRqbWlvL2FFK3hzYW1j?=
 =?utf-8?B?R29FUWdyQjRSaURORTJiMmhVUzNZTXJQOHNuN0Ywc2FyVEV6ZXhlSkdYVm8w?=
 =?utf-8?B?emcwdU9tYWttU1l4V3kvT0RZUDcraFhlVnU2d3lUVU5PVm95dFhLbzZnemZj?=
 =?utf-8?B?RDRWNWsyV0I5M2hudWFHM1dzTkZYNmozbjc4UUdGb2lUUC9ERkJNMkZGcDJV?=
 =?utf-8?B?SXR6c2FRNFpPTVJhRms2Tm1TWGI1aG9ZM2NSUU1tMjJkWUUzVmM0Nk9RWDhR?=
 =?utf-8?B?ckdmckNNcEdaLzBvM0hhaUJDaXZnQU05cjhKZ0tIZVFhNVJtakMrVmJmcUlJ?=
 =?utf-8?B?eUs4RVNQRFNVa1Nidk5wcm51U0JnbDFaMTBhUEtIRjMzZThxMjFrY21DN2hG?=
 =?utf-8?B?OTRCNWhNWFpOM3ByUzNGL1VVZHNzVzJBb2F0NWM2RHVWdG9pL3F0VEIrb010?=
 =?utf-8?B?WXlWN05CQ0NmL3ZEc0NGZ01mTm04djBsa2loT05PQVhXek9zV0xBdlc5bmI2?=
 =?utf-8?B?cnUvcVZDRjAvNkcwOGtFMy8yQ2NXWE8vdERSNEIxY1luMnQyNzZPNm9zWERj?=
 =?utf-8?Q?mAR/KTMWuy5Lf5yZOVriBanIXI/oWyGI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1FFOVUrSTc2VzdrTVFVakQ3NDFveFdsanlkMXRHQlBoVldEUE5XK3VjVnZ3?=
 =?utf-8?B?eDUzR29OYWYrVVVMOVN6dHB1MzBHNXJOS1p4WUxKdHJvbmZYVzQvY1ZhY1VM?=
 =?utf-8?B?MndlOC9OWnNWQ3RmVzZtYldweWhXbnFEOWlUVURPNnl1NTcyOXZzcTBvK3hj?=
 =?utf-8?B?WGdhZVJGU04wN05jdUxCSVhHZ0lIU3hWeTVVaXpsSVJlY2xYMkcxVnNPZkpN?=
 =?utf-8?B?c0puRmFxVzFDb3NWRlN4dk8yYWRValBVUFUzcjBHelVpVUdzcTc2M3VHaEg3?=
 =?utf-8?B?cEl6ZEdjaVhSczdCUzNKL0lkUGRrejBaYWZmOXI4ZlArM0hqbU9pYnMvMGh0?=
 =?utf-8?B?amowNFhQa1hqbkxCU2QxWHJGaDArRThnckNPcjhMUlhLOFdHeXV0czhLbEJE?=
 =?utf-8?B?ZWpiRC9TWktMUzR6NDcraUxPbFNuTDRtdXpGZUErQk1wN3dhOEg3QWUzUk1k?=
 =?utf-8?B?c1VRY2VpRmUxZUJrUGo1TmtnUi85RDZxcWF1cURXckZlU0kvVDBGMjhQQ0VO?=
 =?utf-8?B?Q1ZkUVE3ZklFdjgwOUN6eGRlSVV4dXR5M2luaTR5S1pQenAyVXhmdm5LeVM3?=
 =?utf-8?B?VDZJTVN4b3BoLzNFNVR0THJyc1E5UEFVbGtvS0hNKzQ2VGQvUXBSL3h4VmtS?=
 =?utf-8?B?RkNLbGRYOXJ3eDdGRDFBTUZ3QXVXS0tjc00rN0czS0NCTDY5QTZSZlhhMHRn?=
 =?utf-8?B?b1A2alExeDB5ZjUySm9Zdk9DWE9ZUDVoSUVNU3dJZmJ5K29iaUtuWE1ldE9J?=
 =?utf-8?B?b0ovRFkwQ2hqS1Jma0RvWnY3eHcrVUNiOVRaa3VHeTB4dlhKN3h5SFJJZG5F?=
 =?utf-8?B?N0xraUowZmFHN1oxUjVUS2QzVWU2ODRKZHdsWGZRMC9MZjNBTG1QejVzU2t5?=
 =?utf-8?B?ZkpPSDVYZWVoMzQyWEhmU0VzWDVMVkR6anh2OHBTUG9NdHlVeDFwWXpXWUJi?=
 =?utf-8?B?UVhsZWFPQ1B0TU5pUzNlNW43MzJKNDhlOGpsUGZTODdNMUJUQ1N6OVROajNH?=
 =?utf-8?B?NjdqZFNqRjYwN0hYVkpaVEFNNUMyVjdBTHJCSTZpQnZ6ZmJTQnRRKzJFUkM0?=
 =?utf-8?B?b3dmWXBKTmxiSmNDTlB2RHR1aVdRSGh6eEFnQ0E4OFZFVzFMSE9aWENUQ25s?=
 =?utf-8?B?ODhCRTB1TUhKdmhBalpkcGloNHdMZkgxazY0SVo1VEJ5SXB4ZzFxcGVpQkNr?=
 =?utf-8?B?cGJiMlJPMlBVOUIxRHYrbUwwTHdaR3BIOVFFbXVlUVc4WmxkcG1Vb1RvMHZ5?=
 =?utf-8?B?cDZtNTM4Mm5uWDhmeGhZa0xqdzhSQ3pmcG5mejlhOUNQK0dEcFZVVUV6Y211?=
 =?utf-8?B?Ui9EejIvUkN2YnZXbENpcUZjR2ZhZmV1SU5HQXAvQy9MT3ZDSlpISzdGOTlj?=
 =?utf-8?B?NU9NcVo4ZGZ6VUptelp2WFpyRFZtVkUwaEg3M0M3U3ZkVnMyVDAyTEtWMCtv?=
 =?utf-8?B?NkFoMXJVTnBBM0thU3Nta1YwOS8rKzJYdzZhQWtRN25oRFpKYlFUOGtpYTRo?=
 =?utf-8?B?NEZwWThWR09XZ2FZM2xNTEhXaHY4VmIvYVpsYStneFVwcEtQcU9UMGszSUZP?=
 =?utf-8?B?Skw2TVVnUzFQOXkyWStSUk16Mmg4QitSMTNLeStNRWF3YUNFSWduM1d3eUNH?=
 =?utf-8?B?OCt1U2N2NzhDOWxSS2luQXFXV09WTGhMb0pUTDFsczJHVHJabWFpWGxtRC8v?=
 =?utf-8?B?KytKRVpvNmduYzlkN2VGdVRIK0JGZHFRZ3lNNXdIajBxUzNhaDE1dW9CNEFa?=
 =?utf-8?B?aFAwUFBKNVBtK0pqMHVmRDNLWUxxWElFbzdLZDJLa041MkR1d1AxMU9DR3kr?=
 =?utf-8?B?bVVMdlNJQ1NRQVRiVmw2WlRyRUMvOWtBVkdmbzhqeDBQMXByYVhIK3ZQdWx6?=
 =?utf-8?B?RlhIQlNhVEtHT0pxNnltNFdnTkhIQ3ZyWWQ5SEJ5VEh4QWRaMC9Ed05ZN1Jk?=
 =?utf-8?B?TXNhY2p3V3hmaWtuaHlOVWQ0eHdZN1JpWWpZQUl5d2grYm1WWmozWktuU2Qz?=
 =?utf-8?B?Y1c2bTU5andVN3l0UXhjaWZuVnliS0FUbElsUU1TbUx1Z2JiRFpYTC9lcHdX?=
 =?utf-8?B?YzhZaUVYdkk3dnBjV25qbm9CckR2RE5aWTRYSXBTejJnYWo5V3duQWVJdlFP?=
 =?utf-8?Q?pLGuQBMK8GqWHmSBpFEj6nC/o?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385fdfed-db86-4225-5a73-08dccb1f14c5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:15:53.4783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRw7IKE9mgjAEPNwykCR9gUBWv2qE+mntCdhZQsocOnC8FAnPNxXoWDaJz0VchqGvs3J9tPdUHEAL1afXZyS2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7160



On 2024/8/31 1:10, Krzysztof Kozlowski wrote:
> On 30/08/2024 10:55, Geert Uytterhoeven wrote:
>> Hi Yang,
>>
>> On Thu, Aug 29, 2024 at 5:35 AM Yang Ruibin <11162571@vivo.com> wrote:
>>> Increase the reference count by calling pci_get_slot(), and remember to
>>> decrement the reference count by calling pci_dev_put().
>>>
>>> Signed-off-by: Yang Ruibin <11162571@vivo.com>
>>
>> Thanks for your patch, which is now commit 8a0ec8c2d736961f ("spi:
>> Insert the missing pci_dev_put()before return") in spi/for-next.
>>
>>> --- a/drivers/spi/spi-pxa2xx-pci.c
>>> +++ b/drivers/spi/spi-pxa2xx-pci.c
>>> @@ -146,8 +146,10 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
>>>          c->num_chipselect = 1;
>>>
>>>          ret = pxa2xx_spi_pci_clk_register(dev, ssp, 50000000);
>>> -       if (ret)
>>> +       if (ret) {
>>> +               pci_dev_put(dma_dev);
>>
>> dma_dev is still uninitialized at this point.
>>
>>>                  return ret;
>>> +       }
>>>
>>>          dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
>>
>> dma_dev is initialized only here...
>>
>>>          ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
>>
>> ... and freed automatically by lpss_dma_put_device() in case of
>> any later failures since commit 609d7ffdc42199a0 ("spi: pxa2xx-pci:
>> Balance reference count for PCI DMA device") in v5.18.
>>
>>> @@ -222,8 +224,10 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
>>>          }
>>>
>>>          ret = pxa2xx_spi_pci_clk_register(dev, ssp, 25000000);
>>> -       if (ret)
>>> +       if (ret) {
>>> +               pci_dev_put(dma_dev);
>>>                  return ret;
>>> +       }
>>>
>>>          dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(21, 0));
>>>          ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
>>
>> Likewise.
>>
>> Hence this patch is not needed, and introduced two bugs.
> 
> Cc Greg, Jakub, David and Paolo,
> 
> It seems Vivo (at least two persons from vivo.com) is sending patches
> generated through some sort of automation without really knowing what
> they were doing. All of the patches look like innocent
> cleanups/simplifications/fixes, but they do more.
> 
> This patch here looks like introducing two bugs.
> 
> These patches:
> 1. https://lore.kernel.org/all/20240830033251.232992-1-yujiaoliang@vivo.com/
> 
> 2. https://lore.kernel.org/all/20240828122650.1324246-1-11162571@vivo.com/
> (I sent a revert for this)
> 
> 3. https://lore.kernel.org/all/20240829072016.2329466-1-11162571@vivo.com/
> 
> and probably more...
> 
> introduce dev_err_probe() outside of probe path which is not desired,
> because it marks a probed (working) device as deferred.
> 
> The patches look trivial and/or helpful, so people tend to accept them
> through default trust.
> 
> I kindly suggest reverse - do not trust them by default and instead do a
> thorough review before accepting any cleanup/trivial patch from @vivo.com.
> 
> Best regards,
> Krzysztof
> 
> 

Dear Geert, Krzysztof, and the Linux Kernel Community,

I hope this message finds you well. My name is Yuesong Li, and I am 
writing on behalf of VIVO to sincerely apologize for the recent issues 
caused by the patches submitted by our team members. We deeply regret 
the problems that these submissions have introduced and the concerns 
they have raised within the community.

We recognize that the patches submitted were not up to the standards 
expected by the Linux kernel community. It is clear that our team 
members did not fully understand the implications of their 
contributions, leading to errors and the need for reverts. This is 
entirely our responsibility, and we are committed to ensuring that this 
does not happen again.

To address these issues, VIVO is taking the following steps:

1.Training for employees: We are implementing a comprehensive training 
program for all employees who contribute to open source projects. This 
training will focus on understanding the intricacies of the Linux 
kernel, best practices for code submissions, and the importance of 
thorough testing and review before submitting patches.

2.Enhanced Internal Review Process: Moving forward, we will enforce a 
more rigorous internal review process for all patches before they are 
submitted to the community. This will involve senior developers with 
experience in the open source community who will guide and review the 
work of less experienced contributors.

We value the open-source community and the collaborative spirit that 
drives it. VIVO is committed to contributing positively and responsibly 
moving forward. We kindly ask for your forgiveness for the mistakes 
we've made and your understanding as we take concrete steps to improve.

Thank you for your continued dedication to the Linux kernel, and please 
feel free to reach out if there are any further concerns or if you have 
suggestions on how we can better align with the community's expectations.

Best Regards,
Yuesong Li
VIVO

