Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022AD3621A3
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 16:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhDPOFu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 10:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbhDPOFs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Apr 2021 10:05:48 -0400
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0621.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69E6C061574;
        Fri, 16 Apr 2021 07:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUl9vimFoj8575Q4ZVmwgQhvXFlZC0g/bdxvq3eVIoy934cap7XD/OQDWyeAy0ein2PxA9N/22ql9qT/LlfYc0r63St0zuza5BQjCdyeBfeZsDJeXZRmdlGm6KdH8hd3greTMufEkl3TOzWtpFLeZqSjy4cQ9zatea+IEk0wTbUwDOBLhlQQKlQC834bU+bZ8wK/R6jfi/43XjWwaFjNNymzLNgrR39wD+AyqJZxMMQ7M8owbJXoXaiCe0qhokNazupdLtHH6D77igJbBrEgHr2lEHLeWQLvWxx000LkRiq5lLuciCcMGIjxZY2Dxj8TZPlVwmvYIH1qs4YiBMMMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz+6fDX/tpVCOhisCb3B49zCwzIk1ZgUcrcNuQeCHWc=;
 b=RJo259pAJ2j9IC36Oz+T18AlTYND9jBpELsoeY6kD7FRE4CYL+an3eouIj/EIbkoZw72U2p2q0FubuHWz//POW2GmzJZLKqfBzUJImm+qOsymX6DxOC4D+JoIkwNrMZcLx94enB2+8UwL1zn3tIZCERxp+thbc+nZ2zmF2EANVlEoo35pqE/GhvUenAFiKruKFiT5LvWi9PjxKtfDa6QM7Kk6ePIz2cZKdPwNM0q3gNgbSyq4Ely4z5ZDRP053MZWtV57NZ+yTMPbjBE4TlOKQOoFVaR58l1zSxPMFYby1KexzifznYAuR15Io+AQJoS8qYhMLudCe6wU0EzVjHPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz+6fDX/tpVCOhisCb3B49zCwzIk1ZgUcrcNuQeCHWc=;
 b=Vxtk/gtUoabjgAWOLHi5lTuJYeyRkYVo7+OvzcSgIz018ZOzsA83rfwMZQ8oNpq7UGc+QcW8HVHdz9JOie2dwjPks92/Bf2NaXOt0MnTOoq9R2FI0vq68FseOVs5kYk10XBroZvwxe3zA0yS9nF89d0oxgDYSiEKLGQbBBBocB0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1943.namprd11.prod.outlook.com (2603:10b6:903:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 14:05:21 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 14:05:21 +0000
Subject: Re: [PATCH 1/5] spi: spi-zynqmp-gqspi: fix clk_enable/disable
 imbalance issue
To:     Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210416004652.2975446-1-quanyang.wang@windriver.com>
 <20210416004652.2975446-2-quanyang.wang@windriver.com>
 <20210416125558.GA5560@sirena.org.uk>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <03f4152a-e66e-6b4a-5b4a-5f79f9ce2302@windriver.com>
Date:   Fri, 16 Apr 2021 22:04:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210416125558.GA5560@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.2 via Frontend Transport; Fri, 16 Apr 2021 14:05:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2cd8ade-cdfe-4177-e0fc-08d900e0ac1e
X-MS-TrafficTypeDiagnostic: CY4PR11MB1943:
X-Microsoft-Antispam-PRVS: <CY4PR11MB19435B74106B89AB0A7D674DF04C9@CY4PR11MB1943.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDIZtNb0fgNeRg4C2yyEaM+y23k27FLHvHoNx/S/ZXW6QQwqE2/wSTzPDQ2Efp3QXEdO+uGTzVhIbi7iGQxqOjbCi8+dTPhS6l71SsjefLmesAXCy8w4caRNx23wyiBB+ORYoGTz9LXn1Zsw2S42bzc0t4pMzLbV0DlXnXK2mzDDPQN1WKJJOaOGOsMGjqI0LZ0CFkv1flz4aTzJtvdXymZ2jCW0JOWhjhuHT0EFnmWd9AHpBpng35yNpkqOznh28JZWRxLF0lliTlsl1FdBBeoenaCuMKUl1I43TwXPqA1cW8UDYxDy71ZTLKEQ6gB66JykWoeGIihor2BGcIlYiXgef4LG4Ej1PsbcS/hQThl1de7HQeU5IjjgunxkOyfxT+PGSBDWe53jxo+eleCW+CWzM4+gwRQVLeeF4IIYzZDTIbq3xFEu3a70mGqYxB6az1PQRYDXhj+OHKqHarrLy51T6DzV35oCNc07SubCIxPJSotHtvsdCz2Ld/4EjGzceDjytPqsWrVm9cs8mSA6TutXrzvAXhe57i6bTckspHUOJTu9g5dwoPawe4ejVzVRwJmB4RfwPaSRss8t8EX4LkUfxOS8B6G2bCa2tsFsDrOpP+Z3jMpWmTuFhdWZhMrEaxJVPDnPJ2P5JJ5me7bMG2CkcON7h/21qMK+JxqgD+bvybnJ0EyyqHnmb1e3OIZJzkNM94t+F/Nz7Zt2kMobvIGWPzdWfyRbkn6M4adt/wg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6666004)(6916009)(83380400001)(5660300002)(16576012)(956004)(52116002)(38100700002)(6706004)(66946007)(16526019)(54906003)(8676002)(2616005)(66476007)(86362001)(31696002)(4326008)(53546011)(66556008)(8936002)(26005)(498600001)(36756003)(4744005)(31686004)(186003)(38350700002)(6486002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?SGqGDOeMvlLCSa5I3KtbArt6sP9bkHXG9e9t6mVQ6S5/j5Iom+U1oM6i?=
 =?Windows-1252?Q?JVe6EswOeOEQFrqViGNseAdL3P5iHs1ZdOn4mqUCFYUUq2cnGOBXeOVd?=
 =?Windows-1252?Q?3CVoDaj1J6nt/vgRDl0mvdk33Cu0IIDkuZyl1QNK+b2C6ArU5iUP6HS4?=
 =?Windows-1252?Q?4krXADGQMp3QxAcxGIsMr5LnEuaWEREu1sUut0fPOlHLXV9yLu2tXqoR?=
 =?Windows-1252?Q?uqwaG1Tp1DN9aL9a+X0U2+M6vsfOyahKzL5kSeM7uOD0J98E+XtVcWoM?=
 =?Windows-1252?Q?o0/BXe1ZYCQz1eBL52YUzDQlmOUV8KIPI9wZ1g9MD0b+Za51Ki78qSZJ?=
 =?Windows-1252?Q?h1cTjBUmfBT8TQ2YuHo0GyZFkZIjNEpM0gNU62M8mIyS90DYldfO2/hs?=
 =?Windows-1252?Q?gcJcw9U4NaXMfgtKwM8rBD7J3hUzFZ2BETonaUv9ngy4W+RRsV13b6px?=
 =?Windows-1252?Q?6J7b9Zsxo1QSSR2h2Xq+eRUz/HbHNjYyFui5g6e0yAh81u4e5HMGTAye?=
 =?Windows-1252?Q?QFewE7zsl1Bch6uIv2vErZq5f2RyPAAWqEglhYslcAHs+hA+bKMQ+Hm5?=
 =?Windows-1252?Q?ElYX1JKRO4IGYDGjJMhBTRRO1HBRKbodHd4TrmhiIgAgAoLjxaLKm3ND?=
 =?Windows-1252?Q?kGGHA7xVHyrmZZeF4cLJEG384eoD63jkXBSH3sJzSwEPvc94rsl5OE8v?=
 =?Windows-1252?Q?kLR95QqZELjdtvcz2fUwzya/FW84qqL4p/ePKpT3zayppR0i8l+SZ434?=
 =?Windows-1252?Q?t4zouIsVWV70wykG0m8vZKE8v2r3oKwtTMggdAmqG/OV/DyrduGmn4CI?=
 =?Windows-1252?Q?MGgP96cTmaRZeOJJepgeRtC6Zo8aJA12yg/OfkEhJmA54SR51wk4OxmJ?=
 =?Windows-1252?Q?pjoDNyiMaIwB6vhqFFXIk8NPGyNY5nrfJ9PZ3oEQQCpq5LQbV6X2czsn?=
 =?Windows-1252?Q?isXJqAIFDr84sHHSdfEHAWBn9kMj3tCWA3J7mPUYyFzWwFI5JUcYEI8b?=
 =?Windows-1252?Q?Xm73IKwvg87V6g8teHIqteQKbsDFGeo/GNy45SpA5HtJzfhUJ8cHSxhZ?=
 =?Windows-1252?Q?q77rap7ABfLUjIYkKbWMZG0jADSCp09MmA4NHLFEn3EcPPJCIC2a5wmi?=
 =?Windows-1252?Q?VaTyHwU6LVLcUGrAFBf12MPiSxZBBoJntlZDcYLslGBcl71SO0fjVrdf?=
 =?Windows-1252?Q?6eQJT55TNT5PbV7UTLz4U1CRhm30Wz/fRag5wm7oGvp44o/6IUHQsHin?=
 =?Windows-1252?Q?1XD01MONU8oKt1+3CUTK/T/wOpXwJ2EK2K6/Yff2ve/08bQC4N62wcjf?=
 =?Windows-1252?Q?/JGvUG1lNUICAM/hFNvKKExsgm/Vnst/VZ5EW8/lUrUBypS9Wgs40yfr?=
 =?Windows-1252?Q?GMbc6ly9ptqfi+E+i7k28WWDNRltWmVYydACQ8WtQUc1e5/JDxILMgaU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cd8ade-cdfe-4177-e0fc-08d900e0ac1e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:05:21.2873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t92qfQv2NldCEgKtnWZMngRMozrxt/R2qwMNelqsfi248zaX2+8ASDmBI3qs6g7kefMYKFocNt1O+F4GOk9i4FqPdNqvQYIIM6MyJUd2Eu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1943
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On 4/16/21 8:55 PM, Mark Brown wrote:
> On Fri, Apr 16, 2021 at 08:46:48AM +0800, quanyang.wang@windriver.com wrote:
>
>> Since pm_runtime works now, clks can be enabled/disabled by calling
>> zynqmp_runtime_suspend/resume. So we don't need to enable these clks
>> explicitly in zynqmp_qspi_setup_op. Remove them to fix this issue.
>> Fixes: 1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")
> Are you *sure* this fixes is accurate?  The patch (and several of the
> others that flag the same commit) doesn't apply against for-5.12, though
> at this point there's not really enough time to send another pull request
> so it doesn't super matter though someone will probably need to help out
> with stable backports.

I am sorry. These patches should NOT be with "Fixes" tag since they base 
on the patches

which are not with "Fixes". May I send a V2 patch series which remove 
these "Fixes" tags?

Thanks,

Quanyang

