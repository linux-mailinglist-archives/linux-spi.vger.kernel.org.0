Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC410FEC7
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 14:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLCN1p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 08:27:45 -0500
Received: from mail-eopbgr1400121.outbound.protection.outlook.com ([40.107.140.121]:34209
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbfLCN1o (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Dec 2019 08:27:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JatFMizwGImVXjvDJbkSZnUreVzkUiqy+rZ6bMTZ5GbFVMJvB5w5WbuCBDsbsk9/deNKuNgS6KHOPpsZ0XDt+2m5ag2lXMc7OWDjHXoSzlos9la/bbV7IX6XY0OCUrGcTHGfUY5eL8grBlbdF62IFZ3zC7w0b/I/7zTCl+mzeB/Z9IcmnrHCDy+pvDtlL7aSWwR8dwvLKoQzXxP4x+7yVHPF8lZeGV8McwCkQNsBsMa07Q3Uvptk9UgsgpwR5xWU6SFwQkQR3nH0UvjxIikHMYKJsPp/lVzyupfYIWOL0b4bwNcCmIG/IJ8PbvYys272TQfT2m5kRnkZtyWnI7N78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6iqdCRYte3HB+lK+qyaQjUGwN5HP9VlAZ5gNuMz5mA=;
 b=ZgwBYVAFgN1w1ElyOE5/j8MyrJPMAlIiHfcnSkiC1YaCAsYu8xGUrwAA1hUdCl+LRX3rLVfV/C6w6giHtVCYbgMVQjb7/pk4dEFgjPYMk5PdpuNWEOXs2FykPfxgeFd7TnpeJ7+sUgjap9kJriR51LKskqP/7ZPooG8IlREsIGCWpO5m3Ddpk26Xy8vOBfnZadEJjofeM8OLcbKdGgXgmul+SNt6kMLPKyQQ8YYNla2QhEpb5Iob4Hz0GWrs/LAd2N8XgFJtgdZKTwf5C+s3ZURVfMg7iRAfrq983KCDZtm0CiWydgCu/auod0z9t9y702lM1lWtqhmfFSOmTjyykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6iqdCRYte3HB+lK+qyaQjUGwN5HP9VlAZ5gNuMz5mA=;
 b=ANmDGJCQk3jSmec7QnPtO1uy7X4sh+kzz+O/wuzUxs5fd+AovaWgs6oTzEL0q2HXRZMFz22ongKtzC75B4jL6xMVHX82++xAYcvn2dOO2Hq7dSzsj2t2HJcd7Ppqd+e7dF+ePEi/0Ec7iLd4fs1/t4m5cj5O4F3p6dxLZIfHaSs=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1SPR01MB2.jpnprd01.prod.outlook.com (52.133.161.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 3 Dec 2019 13:27:40 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 13:27:39 +0000
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
Subject: RE: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Thread-Topic: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Thread-Index: AQHVqYxRjjQT6EPsk0uhvsHduSJ+e6eoIQoAgAA7ZYA=
Date:   Tue, 3 Dec 2019 13:27:39 +0000
Message-ID: <TY1PR01MB156262E8D33A0624457CAE248A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com>
 <17e66541-41fb-26ed-c87b-15c59ab57bef@cogentembedded.com>
In-Reply-To: <17e66541-41fb-26ed-c87b-15c59ab57bef@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYWJkMjliMjMtMTVkMC0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XGFiZDI5YjI0LTE1ZDAtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNjk2IiB0PSIxMzIxOTg1MzI1Nzg5ODY2OTgiIGg9ImJTaFlmT3U3bUZmWDBxL0Jtbks1NUFhSlYybz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1947f291-f0a1-42e0-7c66-08d777f491e0
x-ms-traffictypediagnostic: TY1SPR01MB2:
x-microsoft-antispam-prvs: <TY1SPR01MB2F7B2FF101FF1A03AEA618A420@TY1SPR01MB2.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(189003)(7416002)(7736002)(305945005)(74316002)(8676002)(71190400001)(81156014)(8936002)(446003)(71200400001)(11346002)(25786009)(81166006)(52536014)(316002)(76116006)(5660300002)(66946007)(478600001)(54906003)(102836004)(26005)(6246003)(99286004)(4326008)(9686003)(76176011)(7696005)(6506007)(110136005)(4744005)(55016002)(33656002)(256004)(2906002)(186003)(14454004)(6436002)(66556008)(3846002)(6116002)(66446008)(66476007)(64756008)(86362001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1SPR01MB2;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KXwGIDSGdFEgQABHZ4Hkls6+ZaJgDc2I8mzDrO12b6cEohJ/DY+AkTvPCPGU6yR/xeXlf8i1zNDPxlhSx+KmsyUJQ4RWxw3ujSy8VtHkh1JvZZz0uy+wBCwOS9YnxZ1y48bOeIkWhsGsP0vCw86OXWR8sk3X9p5CmBu6f6EhQutGIpknomrEAK09cTjnUE+m3M3vM87PkKiPUPjWXlwyKJf+zGuq35tPzxUi3aOX/CNS/W52diSFdUWLEoJsDRtK9keeaRkUayxbBBnknIZqJ7K+bCLDjSoE2Dsk+3+S6Kf+/ucYCNSZoBUIblcLyVvO1yXMJkve/pWuf5ABl5qhCd/yO12URLsK5YL9M3vkH5oWG9EfPrRBuars6PWcCSWK4mPz3unKbm15SRRf26NNtA5bfzbtYlAYjKXilsOSSBZLNaQ0qubHgO6MTmXrDti
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1947f291-f0a1-42e0-7c66-08d777f491e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 13:27:39.8089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPnjXvmGvnBqZ5vRniYYFOEpW72iGcpN/fAJCvcN1oyBvHT3HWsPH8QwMjOvdxYDFq+I+JlDswxzuNUgN+gY6MZMjl/7JUZI7yTQoz0O/Zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1SPR01MB2
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVHVlLCBEZWMgMywgMjAxOSwgU2VyZ2VpIFNodHlseW92IHdyb3RlOg0KPiAgICAgVGhhdCdz
IG9ubHkgMiBhcmVhcywgbm90IDMuIDotKQ0KVGhhbmsgeW91IQ0KDQo+ID4gKy0gZmxhc2g6IHNo
b3VsZCBiZSByZXByZXNlbnRlZCBieSBhIHN1Ym5vZGUgb2YgdGhlIFNQSUJTQyBub2RlLA0KPiA+
ICsJIGl0cyAiY29tcGF0aWJsZSIgcHJvcGVydHkgY29udGFpbnMgImplZGVjLHNwaS1ub3IiIGlm
IFNQSSBpcyB1c2VkLg0KPiANCj4gICAgIEFyZSBhbnkgb3RoZXIgZmxhc2ggdmFyaWFudHMgc3Vw
cG9ydGVkPw0KDQpEbyB5b3UgbWVhbiBvdGhlciB0eXBlcyBvZiBTUEkgZmxhc2g/DQpJJ3ZlIG9u
bHkgdXNlZCBTUEkgZmxhc2ggZGV2aWNlcyB0aGF0IGFyZSBhdXRvIGRldGVjdGVkIHVzaW5nIA0K
ImplZGVjLHNwaS1ub3IiLg0KSW4gdGhlb3J5LCB5b3UgY291bGQgdXNlIG90aGVyIHR5cGVzIG9m
IFNQSSBmbGFzaCBsaWtlICJhdG1lbCxhdDQ1IiwgYnV0DQpubyBvbmUgaGFzIGV2ZXJ5IHRyaWVk
IGl0LCBtb3N0bHkgYmVjYXVzZSB0aGUgU29DIHdpbGwgb25seSBib290IGZyb20NCkpFREVDIGNv
bXBhdGlibGUgU1BJIGZsYXNoLg0KDQpDaHJpcw0K
