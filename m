Return-Path: <linux-spi+bounces-10866-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB43C12B2D
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 03:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D232C4ECC77
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 02:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200142777FC;
	Tue, 28 Oct 2025 02:54:56 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023138.outbound.protection.outlook.com [40.107.44.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCFB1EDA0F;
	Tue, 28 Oct 2025 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761620096; cv=fail; b=YDR201DPbqO45OlaOEKntCb1P0vj9hmf5Q5q3bOE3vXr++rCPbLO2/eei3gU5XtGp3SAEeqGLhHDmkNIxAuy0N430QMqTevm2fJFDiyaVXq3QpejOW+QiE+0yD56foKTWVPcrMZHW0jPKv+UFN/BYq/bQ55+e0gweYAmEkR+tMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761620096; c=relaxed/simple;
	bh=J1a5ucYg/913Td4jDVO7jqxKZ+KUisxp0wdJa3e2jdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kti5U9b+U/Rpg2VmiWX5HQ/26jXsrjWwZCbKOC6t47Se71bWxHA6SVwvQZepscoL4XltOAhnNGf6qjuIooDQoUDbKEvUb+vH1Qd7LU6Oqt4mcDi5R+nwg5IPghbdCt7Dwyl6/Zb9n07t+op+aTX6iXh+shO+2liNSjfKPqSShM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLjrNOlSbNVxlwCLuZA7IKzA6y3lx+AF2ZPkNDi4KU48uL4g2TSFJ7wt22eFzE6SKi7M1spn6w8kEToITiJoWqWB0c6rOHqPlOdPTUfpTao2uX5TjG2eCuAQye9jG7bLjDB5SFNFaLzExsOIH/mLgh5We5PUPSEIoFQ4qyxcF8Ojg9CyVHwfPkdHFDx6BgB9oRQY1cjU+wDcJF/daqKqxgaWLRZpOApzBSTByAomyom71OAxGjN3mW/cKo4YxEvBrIb4ewQK3bMseG7ms3Nhd+nhm6J46hWnfH6qclbw0w06CQ/5/Zfo5Oh1PdKNZNZh5gF5c6qwDqV81bxkCB97+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrKIs+MLrp3fK072nYRHc2NnwJhU4CFeuVXvOhDyNd4=;
 b=YTzZQJC4HVrjtC1uVKx8CfH0ydn+ZpDQQxn0QHXjBTrVcOOvLch5UqMKKFUw5Ny0V/OOgSp8AlyH63F187c6ZZ3sekrYiyO0d3QTYIl2tMaXiJw6ms29FKFd4ItFU0rc2o0QDPR0rDmw7ojCG7q+v8y7y/5+z96QuTmOVsB92Ia47r7fGA1lMIagyzC8IFrjFCTYtnWbZOwCUx/YLWpfLdAaDZsgbRXgowxfWryU+e+UymImrhukAnDT9aGTYESPBdI1dCj18+OX3e1yFCjv7MpU+Pwriy1Kg3ZdCwQZth06ZkIthrkR/zQv1PpLWvGCcHruYBNIc8z9aex+hpbX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9) by
 KL1PR06MB6519.apcprd06.prod.outlook.com (2603:1096:820:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 02:54:48 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096:4:c6:cafe::9c) by SG2P153CA0040.outlook.office365.com
 (2603:1096:4:c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Tue,
 28 Oct 2025 02:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 02:54:48 +0000
Received: from [172.20.96.41] (unknown [172.20.96.41])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id EC1FC41604E0;
	Tue, 28 Oct 2025 10:54:46 +0800 (CST)
Message-ID: <f9f43492-859a-4369-b660-7fa138c86e86@cixtech.com>
Date: Tue, 28 Oct 2025 10:54:46 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: spi-cadence: update DT binding
 docs to support cix sky1 SoC
To: Conor Dooley <conor@kernel.org>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
 linux-spi@vger.kernel.org, michal.simek@amd.com,
 cix-kernel-upstream@cixtech.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251027084239.2610141-1-jun.guo@cixtech.com>
 <20251027084239.2610141-3-jun.guo@cixtech.com>
 <20251027-strangely-reverence-6f47d87efca5@spud>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <20251027-strangely-reverence-6f47d87efca5@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|KL1PR06MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b4be6f-a8eb-434e-b4b3-08de15cd5ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THhLTHAzUDA1RytnSVE3eHZkL09NajdLZDA2ekhYUXh0dHQwMFFtcjlXZ1U0?=
 =?utf-8?B?ay9CalVJV3pLSGFrR0hUU3hFR2ZRUE11VS9Mb2t0QVJOenpEdVhzdnlnZFBi?=
 =?utf-8?B?SHI3QjM0ZHpjK2Q3OUliNkFCUUNKME9uQVJkTTdUdGJmbHNkOU0wOG4yV0RY?=
 =?utf-8?B?WTI0UVVXYUMyMmZRakYyNVZ2dlFZODZ2cHc1MnF4WHhSRFVDejVydUdwaTd0?=
 =?utf-8?B?R1p0L2Y4Uk02UVg5VHBwRjRYcmFPajRCUTU5NWhnUFhRYnU2K0pQQll2RThQ?=
 =?utf-8?B?cmdVOHlrdCtPQUc2dStiZGdWKzg5Wk83eDU1WW1USE1UVGFPVGtqejhWZnlD?=
 =?utf-8?B?VzJ4TUh5TFhIcVRsdkg0QVhHaFVMWGZVaFp4WHNCclBIaUJublVHWElyMTdS?=
 =?utf-8?B?NnRsRFhKQkZVWDV1Vk83aThGWXIrZWUwdGM1c3NZdVZQUGlicWx4SXZrSEZ3?=
 =?utf-8?B?V2YxbG53eUxVMDlub3Fpb05YbFB2TWc2S29KV1J0d3l0eXJxcjRDTmJlZ0JB?=
 =?utf-8?B?RENERGdJTDU2NW1QNmZoUW9xWEVhNC9jRlNvUGtvR2I0Y08xN0R4MVF4NEVa?=
 =?utf-8?B?OW1UMnpYd3pLVmdYOFRXS3dJN0FkTEpwOTl6cmM1ZVdQVlJ4a2NzT0FvdWFj?=
 =?utf-8?B?ZDI2SUtWL0hLdWpCUXlxTWVQamVSQmJhSVFwREFFamhPMHpuckdpMWQ5enh1?=
 =?utf-8?B?ZzBpaWgvUlVlb09FeTl4Qko4ZE05NGdZQjlrM05lT1F3aVlIelhwRVhCckhW?=
 =?utf-8?B?dUpXNDIzbFFYWmNIZkxxWlNRcCtINkxMU1FQaGtqSHpqZnNIcmtJUHFKTkM3?=
 =?utf-8?B?Y3l1ZmdQeWlRQW9xa3k3bG5UM1NCZU5XejNPcHlXVnNobFlkckc2d3ZvQUlq?=
 =?utf-8?B?cDE4eUhEZHA3Wjl6MU1aeW1Udm1ZS1F6UE9ucC9KUEdvMUtnOThlWHpnQ0lS?=
 =?utf-8?B?dU1pWEM0U0F1M3hKNy9WVmgweDhmS3BkcUpPSXZSYUV3MHdNOHV0dEx0cHlP?=
 =?utf-8?B?TVROYU1RLzJDZVJGdHluZkNUK2RMMG4xUWJGTGltNkNBQ09QNEdCS2d4QzN6?=
 =?utf-8?B?SHI0SnYzcXo4NStMZk1CMWZmcmk1dWRhMENnRVNsSVY1SmY1YjZERzlZNTlX?=
 =?utf-8?B?MnZ1QVdkT1g1VkZUOVlWWWJWK2VTdlE4RkxjWTl4Q2NWQVpUOW5DN2hYQ3Bs?=
 =?utf-8?B?MGduY3RJMjY5UlRvTU5MTDJEelNGL3l0Kzg0SHNpeHd0MXNDQ0NULzR6OHpC?=
 =?utf-8?B?L2thcWtVT1pZUW5DeFNmT2RZMWpHY0dSeXVqK3R3ZGxEUzdJUllsWVA4VHFT?=
 =?utf-8?B?UE9UTzBnUS9xUW1GMlZVN1UvbFdvQlROY1djR3phRFdtOGxlQjZyTU5CVGhu?=
 =?utf-8?B?Rk5Pa1UyZ2hvZGJqazkzaUtuVXFITmdSeFRUQ25CbXBDRW94RlJYZy9mVGUx?=
 =?utf-8?B?WG9Ga3NNS01pWEkzcnhPRzZMTmYvc0VMUUQ1MzRTOXpmejFURWlqUENYd0Vu?=
 =?utf-8?B?dk1wbFM2VXAxRVRkRHVSUUhBeThFa2xtNDlRT21tdzFXMUpPRWFFbmRyeWdR?=
 =?utf-8?B?bGQvb3NoWGwxcnE3MThRSFg3L0pTYzFzMzVZdXVDcGdpZzZWNVpES0JDR2Vt?=
 =?utf-8?B?MXJzMXFwcmdlbzZyL3JvOVppcnJVNHZXeGk3Ti9sMlgvMTQyM1NFYUlNMVE5?=
 =?utf-8?B?WlFhM084MzFVcUNBR2FJT1YraFpYcjd1c2U4Q0x6SXhyYXVPem9XVHBZTHNF?=
 =?utf-8?B?elFIVjZXS1R5TUlVZGhpSlc3TWdQVCtmTXd0Z1lkM09sNmdaSlE4Tzh3RGM4?=
 =?utf-8?B?RUw0ZXFxWWpJMnpjVURqRHBVUWVHb213MEhFdERSeXlXcjdNQ1RMeG5zNVg0?=
 =?utf-8?B?UUMwMVZtaDljNnc3OUpwbkpveEhhc1gyNlVhcnhBbGRMYSs0TGI2M2J4dUF4?=
 =?utf-8?B?bTBkaUxZY2UwQXhkQmtmR1Y3NnB3REZRRU4xdWtLcW1OYjU0NGtTb01BTUNW?=
 =?utf-8?B?UTNBaTc0cTFjZXFHT1EwUC8rd21vakhWdUlvTWFuRE9lOVM3Y2ZEamxDcGJL?=
 =?utf-8?B?eHo1S0Ryem9UK240a1ZVdlMvVG1iN2ROZjhJb2k5MjJEQk1USUgvd0J1Q3pF?=
 =?utf-8?Q?tTlE=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:54:48.1398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b4be6f-a8eb-434e-b4b3-08de15cd5ba1
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6519

Hi Conor,

​Thank you for your prompt feedback.​​

On 10/28/2025 12:51 AM, Conor Dooley wrote:
> On Mon, Oct 27, 2025 at 04:42:38PM +0800, Jun Guo wrote:
>> - Add new compatible strings to the DT binding documents to support
>>   cix sky1 SoC;
>> - Adjust the configuration of the compatible property to support both
>>   single-item and two-items cases.​​
>>
>> Signed-off-by: Jun Guo<jun.guo@cixtech.com>
>> ---
>>   .../devicetree/bindings/spi/spi-cadence.yaml          | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
>> index 8de96abe9da1..e75b142a1368 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
>> @@ -14,9 +14,14 @@ allOf:
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - cdns,spi-r1p6
>> -      - xlnx,zynq-spi-r1p6
>> +    oneOf:
>> +      - enum:
>> +          - cdns,spi-r1p6
>> +          - xlnx,zynq-spi-r1p6
>> +      - items:
>> +          - enum:
>> +              - cix,sky1-spi-r1p6
>> +          - const: cdns,spi-r1p6
> This doesn't apply, probably needs a rebase on spi/for-next?
> Approach is correct though, but it'll be a more minimal patch when
> rebased.
> pw-bot: changes-requested
> 
Thank you for the heads-up. I've just seen your patch, and I will base 
my PATCH v3 on top of it.>>
>>     reg:
>>       maxItems: 1
>> -- 
>> 2.34.1


