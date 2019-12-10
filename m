Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2AA118E6C
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 18:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfLJRAx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 12:00:53 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:63039 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfLJRAx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 12:00:53 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 70ky/2HfnOd6p2289zgrMVGqqOm5elFzK9HI61FKpf8XbH9R+z/sIfeP5aIpIkKX2bvBzOak25
 zeIclXeGB1zlLZErhJHBbd2he1g+Z0MjBZ0vAxFhJoKSnnyImDvKxcQEl+NVnDO21t6jwfubcz
 Hhear6cl0ollkGDZMY4scg4TEEZNNMLTUg7IBjX85P8Gp3s97h1bjKff7K0GJ9O15RxN4Ei0QE
 JsYFnQBJ1BZJ9NHXI/ZdcLzZUwiuuEnkFDgnyVqG6hLUwI9EyxxPJnwoEoCtgVTwKZlZsK7n8P
 wDw=
X-IronPort-AV: E=Sophos;i="5.69,300,1571727600"; 
   d="scan'208";a="59880479"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2019 10:00:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Dec 2019 10:00:52 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Dec 2019 10:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5uT9TJbnGONltQESYPjImh3pm6Ix0Jlpw/yH56SBa7VjmeNS6xhwm5L2CMApv6hlOY6nCkWzBb1ch//vqV6Le7oyuihKkj3G7konhVP4fn777ClBwyXYQQAx8AExr7X+dZjMXCmJNBoAF/z6UKJLUVA29/mtLoKBjfIYkNerV1uJOiNWoYB9slXSyrk/Fsta023ydCBHF3peirIg7wVduZ+TdBR+SpcxYVZXP9WH7HwGwslpJNUExvOWT7GbmnZLiOXX62zSM5T5Jq3ZZY3OjAnj5W8m4T6fr1wY5H4thA6jYbTqOdU3r3Pd4t1tn9SWMp4BiPxgfvTZqAsZ6A5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/sArT4hm5xgyAyoMROmaMTv7ehRr4ciPTcpEu3b9DA=;
 b=HheV8CxeaFRRgxwYPFejeLoLU7dVAYw7xfcDgQ8drA4Fk9idsCP3xae8k/IdbTn+GqyAd5cvzdl67xBUVq05WgnVUN1LAvdAt2CCC9K0Cz0jSbUG5ZZUsIrr0iwIeJ3kcNq8GTM4NFASbVsvca6ieKfbOy0tc682/KY9es13KBQ5N8UhN/IIb6gvY/nDXlNetP2IhAlRL2hTsTF2R/FDoto++p+m7BR95DfnQztbzdehGS6H0LsiN1kDs2L5Wfkq1+1eaOA4igT2lq8IoH+JBum39kDDqH4dyJ+6JQm3K8LXoA+8/3Kj8lDqJDDcFvd79ycAwBBDPUOMh8cLTrsAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/sArT4hm5xgyAyoMROmaMTv7ehRr4ciPTcpEu3b9DA=;
 b=FD2vC8pE2f8BjFxG44mpzbPRJpyB7jsYi9cHnzdgwcJNVv4SKSuFDdsLiqRfmOGKb/2G0QI6jcAsS3K/p+c1N1sqeDi0JIUGcFxarZHTnatEjRTx/plZhkw0MGDxI0HqNUpPfNnlk6uAcm277cio8JPUIdeUVbhpHb0u0kSdFeA=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4510.namprd11.prod.outlook.com (52.135.36.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 17:00:45 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::84c:6e75:22df:cbc9]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::84c:6e75:22df:cbc9%5]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 17:00:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <masonccyang@mxic.com.tw>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <vigneshr@ti.com>,
        <bbrezillon@kernel.org>
CC:     <juliensu@mxic.com.tw>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 0/4] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
Thread-Topic: [PATCH 0/4] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
Thread-Index: AQHVm5L7VyzIMa4LwEmZ6LUHKgpgiqezv4sA
Date:   Tue, 10 Dec 2019 17:00:45 +0000
Message-ID: <8f2908ec-6e17-dad1-7f2a-ec22647caecb@microchip.com>
References: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ZR0P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::18) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191210190038828
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe413b73-f0f1-4e8e-7fc5-08d77d927f37
x-ms-traffictypediagnostic: MN2PR11MB4510:
x-microsoft-antispam-prvs: <MN2PR11MB4510C6B3EC937E5FB2B56A49F05B0@MN2PR11MB4510.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(366004)(346002)(396003)(189003)(199004)(5660300002)(52116002)(4744005)(71200400001)(6486002)(6512007)(81156014)(8936002)(53546011)(36756003)(7416002)(31686004)(8676002)(66446008)(64756008)(81166006)(66476007)(66556008)(6506007)(86362001)(4326008)(478600001)(186003)(2616005)(54906003)(26005)(316002)(31696002)(110136005)(66946007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4510;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hc5g0b+X8NkoQYR9k2grD4t9M+U+gqrVGPL2TDfWWMHdcMS95BV/gNcfgWvcqCpbouVW8Nc90KpXw9puXEJJc5VvjWuvlUTm64iAVwWVsef0DHZCTIme9buFnFrUJekkRIjwLUaXX+/CddU+FprlpzVweoYPvXGVsLy0jNxNHmUYLSplSRx+zSsG+/ABJBfcbn9KzebJvueGO6ZwPgkH9gELi8h9kBZDwy8BZwZH+OCJUq0jvuwWgXyTKoXOFYJOIu6aNXurK8U5/S39saHQvljP+Ojp16Bd2ape/g9SLzpY5cG0Ne5DrUWx2W6KR3FbbHOyUmdXr94TSht7BXUz5vnlMWG4EyDQ3eTDE93FcI9uk9p9UWVVk7l/dXkNRdIPfLdhf8fKM7QdGQE3k7h4+zlxF/ebijISbIKhhrNUkeQ3NX8enn6uCoxRF7b5mDnm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3898D962452FFD4FA513E1098B602C40@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe413b73-f0f1-4e8e-7fc5-08d77d927f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 17:00:45.1614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 201sDRL2xOnzwujqSNmZxnEw/lc0XVi9mcX2SSLVPqRwbrJJZOctrZe13qwz8UX4ZoAuVqq62+rVtNwZqQYIlTeomtJ4gGJXljPSJavKa0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4510
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGksIE1hc29uLA0KDQpGcm9tIHRoZSBkaXNjdXNzaW9uIHlvdSBoYWQgd2l0aCBWaWduZXNoLCBJ
IHVuZGVyc3RhbmQgdGhhdCBhIHYyIHdpbGwgZm9sbG93LiBBDQpuaXQgYmVsb3cuDQoNCk9uIDEx
LzE1LzE5IDEwOjU4IEFNLCBNYXNvbiBZYW5nIHdyb3RlOg0KPiBIZWxsbywNCj4gDQo+IFRoaXMg
aXMgcmVwb3N0IG9mIHBhdGNoc2V0IGZyb20gQm9yaXMgQnJlemlsbG9uJ3MNCj4gW1JGQywwMC8x
OF0gbXRkOiBzcGktbm9yOiBQcm9wb3NhbCBmb3IgOC04LTggbW9kZSBzdXBwb3J0IFsxXS4NCj4g
DQoNCltjdXRdDQoNCj4gTWFzb24gWWFuZyAoNCk6DQoNCkRpZCB5b3UgaW50ZW50aW9uYWxseSBv
dmVyd3JpdGUgQm9yaXMncyBhdXRob3JzaGlwPyBJZiB5ZXMsIHdvdWxkIHlvdSBwbGVhc2UNCmRl
c2NyaWJlIHdoYXQgY2hhbmdlZCBmcm9tIEJvcmlzJ3MgcGF0Y2ggc2V0Pw0KDQpDaGVlcnMsDQp0
YQ0K
