Return-Path: <linux-spi+bounces-11001-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C9BC34A18
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 09:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FC05637C2
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 08:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564002EC0AA;
	Wed,  5 Nov 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OtSmZnMU"
X-Original-To: linux-spi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B32ECD1B;
	Wed,  5 Nov 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332973; cv=fail; b=EvWJCbtasp/8hNNf73G/5+WoHZqGkCH5OIXRG0/KqIfOcmlKqmOf6SbTDn4FmRwXgaVFuOvW/sDWHF+JcU/zYomJjb5Aux+EcUEWBkOWe02zqvO/E0lRT6dtgBf62m1Nv1W3dCg4Bngjc+srbRDGVjRqhCa9Ke7psh7Liq1ixDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332973; c=relaxed/simple;
	bh=83TzPDzI4bvamPrLZsTFlwxB05Qf845BhhORnfsAt3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mXIq6O/Z9H8xHde6JeonBGyL6UZiiEv6BeGgxBr2LhRxJcv1hZ27IuPr4aTCjOVq55SCrze8/upgEBzXxLxSloA73ERykVeKMBLaAtVx1x2oGLZT4TFv9jz7uR3BJItueceOHHCQiCuCuTR4jcW5UznGO6zmhGC5Qol5JjR5Pd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OtSmZnMU; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlspQ5sfDh91g4LkpAF+a7njuIM/Az/1hOqgute5OcXQRKHGpYEaY4clsGFHNxj5t6CzMfOR/TMd9DPJJVKbmLnwkzzZJwUBd5xwwNZb6+t3gKxSzKCXmFue3DV3O3sY1SlSZgfgW+RjP9oPW7FL7oz5MeBQouu9gx5vM1u57i2bALq/WOBJJhbeSHCActxPD6SiOpa0khsUGGthyoJ+RrLfKkoCaOw09WmdMccUt1cFekaGg6TEcI8EkFyf7ByZk2tNPpIikBQ++rK7ngl81yTpks69vy8DhhWu1qiGqK2zwM+YjEWJKE+fbS96b3OMhAjjxwtfOZLuZEePzU6zOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDqm4rcvWvlCpx1cGgQ42uwyBw/hMeyG3HE5RqKlfp4=;
 b=AA2m6//o6BTSH3sVRwaypAHbY/dd/P2ArduPnb0pjuRalelZLPrua3pok2RGI9LLW17RQsYg/6k+c04QkySo7b0hsVMzl426g8C7v8HCuswj/yw7pQiHyat55/CMVCPpKx6cRwcYVRPIgJVsxnRL/1HSmzZV2a5yAID3rtr+zBuNmYeDdabY+ZBtoeE4g+7TfJs9LCBor7s0j8ks/P4r4PwPRI7qSK4MQly+zB/P9BFy2CYJwlcH6U/Qn+4AuyRp5510LmJ3Lr/G9oeCG7blKu9JAXVaTFktNlCMMpcz8tLEHnFqHh/l6fNb77MTZPVRZVcrEpXg6QDiWN8G7yaX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDqm4rcvWvlCpx1cGgQ42uwyBw/hMeyG3HE5RqKlfp4=;
 b=OtSmZnMUzUigqZN/imCUQKkuWOEh67rDCyrwRfFEqaa+TyCHuOcErkSx+LXUkq7DQZ5E6q40ut7nBGz7KRnH/2WtIU5d8yIEfk51PKbM5sY7EUsymt2TbgeFnOuIBPIGb5l70sKXdfJeQMYTSNGkGhFmchVVaX/dkuBoRsR3ujI=
Received: from BL0PR02CA0043.namprd02.prod.outlook.com (2603:10b6:207:3d::20)
 by SA2PR10MB4748.namprd10.prod.outlook.com (2603:10b6:806:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 08:56:06 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::cf) by BL0PR02CA0043.outlook.office365.com
 (2603:10b6:207:3d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 08:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 08:56:06 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 02:56:03 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 02:56:03 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 02:56:03 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A58txfk3397118;
	Wed, 5 Nov 2025 02:55:59 -0600
Message-ID: <ea19bc64-a775-4309-8f3b-ce9dd8ac02ee@ti.com>
Date: Wed, 5 Nov 2025 14:25:58 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
	<tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<p-mantena@ti.com>, <linux-spi@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<a-dutta@ti.com>, <u-kumar1@ti.com>, <praneeth@ti.com>, <s-k6@ti.com>
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
 <cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com> <87qzunt4n4.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87qzunt4n4.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SA2PR10MB4748:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf82e82-1f7e-4e39-38e1-08de1c4927fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEtreTZEMXR3U0dJTjJvUDlHcUFDbytvYXhmK2Z2MXNMZ0hndnVIVEFiRWl3?=
 =?utf-8?B?MGJ5Zzc4cnJwcVRybFdHMHRmUjZuZ3MxWU43bDJyTWhkT0l5VUg3TWxhS3Rq?=
 =?utf-8?B?dG5EV0FyUGRqY3pDLzFWYUJsYzN4dmVXcmtDSElJQ3h6dGtJSXFYOHNBOHpX?=
 =?utf-8?B?QVFlV3VnekpsanZmT0IxdEhURkVGNlh4b3dGRmVaUXhsVjYxR1MwQ3ZRMGw0?=
 =?utf-8?B?a1hYd3ZNcW12eGlRT09pbnRGMWk5Q3VqY2dqUWtiZnRPWTBlVWV6a3h3R2l6?=
 =?utf-8?B?ZElqc0ZaU21pTHNRbFAxSUNnajFCSEhhWjIzRURFQ3ZtZFRueXpMN3Vqd0tx?=
 =?utf-8?B?YW5JaHpEdmgrOGV5Rm1EbEJWelJ0TnFmUGhmVFF1RHA2bjZiNklqbXhHelpS?=
 =?utf-8?B?MTR6N2ZSaVBDb1hJVE9pU1BEdjFqMFF5b3kxdWNrcHFYbHNIdERXSGpkck1m?=
 =?utf-8?B?MWh5VkhTa2dqai82aEN3cHRXZHBmWnJpMnFPaGlEbzFrSlpUZ1Z0cS9uYWV1?=
 =?utf-8?B?UldMYUw0NDdNdnhUMW1xdldiOXJwSUZXSlRKNXFvblFRbzF4Q2p5aDBaSFFw?=
 =?utf-8?B?V2hjTWx6cWV1N1Izc0l2WDdhMEFrakxoenhZOC9JWmd4ckFWYi9RUkhIbGF4?=
 =?utf-8?B?NlIwaTVmbFdGYTZGRGxTd3drbFMyNUVMbTZWQ3UxMVdPZDVkL1ppaGNDK1RP?=
 =?utf-8?B?RVpENS9LeHlwOGlwMGlrVGI2UFAyYmUyOEhaYVJzYmEzN3pYSEJmSGRjd2tQ?=
 =?utf-8?B?cVVqamc3bjgxa0NOZ0Z3Y3RDNkVyYzZOS1U0V0I1ZnVURHo4Q2QxU00yV3Ax?=
 =?utf-8?B?eUl6aFB2L1hnZG1zZ21tU1Bjb3g1dnZTbEwxeGh5UGI5bEtlL0s5MndFdnd4?=
 =?utf-8?B?SXNqbTRkN1FEc0RSalBUeE1ZNElYOWlVZXBldXUwTFZrbzNQMmNPWXM4M0tF?=
 =?utf-8?B?bXBvWW4vU1Z4YTRJUVU5Y2cxRjk0TVY0bFJRVFora0RuTjBDWGxSMEdSd3Fx?=
 =?utf-8?B?Y0dYTmZyN05Obkx6Sm9xZnVyYzlpU2lIZmY1SU1rcUNZUEpaRDMwbnU1eXp6?=
 =?utf-8?B?eE8zTGYxekhMR0FUSmRBbitjdWNWNGt4SW5wR1V3QURKZFpkOFBtcUdTWVFm?=
 =?utf-8?B?d29INm4wSlN3UVUxeEZMVGNHTkhMVXI3RnZZQnFCeHVFLyswd2NjUnNyTzJt?=
 =?utf-8?B?aW5uUTZPRDRySHZBT3JOU05YeFhCMkVpNDhXL3FSbThYZXF5MHh2bFlwMEdv?=
 =?utf-8?B?dCthK3grblNWWDBOS2pod3oweGx1Y3MwNytqNy9LTThRdjg2QStPMEx1MWJt?=
 =?utf-8?B?OTZTSXI3bFhEQU5yNjZTRXFTd2RKTlNkZG1uSGVGNm9rMGJ2VW9YUlZvU1Rm?=
 =?utf-8?B?SzdyRXp6eDNWaFoxNElaUTJWcVZ0ZHM4QW1VNXFld01LNnB5cXd3eXJMeWlk?=
 =?utf-8?B?SUZqb1A4bXBaUXlzVVVUQjl4WkIvNlFobEYwU1ZEMEpmdHgzY0tnTkF5d3hU?=
 =?utf-8?B?NjdsQkZxZmdBWGlRVUEvOVMwTHViQTNSeVFMWlhVUko1UkpkNTJRUTltbkM1?=
 =?utf-8?B?WE90VXBzWXR1YTdnOGhsSW05T3lPVTJwcWE5OUVRSFViQW5jVTJVT1ZJbXZy?=
 =?utf-8?B?ejBEZUs1M1I5LzlIbVpoUXo4emlPa2N5aHhMUXVUYVlkUm9IWFArR1ZYaGNN?=
 =?utf-8?B?M1N4MzFSZytldlI4Sit2MWtRYXhrWk45dXpRR3J6bWVLSUkxRkJpZ2VNdFRx?=
 =?utf-8?B?N1NweVJKUjUrNStKZlRZVldiZktrODJjVkJKMFBhZFVRYi9keVlDT3BWS2lV?=
 =?utf-8?B?dWF5aFltTFRYdFh1QlpRNlNKc0VFZU5Eek9xdk5ucUxJUk9WaVhuU0Ezd2xp?=
 =?utf-8?B?QVB3T1FraFBTUlIvdVV4WXdZeXl1RncvMTNhd1R4eGdnaXZtU09lVFNYTUlQ?=
 =?utf-8?B?RktmM2pzVXJUOGxiM3RtanZWVk14UE5Mb3pZMVFzM1dpV2NVTmxCME42RGRL?=
 =?utf-8?B?elEwMlJlVktrbFVVMEIvWnUxUWVNajBqUkR0Qk5ZSVRuNlUwZXlrRWhzVDdC?=
 =?utf-8?B?M2syU2lZdU9Ba3l6WU1GYkhYbmM4NjNIZ0ZuTFA3VTBtVllJMEowVEdLdU8x?=
 =?utf-8?Q?fioM=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:56:06.1114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf82e82-1f7e-4e39-38e1-08de1c4927fd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4748

Hello Miquel,

On 28/10/25 21:11, Miquel Raynal wrote:
> Hello Santhosh,
> 
> On 20/09/2025 at 23:25:31 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> Hello,
>>
>> On 10/09/25 13:51, Miquel Raynal wrote:
>>> On 12/08/2025 at 01:02:10 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
>>>
>>>> From: Pratyush Yadav <pratyush@kernel.org>
>>>>
>>>> Some controllers like the Cadence OSPI controller need to perform a
>>>> tuning sequence to operate at high data rates. Tuning is needs to happen
>>>> once the device is switched to appropriate mode (say 8S-8S-8S or
>>>> 8D-8D-8D).
>>
>> Apologies for the delay in response - I started prototyping new solution
>> based on our discussions earlier, which took some additional time.
> 
> My turn to apologize for the delay, especially since your feedback is
> very complete.
> 
>>> This is actually wrong. Tuning is way more generic than that :)
>>> If someone wants to use a chip at a high frequency (50MHz in your
>>> case,
>>> but whatever, there is a threshold above which additional care must be
>>> taken), it must go through the calibration step. It does not matter in
>>> which mode you are. Calibration would still be relevant in single SDR
>>> mode.
>>> This 50MHz bothered Mark because it is too Cadence specific. Maybe
>>> this
>>> should be a controller parameter? If the spi-mem core (or even the spi
>>> core, by extensino) sees that the design allows running at XMHz (due to
>>> the SPI peripheral properties or simply the absence of any limitation),
>>> and if the controller states that it requires an extra tuning step above
>>> YMHz (and X > Y), then it launches the calibration.
>>>   From a core perspective, I would like the calibration hook to be as
>>> simple as possible, because what "calibration" means is highly
>>> controller and chip specific.
>>
>> I understand the concern here.
>>
>> Let me point out the options for launching the tuning procedure, along
>> with the issues in each approach.
> 
> Very good summary.

Thanks you for the review!

> 
>> Option 1: Launch tuning as part of spi_mem_exec_op()
>>     - After spi_mem_access_start(), introduce a spi_mem_needs_tuning()
>> check (a new callback to SPI MEM controller) to check whether the
>> current op requires tuning
>>     - If yes, we call spi_mem_execute_tuning()
>>          - on success, mark tuning complete in a flag within SPI MEM
>> Controller private data
>>          - on failure, we attempt a fallback by calling
>> spi_mem_adjust_op_freq() and drop to a lower supported frequency
>>
>> Option 2: Launch tuning within spi_controller->exec_op() implementation
>>     - Very similar to option 1, except that the spi_mem_execute_tuning()
>> is triggered from within the controller's exec_op() implementation
>> (no need for spi_mem_needs_tuning())
>>
>> Drawbacks in option 1 and 2:
>>     - Tuning requires multiple reads of a known pattern, but the flash
>> may not always be in a state to allow read commands
>>     - No fallback on failures, can't make flash-specific adjustments in
>> case of a tuning failure
>>     - No access to write_op() to write known pattern temporarily to an
>> on-die cache. Pattern needs to be always burnt into the flash
>>
>>     - Plus, in option 2 - we can't call spi_mem_adjust_op_freq()
> 
> Two more significant drawbacks:
> - it adds an extra step in the "fast path" -maybe negligible?-
> - spi_mem_exec_op()/->exec_op() are called way before being ready for
>    calibration.

Yeah, it's negligible - the tuning runs only the first time that op is
called, and we just store and reuse the parameters after that.

> 
>> While the need for tuning is dictated by Controller specific
>> characteristics the ops (and state of the chip) required to complete
>> tuning is under the control of spi-mem users (spi-nand/spi-nor).
>> So, it's impossible to achieve tuning without the help of spi-mem users.
> 
> Sounds like a constraint we can afford indeed, especially since the ops
> that can be optimized, are flash specific (relatively few content to
> share between spi nor and spi nand).

True!

> 
>> So, Option 3: Launch from SPI MEM clients
>>                            (mtd/nand/spi or mtd/spi-nor, etc.,)
>>     - Once the spi-mem chip is completely enumerated and best read and
>> write ops are chosen call spi_mem_needs_tuning(read_op, write_op) as
>> a part of .probe()
> 
> This looks like a decent place, but there is one limitation to
> workaround: picking best read and write ops require knowing what the
> controller is capable of in terms of frequency, which means we must in
> advance expect to set up calibration or not. I don't think it's a
> problem, this is something we know in advance thanks to
> eg. spi-max-frequency in the DT, but I still think a controller specific
> "maximum frequency without calibration" capability must be carried for
> the controller to decide whether this step is needed or not when asked
> by the spi mem client.

Makes sense! We can maintain such a property to directly check whether
tuning is needed or not. I'll add that in.

> 
>>     - If tuning is required, call
> 
> I guess "tuning being required" is a controller choice, based on the
> target frequency for both read/write ops and the controller capability
> to achieve this.
> 
>> spi_mem_execute_tuning(read_op, write_op)
>>          - If only read_op is provided, it implies the tuning pattern is
>> pre-flashed to the partition
> 
> Interesting. I guess that lives some room for tuning PHYs during writes as
> well without more core modifications later, isn't it?

Yeah, you're right. See Patch 08/10 - we enable PHY for data writes.

> 
>>     - On tuning failure, retry by re-running spi_mem_needs_tuning() with
>> the second best set of ops (max throughput - 1)
> 
> I would like to challenge this need. Can the same calibration fail if
> attempted multiple times (eg. because of the heat?) If yes, then we need
> a fallback indeed. Otherwise, I'd be in favor of just failing the
> probe. Calibration is an opt-in -> users must allow a higher frequency
> than they use to in order to enable the feature?

It's possible the same calibration will fail intermittently for
different reasons (temperature changes, as you mentioned). If tuning
fails, the driver should fallback to the non-PHY frequency so the flash
continues operating with slower reads/writes rather than failing the
probe (availability should be prioritized, right?).

> 
>> With option 3, spi_mem users are limited to calling
>> spi_mem_needs_tuning() and spi_mem_execute_tuning().
> 
> I would even go for a single spi_mem_tune_phy()? Or is there a point in
> having two helpers?

May be not needed, we can do the check and tuning within a single
function.

> 
>> Rest is hidden
>> within the controller drivers. If spi-mem users change read/write ops,
>> the above sequence can be re-issued.
> 
> I don't have use cases for that in mind, but why not.
> 
>> The controller can store the read_op and write_op in case of a tuning
>> success and periodically re-run tuning, ensuring we always have valid
>> tuning parameters.
> 
> You'll have to make sure you only use PHY calibration for the ops that
> have been used for the tuning though, because for example as I am
> working on octal DDR support: during S2RAM there may be the need for
> returning to SDR mode, which in turns will have to work without the
> tuning (tuning parameters will be incorrect for this mode for the time
> we run slowly). So either the controller knows which operation should
> enable PHY optimizations, or we must perform the whole calibration again
> every time we suspend (meh).

The controller's calibration logic is straightforward - tuning is
required for higher frequencies and not for lower ones. So we need to
perform calibration each time we switch modes.

In the future, we could enhance this by storing the operations that
require tuning along with their respective calibrated parameters within
the controller.

> 
>> One concern with option 3 is that we may not be able to make use of
>> static data on certain flash as tuning patterns (like reading parameter
>> page or SFDP table for tuning instead of controller specific attack
>> patterns).
> 
> This is true, I know some devices can send patterns during dummy cycles
> by I have no idea how powerful that is, nor if it can actually be used
> in Linux. One need a controller that is aware of these bits and can
> itself adjust/fine tune its own configuration. For now, I propose to let
> this aside until we get real hardware that can be tested.
> 
>> Please let me know your thoughts on which of these directions makes the
>> most sense.
> 
> Let's got for option 3. I'm eager to see this moving forward!

Yeah, I'm eager too! I'll send out v2 asap.

Thanks,
Santhosh.

> 
> Thanks, Miquèl


