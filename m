Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597402C2535
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 13:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbgKXMDW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 07:03:22 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45930 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732479AbgKXMDW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Nov 2020 07:03:22 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AOBuSWn026089;
        Tue, 24 Nov 2020 07:03:17 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00128a01.pphosted.com with ESMTP id 34y0p88chc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 07:03:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxzIiEqc5yxrQozhAEcF9G3sKolyYV8xsy32xlTiRloSJEYd5TFxauaKMR9ZJdyInvR6KpmhneWDsKwTt2mkebjcgqKFS/7oZKFsy2uwFMO6+4VMchiXGU6wWQV1Dwqa9MeaGraZ5Xgh3DGL0ojvdpQBHMPcOP0wo6HmwFo0HbfmWRY7SPCTjk0tzTexESQnO/TSyQbaFijNkg2RoHdNlDBGJ12vTZNfrqlYvcUgG9oVUlZKmGTeNbnB70EgvtIgGsH4Q9Ptfc+AbGzpspFQmYoyfgsBLkrNLx2vQRf4Fy4PDdFDAGsgtGwe5jX9ZEwXTkcKOmBJUX3eeDS7nNDMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUCPWAAqi6PXnsprJIB+pRiZFOb7bMU1hngBsg+tqnc=;
 b=ASJk4nhzuMZJFW3Ye0isbYye9Xk+CJODG+z61fxLYJPSzv+nYMl/jHEMWi/dJj1auNkyujwgv9aP50DYxogO3r9CfhOpujmNQx6Gm+oacbw3Eq95jBMn1snvhNB4q2+q7DBu594SB1gDKNgbIzPlRl2Xj0DS9KK2zQCxaaFJ9IFdlwi0vO6UIin3aP3J48uRqenbiZJCdnJyZxi+xAikCPwAzvcFE8ySr5lnHvNAtTnkR/ap/7IiT5Yn76phNlK3tQpmncKxGFoPYgXQE5cbY/1rXlcKvFtjc7bcfXsrTvc7xzG+aHvsWiy2yH6X9SP2/BH4NkA7kADGr1/aG7YJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUCPWAAqi6PXnsprJIB+pRiZFOb7bMU1hngBsg+tqnc=;
 b=8ZrdksJOEv+g4igUNFJzWWLNKtmcuUOeCOI4M8bdPL6RWIyC+bCjWhhwrHD80bGKSU+sEICXVHnx61FpG6RThCFiXDJsPQvt9aKX/hMOPavTUJUcQ5PWH/KoBzmdnAzogBQAJqFfvBZJvkGqd/Zsfjc+Z4fOGKCvRkQ46PjXiqU=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DS7PR03MB5623.namprd03.prod.outlook.com (2603:10b6:5:2cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Tue, 24 Nov
 2020 12:03:15 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f99d:8928:7e14:1a62]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f99d:8928:7e14:1a62%6]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 12:03:15 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>
CC:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH v2 1/3] spi: convert to BIT() all spi_device flags
Thread-Topic: [PATCH v2 1/3] spi: convert to BIT() all spi_device flags
Thread-Index: AQHWwkrvAuyngSX0h0uNjRtAQ54rBqnXKN4AgAACToCAAAJTwA==
Date:   Tue, 24 Nov 2020 12:03:15 +0000
Message-ID: <DM6PR03MB4411ABE610061A840224159EF9FB0@DM6PR03MB4411.namprd03.prod.outlook.com>
References: <20201124102152.16548-1-alexandru.ardelean@analog.com>
 <202011241901.eIm4FyEB-lkp@intel.com>
 <CAHp75Vc+M2veG25pehO-8LSj0WcXvotijwaYvkYvAr3LF1n10Q@mail.gmail.com>
In-Reply-To: <CAHp75Vc+M2veG25pehO-8LSj0WcXvotijwaYvkYvAr3LF1n10Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVdGeVpHVnNaV0ZjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTB3Tnpka05EQTBNUzB5WlRSa0xURXhaV0l0WVRWalpDMDBNVFUy?=
 =?utf-8?B?TkRVd01EQXdNekJjWVcxbExYUmxjM1JjTURjM1pEUXdORE10TW1VMFpDMHhN?=
 =?utf-8?B?V1ZpTFdFMVkyUXROREUxTmpRMU1EQXdNRE13WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhOREUwSWlCMFBTSXhNekkxTURZNU1qazVORGd3T1RZNE5qQWlJR2c5SWtG?=
 =?utf-8?B?NlUwWjNSbUpTTHpGTmFYRlZhVzlpVlc1MmExcDJjR0U1YXowaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUW1ObFpGaEtWMk5NVjBGaWRtaFpaV2N3ZEdoa1Qz?=
 =?utf-8?B?VXJSbWcyUkZNeVJqQTBSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-originating-ip: [188.27.128.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db8bb03a-effd-4eee-7d3c-08d89070ecec
x-ms-traffictypediagnostic: DS7PR03MB5623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DS7PR03MB562369771742C880333EEAF2F9FB0@DS7PR03MB5623.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cJo1SVVOfkOBrxVhX8N5n3iE1bqxWCxLlXQcz9lVNbjqQaukEc5keH9BCiRQfuT/xRxaG3lxQsmlDRSLat+RVYzFRiw3axIP77ejZYmTpD0caEekn6rPyNnvzd7NzmqHWjl4+r7NLS3f099pU22Sa1rDpxs51dV5IWSgRFiMtPEo6bC5ghvKOojk1L+quMgoXwSSo7Sj9G5Hpnp/oWLd4YdBiAP7YOozjjyKTYcK08wzN2jzl/+FQtWP04HjtiJHW+X9sweLYI/lkLxN/yvU6o27ezInBuvDyrLx2NYnAbsKEoktHi/7MsR/Fb/wPuGA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(8936002)(55016002)(8676002)(7696005)(76116006)(316002)(54906003)(26005)(107886003)(2906002)(186003)(9686003)(71200400001)(5660300002)(66946007)(83380400001)(53546011)(66446008)(66476007)(4326008)(478600001)(86362001)(6506007)(33656002)(110136005)(66556008)(52536014)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RhcWgh3OkMSPKmf/7I4ccJCRtG00Y4YDb/CfNdf5mBGdMH/LTPCQmIB09l0/EiS8b3af2ONCXhADjw+9phZCOgJQhOFV/jutF2+6xz7cmZSumKLLI0QVgzt75GjatWP/JNqnmvdIsTIcnrfCAQmAP/OwqZEZ+8RnJXwVgTgDURPBgztjIaQjgbVmcxU3Rs1HlHRHV7GSq3E5UmmL4P6nHf8VlDGqrmed0Q7XT+QxPeKjd2P0LKqhCibI4wqfjI/08oaA6GpeUDIjV7BFE91IWWEIK7kIqRb37KgNILSpkksBwTOzrm8G3oIOGafQ4gJsIzWDWKTICJWg01Knrh7EWJQ5NhNL4ZA46ztCNBFhSLfqiR3r0U3hFIxtXfskMHFtvEZ/nL/0X0trO1JMAXynO/aMZs9+SgA/b3ziPbtN1SmO91pn8qn9tnEZAo+twFCJ69Ge850ABKs/A0iToP1sMJy3251n6bxYyFPWCFMEre7j6q3yX47Ylz0oVh3/LkSD6q3VQmdQenhGrkpk9sUwJcAR6D1VNfA9Q/SmFZy9cpIWiIGnc6rGJaHdTvWprF7th3nhXa6DLgw1K7QadxorVwCciM4bAkSMd5CDUDFFv4QqmZS0SgulI9G7EsFv33WHmGi4Tg5ZTC/xHbk5/78AfABbyRnDredEcxd/u75AlhIFlKPln/J84a9VmuryGu3/cjTQgofBOpH93bQIp2O7XnfXRKnmOBMw+OvJseAAdF4DpykRUJ3fEZQyJ9v6xmGePplc5gfAA6s4MPkt1HaWkGw6YvMJofXGvmkkrM7t7hSy9KbCeDf9W+Ou6JjpQh6hQzdAGzoAk38I7aaHKR25wAwHp4mMWEbE3jz55rILwUwbaWZSn14PiP2SS7gQ0ooF8DN/MaSBop/NOC6iB9/tkw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8bb03a-effd-4eee-7d3c-08d89070ecec
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 12:03:15.7993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFYKAiOloczr+TUmleEz3pSoasvk0J8RYO8MC+2T1u4R385HDdUjoIYRDd3Ho9tXJQcy9LJO9AQFylO8HZHG5lSdyB6v+U2n4sg1ZUA7dKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5623
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_04:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240075
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAy
NCwgMjAyMCAxOjUwIFBNDQo+IFRvOiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4N
Cj4gQ2M6IEFyZGVsZWFuLCBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFsb2cuY29t
PjsgbGludXgtc3BpIDxsaW51eC0NCj4gc3BpQHZnZXIua2VybmVsLm9yZz47IGRldmljZXRyZWUg
PGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsDQo+IE1haWxpbmcgTGlz
dCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGtidWlsZC1hbGxAbGlzdHMuMDEub3Jn
OyBNYXJrDQo+IEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaCtk
dEBrZXJuZWwub3JnPjsgQm9nZGFuLA0KPiBEcmFnb3MgPERyYWdvcy5Cb2dkYW5AYW5hbG9nLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzNdIHNwaTogY29udmVydCB0byBCSVQoKSBh
bGwgc3BpX2RldmljZSBmbGFncw0KPiANCj4gT24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMTo0MiBQ
TSBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEFsbCB3
YXJuaW5ncyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPiA+DQo+ID4gICAgSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIGRyaXZlcnMvc3BpL3NwaWRldi5jOjI2Og0KPiA+ID4+IGluY2x1ZGUvdWFw
aS9saW51eC9zcGkvc3BpZGV2Lmg6MzM6IHdhcm5pbmc6ICJTUElfQ1BIQSIgcmVkZWZpbmVkDQo+
ID4gICAgICAgMzMgfCAjZGVmaW5lIFNQSV9DUEhBICAweDAxDQo+IA0KPiBBcmdoISBDYW4gd2Ug
aGF2ZSBvbmx5IG9uZSBzZXQgb2YgZmxhZ3M/DQo+DQoNCk15IGJhZCBoZXJlIGZvciBub3QgY2F0
Y2hpbmcgdGhpcyBlYXJsaWVyLg0KDQpJdCBtaWdodCBiZSBhbiBpZGVhIHRvIGNyZWF0ZSBhICJp
bmNsdWRlL3VhcGkvbGludXgvc3BpL3NwaS5oIiBhbmQgaW5jbHVkZSB0aGlzIGluICIgaW5jbHVk
ZS91YXBpL2xpbnV4L3NwaS9zcGlkZXYuaCAiDQpUaGVuIHRoZSAiIGluY2x1ZGUvdWFwaS9saW51
eC9zcGkvc3BpLmggIiB3b3VsZCBhbHNvIGJlIGluY2x1ZGVkIGluICIgaW5jbHVkZS9saW51eC9z
cGkvc3BpLmggIg0KV2Ugd291bGQgbmF0dXJhbGx5IGRyb3AgdGhlIEJJVCgpIG1hY3JvcyBmb3Ig
dGhlIHVhcGkgaGVhZGVyLg0KDQoNCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkg
U2hldmNoZW5rbw0K
