Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C3A3D0930
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 08:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhGUGJU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 02:09:20 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45778 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234144AbhGUGGm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Jul 2021 02:06:42 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L6jZQw031364;
        Wed, 21 Jul 2021 02:47:03 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-00128a01.pphosted.com with ESMTP id 39xd2fr9m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 02:47:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQPxxFsnJdnJVqFyY3fsYWPCTjuJl+H9z3AvcKysCZ7POssRoxhhswSoSMXBG75GTeW5wM4u2kwUbvLysgQdYOKlC86mpjt8iBoE+O1AEs/e2JVZue3y/R3iSwCsT1SsC3E64NU/f1dtSrtTnV7C/6WARkfKgZeZv2Kvqv2KocAy7eIoFK3Y7HvM+IfusP5f6ZVF1ebLU99b+ABJnlFFTC9kRsFnG/Qhu1NGY4uI2DtcWpKdNNjSeNoNOTBABTl9hPojsAbX5uJiv82dd370G+rRODCS9Hdi7rP1qdHIW2MlADhZ/iq91dYKlYtCO4u+aJ4i6dNH2zW6XhHCOmgqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN0Mg3YRP4nGz617uFTkO9RpNF9v+fiDnZve0ki3Hfg=;
 b=mR6+SH0g78pzfPObmwpcP6424+2PuzOCEX2gWsLCBjY4qpZ06Q83ZgLoVEQ+Vhz5uxiXpuCdN15eaZEdCl0bFd6ZT8a/b7GpPl/lGWpGqPtneUVLj5lt5seyRbFl2PuQQfIypkieYkPfA5YCS5MSWh82o0njHFMmhjHGmvrvh2K+8W0r4h+KH1CweCrGPf2+V7nBX3k75J/6CfbR0GjsPZVfx9ijXicK56T63NCT9uMQ2idn7JIXULx/uLpg/Tk6GjCtdF9jjBoFuz6WGAsL5KaDMjBc24ey8ona6a9gRgGYaJ9fp9IFgB4AxSnCy7/e8dN3SSJ5eIXGgjOgEZgEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN0Mg3YRP4nGz617uFTkO9RpNF9v+fiDnZve0ki3Hfg=;
 b=TKHz5mlMz/emhNknvabrTA9QHDROqhacJFXvnXRu1miPIHkmAHzTpbcGJZgpbOVku6h0kGvgar53d78AX0VMzqqUTu73C/wkvNbryGoeJN+MzHgfpiuGl5imjOY5OSheJDSy0/5oDw7gMW8Tgnmir5KoyAO1jF/uKHsY2U+dJr0=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6266.namprd03.prod.outlook.com (2603:10b6:510:e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Wed, 21 Jul
 2021 06:47:01 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::54ff:7b16:5fc7:38ca]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::54ff:7b16:5fc7:38ca%4]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 06:47:01 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Mark Brown <broonie@kernel.org>,
        "Tachici, Alexandru" <Alexandru.Tachici@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "nsaenz@kernel.org" <nsaenz@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "bootc@bootc.net" <bootc@bootc.net>
Subject: RE: [PATCH 0/1] spi: spi-bcm2835: Fix deadlock
Thread-Topic: [PATCH 0/1] spi: spi-bcm2835: Fix deadlock
Thread-Index: AQHXeoTE8zwrH2B1W0+h4LnGnXdUs6tMOpAAgADEiCA=
Date:   Wed, 21 Jul 2021 06:47:01 +0000
Message-ID: <PH0PR03MB6366CFFFF5846F7018FFA03699E39@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210716210245.13240-1-alexandru.tachici@analog.com>
 <162680680557.11423.14003826010912823109.b4-ty@kernel.org>
In-Reply-To: <162680680557.11423.14003826010912823109.b4-ty@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE56SXdNV1EzWmpJdFpUbGxaaTB4TVdWaUxUaGlOelV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEY3lNREZrTjJZekxXVTVaV1l0TVRGbFlpMDRZ?=
 =?utf-8?B?amMxTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTXpZek9D?=
 =?utf-8?B?SWdkRDBpTVRNeU56RXpNak0yTVRrMU16VTVPRFEwSWlCb1BTSldRVFZWVDFG?=
 =?utf-8?B?aWRHSXlVUzltVVRkWk1VcHRSVll4VW5oVWNqZzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVSnJka2R2TUM5SU0xaEJWMlZ2WVhvM05rWjRPVzVhTm1oeVVI?=
 =?utf-8?B?WnZXRWd5WTBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVUpQV1VkalowRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlNqUkJRVUZDYUVGSVNVRmhVVUpv?=
 =?utf-8?B?UVVZNFFWcEJRbkJCUjAxQlpFRkNjRUZIT0VGaVowSm9RVWhKUVdWUlFtWkJT?=
 =?utf-8?B?RkZCWVZGQ2JFRklTVUZOVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIw?=
 =?utf-8?B?VkJZMmRDY0VGSFJVRllkMEpyUVVkclFWbDNRakJCUjJ0QlluZENkVUZIUlVG?=
 =?utf-8?B?alowSTFRVVk0UVdSQlFuQkJSMVZCWTJkQmVVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZC?=
 =?utf-8?B?UVVFOUlpOCtQQzl0WlhSaFBnPT0=?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dfe8116-b486-457b-212e-08d94c135802
x-ms-traffictypediagnostic: PH0PR03MB6266:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB626686C954048B4CEEB67ED799E39@PH0PR03MB6266.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pC6mBGJIQ0GioEW/JfloHL/SUE1OIrP7e0rI/QcUDka1Fb9FRzXKMwUQoHsN925CnEG8Xq+X8q0BwdsvqwHGnGXX5aAYB9cmY1dn7U4J5Rsx+cKuC3yyNWuhM2xFWRPovCWHkuLv5P3l7KyIXPTZEoGm5hE5Sz+hyUVt+B97/239iGBYiIQ/hp8A/MfXi3QogWcfHaKj8fsQFXs0oiMNIJg9G/BS3tdG5VsSYV980DhmwAV9MGGLPCxnW01gswDOK3qxJAX38I43wl+9erl9qbVUY/i4fcXzBDVIpf3Wz/A9b/rhitYE5UbkoxNMknL6n9jAlBVZpS/uAhveeNPrvcBa1A59YjA0p+gGyEk7hCJZ51SzXbmDCm1IiTa9wHDG8F1R0qpADOlTy+9e1JlWNoXD3/VBwzjp0eMVLEbUhXGxiE4lVGRWxm3sItfn1GYirZjni7R7LA6eMvXvMv//k7DVvFxo0SUxNVYaTrHJO8OfSeZuepMZ2XJkztIZQbuZbCia2N/jV5qfft5wPeonGOfjIvlNTyi4FdkBJmI3eMPXoaYCgVZpvkm84/oLqIRdjc3RsBFU/APDYaD682XlwxKOfKvOYLHfTaHLSA6T1XZB7uzRxhb0HAR5VqFG6lfRcHXii9riGB8QLBH4ofap6VNshQxzbqcMdRvhO3Rnqd2xybl+yMXHzmYGMTik8tj2oi3aLzBBBMTVhZOQ7o0MzBAku+RMY5Q82wAz9L9rlXRcXHb+av5Wl2pJKvYRnZbNUfIJyzUrIgXTD6mWTiUA+/ZsmlZ41rg9+KErOYXjpXXnfkQWRJxW4KAZDwj3nfZok9vT4ATXyJ5CtYhTCiWDYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(71200400001)(52536014)(53546011)(66946007)(38100700002)(8936002)(64756008)(316002)(83380400001)(66446008)(54906003)(76116006)(66556008)(6506007)(86362001)(966005)(9686003)(110136005)(2906002)(8676002)(66476007)(186003)(4326008)(55016002)(33656002)(7696005)(5660300002)(26005)(122000001)(478600001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bldKaW8yMGp0UFJJZDBjU3REUXpwNUVFM0hRRVhjTk95U2FiNHdvTVhzT1F1?=
 =?utf-8?B?dDVNUkpsb3ZQTC9JV1QremFlU1AwT20vNStsU1FHMEdMM2k5OUJLV0RJQlNy?=
 =?utf-8?B?NkUrUGFSR1RrUHRUek9sak5lS3JqUnlCTlpnemh5dzh5ei80OHIvb0R4ZllU?=
 =?utf-8?B?RkZXU2ZGc3M2ek1nVzZ6M2djbElLR2NxN2M0S09oVDRsMjVzU0N0YW5HQk9R?=
 =?utf-8?B?UDFmc0FUUTRFdXIxWW9obHZ4MjMxN1RxSEtFQmJURXdxMEFsdEQ1cklCamZj?=
 =?utf-8?B?c1VtU2ZQc2tRbXBIekE0c0Q3RXF0YnFldDVZc2VQQm1tR3l4d2lQanBmNG4z?=
 =?utf-8?B?cjQ4VnpTUHM0LzJ6NnpUMUkyTi8yaXFEYzRZallaNzE1dGlKQXRYLzExTlds?=
 =?utf-8?B?VGFDV1lEMmJadTRaMElGQ0tBekM1YU1CVzRZd000aFlGVmJHZWlNMy9JOXZj?=
 =?utf-8?B?K2ZVdk9iaHppVXpUUDJuSUxRNHlmckVFdmxEZlBVaDdyNElMYnc0aGFldDZt?=
 =?utf-8?B?SVgwVzd6YkFVOFpmQXFSRXNrN3R4Wk42dFpzbjN0NHZrVndUZExXTVJmMUtZ?=
 =?utf-8?B?SFpiVkhMUmhLUDVndG5uNjdYc0VOVzlKQWxZZWV3NmNMOTJXMkFIN2pTQi9y?=
 =?utf-8?B?bzRwQmRyTTc5S2Z1UGloWFlOYlpGc2FvaUZKenF1NVp3ZmRFQjRZU05Bdnh0?=
 =?utf-8?B?WGlQSDNoZUJaRnZmbmx0c0prS0J4SzlTNHlEdDVJcXUwSHh0TVZtUGQyU2w3?=
 =?utf-8?B?Z3ZnZ0dhWWVKOW1PeEk0Vmd5eHlKR0FBK0VIQmNRS1FncmNyTVNPM0E3bkNQ?=
 =?utf-8?B?cURmZStLZEhFWUFSVlM5T241MndsS1JCWlBQeUVYN2JDSlBBMjVWQUtadkVP?=
 =?utf-8?B?eDcybUVJNEhCdlFkeFQ3RVczTHZUSm1IYXd1NUZJdGJQR01BZWxrVldoVTNM?=
 =?utf-8?B?amU1YmxzNlkrZi83cmRuWXB1TG1ZQjdUelAxMDRhTFRqY2dJbzQ4M1FXaGlP?=
 =?utf-8?B?ekFJNmhJMTZQMSsrQzNLNlpSbEJ3VjZaalpyL1g2d1FtSHp5clFVMVBWbnRU?=
 =?utf-8?B?aEZCUDhzMjVnOE5sN3RFSG1DZThQQmZFTHVaQzgvdVFEbGROekhSOWF6ZkRo?=
 =?utf-8?B?YmtNUExMQzkrK0w1YUU3dW1LUExrZ05KZzZwTnN5OTM3cEhwUWxTZmZ2eXhM?=
 =?utf-8?B?QnNGdFNKZ3Z6cFVwZnpGL1gxUVZoSkQrVzNMSDBVUUNTYnBOZlZWcGkxcU5Y?=
 =?utf-8?B?SzJuN1JRNlordFhUQ2FFblNsM3paVVcybFdvTTI2ZFVNSSt5VkRaajNVNDNK?=
 =?utf-8?B?Ymp4NjZMZXZLd3h2a0F0Z0FQb3BGRDluMW1GOHV5Vk9rM0JhQjNzWEx0UzZY?=
 =?utf-8?B?U0dXenR4NmtCWm5YN0d5ZnBjRCthUXpBS0NYbGV3akYreU5IekYyL1Jqbmw4?=
 =?utf-8?B?cTU0TG84L0QxVWhsNm05MTFIWitIVjdQYjgrMUNnMU9OazRmcmQ4c2ZBVlBS?=
 =?utf-8?B?SU1oS0p4VGFLYlpLY1J3UWxoSWhYeFBTYTdmV2lZUnozVUtjME42R3R2dnY0?=
 =?utf-8?B?a29OUjhYaWlrcXRqb0Zta21ZbzU5ZXVMYnB4K0NESXFsaENGY0xFV0M0N2lV?=
 =?utf-8?B?WU5wVGFRL2VCa2FQZENwZFpSbnZLZURkL2V2eEVNOFNzVVZPdVFKQzNhMlVV?=
 =?utf-8?B?bEtuWDk4Q1c2bFI0M3BXbUY4ZHBkbDFZTDU4TGlMRmEwaGU1T2lvT01XZ1BJ?=
 =?utf-8?Q?WlJ6tEMTrV2LIkn3av4/Euo+b5yLdFPpC/FrFN8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfe8116-b486-457b-212e-08d94c135802
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 06:47:01.3543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EJKzIRkk5y1T526yquMQheFwKtam3v0ITQ0/21CLAy1wCPycr8vvI2HhV5ZdVjfHRioVDFLnzilE3lGbAsmIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6266
X-Proofpoint-ORIG-GUID: CCZOLi2-fAJon2GD2Mw_DV1sY3DFC1AG
X-Proofpoint-GUID: CCZOLi2-fAJon2GD2Mw_DV1sY3DFC1AG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_04:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210035
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgYWxsLA0KDQo+IEZyb206IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4gU2Vu
dDogVHVlc2RheSwgSnVseSAyMCwgMjAyMSA4OjQ4IFBNDQo+IFRvOiBUYWNoaWNpLCBBbGV4YW5k
cnUgPEFsZXhhbmRydS5UYWNoaWNpQGFuYWxvZy5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtc3BpQHZnZXIua2VybmVsLm9yZw0KPiBDYzogTWFyayBCcm93biA8
YnJvb25pZUBrZXJuZWwub3JnPjsgbnNhZW56QGtlcm5lbC5vcmc7DQo+IGYuZmFpbmVsbGlAZ21h
aWwuY29tOyByanVpQGJyb2FkY29tLmNvbTsgc3dhcnJlbkB3d3dkb3Rvcmcub3JnOw0KPiBiY20t
a2VybmVsLWZlZWRiYWNrLWxpc3RAYnJvYWRjb20uY29tOyBib290Y0Bib290Yy5uZXQ7IFNhLA0K
PiBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8xXSBz
cGk6IHNwaS1iY20yODM1OiBGaXggZGVhZGxvY2sNCj4gDQo+IE9uIFNhdCwgMTcgSnVsIDIwMjEg
MDA6MDI6NDQgKzAzMDAsIGFsZXhhbmRydS50YWNoaWNpQGFuYWxvZy5jb20NCj4gd3JvdGU6DQo+
ID4gVGhlIGJjbTI4MzVfc3BpX3RyYW5zZmVyX29uZSBmdW5jdGlvbiBjYW4gY3JlYXRlIGEgZGVh
ZGxvY2sNCj4gPiBpZiBpdCBpcyBjYWxsZWQgd2hpbGUgYW5vdGhlciB0aHJlYWQgYWxyZWFkeSBo
YXMgdGhlDQo+ID4gQ0NGIGxvY2suDQo+ID4NCj4gPiBUaGlzIGJlaGF2aW9yIHdhcyBvYnNlcnZl
ZCBhdCBib290IGFuZCB3aGVuIHRyeWluZyB0bw0KPiA+IHByaW50IHRoZSBjbGtfc3VtbWFyeSBk
ZWJ1Z2ZzLiBJIGhhZCByZWdpc3RlcmVkDQo+ID4gYXQgdGhlIHRpbWUgbXVsdGlwbGUgY2xvY2tz
IG9mIEFEOTU0NSB0aHJvdWdoIHRoZSBDQ0YuDQo+ID4gVGVzdGVkIHRoaXMgdXNpbmcgYW4gUlBp
IDQgY29ubmVjdGVkIHRvIEFEOTU0NSB0aHJvdWdoIFNQSS4NCj4gPg0KPiA+IFsuLi5dDQo+IA0K
PiBBcHBsaWVkIHRvDQo+IA0KPiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rDQo+IGVybmVsL2dpdC9icm9vbmllL3Nw
aS5naXRfXzshIUEzTmk4Q1MweTJZIXNCdkU5WGRRVGdjUG5PYW1KVEFjWTgNCj4gNlBqZzVDdi10
MWFER0FTVTlJTy1KUWVJUERCZjVUQnVkNnFWMjZlUSQgIGZvci1uZXh0DQo+IA0KPiBUaGFua3Mh
DQo+IA0KPiBbMS8xXSBzcGk6IHNwaS1iY20yODM1OiBGaXggZGVhZGxvY2sNCj4gICAgICAgY29t
bWl0OiBjNDVjMWU4MmJiYTEzMGRiNGYxOWQ5ZGJjMWRlZWZjZjRlYTk5NGVkDQo+IA0KPiBBbGwg
YmVpbmcgd2VsbCB0aGlzIG1lYW5zIHRoYXQgaXQgd2lsbCBiZSBpbnRlZ3JhdGVkIGludG8gdGhl
IGxpbnV4LW5leHQNCj4gdHJlZSAodXN1YWxseSBzb21ldGltZSBpbiB0aGUgbmV4dCAyNCBob3Vy
cykgYW5kIHNlbnQgdG8gTGludXMgZHVyaW5nDQo+IHRoZSBuZXh0IG1lcmdlIHdpbmRvdyAob3Ig
c29vbmVyIGlmIGl0IGlzIGEgYnVnIGZpeCksIGhvd2V2ZXIgaWYNCj4gcHJvYmxlbXMgYXJlIGRp
c2NvdmVyZWQgdGhlbiB0aGUgcGF0Y2ggbWF5IGJlIGRyb3BwZWQgb3IgcmV2ZXJ0ZWQuDQo+IA0K
PiBZb3UgbWF5IGdldCBmdXJ0aGVyIGUtbWFpbHMgcmVzdWx0aW5nIGZyb20gYXV0b21hdGVkIG9y
IG1hbnVhbA0KPiB0ZXN0aW5nDQo+IGFuZCByZXZpZXcgb2YgdGhlIHRyZWUsIHBsZWFzZSBlbmdh
Z2Ugd2l0aCBwZW9wbGUgcmVwb3J0aW5nIHByb2JsZW1zDQo+IGFuZA0KPiBzZW5kIGZvbGxvd3Vw
IHBhdGNoZXMgYWRkcmVzc2luZyBhbnkgaXNzdWVzIHRoYXQgYXJlIHJlcG9ydGVkIGlmDQo+IG5l
ZWRlZC4NCj4gDQo+IElmIGFueSB1cGRhdGVzIGFyZSByZXF1aXJlZCBvciB5b3UgYXJlIHN1Ym1p
dHRpbmcgZnVydGhlciBjaGFuZ2VzIHRoZXkNCj4gc2hvdWxkIGJlIHNlbnQgYXMgaW5jcmVtZW50
YWwgdXBkYXRlcyBhZ2FpbnN0IGN1cnJlbnQgZ2l0LCBleGlzdGluZw0KPiBwYXRjaGVzIHdpbGwg
bm90IGJlIHJlcGxhY2VkLg0KPiANCj4gUGxlYXNlIGFkZCBhbnkgcmVsZXZhbnQgbGlzdHMgYW5k
IG1haW50YWluZXJzIHRvIHRoZSBDQ3Mgd2hlbiByZXBseWluZw0KPiB0byB0aGlzIG1haWwuDQo+
IA0KPiBUaGFua3MsDQo+IE1hcmsNCg0KSSdtIHJlYWxseSBjdXJpb3VzIGFib3V0IHRoaXMgb25l
IGFuZCBob3cgc2hvdWxkIHdlIHByb2NlZWQuIE1heWJlIHRoaXMgaXMgbm90DQpuZXcgKGp1c3Qg
dG8gbWUpIGFuZCB0aGUgd2F5IHRvIGdvIGlzIGp1c3QgdG8gImZpeCIgdGhlIHNwaSBjb250cm9s
bGVyIHdoZW4gd2UgaGl0IHRoZQ0KaXNzdWU/IEknbSBhc2tpbmcgdGhpcyBiZWNhdXNlIHRoZXJl
J3MgYSBtb3JlIGZ1bmRhbWVudGFsIHByb2JsZW0gd2hlbiB0aGlzIHBpZWNlcw0KYWxpZ24gdG9n
ZXRoZXIgKENDRiArIFNQSSkuIFdoYXQgSSBtZWFuIGlzIHRoYXQgdGhpcyBjYW4gcG90ZW50aWFs
bHkgaGFwcGVuIGluIGV2ZXJ5DQpzeXN0ZW0gdGhhdCBoYXBwZW5zIHRvIGhhdmUgYSBzcGkgYmFz
ZWQgY2xvY2sgcHJvdmlkZXIgYW5kIGluIHdoaWNoIHRoZSBzcGkgY29udHJvbGxlcg0KdHJpZXMg
dG8gYWNjZXNzIHRoZSBDQ0YgaW4gdGhlIHNwaSB0cmFuc2ZlciBmdW5jdGlvbi4uLiBEb2luZyBh
IHF1aWNrIGFuZCBzaG9ydCBsb29rIEkgY2FuDQphbHJlYWR5IHNlZSB0aGF0IFsxXSwgWzJdLCBb
M10gYW5kIFs0XSBjb3VsZCBoaXQgdGhlIHNhbWUgZGVhZGxvY2suLi4NCg0KDQpIb25lc3RseSwg
SSdtIG5vdCBzdXJlIHdoYXQgaXMgdGhlIGZpeCBoZXJlIHNpbmNlIHdoZW4gd2UgbG9vayBpbmRp
dmlkdWFsbHkgYXQgdGhlIHBpZWNlcw0KKENDRiwgU1BJLCBTUEkgY29udHJvbGxlcikgdGhlcmUn
cyBub3RoaW5nIHJlYWxseSB3cm9uZy4gVGhlIHByb2JsZW0gaXMgd2hlbiBjb21iaW5lZA0KdG9n
ZXRoZXIuLi4gTXkgbmFpdmUgdGhpbmtpbmcgaXMgdGhhdCBoYXZpbmcgc29tZXRoaW5nIGxpa2Ug
J3NwaV9zeW5jX25vZGVmZXIoKTsnIHdvdWxkDQpiZSBhIHdheSB0byBwcmV2ZW50IHRoaXMgKG9y
IGp1c3QgY2hhbmdpbmcgJ3NwaV9zeW5jKCknIHNvIHRoYXQgaXQgY2FuIG5ldmVyIGRlZmVyIHRo
ZQ0KbXNnIHRvIHRoZSBzcGkgdGhyZWFkKS4NCg0KTG9va2luZyBhbG9uZSB0byAnIF9fc3BpX3B1
bXBfbWVzc2FnZXMoKScgSSBjYW4gc2VlIHRoYXQgdGhpcyBwcm9iYWJseSBub3QgdHJpdmlhbCB0
aG91Z2guLi4NCg0KWzFdOiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4xNC1y
YzIvc291cmNlL2RyaXZlcnMvc3BpL3NwaS10ZWdyYTIwLXNsaW5rLmMjTDY4Ng0KWzJdOiBodHRw
czovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvc3BpL3Nw
aS1zdW42aS5jI0wzNTMNClszXTogaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0
ZXN0L3NvdXJjZS9kcml2ZXJzL3NwaS9zcGktc3VuNGkuYyNMMjcxDQpbNF06IGh0dHBzOi8vZWxp
eGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9zcGkvc3BpLXFjb20t
cXNwaS5jI0wyMzcNCg0KLSBOdW5vIFPDoQ0KDQo=
