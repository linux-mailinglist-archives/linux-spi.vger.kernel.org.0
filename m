Return-Path: <linux-spi+bounces-9249-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94485B174DB
	for <lists+linux-spi@lfdr.de>; Thu, 31 Jul 2025 18:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E261A83997
	for <lists+linux-spi@lfdr.de>; Thu, 31 Jul 2025 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60494238C2D;
	Thu, 31 Jul 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ii6C/Zw0";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="DIkzP1Fz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF721A3172;
	Thu, 31 Jul 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978894; cv=fail; b=HIMBtuXTwF9mQwlBs0DLEXGLL0/OnpGVFMd+pOGRrUamLnUW19f8gL4jHRPvgQPVicR/F974oALhrYPPhhFzyUCg+XVeWEFvGJIwZE7ms63Ik5gmSumOtEXlvVMqTD6nYDDQlxm0t36M0krAATliPFjHBG/1ZM1iw+QXMesAemQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978894; c=relaxed/simple;
	bh=sYsfdYGS+ig+FZKace0mKx/p7hNClAUCGWOhtyiVUn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDMAXCcOeDAMxQLWpJXv/d9l+YSCCkTuEbr/kUlZSAwMDXL9ECPImvgEpzq1knzS+8TXcfKybAxBfw4DG6iycuFjmVGLZt/NtOu7FAvTH9Q8uffoDf339g4QtzQiQy+tKsQb3TteUVi3Dz9SEHwVis9aC+YVQl7pQxOzvg7QwRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ii6C/Zw0; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=DIkzP1Fz; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V4w5YY026195;
	Thu, 31 Jul 2025 11:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=f+0vXwyw8L6fJynurSk0T3h8v82p7TBgUSSir7xAnVM=; b=
	Ii6C/Zw0ACXGsiQpXSRkFJfkG0bXR+UbIaLYETmUM3u4qWRZS3Kg0gYqKD0BqII2
	qgEdBQEeYnDLZCLOP7qIeytfLo/Ywi4WqrsT90Gc/RUj3krCBluP8AKf5ZR+oapQ
	mX2g70C4tMdq+fFA1iH2UUyHFnJWATvfgd2lTi39bJXjNgdQaW96ygrd6KqvUaTv
	b8sQGPmIEv7ZUicSUWvq7OwNZzfjQTBOWctTBVVVYtGjfxN8bNZz6DPJ67XWVKPb
	C2GZ9I3LgVRMh8NCFZm1MeJMA0ImaMg74eykTo3FavV8TyZ3Gq1Fw1T0yhZacqFU
	cVYqoud/bwkQILwKSe6Yeg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2103.outbound.protection.outlook.com [40.107.236.103])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 487yq6s59q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 11:21:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXJvO2bv0Wv6se3xQzDhccrD1DYtHa/EpojZBCLHfhg6b/hlawUwJp3kAqK8k+O4npV693gKXrrWjTdNbc/lejZIHnZOStWlcQDi7yPQp8E84Soxo9rxa32wyNNMGHqk4MTLbvZrxcf0IwnBuBeBMjmkfyZsL0Zoi0pTHIpOloh+4qsuyeLereIMip3v52QxVa9nE9CbsSMyCfTmpQrfsh3rxjEfa/PnAaMSC+U/eXu9j5MHdLXD5ofS7yQHgwUpydw9O5pZBiLhskF0olnap2e7A4FZWkdrmsgbCm/sun+CjDuw273bFQUgBohrmL/89rqV6cnZnXvuX6k3QqEXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+0vXwyw8L6fJynurSk0T3h8v82p7TBgUSSir7xAnVM=;
 b=y+psgeobcE2YnzyLO/jdSMb0KGQfYbxdk++Inu84vmVyYKJH6dMU1sMazHNhPLNchaRW+L2Ccf0XfzBQu/SIBqGXxmeqDUggyEvbxStnrq+MI3NpjFKSd2JK654YRth0MxhXa7LhNsoliucfeXUhKeQ0WiTz87CXHSWQIOUuX3ULGdUEHLGRDV06egESnxrsyVCCT+7zcboTx0J/NLbd5bbTku7e4KBWi0pDv20PW77e5RpPhbUpLUE/d/CGyYNdnZyG4XgMv5EAYbu7GW1lscRVU7xjIkvZf0cfPiw34IS0mtd5qOrxYzyfQWK+ewkIsnY8OWa2I3+R/U6l7F7YCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+0vXwyw8L6fJynurSk0T3h8v82p7TBgUSSir7xAnVM=;
 b=DIkzP1FzpHLGyWsMU29d9yTTmNom7F0PWQ8dDxiwkex28ZoCc2let0QyUwGJLUz5h/R9R3E+yCGfKfwAiPuk21zfqCLMPn2dqXwdD3L1Mr/GMFjaZj9izEXz+25PoYRHpif/mPwdDmutY+UmdWtjOUuR/cOnA4E2K66ivx4IASg=
Received: from MN0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:208:52d::15)
 by IA0PR19MB8100.namprd19.prod.outlook.com (2603:10b6:208:480::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 31 Jul
 2025 16:21:26 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::b3) by MN0PR04CA0003.outlook.office365.com
 (2603:10b6:208:52d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Thu,
 31 Jul 2025 16:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.0
 via Frontend Transport; Thu, 31 Jul 2025 16:21:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 48654406547;
	Thu, 31 Jul 2025 16:21:25 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 36A1982024B;
	Thu, 31 Jul 2025 16:21:25 +0000 (UTC)
Message-ID: <bf497897-9674-45f1-b052-fb4ee0a0a4d5@opensource.cirrus.com>
Date: Thu, 31 Jul 2025 17:21:20 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cs42l43: Property entry should be a null-terminated
 array
To: Mark Brown <broonie@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20250731160109.1547131-1-simont@opensource.cirrus.com>
 <5f9a040e-c0d9-4dca-902d-74bc043d90c5@sirena.org.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <5f9a040e-c0d9-4dca-902d-74bc043d90c5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|IA0PR19MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 350bca89-473c-457e-8a3c-08ddd04e4c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHJJYnA5dFplWVlWWGhCNndDbmNqanI4VUdrQ0ZLVzlDLzJpOWh5dWZkVWha?=
 =?utf-8?B?T2tLdkorTElSYU9JcGh5OHNUc0dFdXVGRytHWEJxVTQ5dW9PY3dPS1Q2TXZX?=
 =?utf-8?B?bW5mVkFIWXQ5TWEwWFhWNFVMRUs5YzBKUUhQVjlYV0V5V0xheVBoRmMyN0VJ?=
 =?utf-8?B?ZVVTTll4R25RZ1FjYnJLWEtSZkZuWkZvckVaMUluakhIS0RxbTlKUVdqdW1Y?=
 =?utf-8?B?ZWVtaGtLWC9DUGtLc2swdlJpT2IweVJZZ3Fja0FUQXdPdFJxYjJYdDI5dENR?=
 =?utf-8?B?VUc0Z0oxb3N0SnQ2SkxKWDdKZTRLWmlSUENrVUtIKzVOYmRTWkIrRXNVRHVy?=
 =?utf-8?B?TGRYUVByNWl0N0lhUWRFeGZuZ3pVWTZzRXJNdzhiUjQvMzYzTlV1UVR3UUlp?=
 =?utf-8?B?ZisyUjRNZWI1Ris1TGh2dVZRaWlaMDBhblZOeTNLQlpzQVkrR3E4aW1sT3BE?=
 =?utf-8?B?NmVWK3BsSFMyMUhzSkNDV0FmVjdhams2c1p5SStmOXd6blhqQ1BZNVFHYldE?=
 =?utf-8?B?UzlEaEEzbHBtVC9yQXU5SlRLOU8xaWYrZUlRYmpCNDg5dklPM3V0U2dMbjk2?=
 =?utf-8?B?bk5SZEU5bHJLd2s3RDRnem5kOVRjaWIya0prSkJLVzEraXBmeUFZYy83Mk1G?=
 =?utf-8?B?Q2JwNnB6SjRpVTAyanRkMEwyU0xOTGlvYWRiT0lSbWNRK24wNVl1SmlUSDFR?=
 =?utf-8?B?RkM1b3E1bEpaVEgzaVlITkdxbUtRYkJ4NlQ2ZVM1RlJVUmVGVDFxZ1NBejFB?=
 =?utf-8?B?RkRYcUQvU0hRdE44NDg2aGxobmdHczZWaHkvWmZHOE9rMkdXZUxWTm9FVnNB?=
 =?utf-8?B?S0VjK1phN1BjTDB3bVdMNWpnRDZpSmIrQTJsWnRTanp2ZW1oQ1pBWWE1Ykl0?=
 =?utf-8?B?am1oOUJNdU4wR2twOGlHMHRJcmRjUWlEVnUxNWhTeXluNzJ3MElFOSt2aWE5?=
 =?utf-8?B?V3F0V3Q1Yy8xdXhCOWc1TmNXSHo3M3VxdDRGU2hrbTVJUWVSMmFWMnRZRktT?=
 =?utf-8?B?aENVT0IwRHZkMmh3Z2NkUnQrWWNjdkZzMXpua1NRVXI0WnY2cWJEbU5tempr?=
 =?utf-8?B?Uk5Mc0p0VGd2OUlTZzVUbmxKNEdPTTNHMnlObzJBMUV6QXAvUkM2VDd3TlA1?=
 =?utf-8?B?RVdIUUh3YUhMb3VBZzYrUUtqNnVCZU9hc0xvdmRDUUxWVTlMWG5ISjkwNWs2?=
 =?utf-8?B?TFVra1UvMENpWkhkMnpZQk1mRUxDWnBBSTd6ejd4MzBrVWtkS1pMTitFcWdw?=
 =?utf-8?B?OU4zdzNNK3ZXejE5NG4rRnRKK3RpQ2VLU1dLc2tRL3oycTkxUVU2ZXpEWmVx?=
 =?utf-8?B?cEQ0L0R6UDRuRkl3UHdKV1lValdkREpEQktmTUVFOWtjY1hmYmpzQklNZHQz?=
 =?utf-8?B?MWtuSWVXZytnVUQ5RjVMMnZVblZ5NlBveGgxVDhpaEZtTE9lK3lobXQ4N2lX?=
 =?utf-8?B?QVRmZWtFZnhKQjdBMHluQk5mQ1BJTHlUSi81TnNlSDZBZ1RDOG5nSXlWUlJO?=
 =?utf-8?B?MHg0NEcyamhxMWtYWEo3cytmN0NvS0R4SlV1L1htRUZsYWM4aGh3UkJYMWdW?=
 =?utf-8?B?ZFEwd2RjcklKZnZwVzBNM1VBUE4wNFNZZmNaVUxiOFZsR0FZUTZpZTdBbnpE?=
 =?utf-8?B?TUlZWkgwUElMMDgxdTltTmhMRmtmYXdrUkNvcWdsSXJRSXk4a2FpbVZrRWRq?=
 =?utf-8?B?cU80eWd2WVNlZ0dNSkhoTXIwZlkrRVBiZlFZc0xLcmNnSk9XK1cvVFlpaWNu?=
 =?utf-8?B?WC8rczhPQjVqNi81b1EwUjVRTFd3Q1BsdmV4YXNrSU00S2xUUFRUVm9BOTBB?=
 =?utf-8?B?K0RaOW92V1JTOUFybE5Ea2gvQ1RDdER6UzYxNmFyOW5mSiswa0N4eVdKS0tJ?=
 =?utf-8?B?ZEJpZG80dGk0RGRpYmc2L21JVjBqUncrcVd3OVlocGc2RzUxcHJ0WUw4cjVY?=
 =?utf-8?B?aVQ5WkduK2hsSWxvZ084REpJU1ptenZNSVBxTDE4V3NLdjNWTksyV3JYU2xs?=
 =?utf-8?B?cHpwbGtoaWh3TjZyQmhub0pmYU5QUFVnSks5N3BDSmh3Rm96cytYcVdvR1d1?=
 =?utf-8?Q?PsYWvl?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 16:21:26.1442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 350bca89-473c-457e-8a3c-08ddd04e4c5c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR19MB8100
X-Proofpoint-ORIG-GUID: h_RguPBUCJ9dyTOQ43qUqi52Bk33emGa
X-Authority-Analysis: v=2.4 cv=Lcg86ifi c=1 sm=1 tr=0 ts=688b980a cx=c_pps a=kx+ZUFUek9wuA+Nh1xeDsQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=RvcVqJ7HNlIFrqlOONQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: h_RguPBUCJ9dyTOQ43qUqi52Bk33emGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAxNSBTYWx0ZWRfX1zZPPAxRyzdr OXdlrjMYYJnhGW8g5mvQ4zR5mkPh1P8HMGWHBYfqOXoxoUnji0i2E6xC7668ZSp3ElDYgwJbsFQ DkJsC9wpsyjiQGVWKSYGWfpK2FIPsC3fC2oMmhfVI9gSgsE7W0JQLv7+INprTHF5nGtW0lBX3X/
 aWjro3b9aUSfBuODXzyjIGafpSN202Ya1SSn2TTZ94viMVcmF0nyAt2ab7WvUIgyJd2hfGMCe3M 37H8GWYPo4Ikqw97BhMMLvks24932t8S/mTlsvgqb71G6ScSmExt8LewoZYrAS7sL+q+dfaCU5s PydZNXZBQos+Vq6YbQM6/yVmMleNiY2sMMugDl3NUNKH0VeJkhYHWZt08MN0RKyHW67RtZO33CW yoo5Pccb
X-Proofpoint-Spam-Reason: safe

On 31/07/2025 5:20 pm, Mark Brown wrote:
> On Thu, Jul 31, 2025 at 04:01:09PM +0000, Simon Trimmer wrote:
>> The software node does not specify a count of property entries, so the
>> array must be null-terminated.
>>
>> When unterminated, this can lead to a fault in the downstream cs35l56
>> amplifier driver, because the node parse walks off the end of the
>> array into unknown memory.
> 
>>   	if (spkid >= 0) {
>> -		props = devm_kmalloc(priv->dev, sizeof(*props), GFP_KERNEL);
>> +		props = devm_kcalloc(priv->dev, 2, sizeof(*props), GFP_KERNEL);
> 
> Does kcalloc() zero initialise the data?

"kcalloc — allocate memory for an array. The memory is set to zero. "

