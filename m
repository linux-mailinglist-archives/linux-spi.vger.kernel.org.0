Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B7432B33
	for <lists+linux-spi@lfdr.de>; Tue, 19 Oct 2021 02:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhJSAaE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 Oct 2021 20:30:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:36582 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJSAaE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 Oct 2021 20:30:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="314594812"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="314594812"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 17:27:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="531049094"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 18 Oct 2021 17:27:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 18 Oct 2021 17:27:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 18 Oct 2021 17:27:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 18 Oct 2021 17:27:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/n3g5xOk/ICPHAxzdHALshnayVi+wgwh1TlcBnfC+EwXDXX8UKiqRuuUk5tyLIKeIsXdQjKPBkPCcXuydJbBSQpa7LzzSYksg9D302q4Gf6M3pf+xrBmXqNVKDMNfpcrtZw+W5jhgPOxecp34xu5Dmn82K8TFZyFQXwpARZyPPVjO4H2sVcomOyp3LFyB7P3IuJ6QMS7f5VsRo8ide2GyqV7aPJf8Z1pBnv4OK2Id82Vb+pOzBaud5ClphYT+qo75HWTUCFZKQ2fCe4AKTE9SiwxgMb/kqDu/ZcXqAakP5OKRne1IFBa+Baa/7cEVGd/u8TY4iJrPA52JHpF5nbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaaxcliJylt2aWBMZ4vB+6rzQQGrmYTNQitTuKKGx7g=;
 b=NXHUFnZsQDh6uPh0QYx/B0FBF7NNCkHqKx904Jg1GyvjTsqKn/rJWdZg2hSDMBvEQtwSuaV3EOOM36qDTy++1QFj3NRlb94/eRIllTy1Yjyi4SHo0Unv+Dts9INELXH3KqsQqu+6YNuza2U2iwXHY0p7SybToCUHbpgikDXZxdfGkTnn44IkHgjcwEr/geWVLrJ72btbvQTMxmDQGxM/ZsxJhW9wWfxW5ElpIoffa1UzDDGpxrGeYiJ9NfRjJ0mH9O6QjlvLBGSn9NEv6OvkdWmbAjq6lVoqWo+sOL2Ydc5EOInSc8Ui4YulA3Zm75+v2iJ7e+bi3D8vsH/Ae8GfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaaxcliJylt2aWBMZ4vB+6rzQQGrmYTNQitTuKKGx7g=;
 b=Zkp5XFUbqYU5jnvN4BYp38iI6VRo2JZsZLh5qr1Nm0+ZFfMKtnJBCX7la8YMeU0Bc37v2IJ2cjWTeX622OgpfMQZ7vDphqVbuB0hmM10mAADtOUXMOVKdyKSUrEzninscBZ1BRYtI1dmwvdSRbav7o+Ph4sdTkyC7L+KzTfra0Q=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SN6PR11MB2861.namprd11.prod.outlook.com (2603:10b6:805:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 00:27:43 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 00:27:43 +0000
Subject: Re: [PATCH 1/1] spi: altera: Change to dynamic allocation of spi id
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <trix@redhat.com>, <lgoncalv@redhat.com>, <yilun.xu@intel.com>,
        <hao.wu@intel.com>, <matthew.gerlach@intel.com>
References: <20211019002401.24041-1-russell.h.weight@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <278aa054-9710-440e-df6e-96c7b835e2ab@intel.com>
Date:   Mon, 18 Oct 2021 17:27:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20211019002401.24041-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::23) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by BYAPR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:c0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.13 via Frontend Transport; Tue, 19 Oct 2021 00:27:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2425d2a3-2407-49c9-054b-08d9929743e2
X-MS-TrafficTypeDiagnostic: SN6PR11MB2861:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB28614D3BB8577F327EF9C580C5BD9@SN6PR11MB2861.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TDog5C+YZ7xOmb5coxhqnPtMT1ep3RuqtYuQVvmRxqx9LydlvaPaYUO1XP1LdSw9t8MPMcWFiCfvpXufzuz/h6r2el+4aXJii197ZOi1KU9MpVdQhN2lCIj6um/5xXgasSqbq9ulSDWAx27IxstrBHO/XKYu++AjnhaCz4O1LXAryD9yaEakkbMSKpW+6Sp0lh5OxoQgTiInnGTwahUt51JzggwTstS4FzFuyj7uzVOloWjJ//grg/SjPmmvQ+BCM630gzFqhZlNIhybJX161oDoQYagIDw+o3OFvKl0wYY/wrQ9o7ug9SSz3O51WvBobzQ+PyeyWj6kKg/lsKO1JbimnJ9K0TsJJHiNeemGoTEw5j0yOVM60ceh+ORPR8mXZdTDiGHZ50GFgpQY1kuwive8+fLNV6lvA6O1fkunIFR6tyZPA4QVUSHcKTAJNCzqxtP3jd9xmWY9Ad2VZg43inD1U80dg87LSMpuaNYpEMtY2asn2RZvFMniKL1Cnt2WvewO3NoOh8omDAlgPkySyImXMRqWTIpgNXMjK+4SFjgQ19zVyJMncbXdb8cd6bQm3u6ceIZZxyfoKTtk4SvanCcVZ+rtoUOj86uRDelLMkgMKyL+QuGkjZBwQVBfVrYWG8H7slT1uQ8tl8yfBtzvNSc2/B7hj2XkmaOcGnBtDYqSYriM8MZ7HrwrTWYMzJmq0mhvGlGNJc0AIJzn8Mr2HMH2Dg9iF5Wz0vCDvfusDugU9skOREKpXQQBpE+fJ4K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(31696002)(82960400001)(508600001)(83380400001)(5660300002)(956004)(66556008)(31686004)(66476007)(16576012)(86362001)(107886003)(36756003)(8936002)(2906002)(66946007)(4326008)(8676002)(6666004)(26005)(186003)(316002)(53546011)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0JwMFB3WDZSbFhaMkl3YnI2ZVMrczR3ME0vSlZOWGdnVUpuRmRJZlZpemJ0?=
 =?utf-8?B?Z05icmlsM2ZnYkszMmIySzdOcjdVSitlSlNUdzhWd2gyTGdUUkJybGUxNWpv?=
 =?utf-8?B?UURwUllCNXNjaHJhQmpOZjlVRDRWdmhEK3VnZnJucStJbVU5VTYvZVQ0RnY1?=
 =?utf-8?B?QzhnUmlweDJtMEJjWWxvZEJiM1UrS1UzczdHYlQxclI1ejZXVEE4NjJ4ajJ6?=
 =?utf-8?B?TnNrMGV2MHRmWjE1U3VvdnFDSUdOMjJkYTBRbkttYThPMEdpUkZFeTV5ZTZq?=
 =?utf-8?B?SGRMU2ZOVVJVUDB6d3ZZcndZeUF1L0wxUlI5VDM2M0pNVWFYcFNZNXJFaFZF?=
 =?utf-8?B?VWNqRnZRaHJSclhSMHdVODJLc00ydFFackRyN0RkNG4vcGZkcGNlYUxCZzZS?=
 =?utf-8?B?c0NRRTBOUERXak8xY0xYTjR0dk8xTnp1SERuS0R5c3NOUTJEejBXblFtaE5u?=
 =?utf-8?B?MDNwK1ZRdTlRd0REam1YQVBtQmNiUzZweWV6dGpRUnBFTStPeVAyRm4xYUZ6?=
 =?utf-8?B?YkpiWjJxQlRVY0dHM0lsNFI1a2dwZWQ5b1RVNVAvOWY1dXU4aXYzNHlqRXZ3?=
 =?utf-8?B?WXFCRGs3aWQxdjVUZTY1Wld3ZVFCZkQ2VG96em1rRUlaa0pSV0tQMW1vN2Zz?=
 =?utf-8?B?d0NybHJYMjNaU2s2ejBBK3Jvc05pcktISHdtRnpMY3ZNRkFmQ3JPbkFDUGxu?=
 =?utf-8?B?NmRqa25OTCsySklsYkFYTjZTc2M1NDZHcXhFTDZhSjdYS29RVzhOVVZpazJY?=
 =?utf-8?B?L1ozQ1RMYlZjM1hXdmF1R00ya25BN09HTW9EWVRiVXM1NXFLRHpNRE95Vm5J?=
 =?utf-8?B?dVhjbWRHeWE5VUZxbTlIUTAydWp5V1J1NjhXUjZQMCtGNWE3Unlzczl3OHFt?=
 =?utf-8?B?MUx6VGh0eEF1YjhOcEJOMkdlajkrbkozT1FkRFBxb05MVEZkWUpiZnQ1T1da?=
 =?utf-8?B?TStEYnFJb2wxYmtLK1o4NFJyTk1CWlNObEdYYjRsVVF6TjdpWWlRTEREcFpY?=
 =?utf-8?B?dGNJVGR2WlR2TlhnWk1SY1F0L0VyemdGYjN1T1VrRGQ0bzVXSUJhRyt5R25U?=
 =?utf-8?B?QjJYQlRxSDZ6Ui9WLzdweGRDMkhmVFlldFNIaVBRV2lMVnBwL1Uvcmw4UEpv?=
 =?utf-8?B?Z290eFpVb21CU2h2N2hCWmxxVXJva1FUeGdLSStQb2ZNcTFHSnRPdHFsRUZh?=
 =?utf-8?B?ajdpbDNiVU1ONzUrb2luVkF2YlhvWExyV1IwL2t1Uy92NCtCZWpJZ0x5clJr?=
 =?utf-8?B?RERkdDVBempDUkJUdHVVNVA1dkR3Y1BPZXJWSVZmeG9MWExwZ3NxS1FpbVlR?=
 =?utf-8?B?cjNYL29QN2p2ZmdnYitDUk9pTktCUTAzaUVMYkZnY015ZmRwWXVHMVN1SDJ5?=
 =?utf-8?B?WThzRFJkL1VmNHNsd1ZtbDlzUndTM25tZVdad291ME11eG1Oc0Rpd2JxVnMx?=
 =?utf-8?B?eXVXUFczKy9VVVBqMkZTSDcrSE1WT3ZRZ2pNNi9MdksxNnJBQ3M5MTdmSDlY?=
 =?utf-8?B?bndQek1pOHVMNWhYOWtSbWJDNnUzUmtSYzJLcU5SU2tQa3E4UVdueHU5amQx?=
 =?utf-8?B?ZmswTVA1WDNqMThBSTVTRHo4YVkxbHJYYjIvSHBvZEtiVEFHZ0tMMmxZakZL?=
 =?utf-8?B?eFFaSTBseFBMMlU0T2EzaUh2UVpyQkp0bTFrNDdPMTRnLzRSbXVvQVhqUFRR?=
 =?utf-8?B?RGw2NEhLNVBPNkFUWE9GUnFTcGdyYlh5ckh2WW5keVpxNDMyM1pxek8wVDNw?=
 =?utf-8?Q?Yyd20+ryauPB9IqvP6+HQ9QCoviGUWSApuP8Qgk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2425d2a3-2407-49c9-054b-08d9929743e2
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 00:27:43.1575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/AN0M1VgXTIeUGJCHO2gIknRgybDag1hyJ9nJY4aoSv3oxz3AWq96XYCYMLX3loxbqLrYV2Bam7bqx67wwSdIxsid6uY+aO7hd5sOksraI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2861
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If there are no concerns with this patch, it will need to have the "cc stable"
tag added for earlier kernels.

I don't think it needs a "Fixes" tag, as the problem has been there since the
driver was introduced.

Thanks,
- Russ

On 10/18/21 5:24 PM, Russ Weight wrote:
> The spi-altera driver has two flavors: platform and dfl. I'm seeing
> a case where I have both device types in the same machine, and they
> are conflicting on the SPI ID:
>
> ... kernel: couldn't get idr
> ... kernel: WARNING: CPU: 28 PID: 912 at drivers/spi/spi.c:2920 spi_register_controller.cold+0x84/0xc0a
>
> Both the platform and dfl drivers use the parent's driver ID as the SPI
> ID. In the error case, the parent devices are dfl_dev.4 and
> subdev_spi_altera.4.auto. When the second spi-master is created, the
> failure occurs because the SPI ID of 4 has already been allocated.
>
> Change the ID allocation to dynamic (by initializing bus_num to -1) to
> avoid duplicate SPI IDs.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/spi/spi-altera-dfl.c      | 2 +-
>  drivers/spi/spi-altera-platform.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
> index 44fc9ee13fc7..ca40923258af 100644
> --- a/drivers/spi/spi-altera-dfl.c
> +++ b/drivers/spi/spi-altera-dfl.c
> @@ -134,7 +134,7 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
>  	if (!master)
>  		return -ENOMEM;
>  
> -	master->bus_num = dfl_dev->id;
> +	master->bus_num = -1;
>  
>  	hw = spi_master_get_devdata(master);
>  
> diff --git a/drivers/spi/spi-altera-platform.c b/drivers/spi/spi-altera-platform.c
> index f7a7c14e3679..65147aae82a1 100644
> --- a/drivers/spi/spi-altera-platform.c
> +++ b/drivers/spi/spi-altera-platform.c
> @@ -48,7 +48,7 @@ static int altera_spi_probe(struct platform_device *pdev)
>  		return err;
>  
>  	/* setup the master state. */
> -	master->bus_num = pdev->id;
> +	master->bus_num = -1;
>  
>  	if (pdata) {
>  		if (pdata->num_chipselect > ALTERA_SPI_MAX_CS) {

