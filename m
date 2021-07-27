Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3C63D749D
	for <lists+linux-spi@lfdr.de>; Tue, 27 Jul 2021 13:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhG0LzD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Jul 2021 07:55:03 -0400
Received: from mail-bn1nam07on2055.outbound.protection.outlook.com ([40.107.212.55]:40000
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231828AbhG0LzC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Jul 2021 07:55:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3Q+WcrWRVDlKLDvyMCka7drJVEaHmnpL16Aza/4CUGoGjRK4Goa5FDlIHi80z5W3N/Q9tET8hq1eKTA6+FcOzLBnBz1HAPhys7HCn7M9O4VLBpjC8dfYwo1NtNUwLds/Akbd9E7UxZCi9q+kiIMUyk2EAtsi6bLHbS+Zah48EV6ENAE5RVU3p+FMl47Pk9Z/oi8Rcna+H6XBEGHiAdPi8K3WjnY/ldN01vC8mFkQAQcuPzRQ+SzXztU9p9v1/LnSlBqLUqAX1t/BWDxf29ANsr1ZL9cuxkCUJZGDVxyIrDJZflLXwK4JCSj6kwQ3/Q7p8AJQEcND4yaz8xUVTCXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoRWoSqJUhLo5T8PGWgmNysrutj+SCAGJ8cJ3KNjftM=;
 b=ELQsTMU/jrx+xZxD/9RTZqcKnL45Q5U8jpGdTQZb5RZ1upsBBD18VcZ079kOAhjHle8HHw3TE04VYQD07HQdFpZ2ijYx++T0/5JH/lM8kVzmTfp5u3OSvrJGmeYN5df/MkiByIUYyJtI6uZhL3R3W0Pb9+X2ebCpO07FPP+dorHOELF3Myvu841BS4QB2YCfbzloJDVUZYgDDHLCEuWIbKZCmGNmror0jJK0Z3qvxceAVr3p3PVEssqZMPYQGXyGTSSLHnjTNPSDTroMUu/7fjm06kjtuEkjQykX5FbIotAwzItyIrXwvFMeGl1EdnG34lX6VVF3TAGiNigBud5OFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoRWoSqJUhLo5T8PGWgmNysrutj+SCAGJ8cJ3KNjftM=;
 b=dPpCqc/YHBwV80dHuOwwC2Pwa7kouwtoaVyEjLAaMR5rLMdFvwJIxFgrZWjXL7n2bDhQ7Wm+KUroE6DQXif8Bq5GqYkiYP+6jr/LqTFmKUS4TpJGoziwiGp7oBJ57S8KgHP16H7V/crDO/Hn0i7bfSrhx798521owhFO/+ekiHk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Tue, 27 Jul
 2021 11:55:00 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::b0d4:3c4a:e942:338e]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::b0d4:3c4a:e942:338e%6]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 11:55:00 +0000
Subject: Re: [PATCH v3 3/3] spi:amd:Fix for compilation error for non X86
 platforms.
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Liang Liang <liang.liang@amd.com>
References: <20210630120425.606957-1-Nehal-Bakulchandra.shah@amd.com>
 <20210630120425.606957-4-Nehal-Bakulchandra.shah@amd.com>
 <20210630124717.GE5106@sirena.org.uk>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <59d72fb4-3623-be6e-72d7-e47c5d434576@amd.com>
Date:   Tue, 27 Jul 2021 17:24:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210630124717.GE5106@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: KL1PR06CA0056.apcprd06.prod.outlook.com
 (2603:1096:802:14::24) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.72.199] (165.204.80.7) by KL1PR06CA0056.apcprd06.prod.outlook.com (2603:1096:802:14::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Tue, 27 Jul 2021 11:54:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 909fd315-d03a-40b4-c6e4-08d950f55ca1
X-MS-TrafficTypeDiagnostic: BN9PR12MB5273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52738C2E745627225B0151CDA0E99@BN9PR12MB5273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJx52qvvbbbMMYvovWjo4aIxyeQD+9lsfeUxH2P8u3BYf0rbKjWZwVgK01CUgy09DxoLLYLsb9SLIIkxkt98mDyHm2+QXC7QOzn6QS1QhvmPdJJGdNvt9IEvx0H2DsGxMsq1u1oIugU0fj0r2WcRI13yaM8btezbfwg9kh1fUA+ZL4gHepM9CHgAW/rm+dd+r4VPu1fce65APZR2xlIHQaqU3Nw09mdiLlzfbUY9elHkVfBfaCBOivhBEJ8w/vi4FvycOv+yjLKBKsWHIQR307DZ7bcLlmhvAAQX367/52dBPqVp9X3cqqr/ZrywrpLRrHIk0TU8fnUqKKc6LimIpsm+r1hxPOUL1dS3TosSB/TO18mLJBtDJZsRghXRKx0/smiuA4OpAfNWttrEEZJYZS7+zefWF2jzyD7jFnJc/PaZjmKdiojNOicd45xZ+xUcibmYKj+iEg1TYVzGwKXqvB4eZIkgYVebT1KMxKCuZ0cVh5xd9UCU3LNBxuuEL9LlbqlwDrAsssZuryEa26S3dIkCXTI4JngBZE6l/vG91C0yhjNOhE91NFALVw8TFr496p/oRCwZU/GxMCDB3Y0e8PTkNzX76VnDOcNb/5+vy1G+IkVTRi4y57JFSrjMW8hIKWe3XNDVBDzJGCfyxTvlPCOrTx41P/jQl13t1gMAQ42i2mbbGZi4epEKDBOOCfnJ+4gQHrZ98PmEP8Jspw3vHNTP+WWfoX2gbMvfp2S5jME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(6666004)(66946007)(956004)(8676002)(83380400001)(36756003)(508600001)(6486002)(66476007)(53546011)(8936002)(2616005)(38100700002)(6916009)(2906002)(26005)(5660300002)(31686004)(16576012)(316002)(186003)(86362001)(31696002)(4326008)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?5AtVQ49gxvvbW5yUrjj7HpPsCG9lzwYu3N4OkGPNYQtlP1Tw+Ne5Sw4t?=
 =?Windows-1252?Q?BiWU2zk8LL8fn6zTXUYd5t5c4SXF2AXhItZABY9WAAzgY8uEsMc8gPGo?=
 =?Windows-1252?Q?Uux7X5oTgy+LAf7QFrAdQctSvTJzu6+/UYKqzSCLUHL4XtVcrH/6p+Ty?=
 =?Windows-1252?Q?F78CXhu8Lfq55+ThZtBRaoRL8vAvtl8AW8t7/Z502Sjh64wc5K8SYy7H?=
 =?Windows-1252?Q?DwQNNhAVE/w1rBTQ7LkHpGWgH06QrlGbI45B45tNazUdYdTbQN9P4wNd?=
 =?Windows-1252?Q?T0ctEKv9aNDfGfRcGcLdIcgNdl+MUSxgsg0ke8o3vOk1pS8NLWJ7WUsl?=
 =?Windows-1252?Q?unQBqNI1lbqJh2lznx1PbVL9Kg5uqNIyPitFmm1tEanv2Fkhw0MRNfj/?=
 =?Windows-1252?Q?hyR7+Uqd/WeZzGT7IEjtSDKPPEyZRJrWtgMprMA1n9rhZqkHAhV4BLTr?=
 =?Windows-1252?Q?vFN9n94dCTeSD/VnGvsvWen815eUKoZSw+sFecbIto+h/f2S6CrKPFDp?=
 =?Windows-1252?Q?vWL/dPIVrOj4uf/lUMY4OZFEH+3cZRLDPYZBEMgIBfU2LrL0RAvsCImH?=
 =?Windows-1252?Q?IJpajhIUfSQU7QtlcYFgWxxe90MsvIt/5Doczd3rmXEz2cHyOux+eKsC?=
 =?Windows-1252?Q?n1Z5BGafU6NmAL1wp6BNhOGbTy7DYKHq0gDUi7yA0UNWP6JF7q3xtPbF?=
 =?Windows-1252?Q?L5smYKIfzgTY6IEEInoKBt+F3cmznPIuUuzap4MnktT6cd81FujLyOvr?=
 =?Windows-1252?Q?I2advt1IU+aEC/WR2oIyFwY8IREBIIr3H1gCFs1z9MLGu8k6uvPNq7q7?=
 =?Windows-1252?Q?Mmd10lduo5vq+q/wkZ1k+NIDVDW8XlidFN9rVMqJxutoOuT/yQ/PN83s?=
 =?Windows-1252?Q?PdbT+nVeh6DZIc8frpYMw1/zU2tUY1JiOLQy8lDd7BgH3fdDUHfJOiBz?=
 =?Windows-1252?Q?oufr7OLSrX5jhaCYf6hmmf02ZZPAM7Dbka3vEQKb8ufdtBYn40LAtqwA?=
 =?Windows-1252?Q?ZgWCwQxC8XOlVjPyceXtGP4qwmKSL9D0GZLr2+xmZsvTyMkSzbhuMsDT?=
 =?Windows-1252?Q?upDsT4ROch7ii4ch9ERbYzx0c7nrhfGDfwQKzRDsZMjN/fszkLF0fDpO?=
 =?Windows-1252?Q?eYH0GrIsOdeZ2le6DBYLHEJ+44ev/tM+qrScl7OBP9s1BtvQR6+Zmqkn?=
 =?Windows-1252?Q?JJYhxOIcMn0kElK17KVZ1U6k28YLMhF8YqKfRLv/nLQRiqz75pEm/zGz?=
 =?Windows-1252?Q?kBGEsz8fB3refaxcVZqzJw+2WJIphR4+ZTSZOY1oNRQZ46nC1BU5Ini6?=
 =?Windows-1252?Q?CPuBkVxcgZM1icdKl9FVQrN+sTAEJzMWJt1EyOQz2CQ2crE0vkkfYRMm?=
 =?Windows-1252?Q?bI3tt6LyrZAidyfCtQ2/5MdGwdE7Lek0lzFaqDDTChAn4o6mxkGREKJQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909fd315-d03a-40b4-c6e4-08d950f55ca1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 11:55:00.2594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVS/KyIusmBjlMivTmajsEC5kVxgAHYLpAEowaB9OENor85xu8rToivaK9ML7qwa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark
On 6/30/2021 6:17 PM, Mark Brown wrote:
> On Wed, Jun 30, 2021 at 05:34:25PM +0530, Nehal Bakulchandra Shah wrote:
>
>> Update the KConfig with dependency for ACPI as driver is only
>> supported for x86 platform. This fixes the compilation error
>> reported by kernel test robot.
> If one of the earlier patches in the series fails to build you need to
> fix that patch so you don't break bisection or cause people to spend
> time finding errors in the earlier patches you fix later.
>
> In any case this doesn't do what the commit log says, ACPI is supported
> on at least arm64 so if you genuinely need an x86 dependency ACPI isn't
> going to cut it and COMPILE_TEST means the driver will still be built on
> everything.  I don't recall anything from 0day that looked like it was
> anything to do with dependencies though.

Thanks for reviewing this patch series, however we have decided to drop 
this patch series and our partner (Cirrus) will send the new patch 
series with

more finer changes.

Regards

Nehal Shah



