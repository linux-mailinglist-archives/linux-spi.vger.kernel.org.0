Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0712DFD6B
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 16:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgLUPUg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 10:20:36 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:46442 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbgLUPUg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 10:20:36 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BLFERi2011830;
        Mon, 21 Dec 2020 10:19:52 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2052.outbound.protection.outlook.com [104.47.37.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 35hf1b49sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 10:19:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpGx0lcfK0pwXQgWVr8T214NrPrZsFYCV6ABj1+w0r8bJur3pCN1/wZN7XYCNadBVyA/3k9YJ/0SI/HxJ7rOA4KuakDVYnoWcQCG2wh/Qp2avYKIGP3G07ioj99zv8e69liph2/B98d1RGnx8vAR6zSeD9pRGhLxJ0fNwDgfiHdilvrwxdDuI0lF65fkEq9czeNWCoE6WY5cDByZQ5N8JQ+DkKSFXTOLgMdqJxH4/Q4bqJsUD6LiniXAceNnwXaCOEzQONL03BNfK0j+mxo2qLrCNiESI1EnLZuDKUHoNbdQPXV2cG5eWxcb2nTT0s9vJ0cSlaV5S5q2lL5ngWwmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbz1Z19uQZgxJwJ/IQE4rhEib7sxUBJMWfhjklh9EWI=;
 b=MNGK43c3zMP1nXAL6WApY4m3mWZJDs8mWt4fgmXDtABIsE5L6P9MRWGoOFxqql1GMeoeKZiLEPidNRf76cKWe4jwZKMmPt1in79Ilurnl/sAI0p2phtghwphh/QFI158Qqut8ljq95P8v3X3Zo4HynVA7tgBB30FgsDSyhT4avklaOdReCWF7Z4nYx6jp0mOOvtAziVhzi6f3+UEd5gPvDcJPwI8xaonnpZ9GKMl3FLaq4VqwNOuJHcOY8TRpovWsMf5EwLjB3TGspUzbJMHmCkriolydwI2/VMtvW8NL3ZAG/E8reINPg2fUkgxaK7JCO/Di4W06ofMpBXTjY5Nvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbz1Z19uQZgxJwJ/IQE4rhEib7sxUBJMWfhjklh9EWI=;
 b=q/5XMJPS57OfF0FvxzEATq2URrmVWtT21QTkdoMzlZhlRJIM5I+kKA/XLyj2i8qhiQ2bQDqxxhj6YKGUddK8F5TpNJ/vb5//IrGpIEXHqHpU8BTA4Ln34QLC88rsEfK2alC0rjn0dJIl3hkQIxV0BIw4jnksL81fBM4v0ghxbgY=
Received: from CY4PR03MB2966.namprd03.prod.outlook.com (2603:10b6:903:13c::14)
 by CY4PR03MB3142.namprd03.prod.outlook.com (2603:10b6:910:59::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.31; Mon, 21 Dec
 2020 15:19:48 +0000
Received: from CY4PR03MB2966.namprd03.prod.outlook.com
 ([fe80::a45b:c565:97bb:f8ea]) by CY4PR03MB2966.namprd03.prod.outlook.com
 ([fe80::a45b:c565:97bb:f8ea%4]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 15:19:48 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH v5 2/3] spi: Add SPI_NO_TX/RX support
Thread-Topic: [PATCH v5 2/3] spi: Add SPI_NO_TX/RX support
Thread-Index: AQHW16Os5Q/OotvhOE2SaUI3h4feXKoBnZ6AgAAAgACAAAqKQA==
Date:   Mon, 21 Dec 2020 15:19:48 +0000
Message-ID: <CY4PR03MB29666C090DF4E882DFB5AA12F9C00@CY4PR03MB2966.namprd03.prod.outlook.com>
References: <20201221141906.48922-1-alexandru.ardelean@analog.com>
 <20201221141906.48922-2-alexandru.ardelean@analog.com>
 <CAHp75VfR1eNMry8JwJoFuaU48KZ6rdBWau=yaR1AnsaRSLTC=g@mail.gmail.com>
 <CAHp75VftBQEK10Z7pkD18fpr8B7ipCXUXVx=1Hnuq-2w=z2hgQ@mail.gmail.com>
In-Reply-To: <CAHp75VftBQEK10Z7pkD18fpr8B7ipCXUXVx=1Hnuq-2w=z2hgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVdGeVpHVnNaV0ZjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFtWm1KallUVTFZUzAwTXpsbUxURXhaV0l0WVRWbFpTMDBNVFUy?=
 =?utf-8?B?TkRVd01EQXdNekJjWVcxbExYUmxjM1JjWm1aaVkyRTFOV010TkRNNVppMHhN?=
 =?utf-8?B?V1ZpTFdFMVpXVXROREUxTmpRMU1EQXdNRE13WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXlNREUySWlCMFBTSXhNekkxTXpBek56WXdORFEzTURreE5EY2lJR2c5SWtO?=
 =?utf-8?B?Tk5rdzJaRUpvU2pkWVoycHpXRVp5WkhwSGMwVnJTMEZ6T0QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUVdKQ1VtcERjazVtVjBGbEszVlFVbXRTUnpRelpU?=
 =?utf-8?B?YzJORGxIVWtWaWFtUTBSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-originating-ip: [188.27.131.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74c14db5-f455-46d8-a0bb-08d8a5c3db3e
x-ms-traffictypediagnostic: CY4PR03MB3142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3142EF906A661630CC50F43DF9C00@CY4PR03MB3142.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xfsZCCdariFonRqCuSu1EQ5XqQ4acuwD7V4DDKyecyL3qoVTFYymaNEWMFp/tdlI+uzXITzFObCqbtoAUlCzPXxltYzSKA43H9fp3iJgo/NNB7p75ePpFEjNW8GIEUGLeGKffjWhxkFYQKAYd9uWr4SjUbYAJIOyuYiBFftr/c/3da0MyU6iHkURsov73Z2hS17fY6xa2xo551lcLJwcXnrUsWy0lj4NkHWWGslRdMRER93XlYYH/HQVGgpaWPQaGjGEboKNg2TJ0wDVa37DtN40fUWjGvtFdrhl7nJyV1lSUlvEUjr/RjhGHhjYxDLcxCJtMDo4FLLqTseGfgl4CdZPwnOqFbKdAwlwfPc1v8JhYmkrZGrO5Hz4TPyZ30FR1F8cr5bSibvSNgz0rhiNJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2966.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(55016002)(33656002)(9686003)(8676002)(4326008)(6506007)(478600001)(66946007)(54906003)(53546011)(316002)(76116006)(186003)(5660300002)(66476007)(86362001)(6916009)(66556008)(26005)(83380400001)(2906002)(64756008)(66446008)(8936002)(7696005)(71200400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dWNTaGNOK08zc3JDdlFwY0srSTlRQzFERkRkT1B4bFhRVmo3TG4wZURFZHRO?=
 =?utf-8?B?bW5DNUgwWUlrbkhZUXgyNWdaSU1COEwrK0JjRlI3RzU1Q3R2QTZac0VBeGky?=
 =?utf-8?B?dTIvQXZEaTE1ZjRNdXNnZmZwMWxUTElLV1oyVlBLbXNJRThYcjYyWHZxV002?=
 =?utf-8?B?WWpDUncySjcwNFR0UE0xdDRGWmZXenE5QnVzMFIzblRmVHgwS1ZteWZkbHZu?=
 =?utf-8?B?NzBnNGZHT2RMcXVkUHhLM0hjN1V6TWg5YTczOXVVTFlpMmRrUWlCRVdaYTRz?=
 =?utf-8?B?MjdGMHFvcWZta3UzUS9LL2JRWjRGeUJ3bnJVaHNCUUR0RkRvZ1hnejNrcWh2?=
 =?utf-8?B?NUVOZ0I1SnZZVDJZR05BdzFPQ0VDSWJnZGlUUnJGQ2x6eHVhZVdIdTc1eFhK?=
 =?utf-8?B?dmpGa3NLaCsrWDRLSUFHUFBHNG5LM3dOV1FZR1loWkIwN1dwSjdVd1NGOU44?=
 =?utf-8?B?Q21nRXk0RGxlU1ZuSFdrTytMUzc2YmlzR2p3dFFqdWhNRHRYbFpkV2lIU250?=
 =?utf-8?B?VFJzbFZrU09UNGhYWFdvWTJ1Z1RScHNHRitKNngyVzdab0FWT2ZTVVNvOVNs?=
 =?utf-8?B?QWhiT3hTTzNxYVdJTWhXdU5QTy9ZSCtxM1FGcHh6RTZKRmtsZmVoZ0cveEY2?=
 =?utf-8?B?TmYyRlZZOFNaZXZYTkJqWDYzV1A3akJNVEZ2eFd1bGNHdXNqVGVONTUxMTNR?=
 =?utf-8?B?S0N0R2FDNVpJRjAzZ1dIZVlTTWkwdzY4Q1hUTC9CRTRZNVlFV25LVWZyT2xU?=
 =?utf-8?B?T2hWaFQxVFJEUENIWTBlUjQyeEpOejhORFowcGV4WnBFT0pRR0NldTRraTBp?=
 =?utf-8?B?b0hocHBDMkhTSjg5cEV3MDJyK3U2S1puc2tKUDRmdG84ZUZCdEtUMzZQalRV?=
 =?utf-8?B?aXU1aVVDQlhpK1UwWmNWeGJ5NFdISFYvUUViNytKa09USUROcjUwMUtkTk8v?=
 =?utf-8?B?OCtnRHg3S21tdzN0SE1FblZMN2c3WXVsQ0pvVUdyMzFJbDg3YW10RVhTb3RT?=
 =?utf-8?B?L0I0QUhsWFhoZy9MTEgxUmFWNkpHRmUvRldFZDlSTlpGeGtYQi80VlhrSXRy?=
 =?utf-8?B?ajRZLzE1MmNDVVZpV3FCdzU0V1VXZDY5K1VYVTdiWEZ5S3ZYYkFUU1FhL3Rt?=
 =?utf-8?B?WVhMeU1uWmFueGs0c2Jibk1RTkNUQ3d0UW05dGlMaUR0bTcrd1BQQ3M3a2xL?=
 =?utf-8?B?cC9PMngvdUt3cWhEamN1VFRuMDN1aFI1Uk1oM2R0TjBtSUFXZFo1YklRT25X?=
 =?utf-8?B?VXoybUd3OS9EdUZva2U1TjUxeTVXVDBObGcrVFU4cm1HcTJCNjllNkxtN2RK?=
 =?utf-8?Q?awxr/VX31yJXM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2966.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c14db5-f455-46d8-a0bb-08d8a5c3db3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 15:19:48.7226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3UAbUTOzwTBZI1y8LJ45+VWV/lp/ACOQnwQfN9+rpubkBBlmeAThSlk4nMS5ZOTG335onSopNAyE/aNsNeD1ng0sxu+2iXLG7AidePYvvqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3142
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_08:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=882 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012210108
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDIx
LCAyMDIwIDQ6MzcgUE0NCj4gVG86IEFyZGVsZWFuLCBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRl
bGVhbkBhbmFsb2cuY29tPg0KPiBDYzogbGludXgtc3BpIDxsaW51eC1zcGlAdmdlci5rZXJuZWwu
b3JnPjsgZGV2aWNldHJlZQ0KPiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBL
ZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IEJv
Z2RhbiwgRHJhZ29zIDxEcmFnb3MuQm9nZGFuQGFuYWxvZy5jb20+Ow0KPiBNYXJrIEJyb3duIDxi
cm9vbmllQGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY1IDIvM10gc3BpOiBBZGQgU1BJX05PX1RYL1JYIHN1cHBvcnQN
Cj4gDQo+IE9uIE1vbiwgRGVjIDIxLCAyMDIwIGF0IDQ6MzQgUE0gQW5keSBTaGV2Y2hlbmtvDQo+
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPiB3cm90ZToNCj4gPiBPbiBNb24sIERlYyAyMSwg
MjAyMCBhdCA0OjE1IFBNIEFsZXhhbmRydSBBcmRlbGVhbg0KPiA+IDxhbGV4YW5kcnUuYXJkZWxl
YW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gRnJvbTogRHJhZ29zIEJvZ2RhbiA8
ZHJhZ29zLmJvZ2RhbkBhbmFsb2cuY29tPg0KPiA+ID4NCj4gPiA+IFRyYW5zbWl0L3JlY2VpdmUg
b25seSBpcyBhIHZhbGlkIFNQSSBtb2RlLiBGb3IgZXhhbXBsZSwgdGhlIE1PU0kvVFgNCj4gPiA+
IGxpbmUgbWlnaHQgYmUgbWlzc2luZyBmcm9tIGFuIEFEQyB3aGlsZSBmb3IgYSBEQUMgdGhlIE1J
U08vUlggbGluZQ0KPiA+ID4gbWF5IGJlIG9wdGlvbmFsLiBUaGlzIHBhdGNoIGFkZHMgdGhlc2Ug
dHdvIG5ldyBtb2RlczogU1BJX05PX1RYIGFuZA0KPiA+ID4gU1BJX05PX1JYLiBUaGlzIHdheSwg
dGhlIGRyaXZlcnMgd2lsbCBiZSBhYmxlIHRvIGlkZW50aWZ5IGlmIGFueSBvZg0KPiA+ID4gdGhl
c2UgdHdvIGxpbmVzIGlzIG1pc3NpbmcgYW5kIHRvIGFkanVzdCB0aGUgdHJhbnNmZXJzIGFjY29y
ZGluZ2x5Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBCb2dkYW4gPGRyYWdv
cy5ib2dkYW5AYW5hbG9nLmNvbT4NCj4gPg0KPiA+IE1pc3NlZCBDby1kZXZlbG9wZWQtYnk6IEFs
ZXhhbmRydSAuLi4gPw0KDQpOYWgsIHRoYXQncyBmaW5lIGZyb20gbXkgc2lkZSB3aXRob3V0IHRo
YXQgdGFnLg0KDQo+ID4NCj4gPiBBbnl3YXksIGxvb2tzIGdvb2QgdG8gbWUsDQo+ID4gUmV2aWV3
ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4gDQo+
IE9uZSBuaXQsIHRob3VnaC4uLg0KPiANCj4gPiA+IC0gICAgICAgICAgICAgICAic2V0dXA6IGNh
biBub3Qgc2VsZWN0IGR1YWwgYW5kIHF1YWQgYXQgdGhlIHNhbWUgdGltZVxuIik7DQo+ID4gPiAr
ICAgICAgICAgICAgICAgInNldHVwOiBjYW4gbm90IHNlbGVjdCBhbnkgdHdvIG9mIGR1YWwsIHF1
YWQgYW5kIG5vLXJ4L3R4ICINCj4gPiA+ICsgICAgICAgICAgICAgICAiYXQgdGhlIHNhbWUgdGlt
ZVxuIik7DQo+IA0KPiBDYW4gd2UgYXZvaWQgc3BsaXR0aW5nIHN0cmluZyBsaXRlcmFscyB3aGlj
aCBhcmUgYXNzdW1lZCB0byBiZSBvbiBvbmUgbGluZSB3aGVuDQo+IHByaW50ZWQ/DQoNCkl0IGVu
ZHMgdXAgYXQgYWJvdXQgOTYgY29scywgYnV0IGl0J3Mgd2l0aGluIGxpbWl0cy4NClRoZSBwYXRj
aCBtYXkgaGF2ZSBiZWVuIHdyaXR0ZW4gYmVmb3JlIHRoZSBuZXcgMTAwIGNvbC13aWR0aCBsaW1p
dC4NCg0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0K
