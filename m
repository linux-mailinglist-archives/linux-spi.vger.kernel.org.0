Return-Path: <linux-spi+bounces-1714-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429A875F51
	for <lists+linux-spi@lfdr.de>; Fri,  8 Mar 2024 09:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398C81F213EC
	for <lists+linux-spi@lfdr.de>; Fri,  8 Mar 2024 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CCE51C28;
	Fri,  8 Mar 2024 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HOb+O/mg"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA22B9CD;
	Fri,  8 Mar 2024 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886100; cv=fail; b=L+nUoJfqh+lDwARb9FqxPKvF3juZfAOYc3W7b6IESbm1pXgKKg3gvRvKqbdGg7K08Lnt7jPf1omwgCx9OWKKePD4KvEHo0LPj0bfVk6t6X/W//7hnj3ZXuRF/jeQ4gku5f4Ql/Y+j/yHEt1E9SSZu/8KSoalc7cayK5G6/GeQsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886100; c=relaxed/simple;
	bh=5vDFPUPHeyrA5q+hFT7e5evtMEMsPVhZg8ZKLFz+3Qo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fC2NVl3wMEvF71oWB907i3AGtv3KBrvGnWzwg5Y6QnJv0GIMisF8uRoS+aUp07xAZ46++i+tRr3WayHOROKFMFHrEBA/Wjja06Wds+O2q0thfnm7dV0PJ+PuNCRltlFNODy+wCvRtKMWtWlNRtZc7EvgF2OwQ1EMCdd8HZkAAqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HOb+O/mg; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brQi3SoDNTfZ9eZ6+VmnYOH8zbFH2OZQmxjWlDuZIv6ItWgtsRh4Wq3FE345twbSNJ/fNegbnFjPAhnY1DG2sVab7epLVqft2ZfV4uHFtngNEAeyp1j1GE9ehPc/2tYCGbieowWjVuIrMwScvjZ4UyP+tpADw3TQcBYSLg0lJ9Hyv7LDIpcwGTq7RLJhD1goH8offd0wkNh9JdY87AF067nXjeYztWGVfW7b9ZupJ1kir6WC+L4Tyr3yEil/N2NUsLzeGoe7tbKPAXSyBhIPrqKEIeV6PuyMgdmtGsb/3vUEwG2lsHM89BLXODc5urTQGF2e0R+M16KcMDwAMgK2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2oCttYWCibs3RQ/zhXjTdPvP5tSRfTyAxw39CZMI48=;
 b=b4FqpoIpMl6TeEAHRVMmbMuTegxTxb2e/mJ7InbB81NNX52HSLeUGfkWKKLNonZFKV65PLXVJyu0zFrN/2vVeAVTKzr7aXO9iCadEwskEOxPvd848uFGqUzug8204n5aAE5DilLH52Iu2wZX5TS/Bktz2DfytLRpaBYjBY7mXDvyBmyDdV9gP37lF1UhmEgVzWYpMvi3KCPLJML0Jgqirc9+UUgH/vBUOOW1sdR4C41tviT87UkF6YH/muOtnqGdYgASOHStBwebgAaPykD7WaIkIONET19ZQBKNJQRw9sTwLdWT9WbC0aN3lEvPWjrO6EgNd9So2BV5dyrr4Kz4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2oCttYWCibs3RQ/zhXjTdPvP5tSRfTyAxw39CZMI48=;
 b=HOb+O/mgRWhkJ1i8qFbXn+rMt6jZMAyfuo7p/25EHvbL8QxjRewp2tc8pydEswU8oNMFQF1j5TaamaOasatl02kY/K4f3+gneay8iBOn4JqN88bkgGBJZFZUFBnEuq2PHbC1EUO65x6OHPoxUKUb5yglA+GBMPTZIqZntPp98R8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 08:21:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 08:21:36 +0000
Message-ID: <a3aca544-dc6b-4812-b82e-dd1f9cc04871@amd.com>
Date: Fri, 8 Mar 2024 09:21:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] spi: xilinx: Add necessary inclusion and forward
 declaration
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
 <20240307154510.3795380-3-andriy.shevchenko@linux.intel.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240307154510.3795380-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0184.eurprd09.prod.outlook.com
 (2603:10a6:800:120::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: becc06c8-a924-4f39-0e5d-08dc3f48c5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JrQKbB7NZ5eFiONtYVGCkzXFJHe45OUyTigJu1zBMYQBkW+6kniDtLZ2zhWzyLyTJx1uPj+ZJbgVHGfbnrp+9AoJnLrv5DrkfWN4j1twq1LG+pqCk4uuWJkTZaxlrPoqp/1sS70h7I48Y+syxSOV51UB42MY0xFw4ViwxGl3Xs35UDbD0+y62W3ztgjnYtNSX0wOYWRdLe41qIX/uE2lRefizracXRzsWDq692x9QPpnjvxw+VVfbj3bbg5ZCD05xO1oIBssZpaShIOXrR6d350Qqtwkq14NgrKVa88/snuv1twZztr/6fxVh2FP+oyGtXaZUquaAHssgoMxI+eH0ShpolrnwJLLPGa+3rFK6rPJmlH3IWCPvHXE/g2hixxnNIfIclKEhL7G2EpEi37QuRfN5RUq+NU3pZo70VHyAorssEA1Z2RNeg464n3qXCGzQlZoZJakM9yCnsKck71mQ5kQwkw5oHRMwJWKopheh4qRq8IaCt6VP/p0qeWuyYfTEcvkzs9FIIC1MsgLwr+6dW1ea3FzdlHkAYEfOU/l1NRHcweSVC6xaDDJ1R2cFFQxxietQOOIYcalgVPmpVgjVfMKTH0WQPvnrxiqKUA/16hnXlejo0MED6Oe3lBDww6Cgd5eHf8rySUXp8mfTEhA3PTMta7mgARR//HFkZNyt1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHNmOXhCbWdjbThneGRLUGRncjk5cFVsa1pPaTNxbHlha0podWRxUUt6bWUz?=
 =?utf-8?B?V3NnMWUyOEJvUDhoNGlxTGYzQ0E4TDNwNERDTTBsNGpWendxMStscWkyVGt1?=
 =?utf-8?B?Z0N1V2NXNy90ditTeUZmWkVYMElWaWRWcTA0K28walRHMEUvZlhCclJqTjhz?=
 =?utf-8?B?OFh2Tm1xcGp6OWNFQ055cE1GMlNvVW1XWUhsV0RaT2ZsSGpRWlhRWUVLaW45?=
 =?utf-8?B?N09nSDNxQXluZGdzZGFpbzlJemFwSWJlSmJmelc3Z2E5YXljUVF4ckdvUDFi?=
 =?utf-8?B?TVVuRnIrUDNUM1FmcGxtTUgxRTBIK25Cckw1aWpuUGZBdmYyVDJrTGdHS2xw?=
 =?utf-8?B?NWVOTUFpS3hBaW5lRTBSSy8vbm5KdWdLOERjNFpkMmpOL0RvZUtxWUl1V21D?=
 =?utf-8?B?YjVRb2VLL3BiY1duUVRnQk5PenZkeVBPVFZFOG0yZUg2VmpIZklZVjVHVW1R?=
 =?utf-8?B?dHVCdnVIdnFIQmM3bUNCK0lzNFM2emxrNnBFMStqd2pXd2JPc1NWQXVINTd2?=
 =?utf-8?B?SzRYak9OTFV6SExnMG82cytQMjVqbXRSNlNGVlcyNXJkRkhrTjlLb2dMeXA3?=
 =?utf-8?B?WU03by9WMGsvdllPYmt4eG9yT3lTT0FEVTFEWER6NWR5Ukl0R1Nra1ROUkxz?=
 =?utf-8?B?aUt2d2w3dWVjMWhUNi8rUndJcU94TVZ0dDJXQS9wNE83QWt6YWZWazhVbGNL?=
 =?utf-8?B?dmNVbW1mNlBJM1VpMzlobEUrMjl0azBiSmQvVHN4UFozUmM3Y0Vlajg0WWk4?=
 =?utf-8?B?M2FpQTNsZTFXdWIzL0wxalVrbWZkWjduSnN2ek9BRDNKUzcvMmtZYXlpMnlu?=
 =?utf-8?B?M3Uxbmw3SmhYUVdxcUI3WjZxZjh0Mmd6QW5qdm9CSmZ5MzdsZ2REdjUveXlN?=
 =?utf-8?B?T2h4endDbjBFYm9xYjlSVXgwVnNVRzV1d2E5SDc2SFNxMnIyMmZ3Y3RUNUZZ?=
 =?utf-8?B?aVJVT0IxMWlia3EyN29Tb1BEQkVvS2hCcnY1dWswQkxpVlFiZVVSQ0dCRmtn?=
 =?utf-8?B?TlFDSXVOZnJuNG9yeG5Eem9UVG5WcVBmbTlVa0dPQ1lsa1d3U0NVbmQvK3VJ?=
 =?utf-8?B?NlAzS3hyY0hON3ZCeHdTV3F6SHRUNS9HT0pEQXFmYUI4TDBlSDA2TGJZeEdu?=
 =?utf-8?B?Q1NUeVd1V2EyYmdONEVtRm9KQllGQjRCdjhWOVRzV1djNVBlY3ZIeEJOQXBq?=
 =?utf-8?B?OWxxZDJCbkFrV2xPU3crMUw0M2dsRzRxZklvWDUxQm5XazJCVEFJS0FHUUg0?=
 =?utf-8?B?ZVJ5bXpreUxBVlJuVzlZZlNpNmk1N05WRTk4dlBZWHBEbmpHSURveGR5UWFa?=
 =?utf-8?B?SmRBNXFUSGVSWWIrWFpmM2FQYmo2WFFSQXd4VTNWak5LMkl2V1Bkc0FZcTVR?=
 =?utf-8?B?ckV6NjFLazJma256U3RlNUNXK0NWZExZSDBRMC9nTlhHM0ZIUmV6ckdrTDBR?=
 =?utf-8?B?UjNsSGxybk1WUExMaHhXUG5IdUFmNDhFQ1ZObldYbTR2VTN0VW92eno1Tjc4?=
 =?utf-8?B?eVZlekVjSXA2YjA3SHRhYTRrMlF2bG5NWURzQUVjdmdmUzlVbzBBbWVQQTRP?=
 =?utf-8?B?Wm9aVVBCUmlOcFRFcjBjRDZ0c2pLa2tTcWpGNFNYdFF4K05aNVgwTFhpVUoz?=
 =?utf-8?B?VEhzQlhZbEZ3VEk1Q3UwM2Z2R1RXd2kxQ3hQazhLTS9SRmwreXpQbFJzWE96?=
 =?utf-8?B?Y0RiZVNoVzVlZXhLSk9iZVM5Rk4zRndLOVBzazJLZTVJQ005cWE5bzBqVWl0?=
 =?utf-8?B?L3NYOHlYK01DWWhqYWtrL0dtUWVTY2pySkZudWpvc2NTNzZiUWtyUDFUQ1dD?=
 =?utf-8?B?ZXh3eXJQTHNtNHd6MFpXT0dHbmxRSVBmSnZGWXRXRkR6VExURjhUOW1ibFNW?=
 =?utf-8?B?MVNhdU5QRHRUT2Y4WExDUGZsUW1telZwWUVvU3p6bmREek9QNzM5ZFlLRmU5?=
 =?utf-8?B?UlBuOWF1bnZLUitjS0h3dVBXSzBmNThST1piaUJib3Q3TnJFZFBLempFRTVM?=
 =?utf-8?B?MGlERjE2QTBDOTFvemZSMXhuSUJNYkJBUU5vSnUzNkNlbS91dGpRS2gySXNo?=
 =?utf-8?B?Z1lwNU1PbGt5T2UwblorRjVVKythT0lORXNBdGF2TlpWaEZ0U25oSnRhcEtQ?=
 =?utf-8?Q?+aHYgWH6gM2qOAjtcIDs4jSDL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becc06c8-a924-4f39-0e5d-08dc3f48c5a1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:21:36.6556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZA8H5wWyrJR9Bdsl0e6VKJyB/Xylok+l98XZ5H1ZkBiletWiOseCgpleOkJnS3W1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181



On 3/7/24 16:43, Andy Shevchenko wrote:
> xilinx_spi.h is mnissing inclusion and forward declaration, add them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   include/linux/spi/xilinx_spi.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
> index fd6add419e94..4ba8f53ce570 100644
> --- a/include/linux/spi/xilinx_spi.h
> +++ b/include/linux/spi/xilinx_spi.h
> @@ -2,6 +2,10 @@
>   #ifndef __LINUX_SPI_XILINX_SPI_H
>   #define __LINUX_SPI_XILINX_SPI_H
>   
> +#include <linux/types.h>
> +
> +struct spi_board_info;
> +
>   /**
>    * struct xspi_platform_data - Platform data of the Xilinx SPI driver
>    * @num_chipselect:	Number of chip select by the IP.

Likely correct but forget how to check it with tools.

Thanks,
Michal


