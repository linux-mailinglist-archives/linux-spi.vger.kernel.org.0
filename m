Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ED34CFD23
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 12:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiCGLjl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 06:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbiCGLjg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 06:39:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D0D31509;
        Mon,  7 Mar 2022 03:38:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9UCdHbewZObs2Q57slxQR+xxKOO2goEfCmOMOrteaWD9vwakGLnuyuCKNDTqxSCvZxtuXOkUeK9c3J1gq1iLGam3mKGdR6N2XqzLHiFG3AsHsVaEcdlPEU0w9Lk0YNyy++DszOY9yIe1CyZbb2Hgv1+bLEjojBwHwOgFdoDTLrF7dr/cS/5L6eJaFayypcUrYlJIcUnQay6FtViBsd/YDNkbdy217qKSkogr7nec/Xo6mVn+Bc80w3m+UV6FmfyNrEZU4EZtnjIfHyu0sD+i1I0zzZfuXOXCJQenO/keTkzkMhJm1Ok0n+IbPbA82h9QJirsMc3dbcnm7sZcpDi0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/uboknRcbSEM2Srxzwz7hoMvwCFdp8bD5VM+58FGLw=;
 b=BOh5EW7zXUZhUA6yvARPW5wGr0r+FeohnsGR1O8RzWEc9Hss0igAyJ+hwQK8gzu2GH2cus8Nsq5+dtsmdjUnD0dWe83VzUK2vWGiAMUbmkBqsXhhu3+me7E/bRi7ZiP8jzuxuY5Y1kjh8RykJlztV/5atZWEQvns19ono1zw683nrbzIA62uh5prtXqK/S5AqpKxawJ9frCdz5n3jJdsEN3GMz2N/QWbGGqKHq0XXu284noHeQSMo/0thZO1tBvOi1p185Q4F/eL3buDosPmJII3LIeHDRrKokz2MBCPqamTj18fC2CQ4/U+aK6kgvSL8AFnBCCBkS0qEKh9dJWjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/uboknRcbSEM2Srxzwz7hoMvwCFdp8bD5VM+58FGLw=;
 b=iGESBEYHZuGd2syRHNyqvveWL9IevftgLecQAX0jpvF8DA/S6Boqt/mfwlPs67NBenmcrkfoKxqExH60CVUAoehluPIh8tDvBxXog+n6r/nPw5rbLEzy7KkdLHals7NS1UvRAwL4lNDfpQkaJBHlzyCI+3CJk4Bi5eeeFFdVPzmSviPInEDu5lx7dUM18NfpMjquJdG5rtcJP05hzDRmRE74dilXgzJ/axL7bqeoGPY6sF3Jx7HiOzyeIZR7qgaGiLixBUH7OyO11sIqD8ayKUM9ICl7qz7MU+t16o63w19z0VU6/EYmqcS4XN4FQx+LoXX+QYpDb9HBz3ZiYpQ7pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB3033.namprd12.prod.outlook.com (2603:10b6:5:11e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Mon, 7 Mar 2022 11:38:38 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 11:38:37 +0000
Message-ID: <e6ec88d1-883c-03cd-0dfc-eb01d7075194@nvidia.com>
Date:   Mon, 7 Mar 2022 11:38:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: spi: Fix Tegra QSPI example
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20220307113529.315685-1-jonathanh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220307113529.315685-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0509.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 533731b5-72cb-4671-3283-08da002f0509
X-MS-TrafficTypeDiagnostic: DM6PR12MB3033:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3033BE7CBC7F5071594D04E2D9089@DM6PR12MB3033.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFqmEofMAjZMMVM1ocKeYkoFN/MWPkBlmczAwPWpNtXQNpJfeCD9xesYNGfBsmHTP3VLD3RuEY7oOWUTqieUL6rEW9BX4okkCumB1Ce/MdcF7qHrwcw3WQWjbiQKAY/SSCwSw+FGSINFPjyvw+/5CU5bQNXiE8JZwiq3H0p8UEeCEaZlzw1zztjR6j0L7lj7WHYeKjHECi6+Wgi8OdA6CWV5wMNb76QJNoOzzQo0UFkBZvC56eq3+z2piMKiz/CG6HuUDtFm0hG8kdDMV+/3J7Iq8ZpfDcaz6CxX0yAhQLA70lZjLAz6LtNmIX8h9zl12W+F1gc/H6c+GG9bqwtW2w9ZtMyVJt6kY5dCK3/bvqJUBxn4BguKOQbNW2HtDaQI67JDax4dc+ZYxN4nFXUkZquguYpH/xxq7Elq51vrvLvtYUlTdLZkBNcIUt/Mn5iG56v0HkfDDZlaX/l8TDcfDveTo+yCtaMfTjYvg+8iheS96mGidpttk3qg8KFpEOINwp+agfq3gV3vl9aUPNCLN63wf0zpdgkdL/XQxTMMRqV7X3vjuTx9ZG/W6WMzdzu6FR0TUfFo5IYGwqWKl3RkQTa4Dd6Kw0+TdyN7+OCFSRCzy1j0bPIPManwNx4dFms8DBqmcI0vhxTLvvMC6tiZpw2ykvyrdXAgtpeTVYQWgf0YKd+IdPPpIpK9xVlOoZm8k47jmT9FQkP3F3HNFVh/11EI7Sl+vPCBbeYwu7cxM0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(5660300002)(4326008)(8676002)(66946007)(66556008)(66476007)(8936002)(38100700002)(110136005)(316002)(4744005)(36756003)(2906002)(6506007)(2616005)(186003)(6512007)(53546011)(86362001)(6486002)(31696002)(6666004)(508600001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWFjY2xFTDFhZ2l1OUVhaXp3bWhtTm0rTjJBSklONlR3RnU0SERqZmk0anlO?=
 =?utf-8?B?aFRpdkdSa21VTXB6Q1hYQnNhcTdpQTRPZ3pJOUpsRm5MbzBGVHpEUzIzdlY0?=
 =?utf-8?B?ZlZTZzZWbmVFL2VmWEpzdGc2RlRrUDAxc0xZUzQ0ZXFZOEJhSFpDVDVpOWtD?=
 =?utf-8?B?VlZ2UmpzekFVUXFzUkRQeDJvNjJyc09QRUxZaVFhL3pSWTlIbWoxVXRGb1JP?=
 =?utf-8?B?K2dWL3VISlZiK2JwVCtGRWkvV0MvUEJCMzUzL1ZVVHAyU0p1ak54WUtJOTl1?=
 =?utf-8?B?MUdOWnVzVXFoYlN2bzFDMWIzdHRiVzlTMmNsRU8vdUpJdmFHMGloMWxJL1VW?=
 =?utf-8?B?cUJCKzFSdGNEbUZrMzFLSUxSU1M0dm9mSXJiQTQzc2RHQ3V0YTRxVVJpejZ4?=
 =?utf-8?B?dkZCdUkzT3FwUmFxc09FQnA3NDViTnN6em14U0pDQmhMT1J3b0l0bTFmKzhm?=
 =?utf-8?B?aGVrTWhZV05XSm8vREVJMU01ZEd4dlFObFBwcVNIdDdLYmdTY29Kaml5Mm9z?=
 =?utf-8?B?bDZyQ2tRaEVDWlExNXZtZ2cwb09hK1VCMS9qOFFNaVRTN1pPTndRZFU3aFhK?=
 =?utf-8?B?YkdUemxMYzJqOXdmdUEzOWVycHlRVFRwbGpuQ2lTRll5TXZnZE5temZpOXhy?=
 =?utf-8?B?bzVRWVpjZEdiRWpHMGZMVFRpOHZvaUFMZ0VQeFNHWXJLVG5tMmZ3cklGbmhs?=
 =?utf-8?B?Y2tqRFE4d1FURzlxdFdqcDV3b3BFSHVIUTJiamdvSnZROVZmem9CQ0xoeGlq?=
 =?utf-8?B?OVZaTmc2YW03UTZhbGhzUFpRNmhZMDdzejRRaGIwcU5pcmd2dllLZzNSMHNy?=
 =?utf-8?B?ZTlFZTN3UUo0eVhqd3JhZ01mVGpTSkNIKzFNMDllajVjR2c3dGxBdHdPd2dp?=
 =?utf-8?B?aDhpQjNBMU9ab0xLbWRWMEcyaVZFZFFTQzhHRzlEN3Zabk5aRmFqdDR2NXFY?=
 =?utf-8?B?a3YvVUd6VlRPdVZ6L1F4QWg2VkJ3MmdjekF0T0p6b0YxRnYybDM1d1lIVE1K?=
 =?utf-8?B?V0FjOTZaYXY1NWFHQ25QMnFiSVd2WFJyRUFjY2RlZGFuYnRtYXV3Vk1nSzdV?=
 =?utf-8?B?ZlU2dDZ5K0ZNSXZSbmNPUEdXcHk4N0pZaURpUEtFdmFPZERrVXJ2T2p0YnFV?=
 =?utf-8?B?dGNXRHJ2UnlEZmorMmhjTk5JNU5VcXZKdFQzK0xFbis2STBkc2Z1c1ZHTEN2?=
 =?utf-8?B?S0pTMkd2UnJSaE9TTlZ4TmlWdFVObmFTUm5QRTE4eVI5WjMwR0pVRzNHNEti?=
 =?utf-8?B?UHppcWlhR0VRM0dqaThSVDJvVDJIVU4xRU9lbGdVbWphR3pjUi92OHE2aUw4?=
 =?utf-8?B?TjNJUmUvRmlqM1ZUUUdQVGJIbmMzbUtNS1pXanZTODlwOXo3RHl4YVBFbk5v?=
 =?utf-8?B?dkxtRWU2NU5DSm9JNE1LQndyK0xrOWVqdzcyL2s1QVFhcTFiM2YrWUNxSUVp?=
 =?utf-8?B?QmJlbUFVNXVxMGc5VEJCR0pDaWJHZC9wb1pzd3BLUDJSQzdabElzUVlwZVpJ?=
 =?utf-8?B?b28yNC9RM0hRSlJRSDRPMjVCa0IvRlliYytRbnBaUmcyamNPeU5TaExUOE9L?=
 =?utf-8?B?ZmxqTjhCSFlBd0o1T3RTVGZNcitGNk43bnc1V0tRaHllOVhraHIwcWdCdmlE?=
 =?utf-8?B?QW0yVkJwaXQ2bjVPMGQxMkp0L0haT2ttYml1Mml1cTd2Zi9mamtzNDZXMTgr?=
 =?utf-8?B?bHlqMHpZOUFZWEpleVhZSG1BMTBTYlh0dm5tc3Z0MmJaaVF0cERReThtZ3Vo?=
 =?utf-8?B?SzNGa1ZkLzJPQjk0SXRDaUczbjhsT3BOR1VGUU9VT3dSMTEzaDF5WHdsV1Fo?=
 =?utf-8?B?RFIwZGJCZkxzSUFPNDkrajVFRXNGczF5VTZoQzBCL1NRTE1IOUNuWjBzYkxu?=
 =?utf-8?B?YmRqb0x5a0NOdHhJRW1NZzRrYVJUT3cxUy9TeE1lZCs5N3VtM2k4M3BHR0Zs?=
 =?utf-8?B?ZmxPTlg5TkY3NW0wTkRSd0ZFZldhN3A1V3JmcllDTTN6TnMvenFFOE83Rzhi?=
 =?utf-8?B?cW1RbTJjZ3BXNzVEZTZ6dFc3ejRtcFF2cStJRHpQK2tMWHpid2RkSEJHSnRn?=
 =?utf-8?B?NFFEeWgwNUVPOUNENG5Cdk45ZFJHdGc2RldlRG5VOHlxVHYxYk85UFFjc0JB?=
 =?utf-8?B?K0NiL2xnVjlyNGloRzY3UUhPamNveFc2WEJIelcvWjc0aFYycCt1NTRLd3FF?=
 =?utf-8?B?cmJHejVhSWNaN2ljSUFWRTFxeFVaMEhGay9NQUp3M1ZIZERJYkFCRHkwRnFK?=
 =?utf-8?Q?C8U2zIa7HqzdoYHEJdozoAiHow/YAtYosOOxy6hfzI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533731b5-72cb-4671-3283-08da002f0509
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 11:38:37.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYpr0Wbqz/REu6QQFA+2nSvaq46JK/Tc1z4b1S65xZ4S0tW2gJ9kB2gfFuMwUtJyAhGJLdC7RaK3waQce9xwPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3033
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 07/03/2022 11:35, Jon Hunter wrote:
> When running dt_binding_check on the nvidia,tegra210-quad.yaml binding
> document the following error is reported ...
> 
>   nvidia,tegra210-quad.example.dt.yaml:0:0: /example-0/spi@70410000/flash@0:
>   	failed to match any schema with compatible: ['spi-nor']
> 
> Update the example in the binding document to fix the above error.
> 
 > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

I should have added ...

Fixes: 9684752e5fe3 ("dt-bindings: spi: Add Tegra Quad SPI device tree 
binding")

Jon

-- 
nvpublic
