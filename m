Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECEB42B97F
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 09:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbhJMHvY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 03:51:24 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:33434 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238575AbhJMHvW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 03:51:22 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CMd92t015033;
        Wed, 13 Oct 2021 03:49:10 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0b-00128a01.pphosted.com with ESMTP id 3bnkb8a2dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 03:49:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVN5k19TEwBA3HLgyh1lTwD8BAG4B87tYjq6okfwBV1IKZ/D3fLnsutuqWHAhQ3s+t9ZFLSu89T0q1zKOIy87ckjqeMxhbpJcOwPgO5n1zKehJ76hAa4SDagasY0xQx2ZDNE1NB7jXqke13W9MOvrRNwi5ckAarnPccqFcqNAj7nLOy3Bk+4jozQrlstzi1yl/zGAxWZW/yOd386Owr7foKUQOj3eeHKVUTBuCG6jysklOs3KEOCanUc0qg7ixygsZWRTn45duJp2CwzrpeO4KslqDrVMr+erB3sS2w4bq6pDf6K+cyJd3/21uIMYa6P6EcHVdOE2jC+TMtpVUir/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIc88To0xUwMS4SujpcR8FdIWowKRT/lxgKcsoEvVrk=;
 b=J2vQwdPKqj63o8/IgBCuABWs8QDgXJH2nXS40+hJzCf9Y+v/eb03tXkv4gCgupNjFpIo4v4JrllxCGBkYFayQDxFPpc1tFncE4DRByxYwiD65Oor5l/3flFka8RQNgxqpZm6RdfXcKLtDK0lKndnZx7VveU69j1LvFN6PPgplWkQ/bw/HbRJK7pgovRjyCRjAMUQsm74jYmjjPj8M9+BaEk1C2opdIx7qQ0UD6Z0P9EDbsp25H5H6zYbzBnq61OM4IseydSo52fV2cwaSWnfr8Rrpt+IVxn/d6I432I/Cpme3nKuuIjE6JcsbHkrQO1JS9/iOrdRofjxGFpN9fjPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIc88To0xUwMS4SujpcR8FdIWowKRT/lxgKcsoEvVrk=;
 b=PAOcQRFW/hDGdiEoL1u4l9tQyK5aiaBACADdSnxTHhKGzIafyNk8bPqNkQRRD3P0J3mtf0zBRGY6Uci0IlqHpKSc+46q0Y8AQaIAYGpKewIyLBgnD6Q5pJ7fEvBbTCVi4lntKsoQRP6/fLRuxIZVHYvj19EiYOfUccxv952Sbr0=
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com (2603:10b6:a03:3b8::19)
 by BYAPR03MB3878.namprd03.prod.outlook.com (2603:10b6:a03:66::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 07:49:07 +0000
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::2008:e884:49ff:99c1]) by SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::2008:e884:49ff:99c1%9]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 07:49:07 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mark Brown <broonie@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH v2 11/20] misc: ad525x_dpot: Make ad_dpot_remove() return
 void
Thread-Topic: [PATCH v2 11/20] misc: ad525x_dpot: Make ad_dpot_remove() return
 void
Thread-Index: AQHXv39uUsTWXy+ov0y5mhgPhwUx46vQjoqA
Date:   Wed, 13 Oct 2021 07:49:07 +0000
Message-ID: <SJ0PR03MB62535460ACF4B38A8F581DD48EB79@SJ0PR03MB6253.namprd03.prod.outlook.com>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
 <20211012153945.2651412-12-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211012153945.2651412-12-u.kleine-koenig@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYldobGJtNWxjbWxjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB3T1dSak9EUmlZUzB5WW1aaExURXhaV010T1RGa05TMDBPRGc1?=
 =?utf-8?B?WlRjM1kyUmtaV1pjWVcxbExYUmxjM1JjTURsa1l6ZzBZbU10TW1KbVlTMHhN?=
 =?utf-8?B?V1ZqTFRreFpEVXRORGc0T1dVM04yTmtaR1ZtWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpNelEySWlCMFBTSXhNekkzT0RVNE5EazBOVGt6TmprNE1EUWlJR2c5SWxj?=
 =?utf-8?B?NVpIY3lhakpuVGxSNlVVa3dWV2xSWWxVdmQzUkJSVU5RU1QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUWsxYWVtNU5Rbk5FV0VGbGNtTTJaVkZRVkdaRU1U?=
 =?utf-8?B?WjBlbkExUVRsT09GQlZSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlZrbEZkbTlSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f44f89b-864b-4b10-8450-08d98e1defc9
x-ms-traffictypediagnostic: BYAPR03MB3878:
x-microsoft-antispam-prvs: <BYAPR03MB3878640CF8DA728E83A3B53B8EB79@BYAPR03MB3878.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pe4Nam5l5V/Kz1+0xKG5P9rCG1ybTzp94SU87a/kJwrTVCX3lIDIxsBe2QLb1Vu9Fh0ZHADTJfTBxvd5XR+bnJW8Vcfc0uYStRDyRLasEpVa69IU9kCAm72OCMq64llwvaUpNflW/sNu4Fj47qvaFEwrfPfBue9hIL8BR25Sw5tbVd1Y9mXEcZONlw61oU50Sb+zyXCsaLHwPmbyRZv9hTTg8VtW1SWPk8swKQfGsAQp2sZ4CHdq8An0BgmCkWW0qISZTId2ciyU8ROHmW6zk8jtR5Zn4xIHrtrTXTIPpon4tHHlurPBRzJIsCemvugp1p21CIjWsSRMcavs9iBgetu9wj7zAChkmaojhhFw6vfL2d32ujXWqXPSCBUojD2Nl2zSusG1r6jmaBCpbzsTEo4WiNSQ4kGPTzbV9xuKNQwiskkIbiIu6a5vzu36D8viLpG/31ezctAzVm//R6okF1USsMrn3WZSQ5FLuEneu0KWxsdTBg+PisVrndheHaIjDAWkmC7BfRqVHORWeZIoKcHPMW5+SEqEjLpY0TcGb+sxqo5Cy0KM2nzEG7tW+IK5oGcFRDDKZCOTOEyCnDI8nice4f6RRM9d/y4iUAhhCGglexhqWh0irVg9Rnefyfh4wG8OodZQDNW0TRb3X/vKtCmVcjgIAuD9dD4vhK69yI1CuMI+l+BUDEZanwTOa1h0r73qlLpUgdOL1zaqOAatOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6253.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(4326008)(7696005)(53546011)(38070700005)(8936002)(26005)(186003)(86362001)(55016002)(66556008)(64756008)(66446008)(71200400001)(2906002)(52536014)(76116006)(66946007)(9686003)(66476007)(508600001)(316002)(110136005)(8676002)(54906003)(83380400001)(38100700002)(5660300002)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjU0WE1RMkR0OXNjczBYSWdwckE3RkV6dVh1Y3VSbUs4WVFRUElXV0w0TCtI?=
 =?utf-8?B?ZDlvTnJNVDRodVlmRkgvL29lQ2x0Z29icFdYNmFCSXI1Y0t2cm1LMzdrUEFJ?=
 =?utf-8?B?UW9MUC9EMFc2V0RRc0ZwMGlWekRJSDRDMjNaTkVwZmZGODZJb0dIME4yUTh6?=
 =?utf-8?B?Vkp3enhFUlBlWlE2Q3JNSE5sVTllMk5ERWE2OHpabml1ZlIzbEQweWl4cUZM?=
 =?utf-8?B?U3Vjd3Y4azZPcUZJUHNDSHQzVVJtWXNSYngyb3hWUUdvZ3pNdWl3a2lQSlQr?=
 =?utf-8?B?ZHBtd1ROSVF1a2dLakZESmk5R3lsRzhlaFNKZmw1NHZGYWxEK3YzbkU0UWFn?=
 =?utf-8?B?NU9YOXVUMDlObS9Cd1IzZG1iV0tnWVU5Unp0Ujk5bnZnZVJjSXpJRTNMTDlT?=
 =?utf-8?B?S2JJc095elZLTFlLQ1ZsVitlK0ZjWEd6dkkvL1hBNUlwb1V5N1pYZjAySi8v?=
 =?utf-8?B?WitJbVBrWHVHVjdVUGZ4bVVZQ3A4R2RIbWdjTURJN2FmWFBzTjRVWlFPL3Bp?=
 =?utf-8?B?L0ZLUEplTHlyTy9WbHhKbkpTWWkvbnkrSkh3azRHNmgvcUswOXp5aFQ2UGRZ?=
 =?utf-8?B?U0F1cVdWT3Y4VjBiWnM5UmRYajNDSTVQKzJXdFZEZ0M3VWtwSXNFN2lrMm8w?=
 =?utf-8?B?NXFSRWNrTzd6eHBZcjk1b1FIZmZTWXNDVEI4L1pyTENiRllUaUl6VVpnalJ2?=
 =?utf-8?B?M3pEbUhFY28yclJpaDhVU2dQcWVmRkpJSjdGSFNLSWxGL1ZKSGtDOVo5aWl2?=
 =?utf-8?B?Ky9CN2M2TlpRYnBXSmIvYVQrcC90Uzc5QVRLOGFHQWFYM0UyOGRJSlRTNGZJ?=
 =?utf-8?B?ajZZVlBEcFZkczdmREl5aEh5M0tPYkZQempBZ1BHMGpUd1oxTDFWZE0vUk81?=
 =?utf-8?B?dlRjTmRnaVRqWHptalY3SWxXWnU5RGFYTEtKamIzdjE1UXd3dHltMTBxejJq?=
 =?utf-8?B?WlY5TTVmT3luWmxSeEZScGZpQkJweGNOaFV2dHFzL2lSbE1oYys4NHNmWFdk?=
 =?utf-8?B?bzlMcFpUcC91c2VjcmQ2ektvUS9vNUt2bzlhTkFTQTMwcE9EUmFWTW1WMWlP?=
 =?utf-8?B?UmlDRUkzbHNjSWY3b2NyVFg0VjRhZTRaenpMNk5HaUFXRnRKdEZKd2Z0VmRT?=
 =?utf-8?B?QndvczRPSXg3WFYveW9vcHZ6RXpkSW5ZVGlrWVEvcEFpa25LVnNrZDZWbXJI?=
 =?utf-8?B?SWdkd2t0SjJUd1oxOWxMd2s1c3diK2ZRSUlMVHYxbXMvZG5id1lhbEFDeHo3?=
 =?utf-8?B?YXhwbVIzOVRzZ3hENm9VcjJJM1pkMEJSdGgwTDdGNWlOOWlkS3ZEbEJSeXpW?=
 =?utf-8?B?b0E1UFo2cisxaHpuNEJ0T2l0VEZUOUloRGtDS21vaUtRSDl6emcySzhRUWxR?=
 =?utf-8?B?bHJyZHZCYmxubStnaVFhdmljeDh0MXhtMlpmWSs4OGVXMVZZanhITWsyVHVz?=
 =?utf-8?B?dGZYWmRiRjhzdnVjOWgzWEYzVGpkb2FvMFgvcUZDZnJEQjdnU083bU5UcStV?=
 =?utf-8?B?TkZqNzB0cGdvYW5yNS90Ym1VNlVqNjN0bFFKZEwxL1ZjUTREbEVpdXNqSUQ2?=
 =?utf-8?B?YzdNN21CTjVCTG1vb0t6S1VaQlNXd2pWN2tRYU54bzdyQlFxVk0yZklWdXh6?=
 =?utf-8?B?YmVacHZXSTk3N3lmeTdoWXVpOUN6S2lRVE4wV2RTOTBNWm1Sc3g4SjZLNi9K?=
 =?utf-8?B?N1hnNjViQVlYWXNNRnJoZVZZR2p1aUd6VXpwZG5lRFNrOWcwL0F5b0dKbTRO?=
 =?utf-8?Q?GhM1LFQILYA3NsvJE2Q75HHgkPesH5CgmMhPDwt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6253.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f44f89b-864b-4b10-8450-08d98e1defc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 07:49:07.5931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59VFY2Tw/p1tdOkwNDLb26pBzTLDC9K/RHAG1WLr6M2N98tzKjFUSR/LG7/jcGG4wmHpSXUHSzMByYPwJWu1odt8kYFUP1e0KqJmruZHPkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3878
X-Proofpoint-ORIG-GUID: 9eEU8T-Qx8MklaNY_OU0zTgGAsEXTzy0
X-Proofpoint-GUID: 9eEU8T-Qx8MklaNY_OU0zTgGAsEXTzy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_02,2021-10-13_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110130052
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gU2VudDogRGllbnN0YWcsIDEy
LiBPa3RvYmVyIDIwMjEgMTc6NDANCj4gVG86IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+
OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSGVu
bmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiBDYzog
TWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPjsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtc3BpQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMTEvMjBdIG1pc2M6IGFkNTI1eF9kcG90OiBNYWtlIGFk
X2Rwb3RfcmVtb3ZlKCkgcmV0dXJuDQo+IHZvaWQNCj4gDQo+IFVwIHRvIG5vdyBhZF9kcG90X3Jl
bW92ZSgpIHJldHVybnMgemVybyB1bmNvbmRpdGlvbmFsbHkuIE1ha2UgaXQgcmV0dXJuIHZvaWQN
Cj4gaW5zdGVhZCB3aGljaCBtYWtlcyBpdCBlYXNpZXIgdG8gc2VlIGluIHRoZSBjYWxsZXJzIHRo
YXQgdGhlcmUgaXMgbm8gZXJyb3IgdG8NCj4gaGFuZGxlLg0KPiANCj4gQWxzbyB0aGUgcmV0dXJu
IHZhbHVlIG9mIGkyYyBhbmQgc3BpIHJlbW92ZSBjYWxsYmFja3MgaXMgaWdub3JlZCBhbnl3YXku
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmln
QHBlbmd1dHJvbml4LmRlPg0KDQpBY2tlZC1ieTogTWljaGFlbCBIZW5uZXJpY2ggPG1pY2hhZWwu
aGVubmVyaWNoQGFuYWxvZy5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL21pc2MvYWQ1MjV4X2Rw
b3QtaTJjLmMgfCAzICsrLQ0KPiAgZHJpdmVycy9taXNjL2FkNTI1eF9kcG90LXNwaS5jIHwgMyAr
Ky0NCj4gIGRyaXZlcnMvbWlzYy9hZDUyNXhfZHBvdC5jICAgICB8IDQgKy0tLQ0KPiAgZHJpdmVy
cy9taXNjL2FkNTI1eF9kcG90LmggICAgIHwgMiArLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
aXNjL2FkNTI1eF9kcG90LWkyYy5jIGIvZHJpdmVycy9taXNjL2FkNTI1eF9kcG90LWkyYy5jDQo+
IGluZGV4IGJkODY5ZWM1ZWRiYS4uMGVlMGM2ZDgwOGMzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L21pc2MvYWQ1MjV4X2Rwb3QtaTJjLmMNCj4gKysrIGIvZHJpdmVycy9taXNjL2FkNTI1eF9kcG90
LWkyYy5jDQo+IEBAIC02OSw3ICs2OSw4IEBAIHN0YXRpYyBpbnQgYWRfZHBvdF9pMmNfcHJvYmUo
c3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4gDQo+ICBzdGF0aWMgaW50IGFkX2Rwb3RfaTJj
X3JlbW92ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KSAgew0KPiAtCXJldHVybiBhZF9kcG90
X3JlbW92ZSgmY2xpZW50LT5kZXYpOw0KPiArCWFkX2Rwb3RfcmVtb3ZlKCZjbGllbnQtPmRldik7
DQo+ICsJcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2
aWNlX2lkIGFkX2Rwb3RfaWRbXSA9IHsgZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvbWlzYy9hZDUy
NXhfZHBvdC1zcGkuYyBiL2RyaXZlcnMvbWlzYy9hZDUyNXhfZHBvdC1zcGkuYyBpbmRleA0KPiBh
ZWE5MzFkZDI3MmUuLmE5ZTc1ZDgwYWQzNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9taXNjL2Fk
NTI1eF9kcG90LXNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvbWlzYy9hZDUyNXhfZHBvdC1zcGkuYw0K
PiBAQCAtOTIsNyArOTIsOCBAQCBzdGF0aWMgaW50IGFkX2Rwb3Rfc3BpX3Byb2JlKHN0cnVjdCBz
cGlfZGV2aWNlICpzcGkpDQo+IA0KPiAgc3RhdGljIGludCBhZF9kcG90X3NwaV9yZW1vdmUoc3Ry
dWN0IHNwaV9kZXZpY2UgKnNwaSkgIHsNCj4gLQlyZXR1cm4gYWRfZHBvdF9yZW1vdmUoJnNwaS0+
ZGV2KTsNCj4gKwlhZF9kcG90X3JlbW92ZSgmc3BpLT5kZXYpOw0KPiArCXJldHVybiAwOw0KPiAg
fQ0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX2RldmljZV9pZCBhZF9kcG90X3NwaV9p
ZFtdID0geyBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9taXNjL2FkNTI1eF9kcG90LmMgYi9kcml2
ZXJzL21pc2MvYWQ1MjV4X2Rwb3QuYyBpbmRleA0KPiA1ZDhmM2Y2YTk1ZjIuLjc1NmVmNjkxMmI1
YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9taXNjL2FkNTI1eF9kcG90LmMNCj4gKysrIGIvZHJp
dmVycy9taXNjL2FkNTI1eF9kcG90LmMNCj4gQEAgLTc0Myw3ICs3NDMsNyBAQCBpbnQgYWRfZHBv
dF9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYsICB9DQo+IEVYUE9SVF9TWU1CT0woYWRfZHBvdF9w
cm9iZSk7DQo+IA0KPiAtaW50IGFkX2Rwb3RfcmVtb3ZlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
K3ZvaWQgYWRfZHBvdF9yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0KPiAgCXN0cnVj
dCBkcG90X2RhdGEgKmRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gIAlpbnQgaTsNCj4g
QEAgLTc1Myw4ICs3NTMsNiBAQCBpbnQgYWRfZHBvdF9yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2
KQ0KPiAgCQkJYWRfZHBvdF9yZW1vdmVfZmlsZXMoZGV2LCBkYXRhLT5mZWF0LCBpKTsNCj4gDQo+
ICAJa2ZyZWUoZGF0YSk7DQo+IC0NCj4gLQlyZXR1cm4gMDsNCj4gIH0NCj4gIEVYUE9SVF9TWU1C
T0woYWRfZHBvdF9yZW1vdmUpOw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9hZDUy
NXhfZHBvdC5oIGIvZHJpdmVycy9taXNjL2FkNTI1eF9kcG90LmggaW5kZXgNCj4gZWU4ZGM5ZjVh
NDVhLi43MmE5ZDY4MDE5MzcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9hZDUyNXhfZHBv
dC5oDQo+ICsrKyBiL2RyaXZlcnMvbWlzYy9hZDUyNXhfZHBvdC5oDQo+IEBAIC0yMDksNiArMjA5
LDYgQEAgc3RydWN0IGFkX2Rwb3RfYnVzX2RhdGEgew0KPiANCj4gIGludCBhZF9kcG90X3Byb2Jl
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGFkX2Rwb3RfYnVzX2RhdGEgKmJkYXRhLA0KPiAg
CQkgIHVuc2lnbmVkIGxvbmcgZGV2aWQsIGNvbnN0IGNoYXIgKm5hbWUpOyAtaW50DQo+IGFkX2Rw
b3RfcmVtb3ZlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICt2b2lkIGFkX2Rwb3RfcmVtb3ZlKHN0
cnVjdCBkZXZpY2UgKmRldik7DQo+IA0KPiAgI2VuZGlmDQo+IC0tDQo+IDIuMzAuMg0KDQo=
