Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290C43CB8A8
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 16:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhGPO3h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 10:29:37 -0400
Received: from mail-eopbgr1410042.outbound.protection.outlook.com ([40.107.141.42]:62784
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233115AbhGPO3h (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 10:29:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0oTYoEJmCpwAutTDgWirkyo+xQw1PocgqhiMNJiLqXztB/Rq+TaJuvuiXUqujEPNlLBDNrrnjX2Wy3W4O5W1zpn6Qv/MX/0LqALp0DSBGD9AvsUDLCiakpabSPsFsLArlz+aAgAkQUX+f3w3WYwx83+sG/1/FN5jiKNllK0EeiVTWmNjxdGnE29x2IoojdugEiA2KH9/3kxGKcfp59knZbjjVThffBBhOUGf1+tFYqNf9AHQkxfu0au6zAxmWFfQugwzUpUFYgsh+TTOZ0KL9F+4z7o+4vhQgZ1dH6va0sbkKcB+irhQuiGpBxY6cDcI/dyiGOLRYAY4+0zmhHAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfcUnqzJDWL1P9uxMqRAqy3ItcHPevi2rJaIEanqv54=;
 b=lZKuSNpz3WQklNmPu3qnYARBhL25aDEHE0jg+hAr4C9/cZjIeN8kb6+wMwkvhxBzE5r3jsKt//uRJzrgXsrg7M+ieBtP4VeoVVze9Q0S1OSVEn2EU0B69CGmwgnaq6veXW96WAtIQ0aEp8deRbiZTYOCP6Z8VIuyFiilB2EOcR5Cl2nFTwef4xGep8tHMs5+64RN+R4T5E1Cl/WqYP/2qcJ4V8COCW7ZjaD6+MljzaIYi1J3XBByCuOstK+qO4maDbt4kJVSKAeICPni/evRb7rVZunb+LAVk6effOTJwrWyUd4s7kRQTgMeKNAnmVdFLcOdbkar/W/dFjtsumOHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfcUnqzJDWL1P9uxMqRAqy3ItcHPevi2rJaIEanqv54=;
 b=VNJCguyoHhVe1Q0OiQSxNMa0A2UZ8tBMj6121YNm8MybCo+SMmWIztsguTv6Sm7OofkELlcLhaeobmVECxZG0e5bYF5G5pGpVboqfWzyqwqyBmO4j7VDtX1v7Umae4zkzogrra9IeC/3I64ecTiJiuV6tAhDicHCLZDv3WCC9LM=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OSAPR01MB2945.jpnprd01.prod.outlook.com (2603:1096:603:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Fri, 16 Jul
 2021 14:26:40 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::94dd:c412:338:709e%5]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 14:26:40 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Mark Brown <broonie@kernel.org>
CC:     Yoshitaka Ikeda <ikeda@nskint.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH v4 1/2] spi: spi-cadence-quadspi: Revert "Fix division by
 zero warning"
Thread-Topic: [PATCH v4 1/2] spi: spi-cadence-quadspi: Revert "Fix division by
 zero warning"
Thread-Index: AQHXee+x3FoA8gJXskOlTO0d6TpkO6tFhsiAgAAihwA=
Date:   Fri, 16 Jul 2021 14:26:40 +0000
Message-ID: <e4ba0b8b-93c9-9e41-a631-4f3ff46cf120@nskint.co.jp>
References: <d3deb78b-fb30-ff37-bc9c-2ba7b8b40c36@nskint.co.jp>
 <760be709-74d1-14cc-fecf-433786e123aa@nskint.co.jp>
 <20210716122305.GA4137@sirena.org.uk>
In-Reply-To: <20210716122305.GA4137@sirena.org.uk>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: nskint.co.jp; dkim=none (message not signed)
 header.d=none;nskint.co.jp; dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dc2788d-dee8-41cf-d039-08d94865ba9d
x-ms-traffictypediagnostic: OSAPR01MB2945:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB29450A27F0B719F33A7755258B119@OSAPR01MB2945.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0CG8UE9PU+WMGjj+IFruIhfLXsEPKSzidrRkuZnjCjoAnuuMelNxYsCrKC4X4mK/cgNQ8GwTYStQH0S1K9bim/yfUfCTHNHbYNdUx6j2b3TpjJN21hI8MTkvitmVafQdNzW3ivrXZkZ/72VWy2Q6f9ctCfF8sGfmA/MkKartCPws/MFIiSIscbZ/63+wNN9opnCcwaR+beaX33fgPgL/mrQsqY6fNk0iqwhu9s2uO5Ld/+dJxDDIb6tph4ndQDNci+hcICoIS6irE/3QXLhosZAGZfNKZmNyPZapOUldZv21RIhuSOANXi9hKcog5VtzR3NBZbBrlGM1LMjr1NLr34MqyHLyNNPRNQmA1l66sIM8F94gLEgTxCCYm5IWwPa9mNE3V0TmzXwwaaDTK6G5iKl8bJ5fMQD+MWqGSjAlPvbRs6WpsAWTLLL22qLD1Vf5/GNcNdyB1EVtubS+ayDVMPykSH1aVO05GpFKVWBIJSLpDJcgaOrptrM6Zxm8b7CHEb5QjJC9QcN6I8c9zg5jXVGbnZAA9aEg6UL7fV4Pn1d7PaS4ZePhN59E9o1UIlBNU5lyz0P4r1sFWptFezmxMekgemyVpCOcBg3mKC9DtoWy2Cm103Xedkz+oSkxTmSNf2QGfyQ3q67QT7/iruUVhyQ0UiVNhuAN9BCqmK0xhIEv9rlEYBKlJNuDNfCV29QWO1z14r9FLdu5bihXynVjfRaIR9eMga5jeYR0IbinFTIduwczJYl8uXnkmJI7+WybxD+qBWxwKgDRP/xmcHvNmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(31696002)(8936002)(6486002)(86362001)(71200400001)(107886003)(54906003)(2906002)(6512007)(66446008)(66476007)(66556008)(64756008)(38100700002)(122000001)(36756003)(186003)(31686004)(6916009)(558084003)(508600001)(2616005)(26005)(5660300002)(4326008)(6506007)(76116006)(66946007)(53546011)(8676002)(38070700004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?amZPWXhHd0hXR01wZ1NzVW9nTkJyVzRucDZaVGhmT0RNVFhDMGc3MXBj?=
 =?iso-2022-jp?B?eU9BWlJDcTllT1JZa29ZSmErU0ZTaXNhYlNlblVsNWJ2NmZyWUNEZjdn?=
 =?iso-2022-jp?B?MU9nVXdFN25KQkp6ZWtSUDdBT2s3c3dWK2VTcVR5QzdrM1hPaTd2TEN3?=
 =?iso-2022-jp?B?TCt5RElWeDlmQ2FYaGhxTjhGd0V5S0h3NlNvR1NDem9EYTFZSjZCY0M1?=
 =?iso-2022-jp?B?b1RXcXVzV3ErRUlDOXdWYUdOUWN5aXcyVUhtemhSK0tOWFhuSGZZVFNB?=
 =?iso-2022-jp?B?UVFLSC96aDlyNTZieml1RnVzbGpaWTdWVlVhbXpTNXRoN3orUzhGQ0JR?=
 =?iso-2022-jp?B?YUNxdnE1WkZnY05GZkU0eGxnZlJUang1ZmZLMWRnU2JhUVZiSlBLb2NP?=
 =?iso-2022-jp?B?OHYzQU41K1dCZVpDN2FCQ1Y5WGJtSE50NlFibWlSWEtxVVY3YUh2NE5J?=
 =?iso-2022-jp?B?U3M3Uk9tZGRjeE1mOGRNK3pSQXhpQVhaRzBaaVF6NjIyS0thM2VtRWJ1?=
 =?iso-2022-jp?B?NmhDaElzMVVBM0NVb0hGZCs5cHNDbWJUU2pERlZaV25RY0w5Zk00d0g5?=
 =?iso-2022-jp?B?NDYxTkNuYldtTWNLOWduVS9WNnM5QW50Q2U2dEU5WXE0eWNCY01yY1pU?=
 =?iso-2022-jp?B?U3laZEM1Z1RoS1B0U0hLK3FDOG5Mdm9wUGNjRUZIbWRCbTNXSitUbksv?=
 =?iso-2022-jp?B?YktvUklhalk3UFVUeFc2UlJvWDg0MXA1S09oSlVucGt2QkZhMWdpTjM0?=
 =?iso-2022-jp?B?ekh0dkM3YjFiMkFCYU1MVjFWL1EzS1h4cmsweW8wekFtNm9SbmlHcDYr?=
 =?iso-2022-jp?B?YU1NRHlRYWtIYUNxK1o0QUh2bnZSSW15NUhTRUlZc291NmxXU24xcU9R?=
 =?iso-2022-jp?B?bTFHZVQ3VExjMGJQQVBjWkpJVmo3dFpvOFVudkVYYkpQaWd3RGNRTnMx?=
 =?iso-2022-jp?B?MDlRMWg4VkFEbmtpbnJjaG4yTmVlVGV0bHpTc2FMN3A3U0VLU21Qc3d2?=
 =?iso-2022-jp?B?NllJZ2tDR09TQ0h6YUhpL2pFZkhlNjNxUG5VL21XQ2RGcC9kNk42U1hl?=
 =?iso-2022-jp?B?VXY4VXB1R3F4cEI1K0NSSyt6ODJ1azI2ZHhJVGszcmhZUHJvSk1DQkpa?=
 =?iso-2022-jp?B?NDFRNmJYd0pEY0VmRi9MNkMrTkM4ZFNobC9yMkhpZzRiSDFQbTh0b1VE?=
 =?iso-2022-jp?B?Z2tJUEs0TEdaRUlvNm1vWW1sL1Vhd2FaR2o3ZjdHMmFsQ1l4QVZKQjNE?=
 =?iso-2022-jp?B?Z0YyNnlINU1lcDdoZTdKWXJmQ1JjYUxDVkY0Y1FoK1NRazVYRmZ3OVQ3?=
 =?iso-2022-jp?B?M0JKWHFrVFEySlFvbWV2czVzMnRjalRBNkh0aG1FWFd6aytScUR3QTVU?=
 =?iso-2022-jp?B?Z2t0dDJoM3lGM0F0Z0Y3OEloWHFjaVFueFErekY1Vi9JUkFsUlpCZzVC?=
 =?iso-2022-jp?B?em55OU9ER2diMk5BMEZ5N0VnbjczbnFKM3RSVXd6RnFDOElLM081NFky?=
 =?iso-2022-jp?B?eml0VUdzZHUvb3gxUjl5ZWRuR3J3cFpWUEhYa3ZyMWF0ZTNxS3BXTWhN?=
 =?iso-2022-jp?B?Nlo0dWtLWlpXeGxnMWNQVEJJN3QxeUg2VXI3aSs4SW1XenNFbjhkSmFy?=
 =?iso-2022-jp?B?WFZEUXJrOXdBSkZQRkU4bWdnUFNmRWJCOEl4Qy9jZFR4YkdpMnpTa0JD?=
 =?iso-2022-jp?B?d09WVjl0dTlSd3Zxb08yYjFWTlBkb1JPUGVBSmhWQW03OVB0aGIwMlpy?=
 =?iso-2022-jp?B?M3dia09XTjFwTi96WHUxZ21YNGF0eGhQc3dDM3BVRUJ1MkxFTm1uWEE3?=
 =?iso-2022-jp?B?UHpCa2pmL2YrZzBBUkxoOTN1aU9QeXR0UCs4a1Q1emQ5QVgrWWp6Y0h5?=
 =?iso-2022-jp?B?aVdUbkZ2QU1ZZndJeWFOTUs2WFdtK0dva09BbVIvSGNuRHVsVHl4Z2Mx?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <311D982BB0AC3F4099DE5197C4FB4FCF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc2788d-dee8-41cf-d039-08d94865ba9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 14:26:40.8730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yn4hLGBsoNQbni4hpk/RcuAt52DD9yoFOKKGKu/HHpxZdvdFQZ+rBlxaCaMcH7Yg0TCUL+Qj7ykKJg1VDU/Yyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2945
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021/07/16 21:23, Mark Brown wrote:
> You've not provided a Signed-off-by for this so I can't do anything with
> it, please see Documentation/process/submitting-patches.rst for details
> on what this is and why it's important.

I'm sorry, I was wrong.
I will resubmit the patch separately.

