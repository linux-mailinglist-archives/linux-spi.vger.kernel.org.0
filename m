Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186231ECCF5
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jun 2020 11:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFCJus (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 05:50:48 -0400
Received: from mail-vi1eur05on2048.outbound.protection.outlook.com ([40.107.21.48]:6042
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbgFCJus (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Jun 2020 05:50:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPe1DWyIfEJp+qiYpQnUFG0YlE6mS9E1aC8gi0T74OH/SdpUKCquAbArKMGHYO6FzuZra7xuU7YlsVvytbt3ASNh7VycvwM+wClOcyLNMD6Qh+x2Yla3ZPxPCo32pETAmYe6KbCtE48DZQvblTcL34l4fiIcHz44VuYABypn6yZcWqGdDWu4HS4uvmHSvVM4B1/8nkdOcVVMjjRm179SOZdZjUmWwmkp8A9Wyx0CWWncAnE+dKh0QHf4v5mkR6ihLz1ovn2OhV+lJA3WOLz4swqPgo7WsfE8afV5Y37QuR6+Aw7NefNIIrK4V8miBlFLVVuHRKlGamLzBkZHA16UaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwHA3CGnK9Mmhv6co31I8SWxE8BGy7VQvg2l451y9rg=;
 b=ie3VfJxtsHISX6BZcrVfHZvDby5U8UOZFcQYwySb8xeuR5AJu58I4wEuphHd2fuEEv96dGeTG0qQqEcHMY4whwk/pQXbuvcVyvAHDfTDJ/IUd3Yct5AjzH/C9w5oZXK8F1cs0B6MVNIE/uJOuW9B4/khNheJuhC1oFIlwS1IFGfHvS21QDpVxSjxQ7SrJgu27FVDczUV8FQ4JzciLXbit0XshCeQ8vU1RqXqijHVEtrLvv6RSt2PxfORMfak+6dhAwL9ffRsl7tTERaBxZ6cA7td6T/AMhCEWw3wHMWSSAyMNv9dyG9+dITp+6qMNztujpvHp1etiX6DVs4kx1HcbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwHA3CGnK9Mmhv6co31I8SWxE8BGy7VQvg2l451y9rg=;
 b=s1hwnqWBhpiX1d+ovtqq3ctb3Nkn1BUCFYUlXcbGhz37CHnJG+23Mx2xKbby8FoyYf9ImhldDgqxVPUDNnHrqrZIQT0mUK8YQ97JATfZKUebUPn5Hx/Vp4MZf7J8tUyKnR8s18tFgdRc7ccvr8IWAlksfGKSUfJWo2iqIqaLZnI=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6653.eurprd04.prod.outlook.com (2603:10a6:803:122::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 09:50:42 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 09:50:42 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Markus Niebel <Markus.Niebel@tq-group.com>
Subject: RE: (EXT) [PATCH v8 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: (EXT) [PATCH v8 00/13] add ecspi ERR009165 for i.mx6/7 soc
 family
Thread-Index: AQHWLqLtpxY1VGgarkKW6xpO4wG5Z6jGpXaAgAABPHA=
Date:   Wed, 3 Jun 2020 09:50:42 +0000
Message-ID: <VE1PR04MB663883F25395B3ECEC66384489880@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
 <5d246dd81607bb6e5cb9af86ad4e53f7a7a99c50.camel@ew.tq-group.com>
In-Reply-To: <5d246dd81607bb6e5cb9af86ad4e53f7a7a99c50.camel@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ew.tq-group.com; dkim=none (message not signed)
 header.d=none;ew.tq-group.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.235.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d160257f-7701-4631-cf65-08d807a3949f
x-ms-traffictypediagnostic: VE1PR04MB6653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB66537E4F283E9EE211D9E37489880@VE1PR04MB6653.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8sqfZLK4sU6M13UaUhHHlNifbKOjbI1kkjOyBYIfKrHvgw8xMR9+xOMra+/7+cRwUf3MJ5MRmsprYM1VgzW0dM1hD+Ouq33w+VGQJsAvsN3acM49ffmEeFLS/WMM8pEl4MglkvWd01MJga/gXx7UInlVJm0oIvB6MwTk/a+ae12F9qCGwfSZlQMDoaD95Z7XRJ3KKZ17a3PISrrBQuKPI7LAfq3thS1Xx/chTF2xALeAlPDRzQlNcHUwlOeNsA6g88qYfrLn47NwUnUVn02oDkfj1Ygfh56UJ74BxZD6Y7GNovd2XqE0x9LrFeqkMUdH4pd2NEfJ5nmG3PGybepDoXEzcyJvNfsXCP1sfHZ6rAa9i6Ko7m6ObfZkUHxVRXUv5vZOUOv7IstEfILx49PSpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(66476007)(4326008)(64756008)(66556008)(83380400001)(55016002)(7696005)(9686003)(7416002)(5660300002)(52536014)(33656002)(66446008)(76116006)(66946007)(6916009)(6506007)(186003)(71200400001)(83080400001)(478600001)(45080400002)(8676002)(316002)(26005)(86362001)(8936002)(54906003)(966005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4mscULsWNOtNo3JbRHaDqYVxemp649Rn/X/n9ePu6f7sxoeaEZsSdD6tvmZ3C/wuQ2zU72rskyeNiYE+kVayDk3kMOObg0EmOw/Zf/D34nHWro4em55aprur3UxbNlK8UhwtK3uD07kwrIRl/C5Usn2V7GJF5l4CKUP8oTiHMGj3M65cRCUMZiu6ztQ/L4s6MbdR4DxWTZK+0b6nZYyBRAP9wdK9gbpNdQdITy72bd46/4CEwUKtRPPMA7MwHi8y4aaorv+O5fqcStX0jJ9KKmuLziO2kzM49Dfdk90iZl4gaW8AccNJJz4i+OhM3JtD4di3i/nZB/ipAD1G5lD4Wx3p67FO3/lNw0iIpk9/nzwZdCEJ9c/J2aA3vFD/eGqei6N7TojlfUzmp36yuHOz1E7juXRObML1cipNOyo7aiITEjdgtI7Zuj54we4SBlCo821wbLg3/ndT2M6kdOSfdfMdGMFn0gYo87jCdYzmHsC2QswW/Hfja7odZFoy3+c3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d160257f-7701-4631-cf65-08d807a3949f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 09:50:42.6870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHlK3KziwLJg5y+nK6uZL8k3S4zn5Vmbvz5XwIJtwluSnfBUnlUrynyV1kuBiXdub1Y6hjexXY3Euj7dMDsj1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6653
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMjAyMC8wNi8wMyBNYXR0aGlhcyBTY2hpZmZlciA8bWF0dGhpYXMuc2NoaWZmZXJAZXcudHEt
Z3JvdXAuY29tPiB3cm90ZToNCiA+IE9uIFRodSwgMjAyMC0wNS0yMSBhdCAwNDozNCArMDgwMCwg
Um9iaW4gR29uZyB3cm90ZToNCj4gPiBUaGVyZSBpcyBlY3NwaSBFUlIwMDkxNjUgb24gaS5teDYv
NyBzb2MgZmFtaWx5LCB3aGljaCBjYXVzZSBGSUZPDQo+ID4gdHJhbnNmZXIgdG8gYmUgc2VuZCB0
d2ljZSBpbiBETUEgbW9kZS4gUGxlYXNlIGdldCBtb3JlIGluZm9ybWF0aW9uDQo+ID4gZnJvbToN
Cj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZ3d3cuDQo+ID4NCj4gbnhwLmNvbSUyRmRvY3MlMkZlbiUyRmVycmF0YSUy
RklNWDZEUUNFLnBkZiZhbXA7ZGF0YT0wMiU3QzAxJTdDDQo+IHlpYmluLmcNCj4gPg0KPiBvbmcl
NDBueHAuY29tJTdDNDYyMTM1OGI5YmUwNGE3OWQyZDUwOGQ4MDc5ODgzNWIlN0M2ODZlYTFkM2Jj
MmINCj4gNGM2ZmE5Mg0KPiA+DQo+IGNkOTljNWMzMDE2MzUlN0MwJTdDMSU3QzYzNzI2NzY5ODkx
MjYzNDQ3NiZhbXA7c2RhdGE9aFI2NkgxaFAlDQo+IDJGcWI2T1hlDQo+ID4gdzl3cFhpelk4RGlO
ZlpaMUtMd3UzS3R5ODdqYyUzRCZhbXA7cmVzZXJ2ZWQ9MC4gVGhlIHdvcmthcm91bmQgaXMNCj4g
PiBhZGRpbmcgbmV3IHNkbWEgcmFtIHNjcmlwdCB3aGljaCB3b3JrcyBpbiBYQ0ggIG1vZGUgYXMg
UElPIGluc2lkZSBzZG1hDQo+ID4gaW5zdGVhZCBvZiBTTUMgbW9kZSwgbWVhbndoaWxlLCAnVFhf
VEhSRVNIT0xEJyBzaG91bGQgYmUgMC4gVGhlIGlzc3VlDQo+IHNob3VsZCBiZSBleGlzdCBvbiBh
bGwgbGVnYWN5IGkubXg2Lzcgc29jIGZhbWlseSBiZWZvcmUgaS5teDZ1bC4NCj4gPiBOWFAgZml4
IHRoaXMgZGVzaWduIGlzc3VlIGZyb20gaS5teDZ1bCwgc28gbmV3ZXIgY2hpcHMgaW5jbHVkaW5n
DQo+ID4gaS5teDZ1bC8gNnVsbC82c2xsIGRvIG5vdCBuZWVkIHRoaXMgd29ya2Fyb3VkIGFueW1v
cmUuIEFsbCBvdGhlcg0KPiA+IGkubXg2LzcvOCBjaGlwcyBzdGlsbCBuZWVkIHRoaXMgd29ya2Fy
b3VkLiBUaGlzIHBhdGNoIHNldCBhZGQgbmV3DQo+ID4gJ2ZzbCxpbXg2dWwtZWNzcGknDQo+ID4g
Zm9yIGVjc3BpIGRyaXZlciBhbmQgJ2Vjc3BpX2ZpeGVkJyBpbiBzZG1hIGRyaXZlciB0byBjaG9v
c2UgaWYgbmVlZA0KPiA+IGVycmF0YSBvciBub3QuDQo+ID4gVGhlIGZpcnN0IHR3byByZXZlcnRl
ZCBwYXRjaGVzIHNob3VsZCBiZSB0aGUgc2FtZSBpc3N1ZSwgdGhvdWdoLCBpdA0KPiA+IHNlZW1z
ICdmaXhlZCcgYnkgY2hhbmdpbmcgdG8gb3RoZXIgc2hwIHNjcmlwdC4gSG9wZSBTZWFuIG9yIFNh
c2NoYQ0KPiA+IGNvdWxkIGhhdmUgdGhlIGNoYW5jZSB0byB0ZXN0IHRoaXMgcGF0Y2ggc2V0IGlm
IGNvdWxkIGZpeCB0aGVpcg0KPiA+IGlzc3Vlcy4NCj4gPiBCZXNpZGVzLCBlbmFibGUgc2RtYSBz
dXBwb3J0IGZvciBpLm14OG1tLzhtcSBhbmQgZml4IGVjc3BpMSBub3Qgd29yaw0KPiA+IG9uIGku
bXg4bW0gYmVjYXVzZSB0aGUgZXZlbnQgaWQgaXMgemVyby4NCj4gPg0KPiA+IFBTOg0KPiA+ICAg
IFBsZWFzZSBnZXQgc2RtYSBmaXJtd2FyZSBmcm9tIGJlbG93IGxpbnV4LWZpcm13YXJlIGFuZCBj
b3B5IGl0IHRvDQo+ID4geW91ciBsb2NhbCByb290ZnMgL2xpYi9maXJtd2FyZS9pbXgvc2RtYS4N
Cj4gDQo+IA0KPiBIZWxsbyBSb2JpbiwNCj4gDQo+IHdlIGhhdmUgdHJpZWQgb3V0IHRoaXMgc2Vy
aWVzLCBhbmQgdGhlcmUgc2VlbXMgdG8gYmUgYW4gaXNzdWUgd2l0aCB0aGUNCj4gUElPIGZhbGxi
YWNrLiBXZSBhcmUgdGVzdGluZyBvbiBhbiBpLk1YNlEgYm9hcmQsIGFuZCBvdXIga2VybmVsIGlz
IGENCj4gbW9zdGx5LXVubW9kaWZpZWQgNS40LCBvbiB3aGljaCB3ZSBiYWNrcG9ydGVkIGFsbCBT
RE1BIHBhdGNoZXMgZnJvbQ0KPiBuZXh0LTIwMjAwNjAyIChpbXgtc2RtYS5jIGlzIGlkZW50aWNh
bCB0byBuZXh0LTIwMjAwNjAyIHZlcnNpb24pLCBhbmQNCj4gdGhlbiBhcHBsaWVkIHRoaXMgd2hv
bGUgc2VyaWVzLg0KPiANCj4gV2UgYnVpbGQgdGhlIFNETUEgZHJpdmVyIGFzIGEga2VybmVsIG1v
ZHVsZSwgd2hpY2ggaXMgbG9hZGVkIGJ5IHVkZXYsDQo+IHNvIHRoZSByb290IGZpbGVzeXN0ZW0g
aXMgcmVhZHkgYW5kIHRoZSBTRE1BIGZpcm13YXJlIGNhbiBiZSBsb2FkZWQuDQo+IFRoZSBiZWhh
dmlvdXIgd2UncmUgc2VlaW5nIGlzIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiAxLiBBcyBsb25nIGFz
IHRoZSBTRE1BIGRyaXZlciBpcyBub3QgbG9hZGVkLCBpbml0aWFsaXppbmcgc3BpX2lteCB3aWxs
DQo+IGJlIGRlZmVycmVkDQo+IDIuIGlteF9zZG1hIGlzIGxvYWRlZC4gVGhlIFNETUEgZmlybXdh
cmUgaXMgbm90IHlldCBsb2FkZWQgYXQgdGhpcw0KPiBwb2ludA0KPiAzLiBzcGlfaW14IGlzIGlu
aXRpYWxpemVkIGFuZCBhbiBTUEktTk9SIGZsYXNoIGlzIHByb2JlZC4gVG8gbG9hZCB0aGUNCj4g
QkZQVCwgdGhlIGRyaXZlciB3aWxsIGF0dGVtcHQgdG8gdXNlIERNQTsgdGhpcyB3aWxsIGZhaWwg
d2l0aCBFSU5WQUwgYXMNCj4gbG9uZyBhcyB0aGUgU0RNQSBmaXJtd2FyZSBpcyBub3QgcmVhZHks
IHNvIHRoZSBmYWxsYmFjayB0byBQSU8gaGFwcGVucw0KPiAoNC4gU0RNQSBmaXJtd2FyZSBpcyBy
ZWFkeSwgc3Vic2VxdWVudCBTUEkgdHJhbnNmZXJzIHVzZSBETUEpDQo+IA0KPiBUaGUgcHJvYmxl
bSBoYXBwZW5zIGluIHN0ZXAgMzogV2hlbmV2ZXIgdGhlIGRyaXZlciBmYWxscyBiYWNrIHRvIFBJ
TywNCj4gdGhlIHJlY2VpdmVkIGRhdGEgaXMgY29ycnVwdC4gVGhlIGJlaGF2aW91ciBpcyBzcGVj
aWZpYyB0byB0aGUNCj4gZmFsbGJhY2s6IFdoZW4gSSBkaXNhYmxlIERNQSBjb21wbGV0ZWx5IHZp
YSBzcGlfaW14LnVzZV9kbWEsIG9yIHdoZW4NCj4gdGhlIHRpbWluZyBpcyBsdWNreSBhbmQgdGhl
IFNETUEgZmlybXdhcmUgZ2V0cyBsb2FkZWQgYmVmb3JlIHRoZSBmbGFzaA0KPiBpcyBwcm9iZWQs
IG5vIGNvcnJ1cHRpb24gY2FuIGJlIG9ic2VydmVkLg0KVGhhbmtzIE1hdHRoaWFzLCB3b3VsZCB5
b3UgbGlrZSBwb3N0IGxvZz8NCg0K
