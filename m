Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FA342B986
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 09:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbhJMHvm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 03:51:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64194 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238656AbhJMHvi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 03:51:38 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CMd6rQ015088;
        Wed, 13 Oct 2021 03:49:29 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bnkbea4u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 03:49:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceimWEv350qTM1e8J34eJCbzEjm9tKBVEcEwkbFcckKnbkQXc4QIQ0wxnTgtU7M+yGMDsNSXdEiEMtJCtZXGznmoP/ChhBDTLfTjGbR4fs8A4ZbIyI2eu9y2m7SP2v8Txz3cP17W4nEiLZMSYlWMoZshP1DCaHCOaIS5dKidcSEErSEg/4YQNh/FtW+DY0aX+3cqdLG4J/v0y4q7G1LLKLpWis6cLogv53Ixw+0YcvzR4rboutC+ftXNbtlMmMC2Nk9EYz+FojpqKspr2+OfF3YUpO5qvdweAPK73+kucusqwEO1+NIebetFbsmLt52oQSRcj8FpIeJCzX5KPoXqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQ5ebGw2O458kjaZDc8VvlUanHfXc8n3YNzxyidGuCE=;
 b=EuRM/uX860vlxa/vQFBer5+WI+z6UQgENW13gHIrcYfROsaBf5wYWp25jamcxlPDRqYqoCZFl+6oQqVO8hG+OX/PWSCTnNlRr2tOUUg+BURQ7OCPRwEksY86cmlXhWUIQ1Yi1gqeKrib/Sw0+/uYPqGSEve1+yf8guAi61FtODVJszIuOByW3O+Uw2hHMSYnaiBF5doMnwdeN+3HmYxAWNkhzvmMRxW5xuaucFVhq8Euq7DMWiYShCFIjgFA0t0X+poaXVHG2KTPheD7CnSr0hg+uv9vShtF+Pk4qgdjycEyOBIiOzsnccj9TWiZ7zCFNgHevi/lHQVL525ztXNvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQ5ebGw2O458kjaZDc8VvlUanHfXc8n3YNzxyidGuCE=;
 b=7TUeq1apABT08gr+0cz3xWIoZGAdbTJcUhvuqKAvGd2lrnWDHuy/k4M8rXt4zWU6pl6UQOoXG8bAwJkHnHx1D/AxK/vC7aXpRbrYrUxokuvN9g34rT6ybKW31b8c1RmbKgEURBc45qa/A/vbJQu0yIk4b9L/6mzZcDcf4Bg9FGE=
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com (2603:10b6:a03:3b8::19)
 by BYAPR03MB3878.namprd03.prod.outlook.com (2603:10b6:a03:66::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 07:49:28 +0000
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::2008:e884:49ff:99c1]) by SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::2008:e884:49ff:99c1%9]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 07:49:28 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH v2 05/20] input: adxl34xx: Make adxl34x_remove() return
 void
Thread-Topic: [PATCH v2 05/20] input: adxl34xx: Make adxl34x_remove() return
 void
Thread-Index: AQHXv39pIS2UhTeDM0GgvyireURVFqvQjqWA
Date:   Wed, 13 Oct 2021 07:49:28 +0000
Message-ID: <SJ0PR03MB6253D4834D1F747F7A95AAFB8EB79@SJ0PR03MB6253.namprd03.prod.outlook.com>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
 <20211012153945.2651412-6-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211012153945.2651412-6-u.kleine-koenig@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYldobGJtNWxjbWxjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB4TmpBM016SmlNaTB5WW1aaExURXhaV010T1RGa05TMDBPRGc1?=
 =?utf-8?B?WlRjM1kyUmtaV1pjWVcxbExYUmxjM1JjTVRZd056TXlZalF0TW1KbVlTMHhN?=
 =?utf-8?B?V1ZqTFRreFpEVXRORGc0T1dVM04yTmtaR1ZtWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXpOREE0SWlCMFBTSXhNekkzT0RVNE5EazJOak15TkRFMk1ESWlJR2c5SW5s?=
 =?utf-8?B?V1NFRlhXSFpUTjJsbVUxVmtOMjB2TDBjMVlrOXpLMWt2Y3owaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTBOUVYwUlpRbk5FV0VGYWNYWk9PSGRPZEV3dlQy?=
 =?utf-8?B?MXhPRE42UVRJd2RqZzBSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-office365-filtering-correlation-id: 705f437d-af56-4df6-5053-08d98e1dfc00
x-ms-traffictypediagnostic: BYAPR03MB3878:
x-microsoft-antispam-prvs: <BYAPR03MB3878C2D5A3ED660A97EA6BC98EB79@BYAPR03MB3878.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J0gY+18vFzyIJF3JJUiZnajO4vUtFfGiRULivqYXQlOsKRM5HU7PnfB2xZ8ICy7lBY+5DAzaZ18tfG4px5LZvaDD5fHd3hFNj0mqroIRn6RDHPI+HrueDry7ux1RV/dQVjnzWEKWJ9YPHf+B4xGXwEJ8aRpDxUZS2VzbNgHEUOIMB7vnjRZvUKYK5WwYwlkl0yC/CGjzJZL6wyKEMhr1nCh6w+g9ObGrlFHeIl2JcocikpFBUHf3IcHxulIFgJGJU/n5HU085WmLw00+Y16fVb84VP1vIPRLJMysJXsaQkLaqffBLotx4ucqbCpxmsh9XgM9IGQsasdnmM/C8aQTTPfR7ix3teovNnUZtk3r7YelCLS7qOfkjdGgtb98gOm+VcQnhEjuzfKqGn5X/TU7PaXK970bb7FiYR2URjP7V76iRHpEUQsEdBOP3jT76NpHLKL+OoP3ekCwvkncoFXsiX414SlyAa4w3XzwNTnbiPrMiCFqMNm+cf3YZqrsxEG1fHjyD8FZ1E+i130DEo+KBTkOGRLT3nHyCAeHv6IJh7xUgofw3NtHE+FOB/s/gY5QYr9PPsngFkyAXAJ8SXjjmUsk9kq+GRBEKWK/IBgqbBQKuHIA9euLdJIf7DRyAf8ZWH4RVkLXDCNHoXI8Z6joJklCNLkI+nAFACvsc84pP7fBRYvieNRwDoNMGDoEGfzRfFqQmkzAz4KLL8Rxmr/cVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6253.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(4326008)(7696005)(53546011)(66574015)(38070700005)(8936002)(26005)(186003)(86362001)(55016002)(66556008)(64756008)(66446008)(71200400001)(2906002)(52536014)(76116006)(66946007)(9686003)(66476007)(508600001)(316002)(110136005)(8676002)(54906003)(83380400001)(38100700002)(5660300002)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnBocmFRcTdUUUowaHhJYUFpdis1MXFHbStHQytjUTI3RmRzd1JxR0lyZGNW?=
 =?utf-8?B?RUl0anB3MHhoVEhkWXdHby9lUWZTK3FEeElBbFlxcS9UWk9pQUNxU1k3ZEtB?=
 =?utf-8?B?aHllb0k1OHJueVV6aVVvV0grTFI5bTZYdlcxODZ1T0s0WEd3Sk1kUFhyeTN0?=
 =?utf-8?B?K09hWWJoMU15OU1vQ2g2dk5iQy9lcmdKYVcyWG4yaXNOdE9XMGVVQk96UldF?=
 =?utf-8?B?WSsxNWp0RjdDS2tKUFF3TmZhL3pxWGViYWd1a24vaXdSS2gvTy9kMEZ5WDRp?=
 =?utf-8?B?OWNnZ1N6dzRJeHRrcWg4Vk51SGdWSjFUYktOQnAydVIxVlpISnVURkxVQXpy?=
 =?utf-8?B?NUxzSGJLeE8rTEdYVy91VDhSTjRydjd4K0NZUUFYTkpGOEY2SEova2ViU2RG?=
 =?utf-8?B?VThKcXE2NFdvb1Z2azZCL2dIcXdIakxVWUpWSjIxanoydExIb1JDUGJzSjRX?=
 =?utf-8?B?VHNRY21iUTBubjByQ0VEcEkySHdmRk4ya3Zla2dnOWR0VGxoNGZIQ3lqUTNa?=
 =?utf-8?B?b1VCd05hRzNQcFdxOUs0N0JEU0ZwK2FIeFhVK0lBK0lHYTgrMVcvczgvMGNn?=
 =?utf-8?B?ekJYSHJ1UGJJQm1ZYVhJd2orNHVwNkRtaWtrb1VGTTA3RndvVW5FM2RackVE?=
 =?utf-8?B?TXpWeXVCc3NtZ2Ivb1JDcisvM0ZmK1JxeFpXV3lmSUVVLzFxc0N2c0FEQUt5?=
 =?utf-8?B?ZnBMVkFUeU1QdDBXdzFFMmFMQVJhM1V6NWJPbENBcHMrbGJYUXAxSWNmM0ha?=
 =?utf-8?B?VEhiQWpFemZTb1hZRFY2bkErdnNhbzY0cVR1dTBSVXExQVowM2g2YW5xMEEv?=
 =?utf-8?B?bURvY0RFMDhoeHhGVTJWekZQbVNxL1NWMFRMWmNFYmhFQ2prbW1zalo5TFpo?=
 =?utf-8?B?SnE3azVTYkU4VVAwT2dXRTQ5T1ZaRDdjYlRreG9HTWtReVZFRElPU2FWUkor?=
 =?utf-8?B?SkdaU3pRbTVwbXhLcVFCK21wb2xpa1BCbWdzWXRzVDFTOGxPZHVjaEJzU1BP?=
 =?utf-8?B?LzVEV3ZFZFF3ajhmelJHMGwwODNFbGlPTlMySHU0d29yWlljTlBZS2Z2REdQ?=
 =?utf-8?B?aCtiWjVzQUVrb1h6UFNRL01tbmxVU2wvbE5vTWwrT2N4aE9UaTNxaXNpeThK?=
 =?utf-8?B?eVJPTDFkTzNDRTFURzlrZHg4ekJCZmJZaFV3cWVGanE1TURhV3ZCTHJQa0lU?=
 =?utf-8?B?K2x5WGhWUUN3TVM5dVdzaXFRODd5ZWlqeHM4RG1LbHMzck1MTkQ0aHhJWkIy?=
 =?utf-8?B?TlMxMVRpY3N5N0tEQzRzYnlJNDdVb2Z2UFdPM01RS2U2RktrZ1JrclpNV3A5?=
 =?utf-8?B?NlZjdWphaTBQV21JVndVNkY3T0tYZzVIMDZDMXJtdUtFNUJjTmpIQ2xCUkhm?=
 =?utf-8?B?QVJWNDBUOXZMalFzVkVQSUZuSVhBNUN6SWg4VGtoRDBaQkpzcWZUU1BLbVpm?=
 =?utf-8?B?dndQQjBCTUh6bElXSnpYWlRoTHFGUW1KRjE0Q1BuVkswVTJqZ2tTdGE3MERS?=
 =?utf-8?B?b05TdFRzenluWkNRTTEyOWtsYnB5Q3diQ3pSOC8xSzVTcHFZL3grY0oybXJQ?=
 =?utf-8?B?WHRvSHZwcnVENGhRRE41THlTS0R2QTFWRmZLOFhJZjJUOVF6RjlIb3NJUlpE?=
 =?utf-8?B?bFNRTTdNL3Z5TlphTGIxa2xDS09kVDBQbDZMc2tUMGtRdCtXamV3c05UYkla?=
 =?utf-8?B?RHkvd01hai9Qb2lnNmtlb2s3N1l5V3IyU05seXppT09PNDFEWEs5MEN6TFlk?=
 =?utf-8?Q?gygwLktAq/bi6Shey3vV2B/dunXBgaYgp0ZPJUX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6253.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705f437d-af56-4df6-5053-08d98e1dfc00
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 07:49:28.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGg06cU3miTKByD9/yoSZwW1jcql36gQdrn5W9J3sLH6fEokSO4vnjOrRVbOA50dcHSdHFmX9OXWJwHywqxlqjLLSk/7MwnlYYYi7zvKMjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3878
X-Proofpoint-ORIG-GUID: tDu19uK6wPTjkrxxlR9QS8wqPdJbhLve
X-Proofpoint-GUID: tDu19uK6wPTjkrxxlR9QS8wqPdJbhLve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_02,2021-10-13_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130052
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gU2VudDogRGllbnN0YWcsIDEy
LiBPa3RvYmVyIDIwMjEgMTc6NDANCj4gVG86IERtaXRyeSBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9r
aG92QGdtYWlsLmNvbT47IEhlbm5lcmljaCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hA
YW5hbG9nLmNvbT4NCj4gQ2M6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IGtlcm5l
bEBwZW5ndXRyb25peC5kZTsgbGludXgtDQo+IGlucHV0QHZnZXIua2VybmVsLm9yZzsgbGludXgt
c3BpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMDUvMjBdIGlucHV0OiBh
ZHhsMzR4eDogTWFrZSBhZHhsMzR4X3JlbW92ZSgpIHJldHVybiB2b2lkDQo+IA0KPiBVcCB0byBu
b3cgYWR4bDM0eF9yZW1vdmUoKSByZXR1cm5zIHplcm8gdW5jb25kaXRpb25hbGx5LiBNYWtlIGl0
IHJldHVybiB2b2lkDQo+IGluc3RlYWQgd2hpY2ggbWFrZXMgaXQgZWFzaWVyIHRvIHNlZSBpbiB0
aGUgY2FsbGVycyB0aGF0IHRoZXJlIGlzIG5vIGVycm9yIHRvDQo+IGhhbmRsZS4NCj4gDQo+IEFs
c28gdGhlIHJldHVybiB2YWx1ZSBvZiBpMmMgYW5kIHNwaSByZW1vdmUgY2FsbGJhY2tzIGlzIGln
bm9yZWQgYW55d2F5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUu
a2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCg0KQWNrZWQtYnk6IE1pY2hhZWwgSGVubmVy
aWNoIDxtaWNoYWVsLmhlbm5lcmljaEBhbmFsb2cuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9p
bnB1dC9taXNjL2FkeGwzNHgtaTJjLmMgfCA0ICsrKy0gIGRyaXZlcnMvaW5wdXQvbWlzYy9hZHhs
MzR4LXNwaS5jIHwgNA0KPiArKystDQo+ICBkcml2ZXJzL2lucHV0L21pc2MvYWR4bDM0eC5jICAg
ICB8IDQgKy0tLQ0KPiAgZHJpdmVycy9pbnB1dC9taXNjL2FkeGwzNHguaCAgICAgfCAyICstDQo+
ICA0IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L21pc2MvYWR4bDM0eC1pMmMuYyBiL2RyaXZlcnMv
aW5wdXQvbWlzYy9hZHhsMzR4LWkyYy5jDQo+IGluZGV4IGU2NDM2OGE2MzM0Ni4uYTNiNWY4OGQy
YmQxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lucHV0L21pc2MvYWR4bDM0eC1pMmMuYw0KPiAr
KysgYi9kcml2ZXJzL2lucHV0L21pc2MvYWR4bDM0eC1pMmMuYw0KPiBAQCAtMTAzLDcgKzEwMyw5
IEBAIHN0YXRpYyBpbnQgYWR4bDM0eF9pMmNfcmVtb3ZlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGll
bnQpDQo+IHsNCj4gIAlzdHJ1Y3QgYWR4bDM0eCAqYWMgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xp
ZW50KTsNCj4gDQo+IC0JcmV0dXJuIGFkeGwzNHhfcmVtb3ZlKGFjKTsNCj4gKwlhZHhsMzR4X3Jl
bW92ZShhYyk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgaW50IF9f
bWF5YmVfdW51c2VkIGFkeGwzNHhfaTJjX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KSBkaWZm
IC0tZ2l0DQo+IGEvZHJpdmVycy9pbnB1dC9taXNjL2FkeGwzNHgtc3BpLmMgYi9kcml2ZXJzL2lu
cHV0L21pc2MvYWR4bDM0eC1zcGkuYw0KPiBpbmRleCBkZjZhZmE0NTVlNDYuLjZlNTFjOWJjNjE5
ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbnB1dC9taXNjL2FkeGwzNHgtc3BpLmMNCj4gKysr
IGIvZHJpdmVycy9pbnB1dC9taXNjL2FkeGwzNHgtc3BpLmMNCj4gQEAgLTkxLDcgKzkxLDkgQEAg
c3RhdGljIGludCBhZHhsMzR4X3NwaV9yZW1vdmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkgIHsN
Cj4gIAlzdHJ1Y3QgYWR4bDM0eCAqYWMgPSBzcGlfZ2V0X2RydmRhdGEoc3BpKTsNCj4gDQo+IC0J
cmV0dXJuIGFkeGwzNHhfcmVtb3ZlKGFjKTsNCj4gKwlhZHhsMzR4X3JlbW92ZShhYyk7DQo+ICsN
Cj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGFk
eGwzNHhfc3BpX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KSBkaWZmIC0tZ2l0DQo+IGEvZHJp
dmVycy9pbnB1dC9taXNjL2FkeGwzNHguYyBiL2RyaXZlcnMvaW5wdXQvbWlzYy9hZHhsMzR4LmMg
aW5kZXgNCj4gNGNjNGU4ZmY0MmIzLi4zNGJlYWM4MGU2ZjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvaW5wdXQvbWlzYy9hZHhsMzR4LmMNCj4gKysrIGIvZHJpdmVycy9pbnB1dC9taXNjL2FkeGwz
NHguYw0KPiBAQCAtODk2LDE1ICs4OTYsMTMgQEAgc3RydWN0IGFkeGwzNHggKmFkeGwzNHhfcHJv
YmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiBpbnQgaXJxLCAgfSAgRVhQT1JUX1NZTUJPTF9HUEwo
YWR4bDM0eF9wcm9iZSk7DQo+IA0KPiAtaW50IGFkeGwzNHhfcmVtb3ZlKHN0cnVjdCBhZHhsMzR4
ICphYykNCj4gK3ZvaWQgYWR4bDM0eF9yZW1vdmUoc3RydWN0IGFkeGwzNHggKmFjKQ0KPiAgew0K
PiAgCXN5c2ZzX3JlbW92ZV9ncm91cCgmYWMtPmRldi0+a29iaiwgJmFkeGwzNHhfYXR0cl9ncm91
cCk7DQo+ICAJZnJlZV9pcnEoYWMtPmlycSwgYWMpOw0KPiAgCWlucHV0X3VucmVnaXN0ZXJfZGV2
aWNlKGFjLT5pbnB1dCk7DQo+ICAJZGV2X2RiZyhhYy0+ZGV2LCAidW5yZWdpc3RlcmVkIGFjY2Vs
ZXJvbWV0ZXJcbiIpOw0KPiAgCWtmcmVlKGFjKTsNCj4gLQ0KPiAtCXJldHVybiAwOw0KPiAgfQ0K
PiAgRVhQT1JUX1NZTUJPTF9HUEwoYWR4bDM0eF9yZW1vdmUpOw0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5wdXQvbWlzYy9hZHhsMzR4LmggYi9kcml2ZXJzL2lucHV0L21pc2MvYWR4bDM0
eC5oIGluZGV4DQo+IDgzYTBlZWNjZjYxMy4uZmViZjg1MjcwZmZmIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2lucHV0L21pc2MvYWR4bDM0eC5oDQo+ICsrKyBiL2RyaXZlcnMvaW5wdXQvbWlzYy9h
ZHhsMzR4LmgNCj4gQEAgLTI1LDYgKzI1LDYgQEAgdm9pZCBhZHhsMzR4X3Jlc3VtZShzdHJ1Y3Qg
YWR4bDM0eCAqYWMpOyAgc3RydWN0IGFkeGwzNHgNCj4gKmFkeGwzNHhfcHJvYmUoc3RydWN0IGRl
dmljZSAqZGV2LCBpbnQgaXJxLA0KPiAgCQkJICAgICAgYm9vbCBmaWZvX2RlbGF5X2RlZmF1bHQs
DQo+ICAJCQkgICAgICBjb25zdCBzdHJ1Y3QgYWR4bDM0eF9idXNfb3BzICpib3BzKTsgLWludA0K
PiBhZHhsMzR4X3JlbW92ZShzdHJ1Y3QgYWR4bDM0eCAqYWMpOw0KPiArdm9pZCBhZHhsMzR4X3Jl
bW92ZShzdHJ1Y3QgYWR4bDM0eCAqYWMpOw0KPiANCj4gICNlbmRpZg0KPiAtLQ0KPiAyLjMwLjIN
Cg0K
