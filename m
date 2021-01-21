Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C442FE98B
	for <lists+linux-spi@lfdr.de>; Thu, 21 Jan 2021 13:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbhAUMCC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Jan 2021 07:02:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:18184 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbhAUMBs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Jan 2021 07:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611230507; x=1642766507;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CMWfx3A6aT4NDPYFjqvsDMn0oZZ5OV8znqKm/8bsxj4=;
  b=cfqOySULOwZtAFsc84ybM5gj6ivDdS+3Ale0sXbZCPJuLK5I6Cc9WK4F
   auNHT3CbokbfBTlLZ0UfnlmrpA/7Fdce8325JunyiLIX+RPI8Uf5bkQZu
   kRpaaAkBXumUbaOetvPdULuCueh0A+my1XkREZsxLtawyQXggBKwzgTis
   itvl/YccurF2EH8G3+rvTRdOWSNvyXwfqn/Qxv2XWllOPYSGUWAEpN6of
   Fc4+AEX+JdaTMyaJ9xVhjMP1ZlDjnj5gz0teNztP25FVXrVMEaQQC9c3o
   bQGiRoy3U9F5Cn2W65BQk3WwEpllHdpWYwIWQ20rNakqMXfesaJeTqsAO
   A==;
IronPort-SDR: 5bKVP8BHyrVBsQdgfbs4zJg1alQp4oeL+wg70gmgNhpHtlXW0yLI3Zmoh8WP6rEQlVj8xfFRB5
 uTW1MTUWpLk7XIVPAWBkXOInUPWwNFrySaSlW3sT/BK7i4Et1MovkXZWamYjsO1MJZ1IC7jyqK
 FFDdS0UM47vX3myflLj5DQhGjAH5ddMXDf79v8umkJTkiNAg+HsjX/pkCUt7HYhxLEpEMqEXT2
 nzDi68UypARng882Hxsy5FXrgxDQjWDoc6W3erh6o8gKe5GarPbHEMKLyhJcDcV3xLLHN7cqsH
 1VA=
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="106765255"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2021 05:00:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 Jan 2021 05:00:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 21 Jan 2021 05:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExDs2D4bcfCwcgK/zjRzgyo4jrqpUwYMLWyTwu4L+AY8puXGfGc/LRQqAV1+UbnbrwCSd8VY0DZqz1snd4diTaIcje2v1TxE78F8PQVCD6ozmVwrglu9SzIr+ISRLM8SGBzV7+KksmtmgwSfaC7UlMdJZFlVFqVw8YI25AW6iz+17IjNBFbf0B0MhhV+HMBUrW03YKmhzE8jczBSjFYH6RyJLlEWavteqJjkEWjvLIbtsYNGjOf9TMQh8bKPH596t0Flun14DxjFGnZSBmIBYGLaJlMKKYEsdauztJyMIO5mO16KDcDM7FrroXaAvIwqecJHzP+yzT9fHL3sAJjdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMWfx3A6aT4NDPYFjqvsDMn0oZZ5OV8znqKm/8bsxj4=;
 b=THY16/brULVAEnniLLybL00mxQVaV0eOsh7rOgG2jERRGL1W6m3FPfjbsLfB9rMvzcUpyMGtfi8SSQMEV6//5ivw6O4nV6pEUgmFsr5Iz/cf6bGPou0vNT9ztqR4vxrmabFJBUFZ+WghsedPGb7HU1bXskcTi2Pu7iPqcveryaGcjC+a0k4SygjRTDoTcISFtblBaE9MkxQ1hIdtXveIGOUJYCEoYkSHdWLBB1YOE321v/KESYO4QzDq/dBxkHkdEujBoUKFnR1jbZu+jOLWxtehSF7P+6Zui1MTtw/AEKqMZV1AYfH0NOK8JW7zh8lWEpKuAcRDBi640EhAlM02IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMWfx3A6aT4NDPYFjqvsDMn0oZZ5OV8znqKm/8bsxj4=;
 b=OnJb/NeLA5ptgkQVGOe7WbG7K5DT02oW9N/xBT6JWY9Mes2btT88Fu7HN6kNDdGMiY8D+xkauPs1+OPzsZMuth1UB1TejfnpFVZGCcEjdKmFW8k/FsqHXJh1avvTqexlJl5uuwbZ12bUzp9CUwQAY7/LFzrVWtes6vu+FrXxH3A=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5164.namprd11.prod.outlook.com (2603:10b6:806:f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 21 Jan
 2021 12:00:26 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%3]) with mapi id 15.20.3784.011; Thu, 21 Jan 2021
 12:00:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bianpan2016@163.com>, <broonie@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <cyrille.pitchen@atmel.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] spi: atmel: Put allocated master before return
Thread-Topic: [PATCH 1/1] spi: atmel: Put allocated master before return
Thread-Index: AQHW7+0ACAcb+DnGD0eZiezcRIDUdg==
Date:   Thu, 21 Jan 2021 12:00:25 +0000
Message-ID: <812b9c86-22fc-f59d-7f31-cfea4c07f708@microchip.com>
References: <20210120050025.25426-1-bianpan2016@163.com>
In-Reply-To: <20210120050025.25426-1-bianpan2016@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27b7aeb3-e3df-4187-64ba-08d8be0423b2
x-ms-traffictypediagnostic: SA2PR11MB5164:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB5164D3B94A4E3806D13EDA21F0A19@SA2PR11MB5164.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:357;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dwsawfWR+IjxLAq9A9ZyPtRAko2QaldAuBubmLHBNRstFQJbQXDlkJl/eM7zWuYxFeeHgPXchX7BOyfXtNd4qmOWyyz379VWJYuxeHmX/6yiNZeMggzWIqUZrwX7qzCtAkiS33L/dW6v8D72WU8IM2ncc6JaaZd4o+dEdLzQl/3F3u4h3GgVwOF9mmYj/GI04Yvk68QNyYtrjH4X/z4fgFpPcN6NhTMz1YPM/DKFQIPKiNIlk9gjCyOg2QoXn44Lf5kH+kZb/aT0Rx9EwlIfz8LFPlTVVGRicnMmC9YPzAbUtKKUYiEJNvzP0eP8D9HaTHhmNzjwvIl1so7W+EzTPBYyAMIIfj91/6M7D1MUkPEYpswQJxLg34YKrvA7OxJytNqOogJdNrzjHJjDCZQxXE5s/wJewyOxfhvlyZ4r79ETd0amstuvpYKlyQVun6romLHtemZJ8tcgu88WrTg3UZOanfFk9fXOLB1xroNG7ZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(83380400001)(2616005)(6506007)(186003)(498600001)(8676002)(53546011)(31686004)(26005)(2906002)(64756008)(110136005)(66446008)(54906003)(31696002)(71200400001)(4326008)(6486002)(66476007)(91956017)(66556008)(5660300002)(66946007)(76116006)(8936002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?KzlwZTc4Mld5cVk4dmhVbm5FTCt5N29RZVNES0FpYnVKa25aM2k5WU1xckdh?=
 =?utf-8?B?NFo1UjRzaFo1eUNUMWF1akpCWmovNkJzRWh5eSsxcHUxVjBGRGtRenZxc01H?=
 =?utf-8?B?U1gwNm13REt4c3pCcmNKc0lpMVk3Vk4vYm9JWG1TQXplYTBNMEhQRzAvMU5J?=
 =?utf-8?B?VFNIRSthUTBYN0xmV201bFhQY0RIalZyQjdYQzZqQ05ZOUJydWlTMTkrMDAr?=
 =?utf-8?B?TzJBbnk1UDY0V3BPM1dCUk85K09MVGZ3RzIrcFVma29BUXh0RWh3N2cxbXhP?=
 =?utf-8?B?TDB0YnUzNnpJVGp2TDdJb0xFSmdLekZPRGc4SWJpWDVaMkJtK0UweHdXeXpu?=
 =?utf-8?B?aTlaVFRMOFR6LzVVaVdsNmVtV050eWhieVV4Wkp6dTFZVlZ6SzNGYlVmTjZO?=
 =?utf-8?B?ekNLQmVaT3IwT25IOFpvSTF6Mm82eGFEcXpmT3Y3RXQzVnlDMjNqSVg0UzJu?=
 =?utf-8?B?T3NHWGpqWHc2VTN5YktSYzBBd2dIMDFqaEx4YXQvcWx0L2VmVUUzd1pRaHFz?=
 =?utf-8?B?OFRVb1lDZmIzaFZtNGc2clpDZFVXT0dQQVhaV21Ic0EzN0R6S1dZYnhBK1Bz?=
 =?utf-8?B?RVo5ZzVtY3BGVHM1eFg3eTFIVHlEVmp4cjUyNDRGa2JqUW5jWVdqVVliQ293?=
 =?utf-8?B?VjRpTXcxS1JPcW1wKzRpUXlrQ1piK0RWNStSbU02UzZ3VStyQnhFYjYxcnRr?=
 =?utf-8?B?TnBaTklDUUhmczkreHNBNjhZR09TSElXeHh6WkFJZ0V4aGUwTUt6RHZEeC8v?=
 =?utf-8?B?d3ZST2dNSmx6NjJhdEc3NHpyMk5SSkJNMHpneDlpclVwR3RFWHQ1ZTFLZjFE?=
 =?utf-8?B?bkFVTEY3Q0JnLytiYnF5SVNuRU5idDJ5ZEhVYlZ0MEJ0UEtLaEE5TjJhbjBl?=
 =?utf-8?B?RDhNMmI5SmtIdVNtT1pYeFg5RDNwdGVsSlZnVVY5bXJ0d2hqS3N6QmtyUXB2?=
 =?utf-8?B?SFFkd1B4K0lFUFBCRThUTmFRcFExcDNtT29CMzluMmoxMjNFWUR1WndWQWpK?=
 =?utf-8?B?YkFGSHU2dWlMMUxtTE1CY1dzK0xOc3BnZzFSaTNkRTZLTWVSWlJtclNmYnFG?=
 =?utf-8?B?cGI2OUdtZit6TFdpZTdVWU5ickNTSFlwZHZyVUpIOTNjVi8zZXJaaFhPcDhT?=
 =?utf-8?B?Q0FwVllyZzdCM25oSVRBVE5EWXgzMzZWSDhFb0R5MThpTng3ZnljcXl2OG5T?=
 =?utf-8?B?dTN3RU5DWm4wNStIdEJQTElTQ2hSWGVSYjA3NDBLNVV1V1IzaGt0bk1aZFZt?=
 =?utf-8?B?NWk2elJCNVZCOUNXaHA2YkpEdVU5VkkrajVaTjM5eU5ISEZYWXVFa0JENlNw?=
 =?utf-8?B?aXMzMkdmL0V6THlGM3ZHVEZSb2YwRjJKYm1sbG9CT1cwaEsvZHlrUCs4N09i?=
 =?utf-8?Q?fNUc6jxVehXv/RtcQRVImekFBOZa5rGM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99C5FE15FC13F049870EF63221FD2503@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b7aeb3-e3df-4187-64ba-08d8be0423b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 12:00:25.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5LkTOK5d4zldZFtFPmVgTms2Ro0RIrBzfEW+8TaIpv3eWpE7C/Bz7iIEqKqEHZM9pOoNgvEbz7qKl1sPRt8guTWukLhQ4TTqrFSiIQgD4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5164
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMS8yMC8yMSA3OjAwIEFNLCBQYW4gQmlhbiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgYWxsb2NhdGVkIG1hc3RlciBpcyBub3QgcmVsZWFz
ZWQuIEdvdG8gZXJyb3IgaGFuZGxpbmcgbGFiZWwgcmF0aGVyDQo+IHRoYW4gZGlyZWN0bHkgcmV0
dXJuLg0KPiANCj4gRml4ZXM6IDA0MjQyY2E0ZTg5MSAoInNwaTogYXRtZWw6IFVzZSBTUEkgY29y
ZSBETUEgbWFwcGluZyBmcmFtZXdvcmsiKQ0KVGhlIGNvcnJlY3QgZml4ZXMgdGFnIGlzOg0KRml4
ZXM6IDVlOWFmMzdlNDZiYyAoInNwaTogYXRtZWw6IGludHJvZHVjZSBwcm9iZSBkZWZlcnJpbmci
KQ0KDQpXaXRoIHRoaXMgYWRkcmVzc2VkLCBvbmUgY2FuIGFkZDoNClJldmlld2VkLWJ5OiBUdWRv
ciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gU2lnbmVkLW9mZi1i
eTogUGFuIEJpYW4gPGJpYW5wYW4yMDE2QDE2My5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zcGkv
c3BpLWF0bWVsLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktYXRtZWwuYyBi
L2RyaXZlcnMvc3BpL3NwaS1hdG1lbC5jDQo+IGluZGV4IDk0ODM5NmIzODJkNy4uZjQyOTQzNjA4
MmFmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktYXRtZWwuYw0KPiArKysgYi9kcml2
ZXJzL3NwaS9zcGktYXRtZWwuYw0KPiBAQCAtMTU5MCw3ICsxNTkwLDcgQEAgc3RhdGljIGludCBh
dG1lbF9zcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICAg
ICAgICAgIGlmIChyZXQgPT0gMCkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBhcy0+dXNl
X2RtYSA9IHRydWU7DQo+ICAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKHJldCA9PSAtRVBST0JF
X0RFRkVSKSB7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0X3VubWFwX3JlZ3M7DQo+ICAgICAgICAgICAgICAg
ICB9DQo+ICAgICAgICAgfSBlbHNlIGlmIChhcy0+Y2Fwcy5oYXNfcGRjX3N1cHBvcnQpIHsNCj4g
ICAgICAgICAgICAgICAgIGFzLT51c2VfcGRjID0gdHJ1ZTsNCj4gLS0NCj4gMi4xNy4xDQo+IA0K
PiANCg0K
