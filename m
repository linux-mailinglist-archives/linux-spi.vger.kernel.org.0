Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CB22E96F2
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 15:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbhADOOk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 09:14:40 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:37900 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbhADOOj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 09:14:39 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 104E8SQs004291;
        Mon, 4 Jan 2021 09:13:39 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-00128a01.pphosted.com with ESMTP id 35uk8y1m82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jan 2021 09:13:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4b2ktTbQ1RwoO1gXi2OBYL3a7WiRtumQKuMo1oOz3amVKdi3W3JU7/FvTaH+EHhkhMC8jWLooPEKLFozVHMMUzhIOYtdxrd5tHkgY8QEyTs6dVed8KZbOniJz7uTUg4hLI43npAsCsgCZfT92LzzRUMLOUl9CdMpkWbEktCzl2TVKR3l4FFGTsOkhP9VyIi5Sp/gFZt9CS/DLtgVuG4swxA15uKJpqTKOIwpgfv5D1fwNhqq5cv/hT7vwoiFlkmlRFFCs9OllZE4I7zWJdyeFoeWTiekfYb0tKzoS9D5ahGxfK8XPlwQ2R6/qcnNgfhUpz5+z5lSDyNqcSYpbxvaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUQlY9i1TkKFwwqjQWhumMvjc/U6W9TgfkK4EACQ7wA=;
 b=eLR8GcySi3Osg+qHTlhXcKyzCy3HZfc53anD9UDdhCgfE6AJR0W+WLZKJsvnZXlpbZQxA4wm+tOoHjQnQ04CkXiiZxkIpdRgT04YcQMF5cCjbnFJGFUluriGdPdOTnXBCXCs/5WkbN9qGjFTjVwodFGRpV6fk1trOXFKgk9vEfXaqnSpvIm/gwoRyEtbsqMVnRc5/IAVif2A4O2AQ9zgGefIEArOoB+cT6kXafw8zXqLhM/RN1zOPLyzTgr8GsMRQFLsKswA195DspJ0AUxlYVrzPOTdp+pZaAAhlLUvnMdg47d1BAYDHgxsuwZ1McI4iktTa6DhmujOfcVDSm09hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUQlY9i1TkKFwwqjQWhumMvjc/U6W9TgfkK4EACQ7wA=;
 b=Us1PCQWq/IDsQ8EnkOvViadxy6Q6G12dj0UyGff3Y0AZ7Cn4yaqBZZ2YfdvfJCPiezQqBfK42T3qVx7BFaF7RKHOf6sy3qe/jSGRIjg5NhIvZY3enShz6X08euonAX7zhnkOlSHKv0pcyXvEvs6iN+XNeojR8wggzH5x2B0ulMA=
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by DM6PR03MB4266.namprd03.prod.outlook.com (2603:10b6:5:c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.23; Mon, 4 Jan 2021 14:13:37 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::e4d2:490d:16b2:25aa]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::e4d2:490d:16b2:25aa%7]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 14:13:37 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: RE: [PATCH] spi: stm32: update dev_dbg() print format for SPI params
Thread-Topic: [PATCH] spi: stm32: update dev_dbg() print format for SPI params
Thread-Index: AQHW4ndjPo7mn3Z/jEu1JAsv2kUMsaoXfEIAgAAGdIA=
Date:   Mon, 4 Jan 2021 14:13:36 +0000
Message-ID: <DM6PR03MB5196669352540FF7F71AC4A8F9D20@DM6PR03MB5196.namprd03.prod.outlook.com>
References: <20210104085923.53705-1-alexandru.ardelean@analog.com>
 <CAHp75VdsXDr8kAREiGhSF9-ffr05+LDHcqOzWnomfWTH2mN9Gw@mail.gmail.com>
In-Reply-To: <CAHp75VdsXDr8kAREiGhSF9-ffr05+LDHcqOzWnomfWTH2mN9Gw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVdGeVpHVnNaV0ZjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB4WkRNeVpURXlaaTAwWlRrM0xURXhaV0l0WVRWbU1DMDBNVFUy?=
 =?utf-8?B?TkRVd01EQXdNekJjWVcxbExYUmxjM1JjTVdRek1tVXhNekV0TkdVNU55MHhN?=
 =?utf-8?B?V1ZpTFdFMVpqQXROREUxTmpRMU1EQXdNRE13WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhOek0xSWlCMFBTSXhNekkxTkRJME16STFNVEl4TURNNE1qSWlJR2c5SW5o?=
 =?utf-8?B?NWVEUnBlWE54Y0ZoaE9HTXdVRlZ1U0VwRGVuTm9ibGMzVVQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTA4eFdYcG1ieXRNVjBGV00yTlZaV3hvWWpSMWJW?=
 =?utf-8?B?aGtlRkkyVjBaMmFUWlpSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQk4wczNVSFpuUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
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
x-originating-ip: [188.27.130.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 009eaa4d-4cf0-4301-86ac-08d8b0baeda5
x-ms-traffictypediagnostic: DM6PR03MB4266:
x-microsoft-antispam-prvs: <DM6PR03MB426687214BC242BB79579F74F9D20@DM6PR03MB4266.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5tFVadR272uYD+lFEWVUlHjTNGogeOZHWdg533j1qr5fDnLPySwejrjiiPkl6jvfnI8k8/xb9iP/70LdW+F+WqQMQzHi8XVPddEONvVfHlB3P8EfpVNZv9zEfx7DPg1s1Cs1lZBWmse3vA1GtFDxbS3VeJ9DR8xoOPClTrABn5pXRLQhp9CV4wWMTGH0J8u/BMNoOvTpD97onN0bzUCw4NKG1ICi41wyznSebsMVhOJof00hmaDbyyKRnY/61thJWKwJ4ZO0st1UOtlQhQsDCnmC9H/QqaFFkY6PUf9gim33bL+a2NT5fG3ibDaWe65j5kvFasyGs07XjmO96Rzl2sSq0zN6lO3q7Cu6z0tHanRmM83lZ3akL6e2ph9QdSLFbjRbt0Q/y5FMf42uhcuvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(66946007)(316002)(76116006)(7696005)(54906003)(66446008)(86362001)(478600001)(52536014)(66556008)(6916009)(66476007)(83380400001)(8936002)(64756008)(5660300002)(186003)(71200400001)(53546011)(6506007)(8676002)(15650500001)(4326008)(26005)(9686003)(2906002)(55016002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZVYzZWhVd3kybG54aENMQVdpenk3NG1ycEVrVlpqOHozR0RvNzBnam1yWUl1?=
 =?utf-8?B?WG9CUkZ5d05hTlV5NENmemZzUnQ1Qmcra1I2cXNWYXJjZTAzTjhnUlV5VHNZ?=
 =?utf-8?B?K3ZtMnp0N2NJd0VQQ0h3N0NyYVYwUlFId0EvaVJiRXpGMVJ5VGY1ZDNrMkZL?=
 =?utf-8?B?c0FycXdQOWNYMFU5T0N1VVRtMzRybzdaT1ZyZGVSWk9RMWFYSG5kZWczeXBR?=
 =?utf-8?B?NUpld0FqQ0dmWVpYZXkzVlZVRjNuaWVOSXAyU3hxUUJFUURUbzhHVTRMS1B2?=
 =?utf-8?B?YUdhNEdjSzZxV2tOQ2xFYklKSlhqdDRwWHJGRFdVK1VYNStEcFlvTnRmMlgy?=
 =?utf-8?B?RU1NdGRaQTFOQWxNeFNaMVovQTRoU2VBYXFIRWJtQVhVbVA5aDArWHhUMHN0?=
 =?utf-8?B?VWsxYTlXZEttZWRWazdPb0xKVlkvSlBCcmFsOW5HYUhCUmRScEpFMEhKWXZN?=
 =?utf-8?B?ZXkwejVGOWlyTTFaemJWVkd1RzhxRzZOcmZsd2NZUFgrU25CZm5PdEFjcmd6?=
 =?utf-8?B?WVZwQ3VzVkxFa1RoaUQ5cVM2TTZpVW9rL2hnNUFtME82amFoR3QwQVpmYjFv?=
 =?utf-8?B?SzJiYVR5UGNhaUNqZHpSa1NRT1kwWWpObUs2RVRXWm0vdzlrVGd4NFNWQXN1?=
 =?utf-8?B?M2I5UXNZcGt0OTY1ZFNjNkVGZDRBOCtUeGswTXRkQTF1MXUxZ215ZTZOS0xp?=
 =?utf-8?B?R2N2RW5Ob0FJbTZiazZ3NlYrMlI5eFdjdlZWWU5vcWt3SXFCdE1LSjlHT1Fa?=
 =?utf-8?B?LzFvSlVIKzVaU1hON2lvSUNpU2tYQWlxK2tjemFubnhKUXFoL1hCdWEvR2dK?=
 =?utf-8?B?ZGk0amk5aUlHVGJtZmllNzV6R2JDenJmQ0xRc2ljTHhnMVFYMnlJejg4SkRR?=
 =?utf-8?B?Ry9OQVp2ekM0VGJUeFJIVThjSFFTbm5QSWQveWpXa2FVbC9EM0dRc0FCczIw?=
 =?utf-8?B?RGJvb0NGU3cxVVkxRGlnVVZMMGE5ZjVrWi8xTnE4ekNsNG9CNjZzaUJRc0k3?=
 =?utf-8?B?Q2lBdjR0cTlpNGp5cXZ1U3kzNUpZSUpsQ0lxSlc0bEdKUk5TVG92RlErZHds?=
 =?utf-8?B?Q2hhOGJ5b0dUTjZSNHdYWWRIV2xWOWJlVThWbWRIZWdvRnY0MHJrN2l5My9o?=
 =?utf-8?B?NEJxTkoxeUltN2VHRTlseGlxUjdKZERsRXorTFdZb2VVUUdqR2J6Rkx4WFlr?=
 =?utf-8?B?UzByU01yWXg4TXBBS2lsbGdsWERNa3hMWGV5cDFOWFBrM2Z1WHh0S1NLSXU1?=
 =?utf-8?B?VlkvWXlYZWFZM0Y5SWYyZUhYOVUzK0pzeDFqRDQ5aWMvUUxRRWxKQ1RxWFd3?=
 =?utf-8?Q?e4jfc/ZNL0dd0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009eaa4d-4cf0-4301-86ac-08d8b0baeda5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 14:13:36.9453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VIwuIV63brTcfA+fDbF0ZP18TMIjwhigecb32i+nvv7JBWO8rC5aI7OajibeN7nI+A89OABdQQowCW7sy3c3K4uw5jDYv0cbDDrIJOfK7v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4266
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-04_08:2021-01-04,2021-01-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040092
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgNCwg
MjAyMSAzOjUxIFBNDQo+IFRvOiBBcmRlbGVhbiwgQWxleGFuZHJ1IDxhbGV4YW5kcnUuQXJkZWxl
YW5AYW5hbG9nLmNvbT4NCj4gQ2M6IGxpbnV4LXNwaSA8bGludXgtc3BpQHZnZXIua2VybmVsLm9y
Zz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnPjsgTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPjsgU3RlcGhlbiBSb3Rod2Vs
bA0KPiA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNwaTog
c3RtMzI6IHVwZGF0ZSBkZXZfZGJnKCkgcHJpbnQgZm9ybWF0IGZvciBTUEkgcGFyYW1zDQo+IA0K
PiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIEphbiA0LCAyMDIxIGF0IDEwOjU1IEFNIEFsZXhh
bmRydSBBcmRlbGVhbg0KPiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gV2l0aCB0aGUgaW50cm9kdWN0aW9uIG9mIHRoZSAnaW5jbHVkZS91YXBpL2xpbnV4
L3NwaS9zcGkuaCcgaGVhZGVyLA0KPiA+IHRoZSB0eXBlIG9mIHRoZSBtYWNyb3MgYXJlIGVuZm9y
Y2VkIHRvICd1bnNpZ25lZCBsb25nIGludCcgdmlhIHRoZQ0KPiA+IF9CSVRVTCgpIG1hY3JvLg0K
PiA+DQo+ID4gVGhpcyBjYXVzZXMgc29tZSAtV2Zvcm1hdCB3YXJuaW5ncyBpbiB0aGUgc3BpLXN0
bTMyIGRyaXZlci4NCj4gPiBUaGlzIHBhdGNoIGNoYW5nZXMgdGhlIHByaW50ZigpIHNwZWNpZmll
cnMgZnJvbSAnJWQnIHRvICclbHUnIHRvDQo+ID4gYWNjb21tb2RhdGUgZm9yIHRoaXMgY2hhbmdl
Lg0KPiA+DQo+ID4gRml4ZXM6IGY3MDA1MTQyZGFjZSAoInNwaTogdWFwaTogdW5pZnkgU1BJIG1v
ZGVzIGludG8gYSBzaW5nbGUgc3BpLmgNCj4gPiBoZWFkZXIiKQ0KPiA+IFJlcG9ydGVkLWJ5OiBT
dGVwaGVuIFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVnLm9yZy5hdT4NCj4gDQo+IExLUCBhbHNvIHJl
cG9ydGVkIHRoaXMgYmVmb3JlLg0KPiANCg0KQWNrOw0KV2lsbCBhZGQgaXQNCg0KPiAuLi4NCj4g
DQo+ID4gLSAgICAgICBkZXZfZGJnKHNwaS0+ZGV2LCAiY3BvbD0lZCBjcGhhPSVkIGxzYl9maXJz
dD0lZCBjc19oaWdoPSVkXG4iLA0KPiA+ICsgICAgICAgZGV2X2RiZyhzcGktPmRldiwgImNwb2w9
JWx1IGNwaGE9JWx1IGxzYl9maXJzdD0lbHUNCj4gPiArIGNzX2hpZ2g9JWx1XG4iLA0KPiA+ICAg
ICAgICAgICAgICAgICBzcGlfZGV2LT5tb2RlICYgU1BJX0NQT0wsDQo+ID4gICAgICAgICAgICAg
ICAgIHNwaV9kZXYtPm1vZGUgJiBTUElfQ1BIQSwNCj4gPiAgICAgICAgICAgICAgICAgc3BpX2Rl
di0+bW9kZSAmIFNQSV9MU0JfRklSU1QsDQo+IA0KPiBXb3VsZG4ndCB0aGUgb3V0cHV0IGJlIGEg
Yml0IGF3ZnVsIHdpdGggYWxsIHRoZXNlPw0KPiANCj4gSSB0aGluayB0aGUgcHJvcGVyIGZpeCBp
cyB0byBhZGQgISEgdG8gZWFjaCBiaXQgbWFzay4NCg0KRmluZSBieSBtZQ0KDQo+IA0KPiAtLQ0K
PiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
