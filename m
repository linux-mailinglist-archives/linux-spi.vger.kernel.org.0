Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3DC359180
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 03:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhDIBeg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 21:34:36 -0400
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:21725
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232967AbhDIBee (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 21:34:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXcfnEXFA4EheEn2pZCVbs/lJ8bPU9k89NWJj4UvJ6ChEEZr23kPKKKjq6k7ws4iMTZ46ko2XEoFHVaQ0kTvCnaeADKyvwIZrlfzvY54SzjNMKJqS8ed3yGA4SI24o5QOkJNtJe9boSJmkNdcC/VKF189xynKb10OqnruOfXum2+01r/4bNp6dDvPXSiIl/L2dWJgp/swrvRMEXWkZExndARwkV2dO51uLaZCwci2dypShl4hF3RHRLkyKUBvy/oaabujQqGKHrGN4eOoRypIM5ZjhAO76BrcXMH76aW4KyOnk5KeSFadu9/QZ+TwJ6fd2wNovLueI5jw91WbeBQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBGaiql4fBwuCYkvdS9gUfD1R4aADZ9DqnNvFv4VXl8=;
 b=FPsn8L8WKr3rYHew1riT4CwoIwfwaLZagSYusAVcbkywQQKiVjCnXCS/eHAeoiSJ4SqbLIpbH2v3dj8HHJiJh7fWPiOdPWUXWL9yethiHp/TU+fBeOrdhrnPkJyJjGnpvzHpkm6nVvnDd20ed1aGzoGRPz8OQxkb1P6ouzorZi4O2+6BnV7N8UgzEzz56d7nWgqNtKuSNPyihMjA4XwvybcSVQDq/YgCmJZs+FAiX8jBZeoMbtYIdySQ6Bpfb96HCRVV+NgSZsGQK9HwyfbLZm5hVQjbFTNEHxgn7019Fz7SOzNOSNJo1W8phVapNgMcJKMNruKVvEHmubPTE7WroQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBGaiql4fBwuCYkvdS9gUfD1R4aADZ9DqnNvFv4VXl8=;
 b=p3IY21aaE50ZYm08VzKQKdJ2Na8umQscB0n12SUDtaKYyn4SS9p0cOnpnb3ulR5/BGOlXJtI3mbxU7hf6S0GgCwNVCYecAEqEX2UEnR2DEEPM2OHzLXLKMjYc47C+shDvgfYPaW32bXv8JUBgcow5Pwc03GB/XvyTNOyOOOraeg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1557.namprd11.prod.outlook.com (2603:10b6:910:d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Fri, 9 Apr
 2021 01:34:19 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 01:34:19 +0000
Subject: Re: [PATCH] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
 zynqmp_qspi_probe
To:     Michal Simek <michal.simek@xilinx.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210408092559.3824-1-dinghao.liu@zju.edu.cn>
 <17b5d33f-ce96-dc07-05f7-41d87f53a3d0@xilinx.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <ef4555a6-1674-d9c0-6401-cdf43780a014@windriver.com>
Date:   Fri, 9 Apr 2021 09:33:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <17b5d33f-ce96-dc07-05f7-41d87f53a3d0@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::28) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by SJ0PR03CA0383.namprd03.prod.outlook.com (2603:10b6:a03:3a1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 01:34:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b7351ac-ccf2-4dcd-fcf8-08d8faf79803
X-MS-TrafficTypeDiagnostic: CY4PR11MB1557:
X-Microsoft-Antispam-PRVS: <CY4PR11MB15570B14518FEAAA84CB521DF0739@CY4PR11MB1557.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfJEeaN5smcWPTYhmJzU5geaDjHq7IuwNUU+o05WBq5qvNFqvCCcCeY5Srkx+PIrvzOR6QHLmGW+9t6V9I7gIwAqzb1eUDZe9kbqSuJ6R8zWF6fcMkxXIG1mFslumQvUEy8ueAZLr2WJZrQpk3KKFIIRqxwHPaY2DZUPE/Sjxn/Grnk9NKxz5T5efxY2a/8e6O433e4IKiitBstcG/awomhySRD+HfMKF6nPUJMqUMLD0hdt1TsLjCoa/x7GywS5Ts2Yx7hJX8onjlWIUW1vU/FaKnJ/64hM3issBiAKdKDHWxEcC++JV8Gnd96rImrMcaYUh33SNHlFFPDQS3ZcZ5fvCcIrWUhH+SG1nuUz1iqcfuPfQmifBZyhxhjM1GN8WiSCTa9bk0XwZeHwPdvfW68b0Xd4MKy/+pOTVw1wqQvt9ciD4n7K3ZueaMHfTixx6CUzGn34B8KQinB13P9+wS0mStdtWjbnkh59K24tmuUHM0G9yJIrknoP5rS6C/T4H/6QyBlSf72W4Y6MmAtlKBVQMyE4sVOzi3l2nyEZBdu+aYz4Qw2HLfApuaxNJ2G6peLb6+faAFYUXLiFEXFzeQVycUDF/ck3TyKDS8Raf1A8WaZGzCRyz8kjTnPDiiE+qC2dLAaonyAR53iNKL1desyViX0vwZuftcx5KC8qfK7mdKfvnUiGRQVaErHZ6mhsPohGAdPAXBhEXbrXFoQsFKmdGA9jrUAmTJgkaEKC/BV4Bboh9VoOy7W9ESXqA6xsbgqrsTt1cbeuQyp6BgQfjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(52116002)(31696002)(956004)(2616005)(5660300002)(86362001)(4326008)(38100700001)(83380400001)(8936002)(66946007)(8676002)(31686004)(478600001)(66476007)(66556008)(6706004)(316002)(16576012)(16526019)(26005)(6666004)(36756003)(186003)(2906002)(110136005)(6486002)(53546011)(38350700001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S2ErNVVvVUxEVSttS2R3VGtUWVllM2J3VVlET3VHbjlkd2NTVVpzczNvQlVt?=
 =?utf-8?B?RTBId3J5clFmVXg2eVhSQXNNUWpPWXNoUzg0U3k1U09KUkIza3dtYXdaZ0lM?=
 =?utf-8?B?SW9sUFY1Y2JFcGsxT3JpTkJyQ0psa2hzMFJ4RCt5Sm50UUE4ZXZUSHExWkJr?=
 =?utf-8?B?WGhid1BPMlhEbEdRcVoyWSs2U0JoRjQrZGhyUHVTbUl0YVptQVJqUS9jOGp4?=
 =?utf-8?B?V0RKTXlnVDBvd2FRSHJXdEVBLzlFdTVVVDIwN3pnZ0YvallEUGRUSDdjSzVq?=
 =?utf-8?B?SnpSZ0QzR2ZKZTdIZlZmZ0h0WlljaEkzLzIyV2hycm9vSzFRS21rOU1LczlN?=
 =?utf-8?B?dkNPNkZwWW5WTGdLQmx6OFllQ0VuZCtuQ3lvUlBsbnlMNDVLUDF1eEt5Uzdk?=
 =?utf-8?B?emlaZGljbTVIbmtmS0VnM3FONHZXczBSRFhTRXNRLzBGZDQrWnJUT1kvOFFa?=
 =?utf-8?B?aHVzT3FHaWIxN2JwWThMY2s1aDBwL3pOYnJWWmt1MVVpR3h6MmtXcWdOOEZK?=
 =?utf-8?B?R1VDb1JXeVJFNE1zemlFRzNDUkdoYUJpMVdMYXg0enZFbDBKYVZHNDduTFZ3?=
 =?utf-8?B?L0hrR1cxVzNLbXgzS1dRamhJRTdOK2VOU1RuMnVYbEY2TTZxTWZVbnJZeWVn?=
 =?utf-8?B?Szc5a0N4Y2hTd0hKL1N0MUY2c0ZCQTFrSE1kWEJQcG4wNjNhbVM2VHRWYnMr?=
 =?utf-8?B?Q3kxQkdFYVVhczY4Tng0bkZkb0pnWWI4ZEhUTkFjMlkya0Z3c3dHaUJaczFO?=
 =?utf-8?B?RHF0KzZTdkl4MDVrWDhxZmdzY1VwVk81VCtNSmUwWEJ1NHFVTWlKS1d2empu?=
 =?utf-8?B?b25USjBPZk1BaDFpbUNTMmc2VEowN2dacmJwRFRtNFhYL01kUlBzc2dFZWxE?=
 =?utf-8?B?K1p2S2E4T2xjOFBjd3RCaENtbTRBRnJmRllJWTRyZFdDSlBhS3A0K3ltQ1hw?=
 =?utf-8?B?d25CMDR1ZFRnZmF5MiszTUNKVnNWQmlicnVieGR3TzNJMFJQSmtUZGI2TVhD?=
 =?utf-8?B?RmkzNmJCODRZdm4xQ0VNeVdWUDJhMWIzWWRIRWNwbHNzdDIwdm5FcTRVV0cr?=
 =?utf-8?B?bm45enY4MWg5cVIva29IY1VydDhQRURveS9ycmlNenIzd3RCclBqR0tzOThT?=
 =?utf-8?B?Ti9ib0dJWDF0YmJvMjNabXhjeTdxaG1laTJ5MTJCUTVKMlA0aWFCRG9nUWRW?=
 =?utf-8?B?OGlrWVpUblpFNEhEOFJKWjVILzNHaEREdWZwU0dtYjdkdk0yRlRjVjZ1NUxI?=
 =?utf-8?B?L2hSaUhvUFJ5T0ZQM2c5aVFPK3hNeklndUI2QklWMklxcFA2djQ1TnBCbTRw?=
 =?utf-8?B?ZXV1c0hqMEdEUlFmcXg4bTVKVkJWRmdMVk4wSU8zU3VPSnpYTzlFYWZuNHRy?=
 =?utf-8?B?ZzU3NlBqUHNDdmR3K1I0ck5ZYnkzL1lNMFlKZm1mWkovc0dLQzd3c2E0dThF?=
 =?utf-8?B?Q2pIcDlJK2JaU3pvL1hmV3hna2ovbDFVaC9Ec0cwMGFTWlhHb0pFWk5HeFNy?=
 =?utf-8?B?RGRzRjVCT0d4d1Bya3AvU0pxQUthRTVUeGRJczFOQ0JwRFVvR3hDbUdBSFFU?=
 =?utf-8?B?UFd0ejdWdTVZK3NSMjlyN1g5d3MzdTNiaWp6WHFCOUY0VElpVVBYVDJ5cHIr?=
 =?utf-8?B?MUlVVVA1V2w4ekZvdDJWTnlIZXlwelo1WmpUQ0xMN3VMczY2akxpV1B5dDJW?=
 =?utf-8?B?MzdvZ3BYZHlySDVhODN0am41TzEvTjhsaXYxNEI5ZUpTVWY1VnRmUXVhSUlK?=
 =?utf-8?Q?DE45jzEHQbsS0WIFzfdrAJvlU2PgIYFIKFE9zQf?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7351ac-ccf2-4dcd-fcf8-08d8faf79803
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 01:34:18.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKuFk3JuwXcENPHaQa6S4dujFKNsDfd/blTkVdl3qlnjYz9eXqPm2zdoIHRXvRIuko3PdJ7KtDQmzNwzCDgGy427hE5/XspBU1iK/fWy8kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1557
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dinghao,

On 4/8/21 6:33 PM, Michal Simek wrote:
> ++
>
> On 4/8/21 11:25 AM, Dinghao Liu wrote:
>> When platform_get_irq() fails, a pairing PM usage counter
>> increment is needed to keep the counter balanced. It's the
>> same for the following error paths.
>>
>> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>> ---
>>   drivers/spi/spi-zynqmp-gqspi.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
>> index c8fa6ee18ae7..95963a2de64a 100644
>> --- a/drivers/spi/spi-zynqmp-gqspi.c
>> +++ b/drivers/spi/spi-zynqmp-gqspi.c
>> @@ -1197,6 +1197,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>>   	return 0;
>>   
>>   clk_dis_all:
>> +	pm_runtime_get_noresume(&pdev->dev);
>>   	pm_runtime_set_suspended(&pdev->dev);
>>   	pm_runtime_disable(&pdev->dev);
>>   	clk_disable_unprepare(xqspi->refclk);
>>
The imbalance is because pm_runtime_put_autosuspend is called to make 
counter to be -1.

It looks strange that there is no counter increament op before 
pm_runtime_put_autosuspend.

In my limited understanding, it should look like:

......

pm_runtime_enable

pm_runtime_get_sync   //increase counter to one to resume device

DO OPERATIONS HERE

pm_runtime_mark_last_busy
pm_runtime_put_autosuspend   //decrease counter to zero and trigger suspend

return 0;

error_path:

pm_runtime_put_sync

pm_runtime_disable

return err;


Am I missing something?

Thanks,

Quanyang


