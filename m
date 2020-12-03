Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1A42CD2BE
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 10:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbgLCJkq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 04:40:46 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:65096 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387667AbgLCJkp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 04:40:45 -0500
X-Greylist: delayed 4741 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2020 04:40:43 EST
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B38Fe6Y002192;
        Thu, 3 Dec 2020 03:20:59 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-00128a01.pphosted.com with ESMTP id 355vjpchug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 03:20:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXGapNLWdLIDZVXkXk3HaNHDWkHGaVDJV8axmAu1RKcSBmqjPD7chSzFLK9pIhW3defa1jfWq0bF8XOXpufD9py7otdyfDcRE3oZ+CwdHTKf4L510hAsDtNHeft++klBd20UQyeF8G768FFKhR7HU5B+1bvDc7b32w3pUoJMJ8mXCqQBars/hn0UPzhd4n6PBFGwzCRNeo1aSJuGMXZw/lu1cEOAZO75hLl4Ix6Fxd0jwf0lt5xN7rvfCkeA1R0Qq5NsQ599NvriioSTnxnEq7fv65NiV+8LsMm4po2QnpUo+JezbKlkKeGCdY131j5OG4hMqCzUFEvrASH7sixN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KINwOijNshbzKhMk03kOuaa0nobs0W5sk+ho1B17MPk=;
 b=VLEEyWe3IJGIc7/7k104OMQ89smev5HNAz/SWV0A3MzSN3uAacUn1vbCY7U0uTrIYs0NeKvjLWrhHQShvyH4wKRDexm5U5qLwzHRytZPC90jKN3FRfzA1blDBakE4UwDcJ5HiF8wMWtBRlydSS8l//tchh10EC8oR/bSlIJJ6esgdf28H49lgR75MOHl76dDUO+hr8YW1xT7YgQc4nlbEfJMRkk9xbPzt1V+1NGv53aI5Afy9ZuUn7/NfwMnMKVfcJzTDGVfoy8736TyQ8YtLskxegUFy+dJXHgladMocbkwf2IPUaFY3jcBaBNz5Inv0PzmdAZsq30vrw9ieT5mfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KINwOijNshbzKhMk03kOuaa0nobs0W5sk+ho1B17MPk=;
 b=JuaKecA+lZig2sngKAl4vVML1QbzCHa68mXnPqI4cVgcvj/xZjUL7Lq6M3Jva0V3g8LvmulDk5eMVtQuNDvr3ZcSakqbNDH/nsd3raq5zK1G4gUTGABzmt+Jna3VXEkf6go6rOZ9c06y32prh4yFNBd4CI0Gl886j2QVfjr/4zQ=
Received: from CY4PR03MB2966.namprd03.prod.outlook.com (2603:10b6:903:13c::14)
 by CY1PR03MB2267.namprd03.prod.outlook.com (2a01:111:e400:c612::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 3 Dec
 2020 08:20:57 +0000
Received: from CY4PR03MB2966.namprd03.prod.outlook.com
 ([fe80::a45b:c565:97bb:f8ea]) by CY4PR03MB2966.namprd03.prod.outlook.com
 ([fe80::a45b:c565:97bb:f8ea%4]) with mapi id 15.20.3611.025; Thu, 3 Dec 2020
 08:20:57 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH v3 2/3] spi: Add SPI_NO_TX/RX support
Thread-Topic: [PATCH v3 2/3] spi: Add SPI_NO_TX/RX support
Thread-Index: AQHWxL56iPOaB4DKUkqHZzOC3MBax6ncCBaAgAAAOgCACQdSMA==
Date:   Thu, 3 Dec 2020 08:20:57 +0000
Message-ID: <CY4PR03MB29661063937AD783F6B2A010F9F20@CY4PR03MB2966.namprd03.prod.outlook.com>
References: <20201127130834.136348-1-alexandru.ardelean@analog.com>
 <20201127130834.136348-2-alexandru.ardelean@analog.com>
 <CAHp75Vcd4t=RqC31S-b1PXMtd=8sypSLhTrSgRD9hbpSqOphoQ@mail.gmail.com>
 <CAHp75VctXhpyBVB7Zw+SB5LiGcj6r850x+ehL7u2H0R4=y5rVw@mail.gmail.com>
In-Reply-To: <CAHp75VctXhpyBVB7Zw+SB5LiGcj6r850x+ehL7u2H0R4=y5rVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVdGeVpHVnNaV0ZjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAzTldSaE5USTROaTB6TlRRd0xURXhaV0l0WVRWa09DMDBNVFUy?=
 =?utf-8?B?TkRVd01EQXdNekJjWVcxbExYUmxjM1JjTnpWa1lUVXlPRGd0TXpVME1DMHhN?=
 =?utf-8?B?V1ZpTFdFMVpEZ3ROREUxTmpRMU1EQXdNRE13WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlNRGMwSWlCMFBTSXhNekkxTVRRMU56STFORFkxT1RNd01URWlJR2c5SWpB?=
 =?utf-8?B?eVF6aHRPSEZWYXpKeFlVTmxiMnhvVlhsV2RYbDFNamd4U1QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUkhvd1JFMDBWR051VjBGalprd3lVRlY0WW1KRFNY?=
 =?utf-8?B?ZzRkbGs1VkVaMGMwbG5SRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlozTldNRFJSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: true
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ddd14a69-bf3c-4ae0-f8da-08d897645c45
x-ms-traffictypediagnostic: CY1PR03MB2267:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR03MB226712B89F57DF0DBE1DAB5AF9F20@CY1PR03MB2267.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwdZA2omKXNmU5kp8dHcUNkt0r5TLVPQ+72a3A9rmjYBkWvXO5WJKCnNXU7b22uYSNoZJPvVhOW1Ous4hzz38scEcIXnKFCA+hod4SVGwP4MLYmHegrXuXRv8WaSb/vWY3voCbP4+Pe1ZxIk/hZlmojkesajYClEDneDA6Q9yJ6QfRImqebV42kBzrab9jDXOI9TL22yYaUoAdVzejJjeq2xGkv77mc5YiGp6oDkEY+zpRvBiS3k4vux+R9uR3NrpbIpaN34JQoAvpE0qN++AEnXXgpMYggPgScVRm9W6IpI60L75H5DIsHf3kLwR4/VqHk88HI8CLPb2iy71O34Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2966.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(6506007)(66946007)(8676002)(5660300002)(8936002)(83380400001)(4326008)(316002)(54906003)(7696005)(53546011)(186003)(26005)(64756008)(71200400001)(66446008)(66476007)(76116006)(6916009)(66556008)(86362001)(52536014)(2906002)(478600001)(9686003)(107886003)(33656002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QXJXSGgrc1FZZ2UreWFEdVZWdzF0YTBWY1Q1RGxPcHBHdEFtOVBWTmRqYU1h?=
 =?utf-8?B?bmovdHdna2FJVWo3OVpZUVVZcFYvWFMwWDl1WVJJS2lSUXVNcVNxMVRyNHpo?=
 =?utf-8?B?K2xJRmh3cFAxNy9FN1ZhUUFXZmp4ajB0VFA2WVllcUllcVVSOHluOWJWUDEr?=
 =?utf-8?B?Y21CZ0gyMmtJajZPbTFIWWNxYWhpblF2blcwNlFzSllYYlc3WmNXa1NqNDk0?=
 =?utf-8?B?TG92VDlRSG5tTkQ3ME9hNjFaWllqdFRIdzNHK2g2dEszYlBiOGI3YldIVWNp?=
 =?utf-8?B?eitIancvL0lKcFJwb0M3NE44YzF3UkpaU2lXQTZQOW83WGYwS0d2ODVwaDFY?=
 =?utf-8?B?YkNYelFLVVp5VXlGSGw4K3k0cUxLWVZXeHdmV3R1M2ZnUU9qREp1U0sySTRo?=
 =?utf-8?B?aGNNVWtiYVpWaHpLZDN2cWxXSkFqTlQ5Y3VKNktNYldReE0vdVVVaUJITjZH?=
 =?utf-8?B?ZzZ3akZrb29xUGsrUjNWTFUzMjVYekFQVEZ1YitreElOVEJTTEQrb1F1WXdv?=
 =?utf-8?B?UEo5dmdKZ20rekJxWDlhQk5sYkp1Q3pRbDNSZHZNWWNHbmUxeWVMRTI0amU5?=
 =?utf-8?B?UFphVHdKWHJwdjg1OGptSEhXVGNtSzdoR1M2b1FvV3daOXBjQmg0bktkSDl6?=
 =?utf-8?B?RmppR29BVEk5NmFnanBFTXBLNGxmUUhiYktYcWJoSGxzSnc2NWIzSW1UeUxG?=
 =?utf-8?B?d2lBNjZRNERzMHVZR25DNnYwVzAwR1g1WnZsTFNTNENRUjF6UEhEL0xDZHRq?=
 =?utf-8?B?aVZUSEtjek9XQmd0aFRGd1N2aHNESmZhV1hlejJmSU9NRytoVUk0b0pTV0hy?=
 =?utf-8?B?c1ZjWTFiVGtXcDNxQ3VUSFJjN1M2cXlnT09Fc1Z1dzVta3hPUGx6VU1sdDBz?=
 =?utf-8?B?K1I4QVBRNVdsU0xkQ2ppaGV6WnQvZzBtcWxRZUJOU3lXWThGbVpFNkdUTUtv?=
 =?utf-8?B?cUkxK3BmYitxZXdEY3pWTUFEZ0Y4MDJPS3ZIVW9pRmNNN1V6Y0w4Mmx3Z2tR?=
 =?utf-8?B?Q0tNVTBQTXk1ZGNkc2dSREthNUgzanNib3prK1BjcFFZbDg4NEQ5c1h6dkJK?=
 =?utf-8?B?MkNvQ0s4RlMyQ3JJYSt6OFBRVjVCQXpHK3M3Z2trdjJtS1RYRkM1NmpRWVZM?=
 =?utf-8?B?RjZTWDVuL2RnR2wzeXRFajZtMTFOMmQ2N0lIMFozRWlIZ21uNnErZ05MS1Jy?=
 =?utf-8?B?ODl1NVo3aVVhbWY0QWN4RzFibC80Q2VXNVRzTGFobEFCejFFYnVxSWUxenNH?=
 =?utf-8?B?MlN6OUtzTlFLa1crUHZJb3BIWWhtVzJSZ05rRS9Nc05PdWFLTU1RY3J6b1hr?=
 =?utf-8?Q?3oMZjZM0uwXKs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2966.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd14a69-bf3c-4ae0-f8da-08d897645c45
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 08:20:57.2299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIwW0ZDzDJbTyYIHipxYjoZPEznjmhkVo/28es7eGNw7UzuFDjSC3Ds/ACbReGjAhNhOCNAdwJmtE+13KFWI0BeaFkSmwJaJ0ZxRGxBY0Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2267
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_03:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=881 clxscore=1015
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030050
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDI3
LCAyMDIwIDQ6MjQgUE0NCj4gVG86IEFyZGVsZWFuLCBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRl
bGVhbkBhbmFsb2cuY29tPg0KPiBDYzogbGludXgtc3BpIDxsaW51eC1zcGlAdmdlci5rZXJuZWwu
b3JnPjsgZGV2aWNldHJlZQ0KPiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBL
ZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IFJv
YiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIEJyb3duDQo+IDxicm9vbmllQGtl
cm5lbC5vcmc+OyBCb2dkYW4sIERyYWdvcyA8RHJhZ29zLkJvZ2RhbkBhbmFsb2cuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYzIDIvM10gc3BpOiBBZGQgU1BJX05PX1RYL1JYIHN1cHBvcnQN
Cj4gDQo+IE9uIEZyaSwgTm92IDI3LCAyMDIwIGF0IDQ6MjIgUE0gQW5keSBTaGV2Y2hlbmtvDQo+
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToNCj4gPiBPbiBGcmksIE5vdiAyNywg
MjAyMCBhdCAzOjA4IFBNIEFsZXhhbmRydSBBcmRlbGVhbg0KPiA+IDxhbGV4YW5kcnUuYXJkZWxl
YW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiAtLS0gYS9pbmNsdWRl
L3VhcGkvbGludXgvc3BpL3NwaS5oDQo+ID4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvc3Bp
L3NwaS5oDQo+ID4gPiBAQCAtNDMsNSArNDMsNyBAQA0KPiA+ID4gICNkZWZpbmUgICAgICAgIFNQ
SV9UWF9PQ1RBTCAgICAgICAgICAgIDB4MjAwMCAgICAgICAgICAvKiB0cmFuc21pdCB3aXRoIDgg
d2lyZXMgKi8NCj4gPiA+ICAjZGVmaW5lICAgICAgICBTUElfUlhfT0NUQUwgICAgICAgICAgICAw
eDQwMDAgICAgICAgICAgLyogcmVjZWl2ZSB3aXRoIDggd2lyZXMgKi8NCj4gPiA+ICAjZGVmaW5l
ICAgICAgICBTUElfM1dJUkVfSElaICAgICAgICAgICAweDgwMDAgICAgICAgICAgLyogaGlnaCBp
bXBlZGFuY2UgdHVybmFyb3VuZA0KPiAqLw0KPiA+ID4gKyNkZWZpbmUgICAgICAgIFNQSV9OT19U
WCAgICAgICAgICAgICAgIDB4MTAwMDAgICAgICAgICAvKiBubyB0cmFuc21pdCB3aXJlICovDQo+
ID4gPiArI2RlZmluZSAgICAgICAgU1BJX05PX1JYICAgICAgICAgICAgICAgMHgyMDAwMCAgICAg
ICAgIC8qIG5vIHJlY2VpdmUgd2lyZSAqLw0KPiA+DQo+ID4gSXMgaXQgcmVhbGx5IG1hdGVyaWFs
IGZvciB1QVBJPw0KPiA+IFBlcmhhcHMgd2UgbWF5IGhhdmUgc29tZXRoaW5nIGxpa2UNCj4gPiBT
UElfTU9ERV9VU0VSX01BU0sgaW4gdUFQSSBhbmQNCj4gPiBpbiBpbnRlcm5hbCBoZWFkZXJzDQoN
CkhtbSwgaW4gYSB3YXkgdGhpcyBjb3VsZCBtYWtlIHNlbnNlIGZvciBzb21lIFNQSURFVnMgYXMg
d2VsbCwgdG8gc2V0IHRoZXNlIGZsYWdzIGFuZCBnZXQgYW4gZXJyb3IgaWYgdGhleSB0cnkgdG8g
VFggd2l0aCB0aGUgTk9fVFggZmxhZyBzZXQuDQpOb3QgcmVhbGx5IHN1cmUgYWJvdXQgdGhpcy4N
CkluaXRpYWxseSBJIG1lY2hhbmljYWxseSBhZGRlZCB0aGVzZSBoZXJlIGFzIGFuIGluZXJ0aWEg
dG8gdGhlIHByZXZpb3VzIHBhdGNoIHdoaWNoIGlzIGp1c3QgdW5pZnlpbmcgdGhlIGhlYWRlcnMu
DQoNCkFueSBvdGhlciBvcGluaW9ucz8gVGhvdWdodHM/DQpNYXJrPw0KDQo+ID4NCj4gPiBTUElf
TU9ERV9LRVJORUxfTUFTSyB3aXRoDQo+ID4gc3RhdGljX2Fzc2VydChfVVNFUl9NQVNLICYgX0tF
Uk5FTF9NQVNLKTsgLy8gY2hlY2sgY29uZGl0aW9uYWwNCj4gPg0KPiA+ID8NCj4gDQo+IEFuZCBs
b2dpY2FsbHkgc3RhcnQgYml0cyBmb3IgdGhlIGtlcm5lbCBmcm9tIHRoZSBlbmQgKDMxLCAzMCwg
Li4uKS4NCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28N
Cg==
