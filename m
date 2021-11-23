Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A122145A679
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 16:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhKWPZ5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 10:25:57 -0500
Received: from mail-sn1anam02on2084.outbound.protection.outlook.com ([40.107.96.84]:30786
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231337AbhKWPZ4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 10:25:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irrD6HvaGKcicg0oWWcd5XeY/PrKYwT0oUnrqDbFJprhLTacTjEHcGzPGNilct8T8PqmhD8OJ1YfjZKgxnVwmo9L5aTa7uCR80sDAml0myQ1s1jPQu8ri7fclzNIsc3xWdpUZYzbVudKRGcjbE4p8kbXCSNB5HH44ODwTyc9iFKng23BQFDzJk8ay/19KwRD/Q7rw9AZYJOWChcIj/IC/KFslGiWQWf2sAmqPcWOeZ+szTd5xawiHMVDkj7jcAQ8p2V2MafruBieRpu5cxQuUp9hS7JAms7THIiS85vtUpDp0VdV2737fI2BelEhvHYWyaOZL5XLxk2FQYjyceJcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDP60Cmbv3HgqmOxAqfAYg7OOv6LKuimJtlaGbNvqtE=;
 b=iBiXLzc3GHkKS4wEEtb7WV/wujfwMY44DKwIb3uTOziuRWFRBP+UVCYQJ7USv2TsXaHPkts8H0r77v5UFlXHSXz3ucPioSFMrJWCwv81u0ifg1dtbFdxQ6GlBCrxFGJyVM7uDINp3eO9ZNzg5M35sKDPTUeuNsFl8C3Oeanl3r+mQ4Y2Liom287FtxqvBRLL46hfeyS4vDd9or7EqKl8LGbmVBbQarkEXo+C/a/Kaabsm7kiAQu+Kn1/9j/3W7V67fJOIE4FzGen0pqBWPlLMZTIxLShwjyUI1LXwAW9mI3UH/NSSURWTHYouuYE9wZm2X7J3/fhWXpBTm4uRVT90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDP60Cmbv3HgqmOxAqfAYg7OOv6LKuimJtlaGbNvqtE=;
 b=sHbWQSUw9gi84cDv1XFUWu5hZWPs//mifIca7l4xN0cZyKFbPo3Tu5uP1Cu/xxyw27/gbw+p8+vGBhwwcCFly3AhCll4bwp4CMucvCU+cn7ljzalPDRhJu+SgdlqqzVEmiTxAdRumOZvgDa1z3QSV073sediXthIGzoh4YvDby+1Qj3Lh9JrIoWduvAqyjH+rJiSNIXUdaQLwq7BtK6CDIpgF+NNNfUUx3k+yLrJmQpMYu7G9xjL3oHhuwwGUhR+gCpc9f6NzBqort5wAA8p1Vtjs0TOVl1U7JEMut2FwAzoZKgeNZnzJdYmNflybKuKKxU0QPjSyiseN7NLnUHENQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 15:22:46 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0%5]) with mapi id 15.20.4713.024; Tue, 23 Nov 2021
 15:22:46 +0000
Subject: Re: [PATCH v1 1/2] spi: deduplicate spi_match_id() in
 __spi_register_driver()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211119173718.52938-1-andriy.shevchenko@linux.intel.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1572a2ff-dcfb-422f-c4c3-5a454a36d31d@nvidia.com>
Date:   Tue, 23 Nov 2021 15:22:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211119173718.52938-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0359.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::22) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
Received: from [IPv6:2a00:23c7:b086:2f00:a59d:1084:4c50:4bee] (2a00:23c7:b086:2f00:a59d:1084:4c50:4bee) by LO4P123CA0359.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Tue, 23 Nov 2021 15:22:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eea12b4-bee7-4686-2fea-08d9ae951a0f
X-MS-TrafficTypeDiagnostic: CO6PR12MB5459:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5459B4EDC3E09A9140CDCFCDD9609@CO6PR12MB5459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9ahtkDXxe2F+EFDPRB/ouy/CJ8pTzwCU6Gnr9JHbtlEf5hRRnp9JvY3B3I1xWGYXCmi/p97Uax6/PRQ3Vw2sZEc8rXkJB/GIz54xzjLleuTNtIDiw0tXQQDkDo3G/ViDFpoQH+OQneP6hQ9nwEQF7U87GXTDuntSbyQ53mEhEeVS49H/XGFLFh/FU6+MEpyTrQ88Fv3CCrbJmAxPOmF2JpFC4nwx2Lz49ta+4rZQ+ByenOJuwYW2MFeV2LbRoXylXYFlXG0ZOQreAomTXXft1yVl32M6ofQM+EArVr0YQig9Sztp/jHeDCujjbidK0rUQKqz0YPH8wDZTfW6YBZnkRTDtRe+VVMOETAni+DjohYS9geKwrkpSsg0kLM0xhIq/NKTR6xhw7AMQr6GGEL0a++kD8WUGtV0+Fre282Pa6/OfNqlPEs25HuNNZXWb0G8VRqCAP9YdsxklSQRwKDqY2IvgU+NvI2XwpDb7lRuGOeMY3y0eQuTEWnD9d5UP3Z6R31sq5GOBt6Q+dDjBf0NunsbTy20HNku3GQtxWq5EvKrKMJHqzWegjykheEZYw3+MhCkvOrCLMXGQswO5OYSdrwYj7/lfDi5YKVlnGqFwpeLmEwl/JlYisw/0H0o/yxsaaG+K7oUn3G2xhT4rCXZ359F0s8+SBwAnnC7BhMl0r/9S53uWFW5mQcWagzyCXFg/NOfqQZBU9Pk4YZhLAX6gQUu+3KPsETYYcTSKdnCzXL/vnLyOz8rs0O/QpSnZtxJG0h153/Wqm/zeVUj76IeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(36756003)(53546011)(2616005)(5660300002)(508600001)(83380400001)(8936002)(38100700002)(110136005)(6666004)(66556008)(86362001)(186003)(6486002)(2906002)(8676002)(66476007)(4326008)(66946007)(316002)(31686004)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2NyQ0RjZUFjM0NtVzF5cWRRRkEwV2ZpeUNVaDdiQTRqRStUUVRFQUpyL09K?=
 =?utf-8?B?aHJ1b21lZm9DRXY0V3JYQ3pDckFkbHdCbGNCWEhtRlpJUFhuemRYTGJyK2dP?=
 =?utf-8?B?M0txaGdyQlFwREZDemcwUm9BS1E1OXNSRG1xclJSUDFWTG9yM1lHU1oyTE9C?=
 =?utf-8?B?eUVSK09aN0pya1MrZHJ0dUJDSXowRjJNR1lEZDdOaFhXWTlHOXZQa1NnR1By?=
 =?utf-8?B?YlNxVVIxOStNMjIxV3lQWXRxTStQN0IvWEU0c0o5TWl0azZGRHRiSU9jdXVX?=
 =?utf-8?B?UmtDNXRwRmt5bVV2TllFT1ZNU0dtdlpQTSswQkg1ZXBlRGNmbm5iUmRJeTZo?=
 =?utf-8?B?dTdJVGo5YnRBYWwrNmFoaC9CUFJlUG04T25kR0VXNVZnTFNTYnR0L3J5Qmdu?=
 =?utf-8?B?aXhTQWVXUjRKVUhzaHh0QXN5STFuOUdWVmMrVzNnaldUQldRNldSR3VUSTRH?=
 =?utf-8?B?YUZFTGkzbTB3bUVld0lwK0gyS0UvcnRGZEM5MXIzMVRrb1RzV1FpM2M1RUxl?=
 =?utf-8?B?QUZ3VllNdXh4QUgwb1BobUlEcmZLZFFtMDcxOEhRWFpLOHZ3UU84WTh0Zy9l?=
 =?utf-8?B?UE5pcCsyQkFUcGk2RjhUR0FZak9ZSHQ4eWxEUFk3ZkJOSEVGQU00bnJVNEZY?=
 =?utf-8?B?VEJlMFRXRDBrSW0vbEdScDBOU09xc2ZCc2VLeXpYSzF5cmlZdEZBUzNCUnZN?=
 =?utf-8?B?TTBFMkM0MGpsRUpSU1FFV2Y3NkxqcEtNRFZIbWZ0NDlPd2tJbzRjVmI4Q01i?=
 =?utf-8?B?TmIvdHJwUmdTRjZSZEgzaTZ1WWpzdExFL3g4dU9Zek55Ulc5MXRGUW5zN04r?=
 =?utf-8?B?TXR5YVFrVkk2d053WXg3RXp1NzFUYzBvampuVEIxRmNsbnBwUVc2VEpDbWVw?=
 =?utf-8?B?MTViM0g1TWEyTXZSV3Y1R1YyOVRqZ2c4UElBZGdKRDlHSHlyNGdNNC9TOXBl?=
 =?utf-8?B?U0x1dEVGT1RoWm9qUlRuY0NsVVh3cnZxR1Jxc2h3V1p6ekdSbDJ6U2srR3FG?=
 =?utf-8?B?d2ZLM1JZekNTV2c4MFB5cUR4MHdiRjROOG16UDhuaFk3aGZJVTN2b0N2aWZO?=
 =?utf-8?B?L0NTcmhhZVhhSklxNlREazNRYXM1aE5kVVlSOVBneTB4cUQ2RVk3dVQ1UTl5?=
 =?utf-8?B?ZHRlcXV0QTltTC9hY3Rva2o4MFpPQm1ZL2pON3VBY0VMdVNwcUdDOWYxSGpH?=
 =?utf-8?B?NWIxdWh6UXBWdjc5NUl1NzZBRDVFRTR2VDFMWGRYcmlIMHdkQ2FYSmtBTm10?=
 =?utf-8?B?dCtoUTZFOVRpVGZqRGZEYkdqcXhrMXpIYWRJUTIzWGZ5R3Z0elZ1VnRlcXNv?=
 =?utf-8?B?ZUxQc1FDUUxvSUNpTC9PUUc0KzJBam90SUF2b2p6NkNOYktHWXhzOHZaaEZN?=
 =?utf-8?B?dGdhOXY0SUYwT05yYWx0Q2daeDNvUW9pc2hFRHJjZ05WNGxteXVIdUN5WFpJ?=
 =?utf-8?B?TWt5NkFsRWxTTWJjZ3dldTluMmUrZldFRnJiMEJnMEpjM3FFRHBWZnJBOEQ0?=
 =?utf-8?B?NEpDRFFNalVVaFVkbjQrU1BMWFdDSlQ1SlNDejNvaDQvTGFwOWcycmFOZnlO?=
 =?utf-8?B?Z2toS1k3QTEzWTl4NDJ0WCsyUFRaL1dqYXhvVlRDQkc4S0IyaUNjRTBuQ3R4?=
 =?utf-8?B?T0FvVUFETEx6Y2pjVEhiZzNTN1kwT2RQdkJGOFJraTV1UThjd21FRmUyNjdq?=
 =?utf-8?B?SW9USEN4RWxFZTA4dDkxWk9SblZySEdobEwwWDFRU1dWWXFZMVZibEFlVE9h?=
 =?utf-8?B?TWxobHVCNjVGdzdSUitrUWU4Slo2SWRVZFJmTmRLTkl1cEp1OTFHR1pVZzlE?=
 =?utf-8?B?NmIwS3B4UnFtUjhTWXFzODQrK3BXV3FrWjREWEFvVCtyRlF3S1U1angrUW1h?=
 =?utf-8?B?R0k1TWExYzU1YjBXN1FsTm9nallrSjl3cmNic3ZlOEJTL1VKajNXZ21yWHYx?=
 =?utf-8?B?dkw0U0V2dVJ2VGJiUFBYcHJMWHM2SFdYQTNaK1RDbjZlWlhxeDEvTlg2bmdS?=
 =?utf-8?B?c1ljcUJaRjV5RkRTZ3Q1MGllalJCTzFLYjVNNXVLY09rZWJwOHBvWW5VaTdI?=
 =?utf-8?B?NkUyMFVzcitzTGRoMEgvdTZjNGFWcmNMR2xxUkppb3RmNS9keHE4c29hRjB1?=
 =?utf-8?B?elJCMHFMOXZQZ1I2blNpUVlEeWhEbE9TMXFxK055MlJNZ3hJR0xDbnBseS9n?=
 =?utf-8?B?cUtlWnRpdlUwT1lsVkloTVFNMGZIY3B4OU1HMzN4SXZrR2Rnb01WVEFhSWND?=
 =?utf-8?Q?OIiVzHuHQTtbq+0mN3Wc3tuENXyaShu1Bn200OugIM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eea12b4-bee7-4686-2fea-08d9ae951a0f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 15:22:46.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c0l3Q9z2j5DfExcKIrvnRKQrznV7mzfgEEHyxTVPhlVzy1HmermDeIJ9OvL0ZXVaTCl+yiwE8evy1Vj0WoPOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy,

On 19/11/2021 17:37, Andy Shevchenko wrote:
> The same logic is used in spi_match_id() and in the __spi_register_driver().
> By switching the former from taking struct spi_device * to const char * as
> the second parameter we may deduplicate the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/spi/spi.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index b23e675953e1..dfa06103150e 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -315,11 +315,10 @@ static void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
>    * and the sysfs version makes coldplug work too.
>    */
>   
> -static const struct spi_device_id *spi_match_id(const struct spi_device_id *id,
> -						const struct spi_device *sdev)
> +static const struct spi_device_id *spi_match_id(const struct spi_device_id *id, const char *name)
>   {
>   	while (id->name[0]) {
> -		if (!strcmp(sdev->modalias, id->name))
> +		if (!strcmp(name, id->name))
>   			return id;
>   		id++;
>   	}
> @@ -330,7 +329,7 @@ const struct spi_device_id *spi_get_device_id(const struct spi_device *sdev)
>   {
>   	const struct spi_driver *sdrv = to_spi_driver(sdev->dev.driver);
>   
> -	return spi_match_id(sdrv->id_table, sdev);
> +	return spi_match_id(sdrv->id_table, sdev->modalias);
>   }
>   EXPORT_SYMBOL_GPL(spi_get_device_id);
>   
> @@ -352,7 +351,7 @@ static int spi_match_device(struct device *dev, struct device_driver *drv)
>   		return 1;
>   
>   	if (sdrv->id_table)
> -		return !!spi_match_id(sdrv->id_table, spi);
> +		return !!spi_match_id(sdrv->id_table, spi->modalias);
>   
>   	return strcmp(spi->modalias, drv->name) == 0;
>   }
> @@ -474,12 +473,8 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
>   			if (sdrv->id_table) {
>   				const struct spi_device_id *spi_id;
>   
> -				for (spi_id = sdrv->id_table; spi_id->name[0];
> -				     spi_id++)
> -					if (strcmp(spi_id->name, of_name) == 0)
> -						break;
> -
> -				if (spi_id->name[0])
> +				spi_id = spi_match_id(sdrv->id_table, of_name);
> +				if (!spi_id)
>   					continue;
>   			} else {
>   				if (strcmp(sdrv->driver.name, of_name) == 0)
> 


Following this change I am seeing the following warnings again although 
most of these have now been fixed ...

  WARNING KERN SPI driver mtd_dataflash has no spi_device_id for atmel,at45
  WARNING KERN SPI driver mtd_dataflash has no spi_device_id for 
atmel,dataflash
  WARNING KERN SPI driver spi-nor has no spi_device_id for jedec,spi-nor
  WARNING KERN SPI driver mmc_spi has no spi_device_id for mmc-spi-slot
  WARNING KERN SPI driver cros-ec-spi has no spi_device_id for 
google,cros-ec-spi

I have not looked any further yet, but this appears to cause the SPI ID 
match to fail.

Cheers
Jon

-- 
nvpublic
