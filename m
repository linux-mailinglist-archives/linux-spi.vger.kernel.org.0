Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097FB428E60
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 15:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhJKNoR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 09:44:17 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:37826 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237312AbhJKNoG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 09:44:06 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B3E30Q007403;
        Mon, 11 Oct 2021 09:41:46 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-00128a01.pphosted.com with ESMTP id 3bm56uuxna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 09:41:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lneoKLGLfwnN15wVyyt0zm5T2u7BMPjVxwjwdYo65Y+B368tHPiMB8FN8NGTEuKzqsXWEFwuQ5iHLIOLuyEr1SSJ9eftNjedpfzYWNPbyezzHk2d4u142glxxIPfRz9WJ5PO9LVDdytbvwuFR9m7qRuBa4yQGwslk9N+WishNDKtXYezeroS3zItOfi++PA8fs+5CQ5BDi7LxhN54QjLkwGNEy/pkmis3FuiGdUvVmJrtCrrP/jPKsHmOfG2tJt5KhH+BfPkuJDcLRJLyysfHkd/zlbJVt1pK50znVcZznt8hBAwAD2sNh7bDRa6tu9gG47U/csPZlpBwo5k9cJM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmmEh9Fe+HGZz7y4ez1CtgeWgglCN+WRr4DRgHnehx4=;
 b=EufsILrNtKHBc611IEBsNxQyOmewypcfDVasJ7G9cQOEDgv1s4fpFck+GtXvkWhlbIFRQLocC9OuM+ZKRckZc1khLYIfUiFmohv1xKoTVgUzlWWg/TGNlnZoWbpbDmTBWnrU5d+qFbYtBMQpbuycZFzWhaV4vlZrimjw6LsQGSC4k5jIV2qTNlFVzYg6PhLZeZBOrh+U01OyUd1ftjstwl1q+IxL6/3xB++/zSsBBBYwBz+6bFRkp0yVc++h2IXzKsDBThq47N8B5Q0aHNUPmKife6OL4xChLgozzHb45mJpLc4qhm+sdLQLAFci/I9X0m8AbCJK43gq+5ar1eQDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmmEh9Fe+HGZz7y4ez1CtgeWgglCN+WRr4DRgHnehx4=;
 b=ImdeE4vhzHDbMIUM5szGFftsMasqK4zAlw5SGuSIwsF0TPcp6yHBNdpSEOq5Nyg9AYZd+h6bxqdXpfjuE/7pz0xBcBZ6SGBtolGtppomL/It1IGrlmTx9QNmEtlhU+DqhGJdNUUU8ZD8iZoIRX+xiljsuAL1ckJJepH2Ej8gK9M=
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com (2603:10b6:a03:3b8::19)
 by BYAPR03MB3782.namprd03.prod.outlook.com (2603:10b6:a03:72::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Mon, 11 Oct
 2021 13:41:44 +0000
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::2008:e884:49ff:99c1]) by SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::2008:e884:49ff:99c1%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 13:41:44 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH 03/13] hwmon: max31722: Warn about failure to put device
 in stand-by in .remove()
Thread-Topic: [PATCH 03/13] hwmon: max31722: Warn about failure to put device
 in stand-by in .remove()
Thread-Index: AQHXvqPWAGm2Ny3hb02e+fiT26NChqvNzhpg
Date:   Mon, 11 Oct 2021 13:41:44 +0000
Message-ID: <SJ0PR03MB6253F40169668D6398D321218EB59@SJ0PR03MB6253.namprd03.prod.outlook.com>
References: <20211011132754.2479853-1-u.kleine-koenig@pengutronix.de>
 <20211011132754.2479853-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211011132754.2479853-4-u.kleine-koenig@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYldobGJtNWxjbWxjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFtTnpZNE1ETXhaaTB5WVRrNExURXhaV010T1RGa01pMDBPRGc1?=
 =?utf-8?B?WlRjM1kyUmtaV1pjWVcxbExYUmxjM1JjWmpjMk9EQXpNakV0TW1FNU9DMHhN?=
 =?utf-8?B?V1ZqTFRreFpESXRORGc0T1dVM04yTmtaR1ZtWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhPRFEzSWlCMFBTSXhNekkzT0RRek16TXdNalU1TmpBMU5qQWlJR2c5SWpO?=
 =?utf-8?B?MFpVUlFaRkJ1U1U1VmVFRjNlRUoxWkhoS1NFWlhOaTlyTUQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUW5jMGNpczFjR0kzV0VGWk5USnZLMUkwT0dsTGFt?=
 =?utf-8?B?cHVZV28xU0dwNVNYRk5SRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-office365-filtering-correlation-id: 95a9d8fe-c0d3-467a-61b0-08d98cbcdd53
x-ms-traffictypediagnostic: BYAPR03MB3782:
x-microsoft-antispam-prvs: <BYAPR03MB3782389680513EB945B353218EB59@BYAPR03MB3782.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0prZGESjPWaTwq0xHEYPt8r1il1OGBSPqJrcb9UTzIDQEZc36RNO/elMWrqIz5qgdPkrAJU6F01oU5JRvYFxy9E+3UewGq4E141zoLyBrVS4Vsgm1vZMEKlYaebOAAVThRI0n7djzqS7evHjPtKiNRcrlFem4X2VZYnIQ66chPmGxgoSn33C4nxM/yZ8zVktWeaXn0Jxh7rQJ3DUsX3ks9X73tYHKnCRcrTsy9CcwMd+fGEPmWOyckFPeJk3SlvuvoTdbg32rZkWrtWDliye/pp50olG/sBI15JyTUd2pWKytqzB73WJGJCRhkaiSTEChC6aG6cPFfpp8HCkJFPMj7ldgwVJckvsFReNnNenDX87Qm0AQ9l9pjCZlcQrE6IW/l6o69gcE2edppWaytmUhtbCr0/PnevBpwJEwZF7bRIZBx6ANW8DH1Bv9ZRnPzYZwQGZFcWVEFadAPNGW7j+QhMSzIXNhF+upYazzYQ8Cfk94n6V4CCOUq2QTeIkOj+KPyCV6xLNS5UU2zXPvcH7WtGy33fvY0kkXgX3KcS4zflBZcEKImoxMzQTd8yf7PDBQ9KWYXfEfV+HK6F8SUBm7tTeU0EzM3RtpYaSoDTyGc1qvRCj2/GytnyecA3oowqnyJjLP9oI51LfOw+B+eH06cLY0GYYfyTI6whwFbvZw0I+URAURWqbXLnMPby4FGEcdbv5NVtjJ00cv6av8GezDLwbeNs25o8J/Eeewo++Ts8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6253.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(26005)(110136005)(7696005)(54906003)(508600001)(2906002)(316002)(83380400001)(52536014)(5660300002)(38070700005)(76116006)(66476007)(71200400001)(66946007)(122000001)(4326008)(66556008)(53546011)(66446008)(6506007)(86362001)(38100700002)(64756008)(186003)(9686003)(55016002)(8936002)(66574015)(8676002)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzFtdFJQZFFWaC92b08zdUY5TElLWExDWHI1b3dFRlpqci9sSkpickF2MWcr?=
 =?utf-8?B?OWhaSVZjZHo2Q1kzV1ExSHZxTGdCcVNnY3pxbzRwNklvaXM3MkFzVHhOeTQ2?=
 =?utf-8?B?d3lSRUtYV09EMU54NlNMMjVJQnlCTVpHaXZYU0t4VEVvSHBYYmJjOHJFK0dx?=
 =?utf-8?B?Y01wSzl6a3Y4WWRabXZTK1Q0TFhkWmVMUC8xTnIyUkZEOU1OUm5KZjdmaklN?=
 =?utf-8?B?VDVkYm4ySHdSQTRXWENJaktjVzgrYUhHbysxUStNYWl3Skt5K2VNV3o3YkdZ?=
 =?utf-8?B?Wmw5Qkp2dUFjbHRnQmRyL0s0aHNoeEpycUpMck1rSTBROEsxbHNXVlJIZFBG?=
 =?utf-8?B?SnRFUzJuZ1c1cSt1OGtnQzR5SlhXdmFieW1JUWFXejV0aFd4Y1FFK3BiL0Z1?=
 =?utf-8?B?QmRyTHhxUk53VUd5MW9uaFlnalpTTGYzMXVISjA4cnNaT3dQSFY2TGVIYWtQ?=
 =?utf-8?B?d0Z6WWZTTVFhMkpMTHZ2TDBPdHBXUEdJeHNsOWdwYUR4SFRycC9kZnFUZ0Va?=
 =?utf-8?B?a3Z1TlYzeGswaXBxUFhhRGRRTTJhd1IxWXpheDhsMHhVcTEya1ZRcE0xd2FX?=
 =?utf-8?B?ZG9MNGxDa2xRUWpLRitIUHdCVElBakl3VkJXbHJpNEV6VjdORUI5RmRWWjEy?=
 =?utf-8?B?L0ZzeTBqbGJxN2pkbVh3dGxGVWVnMzgwZXF6UFh4Tjc5RFNZcmJqMlFwcS9R?=
 =?utf-8?B?KzRuanlyc1R0aUZSUG1xWXdUUEZXNHhkMERYQjV6aG1obEk4U3ptT3NHV1VP?=
 =?utf-8?B?TkhvZFl5Rlhrdll2SVJLOXVwL1RqZ0ptSitZUjdBMzZkNFJZdVpmbldmUUtk?=
 =?utf-8?B?YUhZb3RtSk9rQllsZ0xJYzJ6aFJlNnllNWpNZnBnL3IveFVVMUpBSnJaZk1q?=
 =?utf-8?B?alhodGlnSGYvamxHYUNRczZvUGpFNGtsWTF6bFlpT2dsaWQ5NUdhK3JaOGpP?=
 =?utf-8?B?VCs5SjdxelNFbEdEODFSM1dxUlhpUEYyMk5SbFVXbUpVUTZlc2Rjc3pacFc5?=
 =?utf-8?B?bjdJeU1vZGNXbU9ZTE5KbVVSUWk2SitHUEM0UGtyWmtURlhTR3I3Sk5lbkor?=
 =?utf-8?B?TEVoZmp6ZDh5ODUzSUpWd3dCRkt1dXkxcmpKSDgxT1lHNXZ6K05wdU04STJk?=
 =?utf-8?B?RkZiRFI3L0RVK29JUGo5VVpsK0tPR0RZelprZnNLTnRRb0tXekNkTjl6cDlr?=
 =?utf-8?B?OVl4QWpOY0lUUFhia2VvRGY0RWtSeGFtbVZ3cDBESkRHRTVXcUZESW1qSWJT?=
 =?utf-8?B?OUJScW1wS283QWhUcDdJVmdudFk4a1hIM25jNlowWjMxMExnSUJvazdnWVdz?=
 =?utf-8?B?dWZlcy9JODRHNVY3cUU3YzM4ci9yOWUwU3Z6NWR0amJqZkdzR1NyZ2RRdmZ1?=
 =?utf-8?B?SVNYVXl1YXRmdUtCLzNWVTc3OE9NRHl1TFZ5OG1pTTdaSFBLNE5Ga0RsWFI1?=
 =?utf-8?B?ZlZEeGMvb1ZxcUtlcjhlNjIrK3FTSGI5Yjc3RlBkL2UzTDBMMzdOV00yazR0?=
 =?utf-8?B?UnpjR1FQSWU2NlZJSUc0K2xIYTl6Rmh4dlZDVWhCbFNCaFJRUnRtN1krNTVG?=
 =?utf-8?B?MERRazhZVFVoUXZtTENkaWo2a0QwR1YvS2hHK2FYblFlU1VsM01zVktQZm4z?=
 =?utf-8?B?cHlvR0p3VVhNN3VhMlUwWEFMaEkrTjQrYU81czRzMnFhM1lFYU5pcm5qK25M?=
 =?utf-8?B?WkVzbnN4Sk9HR201ZUU5d3IvZFVXcll4ZFB2dlZZU3c0NTk2YUxKT1hmS3VU?=
 =?utf-8?Q?/zXogpb/23mJ4tvUTW7/k8G09wVgd69jizRldkP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6253.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a9d8fe-c0d3-467a-61b0-08d98cbcdd53
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 13:41:44.2424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FR04OiH9gaa61gDn1i4lXjFfnkaJnXJVg9LK4g0RFy4h3m1H+wl3YG7Y5TjtefIlfSywj1HM74Rn2rcl0ZhYKgyLNDLLURqJsI/qWZy/eKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3782
X-Proofpoint-ORIG-GUID: TmEb2G3-PeEY_nxPMVKG7rue8h-gHeSN
X-Proofpoint-GUID: TmEb2G3-PeEY_nxPMVKG7rue8h-gHeSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_04,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110079
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gU2VudDogTW9udGFnLCAxMS4g
T2t0b2JlciAyMDIxIDE1OjI4DQo+IFRvOiBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hv
dkBnbWFpbC5jb20+OyBIZW5uZXJpY2gsIE1pY2hhZWwNCj4gPE1pY2hhZWwuSGVubmVyaWNoQGFu
YWxvZy5jb20+DQo+IENjOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBsaW51eC1z
cGlAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LWlucHV0
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggMDMvMTNdIGh3bW9uOiBtYXgzMTcy
MjogV2FybiBhYm91dCBmYWlsdXJlIHRvIHB1dCBkZXZpY2UgaW4NCj4gc3RhbmQtYnkgaW4gLnJl
bW92ZSgpDQo+IA0KPiBXaGVuIGFuIHNwaSBkcml2ZXIncyByZW1vdmUgZnVuY3Rpb24gcmV0dXJu
cyBhIG5vbi16ZXJvIGVycm9yIGNvZGUgbm90aGluZw0KPiBoYXBwZW5zIGFwYXJ0IGZyb20gZW1p
dHRpbmcgYSBnZW5lcmljIGVycm9yIG1lc3NhZ2UuIE1ha2UgdGhpcyBlcnJvciBtZXNzYWdlDQo+
IG1vcmUgZGV2aWNlIHNwZWNpZmljIGFuZCByZXR1cm4gemVybyBpbnN0ZWFkLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25p
eC5kZT4NCg0KQWNrZWQtYnk6IE1pY2hhZWwgSGVubmVyaWNoIDxtaWNoYWVsLmhlbm5lcmljaEBh
bmFsb2cuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9od21vbi9tYXgzMTcyMi5jIHwgOCArKysr
KysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vbWF4MzE3MjIuYyBiL2RyaXZlcnMvaHdt
b24vbWF4MzE3MjIuYyBpbmRleA0KPiA2MTMzMzhjYmNiMTcuLjRjZjRmZTY4MDlhMyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9od21vbi9tYXgzMTcyMi5jDQo+ICsrKyBiL2RyaXZlcnMvaHdtb24v
bWF4MzE3MjIuYw0KPiBAQCAtMTAzLDEwICsxMDMsMTYgQEAgc3RhdGljIGludCBtYXgzMTcyMl9w
cm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiBzdGF0aWMgaW50IG1heDMxNzIyX3JlbW92
ZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKSAgew0KPiAgCXN0cnVjdCBtYXgzMTcyMl9kYXRhICpk
YXRhID0gc3BpX2dldF9kcnZkYXRhKHNwaSk7DQo+ICsJaW50IHJldDsNCj4gDQo+ICAJaHdtb25f
ZGV2aWNlX3VucmVnaXN0ZXIoZGF0YS0+aHdtb25fZGV2KTsNCj4gDQo+IC0JcmV0dXJuIG1heDMx
NzIyX3NldF9tb2RlKGRhdGEsIE1BWDMxNzIyX01PREVfU1RBTkRCWSk7DQo+ICsJcmV0ID0gbWF4
MzE3MjJfc2V0X21vZGUoZGF0YSwgTUFYMzE3MjJfTU9ERV9TVEFOREJZKTsNCj4gKwlpZiAocmV0
KQ0KPiArCQkvKiBUaGVyZSBpcyBub3RoaW5nIHdlIGNhbiBkbyBhYm91dCB0aGlzIC4uLiAqLw0K
PiArCQlkZXZfd2Fybigmc3BpLT5kZXYsICJGYWlsZWQgdG8gcHV0IGRldmljZSBpbiBzdGFuZC1i
eQ0KPiBtb2RlXG4iKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBp
bnQgX19tYXliZV91bnVzZWQgbWF4MzE3MjJfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
IC0tDQo+IDIuMzAuMg0KDQo=
