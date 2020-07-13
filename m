Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A5521CF89
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jul 2020 08:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgGMGT3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jul 2020 02:19:29 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23215 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgGMGT2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jul 2020 02:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594621168; x=1626157168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DptnLCJ4aXU8eT6B9ZfaMee/mjBzqPKy7dVpkd4LxZw=;
  b=1lwY+onhZ8wvgXt7RCIkVp1ZMTjiVgTHbBt8FmEvyErl+MKbxNYn/teQ
   w2J/X4SMEPrXqpHRAI/GivyvEbykG+TwA2EiwxDVVStTvhdudYfd0asWn
   /RuDco4xxKra7ySyhdJrJIs/G//jg10lfgmH8376PlHkf6xlFq2brdHGU
   HlUQ8qOjEoJONXe8n0MjM7kn0wSanIorjhHD55xY+bneWCgBQ+GU+cYVD
   COhiF0fYLp1ye7uQCMWNlpn+18awLyqSA5AyaqEB2AnRLYcmJnSgO3uGr
   y/Hz8em4Xm1GetbMwFFPuxUVCSzblZsnFDc5FhY7K3URS73XuNTiHbbd5
   g==;
IronPort-SDR: aCKz2aWoGTOckzCFuuY6uprlYS/sTpTqCAa5ic3An2yVhz6buloTC0UAW/R2KPepN7KUv9hZeP
 +MNyY0h18ywTfruG2QwJK5klCsRzKC93T15mI3OGd7un1QH55ih+9RBmloONoUCpDRl+Ta+QKX
 zQGDzgmoNswFAjM9VBc4si6P+ao9WJjbQd4zwBes+CeXuJMOiIK6ne/XgHECuLqIkgr/hclx9a
 G1yV97nw/ZMR0AcERx3emnAn2yIUf0GlyYXLvTC6TrDz316rIl2GvQiRFsrvX8AAZj6BEjordt
 I2w=
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="87286063"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2020 23:19:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 12 Jul 2020 23:18:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Sun, 12 Jul 2020 23:18:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmVcoTdY/FeAsNA8mpzvGf8UJHCnv9VqHUm/lYBJ/oBDVT6lX9vv3ucBAKTWuefR+j5ngCbAB12T2KHl+pqvV0BFfSgvCdwEz1gD3Mam6BvjoUza+8OicSWd7rSpc33Z8uMgoaC6arjKyPCJmBDQ7np/3p73dQN+JBcmpe2dodvaUtVYFl/R7Te/2lDn3m4M6kRgv+NJrDbSvVAtGLTCD3wHBkfEyqSdGZaktlNv5ixQwOWBzJCS4EMkwutZzZkpx2fa9ld3j7ruMq1ydqaOCM0pPAtcidj2htndbIUvIwuABL6PBRxY2SnlNMJ6NqfjY8+Bdq3BTkk6//PiFoEaJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DptnLCJ4aXU8eT6B9ZfaMee/mjBzqPKy7dVpkd4LxZw=;
 b=NSEBRwUhBp0uenB22139r8TG+lYCQqC8wS59rB/KgJV3f/OelULMhvFld3DHb8vVglgH+FMhLBNedHccduViICpEGEKjtMIlNwm+DtK8Fy+IWh5Df/lEglVRNU5D0W0EpLpe/VaUeebO0h5MdqZ9OeRXUH2kLcNflBTF0ZJ1I08hLh8xbfBx2JLcryj143nLpoBwKFt430sw52BZBm2tAgoJArMnihjLJC96aSLFY2VgcElyTm5kDt5zYnbfiSAXo4UM2oc96ltqMPkL1bNzCK5s7TWnA2yrtG+iolKQ6cv9A1jk0e+mBq567F/iuqsEsLAcmYU3EdJkPexLrU1xWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DptnLCJ4aXU8eT6B9ZfaMee/mjBzqPKy7dVpkd4LxZw=;
 b=RkW41z1vV+BDXAlFYgo2Ve3kDUBdIvfu+AkaiaUrMsX1cAumAYiB0kDhe9SVjjaqpm/YN6MX5/PqiqWHs7Snd8F4v3wU93lBNGpMIhuOw5aL5XzWtt8hykdHxEHF/QeJnFfMKRfiIlt1D7CoWEoM9CylLFBLG35wFK1SVqpH2Zc=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB3576.namprd11.prod.outlook.com (2603:10b6:a03:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Mon, 13 Jul
 2020 06:19:25 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 06:19:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <broonie@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <matthias.bgg@gmail.com>,
        <michal.simek@xilinx.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v10 03/17] spi: atmel-quadspi: reject DTR ops
Thread-Topic: [PATCH v10 03/17] spi: atmel-quadspi: reject DTR ops
Thread-Index: AQHWWN2OjiZAyoUj/UaQzlTa4VGA4w==
Date:   Mon, 13 Jul 2020 06:19:25 +0000
Message-ID: <33e2708a-7e69-86c9-089c-2ace27f7768c@microchip.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-4-p.yadav@ti.com>
In-Reply-To: <20200623183030.26591-4-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.120.242.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 977e2248-149b-4766-6285-08d826f4b120
x-ms-traffictypediagnostic: BYAPR11MB3576:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB35762D1B28CE7EABF8850A8DF0600@BYAPR11MB3576.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yemMI/P62AdxmmAJ1aEw4Ziz03WW2gJiqOaPnI7O4GKHQAES/2z0fLHXnxvZOsYluedymS52WWhXfthlyLd2fryyZM2GEQhAJtsnF+vwtZcyVN3WVOJbqqfhjBneElYTNKq83MAwND31YdH+WYoDIXkQAL0Iawagufx1DadVBtII9ZZwnFQfSOo/TGxWOPUaglchlnrHSsUzmx5SSplWZWdry8RWobkmRPjob0DTVy90CfAvMLeMiFQxOb0C4h5Q9zpBXMGVORUfNv/UYPjHvnrbHOJl7c4jkHNIEboxr2ZXlUtzB9QVKd2SJ9ngVvoouFo8TEbXKgUgODfMAKglY3FRNkurdMN8hiXope5uTrz7AmOAzOX3taf8UWWjoE7I7zTQrgRKbcUO8RMbj2+X+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(136003)(346002)(376002)(366004)(54906003)(6486002)(2616005)(4326008)(8936002)(5660300002)(31696002)(110136005)(6512007)(86362001)(186003)(8676002)(2906002)(31686004)(26005)(7416002)(478600001)(36756003)(6506007)(53546011)(76116006)(66946007)(66476007)(71200400001)(316002)(66446008)(66556008)(91956017)(64756008)(921003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: aFvWk89N8Vv82tc85nwySs9c9VYs7Rcp7Mv/5/FVlrJyI9z+/3jlm3fyLuSsplJPQ/8OetY+sg58IajJXJt95KCUcFZkUGB8/e1f6mzGXAIHa7apGFbHSdd06pF2EdsYg2PFkAgJxuqnKxa9vjtzsHj5hn/Jdb6uP6iQhoiPS69aG2/zZ5RV9d40ZEB0QzemeqPss3cxYDzaGG9tOXSv0BTSWJE5vT+KHdSSZRtSfVXVepqDLQ6Z2ocYusO6xTRSqO729qGeE4NwT+Zz7D4puekSHvWITF0yd0+5tfvvQPPnkmyEDWuIHYEgDW/Mvyb0VzH68pXdzhHytxHJSA31NKdVme+DKOlhZ61+FBU/HJPKiX6OwV6N2e3C6KpUXFYiIaFUhbYBNngQHCAuyKMpbVVLGoS0UmlTfoDHqC9xrwH//1yFwLIWSlLdEuY7PlAZOvACTTKTd3nOSAe2hWkLEdGwgEfdiUfyZRzpPJ7XYB0alD0Fq3Nsj72thssJ5I2Q
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A4C109E0E655841BEF0F3AD8CDB724F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977e2248-149b-4766-6285-08d826f4b120
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 06:19:25.6961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b825ytLg/t9jp4cKgBOJdZ3o8F2ZWFDbneZCFCf+w3B92ArPeX4CYd33JrhTX6pcEvNd2eCMmctJT2yleWiyOGe+LFRNyq2pRDD3263wGis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3576
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gNi8yMy8yMCA5OjMwIFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBEb3VibGUgVHJhbnNmZXIgUmF0ZSAoRFRSKSBv
cHMgYXJlIGFkZGVkIGluIHNwaS1tZW0uIEJ1dCB0aGlzIGNvbnRyb2xsZXINCj4gZG9lc24ndCBz
dXBwb3J0IERUUiB0cmFuc2FjdGlvbnMuIFNpbmNlIHdlIGRvbid0IHVzZSB0aGUgZGVmYXVsdA0K
DQp0aGUgc2FtOXg2MCB2ZXJzaW9uIG9mIHRoZSBjb250cm9sbGVyIHN1cHBvcnRzIERUUiBvcHMu
DQoNCj4gc3VwcG9ydHNfb3AoKSwgd2hpY2ggcmVqZWN0cyBhbGwgRFRSIG9wcywgZG8gdGhhdCBl
eHBsaWNpdGx5IGluIG91cg0KPiBzdXBwb3J0c19vcCgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
UHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc3BpL2F0
bWVsLXF1YWRzcGkuYyB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jIGIvZHJp
dmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+IGluZGV4IGNiNDRkMWUxNjlhYS4uYTg5ODc1NWZi
NDFlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMNCj4gKysrIGIv
ZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+IEBAIC0yODUsNiArMjg1LDEyIEBAIHN0YXRp
YyBib29sIGF0bWVsX3FzcGlfc3VwcG9ydHNfb3Aoc3RydWN0IHNwaV9tZW0gKm1lbSwNCj4gICAg
ICAgICAgICAgICAgIG9wLT5kdW1teS5uYnl0ZXMgPT0gMCkNCj4gICAgICAgICAgICAgICAgIHJl
dHVybiBmYWxzZTsNCj4gDQo+ICsgICAgICAgLyogRFRSIG9wcyBub3Qgc3VwcG9ydGVkLiAqLw0K
DQpCZXR0ZXIgdG8gc2F5IHRoYXQgIkRUUiBvcHMgYXJlIG5vdCBpbXBsZW1lbnRlZC4iDQoNCj4g
KyAgICAgICBpZiAob3AtPmNtZC5kdHIgfHwgb3AtPmFkZHIuZHRyIHx8IG9wLT5kdW1teS5kdHIg
fHwgb3AtPmRhdGEuZHRyKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAg
ICAgIGlmIChvcC0+Y21kLm5ieXRlcyAhPSAxKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGZh
bHNlOw0KPiArDQoNCkkgd291bGQgbW92ZSB0aGVzZSB0aGUgZmlyc3QgdGhpbmcgaW4gdGhlIGZ1
bmN0aW9uLCB0byBzcGVlZCB1cCB0aGUgZXhpdC4NCg0KV2l0aCB0aGVzZSBhZGRyZXNzZWQ6DQoN
ClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+
DQoNCj4gICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gIH0NCj4gDQo+IC0tDQo+IDIuMjcuMA0KPiAN
Cg0K
