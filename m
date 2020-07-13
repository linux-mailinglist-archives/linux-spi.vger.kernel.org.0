Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E7C21CF95
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jul 2020 08:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgGMGYm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jul 2020 02:24:42 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23706 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgGMGYl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jul 2020 02:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594621480; x=1626157480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JevabZdcZ/K49lBtfjW4K2P4+aSSGDP4/z2Q52i1vSs=;
  b=ThPJP0im/UYpLcr0m3JF48gLGFLSMWp6PzXR/T0VcupuHqlheLmqjGN8
   HiS6I6kLN3UOFrs6qx3t/XM/H+K9un8ZMD3Fvd12X5A/H3L9dmVSMVcpj
   k91xMpdrC3cRIWanSLtZtal+B2eg/GWlN/v4j0SJ8IBpJ16fc+NiQ9IAX
   BBO+dIibY5+oegyEZ9wkeIrUPAHjd/6+AAw6zKvewgQv4yewEQlbxBYR6
   2vsCqIYi0YYDleg9WDSo21UqU+nATZ+Lkt+0Y7/EC7IayvdhNc1V3Bg2o
   NztsQ/OXP6LeMUIdaToEt7mztLy5ede0zAl043QPKRq3nKBlU+Rf6u+Pk
   w==;
IronPort-SDR: XqDggY6UzpA8cHwbIDNum15wnxBsF1TSCEgZFOsuTpCi4EgRAydLkdp4YsGeJO/DaZj/m/10Ez
 P1ULVD7YguLW179PzdWmbt4HR3aD4qvSdEQFjkzQqDiqtBkL+zUz0/rP4bAXt4QZdxznKL/kqt
 4HSkkdEq8NxjVZ9GNVcZfq/XMASMxHNc4namYnzfregYjLBRC8jz6mZaqJBRFUWse9zfCXx8Qu
 xOGmrpGzbrIXc8rDJL0ykO0FwZuP59qnNfV1ik9ojc+wANK65kRs/ngFbciA3PgdM3mmtoeNe1
 I9M=
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="87286966"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2020 23:24:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 12 Jul 2020 23:24:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Sun, 12 Jul 2020 23:24:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8zohyIh3cjb+4D4qk1lyAfI4sLygOqdzItfitpTffqqa0QWb1fJdqlKR6ALkVIlY8pIX6NGfxzCdarZoB07MfHi/a4+6nqCUm8tfgDXMU1cxm8LRrkrjipXL7lzyuFXKqr+P10fyJ0v6eeabeGznP3z1OZdvu0JkUhliP6LXsUtQKvSppk9Nsk+y2aNplbKrdOpPwbYY8H9JISOodGpdgDDymniaWbAVd2ZKB+NyniOIo/fmmaDP54IY+jJf5knmYPD5Y4C+Z2TulD+AXJWTvMtrgHYOfzBeECSDeKBRMd8L00pTHrli62MWwc+3s0HGDcetrH7RNKdnj406d1IBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JevabZdcZ/K49lBtfjW4K2P4+aSSGDP4/z2Q52i1vSs=;
 b=Gep1w5GSLgdWIfEoapsPd69TkGWFEj9N6THxtCZ2KwEbSJFzsHV2xgs/a6Dl0SyqJtHPz8/+yGlxefzZFnYTnLLO+azcjSjmoE1b3t14tYJafln75HLcQsuCz2jHXzXevVqnwN953JrbRbXtJcCAIs05puVSj88wiJshiDwu34XdVqzmjV6cGsedQHAmRBaHd/eYh6OOTGdwlUx9isOrTNtWfAPp/kaNkDVNB9nl6BHMGUxw994z6JxTfHerl+g1MaxCAPSKrDcX5I57FXH7e150tPjWb2CkXkivALfqfrhlSrRzZzZ8tc9Js0s++cKfJ7c3BNA3He6qAIPDAsLwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JevabZdcZ/K49lBtfjW4K2P4+aSSGDP4/z2Q52i1vSs=;
 b=gE1Ju3ZSV/I+/ps1Jd05X7guiGbT8R52F65c4xATV57k2G2qzhUsO0j9SDf4mOoG4zwPFTDKgYjmDnc2CUw7Z0uiBccgosv3denfoNkQPFLTZsEcExPfVdMAU7s/8sZw8k0gGwG3lcFSbL7UcbmcLCS/lIqgC7Q2AX8QwnIiOWk=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB3576.namprd11.prod.outlook.com (2603:10b6:a03:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Mon, 13 Jul
 2020 06:24:37 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 06:24:37 +0000
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
Subject: Re: [PATCH v10 04/17] spi: spi-mtk-nor: reject DTR ops
Thread-Topic: [PATCH v10 04/17] spi: spi-mtk-nor: reject DTR ops
Thread-Index: AQHWWN5HTvB91P8nH0ODLTeFKdlZcQ==
Date:   Mon, 13 Jul 2020 06:24:37 +0000
Message-ID: <b0e86071-2808-ec4b-e09c-3614bc9c205a@microchip.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-5-p.yadav@ti.com>
In-Reply-To: <20200623183030.26591-5-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: 2be7e176-fb07-43df-a9d1-08d826f56ac3
x-ms-traffictypediagnostic: BYAPR11MB3576:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB357640DF67F7B762301963ACF0600@BYAPR11MB3576.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MmQiZpziSInvudUIawGfdeHeTM07DHlBxxtz2Xt+Qczl05ou1xP9LGIIk3E5MhTlnQXV9PU8LWgjd21S4FwBD0+JJ0xVtCCwKS5qHedCBCOzf9llQWVCGanuM2gaJ3ZTDnZvOLyk8+7sEFQRxH1tc3rG9RRaSKbEwXVL00OpGWhRv5VBmGrUyuWy7LoEG3czbXRPp+GRhnnbDJnR6uL6WszwQh/IKK9rn43uWV3X/hku6eLg06ADtDfatW2HkTN55nZ/+a0Zh6xWifmQUfZsBnOhAMqqwzt2HTzwjjgGptDJ1J4RAmP4HMSUjkPPUs9JW1LwqnIsUDzx73HHevsdEK5gQ21plXouRVcIEO8yH3uZqqeaWprH84euVge0yw9xvP30pAfiVcL7bTSfLLsvdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(136003)(39860400002)(396003)(26005)(31686004)(8676002)(2906002)(86362001)(186003)(71200400001)(66476007)(316002)(66556008)(91956017)(64756008)(66446008)(36756003)(6506007)(53546011)(7416002)(478600001)(66946007)(76116006)(4326008)(2616005)(8936002)(54906003)(6486002)(6512007)(110136005)(5660300002)(31696002)(921003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5wwQbZEH24EPqmBAcSW8RkisuKuqo5OEDrjnfVCTKKOqd03Wz76C7E9c+Lc3tE2Ossi7asw6EkRUqvGtyBE5bPBWn1bDGmMYZ8ECpfqTIpXO4eu10IMMBVBTNGsrAovD5Q7fzV1GD362Zzkzc6WSjyG0tyxUdHjGh/dzL0VlMk//ekQyBLSaAp7VbI2gGl9RDBsbTz37iKxi7sF+/VgvrcvJgo6Cydbpxn6sCTMuTePWxOOrP7n7Pnndd+DBl95ejuG3F6QmIJWOhvCa/oVkYzYQLAiI0c0e2t/Hop5T/OVIwudSSwRPN6GoFmXBXx5QltLhFDqKpjPzT2CxJXxi9HYfjd4GVga5OZJJZMCYKXClKdNRY0jzsJbJLg6uDdC6ym0d8VFokUXh+HEvs4QN9OMfCrbMgsgq9Twr3OsfLySRiFQIaC/aYmWHf0yuuHG6lmH8cWo5fjEIKZnMaH+EqqQLHrEuj3J6KYtrD4vmMIx8GJ7/4Vb3uebzZNkXvgFb
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB1940F37E9DE64D91DA79EE22BE5869@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be7e176-fb07-43df-a9d1-08d826f56ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 06:24:37.1117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWa+02RctGgK3t13eefo1T+yNnUnZ8WIwCJ+GRpbPDqpUyv7B6Di92mDDrplQnCtsPU3wvNmA5ittFdOEkjdlBpdreqjD88KHrz6Xt0b8ss=
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
PiBzdXBwb3J0c19vcCgpLCB3aGljaCByZWplY3RzIGFsbCBEVFIgb3BzLCBkbyB0aGF0IGV4cGxp
Y2l0bHkgaW4gb3VyDQo+IHN1cHBvcnRzX29wKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQcmF0
eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVz
IDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3NwaS9z
cGktbXRrLW5vci5jIHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktbXRrLW5vci5jIGIvZHJpdmVy
cy9zcGkvc3BpLW10ay1ub3IuYw0KPiBpbmRleCBkNWYzOTM4NzE2MTkuLmIwOGQ4ZTlhOGVlOSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLW10ay1ub3IuYw0KPiArKysgYi9kcml2ZXJz
L3NwaS9zcGktbXRrLW5vci5jDQo+IEBAIC0yMTEsNiArMjExLDEyIEBAIHN0YXRpYyBib29sIG10
a19ub3Jfc3VwcG9ydHNfb3Aoc3RydWN0IHNwaV9tZW0gKm1lbSwNCj4gICAgICAgICBpZiAob3At
PmNtZC5idXN3aWR0aCAhPSAxKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAN
Cj4gKyAgICAgICAvKiBEVFIgb3BzIG5vdCBzdXBwb3J0ZWQuICovDQo+ICsgICAgICAgaWYgKG9w
LT5jbWQuZHRyIHx8IG9wLT5hZGRyLmR0ciB8fCBvcC0+ZHVtbXkuZHRyIHx8IG9wLT5kYXRhLmR0
cikNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gKyAgICAgICBpZiAob3AtPmNt
ZC5uYnl0ZXMgIT0gMSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gKw0KPiAg
ICAgICAgIGlmICgob3AtPmFkZHIubmJ5dGVzID09IDMpIHx8IChvcC0+YWRkci5uYnl0ZXMgPT0g
NCkpIHsNCj4gICAgICAgICAgICAgICAgIGlmICgob3AtPmRhdGEuZGlyID09IFNQSV9NRU1fREFU
QV9JTikgJiYgbXRrX25vcl9tYXRjaF9yZWFkKG9wKSkNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIHRydWU7DQo+IC0tDQo+IDIuMjcuMA0KPiANCg0K
