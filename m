Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C633884D
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 10:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhCLJJy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 04:09:54 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25894 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhCLJJp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Mar 2021 04:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615540186; x=1647076186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+Zr0m90Iwo5ugq5zr4Qv+z7Raw6AjkrkqyTJcMqNJ90=;
  b=CTemkMmiP/LJQL1bGNUE1Wl5Wim+XIJZHWI4PyrWdwAopAKNxuzpVbeE
   5wNAUrJ6wQVydpwMfzaWWGfqtePHVK0IIQ/xd7jMMhXF/UQKTQcMsNX4S
   NYVPolaPR9EW+nknkjgg51jgd1g1qGbtgDUX/OZACrkTy0maJkniF2pNA
   mW0uq/hjZRK5QLUsFw8pHIUH/43FkOuHz1cl0oz56r8VerPdV44Ld+SaT
   UkRIbr6Up3sBLKF01t6weaYNVeW0PLP+noLKL8T+v6zcnKpAHEzEET6iL
   MPCWJGumKURbE5VK4yal7iGUHSUmSH1wbvDofCO+2ekXsrABn8C62oVw4
   A==;
IronPort-SDR: /IHsVe6lge3Sd+ifgFSgARMMRYxK70PmkppZngswPz11nqPsbkrJXdzBdylk1dT5YJ8gL9Me5m
 mL7vRTGwRsTW6XULZAYIW8znHxh2tzgDSRfiDJ4TtXV10uq9YY/ZRIFUtUytAvEmLFq79uxnnW
 1o9gwMlhCfTmfY8Yrqz4ivRK7mziLknkkGEl+IzBPB0K0s2PzC0XhSMUAU0LlpR0jZ4S5Plafr
 WO5W5quxeTW4JdvLcjgCv1S2baXY4JyOSsrshIWXyac8S60UsxCJoFxepNB/igNWBPlZHIUA/o
 xlY=
X-IronPort-AV: E=Sophos;i="5.81,243,1610434800"; 
   d="scan'208";a="109732665"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Mar 2021 02:09:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 12 Mar 2021 02:09:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 12 Mar 2021 02:09:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfL7gdMTrJ6Sra8Ql5dWga/7qf0SMMc6vJ0RQ/xnV4vwKxz5TlNJJ4kPnhUVsd65c7zlXcp/FBmVWbvHv+ieIT5IhjuAa32sHY+8fJlhzliHkNUS5ehUuV/msv4/osvYQN1OFzeDWWK6uayvnOZPJ1HP1e46vEdbZmy1l52quzg1itBqcvozyArck8KRGEocbdckNErchHC2TWplz8SYHDqe+IOXcAdf+JmrTBY2ZE8EPTLS16349jqAWK7k5cEzrD2LquRVElpDC/US80MB9SWE5uybnN/g7jmI/11TRN5akqThHovXvnbBlWQRrNlxwAYik+lTlR3gGIT2A+HrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Zr0m90Iwo5ugq5zr4Qv+z7Raw6AjkrkqyTJcMqNJ90=;
 b=HBPQC6uO6zRW/YOcRIN0w/TuhdJBSoddOiHR/bPTrxO5gMvDSXghHkt22KiUKv8135Kt1kvlBohhHQNDYrBsuFGV+QJCnq8Rr78LEEgNqiiMQsx0InVg0+r33C5emYuamxDptrIxBNhta3bIPvbDJzClLRY0lDuG/U72ixiMTHCGJz3f1CKND93nuTc7/gB163IxC/hqzDlIKDhPzquuDsIp6vUEp3v3xxMt2kl47dxecgtkz9GQeFaVaarvOkbiFYvRsQ5cCYI3u0kdzVYR9i9RTxMxA06tlTjv+lYaz/qbwmEhlsXCTcsP7LLyMcS3oRPztD4V0poC1NLmzQKQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Zr0m90Iwo5ugq5zr4Qv+z7Raw6AjkrkqyTJcMqNJ90=;
 b=K6bWo2ZCvg4bQSEXO8wQfwf6A3ua/oPVNc8foy+4iVfPaHwMeWgfxKy1USVB8mOmuW1LXW45IZ8V9Gcc5wsok27AxXFiXrjKuO7ZtgSKVHvE2fFORY2pv6c1ynHi7U4qI92Qrtewe7iAtRZJw7nuxZY2WpdEdDHS478B4Gb48WY=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4793.namprd11.prod.outlook.com (2603:10b6:806:fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Fri, 12 Mar
 2021 09:09:42 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::c9e8:9bf4:b08c:c30f%7]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 09:09:42 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC:     <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 0/6] spi: Add OSPI PHY calibration support for
 spi-cadence-quadspi
Thread-Topic: [RFC PATCH 0/6] spi: Add OSPI PHY calibration support for
 spi-cadence-quadspi
Thread-Index: AQHXFx9voVlY5U/87kSEhShnaEXyTw==
Date:   Fri, 12 Mar 2021 09:09:42 +0000
Message-ID: <9c551f56-4c00-b41a-f051-8b7e197fbcdc@microchip.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
In-Reply-To: <20210311191216.7363-1-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4060122-66a4-4a7a-a6b3-08d8e53692af
x-ms-traffictypediagnostic: SA2PR11MB4793:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB4793DB8BED805DB110AB1CD6F06F9@SA2PR11MB4793.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixsd2cgPwumLFT+QoArkVCHx76KBzpZu3aF1rcuZJyR8SepkTffvXhPoXkd7DFjX7wq0Ul9+UCKcD3nHolrvaLc4h65GCIDTI8HaeyRA4YUmXr9OZaf3miZ0ew441qAH3sVTQ+v32wZlKFe9kme7zgycIyVim1DrXso01qxf3P8xPpWXTOtSM8f/8Eu+OjGTkNF5zRoIYKbT1Std82XPApqTRNWUtswMRhvKQxfj51yzFkQxhNbnUNF045Y5GDDUypu7utFvAkrElBlR6eRevrgvIs6kEHYlQWfEcLnwyImf5q8NjNl8M9gbHpnPc3PKmRNBuv8xU2VV2B9ZH5L6qqzQh1LjIsQCqwZ5g5etYXQ0aPmGbm1ddwAhcT07PSNUeslfRZBmD2h26n8VxThcgxUfaESCxDJrMGwxQGy8naoPM83/vFSKNEzsRtgs+K43JycpIGDF7gCqhhs2HHDeV2mju3efe/HhtwpCSTEY9GNf57JXHDaAHyfYuIQJU2Dhkjv4XrlqC6qLZvtu8xVymn4uPQq+FQWae5yB2zB/G2xq68Awh1OyZqJ4AY9hLftcDR0IBQBvBsFvIPaP+qJj64IVHMQnYym6fY/Pq6gmIFaY5qBoQ+fK+Bt8IbVFJdyAFw4uCPkCclQ0zyCtsjlO04TwkUE5KzSxccDDsjeppt7J/9mCuV4ePCKZBlu+8ViaP4TTUwhFLEBrcq1mLr3Y1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(136003)(376002)(366004)(346002)(64756008)(53546011)(36756003)(71200400001)(86362001)(76116006)(6506007)(966005)(186003)(66946007)(31696002)(91956017)(2906002)(8676002)(6512007)(316002)(6486002)(66476007)(110136005)(921005)(66446008)(66556008)(478600001)(4326008)(2616005)(7416002)(8936002)(83380400001)(26005)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SUF1SWlwRDdUTnpnOUUxSEdXRG9KZ0pjdTMwN2dEbEpHUE9sU3NDbkJ2d0dM?=
 =?utf-8?B?L1YxWmZmSCtJakRMWnEweU1XQ1N2ZE41V0swc2FxREVWcUtxV21yc3h5c3ND?=
 =?utf-8?B?cGk3aGhyVTJocDkrbXNnby9uQ3FXdzRBQUdEVGlSVmZGMDNRcksxNENFcWJx?=
 =?utf-8?B?UkNLSHBVbmhFVXgvSTFOcnd2Z3FjOW50ZmNOWjNMY0lZMC9QUXcrbUF6OEFq?=
 =?utf-8?B?SDMzZFRGeFRUVTVpbVQ3bm96aW9lTlc5Q3E1ZnpyL3hRc0dGa2hRc1hmNkRm?=
 =?utf-8?B?QkZjUzM3d2JzOUJGQm40TS8raDZOWGo0N2FUZERXZmlIZ2NnQWxUdjdObVVP?=
 =?utf-8?B?Q1QwR0dIdDBXM0xlTTZUYStvWkhRSG9ER29pLzVGOGN0dVlnSjhmSWRZREsz?=
 =?utf-8?B?bTZqdFR4V1pDcGdzYU16WldJZkVVVXBIWURLSGRNL3pVWEhQZXE2MTJMd3dy?=
 =?utf-8?B?VWlSZURzU1YyRjZWMjNYWUJuRmVReTlqYWQrRUpUbHBsckxaWGsrbkxLZy83?=
 =?utf-8?B?c3JYNXhRU2ZFTjFHK01RRVJtemZ4V0xaSHU3dGx3SjlBR2YxMWlpOVp5QU5q?=
 =?utf-8?B?d3BvYWExemQ4d3RSR2Q0THBwQ3VSbnh5NDNZemJkaVBOTE9scDRjbkNnRkhB?=
 =?utf-8?B?NzI0MWNlOUdVNnRhVDlhVlBrZzh0NU1iSHNCcFFtcEFXcGxzNVJFUmJoZTFv?=
 =?utf-8?B?WGFCWmU5MldYWDJ6UFZFT1VNajZGSTdmY214U0YrSFpIOXJoYnBUNDdldXlO?=
 =?utf-8?B?NEltSW1mMFViaDdJM3RRd1RqQVBFSDBJVWxrMVV4Zzk4c1B3NGxSdGlYc21V?=
 =?utf-8?B?aktWZkxUTjhqc1E3MkdIcFFseWdsUndIZnBQb2dwQUhUTEJkQ0tIbGwyMUlu?=
 =?utf-8?B?WFhPdVU0NjlqRGkrOVBGRlE3YTJWS29iakNKL1p2OS9odkduandYVmMrWGh0?=
 =?utf-8?B?d1hjMmRweDdBRXk4bTNoQVhyNC84M1Fhd1ZYL1d3Ulc5em9ldjhTU20ranBC?=
 =?utf-8?B?cHZqNWYrdkU2bUQvS1dac2NmQXVxejg2NE1vV21JTlMxaHdNd3R5ZkorMEpC?=
 =?utf-8?B?c3IxTFhid2YwT29XK1I1bnp6VzBTRzc3ZnNscU5raDF1bU5YSW1VaWtCK1Fx?=
 =?utf-8?B?amNWMlVUVi9GWHBpQnd1d0V4WXJxYTllZ1gycmY2bG1SV044MUFMSGFJZzMy?=
 =?utf-8?B?YWhCWkVTQmVYS0REMEI1QzgycEhNN3VSUEh0WUw1ZUtJWk1RenJ2QlBRTldU?=
 =?utf-8?B?K2FDT3RSTTJCTjZxNFhOd3NxSkRpSHBvSStpeUxxb0xkSUp6ZitiL1lIcEdi?=
 =?utf-8?B?cVh1S1dqUGE4Nk5VVkVrRDJtNjA5L1F4R3ZJUXBUNXY3RjhjUUM5YXJHaFly?=
 =?utf-8?B?blBlMW4rcXUzN2hOZ3hsNHJzazN5ZENhc1V1UHhhSUtPZ3pmZXl5NFZsM0Jv?=
 =?utf-8?B?RVAyZktDSHV1NjJEMU5lTTBjQXBCaEZmYjhkQkhUSTVtc1N3blhQTmRPTzdx?=
 =?utf-8?B?RUF0WVJVdFlrTW5Bc1NCRTd6YmVwcXQ1cklzVmF6RURQMmlObmNxTnpaajBt?=
 =?utf-8?B?a2dCd0FjdWNzbkJRUDZXZmw1bnZjRDR0U2Y2eFFLVHorYUtGMGtZQnBucXFV?=
 =?utf-8?B?YnBYQ0oxeDQxNXZZV2ZXdC9hcHdvM0lQckwrcyt3Q2tKRUVTVmpFekZ4cms0?=
 =?utf-8?B?Y3lRQ1gzUEFZTllDS01xeVdzc2w2S3JEeWEzKzdiMHp4TmMxNTdDTGFBZEdH?=
 =?utf-8?Q?h2cuBTc36+2WD2vHXE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4A408DB1B61EF4381F9E463C332448E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4060122-66a4-4a7a-a6b3-08d8e53692af
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 09:09:42.4197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aZpRY5ISU8GH84IYIrW++8DkMA3EdlUSAeUplRPt+IPEpnw6Q9+e9dJJ/Cv9SBg6pW8OjlP8EA6dYDvIoy8RZttBJ5M9OqRt/evNBcvHHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4793
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMy8xMS8yMSA5OjEyIFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSwNCj4gDQo+IFRoaXMgc2VyaWVzIGFkZHMg
c3VwcG9ydCBmb3IgT1NQSSBQSFkgY2FsaWJyYXRpb24gb24gdGhlIENhZGVuY2UgT1NQSQ0KPiBj
b250cm9sbGVyLiBUaGlzIGNhbGlicmF0aW9uIHByb2NlZHVyZSBpcyBuZWVkZWQgdG8gYWxsb3cg
aGlnaCBjbG9jaw0KPiBzcGVlZHMgaW4gOEQtOEQtOEQgbW9kZS4gVGhlIHByb2NlZHVyZSByZWFk
cyBzb21lIHByZS1kZXRlcm1pbmVkIHBhdHRlcm4NCj4gZGF0YSBmcm9tIHRoZSBmbGFzaCBhbmQg
cnVucyBhIHNlcXVlbmNlIG9mIHRlc3QgcmVhZHMgdG8gZmluZCBvdXQgdGhlDQo+IG9wdGltYWwg
ZGVsYXlzIGZvciBoaWdoIHNwZWVkIHRyYW5zZmVyLiBNb3JlIGRldGFpbHMgb24gdGhlIGNhbGli
cmF0aW9uDQo+IHByb2NlZHVyZSBpbiBwYXRjaCA1LzYuDQoNCkNhbiB0aGUgY2FsaWJyYXRpb24g
c2VxdWVuY2UgYmUgYXZvaWRlZCBpZiB0aGUgY29udHJvbGxlciBpcyBpbmZvcm1lZA0KYWJvdXQg
dGhlIGZyZXF1ZW5jeSBvbiB3aGljaCB0aGUgZmxhc2ggb3BlcmF0ZXM/DQoNCkNhbiB5b3UgYWRk
IG1vcmUgZGV0YWlscyBhYm91dCB0aGUgb3B0aW1hbCBkZWxheXM/IEFyZSB3ZSB0YWxraW5nIGFi
b3V0DQpmbGFzaCdzIEFDIGNoYXJhY3RlcmlzdGljcz8gSXMgdGhlIGNhbGlicmF0aW9uIHN0aWxs
IG5lZWRlZCBpZiB0aGUgdXBwZXINCmxheWVyIGluZm9ybXMgdGhlIFFTUEkgY29udHJvbGxlciBh
Ym91dCB0aGUgbmVlZGVkIGRlbGF5cz8NCg0KQ2hlZXJzLA0KdGENCg0KPiANCj4gVGhlIG1haW4g
cHJvYmxlbSBoZXJlIGlzIHRlbGxpbmcgdGhlIGNvbnRyb2xsZXIgd2hlcmUgdG8gZmluZCB0aGUN
Cj4gcGF0dGVybiBhbmQgaG93IHRvIHJlYWQgaXQuIFRoaXMgUkZDIHVzZXMgbnZtZW0gY2VsbHMg
d2hpY2ggcG9pbnQgdG8gYQ0KPiBmaXhlZCBwYXJ0aXRpb24gY29udGFpbmluZyB0aGUgZGF0YSB0
byBkbyB0aGUgcmVhZHMuIEl0IGRlcGVuZHMgb24gWzBdDQo+IGFuZCBbMV0uDQo+IA0KPiBUaGUg
b2J2aW91cyBwcm9ibGVtIHdpdGggdGhpcyBpcyBpdCB3b24ndCB3b3JrIHdoZW4gdGhlIHBhcnRp
dGlvbnMgYXJlDQo+IGRlZmluZWQgdmlhIGNvbW1hbmQgbGluZS4gSSBkb24ndCBzZWUgYW55IGdv
b2Qgd2F5IHRvIGFkZCBudm1lbSBjZWxscyB0bw0KPiBjb21tYW5kIGxpbmUgcGFydGl0aW9ucy4g
SSB3b3VsZCBsaWtlIHNvbWUgaGVscCBvciBpZGVhcyBoZXJlLiBXZSBkb24ndA0KPiBuZWNlc3Nh
cmlseSBoYXZlIHRvIHVzZSBudm1lbSBlaXRoZXIuIEFueSB3YXkgdGhhdCBjYW4gY2xlYW5seSBh
bmQNCj4gY29uc2lzdGVudGx5IGxldCB0aGUgY29udHJvbGxlciBmaW5kIG91dCB3aGVyZSB0aGUg
cGF0dGVybiBpcyBzdG9yZWQgaXMNCj4gZ29vZC4NCj4gDQo+IFRoZSBkdHMgcGF0Y2ggZGVwZW5k
cyBvbiBbMl0uDQo+IA0KPiBUZXN0ZWQgb24gVEkncyBKNzIxRSBFVk0uDQo+IA0KPiBbMF0gaHR0
cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LW10ZC9wYXRjaC8yMDIxMDMw
MjE5MDAxMi4xMjU1LTEtemFqZWM1QGdtYWlsLmNvbS8NCj4gWzFdIGh0dHBzOi8vcGF0Y2h3b3Jr
Lm96bGFicy5vcmcvcHJvamVjdC9saW51eC1tdGQvcGF0Y2gvMjAyMTAzMDgwMTE4NTMuMTkzNjAt
MS1hbnN1ZWxzbXRoQGdtYWlsLmNvbS8NCj4gWzJdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC1hcm0ta2VybmVsL3BhdGNoLzIwMjEwMzA1MTUzOTI2LjM0NzktMi1w
LnlhZGF2QHRpLmNvbS8NCj4gDQo+IFByYXR5dXNoIFlhZGF2ICg2KToNCj4gICBzcGk6IHNwaS1t
ZW06IFRlbGwgY29udHJvbGxlciB3aGVuIGRldmljZSBpcyByZWFkeSBmb3IgY2FsaWJyYXRpb24N
Cj4gICBtdGQ6IHNwaS1ub3I6IGNvcmU6IGNvbnNvbGlkYXRlIHJlYWQgb3AgY3JlYXRpb24NCj4g
ICBtdGQ6IHNwaS1ub3I6IGNvcmU6IHJ1biBjYWxpYnJhdGlvbiB3aGVuIGluaXRpYWxpemF0aW9u
IGlzIGRvbmUNCj4gICBzcGk6IGNhZGVuY2UtcXNwaTogVXNlIFBIWSBmb3IgREFDIHJlYWRzIGlm
IHBvc3NpYmxlDQo+ICAgc3BpOiBjYWRlbmNlLXFzcGk6IFR1bmUgUEhZIHRvIGFsbG93IHJ1bm5p
bmcgYXQgaGlnaGVyIGZyZXF1ZW5jaWVzDQo+ICAgYXJtNjQ6IGR0czogdGk6IGszLWo3MjFlLXNv
bS1wMDogRW5hYmxlIFBIWSBjYWxpYnJhdGlvbg0KPiANCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMv
dGkvazMtajcyMWUtc29tLXAwLmR0c2kgfCAgNTUgKysNCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5jICAgICAgICAgICAgICAgICAgfCAgNzQgKy0NCj4gIGRyaXZlcnMvc3BpL3NwaS1jYWRl
bmNlLXF1YWRzcGkuYyAgICAgICAgICAgfCA4MjAgKysrKysrKysrKysrKysrKysrKy0NCj4gIGRy
aXZlcnMvc3BpL3NwaS1tZW0uYyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTIgKw0KPiAgaW5j
bHVkZS9saW51eC9zcGkvc3BpLW1lbS5oICAgICAgICAgICAgICAgICB8ICAgOCArDQo+ICA1IGZp
bGVzIGNoYW5nZWQsIDkxNiBpbnNlcnRpb25zKCspLCA1MyBkZWxldGlvbnMoLSkNCj4gDQo+IC0t
DQo+IDIuMzAuMA0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCj4gDQoNCg==
