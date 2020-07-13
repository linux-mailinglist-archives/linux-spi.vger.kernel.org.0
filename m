Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9B721CFC0
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jul 2020 08:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgGMGeS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jul 2020 02:34:18 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:31587 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgGMGeS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jul 2020 02:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594622058; x=1626158058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HnDMyw3QbHSMXA22QxZVKiRNwhrx8NJYze23R7afQeE=;
  b=y2WeS98oGSvZoW0YSv1biifZ0hmcNN+/MnpumRw+QwWTN9mH8q1BzvXM
   0YQqEjZno0rYN4sqjpVcSQDC5BeCYSjY6bL/6dHXTTnde2jGMuFeCbhgi
   4tpQ5AqbMlryArB9eXDH77831sNBWTVE+hrufPgjcsE/c1wXnh0dmtclO
   hwmLxG6FGV8GMvNoYJDuvSrD4NgHiVyC1qpLJJt/RlAMUfydTUkSPCQDb
   2B6rBoa8dmhKtg6Ewurqq0T+pWnLvsnZZq8NWwkR4H8kyCB4Glx9l1YRY
   IWgGVFtnzGQhkXmaX+AOlxdlknyuvwB+FKST6rQHUdi/ks0mxg8Wo5Afn
   Q==;
IronPort-SDR: 5EunmS7PQ/kq8/op4zlHgx2bmEi+Ar7+qQTW5rF/89RTAjbwmTHaxeWNjEvqIBF4nm2L185bpw
 rcJrcp57c3X+hoL5ui3Zl55biZe9ftSZ0RwPB76Pj4iaNZTBzhelnAU69JHDpGXUoiSU56t5iA
 QJ2Y3YgZYU5AY3okncjEDhMhadCmKWxxgJYTJYb3UffVb7wbpQNHfsLBHEaHVpVhEpKYa8p7MR
 O3AcmhJkiAeNRZsPi0Mv5Pesn30JIDpig8aaue2T/1J661DanyWdoOcMhaoT/LfD3tjPcxke2V
 BAw=
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="82843199"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2020 23:34:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 12 Jul 2020 23:34:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Sun, 12 Jul 2020 23:34:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxH2hqCLWyp4YQUcHsDDoHQ3ZKThcllacFWbHvGp204WWLYJ9A82EwoJMAT83or8JKXV+M4rtHWU3/t7skK2Yjb5AAB7R6gR3zprL6m7I5E4NhiroLLI6WSgAuEXjFwEDIrW9fiAvG25dgu+Na1AOyxnNACewVuZSDI+i01llWSBNNI/dfjpZOmy2VWTROkwy0EiuzG04bNC5nTsL7FXQz7POjl2JcvCu0DJc9o+hukadIpWbN86ab/A3LnkOKqeYv7bqemIh4Grx5P7IW2UcL1MkcGraOuse7xYVJauC/Us8t7qsuFvethQFzJGlu5ZPSXLfgr/RuvzBPy5Yzr9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnDMyw3QbHSMXA22QxZVKiRNwhrx8NJYze23R7afQeE=;
 b=oO8QuTtcsa4tugbDx3mjm7WjT20y6QfQWTaP8PqZc0aurimFrae0/eQesugBhWqJx2BvhhzuuWj+wSClOgX6XbCHPomyw/wyZbmU0lrnd8iTaSLzLMLtpiXdZZqClGtX0Wgg1oIeBF298Ou40AKhAwEBdfBnzjq58Wvea8z75t9sMh2x0pEP/0qDoI7fGzKtBbBRWjU3OHw13fEDhZqNeu5vmN3tpKlCWa48Hbgxq0zvNTav2DpkQqpkuXRERTiqyHCFBGnrIf6DeclL8ZB03lfGHwWAdVAoJqnwTjZL/Zzhp3cbzYM09Zy6wO4OzuUvd9yJc+dzy1pbGaOIeoUmcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnDMyw3QbHSMXA22QxZVKiRNwhrx8NJYze23R7afQeE=;
 b=COgY1lSmWVUMT+RRvySIQGU1NYarcvAtKyyVsZy5JKIpuyhqx/CBxWamrPOe9rYDvQahgr74Iw4DhBghibJ3dYh/WjxjKXucrjvkpC9xWXhK742aJvlWUieVEifImfJ3rnQfrbgmqgC02lpvFIpVIP4ps8+5cKlJW1HbMdQIuIY=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BY5PR11MB4209.namprd11.prod.outlook.com (2603:10b6:a03:1cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Mon, 13 Jul
 2020 06:34:13 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 06:34:13 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <matthias.bgg@gmail.com>,
        <michal.simek@xilinx.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <nsekhar@ti.com>
Subject: Re: [PATCH v10 00/17] mtd: spi-nor: add xSPI Octal DTR support
Thread-Topic: [PATCH v10 00/17] mtd: spi-nor: add xSPI Octal DTR support
Thread-Index: AQHWWN+dU3MRlEjPj0CyeRCYqGYmmg==
Date:   Mon, 13 Jul 2020 06:34:12 +0000
Message-ID: <e6d4c015-b70f-40e3-2275-89d245e817e8@microchip.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
In-Reply-To: <20200623183030.26591-1-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: 82e21053-3635-43dc-2c7f-08d826f6c1ff
x-ms-traffictypediagnostic: BY5PR11MB4209:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB42095D53685EE8AEDE279F42F0600@BY5PR11MB4209.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QijyGuGI4OEbBQqMQV1xedgHIrLvrv+dRHFKtO3fLb3C2xHx1XjPowtaVOmOjHVhMPmjDLPSIh2PcI4bHUqvpKCsgBNIWluQu1ShVx41G7nZ62TJ3QS00uw+RYtu2xEiTxuloouxh8rQLiJUBrmG1FKEbt0Ubo9fzR9BpO/v0hIuQZOiGVOqdl/kewjcyPtyBysIhgw8l7t2F6Jtv/JRm0v9QaaD9Razx5+FUjUdOkLLGL9cIUiBwT/Dk0d8PipABkcu+5QMWD1JDJGboEg+ufwDK+RGEUXqjKV/EA1k4QXkOfiJNi5gQ87EJ7Epq7g34cb+aWPuFIpqZe46tbjo6DoFlyDf7H4MAMLCk8rJAfNoTjBBmH6XTPrgTW27yg0G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(346002)(39860400002)(376002)(5660300002)(4744005)(86362001)(36756003)(66946007)(66476007)(66556008)(66446008)(64756008)(31686004)(91956017)(76116006)(186003)(6486002)(26005)(2616005)(31696002)(7416002)(71200400001)(2906002)(4326008)(6506007)(478600001)(8936002)(6512007)(54906003)(8676002)(53546011)(110136005)(316002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NybGGYnjduU8DXGte2aLD8aoaOzP1tQl5NWVvMG6kmkD40GgigChXBRWXdwiNlEy2jX1hK36VOTmkV5qJ1ghM96pEbbtt2dQMxv0ksKVQvM1xvuL0dX6f1ld1lQAX6FkhQmHvjGgMzqhwr1Zd4xN97R5k+9ngxQ7fvw57jENZR9JfX/SnRqoIR4jDQLMEWNpndRu9aC62RO3FKNSRDbApERfmULJg6rh8aw9Nm+3Z8ekZQJTq2Z2xqy6saSM87rnWmPnOHDug12Gn5itwq6O8/fV1rrpV+dfR8nClxy2vdVx7+/QyMFlS13pALWEhv6n4yCd7oZyo0xsyWk0IMd3VKk94RHpm6vhfueyPZnxCp5fuf1H2DDqbHTy442T8wzYAWt7xQ2Cw1RuvrIlj/Z+JVHsczK2Q6wu/i3XtW6S1iBtKlOuJl70Cgl8qPd6uV7NNPLgrSvgwJltvLTWKaOlQ4yLkvnRLwYUutOLu6q1D5goK8Yt3lj/cEBy8lMmfj3D
Content-Type: text/plain; charset="utf-8"
Content-ID: <39ABED06096FD34F84A063A46A2DB065@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e21053-3635-43dc-2c7f-08d826f6c1ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 06:34:12.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a67yzXmwzKTAvOg7BD+09iwnrmxUf5qassXLlskJr03u0QtgfTdwiwr1kVpYsCUWBC/EdZ4+Hia4i+hjMdfckDTVsvFYzd7k+8S3yySIIs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4209
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGksIE1hcmssDQoNCk9uIDYvMjMvMjAgOTozMCBQTSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+
IFByYXR5dXNoIFlhZGF2ICgxNyk6DQo+ICAgc3BpOiBzcGktbWVtOiBhbGxvdyBzcGVjaWZ5aW5n
IHdoZXRoZXIgYW4gb3AgaXMgRFRSIG9yIG5vdA0KPiAgIHNwaTogc3BpLW1lbTogYWxsb3cgc3Bl
Y2lmeWluZyBhIGNvbW1hbmQncyBleHRlbnNpb24NCj4gICBzcGk6IGF0bWVsLXF1YWRzcGk6IHJl
amVjdCBEVFIgb3BzDQo+ICAgc3BpOiBzcGktbXRrLW5vcjogcmVqZWN0IERUUiBvcHMNCg0KVGhl
c2UgZm91ciBwYXRjaGVzIGFyZSBsb29raW5nIGdvb2QsIEkgaGFkIGp1c3QgZmV3IG1pbm9yIGNv
bW1lbnRzLg0KSWYgeW91IHRvbyB0aGluayB0aGF0IHRoZXkgYXJlIG9rLCB3b3VsZCB5b3UgdGFr
ZSB0aGVtIHRocm91Z2ggdGhlDQpTUEkgdHJlZT8gSWYgc28sIEkgd291bGQgbmVlZCBhbiBpbW11
dGFibGUgdGFnIG9uIHRvcCBvZiB2NS44LXJjMQ0KcHJlZmVyYWJseSwgc28gSSBjYW4gbWVyZ2Ug
dGhlbSBiYWNrIHRvIFNQSSBOT1IgYW5kIGNvbnRpbnVlIHRoZQ0KZGV2ZWxvcG1lbnQgb24gdG9w
IG9mIHRoZW0uDQoNCkxldCB1cyBrbm93IGlmIHlvdSB3YW50IHVzIHRvIHJlc3VibWl0IGZvciB0
aG9zZSBtaW5vciBjb21tZW50cy4NCg0KQ2hlZXJzLA0KdGENCg==
