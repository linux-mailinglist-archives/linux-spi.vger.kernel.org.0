Return-Path: <linux-spi+bounces-11869-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44618CB7DE0
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 05:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDA663027A42
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 04:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB75B26FA6E;
	Fri, 12 Dec 2025 04:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gTZjVYEA"
X-Original-To: linux-spi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C063264F9C;
	Fri, 12 Dec 2025 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765514101; cv=fail; b=cXmnxkhpU8ykWxMEMMLmnHZtpEZ40+zEU/X3NPrfqdUNQ+8U/XeahNn5/JQD6QqYalCSDVlwghGj+Px7OoifDhRDH4/FXBBqBmgcMqAVs/kcqi++BxgLvzk9XYW+a9tipjTmmfZI55rxopqz7G4nOzWEvFXHdsBkzuX+LzH1qdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765514101; c=relaxed/simple;
	bh=gv1lrAL7xozzI3C/gyZX0/EFkrsbhs/7JV0eJ3VJPfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GgHZh495wU0OvBHJ+G3yFSkL5hN8WLfUthIP90+3k2EauxGBZMkxboI+kg9ULB6bQM5mgYnlFK7WVYxxmicsU4o7j3BS3wXow8jmx94Vb+G2YOQnLrNloX7pCeLwEHpVDs9pIMn3jUfQZZ+ycFKAuBQvIdoD3WDHxqfZNKtgyk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gTZjVYEA; arc=fail smtp.client-ip=52.101.46.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEhYncWJqoh7naRsYvnTpGLrRoBlLA6f5j+2oLGqkVs6826XdizqRwuT7XWr00TThlkepl7BNmqC30/PUaC1G0CFV7AoiRDDPVb8DUznd66MjZm0XKLYJVeIjunQY1hU2+MVWr6GtDOq2qb3e3w5/m47smZ0p48XEtJlvkXNw/xMWSDlRZ27l6bjuwleY0B9P5S5/e/xSugRLBYaQ0n/Iz7B10VStE7DORtneM8FOxcvDNz2x7fa1hSxd8Cw5r53C+VHkyGMaMHbIpaMVzF6t0Gx777qhx5nmrX0DTf9sJDECzJKIbd9K7Z9e3fBDaSrFK5/5mnM6PzSjBj9rCMezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPYy/rRk4r+FGANBpiKCe3xm+Wf0SdQRw1WG/15JeKQ=;
 b=rzgttcPJ2JLk9b5OaZ4Xm1G+5F9K7siDggNK1cO6vQmHl6rZDXHwwjxz0KAKxOadSalOfXjUShFFnnuLr7fTTIzyjUSYgcLkxvDc5p7ve1yhtK9RCVuNW4mihLSV0lnIM5mCsGI+QSZy3wmdNc3AwDbnQ/awKf65b/9ebsXCIRnNsduADuaf68E3szqkOiGfo1LMwifYS4kLxdwIKvhkvp4GP4YmrjrPPwoyveSddB22jI3C0QxwCysoDmxCrS8rjBC0yyWvLXAY8WiJEqaV1SCEfmxCUx4HTrFqCaE8bmI1r+APShwdC7Y3835qcJF0KYhYilKt5SQ4es0Yomj9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPYy/rRk4r+FGANBpiKCe3xm+Wf0SdQRw1WG/15JeKQ=;
 b=gTZjVYEAGPmop2AOjXtuGaGtUksRbOIuEBP8GimLGoalqUYb0vsClqtf8zbCvY5uepFlQkqqPh6PjDphr7d7Rje2HHfgGL0+UUZqLy3PO8kX8ebQ+oMlR2IU5jst4nXJM6qpX8W96ShkrFtmaUuspY4TVOzRuKkcg0EV+Sc1Ocs=
Received: from MN0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:208:52d::10)
 by SJ0PR10MB5663.namprd10.prod.outlook.com (2603:10b6:a03:3db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 04:34:56 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::95) by MN0PR04CA0017.outlook.office365.com
 (2603:10b6:208:52d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.10 via Frontend Transport; Fri,
 12 Dec 2025 04:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Fri, 12 Dec 2025 04:34:54 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 22:34:51 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 22:34:51 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Dec 2025 22:34:51 -0600
Received: from [172.24.21.18] (ltpw0bk3wf.dhcp.ti.com [172.24.21.18])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BC4YmPi1630956;
	Thu, 11 Dec 2025 22:34:48 -0600
Message-ID: <1542ee8a-620b-4349-92fb-ab1f6c5b5eab@ti.com>
Date: Fri, 12 Dec 2025 10:04:47 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
To: Mark Brown <broonie@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Gujulan Elango,
 Hari Prasath" <gehariprasath@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
 <aTFQv157O-wJjVrZ@gaggiata.pivistrello.it>
 <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
 <20251204140530.xax5didvuc7auzcd@problem>
 <4d6b857e-4bfe-45ef-a428-6e92f218f0c5@sirena.org.uk>
 <2fcf5235-cc94-4202-9164-4889356c5264@sirena.org.uk>
 <cd95320b-6852-476e-bc8a-2e8d1ac77a9e@ti.com>
 <f804d7a7-4ffb-4d2a-bbaf-ca0a076a11ab@sirena.org.uk>
 <5525272e-7220-4352-bb08-ac66631108e0@ti.com>
 <cf8e7003-ebca-4817-8350-f29332d75fab@ti.com> <aTf6RRAveRdVnWQZ@sirena.co.uk>
Content-Language: en-US
From: "Dutta, Anurag" <a-dutta@ti.com>
In-Reply-To: <aTf6RRAveRdVnWQZ@sirena.co.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|SJ0PR10MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d073ed4-ef9b-46d5-01e4-08de3937cc44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVZtWGFTVU1RYjhON0hKcHFFVDNYOHArMEt6VjdpbjIwalNWZi9PdGs3VHBw?=
 =?utf-8?B?RkdNSlM2NWZTZjU4UmpwVmxER2VMTk96ZUk1Vm90a1N5TTFoSHBER0Jia2VL?=
 =?utf-8?B?Qjc0UHdETXkrMVdsaDB6NU5VTW5zbS8xRmNaeThjYTk5UWxsczJ3d3BQMEpI?=
 =?utf-8?B?TUdiaDI3YklLUnFkV3lTWXVuUzVyTERpNTFEcDZzeW1xb2xNS0lhb25yTktY?=
 =?utf-8?B?blY5ZmJ2QTVEQXVrb1ppS1htR2w1WmRxMEQvbUc1R1dFOTBYNEdZVFdYeVAy?=
 =?utf-8?B?QUk1ZUorYWk4d1VBR3BSQXk3UTE1b29zVHZEQ0sySVBUNHdLdFhMclRvOEJI?=
 =?utf-8?B?Q1o5ZTVoemJqWENEMHBud3IwZS9zVWdHRUxJVlV5cDd1WmlHMFg1SnhKdHds?=
 =?utf-8?B?dnZ5SHN6UXpVUVZUaHovNVZLRnY2c3dDNlE5dGsweDZZbTJMbk56QVRPRHQv?=
 =?utf-8?B?SEhmVHc5YkFYNGM3alliSG1PR3Z6dXRIaFM1VStZQ296cWsvUU8xZEdFcytp?=
 =?utf-8?B?VTllVFBzOGF4SzJncWlLWUNqQ0NZVDVCYVRjQ092MzFCejVYOU51Uy82QXAy?=
 =?utf-8?B?SEcyT0pTS0NFSEZzMzdXRzRYNVc0TndtT2JzdDM1cmZUaldtK0VGUXdaLzFt?=
 =?utf-8?B?ZUdybTAxck9DWWlnWjh6RFBSVFNzNHh5REwvTDRZTEdKYUNvN2hKTTlCTDZE?=
 =?utf-8?B?ZUUxRW92WmdNMTVMVDJMdUFhb2U1bTlGek8yNE5jVkl3cFdja1dMSnlyZlRZ?=
 =?utf-8?B?b2RZSmNlL0QzeHNpaG0yay85UDdCTm1XU2tnOXJ3MlFLazRHaTYrOHZJUUsx?=
 =?utf-8?B?WXpPOVhTaFdZaDFkaUtJLzV4QlFvaWloMUNPVy8vSVlqd29xSExEU1kwS2g1?=
 =?utf-8?B?ZW9LY1RtcHFmV2JyZm5udmZCSnZsOXg1WXV2OHlOTGhTUVNNaHJJMjdCcGl0?=
 =?utf-8?B?UnhuUXc3TlJPNi9NRUZvQzNvZ0szVGd5RW9IaWJsdkdJNGRnekN3OXhUSGVK?=
 =?utf-8?B?UGFqOWVLVFo1TzY5VjZxRFd4a2o1L0lQQysyWENOa1ZrbUZEUVJwdisraFor?=
 =?utf-8?B?c3k5T3RZbWVwQjlLdVJiUHZ6M2g1REZhMlp3eTdYem1NZmZBK2NPcStIeFRD?=
 =?utf-8?B?UVoyeko4Ykd3QmpHbC85OXZ3N0ZHdk9RVTllRWdEbk1Za3VQZ3hqUjIvS1BC?=
 =?utf-8?B?cTAvNlRZdGhkeWhpNE1mQzhMRitlbUxZaE82N0xlT2tLcCsrZjE0ZmE3VTRi?=
 =?utf-8?B?WDk3NTVVb0hCWWNTQjUzelZ2c1hZQ29hcTFjWjZlMlVNQlFQUFRHbkRaaUl6?=
 =?utf-8?B?Qy9QWjluTW04RnUyaUx1QVZIRGlwOWlNL0ZaM05kSktZQWtZMW8wRDVsQXVo?=
 =?utf-8?B?RmtVeHQxTW05QVNJKzIyU0JnbTZZaS9vTnl1cVlhUzlWaFJYbkl4RU1seHdr?=
 =?utf-8?B?REh5cEVpQjVzRCtnelpLbkhUU2N1UmJJTUxVUnFjSUR5ZjhSTUM1UStLREdO?=
 =?utf-8?B?alpJai8ycWRCYXJValM5Y1JRUmFPTTY2MGozK2duTDZveTBhU2FJMUwxUDdH?=
 =?utf-8?B?MlpsUXpJYlcxVGJPM0lFWWIwcTNjUUU2NENUTU9RYzRNNWx6amlQRGJWV004?=
 =?utf-8?B?am1vbW1BSS9DQnpHODFGaWx0UGdFOThrZisvZ21XRU9qR04xZ0tnaHV3djU1?=
 =?utf-8?B?ckV2YzdPU24zVkg5dVhuZ0V3MDVJUXZBK0pCSXUzbGl0eW54MmxHd1JPQk1s?=
 =?utf-8?B?YzhlTXc4VDExSTFCNmxkMEtCNjNjclQvODVIN05kZDRnWFdBWG54aTN2WUdy?=
 =?utf-8?B?NllCK0dyUmdkd2hiRGV0WDNQNnFoZXV1NW45b1o3K2RtdSthMk1PaTUzaXVG?=
 =?utf-8?B?SG1LRFBlc3lRRlo2UXFMVENYNHQ0eDlzaGdnS3pmTW9xMVZNQ1dTZ0VlL3RE?=
 =?utf-8?B?QnVZaTJmNmhLOTY2a3E2QWl1T0J1d2VNOFYwSTNNZG9EaGsrMHRPejU1WTZu?=
 =?utf-8?B?czRoMXZUekl6bUpvUkZlc3A3N0V6MFZ1MTFkSVdyOFovdzBHZ1NWbjZFcC9h?=
 =?utf-8?B?V2VZdlBkRlo4eEdhKzVjUURrd3I1OUJuL0VvU1ltQXdYSGtpVVA3ekk3R0sx?=
 =?utf-8?Q?5usE=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 04:34:54.5013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d073ed4-ef9b-46d5-01e4-08de3937cc44
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5663


On 09-12-2025 16:00, Mark Brown wrote:
> On Tue, Dec 09, 2025 at 03:22:43PM +0530, Dutta, Anurag wrote:
>> On 09-12-2025 11:13, Dutta, Anurag wrote:
>> Another solution :
>> diff --git a/drivers/spi/spi-cadence-quadspi.c
>> b/drivers/spi/spi-cadence-quadspi.c
>> index af6d050da1c8..4d298b945f09 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -2024,7 +2024,11 @@ static int cqspi_probe(struct platform_device *pdev)
>>   probe_reset_failed:
>>          if (cqspi->is_jh7110)
>>                  cqspi_jh7110_disable_clk(pdev, cqspi);
>> -       clk_disable_unprepare(cqspi->clk);
>> +
>> +       if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
>> +               if (pm_runtime_get_sync(&pdev->dev) >= 0)
>> +                       clk_disable_unprepare(cqspi->clk);
>> +       }
>> pm_runtime_get_sync() will increment the usage count thereby preventing from
>> runtime_suspend()
>> getting invoked, thereby preventing double clock_disable()
>>
>> This will work for !CONFIG_PM as well because pm_runtime_get_sync() will
>> return 1 then.
>> and the runtime_suspend() is never going to be invoked.
> I think we want this, possibly using pm_runtime_force_resume() instead
> (not 100% sure on that one, glancing at the documentation there might be
> issues though it feels like the intent of what we're doing here).  Can
> you send a patch please?

> Hi Mark
> If we use pm_runtime_force_resume(), then for CONFIG_PM_SLEEP, it will work.
> But, in case of !CONFIG_PM_SLEEP, pm_runtime_force_resume() returns -ENXIO,
> because of which :
>
> if (pm_runtime_get_sync(&pdev->dev) >= 0)
>
> will be become false and clk_disable_unprepare() will never be invoked,
> which might be an issue.
>
> Let me send a patch with pm_runtime_get_sync(). If changes are required,
> please let me know.
>
> Regards
> Anurag

