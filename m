Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C914F1157F0
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 20:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfLFTtk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 14:49:40 -0500
Received: from mail-eopbgr1400104.outbound.protection.outlook.com ([40.107.140.104]:36171
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbfLFTtk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Dec 2019 14:49:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch9UQrbrUPPG0nB8ZNlSSzkqsKKpXirydgCOcmA3qDgWoTskqP9B6+NhJ0BCZ5dVIh81wiqMnPDT79lv+91HcIxewGE+loEvSJHnmuUJIcv9l5ByaeZxTl4Uo6s+ZjkJyZWO6E1GgAh+otI+INgGhpdtnDqbliuGzCCiSdIDFguWUrd5SalAne7UD3owwgNrum6t2A243emyu4goOuR7igVWuu9ch/cO6SkL7G581fzmqT7CpcY8Pe+FMUBu5NYKX5uvE4uWdfIWNF42eI5ndM7xfXwyyb86Y/sGIaN3NvkGEvaBIwnRKJAKOOtzRe6waqN9N1w8m9h3AhiW8ekt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyGjU7T6WutyAvOkNHgc4SGQpxnvbKyXVi72RF4mXN0=;
 b=hWVgc0bOr1sTfPcWMcZKu/rYEW+6bNzuT7JGtu+DnZNS3QyiJIPd9uGr/yc1M1lA4pkxyN32piWlASbV4K7uzSDdFOtHVaunyd6Hhv0zsLlL0ZccZxDs3TDIBs1nFTiN8HiQCdtsVZBk/LK94nIfQOP5FmZBlgGxM45VOF86b3Qys5f7tTaRunF7WAq94riO8PF8uLDsaa7hOKt2LWDsjTH0uleeXRucbFCSuK54z16EXfRY/vRVUuEL71a/VtnJSinsGLjUsukLM3SsAgIY8zt/dN5zQ7zkMzM3uYb3z/u7FP39JKPKZ39NCfV6tUr7HcGDi/GRrrYNGNUnRYXIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyGjU7T6WutyAvOkNHgc4SGQpxnvbKyXVi72RF4mXN0=;
 b=I8MOIuol4RDN8Gk7j2z9N1kFQBXIgzBakIchV6NB+y+fWgWQqvNK1pB2r5/Cck5It8uB6BxudPPqrYoblnvBTo/PN09bA+9Ybnw2FCJk6B9WTuS3M95+wZOPexe2rvft5yBqTrIzQRgN2CxUvonrCDwXBqFVENcVROAserMGJlM=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1643.jpnprd01.prod.outlook.com (52.133.163.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Fri, 6 Dec 2019 19:49:34 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Fri, 6 Dec 2019
 19:49:34 +0000
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
Subject: RE: [PATCH v2 3/6] clk: renesas: r7s9210: Add SPIBSC clock
Thread-Topic: [PATCH v2 3/6] clk: renesas: r7s9210: Add SPIBSC clock
Thread-Index: AQHVrDsZnI+SMLkmZkyW5+1FSLVd3qetcNKAgAAShiA=
Date:   Fri, 6 Dec 2019 19:49:34 +0000
Message-ID: <TY1PR01MB1562645184402F7C01CE36958A5F0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-4-chris.brandt@renesas.com>
 <5644c687-7692-53f2-f01e-0e7bf62464ea@cogentembedded.com>
In-Reply-To: <5644c687-7692-53f2-f01e-0e7bf62464ea@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctODQ5ZDdkZDEtMTg2MS0xMWVhLWFhNTItOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDg0OWQ3ZGQzLTE4NjEtMTFlYS1hYTUyLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNjg5IiB0PSIxMzIyMDEzNTM3MTQ0MTg1ODkiIGg9IjlzS0dEQ0xiVktiaWd4VjIwQnM0NTg2ZnRjaz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6c8f820-1813-40e3-8c57-08d77a856b70
x-ms-traffictypediagnostic: TY1PR01MB1643:
x-microsoft-antispam-prvs: <TY1PR01MB1643437E672D90FEACCBC5148A5F0@TY1PR01MB1643.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(9686003)(76176011)(99286004)(478600001)(81166006)(81156014)(55016002)(7696005)(8936002)(186003)(5660300002)(305945005)(74316002)(8676002)(229853002)(2906002)(102836004)(53546011)(6506007)(66946007)(33656002)(52536014)(7416002)(66446008)(64756008)(66556008)(66476007)(76116006)(86362001)(71200400001)(71190400001)(4744005)(54906003)(316002)(110136005)(26005)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1643;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiaYp+NTbST/jqAv5SDWDFSh10U6W1RT2pRmDViYtD7uBfroouJrNtIU4gQJqBWPg1uJ+kDEspwSbl+SJE5ZwYsyiFyrFrBo6NRbJbvEWdmW86ol7Vxtr9i7moT4aOmJ8vY0K89U3xViSDc34PJziFPbI71PB5nX5pAB20LzgQNFZuXClXUPc7eSxeV/NL971eUx3nD+Of2aWHxbVwHoPAd2smQjNAmpXq/r+7/PZfK1tBrFytL8d1vWoiQvQny6lUfGg4KLDkH0iU5UKnSSBWbs6VC26CvlBd+wx6RD9mrhyEJ+h/ll1JJYyXrxZQYyb0UWHy5CG1S1XbNiV/1mVRgKXJBmB9YB/WELmNAZKAtN1oX//bQC3dYjQXduQ5r+4MHFu25xudE5ph6E+dnnYo2iMR9WDFTXBpZcTxp0Me1U/h1Q0NceiYNXCFz/6jEW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c8f820-1813-40e3-8c57-08d77a856b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 19:49:34.5742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1bKrH3wZIooZwFvEX2a7biiARZrNaHJke7cWlJfaprGqzxgC07McP1gpZ1YmH/x1dQzpHzG1i2m/HIIEWUvB8/qeefNps+ombkkiqIw+s2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1643
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gRnJpLCBEZWMgNiwgMjAxOSwgU2VyZ2VpIFNodHlseW92IHdyb3RlOg0KPiBPbiAxMi8wNi8y
MDE5IDA0OjQxIFBNLCBDaHJpcyBCcmFuZHQgd3JvdGU6DQo+IA0KPiA+IFRoZSBTUElCU0MgY2xv
Y2tzIGFyZSBtYXJrZWQgYXMgY3JpdGljYWwgYmVjYXVzZSBmb3IgWElQIHN5c3RlbXMsIHRoZQ0K
PiA+IGtlcm5lbCB3aWxsIGJlIHJ1bm5pbmcgZnJvbSBRU1BJIGZsYXNoIGFuZCBjYW5ub3QgYmUg
dHVybmVkIG9mZi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENocmlzIEJyYW5kdCA8Y2hyaXMu
YnJhbmR0QHJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOg0KPiA+ICAqIFJlbW92ZWQgc3Bp
YnNjIGZyb20gY3JpdGljYWwgY2xvY2sgc2VjdGlvbg0KPiANCj4gICAgU28geW91J3ZlIHJlbW92
ZWQgaXQgZnJvbSB0aGUgY3JpdGljYWwgdGFibGUgYnV0IGxlZnQgdGhlIHBhdGNoDQo+IGRlc2Ny
aXB0aW9uIGludGFjdD8NCg0KRGFtbiENClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgdGhhdCBvdXQu
DQpJIHJlbWVtYmVyZWQgdG8gdGFrZSB0aGUgY29tbWVudCBvdXQgb2Ygb25lIHBhdGNoLCBidXQg
SSBtaXNzZWQgdGhpcyBvbmUuDQoNCkNocmlzDQoNCg==
