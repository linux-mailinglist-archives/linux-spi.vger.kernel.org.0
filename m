Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D1D45AA24
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 18:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhKWRhX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 12:37:23 -0500
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:64360
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233491AbhKWRhX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 12:37:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPmJ/oxN+83qIQ6cDL/AfLJOg3614JrCyR9NIVpM4qkPv+rYRMHaexTSwo2cxyz8OztxwlvvXq8xrx2jVpOR2iopx/tgg3/zEHG4WFHDB2u75iSNnUqle5VkLrRsxJ8MI02R/sKM2osPHA7BsD7x/IdThcSZidohPCBV0wsK9FBjaEHVblCtS504bQgDaTw/H8KaXBYo2ODN2eOCxNiSmg4cidMZskYILxyFMvKSzKRKDK6Nxkc2l2y1tOI9mHqkmmOgKHrf6g7EOdzrpiRuQMB6xUXcBcyOh45+4LzKJttOLH78MBz1z8HTquSUzZYh6OoWlhIrDBYQdTRWlzS1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tovCSVVsQcQPUn01Gi2yyZgY6yZk9tF4El1grJ+1WCo=;
 b=bFJ2RtsG2KmX6DNpuJj3zNAiNEsawmruc14XAj+j22cccIVa5rLDHZE35wSX1oA6wEPftG+SspPQnLFlgjPPLW8hZWOkYgaopgq9CKVd4zvQfs8oh7+1FLxzVzOr2/onbnngKXTD5n4MxUM5Qdg7Qf+qqk4cdWvFuq/N6puER/pt7Vt9edqpRASKn8rgYf5qpJDkx6OVCUEW6YzdnijfTqAxlajb0bN0ZFlB4oHSUckP9yOMS393rZ79hpbB9yVKCPA6OaIjMf5H1FBSGZ2Y/uIV3ogw8e/l5leOhG1z6nVRSLuYDm8LjwjMzhAU7xh8NgMaemJ6Ob2yOk/9JHflqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tovCSVVsQcQPUn01Gi2yyZgY6yZk9tF4El1grJ+1WCo=;
 b=PFxFOI322JirlxzTM+PfCcBreOeasZCpUrP8G5J8ptprnyXj0eveCuQ0wR20+15VbsJP3jN28/lPG/6R7JlQIOtasjPmvJsEGb9+auuvCLQfRdBHJ/FtmOOrFaxo12qjA3NyYHYnnSWh62Dj6B1Jugw1rES2PvFJpfRlv5gmKlK0VKEew8QQW61c8cVRRURph0nkqL0ViO1zSqUEP32AbGDK9fKTYeZkkMd5YjXzVzYIzIOjgiA2eABmkN8kyDP6m2ePus6Du3kfdaLM2rPylWX0aaGESdiIgvSY2Yb+OP784/Jfvgdk1Q+EBI1AteILc6KelKrDpsiRkT/I0E+4qg==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW5PR12MB5569.namprd12.prod.outlook.com (2603:10b6:303:196::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 23 Nov 2021 17:34:12 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0%5]) with mapi id 15.20.4713.024; Tue, 23 Nov 2021
 17:34:12 +0000
Subject: Re: [PATCH v3 1/3] spi: Fix condition in the __spi_register_driver()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211123170034.41253-1-andriy.shevchenko@linux.intel.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <051e22b4-49c0-5ef5-709c-015fe3f20cee@nvidia.com>
Date:   Tue, 23 Nov 2021 17:34:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211123170034.41253-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0416.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::7) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
Received: from [IPv6:2a00:23c7:b086:2f00:a59d:1084:4c50:4bee] (2a00:23c7:b086:2f00:a59d:1084:4c50:4bee) by LO4P123CA0416.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18b::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 17:34:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5247edf-e8b5-4b99-2816-08d9aea7769b
X-MS-TrafficTypeDiagnostic: MW5PR12MB5569:
X-Microsoft-Antispam-PRVS: <MW5PR12MB5569D6845E2803F08D73AECDD9609@MW5PR12MB5569.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YKY09ctlIWfanCzYk1VPwtsSHzLHYDYbrzolXn/EkNtWvcAwMro6P/LVCsuTy1C2iHn618KOfcnmLy1uYx6sXD7ZIWL/UZEEG5zpk/CB+INj4kiItPXfRqqBCuRhlmP/1gv4D77eKMH7K6aGVrZ/WKkHCYgFztdGZH9jdD2GTfpM3UdTRXP0+AsUbnE6fgbaQNWtW50os+2C2hSVjEaN0iRELvAAcNTmu0wMI6kx742ZrfkRAH/b1xHA1EQbzjR0qEC5sv1SDq7KUc3QhJbZsHMjMSjGDti9R7wD5NxB25mugezU/Jz8x75OWi2r8pdUORpAbYG+rT6IxgvRrCsQm+lXnENx9qJ1SUi++nESbUkTOOpSlKuuUBOAh+mCJUhh//SAt1GYmYdpilISGcEq2o57alxHvEtMqU1KbP5gQ4vg7VO3rSw0zX9f1niu3Y41ThA0CswaSQS1NI1e5MWqWiDizhWrO81uHTsFRERokCrTm/hVwidFO7sz9Zeaa9gmC8yRdN31nQm+zDIHhe/fKYicR9siRxEk1v2cFwVRMPLCMGoFVVFA6rYFBg16xPC+R/j/HVPTRvJ0bgilJp5i823pmOmnV66zby99dro2+/ZYIwsX17FFiSHyC9nXHArA59eqeKJLe8KfrmIsY5OLiosKsI/f+bqPlwcy+FGG+q8/vvf8MWvnOU6QvZG1/XP6ITMozBGfGvshcDppw2xiGCdIDgBeHyisSLZ0UvhPRDrH64gL8H3qnwQNeTBclBA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8936002)(8676002)(508600001)(2616005)(5660300002)(83380400001)(38100700002)(6666004)(31686004)(6486002)(4326008)(36756003)(53546011)(86362001)(31696002)(66946007)(66476007)(66556008)(316002)(186003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWF1TkNiNTlzQTR3K2pxOFBRMjdINERNVFJrMmwweEpUWG9wVFJjUkpLbFFY?=
 =?utf-8?B?T1B1S0dYZnNTUk1iK3NNdUlmandyQWpNYXpwbDNCaTZXNE8zaTd1WGExc1Nz?=
 =?utf-8?B?SEh4ZUxxdk00bTFzVEdZQ2dmeTAycUs4T3pvTGoxZTZFeVFBM3ljZXNMYVJQ?=
 =?utf-8?B?Qm16dityZVhIVUZ0WlRITmJzWkhJNmlINWtUVkNJaDZhYm1Ta2NtMkJhNHA1?=
 =?utf-8?B?ZGJUbXpkdnNWUDdVRjBHcEJoY3k1U3M5SjJVZHE5NEVRdWtiQ0pVR3J0dHdG?=
 =?utf-8?B?cjkycENkeTRHbjlmbUNzdENoTStUZHdKSTZuTjc2Z093VTRrYjFpOWFVbCtS?=
 =?utf-8?B?ZEw4Qzg0RHg5NXVyTmY2azJoV3AvK3N3d09ReG52eHJEK095MElURXIvNVV6?=
 =?utf-8?B?b2F5NVh2QzhFZVRIc3pUQ0g0SUxEb01HM2VpYi85N1V4UVpZMm9LaC82RWZI?=
 =?utf-8?B?VmRWWWYyVnRHRGcwTWdFb1VUNzFEazlnMUlkM1BDLzhBYXBrQ3pRNUJPL1Vt?=
 =?utf-8?B?TnFrODE5cjB6VC9QVGl2QnIvOFh2dzJnbmhrWnNnamZPVmRjRDZxd3gyY3NN?=
 =?utf-8?B?UVhZNEtjZ3gyVHEvVGVXOGlqY0ZIdmpxb1Q3WWpBWTA1SXVFUERCcWdqODVC?=
 =?utf-8?B?ZEY4Mytkc01NOERiUlpDZzJzd1M4eU1Tem0xVzVLY3dXZm56eVhtdEp2M3Mz?=
 =?utf-8?B?SGpENkVXbVJzR2RyMCtoUUJGemgvNisydTRhOHVlWjg3bVNpQW1EZ25XMGk0?=
 =?utf-8?B?UVdGYnY4czFHRVUzYS9yNkRRVW1YMmEyMkpXL3BUWmhWWlRiNml4amg2aWVE?=
 =?utf-8?B?bWRmSUh2RWhyT2xyOFVkcDJRRjkwQ0FaeHg0K1F0M1NyTHkwWUxDbUhtT09p?=
 =?utf-8?B?S1Y0THYxRHV6V01FZmw2YytWOVQ0VldyR1BWUm9iWFJaeHp6dGxGN0I0K01o?=
 =?utf-8?B?ZkJVVTVvbmc3aFZFMEkxTU51QmsyMHB2NHlYc1c5VUZLMU5wVzJDdTNVRGpS?=
 =?utf-8?B?NHR2U0pHanQvUHpkUGF6RTAyUnlmYlNxYVludG1CVUkySDEwZ0FNSzYzbjVn?=
 =?utf-8?B?NVRwU1pkcEFzTzJ0S2pKOFY3bmtBTnhncjdLQUd0YmtrTnBLUlZsTjNXZ1BW?=
 =?utf-8?B?K1Y0T3oyOWxIMktnNm1ieXFsMEtpWjRPOU5FejI2KzdwM0VwaVhUYzZveGkx?=
 =?utf-8?B?eGozU01HV1l1SnJDQmVzS1JTc1lEM1FXZVRmc1dPQ21oQzFhaUFoUytXc0xZ?=
 =?utf-8?B?ZzlLeDBKSXFET0x4WDVjOExmSGFPUFhnZG93Tk9WVXhXUVR1b1dlbmFUbllG?=
 =?utf-8?B?UmtSSVVUbmpBaEpUdUFzYk9EVi9sYmV5Q1g5K0lCRCtxcmRoZFhKcE12Q2hp?=
 =?utf-8?B?aCtKRHlzNTNjeVA0WVhJUjJOSmZkVUdxcGtRWCtQZ2tRcXA2ckhQcWViaWhy?=
 =?utf-8?B?ZHZUajNEcFNENUhmNEFoZWxoa1FGaU52aSs5dnVHZmkrSmtjSGRnSzVWdzVa?=
 =?utf-8?B?dit2VFNJTTVCZDRWT0traEdkTWRmbzkrN0s5V1p6N0pQcE5oOTdzUGFSQzJI?=
 =?utf-8?B?MVN6MzVUSTB5cit4cEphOUNnb3N6QTQvWFVQY1oyWW1hMzcrY3FtcldCU3Vx?=
 =?utf-8?B?S3hneWpxRU5GQkNPcFJZVVkwYkp6dVRlRzY2Um5TQWNrZmo1djJKUy9LYkh5?=
 =?utf-8?B?ZnZXcUZKd2NRMy9UUGhuMFNiQzR3aUFXWmlKNkZoRXlZdmlJSmZSeW00bjJ1?=
 =?utf-8?B?Wjh2VTJXckRWVmFsQmlvK2hsTVBGYnV6V0R4YTV2WU5pc2JwamdWUzlwMW8r?=
 =?utf-8?B?cktWd2hSRGRjL0JJMlJjVlBuSVg5Z2lBdm5CSHdCelVaYW1jSTFBeE1oWTJT?=
 =?utf-8?Q?QrJzfyhFYwFOp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5247edf-e8b5-4b99-2816-08d9aea7769b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 17:34:12.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Kv6lp0tuML3XZ/dMOtKYLuS9NXiPj2DR4x0F88LLyGpPKFzylIxULbzo75dYwPaaIuUV/sevn9SgrsGSoG8FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5569
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 23/11/2021 17:00, Andy Shevchenko wrote:
> The recent commit 3f07657506df ("spi: deduplicate spi_match_id()
> in __spi_register_driver()") inadvertently inverted a condition
> that provokes a (harmless) warning:
> 
>    WARNING KERN SPI driver mtd_dataflash has no spi_device_id for atmel,at45
> 
> Restore logic to avoid such warning to be issued.
> 
> Fixes: 3f07657506df ("spi: deduplicate spi_match_id() in __spi_register_driver()")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: a fix-patch instead of previously applied one (Jon)
>   drivers/spi/spi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 9d19d9bae253..15688acc952c 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -474,7 +474,7 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
>   				const struct spi_device_id *spi_id;
>   
>   				spi_id = spi_match_id(sdrv->id_table, of_name);
> -				if (!spi_id)
> +				if (spi_id)
>   					continue;
>   			} else {
>   				if (strcmp(sdrv->driver.name, of_name) == 0)
> 


Thanks for the quick fix. Works for me!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
