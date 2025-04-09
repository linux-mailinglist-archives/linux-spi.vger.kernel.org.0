Return-Path: <linux-spi+bounces-7472-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F369A81AB6
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 03:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7249422421
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 01:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66F64A01;
	Wed,  9 Apr 2025 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="vwl3tn2Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7D29A2;
	Wed,  9 Apr 2025 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744163384; cv=fail; b=oSGT6PV2r5/68kZ1aLbqkfNzldkAWNcBbPWA32BNKLz3oBno5lwZFOmIniiOWvEWQPROJ4KYjYI58h4Qa6eOWRUD1Xe40OVbm37Sr6oxMuFSZK8f1iPpYjVVTdBtvVwfNo4dogYaCvxCGMi+6gQ/HDwQlDmAiv79UwJOS644hiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744163384; c=relaxed/simple;
	bh=8TO0ucvxdFeR+4FZ5zKZAQ+NHIjbS3Tk+zVMP6GCRvQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K9FYWLyBWwO0vGSHGOYnY7d9RRHU2cdPyr78bV6rAqRLsiJNzgHyWPfTfcMV6Ze/fCRUDb+zky8vuktYRQSlXwfzb3bKHPJFdoQXBF2K51srmk/xuAvBKettJGnp/NeZBFrt7OnDMSErzzqdTBQrj6/OVB1upSbF7b7LpzviKSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=vwl3tn2Q; arc=fail smtp.client-ip=40.107.255.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bToF7DEN52nkIgZ5pRe3add60Zg2HFp5jtYWctImwOAreO8+GPbz6Yy+rQUmQqTocG9ZMEM6AQsURVqcgnVj95q9rJoxGFuIqyzeqlSGvI2hcYyFEVnaREWmUqorg5nkm0BX7w0ZZiPcFH5pwrcGhYM7l5v+Y1dRZKc996y3eAwzzoVsIY1p78FI+3Klpapr8geEkE+EtVT7yctSN0Muljn1e1Qa6NeRNAH2Bz/nGXmRLMhk44rQ11689LkpxFkhSnRN/TPvkQHhnuQrmM0ERDB3OZcS5p3kjFh4r04geu5lFl1Y9m0DuIAvmdvv2wQxEf3pawo3vXWmg7/UjBiLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xibo7uBmFnL2stbLsqepvmGIZZxmhXkFCRr/VW7YIrM=;
 b=u216oVoSEtFV95tMEu39wsqzqWKSIoRgmBk3gvaZCiZLuBy6cwhc//5xhJD8RHbdHfmzjbH+U74NxuivqGpMBDJxP/GWaDroRt+TeWc0SUR+lhSWPBB47RG/gTnHx3TQtVeStg/9GvjtgmP9UJfCK/0PE5b17TO1FOuob4KV7JB2IO5oVzB4QHfs60yzD+BcEyDMYQVIGNnsiWmPAt+6hgd/InO1a5SWOAimA7nf27SsyCsVUaMRi1CwIBpr3I6FJu5PT3HRhZezYS+eBjWuy0gmX+1LlB9Ic+aQqtoNdcpmnU94WAB9K21I+wHl0uhJx5VATVlGb+WQoupk7NJMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xibo7uBmFnL2stbLsqepvmGIZZxmhXkFCRr/VW7YIrM=;
 b=vwl3tn2QzwYiCQABCMu32W6ab5vM4/3OMy/wsyjZM2+RdDUqxV0CJQ6vOh5afgH1pr2qnMougXHGihgRzfQ72JW8a3TkBnHB/3es8ZCgRSjKenx36ayPyzdaerXJEh3dRkZhIZV2ieeg2jYvmLpoEmGb5a8RFSmy++xH+0KvNDUF9bkV3ZbbR9bj5OySuvMTWeg/Zn8HVMwyaeBS2BEgRTgOoc4MVLUT8rtgnfdGEBxvoC1NcqbNrf89bT2VmekDOropZCUOmgwcNiUbqU+I5OxCB7Hv1o0XJ5s+Xfe8SukOaItd51y6vwwEwCEBCqIy0uKYbLpxcjLIq139rGo5ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB7019.apcprd03.prod.outlook.com (2603:1096:820:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 01:49:37 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%5]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 01:49:37 +0000
Message-ID: <aebccc51-14a2-40be-8d9e-20a55ce94459@amlogic.com>
Date: Wed, 9 Apr 2025 09:49:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: meson-spicc: add DMA support
Content-Language: en-US
To: neil.armstrong@linaro.org, Mark Brown <broonie@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sunny Luo <sunny.luo@amlogic.com>
References: <20250408-spi-dma-v1-1-3c38be62c09c@amlogic.com>
 <c29a8c28-996c-4e94-b0a1-0e4a37f0bebb@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <c29a8c28-996c-4e94-b0a1-0e4a37f0bebb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:404:56::31) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: db1a0b21-39cb-4ef5-ac34-08dd7708c912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEo4VjFWazluT2VHMHRlREFsMThnQjM3cVBQTjgyd3lwaFpHZWcwYnRTUE94?=
 =?utf-8?B?c2JEK0xmSHRYcURMU1pHSTZtQ3BiOWFhanBNUDNqZmZVWTg5Q0VXbE5JS3NM?=
 =?utf-8?B?eTVyR1h2bW8rYWhPSjh2SGdwSkRVZHF3K2xxTnJOMEZoWHlkZHZrZUl4ZlRs?=
 =?utf-8?B?bWdLM3RlRkpHR0ZtUk9JOWdrT3FZL2JUdUdJeGpZLytQT09qVGUweGRWNzhJ?=
 =?utf-8?B?cFJYMFdZcHZya3pZbTVCMDUyNzQxOUZuRHlQZ3AzVnVPZEMxa1NjdXFTOGpE?=
 =?utf-8?B?Y1ZjM05DdXM3cFBqN2l3RG5iem5maXNwbjNIV3ZndUZVQ0xObk9KVllwU3BJ?=
 =?utf-8?B?TUpDSy9NWUVlM0xZWjBjOHo1aVdwcmRzNTZHazBqeWlaZnNtTGVGNTVrYlE1?=
 =?utf-8?B?aUtXR3B2VDdoTkt6b2h6bHFXUGtZOWJXUFg5L0JaNDV6S1lKaWR1WUJIUEpV?=
 =?utf-8?B?UW03MDBjRWQ5TWtRclhaZGJpdy9vcFR4QWZSd2V1L0JpU0ZPMGFLMUNHSC9B?=
 =?utf-8?B?M2V2S1FUSVpkSDA4eVpCTDRUUXdidjl5TCs1NG83bmhpTGFPWjNjYVB3TmRR?=
 =?utf-8?B?U3hZQjg1T0ZIUFFyOUVzc1YyckpVckdweXpXZDBBbks0d1UxVHNVL3E5U3RS?=
 =?utf-8?B?VVF6cndxUjFJQzlSVTJGYXdKaDB4amJrUGFGQjNxcjlQUmN3ZEIrUmFiQTlB?=
 =?utf-8?B?dHoxc3o4RThQaSt6YmFlZzg3cFB1dk1TZS9aR21MZkU3ZWRkQm9WQ3d2cWpv?=
 =?utf-8?B?VmpvN1J5Ukg0L3Q4TUthRDVhejVVQ2lHMHp0c20zL2puYm1UaEZVNXZXdUdG?=
 =?utf-8?B?RUJzYUVscHFsU1FBU0lKaDVsa2I4NXhDY2ZkUnJrd0psRmw1dVh6YkhFVFJs?=
 =?utf-8?B?aFRJVk5mTkYvWFdwWnJTY1lXeTZYY3lwb0NadzZaRXh6Zm1zTDFESGlwQ08x?=
 =?utf-8?B?N2kvcEptSlhYU1R2VDdmR1ZCdXRqaFdNR3VPRHk4K1hqVVd1WmdmbEJNMHFh?=
 =?utf-8?B?cDhxNlJUMEU0ejA4QXNacHg1RThLZXJzWFBDby9yRUFZaTlPcE42UVplS2tP?=
 =?utf-8?B?Y0QxbWt4SmRYVk93N3ZHdmROUUtrditidGN3Zk9ZZnhVcmhHQVBsd2R1aVds?=
 =?utf-8?B?N1dPeWZGQU1hQjdabXFTRHVlK3dBcjhaUFhZUzk1L3dXOTFkSlhTU29Xa3hM?=
 =?utf-8?B?T3V5MEljblh6UXVHTnFZZ3JEOUxZODdsZ1ZQdlFJREczOHgwRE5NVThiR04x?=
 =?utf-8?B?UGI0N1JpejZLdGtHazRTYUZ1VEZkdGl4TzdLd0ZSRFVZRHFrbEQ1cHg1VzJw?=
 =?utf-8?B?Q0FOV1F2TGIxSlptcEZNMVd4cnQ4MGhJZm5vaUJIL2tTWEU4WlN5VTV6SWRW?=
 =?utf-8?B?dTZSTW8wcTZDemxZcys2ZkJpSCs0NUQrR1NyZEYrcXFnRW9UT09VUkRkbE4z?=
 =?utf-8?B?KzExVVFBbnBMVGpKb3d1UEFVRlZnZEJXRFNRalA3djY1QkYrcE0yelk4U1pU?=
 =?utf-8?B?a1VDd1plZHdYaTQvaHpOS1l6WDdGcVZTV1dDM2d4dE8zbGp4aWZXMlIvd2dZ?=
 =?utf-8?B?MFpMendmaGh2b08xMXM4clFrMmwzemVMMTAwNGFVRXVqUG9uZ1JEaXJQM1R0?=
 =?utf-8?B?NDZiRXljcHpneVVVN0pUVkdGMUxxYlZQQndqeVZ4OU5lOTVGTG5ZWTVvbGFl?=
 =?utf-8?B?dlNnUkttekVsNERjR0xPTmRacWxNZkxvc1gxd1cxOHplNGFkZDVybHQ4dTBC?=
 =?utf-8?B?Ym9xdTRtRVI5UDM3NFU4TGszbjBSWStHWXd5MWZHZ2VMQ1V4WHpjWG1BNm93?=
 =?utf-8?B?T0NaWGpUUEJ2ZGd3RUdCclVlaXRoTCtUUnpmcHZhQ1BhRGNPUUdJYXRwdjdk?=
 =?utf-8?B?WG84OVJLaC9zV2g5dXFpcExhRU4rVmZKNThST29VQ0ZEV05VdXQvb0MwSTll?=
 =?utf-8?Q?OGxaF8F/0Ks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S043OHZNZE1IRU5rRDF6NzJtV0Nxb291YnFYd2RLeU9RMGcybHBPL3hhc1Y3?=
 =?utf-8?B?UXlualF6cWk0ZWtpSlZ4T0pVbm5zTUwrZEZwaU1JZ2FKc1R5RUN3aGV2M0Y2?=
 =?utf-8?B?M0swa1VQRC9Jc2N4UU1lcFdvKytUejRjSGQ1anlmTXZ5eG1mVHZVcUloMVdj?=
 =?utf-8?B?NFc2NDk2dDQ4TzJUWEhYeksyQ3RIWnBVc1ZiMUI2TWlFelNpWWRHWGlqU3FQ?=
 =?utf-8?B?V3p5NmZwdk5tc1l5Zk42Tlh5bUFwWEdibGZMY0dHSXBXVUtYZmUvSzlGWGlv?=
 =?utf-8?B?c2wzOG5wc2ZWRVdMK3JmVzVIWi9OV3dYWXFWU1pic3B4RUtEQkpBcldTTHl2?=
 =?utf-8?B?T2MvS1JZN2lnNlVJem0rY0c5WWJFRmJ5Q2RLd2FlS3dacXBkci9TVFkzdGhU?=
 =?utf-8?B?VktFUEQzUWdGYXU2TG1vb2hGTzhaK0RMSVhMcWR1VnVUY2VLRDBuaGhkNkZY?=
 =?utf-8?B?YXRTeGFqK0NWUmdZL1JBam9JeEhnanJQNXJWQ2dHR0ZENVNzVm1PU2hSQThp?=
 =?utf-8?B?NVRFcEN5TWxWYzg4R2NyUWkrSVU3TVZjYkZ2MHN6dzQ1cHR3TnIzRU0zVW5n?=
 =?utf-8?B?N05yOXhNL3Ftc25nd1ZnN3llYkNNUXVhRXhLWDU5YWVEUkJkZlcyeE1JdEhF?=
 =?utf-8?B?aFE2c3lXZVRKdU1YTmtNdTFlSzAxZnR5YUdVUDRobE5wS3VqZzNUdzQ4TC9y?=
 =?utf-8?B?ZUVUK3NTVzByZTFhOWtXOGI2ZDduK0NaSHJaTCt1Z3Znc0dFOVZjUTFqZkhT?=
 =?utf-8?B?dDZsSGF4MkI2Sk1OL2VZUml3L3lxcU1NSEZFVzhxR0VNTml6dE56NGd2STdD?=
 =?utf-8?B?bDhMOGttaHJnQm9RS1RTQmNNRTFTNmRLNlpUTkxtZ3J6bFZWejFHVDRVc2Vn?=
 =?utf-8?B?NFpDYUE5aThEQ1NHeWtZbEIxL3ROb2cwQjZNMmVTenhEWEdHYnpLMkVkdElT?=
 =?utf-8?B?T05nMy8zWHFoS1lkUzFrKzU5bUY1clFSN2tEVmtSaEJocUhKL0tyeUJzbzVF?=
 =?utf-8?B?VVQ5RXgwZmxzYzR4RllwUlI4dlVRbHV6Q2ExSzJJUlNQUnhiVGEyT1piUnAw?=
 =?utf-8?B?eFFnMHZhOGhjUytCQW5hS1BmR016R0hMcHNaTlp2b3dpY2NBanpnVzJ6bGk3?=
 =?utf-8?B?aWlOSEljVHREcUZHb1dybmljMkRzSTJyUnRwcWRhV3BmRWUveUxxYUZ4ZW5L?=
 =?utf-8?B?bUlkaVZNbWMzMzdRQlZvN01raHR5dXlSSCsvMHQzN2txcnFUS003cks5eTVG?=
 =?utf-8?B?cmZYaEdQdmlwVDB0dGdkUjhMa0xpZmRpL3NabGFMZWVQOEJjVHUrcFpQblpK?=
 =?utf-8?B?eUxkcUJ1NU54TjhNZlh1ajV1L0pGYTh5bkt6Z0lhMzV4WGh6cE9JNlNQYkFm?=
 =?utf-8?B?dU15QVRXazRLRUZRS09EdjdIb1lCYW84V2JMaXNzbUZhQ0FwQVQvd3prYndv?=
 =?utf-8?B?emFNUkE2ZmdvUnRvNzh6cE5MMjVSL1JmWFRJMFJSZDJmTTdFWUVaVWVDcU92?=
 =?utf-8?B?RlNVMHg4QmlVTXhhSE1aaU5tRXVkL1pDSXFIakp6cGppak5PbzMvTGNQNk1N?=
 =?utf-8?B?aHVtcW54bG8yaE56UmRaRUgxVGhzMVRlNTA2QmYwRTRRT01SS2RCWEwxZ0R4?=
 =?utf-8?B?dWJ0Rks3VXVuL1lweUZjSUpBNkh4L21pajc2LzU2SWc0YnRMTGdtcmEvSnY1?=
 =?utf-8?B?SDNKU3hPczFyOGFkNEw4c1A4VDB4VnRMbkRDM1loYTBWbE9JK3djUFVGa01o?=
 =?utf-8?B?UjhJK3hYMVRtUndnTGpnQzU5dGNETkxIV1FuMWh4clg5TkRxWTRBd1plMk9q?=
 =?utf-8?B?SFJXWkRLdTFrb0xUUElYL1pYNnhyYURJY3RId2UvbVlndVBNSlFBTEZEc2Ny?=
 =?utf-8?B?S0U0ckUySndaTlBqN2d1VCsxMFZ1cmtFTm8xdEFndnV2b2lxUm9UTm82aVA5?=
 =?utf-8?B?aEVCcTNVcy8wSS9XSVRUcXpKZzlSaEpoRnpQMXY1Ym9JQ2EwV3hvRS9jSnB4?=
 =?utf-8?B?dEFPOHpmQ0lJQWZwa2R0a29mQVg5MTdkaUducWVqZmFGWjdJL2l3MTZSeHMv?=
 =?utf-8?B?YTh6OTE1UEZVRmlOMHc4Ty9lVDNUaHpYYWtmVVRYUWgyeStNVFFRRXBLQkVO?=
 =?utf-8?B?czUzczNHaXA0VFU1S0gvSVdVM3BROWlWRW5uOEJlUThZazkwYlpkdmUxdzVk?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1a0b21-39cb-4ef5-ac34-08dd7708c912
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 01:49:37.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4bQL3ZtVfTcb1ELY0LJtxiR6kLS2xEEUyDtO0FUan/FkI5oJ/+e91aGfotkvhj+Ct6GAKoLwT3PoiPeEVPtuiydeMFLokmTzAiI09yRdfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7019

Hi Neil,
    Thanks for your reply.

On 2025/4/8 15:41, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 08/04/2025 09:04, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Add DMA support for spicc driver.
>>
>> DMA works if the transfer meets the following conditions:
>> 1. 64 bits per word;
>> 2. The transfer length must be multiples of the dma_burst_len,
>>     and the dma_burst_len should be one of 8,7...2,
>>     otherwise, it will be split into several SPI bursts.
>>
>> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/spi/spi-meson-spicc.c | 243 
>> ++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 232 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/spi/spi-meson-spicc.c 
>> b/drivers/spi/spi-meson-spicc.c
>> index df74ad5060f8..81e263bceba9 100644
>> --- a/drivers/spi/spi-meson-spicc.c
>> +++ b/drivers/spi/spi-meson-spicc.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/reset.h>
>>   #include <linux/pinctrl/consumer.h>
>> +#include <linux/dma-mapping.h>
>>
>>   /*
>>    * The Meson SPICC controller could support DMA based transfers, but 
>> is not
>> @@ -33,6 +34,20 @@
>>    * - CS management is dumb, and goes UP between every burst, so is 
>> really a
>>    *   "Data Valid" signal than a Chip Select, GPIO link should be 
>> used instead
>>    *   to have a CS go down over the full transfer
>> + *
>> + * DMA achieves a transfer with one or more SPI bursts, each SPI 
>> burst is made
>> + * up of one or more DMA bursts. The DMA burst implementation 
>> mechanism is,
>> + * For TX, when the number of words in TXFIFO is less than the preset
>> + * reading threshold, SPICC starts a reading DMA burst, which reads 
>> the preset
>> + * number of words from TX buffer, then writes them into TXFIFO.
>> + * For RX, when the number of words in RXFIFO is greater than the preset
>> + * writing threshold, SPICC starts a writing request burst, which 
>> reads the
>> + * preset number of words from RXFIFO, then write them into RX buffer.
>> + * DMA works if the transfer meets the following conditions,
>> + * - 64 bits per word
>> + * - The transfer length in word must be multiples of the 
>> dma_burst_len, and
>> + *   the dma_burst_len should be one of 8,7...2, otherwise, it will 
>> be split
>> + *   into several SPI bursts by this driver
> 
> Fine, but then also rephrase the previous paragraph since you're adding 
> DMA.
> 
Will do.

> Could you precise on which platform you tested the DMA ?
> 

aq222(S4)

>>    */
>>
>>   #define SPICC_MAX_BURST     128
>> @@ -128,6 +143,29 @@
>>
>>   #define SPICC_DWADDR        0x24    /* Write Address of DMA */
>>
>> +#define SPICC_LD_CNTL0       0x28
>> +#define VSYNC_IRQ_SRC_SELECT         BIT(0)
>> +#define DMA_EN_SET_BY_VSYNC          BIT(2)
>> +#define XCH_EN_SET_BY_VSYNC          BIT(3)
>> +#define DMA_READ_COUNTER_EN          BIT(4)
>> +#define DMA_WRITE_COUNTER_EN         BIT(5)
>> +#define DMA_RADDR_LOAD_BY_VSYNC              BIT(6)
>> +#define DMA_WADDR_LOAD_BY_VSYNC              BIT(7)
>> +#define DMA_ADDR_LOAD_FROM_LD_ADDR   BIT(8)
>> +
>> +#define SPICC_LD_CNTL1       0x2c
>> +#define DMA_READ_COUNTER             GENMASK(15, 0)
>> +#define DMA_WRITE_COUNTER            GENMASK(31, 16)
>> +#define DMA_BURST_LEN_DEFAULT                8
>> +#define DMA_BURST_COUNT_MAX          0xffff
>> +#define SPI_BURST_LEN_MAX    (DMA_BURST_LEN_DEFAULT * 
>> DMA_BURST_COUNT_MAX)
>> +
>> +enum {
>> +     DMA_TRIG_NORMAL = 0,
>> +     DMA_TRIG_VSYNC,
>> +     DMA_TRIG_LINE_N,
> 
> You're only using DMA_TRIG_NORMAL, what the other 2 values for ?
> 

DMA_TRIG_VSYNC and DMA_TRIG_LINE_N are used by VOUT modules in certain 
partial TV SoCs. These DMA triggering methods rely on special signal 
lines, and are not supported in this context. I will delete the 
corresponding information.

>
>> +
>>   #define SPICC_ENH_CTL0      0x38    /* Enhanced Feature */
>>   #define SPICC_ENH_CLK_CS_DELAY_MASK GENMASK(15, 0)
>>   #define SPICC_ENH_DATARATE_MASK             GENMASK(23, 16)
>> @@ -171,6 +209,9 @@ struct meson_spicc_device {
>>       struct pinctrl                  *pinctrl;
>>       struct pinctrl_state            *pins_idle_high;
>>       struct pinctrl_state            *pins_idle_low;
>> +     dma_addr_t                      tx_dma;
>> +     dma_addr_t                      rx_dma;
>> +     bool                            using_dma;
>>   };
>>
>>   #define pow2_clk_to_spicc(_div) container_of(_div, struct 
>> meson_spicc_device, pow2_div)
>> @@ -202,6 +243,155 @@ static void meson_spicc_oen_enable(struct 
>> meson_spicc_device *spicc)
>>       writel_relaxed(conf, spicc->base + SPICC_ENH_CTL0);
>>   }
>>
>> +static int meson_spicc_dma_map(struct meson_spicc_device *spicc,
>> +                            struct spi_transfer *t)
>> +{
>> +     struct device *dev = spicc->host->dev.parent;
>> +
>> +     if (!(t->tx_buf && t->rx_buf))
>> +             return -EINVAL;
>> +
>> +     t->tx_dma = dma_map_single(dev, (void *)t->tx_buf, t->len, 
>> DMA_TO_DEVICE);
>> +     if (dma_mapping_error(dev, t->tx_dma))
>> +             return -ENOMEM;
>> +
>> +     t->rx_dma = dma_map_single(dev, t->rx_buf, t->len, 
>> DMA_FROM_DEVICE);
>> +     if (dma_mapping_error(dev, t->rx_dma))
>> +             return -ENOMEM;
>> +
>> +     spicc->tx_dma = t->tx_dma;
>> +     spicc->rx_dma = t->rx_dma;
>> +
>> +     return 0;
>> +}
>> +
>> +static void meson_spicc_dma_unmap(struct meson_spicc_device *spicc,
>> +                               struct spi_transfer *t)
>> +{
>> +     struct device *dev = spicc->host->dev.parent;
>> +
>> +     if (t->tx_dma)
>> +             dma_unmap_single(dev, t->tx_dma, t->len, DMA_TO_DEVICE);
>> +     if (t->rx_dma)
>> +             dma_unmap_single(dev, t->rx_dma, t->len, DMA_FROM_DEVICE);
>> +}
>> +
>> +/*
>> + * According to the remain words length, calculate a suitable spi 
>> burst length
>> + * and a dma burst length for current spi burst
>> + */
>> +static u32 meson_spicc_calc_dma_len(struct meson_spicc_device *spicc,
>> +                                 u32 len, u32 *dma_burst_len)
>> +{
>> +     u32 i;
>> +
>> +     if (len <= spicc->data->fifo_size) {
>> +             *dma_burst_len = len;
>> +             return len;
>> +     }
>> +
>> +     *dma_burst_len = DMA_BURST_LEN_DEFAULT;
>> +
>> +     if (len == (SPI_BURST_LEN_MAX + 1))
>> +             return SPI_BURST_LEN_MAX - DMA_BURST_LEN_DEFAULT;
>> +
>> +     if (len >= SPI_BURST_LEN_MAX)
>> +             return SPI_BURST_LEN_MAX;
>> +
>> +     for (i = DMA_BURST_LEN_DEFAULT; i > 1; i--)
>> +             if ((len % i) == 0) {
>> +                     *dma_burst_len = i;
>> +                     return len;
>> +             }
>> +
>> +     i = len % DMA_BURST_LEN_DEFAULT;
>> +     len -= i;
>> +
>> +     if (i == 1)
>> +             len -= DMA_BURST_LEN_DEFAULT;
>> +
>> +     return len;
>> +}
>> +
>> +static void meson_spicc_setup_dma(struct meson_spicc_device *spicc, 
>> u8 trig)
>> +{
>> +     unsigned int len;
>> +     unsigned int dma_burst_len, dma_burst_count;
>> +     unsigned int count_en = 0;
>> +     unsigned int txfifo_thres = 0;
>> +     unsigned int read_req = 0;
>> +     unsigned int rxfifo_thres = 31;
>> +     unsigned int write_req = 0;
>> +     unsigned int ld_ctr1 = 0;
>> +
>> +     writel_relaxed(spicc->tx_dma, spicc->base + SPICC_DRADDR);
>> +     writel_relaxed(spicc->rx_dma, spicc->base + SPICC_DWADDR);
>> +
>> +     /* Set the max burst length to support a transmission with 
>> length of
>> +      * no more than 1024 bytes(128 words), which must use the CS 
>> management
>> +      * because of some strict timing requirements
>> +      */
>> +     writel_bits_relaxed(SPICC_BURSTLENGTH_MASK, SPICC_BURSTLENGTH_MASK,
>> +                         spicc->base + SPICC_CONREG);
>> +
>> +     len = meson_spicc_calc_dma_len(spicc, spicc->xfer_remain,
>> +                                    &dma_burst_len);
>> +     spicc->xfer_remain -= len;
>> +     dma_burst_count = DIV_ROUND_UP(len, dma_burst_len);
>> +     dma_burst_len--;
>> +
>> +     if (trig == DMA_TRIG_LINE_N)
>> +             count_en |= VSYNC_IRQ_SRC_SELECT;
> 
> Is this the VPU VSYNC irq ? is this a tested and valid usecase ?
> 

Yes, it is VPU VSYNC irq, This part of the code is not completely. NO 
tested about it. I will delete it.

>> +
>> +     if (spicc->tx_dma) {
>> +             spicc->tx_dma += len;
>> +             count_en |= DMA_READ_COUNTER_EN;
>> +             if (trig == DMA_TRIG_VSYNC || trig == DMA_TRIG_LINE_N)
>> +                     count_en |= DMA_RADDR_LOAD_BY_VSYNC
>> +                                 | DMA_ADDR_LOAD_FROM_LD_ADDR;
>> +             txfifo_thres = spicc->data->fifo_size - dma_burst_len;
>> +             read_req = dma_burst_len;
>> +             ld_ctr1 |= FIELD_PREP(DMA_READ_COUNTER, dma_burst_count);
>> +     }
>> +
>> +     if (spicc->rx_dma) {
>> +             spicc->rx_dma += len;
>> +             count_en |= DMA_WRITE_COUNTER_EN;
>> +             if (trig == DMA_TRIG_VSYNC || trig == DMA_TRIG_LINE_N)
>> +                     count_en |= DMA_WADDR_LOAD_BY_VSYNC
>> +                                 | DMA_ADDR_LOAD_FROM_LD_ADDR;
>> +             rxfifo_thres = dma_burst_len;
>> +             write_req = dma_burst_len;
>> +             ld_ctr1 |= FIELD_PREP(DMA_WRITE_COUNTER, dma_burst_count);
>> +     }
>> +
>> +     writel_relaxed(count_en, spicc->base + SPICC_LD_CNTL0);
>> +     writel_relaxed(ld_ctr1, spicc->base + SPICC_LD_CNTL1);
>> +     writel_relaxed(((trig == DMA_TRIG_NORMAL) ? SPICC_DMA_ENABLE : 0)
>> +                 | SPICC_DMA_URGENT
>> +                 | FIELD_PREP(SPICC_TXFIFO_THRESHOLD_MASK, txfifo_thres)
>> +                 | FIELD_PREP(SPICC_READ_BURST_MASK, read_req)
>> +                 | FIELD_PREP(SPICC_RXFIFO_THRESHOLD_MASK, rxfifo_thres)
>> +                 | FIELD_PREP(SPICC_WRITE_BURST_MASK, write_req),
>> +                 spicc->base + SPICC_DMAREG);
>> +}
>> +
>> +static void meson_spicc_dma_irq(struct meson_spicc_device *spicc)
>> +{
>> +     if (readl_relaxed(spicc->base + SPICC_DMAREG) & SPICC_DMA_ENABLE)
>> +             return;
>> +
>> +     if (spicc->xfer_remain) {
>> +             meson_spicc_setup_dma(spicc, DMA_TRIG_NORMAL);
>> +     } else {
>> +             writel_bits_relaxed(SPICC_SMC, 0, spicc->base + 
>> SPICC_CONREG);
>> +             writel_relaxed(0, spicc->base + SPICC_INTREG);
>> +             writel_relaxed(0, spicc->base + SPICC_DMAREG);
>> +             meson_spicc_dma_unmap(spicc, spicc->xfer);
>> +             complete(&spicc->done);
>> +     }
>> +}
>> +
>>   static inline bool meson_spicc_txfull(struct meson_spicc_device *spicc)
>>   {
>>       return !!FIELD_GET(SPICC_TF,
>> @@ -293,6 +483,11 @@ static irqreturn_t meson_spicc_irq(int irq, void 
>> *data)
>>
>>       writel_bits_relaxed(SPICC_TC, SPICC_TC, spicc->base + 
>> SPICC_STATREG);
>>
>> +     if (spicc->using_dma) {
>> +             meson_spicc_dma_irq(spicc);
>> +             return IRQ_HANDLED;
>> +     }
> 
> Make meson_spicc_dma_irq() return irqreturn_t and return IRQ_HANDLED.
> 

Will do.

>> +
>>       /* Empty RX FIFO */
>>       meson_spicc_rx(spicc);
>>
>> @@ -426,9 +621,6 @@ static int meson_spicc_transfer_one(struct 
>> spi_controller *host,
>>
>>       meson_spicc_reset_fifo(spicc);
>>
>> -     /* Setup burst */
>> -     meson_spicc_setup_burst(spicc);
>> -
>>       /* Setup wait for completion */
>>       reinit_completion(&spicc->done);
>>
>> @@ -442,11 +634,40 @@ static int meson_spicc_transfer_one(struct 
>> spi_controller *host,
>>       /* Increase it twice and add 200 ms tolerance */
>>       timeout += timeout + 200;
>>
>> -     /* Start burst */
>> -     writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + 
>> SPICC_CONREG);
>> +     if (xfer->bits_per_word == 64) {
>> +             int ret;
>>
>> -     /* Enable interrupts */
>> -     writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
>> +             /* must tx */
>> +             if (!xfer->tx_buf)
>> +                     return -EINVAL;
>> +
>> +             /* dma_burst_len 1 can't trigger a dma burst */
>> +             if (xfer->len < 16)
>> +                     return -EINVAL;
> 
> Those 2 checks should be done to enable the DMA mode, you should 
> fallback to FIFO mode
> instead of returning EINVAL, except if 64 bits_per_word is only valid in 
> DMA mode ?
>

I only support DMA when bits_per_word equals 64, because the register 
operation is more complicated if use PIO module. The register is 32 bits 
wide, a word needs to be written twice to the register.

>> +
>> +             ret = meson_spicc_dma_map(spicc, xfer);
>> +             if (ret) {
>> +                     meson_spicc_dma_unmap(spicc, xfer);
>> +                     dev_err(host->dev.parent, "dma map failed\n");
>> +                     return ret;
>> +             }
>> +
>> +             spicc->using_dma = true;
>> +             spicc->xfer_remain = DIV_ROUND_UP(xfer->len, 
>> spicc->bytes_per_word);
>> +             meson_spicc_setup_dma(spicc, DMA_TRIG_NORMAL);
>> +             writel_relaxed(SPICC_TE_EN, spicc->base + SPICC_INTREG);
>> +             writel_bits_relaxed(SPICC_SMC, SPICC_SMC, spicc->base + 
>> SPICC_CONREG);
>> +     } else {
>> +             spicc->using_dma = false;
>> +             /* Setup burst */
>> +             meson_spicc_setup_burst(spicc);
>> +
>> +             /* Start burst */
>> +             writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + 
>> SPICC_CONREG);
>> +
>> +             /* Enable interrupts */
>> +             writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
>> +     }
>>
>>       if (!wait_for_completion_timeout(&spicc->done, 
>> msecs_to_jiffies(timeout)))
>>               return -ETIMEDOUT;
>> @@ -853,10 +1074,10 @@ static int meson_spicc_probe(struct 
>> platform_device *pdev)
>>       host->num_chipselect = 4;
>>       host->dev.of_node = pdev->dev.of_node;
>>       host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LOOP;
>> -     host->bits_per_word_mask = SPI_BPW_MASK(32) |
>> -                                SPI_BPW_MASK(24) |
>> -                                SPI_BPW_MASK(16) |
>> -                                SPI_BPW_MASK(8);
>> +     /* DMA works at 64 bits, but it is invalidated by the spi core,
>> +      * clr the mask to avoid the spi core validation check
>> +      */
>> +     host->bits_per_word_mask = 0;
> 
> Fine, instead please add a check in meson_spicc_setup() to make sure
> we operate only in 8, 16, 24, 32 & 64 bits_per_word.
> 
> So not need to clear it, the host buffer was allocated with 
> spi_alloc_host() which
> allocates with kzalloc(), already zeroing the allocated memory.
> 

Will drop this line, and check bits_per_word in meson_spicc_setup.

> Neil
> 
>>       host->flags = (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX);
>>       host->min_speed_hz = spicc->data->min_speed_hz;
>>       host->max_speed_hz = spicc->data->max_speed_hz;
>>
>> ---
>> base-commit: 49807ed87851916ef655f72e9562f96355183090
>> change-id: 20250408-spi-dma-c499f560d295
>>
>> Best regards,
> 
> With those fixed, the path is clear & clean, thanks !
> 
> Neil

