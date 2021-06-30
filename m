Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BF53B8530
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 16:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbhF3Oq7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 10:46:59 -0400
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com ([40.107.243.50]:50273
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235177AbhF3Oqz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 10:46:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9qxchzmeeBclAXbrnlDCmeVseiN2vyXPCypVGSz1B6cxgh4/LRH13KMHtf+IEsCwwDq1NSXPDbEoZY+z1Ru8LfUoH6pxumV3PQip06a/kBE0mRnXhbDGS+9fjMo0MVXopuoAXu5wdVP+/4BjDPBTc2ASHXg2oTTuT3GT41vlA1hdCx/ohgw8ACxII+oyWyi/VmTEpoGkLYbmLTzOXBuq3Zz2cwOxlfGx2HxtnespAFWf/7gBvdkcntOj5gDqsJgHU8z+GMzaW47PTxx7Sk44ad+issclJzGYyx3in44QT6gB6QtzztxY5/aEoQzaCpAE6UarFg3S3GlvBHGDb3UpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieF7OGTAPg6VAirOwmYzQlNGZnk+CEzOmpOc7a8lVLM=;
 b=IP+gTY7zSMV37KPyfwOQulKidmPUHiEE+CURYBQJKqdFWBAnjiUoNtF/ixb8S0mwb+oBYGfMImFEnJUvKhjLjJXUww5lJlgDxIXUm3KBJyRVAvWjwyuYZk+T9fNYwws6lx+WGMtkVu8D8//iZvIFYko404XoZKi7ealy0yLdO853ltnC4ggPh6DcIQJH7YRKSstAnAbzqnmJoarjbf4u+AgDnZlcBhfrxBKkJIM+/TOnIHZvt/YbSl1ZZGxJgxa0+4hbbvXwNNERIpwZWQrMIhCR7osQ58Q0ic6TqYZ6K6UKeDglUZA/UyJe4OVXX0W2EMGI90cvqXzvlK7zbmYjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieF7OGTAPg6VAirOwmYzQlNGZnk+CEzOmpOc7a8lVLM=;
 b=SycYZLScepLfqAM+AxHkPk5F4kN0XHxPs1cOxXiLNv+KunMpi+ODpi2ARBq9IrPEjO/7rNDlaIDNz4CxzRBXG/zKQqAGEZJ2mhyN87h5W9qqGgFviuWgFGYb5svEyeWpvuiWL8BO5wsrGir0OW67f78oIb3gEC4KPhFQgm1TtsI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 30 Jun
 2021 14:44:25 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::69b8:2b8d:bce1:b1be]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::69b8:2b8d:bce1:b1be%7]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 14:44:24 +0000
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
Message-ID: <fc174349-d2f6-6721-51e4-a23ae5a8262f@amd.com>
Date:   Wed, 30 Jun 2021 20:14:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210630124717.GE5106@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.83.220] (165.204.159.242) by SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 14:44:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4000973a-9e45-4a38-60d0-08d93bd58df6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5145:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51451DD50A9B31CFCF34BB1EA0019@BN9PR12MB5145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJ673LTkdgmdAK25rAMXNSGPNz+LzJidi+wV8U7Eq9irXSH/zD3a4B3EM+3AHJ1AK9/MOk4uxzb4rM1dWn1gvgFfF4KloPXnvUhde9MT00TRfzL0Mq6rqIB2Az1B6eL2T9FNzhOruYvZcK+PwxI8QbGFP9A0iZ/20aRXm9Qa7oiK+D+XewC8Q93YHotE0AFnLdHWIIiHNQuECIFSgG+ePRqJATdJtXuOgnzJPUGRGfO8Ew2sLbFqMmMAoj5aqGdQkOqtteIQW0hu8+KnOQxRXymTYLdZrM+x/UVgm7oEcgL/25DTOtf5bowoG06eS4u7N38DKmPwclrIRP/8Qt1ml2j46V+gknLHx1WQ4EGkSmLa6axx8zeY4l0be8plg3/kqceiVblcQq0oudUaqO7MV8+qiTjIdHVgBbgr42iKRAfbbhuzogIN4MX8JRivY9cMt/9TR1XGTbSeSRPYT6kyeF2n8cbpJVt72jQnzlG05JssjKD3PdGaw4xH30KnjVuJ6LNGVitHugzCfrNqrWtih5kW36yCNv+X+Zu28CA/kfRPY52gXo62hU+JvoDlbR3hY9qPJMDHVs7RSNdvFHBrUEAMIRABNLKCZUvMryj7ot7oR/asJsg7nx7EwG+/KtneShIGilvQKccRhXdEHKqnnibgNKgNIxnGnnZyGK8kd92BkSEpLuOJnU7Kw6rTXgUPuYMKjhSMay4QhcrazLZTExqOdC4A8f+aAZgocjVj5g8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(2906002)(8936002)(4326008)(31686004)(53546011)(316002)(26005)(16576012)(54906003)(4744005)(36756003)(66476007)(6666004)(38100700002)(5660300002)(186003)(6916009)(956004)(2616005)(16526019)(86362001)(66556008)(478600001)(6486002)(31696002)(66946007)(83380400001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?topcoKzSybM3SydieKCD5HXup8kzGPamqJQdVqXcmj01edEFZvVcVMBH?=
 =?Windows-1252?Q?lvyLnsgrgU9eXcah+tunKcVGUfFrbD4XUGq4OLUm46NEGGYaYn0KzrsS?=
 =?Windows-1252?Q?vqj0yE1SSNsWhYdEaqiIPZSEQo9q70jPZgcW5D19SZFdF6RwZ0trchAh?=
 =?Windows-1252?Q?IMlMbGvl4t95t1MHbO0h1oRfnPeYiqmrXyLZPBvNDXQ9hVblFNkyLwe0?=
 =?Windows-1252?Q?kFiT+ows1d0OV5rzztUQQHPOzxt5aNpRyRFX0pNNgzriEvTTxOonMRAu?=
 =?Windows-1252?Q?JwGjbt1vgsR+sRtnJsrh8tFWA0gFNL2DpjxUoDQ6LdcrCwt6YFzz+3z0?=
 =?Windows-1252?Q?kCAFhhIMHpUgHHzd6V74Z4o0VvgvrNJS4RscQqvvrQ0mbnvzvcJe5NX/?=
 =?Windows-1252?Q?H0tFmnT5J5CaJXxqjFSBRX+Kr34cAp3z/EUXZ2e1+w1wTpc8KM62IA+J?=
 =?Windows-1252?Q?mK+woOc4vwyX12T6H0rfJhrH7hSoagA/1r6NRcOwkRejAYMMTC2MbSBK?=
 =?Windows-1252?Q?6a1BGNa3+BHgnKOxgPlOz2dK7F7ULtAWJlAKjMjsMD1vRWLlUkBLivZJ?=
 =?Windows-1252?Q?F23oOmz+6HDUWiEHRFm4NvzhKrSjXWoaSTvGQdJh+bqwo7XgzZZcTPxY?=
 =?Windows-1252?Q?L40zP7CFMZlPTBJZ6Q0qMRDD1R/+h4UbUi/QsJ2a0NIzRHm6O9242Jtc?=
 =?Windows-1252?Q?8rkJgWaABjofZ9mvCGp71s2sOA8vreNyds9t5xbHk4cLSNWZYMzON9Nb?=
 =?Windows-1252?Q?ITveytEv9uio/AsJ0KyFI+oZP0dfaM8EAlawtREoYY6a4056AkPpXeNR?=
 =?Windows-1252?Q?wWINw8hs4a2qBNW2cqK73bbo7/iaAlYj/mNvVU7xKUDUTC9ukneT/1Jr?=
 =?Windows-1252?Q?5wrqfe/IdcRcICB5Z11lBY01I+t3afOiBPRPFdmD6bxaNel4SQ8pfinF?=
 =?Windows-1252?Q?kxHtKxuP3wns3QwbTHdx2jcxPSTpHLPcGUYkCdr+jn1gJe3N9XVXzBWF?=
 =?Windows-1252?Q?prFGNh12AgAdzip63cE1K+XZwtBNWsOTa72yFrgP0YsbXYI2iOTWdBB3?=
 =?Windows-1252?Q?a68x79JFg6Ot9J0GsJ898szCRNBZC1/oR7JA5VZEgl9LLCCxk5V7L0zL?=
 =?Windows-1252?Q?HVhS7Dt75koIUcRrXEh5A4Q5FSSPXkIydFQyNjMwzAJlfgV5sCRq803g?=
 =?Windows-1252?Q?gQbgMjw837nQjAXPzTjOG0MITnW++TI76x7vPqwT8tkhIfhPDNG/AhxV?=
 =?Windows-1252?Q?crYOcWtHz0EPJHANV0rRFiRRz3FGD1CtmME3dNxdeFLOu/8no0G4HpXo?=
 =?Windows-1252?Q?ooVVyIHZTGwdJJ4+atbta49Fv17yWbz98Ff3r4OMtKc46YqjFAanB71J?=
 =?Windows-1252?Q?mrP9sztXVJA4jqNeEMTdVT5Ie3qioETwIoexr+De8uxJZe8Yezk/JNiO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4000973a-9e45-4a38-60d0-08d93bd58df6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:44:24.7205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LobLLop/GCbx5z4ICuYgUQ6nT02b1D3oBiYX2YQgGg8LupOH5svst0yYPQ6AMKZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
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
so now should i RESEND this patch with suggested changes,i.e removing 
ACPI depedency
change and removing COMPILE_TEST?
Thanks
Nehal



