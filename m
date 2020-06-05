Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA941EEF98
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 04:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgFECpI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 22:45:08 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:6102
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbgFECpH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Jun 2020 22:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obetVqD4RNh7E8pj6LY2dakfGi07eW+YDP+Wd5NtTxQkvoNDP0cfhjUErj7ubzZK1TPcEl4IBkSrXmYUX3EiButMJJLDuxkUlZApLwqBex/+ygnirjf/tC1sTJOVvMO/dfxkCbvesBiEckjc4/l0PlVvRS0TD+ogT3O+yN+I54rQufgrAEYVt45S0UqJyeaNJaJhEawzbbD2Uu+6Ijl9tXu0k+JCQDqItlOiBxAvh8Mkzlo4/Wsi4QlesJoEyqz9XYvMww3xUWEK2Qah0yHvyjEre8VQ2EF9oxKWMJLSesTz2R2wmq5TKgp/UmCpNveoVnIQCXiG6+bRqyc3S/qFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TRR96uiRUpbu2rO7P/vHHZlXPzBOCYoj+2lqdt1AK4=;
 b=EJgJ9hjhfvchYasuDPVyOGDjCVFCRymYfOpUrWIGD0nCq8zU04rKxG809gno8OiD9CYboIQ3i43iNgbVj8tI7mXwrhgJc7UHuO92piH0zW/4/lvzTK+1gxRNKRVp0Ek+cqkyfMlyhFHz1rvO+JO2ExUNw5nWMQJAHg0xyZWOwYBNUTRJGivRBeoodyatvdEAidZSlqwLNaWQVyhzATDYpy+0paCOYShQBiRII4QvmNuOx4eA9hdEUUrNczuNvBJo1d4q8jmZHpEHktHNWSRY+NjxWAN9AQL58xGdCNuyO9PFBfPo34uMvqiHyOzxL8QHaluBtkw5h6TBJhwdiLKrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TRR96uiRUpbu2rO7P/vHHZlXPzBOCYoj+2lqdt1AK4=;
 b=sdXcoCNF4e4nDa467QyyPOEch4SJuMNT1OmHqo25FsLrUN6dAPcHf1mxR9qehwi16YHIycXvvzhSpl3+YskHV30oOO0MH3K5u7LeTHdDk0fqWyOGOpW6WbA0hJKeJ45NOIwLaX+ZvF5nSfnEPxM4sdmIg8yr0AeJQWyTg6pSeHc=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6448.eurprd04.prod.outlook.com (2603:10a6:803:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 02:45:01 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 02:45:01 +0000
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
Subject: RE: [PATCH v8 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v8 00/13] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHWOZ0g0QVCNDQ3Ykil4no/axscHqjItCoQ
Date:   Fri, 5 Jun 2020 02:45:01 +0000
Message-ID: <VE1PR04MB6638463E7E6577E84F8D1FF589860@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
         <5d246dd81607bb6e5cb9af86ad4e53f7a7a99c50.camel@ew.tq-group.com>
         <VE1PR04MB663883F25395B3ECEC66384489880@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <7cb6cf02fc7cf860d1da7ba889887e79623e71a9.camel@ew.tq-group.com>
In-Reply-To: <7cb6cf02fc7cf860d1da7ba889887e79623e71a9.camel@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: ew.tq-group.com; dkim=none (message not signed)
 header.d=none;ew.tq-group.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ceeda3c-eb40-46f2-786d-08d808fa718a
x-ms-traffictypediagnostic: VE1PR04MB6448:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB64485170139E10AA5817A34289860@VE1PR04MB6448.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zxJST1+yrWefOFIGdA8KKiS4MSZ5JAIsW9iCUWiDQZufu1Uq3y/ul+10tw6fKjn2/oy1el0DSV7LYPSBvZ/Wr9rRfbnqZzZm8lnPZB+cwjxpHp9ik1rApwmaHPuVrXJEhJvYqyF47NfruOyO7pRLnzCfDmHZMUoffMayQmhovaZqNkXg4sZp50PZVq1XHLtH8L/iwOCUVfwB9jI0Kc81w4dGCJYDXJeRz4sMuvdJlJ2vRxep5AzKm8ic16lWripnBapGYVRQqBJAw8tlz5Zm0OdZExLBgfpE5FM1p5c5hxpoYKq9dllEYPwfrWrRdTrA5Pj2ajSgj0ZbWn7j0KE7Fw6phSvTdu4kIJ7cpTNqKNGvPZW9JS4GQTzF5cdP+uqdNuPScTscLV36wiedjPAIpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(316002)(2906002)(33656002)(966005)(83080400001)(83380400001)(54906003)(478600001)(55016002)(7696005)(66446008)(9686003)(86362001)(6506007)(76116006)(66616009)(8936002)(66946007)(99936003)(64756008)(8676002)(66476007)(66556008)(4326008)(26005)(186003)(45080400002)(7416002)(52536014)(71200400001)(6916009)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: M4n/UPoVvsEKcDp6r/ZAgSqxz5g0pVDcRl0VfE2Lvjdceiq/8S/Z1er2Vib9xU3Z7jMIYBSksyaN4SiE9novhZv1FbZnUR8nq4uZcUpgct0BRbpmvOUZ+vlmy/peRPPysNtYOkuIYcPIpactFZhd0d6O6RDN0zyg/LnsGmqJfqf/HW1HNVFcJIpZMcO5CXkSsqNzBWcyX98O7qFWcVMLCvtaHgqary2oMGYtsJqdqzM1FkcFcST5BFWq+JOuSa4HjMXKqI/zphm3klEFj6VVR9zUyodqJU5WuTK6/Xx2Y7LhhWHiB1ivuVQzCtbcAXBz3OOrIF0rXo5tvpckKUe8PXGt1HYviN9sYHocRin5Yk9Nu/Eex+CM4/LEUtTxdIzQSs7nyvp1PnyiamyEcWNA9cke5SnEaxrfA03snY24C0YL90Aa/3eRijXBtOrbT0uQI4kq34N195xgBpX0Z2ct401oBmEDnHb8k0ohbVnRFZ8=
Content-Type: multipart/mixed;
        boundary="_002_VE1PR04MB6638463E7E6577E84F8D1FF589860VE1PR04MB6638eurp_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceeda3c-eb40-46f2-786d-08d808fa718a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 02:45:01.1212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isMj17Kway+C0LN5xqjEfCaVxEKOt1iTu4KzYSS4nzYL3vribT1u/A8FOu52fASjuCvwqnxF1rkMvaQZgKdLzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6448
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--_002_VE1PR04MB6638463E7E6577E84F8D1FF589860VE1PR04MB6638eurp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMjAyMC8wNi8wMyBNYXR0aGlhcyBTY2hpZmZlciA8bWF0dGhpYXMuc2NoaWZmZXJAZXcudHEt
Z3JvdXAuY29tPiB3cm90ZToNCj4gT24gV2VkLCAyMDIwLTA2LTAzIGF0IDA5OjUwICswMDAwLCBS
b2JpbiBHb25nIHdyb3RlOg0KPiA+IE9uIDIwMjAvMDYvMDMgTWF0dGhpYXMgU2NoaWZmZXIgPG1h
dHRoaWFzLnNjaGlmZmVyQGV3LnRxLWdyb3VwLmNvbT4NCj4gPiB3cm90ZToNCj4gPiAgPiBPbiBU
aHUsIDIwMjAtMDUtMjEgYXQgMDQ6MzQgKzA4MDAsIFJvYmluIEdvbmcgd3JvdGU6DQo+ID4gPiA+
IFRoZXJlIGlzIGVjc3BpIEVSUjAwOTE2NSBvbiBpLm14Ni83IHNvYyBmYW1pbHksIHdoaWNoIGNh
dXNlIEZJRk8NCj4gPiA+ID4gdHJhbnNmZXIgdG8gYmUgc2VuZCB0d2ljZSBpbiBETUEgbW9kZS4g
UGxlYXNlIGdldCBtb3JlIGluZm9ybWF0aW9uDQo+ID4gPiA+IGZyb206DQo+ID4gPiA+DQo+IGh0
dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRnd3dw0KPiA+ID4gPiAuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4NCj4gbnhwLmNvbSUy
RmRvY3MlMkZlbiUyRmVycmF0YSUyRklNWDZEUUNFLnBkZiZhbXA7ZGF0YT0wMiU3QzAxJTdDDQo+
ID4gPiB5aWJpbi5nDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4NCj4gb25nJTQwbnhwLmNvbSU3QzQ2
MjEzNThiOWJlMDRhNzlkMmQ1MDhkODA3OTg4MzViJTdDNjg2ZWExZDNiYzJiDQo+ID4gPiA0YzZm
YTkyDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4NCj4gY2Q5OWM1YzMwMTYzNSU3QzAlN0MxJTdDNjM3
MjY3Njk4OTEyNjM0NDc2JmFtcDtzZGF0YT1oUjY2SDFoUCUNCj4gPiA+IDJGcWI2T1hlDQo+ID4g
PiA+IHc5d3BYaXpZOERpTmZaWjFLTHd1M0t0eTg3amMlM0QmYW1wO3Jlc2VydmVkPTAuIFRoZSB3
b3JrYXJvdW5kDQo+IGlzDQo+ID4gPiA+IGFkZGluZyBuZXcgc2RtYSByYW0gc2NyaXB0IHdoaWNo
IHdvcmtzIGluIFhDSCAgbW9kZSBhcyBQSU8gaW5zaWRlDQo+ID4gPiA+IHNkbWEgaW5zdGVhZCBv
ZiBTTUMgbW9kZSwgbWVhbndoaWxlLCAnVFhfVEhSRVNIT0xEJyBzaG91bGQgYmUgMC4NCj4gPiA+
ID4gVGhlIGlzc3VlDQo+ID4gPg0KPiA+ID4gc2hvdWxkIGJlIGV4aXN0IG9uIGFsbCBsZWdhY3kg
aS5teDYvNyBzb2MgZmFtaWx5IGJlZm9yZSBpLm14NnVsLg0KPiA+ID4gPiBOWFAgZml4IHRoaXMg
ZGVzaWduIGlzc3VlIGZyb20gaS5teDZ1bCwgc28gbmV3ZXIgY2hpcHMgaW5jbHVkaW5nDQo+ID4g
PiA+IGkubXg2dWwvIDZ1bGwvNnNsbCBkbyBub3QgbmVlZCB0aGlzIHdvcmthcm91ZCBhbnltb3Jl
LiBBbGwgb3RoZXINCj4gPiA+ID4gaS5teDYvNy84IGNoaXBzIHN0aWxsIG5lZWQgdGhpcyB3b3Jr
YXJvdWQuIFRoaXMgcGF0Y2ggc2V0IGFkZCBuZXcNCj4gPiA+ID4gJ2ZzbCxpbXg2dWwtZWNzcGkn
DQo+ID4gPiA+IGZvciBlY3NwaSBkcml2ZXIgYW5kICdlY3NwaV9maXhlZCcgaW4gc2RtYSBkcml2
ZXIgdG8gY2hvb3NlIGlmDQo+ID4gPiA+IG5lZWQgZXJyYXRhIG9yIG5vdC4NCj4gPiA+ID4gVGhl
IGZpcnN0IHR3byByZXZlcnRlZCBwYXRjaGVzIHNob3VsZCBiZSB0aGUgc2FtZSBpc3N1ZSwgdGhv
dWdoLA0KPiA+ID4gPiBpdCBzZWVtcyAnZml4ZWQnIGJ5IGNoYW5naW5nIHRvIG90aGVyIHNocCBz
Y3JpcHQuIEhvcGUgU2VhbiBvcg0KPiA+ID4gPiBTYXNjaGEgY291bGQgaGF2ZSB0aGUgY2hhbmNl
IHRvIHRlc3QgdGhpcyBwYXRjaCBzZXQgaWYgY291bGQgZml4DQo+ID4gPiA+IHRoZWlyIGlzc3Vl
cy4NCj4gPiA+ID4gQmVzaWRlcywgZW5hYmxlIHNkbWEgc3VwcG9ydCBmb3IgaS5teDhtbS84bXEg
YW5kIGZpeCBlY3NwaTEgbm90DQo+ID4gPiA+IHdvcmsgb24gaS5teDhtbSBiZWNhdXNlIHRoZSBl
dmVudCBpZCBpcyB6ZXJvLg0KPiA+ID4gPg0KPiA+ID4gPiBQUzoNCj4gPiA+ID4gICAgUGxlYXNl
IGdldCBzZG1hIGZpcm13YXJlIGZyb20gYmVsb3cgbGludXgtZmlybXdhcmUgYW5kIGNvcHkgaXQN
Cj4gPiA+ID4gdG8geW91ciBsb2NhbCByb290ZnMgL2xpYi9maXJtd2FyZS9pbXgvc2RtYS4NCj4g
PiA+DQo+ID4gPg0KPiA+ID4gSGVsbG8gUm9iaW4sDQo+ID4gPg0KPiA+ID4gd2UgaGF2ZSB0cmll
ZCBvdXQgdGhpcyBzZXJpZXMsIGFuZCB0aGVyZSBzZWVtcyB0byBiZSBhbiBpc3N1ZSB3aXRoDQo+
ID4gPiB0aGUNCj4gPiA+IFBJTyBmYWxsYmFjay4gV2UgYXJlIHRlc3Rpbmcgb24gYW4gaS5NWDZR
IGJvYXJkLCBhbmQgb3VyIGtlcm5lbCBpcw0KPiA+ID4gYQ0KPiA+ID4gbW9zdGx5LXVubW9kaWZp
ZWQgNS40LCBvbiB3aGljaCB3ZSBiYWNrcG9ydGVkIGFsbCBTRE1BIHBhdGNoZXMgZnJvbQ0KPiA+
ID4gbmV4dC0yMDIwMDYwMiAoaW14LXNkbWEuYyBpcyBpZGVudGljYWwgdG8gbmV4dC0yMDIwMDYw
MiB2ZXJzaW9uKSwNCj4gPiA+IGFuZA0KPiA+ID4gdGhlbiBhcHBsaWVkIHRoaXMgd2hvbGUgc2Vy
aWVzLg0KPiA+ID4NCj4gPiA+IFdlIGJ1aWxkIHRoZSBTRE1BIGRyaXZlciBhcyBhIGtlcm5lbCBt
b2R1bGUsIHdoaWNoIGlzIGxvYWRlZCBieQ0KPiA+ID4gdWRldiwNCj4gPiA+IHNvIHRoZSByb290
IGZpbGVzeXN0ZW0gaXMgcmVhZHkgYW5kIHRoZSBTRE1BIGZpcm13YXJlIGNhbiBiZQ0KPiA+ID4g
bG9hZGVkLg0KPiA+ID4gVGhlIGJlaGF2aW91ciB3ZSdyZSBzZWVpbmcgaXMgdGhlIGZvbGxvd2lu
ZzoNCj4gPiA+DQo+ID4gPiAxLiBBcyBsb25nIGFzIHRoZSBTRE1BIGRyaXZlciBpcyBub3QgbG9h
ZGVkLCBpbml0aWFsaXppbmcgc3BpX2lteA0KPiA+ID4gd2lsbA0KPiA+ID4gYmUgZGVmZXJyZWQN
Cj4gPiA+IDIuIGlteF9zZG1hIGlzIGxvYWRlZC4gVGhlIFNETUEgZmlybXdhcmUgaXMgbm90IHll
dCBsb2FkZWQgYXQgdGhpcw0KPiA+ID4gcG9pbnQNCj4gPiA+IDMuIHNwaV9pbXggaXMgaW5pdGlh
bGl6ZWQgYW5kIGFuIFNQSS1OT1IgZmxhc2ggaXMgcHJvYmVkLiBUbyBsb2FkDQo+ID4gPiB0aGUN
Cj4gPiA+IEJGUFQsIHRoZSBkcml2ZXIgd2lsbCBhdHRlbXB0IHRvIHVzZSBETUE7IHRoaXMgd2ls
bCBmYWlsIHdpdGgNCj4gPiA+IEVJTlZBTCBhcw0KPiA+ID4gbG9uZyBhcyB0aGUgU0RNQSBmaXJt
d2FyZSBpcyBub3QgcmVhZHksIHNvIHRoZSBmYWxsYmFjayB0byBQSU8NCj4gPiA+IGhhcHBlbnMN
Cj4gPiA+ICg0LiBTRE1BIGZpcm13YXJlIGlzIHJlYWR5LCBzdWJzZXF1ZW50IFNQSSB0cmFuc2Zl
cnMgdXNlIERNQSkNCj4gPiA+DQo+ID4gPiBUaGUgcHJvYmxlbSBoYXBwZW5zIGluIHN0ZXAgMzog
V2hlbmV2ZXIgdGhlIGRyaXZlciBmYWxscyBiYWNrIHRvDQo+ID4gPiBQSU8sDQo+ID4gPiB0aGUg
cmVjZWl2ZWQgZGF0YSBpcyBjb3JydXB0LiBUaGUgYmVoYXZpb3VyIGlzIHNwZWNpZmljIHRvIHRo
ZQ0KPiA+ID4gZmFsbGJhY2s6IFdoZW4gSSBkaXNhYmxlIERNQSBjb21wbGV0ZWx5IHZpYSBzcGlf
aW14LnVzZV9kbWEsIG9yDQo+ID4gPiB3aGVuDQo+ID4gPiB0aGUgdGltaW5nIGlzIGx1Y2t5IGFu
ZCB0aGUgU0RNQSBmaXJtd2FyZSBnZXRzIGxvYWRlZCBiZWZvcmUgdGhlDQo+ID4gPiBmbGFzaA0K
PiA+ID4gaXMgcHJvYmVkLCBubyBjb3JydXB0aW9uIGNhbiBiZSBvYnNlcnZlZC4NCj4gPg0KPiA+
IFRoYW5rcyBNYXR0aGlhcywgd291bGQgeW91IGxpa2UgcG9zdCBsb2c/DQo+ID4NCj4gDQo+IEkg
aGF2ZSBhdHRhY2hlZCB0aGUgZm9sbG93aW5nIGxvZyBmaWxlczoNCj4gLSBwaW8ubG9nOiBETUEg
ZGlzYWJsZWQgdmlhIG1vZHVsZSBwYXJhbWV0ZXINCj4gLSBkbWEubG9nOiAibHVja3kiIHRpbWlu
ZywgU0RNQSBmaXJtd2FyZSBsb2FkZWQgYmVmb3JlIFNQSS1OT1IgcHJvYmUNCj4gLSBmYWxsYmFj
ay5sb2c6IERNQS0+UElPIGZhbGxiYWNrDQo+IA0KPiBUaGUgbG9ncyBpbmNsdWRlIHNvbWUgYWRk
aXRpb25hbCBsb2cgbWVzc2FnZXM6DQo+IC0gUmV0dXJuIHZhbHVlIG9mIHNwaV9pbXhfZG1hX3Ry
YW5zZmVyKCkgYmVmb3JlIFBJTyBmYWxsYmFjaw0KPiAtIFNQSS1OT1IgU0ZQVCBkdW1wDQo+IA0K
PiBJdCBjYW4gYmUgc2VlbiB0aGF0IHRoZSBCRlBUIGRhdGEgaXMgaWRlbnRpY2FsIGluIHBpby5s
b2cgYW5kIGRtYS5sb2csDQo+IGFuZCBkaWZmZXJzIGFsbW9zdCBjb21wbGV0ZWx5IGluIGZhbGxi
YWNrLmxvZy4gVGhlIGNvcnJ1cHRlZCBkYXRhIHNlZW1zDQo+IHRvIGJlIHJhbmRvbSwgb3IgdW5p
bml0aWFsaXplZCBtZW1vcnk7IGl0IGRpZmZlcnMgd2l0aCBldmVyeSBib290Lg0KV291bGQgeW91
IHBsZWFzZSBoYXZlIGEgdHJ5IHdpdGggdGhlIGF0dGFjaGVkIHBhdGNoPyBUaGFua3MuDQo=

--_002_VE1PR04MB6638463E7E6577E84F8D1FF589860VE1PR04MB6638eurp_
Content-Type: application/octet-stream;
	name="0006-spi-imx-add-dma_sync_sg_for_device-after-fallback-fr.patch"
Content-Description:
 0006-spi-imx-add-dma_sync_sg_for_device-after-fallback-fr.patch
Content-Disposition: attachment;
	filename="0006-spi-imx-add-dma_sync_sg_for_device-after-fallback-fr.patch";
	size=1526; creation-date="Fri, 05 Jun 2020 02:44:39 GMT";
	modification-date="Fri, 05 Jun 2020 02:44:39 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwOGJlY2VjMTY1YjE1NjYzZmFmZWE1MmUzZGM2ZWQ1NDgyYWQzNjUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+CkRhdGU6
IEZyaSwgNSBKdW4gMjAyMCAwODo1NzoxOSArMDgwMApTdWJqZWN0OiBbUEFUQ0ggdjkgMDYvMTRd
IHNwaTogaW14OiBhZGQgZG1hX3N5bmNfc2dfZm9yX2RldmljZSBhZnRlciBmYWxsYmFjawogZnJv
bSBkbWEKCkluIGNhc2UgZG1hIHRyYW5zZmVyIGZhaWxlZCBhbmQgZmFsbGJhY2sgdG8gcGlvLCB0
eF9idWYvcnhfYnVmIG5lZWQgdG8gYmUKdGFrZW4gY2FyZSBjYWNoZSBzaW5jZSB0aGV5IGhhdmUg
YWxyZWFkeSBiZWVuICBtYXBwZWQgYnkgZG1hX21hcF9zZygpIGluCnNwaS5jLgoKU2lnbmVkLW9m
Zi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPgotLS0KIGRyaXZlcnMvc3BpL3Nw
aS1pbXguYyB8IDEyICsrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktaW14LmMgYi9kcml2ZXJzL3NwaS9zcGkt
aW14LmMKaW5kZXggYjdhODVlMy4uYzUxY2QzYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9zcGkvc3Bp
LWlteC5jCisrKyBiL2RyaXZlcnMvc3BpL3NwaS1pbXguYwpAQCAtMTQ1Niw2ICsxNDU2LDEzIEBA
IHN0YXRpYyBpbnQgc3BpX2lteF9waW9fdHJhbnNmZXIoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwK
IAkJcmV0dXJuIC1FVElNRURPVVQ7CiAJfQogCisJaWYgKHRyYW5zZmVyLT5yeF9zZy5zZ2wpIHsK
KwkJc3RydWN0IGRldmljZSAqcnhfZGV2ID0gc3BpLT5jb250cm9sbGVyLT5kbWFfcngtPmRldmlj
ZS0+ZGV2OworCisJCWRtYV9zeW5jX3NnX2Zvcl9kZXZpY2UocnhfZGV2LCB0cmFuc2Zlci0+cnhf
c2cuc2dsLAorCQkJCSAgICAgICB0cmFuc2Zlci0+cnhfc2cubmVudHMsIERNQV9UT19ERVZJQ0Up
OworCX0KKwogCXJldHVybiB0cmFuc2Zlci0+bGVuOwogfQogCkBAIC0xNTIxLDEwICsxNTI4LDE1
IEBAIHN0YXRpYyBpbnQgc3BpX2lteF90cmFuc2ZlcihzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLAog
CSAqIGZpcm13YXJlIG1heSBub3QgYmUgdXBkYXRlZCBhcyBFUlIwMDkxNjUgcmVxdWlyZWQuCiAJ
ICovCiAJaWYgKHNwaV9pbXgtPnVzZWRtYSkgeworCQlzdHJ1Y3QgZGV2aWNlICp0eF9kZXYgPSBz
cGktPmNvbnRyb2xsZXItPmRtYV90eC0+ZGV2aWNlLT5kZXY7CisKIAkJcmV0ID0gc3BpX2lteF9k
bWFfdHJhbnNmZXIoc3BpX2lteCwgdHJhbnNmZXIpOwogCQlpZiAocmV0ICE9IC1FSU5WQUwpCiAJ
CQlyZXR1cm4gcmV0OwogCisJCWRtYV9zeW5jX3NnX2Zvcl9kZXZpY2UodHhfZGV2LCB0cmFuc2Zl
ci0+dHhfc2cuc2dsLAorCQkJCSAgICAgICB0cmFuc2Zlci0+dHhfc2cubmVudHMsIERNQV9GUk9N
X0RFVklDRSk7CisKIAkJc3BpX2lteC0+ZGV2dHlwZV9kYXRhLT5kaXNhYmxlX2RtYShzcGlfaW14
KTsKIAogCQlzcGlfaW14LT51c2VkbWEgPSBmYWxzZTsKLS0gCjIuNy40Cgo=

--_002_VE1PR04MB6638463E7E6577E84F8D1FF589860VE1PR04MB6638eurp_--
