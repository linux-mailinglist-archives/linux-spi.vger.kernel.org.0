Return-Path: <linux-spi+bounces-3334-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 283298FFA1C
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 05:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D02BB21575
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 03:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4D14AA0;
	Fri,  7 Jun 2024 03:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="Na8wNpdX"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2100.outbound.protection.outlook.com [40.107.244.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7214269;
	Fri,  7 Jun 2024 03:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717730077; cv=fail; b=p1Pt+bXwwOPYQf/phPFb28P0Mx4oJaTsh5Zhrgi9KZx1Hxdx5mQtCT3O8q/AJQU+ljh1r3YulxiQVZalbqYS20mohRk6jIggP1n2eDuWIsfF5aUW7iHjIwZBrWOtWA6KzheGTJQX/KWDubsnPiKcb7qkEmhkeJVFHF9KkHNAhzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717730077; c=relaxed/simple;
	bh=R8XpW7F6OTmUGjXdCtwtDqsN6cuh11ciDdJDwIu8qzI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JLX+fpBanJLvPANqUpEv60m/RN73aZbBrfw/OsmG3Hbefl1a5zJZA0fQ8PKLbzFPo/v3Nfb9EHOzBjEXVz9wMzvo82FadromU4WOCUjVlOIUYPyIwD0e7eSJR95AtQqVB1/IkS4pXrEcS3fPChMXqroRfHR3T20UypTqEljcON8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=Na8wNpdX; arc=fail smtp.client-ip=40.107.244.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja5SJG6W1Qr4ukC0IWXAScBaYCmmbh7x44c32+wM9KYWz1bFWx+eIdDzXNrAS4I0qk1Fwvs2q6QzHmScV1wjg95DD/yAqBcwfQheZXRoI097D2vErEhwVYj7MMWSSMeKQU6RDEL60XiisIjHqR03pbZySHJTTsWdOoaVJtXf/e5G01GSeiDqTfuxS86/VRQdpTTjc1YVQNBytdponRskl0cWqaQ7HpVhWgsxBRH0qoh0v7XasDzIsCr1druQ5gukiZ9JQCLlt7Vw2/mHVdT8bT1NBo1OUrs115ArEWt03IjacjAG9e7BWOVMfhmClZDNgnw42iONa9nhHWyJmBmwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAlU0DnR/RRQyGGBPBnfA8UtDmjDM1xPSREZsuJd6EM=;
 b=fVPaLvrQkoXA945lV2+4aXs3t18SRhoSibVW6KFEnuw2hJ2MbkegT96GyTQyOrprenyYzITAn+eJ6gNLzcqkBIq3Ox987M0m5XcyN+MYSr5emXPKwBaZ5IxXYP9VW4FBE26CnpshLLgpbYyYKLpa/oJ9Xqfyb/Nffy91z7hRfB4n0zTghGezYc07Tst8jleGJqHskbKgm8zfu/WrICBu4y6dwWhnX0xvwq1wxVx4qCRT8Z9v3bQzmmaAnCVyi/1i+VrdQ1I494/S01MTNCzmpQh1j4KRIhCAEVKaqEOvy5XTavspdZXbTjoQzdbduIbU43+yxSy1BlInBbJDGFTXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAlU0DnR/RRQyGGBPBnfA8UtDmjDM1xPSREZsuJd6EM=;
 b=Na8wNpdXkWZydT3mme/byaSWOvcgEl45zpBr8HNNPip+cFGSX2aKQUk1tXXC7QTYjOplkrI1O3s3gPS9hfzq5W/V5LgcFouLF4lhTatdnGa5FTniW0jiVoKbKul4VvNWN4OaL24fY/uFqoNAacnpqV22uaZjcxpoxGevm2ESkrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by PH7PR10MB5769.namprd10.prod.outlook.com (2603:10b6:510:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 03:14:31 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%7]) with mapi id 15.20.7633.018; Fri, 7 Jun 2024
 03:14:31 +0000
Date: Thu, 6 Jun 2024 22:14:27 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: omap2-mcspi multi mode
Message-ID: <ZmJ7E305ow91ez2U@euler>
References: <Zl/V0dU6SjAMkpLG@colin-ia-desktop>
 <ZmFt7yfZFFJdsZuJ@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmFt7yfZFFJdsZuJ@localhost.localdomain>
X-ClientProxiedBy: MN2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:23a::12) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|PH7PR10MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c708c58-04e4-44e2-aff5-08dc869ff29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUs3MVJOY2dPMjBRMVltR2srY0tIYkhmZG5jNDk0QU55ZDFJTllsUTJ4dlV1?=
 =?utf-8?B?bzRCMC9GRDFsQjBqTHdoa0Vxbnp6RjBhM1o1K2dpVXcwWklUMWFXZFZSVnp0?=
 =?utf-8?B?aDhabi9kc3VUT043V3JKdXBRaEkxbW9UUUZZRlFtS1FFNDB6cmJ6Zy9NeWZp?=
 =?utf-8?B?ejlDaTQ5WUc2VmtrMEpIcG9IakdKckVtb3NkWlRuNFQ3N2p1MEtBREVlZ2Ft?=
 =?utf-8?B?YldTek5qVXlQMUlDdEpFMURsRDR1Zjd0cHF1cUtBN3psMWZiRy9JeC9lVnky?=
 =?utf-8?B?TXE0MWlBQ2IzMFd4dGEyRzNhRXFqeWVwOWRIWjZCZjVBQnZLTjVnUEV0K2N1?=
 =?utf-8?B?V1F5UkJYM05JL0djL0xJYi9UNHhqbTl2QzBGenI2UGFvS2NwdCsxK0Q4WUNz?=
 =?utf-8?B?R1N1RE9yclEweVhlUjNzNEE0aDBHR0dPb1d0OHdDVVpWb3J0Ry9BZkRJR29w?=
 =?utf-8?B?VEZwU2pDQWpobE05WWpzcWxUQlJxMUdpY0QzSWZ6UmkwanMvdUJrVmZ6WnRY?=
 =?utf-8?B?MGlXc2Qzb3JzaHlTdW4vMHkwU0dHYUxnS2dqZUJPT1ptTjM5czVLZ0hvby96?=
 =?utf-8?B?R3NrWTB1RG56TGFnbUc2blNxSXM5bC94Q0o1ZHZMK1hEb2RGbm5GTndSK05s?=
 =?utf-8?B?eVd1MlhkU0dacytid0huN1ErbkhEeXRqazBFOGFVaUJ1NVpGVnRwTXFFTEc4?=
 =?utf-8?B?ZUZnQXA3YnRZMHplRDhrRHErUWgwME8wWHdFN08rcU1admNHeUhSd09FWkJM?=
 =?utf-8?B?OVhJRlh5Sk8wTXZCQzk3a0VuSktPWUxBTzR6Vjd4WkVha3l1eHpabjZ0bzha?=
 =?utf-8?B?ais3VmdNVGpsV0hXWkJwYnNyTldkWWJWR2I2b1NZVVY1aHpucWRHSnZZNC9W?=
 =?utf-8?B?M0kwcEN3WWU5dkxOQUVrMHBQMFErSDljeGNwemhGK2FobzN1LzEzNzYxMk1F?=
 =?utf-8?B?YlVTYks4L3BlNjc2Q2NrK2lQaVFrSUhTcGd6OUZQenV5MWZSVEV3eGoxb1E4?=
 =?utf-8?B?blVhNG5nVkpsTC9HTmJES3lRbThhdGRMMGtWdk1CM294ZmcwZGQ0VmQybzA2?=
 =?utf-8?B?cCtoTW90MC9hNTNqNlBpZ3lLS3BDWXJWZTRCK3pKUk9KZkFmaG4ySnpLdW1O?=
 =?utf-8?B?TklYM3ZNQVpaTC9FR3JBMnlmL0xYMUFFSVdoakxaNW9qT01DbGFTWE9XRHIr?=
 =?utf-8?B?RlYwQnNsMms4amFvaEp0WWRIdDYzS3NoODBjZnFMa0wxbVVwZHdOWnkzOXJS?=
 =?utf-8?B?UjlwTVJnYTdYNWhhZGpmSTRnQWdMQ1pBcHF6Q2E2c3JMY1VoaUtzMnBRcVQv?=
 =?utf-8?B?V2VYcTVVeU4xWGZFT3FqWkxHQ3UxQ3E3N2FrNjhMbEt5YzlFS1c0aTBEM3NI?=
 =?utf-8?B?SnZ3N3loOXVyek5LRmE0SkVmMFgrd1gydVVZczNWa25NWXdFVGdJdHBEcVQ3?=
 =?utf-8?B?OVorSE9WWXJma215aUVuVFhYVkFWTDdyRmVMSXNaM2RDbXVCbGVzbU1sMHFK?=
 =?utf-8?B?S3l6S2pMWkNGV2xLbFVKdWZMdTFCT1RNd2ZOZytyQXNJQ2l4OE1EU1lZRHB3?=
 =?utf-8?B?S3dZODBYYjlHNi91NTNoaXNPNFRvZHJVdjNTNXRFR2UwZWFnb2hXcGhFQnVj?=
 =?utf-8?B?c0NvYk1ubWtobXo0cnpMQ2d0cFhOaW1XQUpxSEsvUitIL211VllMUkpLUHNp?=
 =?utf-8?Q?XsOp8NYxXpLHDjmWsyM1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUduZ0VJWkE4NVQ0RFkwbWl0bGJ5ZFdMaDRxVmNFZ1J6czYvVU5IWHVlN0Jy?=
 =?utf-8?B?d2E1TFBCZ1F4cHhEUmg4WXV4L2NqUU91Z2pvMGxGUmdBaENwMEFOeWVxUFFl?=
 =?utf-8?B?elBSSnVCcHozWWg3ZXFtVXMwcXZLYm9NdlJTNCs2V1gxejJvNmZFeGRYM3Zx?=
 =?utf-8?B?d2d1WENsR0pRZkZLVGdNeitPR0VUYXVlY0JtVngyRmxSeExlQnhvTE1RTnZm?=
 =?utf-8?B?Mk9nK0pJUWZrU0FaaytiMGVrZnVtV0doVjJJMXRzTXNoTURIV2lmblhLRHhV?=
 =?utf-8?B?Rno2TGVsczhUVFF6T080N0hVMjZlL2tZdG45cWhZeUFxcDVSVFplbSt0NkNV?=
 =?utf-8?B?RkpaNGJnb0E2aFlCSHVVT1IyKzJYdmxRbmFsNDRQYVl2Ty8rbXNPVGh5ZkJx?=
 =?utf-8?B?Rmlpd3FvT2drNjJ5R1FuWi9ObG9OLzBFak5rZEZ3YitNbnhFTFQ4RDN0Wlkz?=
 =?utf-8?B?SnF5eDNta21QeVdTaVRQWXdHbkJBaEJncVgraXJvYkl5VENzemhoei9GNjhY?=
 =?utf-8?B?SGFRSFFJZmI4YTcrNVpDWFBkRE5FRmtuTnVXTnNOcWtEYVZtaHl5eU1aaVZ6?=
 =?utf-8?B?MFhhYVg2Vk5qYjBobkZVMUJ0dVZtMXE3ZDJzRTRDNGszQWFaTldveW1HNHBu?=
 =?utf-8?B?NWpsQ2phbTBENzRrMzFIM2xYZW9raVdWRVhQK2VYaS9lZ1JUUXNoeGxFbGl0?=
 =?utf-8?B?ZUNwL051MFo1eXBaYlJqR0pHNnhXd3lhN08vcEU1MDE2OFhsZEdjOWlWcXd5?=
 =?utf-8?B?WElEb1VhbFpuWnVoQkRqazdNMlNnOVgvR1A0Y0VkNEZTNVVCcUlZS1QyQkI3?=
 =?utf-8?B?QktrbFkxLytCVkV0dXB4Q3o3bUI2UnVQQWNkTE9KbVdQaHNJa0ZacmFqTE52?=
 =?utf-8?B?aGVuRGdSZVZJQUdFWWtpSkE3cmszM1hsSjdWUmhjUTBValFXL2ptWXJJVUNS?=
 =?utf-8?B?bk1UZm5Sd2tucjJmYm1GQ2RFK200cTNZUmw4RXNTcndLNE9XQmlFeTUrN24y?=
 =?utf-8?B?Y3hkK0FwMTFHQWhXNFRVaDBZK3oyd1pJOUlFQTJWdzJpSUUxeFYvQzJWNUo3?=
 =?utf-8?B?SmlCSU5xbms2cGZxeHBJdGhzKzZuY0IrOFhpTnpLVE1BS0R5Q05OMm94emlZ?=
 =?utf-8?B?cHRROTZhU0hlWlV1ekYzMWIzb01hcVZNQzFEMmdXbUVWcTBBSzNhYmthdFRw?=
 =?utf-8?B?NEZ0YkZIK2xXUStkY3k0V0EvR0JVcnpka3JWaW5ISEZpTEl5dlRLMTBmK005?=
 =?utf-8?B?M3Z1ckdsbGZRd0xMNnhqblNoNktGa1lNZ0s0bThCUHRMT2VOMURaVGRMaWFE?=
 =?utf-8?B?NFJPR3dkZ0lMa2NVcFZiYnhCWFJCVTg0SjZsOE90UWwrVzNDZmFNaDIzNnpH?=
 =?utf-8?B?RzdjUkx1R3V0c1Y2eURuY2xuWUU1MUFnVVQ5eXZlN3BDc2xCclFoRXYrWnFa?=
 =?utf-8?B?TU5hM1RsZW13WmJ0ODUvaGR2Q1ZnL1lLUmVmRjhHcFVpUUlKQlRSVFU5Wml5?=
 =?utf-8?B?Sm83YXNFTW14Y3VNd2xWaUlXdTd2VXhSNWNEdUI5NTBWNnk4VEpQSTk3NXdQ?=
 =?utf-8?B?Yys0aXU3TGg1ZVlNSjVXZ1VqaksydkQ0L2NheHNWZEJSbys2WTRERzN4UldC?=
 =?utf-8?B?Rnc0emVHcEdQMWcrL2M5UzdDcWZzZXlNK1lxRC9jL2hPcnNWNDkya2VDa1JW?=
 =?utf-8?B?VGVUYUFoSkxNbWk1c3JKMlZDWDRsR0E3VTlmUXJjb1B2YnY1RmNsVy8zR0ZE?=
 =?utf-8?B?TjJyckp3V0gwNExsUWJLOTJiQ3IrS0lIaHkvRlZUTHpIR2ZXblhGb01VKzAr?=
 =?utf-8?B?bDJBNmxTSFk2aHlSZzRTRUl5MXhzVGhSUnNBU0VFZFBXSTUxdisxM1Jvc3Fh?=
 =?utf-8?B?MnJaSloxRWFKcDhaR0l2VTVZc25NZGdCc3l4Ui95RXVyemJzMlI1NFZNdllk?=
 =?utf-8?B?VHJRbmVPNzlpMjNNYkpkeDRUNnRkVUsrL0dSY21GNUdmS2piNUJoRmhZRHVM?=
 =?utf-8?B?ZVhvenFQUTNUSzRmQUlOdlpSYzNRZlRnRjY2SnFEMGEwM3Nrb1BUbG05di9L?=
 =?utf-8?B?Y1AwYWREeGtCSmQ1bTRicDRUMXZFVmkrR2lvVEIwYnp5ZHFoQldmRzZ5cy9V?=
 =?utf-8?B?cHgyTmc5R212dXVTQ1RkemgwZzFMR3lKL2d0TmRNdkJ4eEwrZk9CaDRFTFFR?=
 =?utf-8?Q?O/di7PDXYVa7eYNe9SXS5PA=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c708c58-04e4-44e2-aff5-08dc869ff29b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 03:14:30.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jr9XkjuBO9RQe309dGQc/PCPW03uWM+fQysfUU0mrfXWiaTZbhBms70kiprvauNCgt798nX/QUk0uTHlYNZaijeTRvo5c+eVG6QRzP05sVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5769

Hi Louis,

On Thu, Jun 06, 2024 at 10:06:07AM +0200, Louis Chauvet wrote:
> Le 04/06/24 - 22:04, Colin Foster a écrit :
> > Hi Louis,
> 
> Hi,
>  
> > I found that commit e64d3b6fc9a3 ("spi: omap2-mcpsi: Enable MULTI-mode
> > in more situations") caused a regression in the ocelot_mfd driver. It
> > essentially causes the boot to hang during probe of the SPI device.
> 
> I don't know what can cause this. My patch can "compact" few words into 
> only a bigger one, so the signal on the cable can change, but it follows 
> the SPI specification and the device should have the same behavior.
> 
> Instead of two very distinct words (for example two 8 bits words):
> 
>   <-- first word -->             <-- second word -->
>    _   _   _   _   _              _   _   _   _   _
> __| |_| |_| ... |_| |____________| |_| |_| ... |_| |_
> 
> The signal on the wire will be merged into one bigger (one 16 bits word):
> 
>   <-- first word -->  <-- second word -->
>    _   _   _   _   _   _   _   _   _   _
> __| |_| |_| ... |_| |_| |_| |_| ... |_| |_
> 
> > The following patch restores functionality. I can hook up a logic
> > analyzer tomorrow to get some more info, but I wanted to see if you had
> > any ideas.
>  
> I don't understand the link between the solution and my patch, can you 
> share the logic analyzer results?
> 
> Maybe the issue is the same as [1]? Does it solves the issue?
> 
> [1]: https://lore.kernel.org/all/20240506-fix-omap2-mcspi-v2-1-d9c77ba8b9c7@bootlin.com/

I took three measurements:

1. My patch added
2. No patches
3. The 'fix' patch applied from [1]

2 and 3 appear to behave the same for me. But CS is certainly the issue
I'm seeing. Here's a quick description:

A write on this chip is seven bytes - three bytes address and four bytes
data. Every write in 1, 2, and 3 starts with a CS assertion, 7 bytes,
and a CS de-assertion. Writes work.

A read is 8 bytes - three for address, one padding, and four data.
Writes in 1 start and end with CS asserting and de-asserting. Reads in
2 and 3 assert CS and combine multiple writes, which fails. Reads no
longer work as a result.

I thought maybe the lack of cs_change might be the culprit, but this
didn't resolve the issue either:

@@ -172,8 +175,13 @@ static int ocelot_spi_regmap_bus_write(void *context, const void *data, size_t c
 {
        struct device *dev = context;
        struct spi_device *spi = to_spi_device(dev);
+       struct spi_transfer     t = {
+                       .tx_buf         = data,
+                       .len            = count,
+                       .cs_change      = 1,
+               };

-       return spi_write(spi, data, count);
+       return spi_sync_transfer(spi, &t, 1);
 }


The relevant documentation on cs_change:

 * (ii) When the transfer is the last one in the message, the chip may
 * stay selected until the next transfer.  On multi-device SPI busses
 * with nothing blocking messages going to other devices, this is just
 * a performance hint; starting a message to another device deselects
 * this one.  But in other cases, this can be used to ensure correctness.
 * Some devices need protocol transactions to be built from a series of
 * spi_message submissions, where the content of one message is determined
 * by the results of previous messages and where the whole transaction
 * ends when the chipselect goes inactive.

And relevant code around cs_change:
https://elixir.bootlin.com/linux/v6.10-rc2/source/drivers/spi/spi.c#L1715


So I think the question I have is:

Should the CS line be de-asserted at the end of "spi_write"?

If yes, the multi mode patch seems to break this on 8-byte transfers.

If no, then how can I ensure this?


Thanks

Colin Foster

