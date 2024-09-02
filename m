Return-Path: <linux-spi+bounces-4499-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64D6968269
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 10:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860672812F6
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 08:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B596176AC8;
	Mon,  2 Sep 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kHuq6hqB"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF0178388;
	Mon,  2 Sep 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267177; cv=fail; b=BTlRic8qXJdVrivsUJs05OVuEbhX1mEwg7GTRjbU1hKj/+y3R432tXXe0IXZlaYKxTx6+LofAxhxeD+AA1awN7364T9As1wVPgV4qOaZASIDxDuWK2mmnwQJmHLyqiW192aOrfWxgGN0og6BfVDokuzWY9m8q5PFGmKi8IuU1N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267177; c=relaxed/simple;
	bh=Kv2fKFbPKXcAJ43emOP8NB98ne4pK5lLhZD4nszPxxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NgE4O3xxLuIqjxP80Nh79FcUptq656HvRtOrLNktOtOfalp+2jPOgHZNL6mRNTOOs8m3Mv4SD8VuS1A1FdOJCRcAlrFMSdwHc/VxS+zfYjXdLdVvkQ56J80m7m/t8DmQat/1dY0U9xW51GJ1uh1TVnftH0O/HyOAXZZ1zvhLmFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kHuq6hqB; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ykwt3D6QX1BjATXn/xgREOvgVAOUe4PuPEqirnguPlvnd+19PHYWugKYXXcW4d85bZByhrv7s3Ci84GhnvU0benaT6wfYusqfUlKhbReMBzWQx8w0w7XWwPRzTlGJ3qaZxge0/y2D17i4OJUoGHQVCCmmePA+FYiWLEB/Un7mrnc3Cin/urJZkYPQxDr7qghHihfV7q9sWh3hG7IgdsQj1HAB6whAs25kmI1Xgs36+hLcZilwHDbwXsHn5u9mYhBwMk2cifcHH0SUKnBXM17zcxJ+/BrLkFl8AiRycnOpVYzKUcQv3FFbdig7wNP07qa3q0TAuz9dXL+4KYP+vRPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtvFC0tuDLJyOK/CCkUOKX8cH2Kc/SfFJAHDR1I5qDo=;
 b=Z1+r3ltvrMomjGpyNzTnjWaSja2N6+GtWCd+wiavxjuGGEa5RejfBT2Gjd+2vlT7+wz6j9CPcx00GbJSRy9k7wkGKiyl/qIGvyaeES+gZAQzGKYpEQKLR/nQ0uIioCLoJd23A2lqT1VPSMgPQi8yGjkvyu7Qy+6lCWvrfwtg7sPVXS1kY6fPcjSlqkUTTh7Gjupk3+AfM3OtzjOMqIEqPK48Vi9nF7WK6GRg5d5yZd7EfV3WQ4DnoGdCJp2jlaTeUuzgwu5QCZlW9EJKQ32uWjSO6DYmAxaDsKeKLmg/Fu2LfvoiPkfivzuHVdkrOvscsvuQSWoU6yqqi8MRnenCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtvFC0tuDLJyOK/CCkUOKX8cH2Kc/SfFJAHDR1I5qDo=;
 b=kHuq6hqBZyOOEI461du1gTqOTa5ko8SWaAI1WsJTv8XNYaFKnE9wC8HmM6SlkMFnbTlfmzVU0YfV+KJ5+1VMeG4Qt8/+pqmldnbUUNGo0KUuIPN3zFveIso3onaIIHBqUcqXgzlpdWYCTYB5U/4lpz56LIqfJhAacpKb+FMIBIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 08:52:53 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 08:52:53 +0000
Message-ID: <f4c4da23-c22e-426b-8b18-f2173a3c72aa@amd.com>
Date: Mon, 2 Sep 2024 10:52:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: zynq-qspi: Replace kzalloc with kmalloc for buffer
 allocation
To: Kuan-Wei Chiu <visitorckw@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240814192839.345523-1-visitorckw@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240814192839.345523-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0257.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e4961e-f27c-4416-777e-08dccb2ca1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am5sTVhablQ3VnFQcWc0MDlGdkRGbTRGUHF1ZVUrWGpsRUc5SzdzcGxIelpG?=
 =?utf-8?B?OGNaRjMwc3ZENmZESWpHekNTYit1MlRBVkI1UUJWRmpveU9PanozS0FYZnVq?=
 =?utf-8?B?QlBKTEx5TkVTQkNLVi8wNnQzSXA3eHh5b3U3QkkycnR1dUFxaFl2anF3WVNL?=
 =?utf-8?B?OTlEN1U2QVdXYmM2bXVGSVBsS3lwMFg4elhRbFRJUHd0K0pFVm5OSjQyV1p5?=
 =?utf-8?B?dS9lQUMrRzdKVEdmc0hXRXdDN201MHN4Mk5PVlFvYWVNS0U5V3RsR0ErNWta?=
 =?utf-8?B?ZUZNbCtnUittSUpxd21wZFZ2YTlOTDFpWEl0ZkFhMkNGNFR5blJ6QWREZk82?=
 =?utf-8?B?aWlzWmxsQUlIMCsyWkhvSk4xbkcwWlpVOW1hWThoYzl2UmwrNFZlY1VKa2R5?=
 =?utf-8?B?Q3poTFdJNTRVS0k0T2hPTzh2T0pmaFZwcU0walBtdk42cU1aWklZL0ZHa0RD?=
 =?utf-8?B?bzJoVmRnOWRGRWdwK1NqQm1pZ1lUUWV5ZHdRWk5McG9YSFppSkdPZFdzc3Uy?=
 =?utf-8?B?dTEybHZ1SHBwK1krNjYwY0w5bHExZUQ0RTZDekN3NUdWSExvUnB3d2dnc2pC?=
 =?utf-8?B?V2x4TnhOc2tIZ0oyRFpuL0J5b1p1c0Z0aXJkbDVHMHVmN3YrUjdTVlI5VG0y?=
 =?utf-8?B?MC9NMmZVS3BKTCs1VlVDL00wbVcvaThYSWVjYk52Q3c0Z0RXVFdpcmp4RGQ1?=
 =?utf-8?B?OVpJR3pPUm93NlJFVW5LNjRTcldHNHVyUXdQcWRKRzFWcUtnWEdvdUMzRFor?=
 =?utf-8?B?Q1RkSGN0YkRZREtINm1FNjBoYVAvZUJ0b0VVNWR6blgya1hPSE9jYXVzdmR1?=
 =?utf-8?B?N21XcXpvVWM3emJ3UEwzYnQzSG10ek1yb0daYVBXU1UvUWtjSjdrb0NvQWNT?=
 =?utf-8?B?MFc4TDJzWjZnT3pVbHJNNHBZc3BZUnRkZU45OExFTmxJQkF2a0dqek9ScW41?=
 =?utf-8?B?L014dkhBc3F4eVd2TGE4d3RJTytpTG1lL3JDdlRsR2ZkOGVhSUsyUDNSc1Fp?=
 =?utf-8?B?b2x3Mi9tOWtieEJNajYxekdqbVEvc3ROOU1KU2xESUtkYnlmdS9qWjhXMENH?=
 =?utf-8?B?K2U5Q0JRaTZJS3BaY0tBWXpRVllZMi9CUnRpQW1KYW05NzhBS1MrZUxLbGg2?=
 =?utf-8?B?SVlrUGNDSHBBSHlBUURud2wvRlE0elVLK2JYRTZQa21GMTAwZEdtak1Yazh6?=
 =?utf-8?B?UWhNemZUREd6T0lZNHplUGlTcVZ1bDI3TTdZRXg4VVg4dmErL0VBbmZ0UTRk?=
 =?utf-8?B?dy9NeDRxWkFKQW1JVDZCMms3R2taRnFYdy9CMjJSYVpISkU3KzJOcStRU2Rl?=
 =?utf-8?B?d25uYTRBUlhXN1Y2ak9BTHYzMFR5RDVZbG56Z0J6L1RGbDBkS2JTUWs1eTE3?=
 =?utf-8?B?amtDeTFrdzFVc2d3RFlNV0J2YUk5VFp0TkRRaVUwK0N3UmwvbjE0Zm1seHlU?=
 =?utf-8?B?NnpoWVRzRmY3WGFIUDZGNlh5dHBPTUxJNnk5aDNtU1lkR3ozcEsyYkxQbkw1?=
 =?utf-8?B?Rkw4eUJNVGhZNVlNaHZNeCtqUnRCVldSbFE3VDBOV1hZUzlGOEx3VFpmYzlX?=
 =?utf-8?B?M1hKeFROT29GcmRhb3ZnUU1SelJ4TGFaWFdiSkNkZTlXWkJhZHdvZmlORnpz?=
 =?utf-8?B?VGt6T0dFSkxWWDh2YVBsSU5NeGtQdm5Ib3hWOTBBbTlBc0VGNDN5RHl6MElP?=
 =?utf-8?B?SUZJNWpMN3l1cVVTM2lGQitES3k1SUR3VlV4TEx6Q09sYzVyRit4czdTQUxD?=
 =?utf-8?B?blhrbDU0eUFlU3ZuMGhBMGdOalRRRGc2QkJNZzZHV1ZCUEdyZVBhOHZkZlBx?=
 =?utf-8?B?ZUM3VDU4RWViOFZjYktVQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUhBS3NXM3BuR1lCWElna3VCanJ4Zkk3dDBQVHJrK1JyaTc1R3JUS2pMN3I5?=
 =?utf-8?B?cjZkQ2JNOFY5ZHkxTld5cTVPdHhqK0lSLzhlNHp6SGluZ2F5ZXd1b0R0bVFP?=
 =?utf-8?B?VHE3azd5Y0NkSmRLMEZyQWtPTUdPcjhWYm4zaFZXenBWTmFQRzdoWnYvcnRu?=
 =?utf-8?B?M0hramMzQnk3all1cVpHZlRXZE8yNzhRN1BZcUd5aUJJUlcvRFJjZitia0Fa?=
 =?utf-8?B?N3ZubkZiMU84aFpqQWF5ZUd6ZnNrZTRaTGxJaUVsZzNUYXFOOVZKV2FEWG1R?=
 =?utf-8?B?TTBPVWJpcWJ1SjY3bTJGT0o0b2JRWTVMaUNXaWxyVkMwbkViL0E3VTZOT1lT?=
 =?utf-8?B?RFZ2ZndLbnVMRGg4MU9YLzl2NE1QclJhTGhPWE5RTjArU1hDK25TRTFaSkwz?=
 =?utf-8?B?L0xDQXdCOG82aGZqQi9RUndtejJ5ckVEVFgwN2ZhcnVzVGZZMlJrS0RBMm9R?=
 =?utf-8?B?ZVR3UFNVWEFvVUFOa3N4YU85MmM3QSt0OGFvTm1GeXhhY3M2OW0zMlNEZ2JV?=
 =?utf-8?B?L0hLbFZJM1BMMlNLZFpGcnU0bVgyQjZib2Y4WGVOVjZTSWthUXF4cU5WRE9w?=
 =?utf-8?B?Y3BvRjAvNlhDQTZFcW51K1QrQjNVN056OHBDaHJPNUZGMFA3eTdVVEVLN3c1?=
 =?utf-8?B?cytrRFNEbGhwUnYxaWdwd20rRzFnWmtzVk1UQkFXTlBESmxHQ3dSVWVHNHJL?=
 =?utf-8?B?anhONGVEelZCVzloQmZQZytlU05wNFh0TzdqRkR1cVJzZ2FnNE10WG4vcWwz?=
 =?utf-8?B?UHpKMWN0YnQxdWRIZmpmcExwemJHcDRKRHhWNnNTeDdPOXV4ZnVCK2VTYzQ3?=
 =?utf-8?B?eTc1U1ZlZHV2bDJxOVpMelJTUWxJT241U3F5YWt5dFViV1NNcFdKazNnZnJ4?=
 =?utf-8?B?dHdrTy9pQ20vQ3VzSGluand2MGF5OTZyb0MrREU2ZkhCMG5qb041QnZ0TFV3?=
 =?utf-8?B?UEZEYVplL09zOTNCNEVkck9JUTR1U0h1cXVMV3VvTG9xUklaN0xyNFpYRmpT?=
 =?utf-8?B?MlRtOHRETTRCcnhZSDVSMkY1T1REdGZISSs2NlAxU0I5VlZqbHNVYXJxVXk0?=
 =?utf-8?B?cmhnemJiU2RXa2thR2hkdnd4d25yNlZkYWNKMTQ5MTVXU3N0SW5YRDRkYkVE?=
 =?utf-8?B?eWNUcXZQdXVNVm43MnArV1A4SlRNVFJxSjRXZnhhNzRwTjhZUURNMVFGQTJM?=
 =?utf-8?B?cXBGbGVBZjBpdmdDRkp4Y2MrTHk5UEh5bXRkV21rcFFyY2tIL0k2bWlraGFl?=
 =?utf-8?B?ZDVtbnQwbHBOZW5iMWJaKzgreGdxM2FDOWlkNGtrZUxPOXRPM1VwSDRocjYv?=
 =?utf-8?B?bE1kY2NSU1JxMExGdUxhRVh5K2N6SmN2ZUVoK2pVdzNmQ3hvTTU0YUZoRkl5?=
 =?utf-8?B?NlZqMGdzdy9VQUlqZzhsVnkvU29lY3kvZnU2RE14OXZJRUI5ZmN0eVNva1Jh?=
 =?utf-8?B?d2x6OXNJYUJJT0FsckVmdUhxK0N2bUQyNy9JU0dRVHhjLzVGQ2U4blFnTlNo?=
 =?utf-8?B?MllwSFc1cHhaYUlmR01xbWJEUTB4M1RodDB5UnJHUWZCd0grdjhtclFQcksw?=
 =?utf-8?B?eVExWGlLa2lCZDNaSHRFNVYveVpIVjdDNHpNTnZHbkJtNC9LSksvN0FzUjg2?=
 =?utf-8?B?TFYwdC9rMUk2OCt6Z2xPc0VZcGw0N2pXNWdBcEwyMmlxSzlhWEhYK2xxMFc0?=
 =?utf-8?B?WEs3cm53L25keFNZTlB4Um5aV3F0MXFhdDJmK0JWd1VFUXdSdkJNQnVmemIz?=
 =?utf-8?B?L0FOZHBBV05zTzUzMHNlZW9pMEJTK3VPQ1lrNjQyUmZTK3RkWEt2cWJzNVQ5?=
 =?utf-8?B?K09QUDhJWkFiSUVvNFJ4RTBsZHFpYjNhQnZNTHZLS1g1aUFDaVFDT2dPb3oz?=
 =?utf-8?B?ZzhIMTdla2ZmYnM4c012UDlDN1BkMnZhNkVvMStmdnZicDUyMDAweWNYM3dy?=
 =?utf-8?B?Vlg3N2ZZOTg5elo5L3k4WWtoczZKY3dJSk1CU1pzdVo3S0JORUdSUlRkUmpJ?=
 =?utf-8?B?Skc5N0JzNU9wdFNMNEdSQWloQjNXRDhicEcwcmRPWW9vWSt6amt4eVRQd2t1?=
 =?utf-8?B?R0pCUTdtZ05ZZW9NaXUrc1FmZmpwa3huQVo5aW5yM3dOcEVXVk8rMkJOZy9L?=
 =?utf-8?Q?IhlkOvX/VqIkExgsqQwaj3XrD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e4961e-f27c-4416-777e-08dccb2ca1bb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:52:53.4458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4vhJUhq1YzKqtQD2Zt0nLubnJRYkXGFnYz/eT5zbsZBtY/k1k0VtktZtpLCEH1T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371



On 8/14/24 21:28, Kuan-Wei Chiu wrote:
> In zynq_qspi_exec_mem_op(), the temporary buffer is allocated with
> kzalloc and then immediately initialized using memset to 0xff. To
> optimize this, replace kzalloc with kmalloc, as the zeroing operation
> is redundant and unnecessary.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Note: Build test only.
> 
>   drivers/spi/spi-zynq-qspi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
> index d6325c6be3d4..b67455bda972 100644
> --- a/drivers/spi/spi-zynq-qspi.c
> +++ b/drivers/spi/spi-zynq-qspi.c
> @@ -569,7 +569,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
>   	}
>   
>   	if (op->dummy.nbytes) {
> -		tmpbuf = kzalloc(op->dummy.nbytes, GFP_KERNEL);
> +		tmpbuf = kmalloc(op->dummy.nbytes, GFP_KERNEL);
>   		if (!tmpbuf)
>   			return -ENOMEM;
>   

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

