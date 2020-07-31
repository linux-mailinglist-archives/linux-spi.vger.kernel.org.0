Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978B8233D12
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 04:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbgGaCBR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jul 2020 22:01:17 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:56123
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730974AbgGaCBQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Jul 2020 22:01:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHkZtzKnjmZcSM15v+WR4ahJa1kxPl9DvHImHRiHLowydBumR7CesTm7KJSDuM/kpgBMDmcIzS9xWNg9EQ2LwV/q0bYX5YChzYYr3JYc4WRPdwAlckyQjpbSkbjqqghOA7oHivzISYc6yivcjAwqMuXwLziLNYedivIcbqkbZfWd2kzjz88FhDXjNSu84zTAspXISQpad+Mrbgk9PSpY6jPRvEbf+vRebafRTTi5thkLjb8K6w5rs2frHaz1FPmON6Wq6EZpJ53+uoDyucauuZgxuC1WMBrwEE2DuOt8TgGQWBSbiRvXNbm6KIFObsLBxNj4v5E4zcut5n440mPwiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3GgrnhtfFfMCeJLVvzBOGL6YuKVfv/KWX12UF5jBpo=;
 b=NIxdmaZlvgEj5awbpcssc3JYz509rqlDBVaKyrh2i7M2HExy3a1TajZ9Tr2bw2OtSLhOVfaI3grX0509sBmjYQv/phcQN/DLsQZkKiYZbIsMKB5SDZYsw9ZLeIkFYyZS7EAmd7tMw/YgSUEIly5kVFrSPN337dF1OeQ3fMk2Y5szYLcp8unRGSAXHUxekWbEK3B6Y86kc66AcWMtmMT5cz/O0Eb/bPLnJBjSKTi81CxThkUh6LUhkviyTwfTkbxZnJKDhxQdor/EO6KFsg/d0IGGClwnTQVaZUAz4XEoq4or5O59O+MZVyop6QpdkSiP2G7s+l7HNya9DouXRomoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3GgrnhtfFfMCeJLVvzBOGL6YuKVfv/KWX12UF5jBpo=;
 b=eVR/FfWPcRfci2Ewl+lLq5OEaY3hYjKX00Oii6UxuKNTTa1K1CKijufBnddk0sYz6/lItYYYnt4foqUsEPb6iiUjsXy74NLtesA0NQM85aFL8Sgc8MXG6i/jsOk6W8TkTeb8lIaxQmaX4SPfHNaZ53Nbgcvj5v6xUk49vqLdPsI=
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM7PR04MB7000.eurprd04.prod.outlook.com (2603:10a6:20b:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 02:01:12 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 02:01:12 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH V2 1/4] spi: lpspi: Fix kernel warning dump when
 probe fail after calling spi_register
Thread-Topic: [EXT] Re: [PATCH V2 1/4] spi: lpspi: Fix kernel warning dump
 when probe fail after calling spi_register
Thread-Index: AQHWY8QSnB44PCmq7E2jprC2eLRCO6kbRbqAgAWu22A=
Date:   Fri, 31 Jul 2020 02:01:12 +0000
Message-ID: <AM6PR04MB56234CF41A225C8969ECE04DF34E0@AM6PR04MB5623.eurprd04.prod.outlook.com>
References: <20200727031448.31661-1-xiaoning.wang@nxp.com>
 <20200727031448.31661-2-xiaoning.wang@nxp.com>
 <20200727111109.GB6275@sirena.org.uk>
In-Reply-To: <20200727111109.GB6275@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0757d08d-c9e6-44ab-0058-08d834f599d0
x-ms-traffictypediagnostic: AM7PR04MB7000:
x-microsoft-antispam-prvs: <AM7PR04MB7000B76F7928FEB5DE84349BF34E0@AM7PR04MB7000.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cMDLLgAidMudIZ22gpSitwmlOa+4livwhgqPzxEKqM6hU+T4XRFUMRr4XoW1fA0rKe+O7F+anr3EEopnI4K95+SpwkUSvVCQQWpIoJFkeAQWBXHncVz5mJ6dLD0V24NvXrEEfzgXi/IW+4LeOqZB8KbwCj8ZJQ6VQicKezkEPgMigW6mfrSzph22mFkc4IdWaKxXvceKEUB2nr7ekE4wkDdI+dwmjKIlN3RhYqo5vTepNpomokcAZLtEHtz8da9xy92l2b7LRoKx+3AIVLutrfrk6zseGp8WT2mxYUcD78ruHfdomTc1/hkhzlO9EySrVgAl8EBM6v9e2RUU94g3Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(66556008)(66446008)(66946007)(66476007)(64756008)(5660300002)(76116006)(86362001)(33656002)(8936002)(2906002)(186003)(26005)(53546011)(6506007)(8676002)(52536014)(45080400002)(6916009)(7696005)(478600001)(9686003)(83380400001)(55016002)(316002)(71200400001)(54906003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dpzVR3vHkYNMnxfhhHiAp0P3zvfSB7yWyCkRS0l7LfKjErITHtgCuZFePPdFjQOz8tGJA1APag9BVzpwVCXN49rvuP5LJs5emJ6iqiMUhCjwrFm+6asHKuPK6lFtQxsIt/i/9s1zyz6F1hwsoTWPbqNVSFlioP2RPWGWh3tkSHDDlskBXFv8dxcyVsBu0PrG32mqxMLP8HAOx2uPsc9RLu8+YbgCZteeyUVBCcNeMBP7CjOnaB/m+RNFrkLeCwRTbDc4VybdP+J8S/jB4SdxwDUrvNPBf5IE0Wa3oUelq0Rgi1ptv1LRCXhkY3lUeIQixXQx07o/aiVbet5eCx0OtAnIk370kUNUlhmWNuGLMzJEKCsQ0qEljmw4fPAVhXRWF4Vk3BikQ4DbonX3pbp2IoJbdn/LZxDdtW5/sZxogQ6mwqzQyAFUl4Ew+1Zlf7PcuDm68hqIH0Ug0rY/o3X5NMPNxtGTv79GWjuJF0ljU13Gc1sGOs2UJ4BpjGmGgNC+no70pLj5BcxafW3/88n14kKC9ADV5xLQZZ00grweOXpJgtknT/mlgz9N+TPxT8ed3opmuln6MYA+lGkUahHQM/BNTExE28ysjk+/RFwEp7uu7UFPkmiiPJJJ7i8QdUWm5+ftlLgdbKSlg28HIoZ9PQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0757d08d-c9e6-44ab-0058-08d834f599d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 02:01:12.3793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zrimWrGuCAbunvqjus3bQjf9NZRhpUlGJRO7u0zRThsuQtF29rLao2I2Cj39QIeHTHTyu5RecJ3LoY/Z5PRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7000
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmsgQnJvd24gPGJyb29u
aWVAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDI3LCAyMDIwIDE5OjExDQo+IFRv
OiBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+DQo+IENjOiBsaW51eC1zcGlAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtF
WFRdIFJlOiBbUEFUQ0ggVjIgMS80XSBzcGk6IGxwc3BpOiBGaXgga2VybmVsIHdhcm5pbmcgZHVt
cCB3aGVuDQo+IHByb2JlIGZhaWwgYWZ0ZXIgY2FsbGluZyBzcGlfcmVnaXN0ZXINCj4gDQo+IE9u
IE1vbiwgSnVsIDI3LCAyMDIwIGF0IDExOjE0OjQ2QU0gKzA4MDAsIENsYXJrIFdhbmcgd3JvdGU6
DQo+ID4gQ2FsbGluZyBkZXZtX3NwaV9yZWdpc3Rlcl9jb250cm9sbGVyKCkgdG9vIGVhcmx5IHdp
bGwgY2F1c2UgcHJvYmxlbS4NCj4gPiBXaGVuIHByb2JlIGZhaWxlZCBvY2N1cnMgYWZ0ZXIgY2Fs
bGluZyBkZXZtX3NwaV9yZWdpc3Rlcl9jb250cm9sbGVyKCksDQo+ID4gdGhlIGNhbGwgb2Ygc3Bp
X2NvbnRyb2xsZXJfcHV0KCkgd2lsbCB0cmlnZ2VyIHRoZSBmb2xsb3dpbmcgd2FybmluZyBkdW1w
Lg0KPiA+DQo+ID4gWyAgICAyLjA5MjEzOF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0t
LS0tLS0tDQo+ID4gWyAgICAyLjA5Njg3Nl0ga2VybmZzOiBjYW4gbm90IHJlbW92ZSAndWV2ZW50
Jywgbm8gZGlyZWN0b3J5DQo+ID4gWyAgICAyLjEwMjQ0MF0gV0FSTklORzogQ1BVOiAwIFBJRDog
MTgxIGF0IGZzL2tlcm5mcy9kaXIuYzoxNTAzDQo+IGtlcm5mc19yZW1vdmVfYnlfbmFtZV9ucysw
eGEwLzB4YjANCj4gPiBbICAgIDIuMTExMTQyXSBNb2R1bGVzIGxpbmtlZCBpbjoNCj4gPiBbICAg
IDIuMTE0MjA3XSBDUFU6IDAgUElEOiAxODEgQ29tbToga3dvcmtlci8wOjcgTm90IHRhaW50ZWQg
NS40LjI0LTA1MDI0LQ0KPiBnNzc1YzZlOGE3MzhjLWRpcnR5ICMxMzE0DQo+ID4gWyAgICAyLjEy
Mjk5MV0gSGFyZHdhcmUgbmFtZTogRnJlZXNjYWxlIGkuTVg4RFhMIEVWSyAoRFQpDQo+ID4gWyAg
ICAyLjEyODE0MV0gV29ya3F1ZXVlOiBldmVudHMgZGVmZXJyZWRfcHJvYmVfd29ya19mdW5jDQo+
IA0KPiBQbGVhc2UgdGhpbmsgaGFyZCBiZWZvcmUgaW5jbHVkaW5nIGNvbXBsZXRlIGJhY2t0cmFj
ZXMgaW4gdXBzdHJlYW0gcmVwb3J0cywNCj4gdGhleSBhcmUgdmVyeSBsYXJnZSBhbmQgY29udGFp
biBhbG1vc3Qgbm8gdXNlZnVsIGluZm9ybWF0aW9uIHJlbGF0aXZlIHRvIHRoZWlyDQo+IHNpemUg
c28gb2Z0ZW4gb2JzY3VyZSB0aGUgcmVsZXZhbnQgY29udGVudCBpbiB5b3VyIG1lc3NhZ2UuIElm
IHBhcnQgb2YgdGhlDQo+IGJhY2t0cmFjZSBpcyB1c2VmdWxseSBpbGx1c3RyYXRpdmUgKGl0IG9m
dGVuIGlzIGZvciBzZWFyY2ggZW5naW5lcyBpZiBub3RoaW5nIGVsc2UpDQo+IHRoZW4gaXQncyB1
c3VhbGx5IGJldHRlciB0byBwdWxsIG91dCB0aGUgcmVsZXZhbnQgc2VjdGlvbnMuDQoNCkhpIE1h
cmssDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHJlbWluZGluZy4gDQpJIHdpbGwgcmVtb3Zl
IHRoZSByZWR1bmRhbnQgcGFydCB3aGVuIEkgbWVldCBzaW1pbGFyIHNpdHVhdGlvbnMgaW4gdGhl
IGZ1dHVyZS4g8J+Yig0KDQpCZXN0IFJlZ2FyZHMsDQpDbGFyayBXYW5nDQo=
