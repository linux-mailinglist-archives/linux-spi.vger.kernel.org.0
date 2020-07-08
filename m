Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783B5218CE4
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbgGHQWp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 12:22:45 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:21241 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbgGHQWp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jul 2020 12:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594225363; x=1625761363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ix4gTCSof5dy+v+Gil0mgVSTSi2mz8M767Bp24baUS8=;
  b=mwJ98NNsAUS5OamX4PsNu5jFZnZ8iCGkfxahc62ZXb7edAHcOsHFf0io
   WA4edfvic2EYzK1XHc2ZfS6vEbKhCDFQKKqwP+zpdWe66lI13jTCsTMIq
   Eum1qP3ymn1WmyonmD4ZCKdvdFdnanGw2+gZSbhpr0evngkG6f5z3EEGb
   3vCFKT68IDp7Ig2+TN/l/HbJaFqCM5OdqKNeunfd7XdWikENPwjLFLnun
   nWeXBLJggpCjPyzjEhyEuX5+/IrYS5KsSiq1mjtab5e0zVRHNEAa+5pSh
   XYjDFHFLF3XOZV/g/RuNpEpnFbbJ6FVCNHaEHqve2H/FK8gQNbZV2DDr+
   w==;
IronPort-SDR: URNNe5lIz8bdugS41XkoCIJPARLTvqbAX2MUUXa5Uf1EKr1TIqNwFzY4nZWAhKMQYolb6J9aFC
 QXLk3E7nxbNrzgfD6eujPxQZHM9aOvV1kf03BMlc/RnCTwomXjg8tp7JsyBcO4dxmjMBMl+na7
 TQ8r6UwDiKN8l+4OqDdTpk1VrU+7+j3yqAVsG3/MWX73MbDNrmNzchZ3g4x/2tMgUQ/R92F2x/
 R0+JtomnQ9HqkH5VBfDC2yKhGjwcUTmtONwNaWS/qeUko54JNmNdxG/Yqnl3Us5y7jrqoqXoyF
 J4c=
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="79173523"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2020 09:22:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 8 Jul 2020 09:22:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 8 Jul 2020 09:22:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeCKkEUnpWO4onYLIHJMhc8najPI+7egm03AnRQokZPoaFDtAjG3iO3YszfuCwtwArK5OwLFhPoOAMb2LtQHc+Dkjw2gLwprkPlfbgJw6Gs31GZNAc0X+f3tTfj2VD+s1TL/f6QQFLCoeL71Nr2a1a9Z2H22gUJwj5wR9BIUZrZkpyrRody6wBGu63n5FeN2T5vCTL4MBS8wJmv2HVALilTQRv8zdO6hjX+KZcqm1fDeT+o1w+ewclflL0AhBC5+j4vXxQpqa8QdmkgCI5tCi3z3S6SDiOekIXYKxLUAc/nAPuXHT9EXn6kJYZbG/IX1Lf+Kc2MsvL6MNarBdlH7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix4gTCSof5dy+v+Gil0mgVSTSi2mz8M767Bp24baUS8=;
 b=KyIQM8xPC7ks8ZykKla4b4urbnVxk2OTsZVvm5WPr7iSyIbUlrgihBcck+ULaQ8iTGY+vqyg7+2e2X9/rzLpNsCNf5cQw/WCEoAGJ8KkBWAOsqylTudVdQDn+6GHtZKB8Snld8hnp+mzfCm6Rpf7P65vFumBOfCnQIkbbe6pd2sL3lEJrxyPJqedJy3kYfVZ5gTukUkPN3f1+ywehQI7frW6h4dejFeZRDwLEllHnw6AL3O84A6onDZpZOdW3utoq1xOUHfv6o0sEwpQ1peY6THjX0Mx6guDRqSnxySjpRsQsLYXRyXQiWKNK9JIYMV9962vKayuCG3kDtFXbbj2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix4gTCSof5dy+v+Gil0mgVSTSi2mz8M767Bp24baUS8=;
 b=heIpfoivxn/cmfB6q4saJ8D3LQS2piVilPZysPkAsn5iGcu6LFoEwZ8R7jQRcFLzEgMr5rv1CuJ7sh847+aUuuqLrMxV4j9ckXq/bFaquAWyp+MMdjqJ3L+rEI2J068jEPtlPWvcEH7ZE2HFSj8HXh8BSN6oZ2DTnwKKVML4YUE=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB2870.namprd11.prod.outlook.com (2603:10b6:a02:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Wed, 8 Jul
 2020 16:22:41 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 16:22:41 +0000
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
Subject: Re: [PATCH v10 01/17] spi: spi-mem: allow specifying whether an op is
 DTR or not
Thread-Topic: [PATCH v10 01/17] spi: spi-mem: allow specifying whether an op
 is DTR or not
Thread-Index: AQHWVUQAL5FGGK8980aliLC/F11sVA==
Date:   Wed, 8 Jul 2020 16:22:41 +0000
Message-ID: <c795bdfb-2acb-1496-9d40-045e00556346@microchip.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-2-p.yadav@ti.com>
In-Reply-To: <20200623183030.26591-2-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c27ad3d8-b2eb-40b7-1279-08d8235b2381
x-ms-traffictypediagnostic: BYAPR11MB2870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB28703FEBEFA37B3E7397B155F0670@BYAPR11MB2870.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s3vrfTBJU9cIk4zrY9odxDYdFL5l6tF+Ncr1crnAmrddi3KDCcx34hQVbpkyEZT6xBdoj3MhqH+IBQubGQqpwDfOLmXED+epkexRr+XSXSSff6ddhHMDnwqCk29vYA6yb0KXWiOoC4ujFjMMpAhT0l0QPSqKSjGpucutVg7Kt6hahJqMo/y3dcxATJV4FDE+mGrtmUZWB2WSMq3PmilaxDBxUd3VnWjl6HfT0E0x7iJa0ZaKDrM+cUaC0ezWNNzMnC6NyERyHkxKk21yrlVU19kTOM3vAxgukk/63HrpHWZZSxw/IOVY+1hXKJS7URzUiTowtI1ib95aBMXt4wHrpwghgiHhvRc+p5lr+xkat+Qb2Ay/qheVUabR5x4IfeT1rUFp4XyORAT9K5IObTYC+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(396003)(346002)(376002)(31696002)(66446008)(6512007)(66556008)(36756003)(6486002)(110136005)(7416002)(54906003)(4326008)(5660300002)(86362001)(76116006)(2616005)(66946007)(316002)(8936002)(31686004)(8676002)(66476007)(478600001)(186003)(53546011)(6506007)(26005)(64756008)(4744005)(91956017)(71200400001)(2906002)(921003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EzmseE/hKiptJbykOfo8N5tv+ihQWaX+pxLh0ObTIPlXttUlV1IRtnnmlQ8XLZ/lqG/jp50VVR4L9whyaRWsumSqzTPw6je1Jprw6Ra31MRcnCd1tLkcfp976Trj0dOub2Eb/+lGfIfB31PFrfwvd63W7qixdFDTLljT1sS1dRh0dyosmV6YYk2NWF+goM32H5rpzZwMvpsvJf9Ew9qKfpFCYh7aKh+o4aXnPtU6FJK5oViESETRkAJOovCAboeZwSftAYWzcTlfWEmT24MldhDksDuvinPOWk43Z1mtuBHc+yz4p1qe3K81fzhvi3whqvN1cBPQ7q5818S1ohlPCPzKxgm6T4QC5TFuehhkXww0vIO+BMOjHPBRg6cDOFDifgpGvbREFJkydSbJ1fKTduJ3MiCplZiS0i3+milI6G1zlunEvhLcFzTbANBd6PjW8QHV8TCYK5G6izDzl5HdbNmqueK/A/LI9MC+sV+B0fo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52435D2550C6564695CAE7098AB19FAD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27ad3d8-b2eb-40b7-1279-08d8235b2381
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 16:22:41.6553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2f5uPbHCZFE+sa2vivsosBWKPbAgL0sKYJz9f4YNWFE8GtABTA50r3j9Kw+yZkt6uX8dZn+9av1/Orq+Jr4nYmk2r/0rhs71BrXDKtIENQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2870
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gNi8yMy8yMCA5OjMwIFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBFYWNoIHBoYXNlIGlzIGdpdmVuIGEgc2VwYXJh
dGUgJ2R0cicgZmllbGQgc28gbWl4ZWQgcHJvdG9jb2xzIGxpa2UNCj4gNFMtNEQtNEQgY2FuIGJl
IHN1cHBvcnRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2
QHRpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWlj
cm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvc3BpL3NwaS1tZW0uYyAgICAgICB8IDMg
KysrDQo+ICBpbmNsdWRlL2xpbnV4L3NwaS9zcGktbWVtLmggfCA4ICsrKysrKysrDQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4NCg0K
