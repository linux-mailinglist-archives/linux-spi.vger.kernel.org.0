Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2941A11D7C6
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 21:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfLLUTY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 15:19:24 -0500
Received: from mail-eopbgr1410114.outbound.protection.outlook.com ([40.107.141.114]:17999
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730707AbfLLUTY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Dec 2019 15:19:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcTgT90weiKCAUqZXeUkOWsX3Q80Yhqt+oy+W0RQQmuPvPBUFLpECkNw9Crv8g76fC52ritax5MnUQ4Pc7emgAM+FEa7gSRIznnYsr5DDht6mQ2X3DH96Iv2imUorlIKzI9zy68PcJ64FQQxcU3owW9y8Cp6r6ggNfknrR7A8DlN5ItonVOGKWiaiNHCzja3EghmhfkFmAgWXSWP4PD3ST60oGow2ynuPuZmsN4hCC67gqcMMV1Z/ycMdKOrQ2eBrvNy+9UTCSwZWK8p6WsOj57/vL/BtM7Y9NLjdocEo5WXua5HxgJ4jRJFTY4dbQwOD2SHzXTeyb+vasnmpg3kdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA2Th6z1BCb+G/Fw7zh6V69GKhrhS9UW8QS5R6DAZXk=;
 b=m6uYO9TViL1gHinGYcuePmqp1qCLtqJMFsoN3jw/G1aWvFWPHE+9zGo4Xhqkk3dHeCz5Y3bYSKtzewLzE+yk7gMilPVtLRRZsmZb2QLK0BhvqkP+sftk5SKODaySHQLrGouZ143Z9CcAyK57nfxKdLaJ0ycJo9dnsP3YYVUw7WeISNnnQ8aByCvryo/YItT2zwjv4nq1ncy3Hk4rAAB/05C33VbWoP/jhrZe6VLFucYuYUzoaVcupBqDzysTfGL5jJisr/83jq4bxyKysgXgsbV9eZFr8W+EwEeW8A6TOI5AH3/dMxXoXAekZt9b4C//LRYiSb8W+2xTuNYbWibNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA2Th6z1BCb+G/Fw7zh6V69GKhrhS9UW8QS5R6DAZXk=;
 b=LNIMUn+IzaY1ycsVAJrQZ2LYsHBoJicHoY0CilmOxmExMDlucvUL2DYusfhF0szpx6y3koohFnlLN0KvJ7XZh+xuF8l6kMGuuYJkqnmxMIbIiTH+xExSrpqKiU73noc+zhRdjQooP9G93u1llNhhJEmDDQNNbh6Yo0rqE5NktpU=
Received: from TYXPR01MB1568.jpnprd01.prod.outlook.com (52.133.166.145) by
 TYXPR01MB1536.jpnprd01.prod.outlook.com (52.133.166.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 20:19:20 +0000
Received: from TYXPR01MB1568.jpnprd01.prod.outlook.com
 ([fe80::70bc:2573:de4f:dcc9]) by TYXPR01MB1568.jpnprd01.prod.outlook.com
 ([fe80::70bc:2573:de4f:dcc9%5]) with mapi id 15.20.2538.016; Thu, 12 Dec 2019
 20:19:19 +0000
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
Subject: RE: [PATCH v2 1/6] spi: Add SPIBSC driver
Thread-Topic: [PATCH v2 1/6] spi: Add SPIBSC driver
Thread-Index: AQHVrDsMpgzelIsB7UCp/Sk4dX5yJ6e27ngAgAAFoLA=
Date:   Thu, 12 Dec 2019 20:19:19 +0000
Message-ID: <TYXPR01MB1568ED4D40CEC399E64F6A2B8A550@TYXPR01MB1568.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-2-chris.brandt@renesas.com>
 <37c13497-d20f-583f-72d7-1e3c8a241990@cogentembedded.com>
In-Reply-To: <37c13497-d20f-583f-72d7-1e3c8a241990@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYTQ3YTQzYjItMWQxYy0xMWVhLWFhNTUtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XGE0N2E0M2IzLTFkMWMtMTFlYS1hYTU1LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNzg3IiB0PSIxMzIyMDY1NTU0NTUzMjM4MDgiIGg9IkhFUUl0K0p6RTVYVnBFY2pxd3pBa1BaU1FYWT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [24.206.39.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c5475e1-ae96-4006-224d-08d77f4091dd
x-ms-traffictypediagnostic: TYXPR01MB1536:
x-microsoft-antispam-prvs: <TYXPR01MB15364378963A1F701615C6028A550@TYXPR01MB1536.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(71200400001)(966005)(478600001)(76116006)(66446008)(66476007)(64756008)(66946007)(66556008)(7416002)(316002)(7696005)(5660300002)(86362001)(55016002)(186003)(26005)(2906002)(6506007)(52536014)(4326008)(8936002)(9686003)(81156014)(8676002)(110136005)(33656002)(54906003)(4744005)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1536;H:TYXPR01MB1568.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ipThPMfiqVGYotfqKKGzqPK8SAfPtkUlHGrN3ljNFR0dHYvzrv0UZwmKV563tsfhmv/2lArUbhw82qEnM1j4g7M1TSf6whECSCn7i9On+3983Mlio3HVcVXTIwPXap7tYz+Yrnyh4M9a/2888kYDQDagFVGxDcs3LNdsD9qDXtjRN6TE88JsyIEvc5UZ/ihSlWmmDNVySjpz4n87iA63dycPHScyLBGZnqRJxnDGcGneezcqSshuREMA3x4+0Onsrr6s11q6dPBjnRaua8G8KoFUXXSSk+FZIyXLRjwtBxRBUfBXVrnMwVeGO3SvrqL2H2J1shtbnb8FNH4v/KVJKTX2IdtEFuhy/ettteKvCJtqsHKxPPFuQv/xq+crgXuOyFa2vW68OC1Z/1zqTnTz3bqA6Ob9NvWESg/eosmBTywqIEoDDSWGcZbOI/SqQDec
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5475e1-ae96-4006-224d-08d77f4091dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 20:19:19.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obYjj+tjL6SqFD657gs8D9Uxt22sAt0nFIJndTCKMdNVH3UXmcTbcpZ5aJpNk4/39IW+4p9RQUKZb1ZOvlJcDKsFDiMQZmlZtWHQw/fBlpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1536
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVGh1LCBEZWMgMTIsIDIwMTksIFNlcmdlaSBTaHR5bHlvdiB3cm90ZToNCj4gICAgQXMgeW91
IGNhbiBzZWUsIHRoZSBkZWxldGVkIGZpbGUgaXMgYmFjayBhZnRlciB1bm1vdW50L3JlLW1vdW50
Li4uDQoNCkRpZCB5b3UgZG8gYSAnc3luYycgYmVmb3JlIHlvdSB1bm1vdW50ZWQ/DQoNCg0KV2l0
aCB0aGUgUlovQTJNIEVWQjoNCg0KV2VsY29tZSB0byBCdWlsZHJvb3QNCmJ1aWxkcm9vdCBsb2dp
bjogcm9vdA0KJCBtb3VudCAvZGV2L210ZGJsb2NrMyAtdCBqZmZzMiAvbW50DQokIGxzIC1sIC9t
bnQNCnRvdGFsIDY4OA0KLXJ3c3IteHIteCAgICAxIHJvb3QgICAgIHJvb3QgICAgICAgIDcwMzQ0
OCBPY3QgMzEgMDk6MDggYnVzeWJveA0KLXJ3LXItLXItLSAgICAxIHJvb3QgICAgIHJvb3QgICAg
ICAgICAgICAgNiBPY3QgMzEgMDk6MDcgaGVsbG8udHh0DQokIHJtIGhlbGxvLnR4dA0KJCBzeW5j
DQokIHVtb3VudCAvbW50DQokDQokDQokIG1vdW50IC9kZXYvbXRkYmxvY2szIC10IGpmZnMyIC9t
bnQNCiQgbHMgLWwgL21udA0KdG90YWwgNjg3DQotcndzci14ci14ICAgIDEgcm9vdCAgICAgcm9v
dCAgICAgICAgNzAzNDQ4IE9jdCAzMSAwOTowOCBidXN5Ym94DQoNCg0KTm90ZSB0aGF0IEkgYWxz
byBuZWVkZWQgdGhpcyBwYXRjaCBpbiBteSB0cmVlLg0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJz
Lm9yZy9wYXRjaC8xMjAyMzE0Lw0KDQoNCkNocmlzDQo=
