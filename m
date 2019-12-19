Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9812112677A
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2019 17:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLSQ5U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Dec 2019 11:57:20 -0500
Received: from mail-eopbgr1400100.outbound.protection.outlook.com ([40.107.140.100]:6126
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbfLSQ5U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Dec 2019 11:57:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRyCoMwUTleG0QxCJ3dyQzafaH4UabTPEGAYqXZL4AON07ERIhQoUXpROgqDupMwlEnOt6+Err/bIyT39vxQIp24k3/FHwkPy0kcuXlQ6LJT+uzGnHUXGCv9DDo6ypb+4FAgf68DSfyly/2ojYZ5G/DbqNYhS9UWGFUgnqEHW3kGsuMGuk2l3L9wO7V8PU+gc89cMah5MlNemYIhrufcLGnx498RCqkZAPa/nnSc/NxHQCMXjn6sRyuoilQZCsmP3MxruCggnLyjAshJ4GgUPjeh3WCeJc+pB2bjbSHgWhpJpft3ZfSnvJ9geahOYqihxaiCHodAq3YYyGfgA3CbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKxvHXokZAUChFO/qu0G997wNXugB24sXXwxlR+/AQs=;
 b=U2m31hDWEeAaUUFwCmDnsb8HZr5KDDPFBiklrcFN5tLGmenM+D68pQMytSREGPt1bXfyVnmvEdb8vUByrC2w/vlvISUUgYNoq34uHbI8Ch95lA6IyUNh1+3ry/HkovITIJv7vnMttojMJvRNULm06syS7yCkqvGuU/qXlGvKwVYBhJBrMUtD69cgjWikYZ9yfJSjb52hQCBhKonHMJCcTl+AbNPin1pRFnhHkQ3YTXf/8yE/OAMKhdDX3wIn0zEu49xn9LCMgjpgUZ7PXinpetr5dFHsljFaqaseh6+BdV+bRKCeFHfrOQUIJbC4eMK8iwawdak4RhBkiqrHs75uSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKxvHXokZAUChFO/qu0G997wNXugB24sXXwxlR+/AQs=;
 b=P0kYEyN5CM74j3cgPZVSp3RceCkmhTQ+/Uptf+DJkwL9PZOrZhHnXkDVTlr7ZhlYyoKFljlcTyJgK31VXm+YelDbeNaw0fEaA7gKRlkwCYzhSVbKzwxCfzMacYbZQAFXaaZq0S6fiGrFeqF7QjNOSLrU/yBZIJLuSAK8sEtk2k4=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1881.jpnprd01.prod.outlook.com (52.133.161.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 19 Dec 2019 16:57:15 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 16:57:15 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: RE: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Thread-Topic: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Thread-Index: AQHVrDsFo/XrCnZmIE+HK5Vec6rH7qevIW6AgAK0x/CAA35sAIABOkowgAa4UICAABhMQIABaMMAgALzYFA=
Date:   Thu, 19 Dec 2019 16:57:15 +0000
Message-ID: <TY1PR01MB1562E196AB1C582F186CC74B8A520@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
 <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
 <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com>
 <TY1PR01MB1562B9EB96818DCA507079808A510@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <bb630141-021c-5618-f266-b98b29956fa8@cogentembedded.com>
In-Reply-To: <bb630141-021c-5618-f266-b98b29956fa8@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOWEzZWVlZWUtMjI4MC0xMWVhLWFhNTgtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDlhM2VlZWVmLTIyODAtMTFlYS1hYTU4LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTMyNCIgdD0iMTMyMjEyNDgyMzM3ODQzNjMzIiBoPSJrSCtCVnJZNXh5OWRDMlR6QXhNcDAyTVZYbzg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ebfe6e1-2d96-4389-8394-08d784a4801b
x-ms-traffictypediagnostic: TY1PR01MB1881:
x-microsoft-antispam-prvs: <TY1PR01MB1881A82BE09226AADA7662668A520@TY1PR01MB1881.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39850400004)(376002)(366004)(136003)(396003)(189003)(199004)(8936002)(316002)(54906003)(55016002)(7696005)(66946007)(33656002)(9686003)(4326008)(6506007)(478600001)(26005)(81156014)(81166006)(76116006)(66446008)(64756008)(66556008)(186003)(66476007)(5660300002)(8676002)(86362001)(52536014)(7416002)(2906002)(71200400001)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1881;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N8thbqQSG/iIYNW2tjE3flxgzSoIneMWET/ZrV/OmCp4oqYAIqg9mA0BFCib0Tu+p2kbAatX8VEMweAjul4CxQYpKAUvgDMIEipLQ879VGivtTg46CXS6+kGsOLT4C1n1kyYD9+nyAME5qjDOe4CCEyR6CIT1tniei4w+MkHO22MBG8ZarrshGXU0YTlHwNeGA7CXMSb8WOx2/5suIgavQoWcXCpzAOdcLiGzLPiN+IHE6bk6I0dWSBbRo+jXfMo2kTXKCqOnrD+fvPhRiLJQiSD/QYnzTPLWo8KFMwxnZhNdlHdmC/W/+CCtT4cb3It1xEIrh8CaqaBZenZGt+E7gi8hNmpV1HugIMf7Wy4gQQAF4RFmiPzw/ppdKTXYCZVjCGfF/miCvuUvIs68+OwDGotJk4fApqopz5TLuLzelXUj7tAqMdvjRiH823dwxg3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebfe6e1-2d96-4389-8394-08d784a4801b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 16:57:15.3605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcKI2xM0Fm8XlLhsgDad/eCzkvmWRY2pJK2Yuhwgzk+u3iYACbrldZ3RwwN4snWQfK4udYRXdt9R2jFf9NmVbpQlNp4RsxJLxfxYeEbGW58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1881
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVHVlLCBEZWMgMTcsIDIwMTksIFNlcmdlaSBTaHR5bHlvdiB3cm90ZToNCj4gICAgQnV0IHdo
YXQgZG9lcyB0aGUgYWNyb255bSBtZWFuPw0KUVNQSSA9ICJRdWFkIFNQSSINCg0KDQo+ID4gU28g
YXQgdGhlIG1vbWVudCwgdGhlcmUgaXMgbm90aGluZyB5ZXQgZm9yIG1lIHRvICd0cnknIG9uIHRo
ZSBSWi9BIHNlcmllcywNCj4gY29ycmVjdD8NCj4gDQo+ICAgIFdoeSwgSSBjYW4gc2VuZCB5b3Ug
YSB3b3JraW5nIHZlcnNpb24gb2YgdGhlIFNQSSBkcml2ZXIsIGFuZCBldmVuIEhGIG9uZQ0KPiBp
ZiB5b3UncmUNCj4gaW50ZXJlc3RlZC4NCg0KVGhlIHBvaW50IG9mIHRoaXMgd2hvbGUgZGlzY3Vz
c2lvbiBpcyB0byBkZXRlcm1pbmUgaWYgd2Ugc2hvdWxkIGhhdmUgMiBkcml2ZXJzDQpmb3IgdGhl
IHNhbWUgUmVuZXNhcyBIVyBJUC4NCg0KVGhlcmUgd2FzIGEgUlBDLUlGIHBhdGNoIHNlcmllcyB0
aGF0IG1hZGUgaXQgdG8gdjE3Li4uLmFuZCBpcyBub3cgZGVhZC4NCg0KWW91IHNlbnQgYSBuZXcg
UkZDIHNlcmllcyBmb3IgYSBuZXcgbWV0aG9kLCBidXQgYWxsIGl0IGhhZCB3YXMgbG93IGxldmVs
IEFQSXMsDQpubyBNVEQgZnJhbWV3b3JrLCBkbyBpdCBkaWRuJ3QgcmVhbGx5IGRvIGFueXRoaW5n
Lg0KDQpJZiB0aGVyZSB3YXMgYSBjb21wbGV0ZSBwYXRjaCBzZXQgdGhhdCBJIGNvdWxkIHRyeSBv
biB0aGUgUlovQSBTb0NzIGFuZCANCmdldCBhIHdvcmtpbmcgU1BJIE1URCBkZXZpY2UgdG8gc2hv
dyB1cCwgdGhlbiBJIHdvdWxkIGRyb3AgbXkgZWZmb3J0cyBvZg0KZ2V0dGluZyBteSBkcml2ZXIg
aW4gYW5kIGp1c3QgYWRkIFJaL0Egc3VwcG9ydCB0byB0aGUgUi1DYXIgZHJpdmVyLg0KDQpHZWVy
dCBzdWdnZXN0ZWQgb3V0IGFuIGVhc3kgc29sdXRpb24gZm9yIHRoZSAiWElQIiB1c2UgY2FzZSBm
b3IgUlovQSANCmRldmljZXMsIGFuZCB0aGF0IG1vc3RseSBoYXBwZW5zIG91dHNpZGUgdGhpcyBk
cml2ZXIsIHNvIEknbSBub3Qgd29ycmllZCANCmFib3V0IHRoYXQgYW55bW9yZS4NCg0KSG9uZXN0
bHksIEknbGwgYmUgb3V0IG9mIHRoZSBvZmZpY2UgdW50aWwgSmFudWFyeSwgc28gaXQncyBub3Qg
bGlrZSBJJ20gDQpnb2luZyB0byBkbyBhbnl0aGluZyB3aXRoIGl0IHVudGlsIHRoZW4uIEJ1dCBp
ZiB0aGVyZSBpcyBhIGNvbXBsZXRlIHNlcmllcw0KdG8gdHJ5IGJ5IHRoZW4sIEkgd2lsbCBzZWUg
aG93IGl0IHBlcmZvcm1zIG9uIFJaL0EgYm9hcmRzLg0KDQpDaHJpcw0KDQo=
