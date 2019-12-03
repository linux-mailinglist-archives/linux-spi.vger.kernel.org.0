Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCCA2111BAB
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 23:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfLCWdS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 17:33:18 -0500
Received: from mail-eopbgr1410094.outbound.protection.outlook.com ([40.107.141.94]:52665
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727131AbfLCWdR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Dec 2019 17:33:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUONtzFbHSM3hYtAFBQJL+s6MWnkEAEo1SEHqDCY4yUblbT8UxGPGzMuB+AwHom9e1r2FJrmYgWy9R7Gvck0njSUTIpchltXrO/Nhv12L5qJNIweRdE50Qaf0gyTk7M2/r7fGsesROJ5gZqhb4xGNPKGHGx9f5Hpc8m3tBxqiDlz2NR3TzdGIMs6Uqg1S3qwQ7aiee4T+xEGE594keAgtWye4TYywPsu6KewVbNSqPI4pa5shDl6OvLCtxpXXIzsyWuCcKxjWTCn9A+2icda9I4B9KXzNOJacC+PO/onfPcoPK81/Wy08kquxqSIK+J/yX+d2u2b+ZPl9IlT1wfaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWcbF7nO2hd+psDfcqfDKkhrh7bw9hghOylzqE51BlQ=;
 b=mU8onj5sEMqLI/2UthcMqcU1lgp5b4p1yodqp8j+RCke+odMTb9gcJyiz6CHYplzcb9G6hLvtKjpGJYqiI1tiQGOvpp6oGioTHNVnGbPA13nT1AXKSeqsGCRbtNLCsFGIy88BOR3GOu2MgfLbgye7NokP9gPkTcQmTaZMWm+geTHoPYPcsQ0pGliAppqNZcTYMsgQ4TUSKuDLHLBPoAbsLev7wV7Hbhy0LtpKVxV430e3Cf0xcHyrP+Rm/BXiUYBABQx5BdxWDdf+/3jJzL+S0YiHZ10Hpmjyn2Zga/dEXuaU5xZcHEzOWzcIXr8R8UKNuj3KouJAzuBTIQ76FhoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWcbF7nO2hd+psDfcqfDKkhrh7bw9hghOylzqE51BlQ=;
 b=eKsJn5q+ni7wu1ZJ6wzA9Y23ynSTcZdLTKjCMH2vLiqBdHe6QxxDoI0xHGIUL4KjZ3FI46ZXqDh1oVaU64L/4p3G8np0SBNVSQtI+RMStiloIDBNqPhSGKWVwlSdtLPSm5Bf3upChooafwIbcLho9dOljf7LgJzgZWJBlySWpSE=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1468.jpnprd01.prod.outlook.com (52.133.162.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 22:33:14 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 22:33:13 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: RE: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Thread-Topic: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Thread-Index: AQHVqYxRjjQT6EPsk0uhvsHduSJ+e6eow+OAgAAQwHA=
Date:   Tue, 3 Dec 2019 22:33:13 +0000
Message-ID: <TY1PR01MB15622365FCCC3C1CB052FD0E8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com>
 <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZTJjMmUyODYtMTYxYy0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XGUyYzJlMjg3LTE2MWMtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMjUzNiIgdD0iMTMyMTk4ODU5OTE4MTg4MjM3IiBoPSIyS0UwRlc1R1pCQUkzb1NtakdpS2lYQkViZWs9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ddbad4b-5c18-459c-e6da-08d77840c8c8
x-ms-traffictypediagnostic: TY1PR01MB1468:
x-microsoft-antispam-prvs: <TY1PR01MB1468EEE9187740CD2E6637208A420@TY1PR01MB1468.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(189003)(199004)(86362001)(33656002)(6916009)(26005)(99286004)(76116006)(66446008)(66556008)(256004)(64756008)(66476007)(11346002)(305945005)(14444005)(14454004)(478600001)(71190400001)(25786009)(52536014)(71200400001)(76176011)(229853002)(316002)(4326008)(446003)(66946007)(2906002)(5660300002)(186003)(6436002)(7696005)(9686003)(8676002)(6246003)(55016002)(81156014)(81166006)(7416002)(3846002)(8936002)(7736002)(6116002)(54906003)(74316002)(6506007)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1468;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qrX52Gi3rkUFN1UnmEaBdZKwAwkIWl1bBfp3ZEmyjXhJF2FW6i1rJketm749TSnf/O8VwKKKgGWBRyqEXkO0b5lsFjZ2l4nNc2eILnshlnmvlmlOm8MuEGq4U/VTVELjNjhXbYihRKOd4ODON091y0yLktZ1UzY76Wwu9LwEIQkFowhvH6Fd3v6qJ8wNmZXNcu8EyLtYq7+SiQgdDsbkv7p5i499t/zupwjI5h4++RoFYqtqJ2FU9OOXosADpI8vktyEHWWT02rMrZtcFRx42BXEax01mrO8nJHjB4gT95pUm0IXk+Ka9oMR5XjoND+C40lRe7mC28JfJHS5mb7bPfJ076wIiIx7hSXDqpF1MXCneYulE1/gTf1sjJUKsbv0VFhrIuEAEhixetAJJt+wBzey99JlqnxtHtdYQ7FNeMkN5lxScINjidmpyIOA+M78
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddbad4b-5c18-459c-e6da-08d77840c8c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 22:33:13.5385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWWtWGAbiF6815FDs9eFHZVBjjEtJ81/WHBXnEdrg4GldMURz4ev8juUJcjkhc/a5nU5bwMRCXVnpAXenMjmEc7jJo2ezmdZVJ6xVPVFt+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1468
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCkFzIGFsd2F5cywgdGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KDQpPbiBU
dWUsIERlYyAzLCAyMDE5LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+ID4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktcmVuZXNhcy1zcGlic2MudHh0
DQo+IA0KPiBDaGVja3BhdGNoLnBsIHNheXM6DQo+IFdBUk5JTkc6IERUIGJpbmRpbmdzIHNob3Vs
ZCBiZSBpbiBEVCBzY2hlbWEgZm9ybWF0LiBTZWU6DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS93cml0aW5nLXNjaGVtYS5yc3QNCg0KOigNCg0KDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6
DQo+ID4gKy0gY29tcGF0aWJsZTogc2hvdWxkIGJlIGFuIFNvQy1zcGVjaWZpYyBjb21wYXRpYmxl
IHZhbHVlLCBmb2xsb3dlZCBieQ0KPiA+ICsgICAgICAgICAgICAgICAicmVuZXNhcyxzcGlic2Mi
IGFzIGEgZmFsbGJhY2suDQo+ID4gKyAgICAgICAgICAgICAgIHN1cHBvcnRlZCBTb0Mtc3BlY2lm
aWMgdmFsdWVzIGFyZToNCj4gPiArICAgICAgICAgICAgICAgInJlbmVzYXMscjdzNzIxMDAtc3Bp
YnNjIiAgICAgICAoUlovQTEpDQo+ID4gKyAgICAgICAgICAgICAgICJyZW5lc2FzLHI3czkyMTAt
c3BpYnNjIiAgICAgICAgKFJaL0EyKQ0KPiANCj4gSXMgdGhlIGZhbGxiYWNrIHZhbGlkIGZvciBS
Wi9BMSwgd2hpY2ggaGFzIGl0cyBvd24gc3BlY2lhbCBtYXRjaCBlbnRyeSBpbiB0aGUNCj4gZHJp
dmVyPw0KPiBXaWxsIGl0IGJlIHZhbGlkIGZvciBSLUNhciBHZW4zPw0KPiBJZiBub3QsIHlvdSBt
YXkgd2FudCB0byBkcm9wIGl0IGNvbXBsZXRlbHkuDQoNClRoZSBmYWxsYmFjayB3b3VsZCBzdGls
bCB3b3JrIGZvciBSWi9BMSwgeW91IGp1c3Qgd291bGQgbm90IGJlIGFibGUgdG8NCnNldCB0aGUg
YmF1ZCByYXRlLiBCdXQsIEkgaGF2ZSBubyBwcm9ibGVtIGRyb3BwaW5nIHRoZSBmYWxsYmFjay4g
SSdtIGZpbmUNCndpdGggaGF2aW5nIGEgY29tcGF0aWJsZSBzdHJpbmcgZm9yIGVhY2ggU29DIHRo
YXQgaXMga25vd24gdG8gd29yayBmb3IuDQoNCkkgaGF2ZSBub3QgdHJpZWQgaXQgd2l0aCBHZW4z
LCBidXQgSSB3b3VsZCBndWVzcyB0aGVyZSB3aWxsIGJlIHNvbWUgbWlub3INCmRpZmZlcmVuY2Ug
dGhhdCB3aWxsIG5lZWRlZCB0byBiZSBhY2NvdW50ZWQgZm9yLg0KDQoNCj4gPiArLSByZWc6IHNo
b3VsZCBjb250YWluIHRocmVlIHJlZ2lzdGVyIGFyZWFzOg0KPiA+ICsgICAgICAgZmlyc3QgZm9y
IHRoZSBiYXNlIGFkZHJlc3Mgb2YgU1BJQlNDIHJlZ2lzdGVycywNCj4gPiArICAgICAgIHNlY29u
ZCBmb3IgdGhlIGRpcmVjdCBtYXBwaW5nIHJlYWQgbW9kZQ0KPiA+ICstIGNsb2Nrczogc2hvdWxk
IGNvbnRhaW4gdGhlIGNsb2NrIHBoYW5kbGUvc3BlY2lmaWVyIHBhaXIgZm9yIHRoZSBtb2R1bGUN
Cj4gY2xvY2suDQo+ID4gKy0gcG93ZXItZG9tYWluczogc2hvdWxkIGNvbnRhaW4gdGhlIHBvd2Vy
IGRvbWFpbiBwaGFuZGxlL3NwZWNpZmllciBwYWlyLg0KPiA+ICstICNhZGRyZXNzLWNlbGxzOiBz
aG91bGQgYmUgMQ0KPiA+ICstICNzaXplLWNlbGxzOiBzaG91bGQgYmUgMA0KPiA+ICstIGZsYXNo
OiBzaG91bGQgYmUgcmVwcmVzZW50ZWQgYnkgYSBzdWJub2RlIG9mIHRoZSBTUElCU0Mgbm9kZSwN
Cj4gPiArICAgICAgICBpdHMgImNvbXBhdGlibGUiIHByb3BlcnR5IGNvbnRhaW5zICJqZWRlYyxz
cGktbm9yIiBpZiBTUEkgaXMgdXNlZC4NCj4gDQo+IFdoYXQgYWJvdXQgdGhlICJtdGQtcm9tIiB1
c2UgZm9yIGUuZy4gWElQPw0KDQpCdXQgIm10ZC1yb20iIGRvZXNuJ3QgcmVhbGx5IGhhdmUgYW55
dGhpbmcgdG8gZG8gd2l0aCB0aGUgZnVuY3Rpb25hbGl0eSBvZiB0aGUNCmRyaXZlciB3aGVuIGl0
IGlzIGJlaW5nIHVzZWQgaW4gIlNQSSBtb2RlIi4NCk1heWJlIEkganVzdCByZW1vdmUgYW55IG1l
bnRpb24gb2YgdGhpcyBmb3Igbm93Lg0KDQoNCj4gaW50ZXJydXB0cz8gUlovQTJNIHNlZW1zIHRv
IGhhdmUgYW4gU1BJQlNDIGludGVycnVwdCwgUlovQTEgaGFzbid0Lg0KDQpUaGVyZSB3YXMgbmV2
ZXIgYW55IGludGVycnVwdHMgaW4gdGhlIFNQSUJTQy4NCkJ1dCBpdCBsb29rcyBsaWtlIHdoZW4g
dGhleSBhZGRlZCBIeXBlckZsYXNoIGFuZCBPY3RhRmxhc2ggc3VwcG9ydCwgdGhleSBwdXQNCmlu
IHNvbWUgaW50ZXJydXB0cyBmb3IgdGhhdC4NCkFuZCBub3cgdGhhdCBJIGxvb2sgYXQgaXQsIHRo
ZXkgYXJlIGZvciBwaW5zIGxhYmVsZWQgUlBDX0lOVCwgUlBDX1dDLCBSUENfUkVTRVQuDQooSSBq
dXN0IHJlYWxpemVkIHRoYXQgIlJQQyIgc3RhbmRzIGZvciAiUmVkdWNlZCBQaW4gQ291bnQiKQ0K
DQpTby4uLi5hbSBJIHN1cHBvc2VkIHRvIGFkZCBpbiB0aGF0IGludGVycnVwdCBldmVuIHRob3Vn
aCBJJ20gbm90IHBsYW5uaW5nIG9uIHVzaW5nDQppdD8/DQoNCkNocmlzDQoNCg==
