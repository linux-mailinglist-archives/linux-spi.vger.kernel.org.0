Return-Path: <linux-spi+bounces-11734-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 811FDC9E1D0
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 09:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEED9342F2A
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670E25783C;
	Wed,  3 Dec 2025 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fW5alWo5"
X-Original-To: linux-spi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6223AB81;
	Wed,  3 Dec 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764748950; cv=fail; b=YX21gcRunbeK/k39dZrhExB1jDkQloeEd7m/QKEaRb4i+LoIpi7SPJYWlbw9qlXuB4zjmYyrxXzZzMWOzbWomTzwjg+hNQZCKR6lL/O7LnPHqFg7DtUNvkGkqP+PetW9Q0qgSPuhY92/W11jpTKuCC+9aOsw2E3WRhvVetXEv2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764748950; c=relaxed/simple;
	bh=hfE9XZ1rlf0EAKHqVYgeMR/7xDRX9Gvpdu1F9jJkk0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yy7UZYvyX2X0i7S4kyBCt4vUSubUGKiUDR/Wt//IYY5xkO6S4YhfbxngpolTYljtrn8du5sE+fLYNX/SaHT5NGMA6fl/8RnRCJoNvv9txqRxwapJLtflbf8Iy4/Y4w2+GX3B0QiFmrNnvg+3c0Qzm/hBOfgH8cG1CePq5ttTEyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fW5alWo5; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ejm6dvYTxHp6jh35WU2gWJkJHatA4uLM451TTBU8jwA6OAZvqeyYO3uMrHqDkO+TMe906XwykIfwF/TznK7kYQPytJRdAnXD5OBHh8VXUhGB2G0LfhKNTPxiuNMl7zvos4qK/5cyM6m5DH/6YciuTlBopj75dx0tGUWa60FKL3Ammpmdu+yOIV86Jw1CI0xz6K4sW/+MR5JNRBnmMFj4ismZQlie+1utsl5y1Grs0fmIgqbTREreSEiUllH3RTWiRnDgJkVG8hdbD/GGz3I7iNbAMOvtURJRlb9aseYwg8Zs9tm2qP6cxRuKdcnkPCq2LoY3nGEw/KXjWdnmyckEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksLulRlPbfpxkXMMTW+rTsj1x6Z7CVk3fdSGMh+h8ZM=;
 b=e9twPzQNJRy39mGKnY0dIsVKHQCzF/mh7qiXa0tfp4pyhGRt1ZKJdNvH3oEQ4Zd2NHAW91WJUHa/dboug0trdKs+b6SpDN0WIyhBdHPVWefD4CGaL6cHvpZnziSpI+78PYFBW36tkEetbiJf/+Nn7PuKMmYk5pz9DuVgFrqyQuheeO29mZFWyRs+2GhjGTyEuYPp6sSIJbdBXq4hM9fhpW9jbo25eCosEqqZ7D2g9UfIwyiqebJ1f0O1LSBgP8U71HayOb68+sYqfYVmAfwRxKClQiMQx5+tkP+T7QKkeQazFup+VDi2rZawzJU8dihYriAMMdQkCDJBZVx+ooYn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksLulRlPbfpxkXMMTW+rTsj1x6Z7CVk3fdSGMh+h8ZM=;
 b=fW5alWo5GxHBv3uykJQtuZgabZbiROdYs7Km77yAUy/BJsEOPIY7gYViwCjkrLT8hp/zXtAAJU4mvZT4BJeU4Kkb1pieQMzrfFzWcE+yPo3NxCqjoIdKya3bK6zsl/ysLAmB6Q7KgkWC+xOQNLG7u0bSuPmKM3JVYLl0UzSHi7Q=
Received: from BL1PR13CA0096.namprd13.prod.outlook.com (2603:10b6:208:2b9::11)
 by SN7PR10MB7104.namprd10.prod.outlook.com (2603:10b6:806:343::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 08:02:26 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::98) by BL1PR13CA0096.outlook.office365.com
 (2603:10b6:208:2b9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Wed, 3
 Dec 2025 08:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 08:02:24 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Dec
 2025 02:02:13 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Dec
 2025 02:02:13 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Dec 2025 02:02:13 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B3829xB3686810;
	Wed, 3 Dec 2025 02:02:10 -0600
Message-ID: <fe103265-7a68-41b8-b168-15a5e19abb3f@ti.com>
Date: Wed, 3 Dec 2025 13:32:08 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
To: Pratyush Yadav <pratyush@kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
	<mwalle@kernel.org>, <p-mantena@ti.com>, <linux-spi@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<a-dutta@ti.com>, <u-kumar1@ti.com>, <praneeth@ti.com>, <s-k6@ti.com>
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
 <cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com> <mafs0ikf74fja.fsf@kernel.org>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <mafs0ikf74fja.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SN7PR10MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 2002c00c-378a-47a2-27a2-08de32424b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG1UeC9JUy9kYldBcENqTVd4SDVzSWJqUHZFQlYxZjFTMjFYcW9ub0p2bFlH?=
 =?utf-8?B?S2xoK0FYWUlhakxOT3NUcUxkU3R3TTdYUyswMjUrZTJ4TlhmaXpmdStPZ2xG?=
 =?utf-8?B?eU5FNTRTUFQyQnlnblJoZUUzVk9PVU54V0MrUEE3QVcvRjNxTXA5NWMxbFda?=
 =?utf-8?B?WDBnelhyalg3YkJweFpxTEEveVF2MzlkM0dWbHJmN2NvbUEvYVdPbTQ1Q1JJ?=
 =?utf-8?B?OENPaFBOMklyNklSOXNrSjVWVEVETjcvQXJpTkZvV1A1UUJhZGFxV3JNMzNi?=
 =?utf-8?B?ZFBySkhHQlE3dS9SNEZ4dk85UXhpZlVxaUJld1djMUtMWFVoTXlJdEtDMzJ3?=
 =?utf-8?B?UnlnMXNvSG4zMHd6UWhXNXRjdENLa1RRUmRBL1NadlZ3ejA2M1VmQ3ZINkxN?=
 =?utf-8?B?MnZBNVJiUWNDQzgwS2lvWEJOMW1IMjVkb3ZNTzZnMCtNTjNEcVFGTEtGWlh1?=
 =?utf-8?B?NXpYaS9CVjZkemIzU3FXNDVHSlhSM2RETjRZS3FiMGVxb2ptKzE5aFgxd25y?=
 =?utf-8?B?VlQzM3hCcUZRK1BQTi9hNnRYWXNoNW9CeURHNlptRURnRVAybE9jT1JaQnZa?=
 =?utf-8?B?V3JnWTk5L1YrcU5pb2FhZHdydXpYSDdnVjU4QldJVEpnZDI3emo1RVhKcnBl?=
 =?utf-8?B?am1vcnJFTmp5ZFVXZFF1b3BBVGNrc2lqT3ovSmpDZ2RSK05nSm9mMkFMOVRP?=
 =?utf-8?B?K2RZUlA1dW41TW9DRjQrZGtHK3JIeU43WDY1dmYyTlR6dEIwaDVZNmFpN041?=
 =?utf-8?B?T2FYUWZhRC8wMWplcGR3bGwzSXBoVnZIVkVoTXlLQWxOVkZISTZaL0IxM09C?=
 =?utf-8?B?L2lnd3pOL0VYM1IrU1dPZVVLM1FUV2c2VG5hdjB5dGF4eVlKYjJod0J4ajV6?=
 =?utf-8?B?WVZqQmZQUHBZQnk0QzV4TnlKRUVUS1hzTGZDT0ZaS2RBTFllRXI4VHNLSno1?=
 =?utf-8?B?b1pBQnBPRmUzanFCc2pvUkxGOEJGcU1WdkxzS1ZZTXpNL0lkbkJSakZpaDJB?=
 =?utf-8?B?RENoU0NLRE54N09JZG1kWlN0M3RDaW0xVUxMVm5jK0NVWitTMkxFSitLbjUr?=
 =?utf-8?B?Z3ZpeWpNMmYreHkyWlVySEJJVk9xTEIrQXh1ZlNtRWtqWnptVEh4dThUUERM?=
 =?utf-8?B?YWQwQmh0K2Uxbzcxc2JYVTdSYWxGNlp5VUkvZWFOT1gwcHNJc0paOXFMN2ZI?=
 =?utf-8?B?ZzdMejlZeWxjZXVvV0dQbUhQNUxaVklPYjBtdUwrVHdDWkkzS01LbXhzVXZv?=
 =?utf-8?B?ZzJ6RGsrN0VjaXNwODM3S0diSmN0Snk1dVNwTmJFRVNPQiszSTg2SmZOUGZB?=
 =?utf-8?B?dDF4TW1wQVIrRHZCQnJXTkl1R0NWWFlkY1ZrS00wb2Z0b1N2VjF0eE5Vc1l0?=
 =?utf-8?B?Q0hJcWM4N3lCUWJhOXI2aG02NkswdU8wbjR1dUEvWWZvRE12ajlnNWh2N0FP?=
 =?utf-8?B?UDdCdlZ5ckFTUGtvYW1vWGxtRVZrR3ZSQzR5MnVYNnRUTE12UEEwZU9tdnFY?=
 =?utf-8?B?bVFHNU0ybnJmMFR4eWVyU1MxNHNZTmI3aSs4UHAvaEJIbWtrWEhyRTNoNHgy?=
 =?utf-8?B?Nm84UTZBTXI5STZHUy8ySkhzQktveCtTdThtZmtTdGwxZ1dLTkxHa0pwbHpS?=
 =?utf-8?B?aGorME5mVmFkSHVwaEZpaGhPblpTaVVWMkZFaWRTUE5zelVmUmgrbkxEbk9F?=
 =?utf-8?B?aVFLWlh3ZnAxUTNGUlREdmVKeDM4TXRtMUpGdU85czIyY0xRQmRhemlhNEdt?=
 =?utf-8?B?SFFKY29PUmE1bytENHFPY2d5c3loYWcrTTlLL0ltc0h0cjE1aFlUY3VLQjVi?=
 =?utf-8?B?MURKUHRLSFEzQmNYeWFPeXdHTkQrWDZGVXJMZjJMMENkZ2R1Z3RIejFJRVVG?=
 =?utf-8?B?aW84amlCNyt6eWlmaXBvYXEwZGhUL0IxOVZ4bWhEVk1QWlorR3JGWW1abWxq?=
 =?utf-8?B?RDY4ZDN2N1RPL2ovbHF1UUJuaENHNlNFbEx5b3A1RURtbGl3MDUwSHpSQm9C?=
 =?utf-8?B?bFRWcTNSVlVJb1dxdEsxQ0k3RVZvUm1IVXlIbC9WL3FzRC9SblRaU21XOFI1?=
 =?utf-8?B?eHExSm9tMXpKZzh1ZEdESnkvN3JXNXZ3TnZsZFgwOHllQ3AyYzRHSWprQkk4?=
 =?utf-8?Q?CI9g=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 08:02:24.6418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2002c00c-378a-47a2-27a2-08de32424b69
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7104

Hello Pratyush,

On 18/11/25 19:19, Pratyush Yadav wrote:
> On Sat, Sep 20 2025, Santhosh Kumar K wrote:
> 
> [...]
>>> This is actually wrong. Tuning is way more generic than that :)
>>> If someone wants to use a chip at a high frequency (50MHz in your case,
>>> but whatever, there is a threshold above which additional care must be
>>> taken), it must go through the calibration step. It does not matter in
>>> which mode you are. Calibration would still be relevant in single SDR
>>> mode.
>>> This 50MHz bothered Mark because it is too Cadence specific. Maybe this
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
>>
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
>>
>> While the need for tuning is dictated by Controller specific
>> characteristics the ops (and state of the chip) required to complete
>> tuning is under the control of spi-mem users (spi-nand/spi-nor).
>> So, it's impossible to achieve tuning without the help of spi-mem users.
>>
>> So, Option 3: Launch from SPI MEM clients
>>                            (mtd/nand/spi or mtd/spi-nor, etc.,)
>>     - Once the spi-mem chip is completely enumerated and best read and
>> write ops are chosen call spi_mem_needs_tuning(read_op, write_op) as
>> a part of .probe()
>>     - If tuning is required, call
>> spi_mem_execute_tuning(read_op, write_op)
>>          - If only read_op is provided, it implies the tuning pattern is
>> pre-flashed to the partition
>>     - On tuning failure, retry by re-running spi_mem_needs_tuning() with
>> the second best set of ops (max throughput - 1)
>>
>> With option 3, spi_mem users are limited to calling
>> spi_mem_needs_tuning() and spi_mem_execute_tuning(). Rest is hidden
>> within the controller drivers. If spi-mem users change read/write ops,
>> the above sequence can be re-issued.
>>
>> The controller can store the read_op and write_op in case of a tuning
>> success and periodically re-run tuning, ensuring we always have valid
>> tuning parameters.
>>
>> One concern with option 3 is that we may not be able to make use of
>> static data on certain flash as tuning patterns (like reading parameter
>> page or SFDP table for tuning instead of controller specific attack
>> patterns).
> 
> Why not? How else would tuning work? Do you expect controllers to first
> flash the tuning pattern and then tune the reads? That is a hard no I
> think, since you don't want to over-write user data and I don't think we
> will ever have any area of memory we can reliably over-write without
> risking that.
> 
> I think we should start with the requirement to have the pattern flashed
> already and figure out how SPI NOR or SPI NAND can discover that
> (perhaps via NVMEM?).

I agree - having the controller overwrite user data is a hard no!

For SPI NAND, a program operation happens in two steps: data is first
copied into the internal cache, and only then written to the flash
during the program-execute phase. This is why the tuning flow writes
the pattern only to the device's internal cache and reads it back it
from there. This avoids touching any user data on the flash and is
already implemented in v2 (which I'll post shortly).

For SPI NOR, we do not have an equivalent "write-to-cache" possible, so
we still require a pre-flashed pattern region. At the moment this is
provided via a dedicated "phypattern" partition, and its offset is
obtained through the of_get_* APIs.

Regarding ways to locate the partition:

1. Using NVMEM:
    a. Exposing the phypattern partition as an NVMEM cell and issuing an
       NVMEM read during tuning does not work reliably, because NVMEM
       ends up calling into the MTD read path and we cannot control which
       read_op variant is used for the read.

    b. Advertising the partition as an NVMEM cell and using NVMEM only
       to fetch the offset is not possible either. NVMEM abstracts the
       private data, including partition offsets, so we can't retrieve
       the offset as well.

2. Using of_get_* APIs:
       Using the standard OF helpers to locate the phypattern partition
       and retrieve its offset is both reliable and straighforward, and
       is the approach currently implemented in v2.

> 
> I think SFDP is quite nice for this, but IIRC for spi-candence-quadspi,
> that was not a viable option due to some reasons. If you can now make it
> work with SFDP, then that would be even better, since we don't have to
> deal with the pain of pre-flashing.

The current tuning flow requires a specific stress pattern to ensure
robustness, and the SFDP data aren't good enough for it.

> 
> Overall, I think option 3 is the most promising. Options 1 and 2 will
> likely add so much overhead they will end up being slower than non-PHY
> reads, since tuning is usually quite expensive.

Thanks,
Santhosh.

> 
>>
>> Please let me know your thoughts on which of these directions makes the
>> most sense.
>>
>> Thanks,
>> Santhosh.
>>
> 


