Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE9119216
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 21:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLJUdi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 15:33:38 -0500
Received: from mail-eopbgr1400132.outbound.protection.outlook.com ([40.107.140.132]:22272
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbfLJUdi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Dec 2019 15:33:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd3MVjnrgE48Beo0o6fKJgLqA8AopjvxPc0pK27dR80j+8BtZmcQYFPBgd3EB26xKI7WpLM3RO3dWzWgKUUbBkWe4LglyM3sLxWWlDWPw5JTX0Z3yJgDpQMEIhokwOgTtY2R4qOjIbO//CiaQ3xEGyYK0NfSf06hp9uns/xDvGRLyXDGPxCR8I/A2EAnrFEAzDqR1i5XvKgGdp+N+fG9Ig8QeVyPCd79WlSR6Ckzw0KWHNvEhkYYN04ldt8H5QnNhT596U5YPHYFfYV2xUs5Ez0UQLFnVwNgS6OIgiO0oyFALi4NRTSfskMC0+0S3g80KjaFhLKqJXdWOSmRfZaoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4/uSArMR28G5csbjFLTdj7CESpD3u/INYskxbXXAy4=;
 b=beZui5Jf9G6b1qvBALDH+44ueAPFdlGFmGjAIg2ef+zrUKjpbdCMi6zjKGxJKdq2SeH8Jg/6DJPT29L07SBLd06SKJdyER5V2GRkFxZdK9MnjXeI4zA+rhTmDRZT2/4JKeWxxfdmDUC7azizqTLeYV234orYjmxST6qdKuRoSBmpBswZedg29Gkcn3hZRjeJsp2HD5XYWU470Jx3zaUoGiY8B2GAySKbeMa/e3m22K8e+h7fExEDlM6nj4iLDzWSOiBJRHN8RSle0jdzj4tK3SrP/11oWerdLdG0iz+xe7uPgu0RvaCEO28DEuf0XGXlckGdEVV9+VJVBzZ5mvvR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4/uSArMR28G5csbjFLTdj7CESpD3u/INYskxbXXAy4=;
 b=rEOmH5X6LqDdpioJISFbI8u4v5ljxTf3IogCDN5hO1Do3vKKE46DqPoumHq06Y4NqorYqehyot2DK2qq+0w5c4ltF5clobUuP9jfI6h11U5EeeUxvxV/DlgU0L7+dxPH6mzR2d/FWpfna+a91qxp8kEnzP2Yyeq/UMkoAnCj/ZE=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1723.jpnprd01.prod.outlook.com (52.133.163.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 20:33:34 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 20:33:34 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: RE: [PATCH v2 2/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Thread-Topic: [PATCH v2 2/6] dt-bindings: spi: Document Renesas SPIBSC
 bindings
Thread-Index: AQHVrDsTjXSeF7WhuEKgUGoi0guPiaex3BKAgAH2T4CAAAK6gIAAAbsQ
Date:   Tue, 10 Dec 2019 20:33:34 +0000
Message-ID: <TY1PR01MB1562D812E6060516E689C7578A5B0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-3-chris.brandt@renesas.com>
 <CAMuHMdXW6_tCcx_DE66qBSTK8XmWyWm82ZD6h-N5YX_+xcvBtw@mail.gmail.com>
 <0cbd8556-cf17-7d6b-5c12-e8d663a39cfa@cogentembedded.com>
 <CAMuHMdUOUctfD7K21yAx8QFAj0LP+D2PrMCri8H2PMUr5WzXoQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUOUctfD7K21yAx8QFAj0LP+D2PrMCri8H2PMUr5WzXoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNTRjZTYxMzYtMWI4Yy0xMWVhLWFhNTUtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDU0Y2U2MTM4LTFiOGMtMTFlYS1hYTU1LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTM0OSIgdD0iMTMyMjA0ODM2MTMwNjkzMjM5IiBoPSJscXUvK2R0ZHRNRVhOSTM5d3VLR1M5ZmpVME09IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [24.206.39.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b01d1cc0-c1dc-468c-66b4-08d77db03aa2
x-ms-traffictypediagnostic: TY1PR01MB1723:
x-microsoft-antispam-prvs: <TY1PR01MB17230E1470E6D8509A341DB58A5B0@TY1PR01MB1723.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(52314003)(9686003)(7416002)(55016002)(110136005)(2906002)(8936002)(186003)(66946007)(5660300002)(7696005)(8676002)(33656002)(316002)(71200400001)(6506007)(478600001)(66476007)(54906003)(4326008)(81156014)(81166006)(64756008)(76116006)(86362001)(52536014)(26005)(66556008)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1723;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nXAF56K3jOz3F4XnnxtycEIUifh+AudmUf7XNhAPuj+WyZtBBXvg6D/TRZApEdMKY288E1E8EERLXboAOUWyFq2t7QMNjBn4GrpSvZ96xlRRjzvHqst4ZEYJA6Ory2L4j3OznzBshB2S6FJXYVmLz6dOwuPsWvEuufdL7/0XrwtoKxpQN7mFsdnxp0d83T/VVpdysPh2avR+vTTQM0jHU6/y/2FO42l/nHQ+v2m6vyrUDCdh6lxxgNCNyLIbLVnAaeDMnp5xPsWdyM6ux5loB0lj2wCdNL0kg9T9BmQQrUXnrpA6XhN2kC/v5BQV7tV5Dva+/j98UK+8SJZ0s+DFTSRvC0giSoDfBUmnEIAlNtostWwyh6RdBI2YKOb+G+DSa7IM1AaNywyIpU5BlJHViC0C0+W3xgUZxk2TQLy6qzERcBk5fJ/kXNrPYqi7+ZRhklf256EdLGr64usOhJxaMp/T9SkG9dUlPPDIyg5sPF1WhjKCstMBTRs2YRdKUlBW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01d1cc0-c1dc-468c-66b4-08d77db03aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 20:33:34.6442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3clbG2Ii6SdBbGJiIiz/4b+fEVRBoWxpF1tGuv5nT7/M576daiuhJaHOgtQhcrxLsOSNC3C32YKghLmyz9pA43qE8StRRLR6cUrT7tpAybk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1723
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVHVlLCBEZWMgMTAsIDIwMTksIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4gPiA+IFRo
ZSBzZWNvbmQgb25lIGlzIG5vdCBuZWVkZWQsIGlmIHlvdSB3b3VsZCBhZGQgInJhbmdlcyIgZm9y
IHRoZQ0KPiA+ID4gbWVtb3J5LW1hcHBlZCBtb2RlLg0KPiA+DQo+ID4gICAgSSdtIG5vdCBzdXJl
IHdlIGNhbiBkbyB0aGF0LiBUaGUgZmxhc2ggYnVzIGlzIGFjY2Vzc2VkIHZpYSBhIHdpbmRvdw0K
PiA+IHdpdGggdGhlIGhpZ2ggYml0cyBpbiB0aGUgRFJFQVIgcmVnLCBldmVuIGluIHRoZSBkaXJl
Y3QgcmVhZCBtb2RlLi4uDQo+IA0KPiBTbyBpZiB0aGUgRkxBU0ggaXMgdG9vIGxhcmdlLCB5b3Ug
Y2Fubm90IGFjY2VzcyBhbGwgb2YgaXQgd2l0aG91dCBwcm9ncmFtbWluZw0KPiB0aGUgaGlnaCBi
aXRzLg0KPiBIb3dldmVyLCB3aGVuIHVzaW5nIFhJUCwgIHlvdSdyZSBsaW1pdGVkIHRvIHRoZSB3
aW5kb3cgc2l6ZSBhbnl3YXkuDQoNCklmIHlvdXIgU1BJIGZsYXNoIHN1cHBvcnRzIDMyLWJpdCBh
ZGRyZXNzIGNvbW1hbmRzLCAoIjRSRUFEIiBmb3IgDQpleGFtcGxlKSB0aGVuIGFsbCAzMi1iaXQg
YXJlIHNlbnQgb3V0Lg0KDQpUaGUgJ2hpZ2ggYml0cycgdGhhdCBoZSdzIHRhbGtpbmcgYWJvdXQg
aXMgZm9yIGFjY2Vzc2luZyBTUEkgdGhhdCBpcyANCmJleW9uZCB0aGUgWElQIHdpbmRvdyBzaXpl
Lg0KDQpGb3IgZXhhbXBsZSwgdGhlIFJaL0ExIGhhcyA2NE1CIHdpbmRvdyBzaXplIChSWi9BMj0y
NTZNQikuIE1lYW5pbmcgDQphbnl0aGluZyBhYm92ZSA2NE1CIGlzIG5vdCBhY2Nlc3NpYmxlLg0K
SG93ZXZlciwgeW91IGNvdWxkIHByb2dyYW0gdGhpcyByZWdpc3RlciB0byBiYXNpY2FsbHkgY2hh
bmdlIHRoZSB3aW5kb3cgDQpzdGFydGluZyBwb2ludCBhbmQgbWFrZSB0aGUgdXBwZXIgNjRNQiBv
ZiBhIDEyOE1CIGZsYXNoIHZpc2libGUgYW5kIHRoZQ0KbG93ZXIgNjRNQiBwb3J0aW9uIGhpZGRl
bi4NCkZvciBhbiBYSVAgc3lzdGVtLCB0aGlzIGlzIG9uZSB3YXkgb2YgZG9pbmcgYSByZW1vdGUg
ZmlybXdhcmUgdXBkYXRlIA0KYW5kIGtlZXBpbmcgdGhlIG9sZCBjb3B5IGFyb3VuZCBqdXN0IGlu
IGNhc2UgeW91IG5lZWQgdG8gcmV2ZXJ0IGJhY2suDQoNCkFueXdheSwgdGhlIHBvaW50IGlzIHRo
aXMgZG9lc24ndCBtYXR0ZXIgaW4gZWl0aGVyIHRoZSBNVEQvU1BJIG9yIA0KTVREL1JPTSBvcGVy
YXRpb24gb2YgdGhlIGRyaXZlciBhcyBmYXIgYXMgSSBjYW4gc2VlLg0KDQpDaHJpcw0KDQo=
