Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A2A271AAC
	for <lists+linux-spi@lfdr.de>; Mon, 21 Sep 2020 08:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIUGJs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Sep 2020 02:09:48 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:38150 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUGJs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Sep 2020 02:09:48 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 02:09:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600668588; x=1632204588;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=6lifLcLr3eWfwFYjAJuoAWwmFsDb0Bud01J1MFSeJuI=;
  b=rpI+nruF2n/4Za6ot8pKtKeif/O26X9sZJWJ/AjWpaupjym/DQjQiCZH
   C1gR6wAjJYPbQKkm5KZemhlwMCqN9TdzTkHX0ltNVE/8sxoIoO1rJxAgj
   OpnvSm+JdDhfKLODY2d+oHED7CqXJUrdDWKz7RASH0OjiibLUiwd78agF
   BkOMhbsJTIwh3Fog6qllN/WBfhrClHUaAPmcqMuHIVZ9QvyNJQ+mAHlNk
   74rhRssIFWTA78KKG3cPlhGz5v5oNaWHMC6cnZkxxUuHJRULizl1h/G+W
   2QiTQuI28zPKEY/GFGloqJvCAsi7tNxmdyRre7mkpByt6Xc1hFiiu9QGb
   g==;
IronPort-SDR: jRH+UseV5+Qe5jmqj8DiyT6Voadl6dm4nNvTTbPqM/NTbY+yFTyCcYElDwmmX1l+UH8YLosJH+
 CK2bLSYrgNnGyhoBioPylSTSepcYcSPHjWFv9VBJVd60TmMGmbWB87AXGm9ifHSSSVZo/RXfSA
 EeS0HCR31PaLO5vVPw8Z5p5bQtPqopRPZqDLo+Mv4G10mEw3PJYazfdLkGeMzGtv223uDq7VSR
 xsxLvg1w1GZ6wgNKslCb7gSPVlS8CJ47GX1slzo7T4mGQUKUDFxY48DM/AFv/DSxkJ9jQbq3Fh
 QMk=
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="92545737"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Sep 2020 23:02:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 20 Sep 2020 23:02:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Sun, 20 Sep 2020 23:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1Z6Dh0WB+1i3JsM+Y6JjyI2p1Vd6SHWv394858bNyn4kcjqBfR8I3HXfx7jVlB3UgxP5QPpI48Yxbm2CTuYYdNg8B+p0/nCkQfWLa/lS+fewSj9MeHK5IJ59XidUGWo2K4iih0xozOvDSa6ie9EyQpToY/g/wT3IO701JdYcJTLPCCoR44q10mZo5Z0Gj+X7mitscYXXkmFms4JuT/IBK59YDt78SOF1Z7iaR+5JAUR3KSCCKIonzw9YydTyfy+bCWq1+VtPTD4c8L7pDy/eO7nMUl7mGJ0/W4YLFJnTmLtU/vHgyu5gN+w/zqnuyyOzFnBRugEWRJ2zXaKApurNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lifLcLr3eWfwFYjAJuoAWwmFsDb0Bud01J1MFSeJuI=;
 b=GV5F6tmSk2o8bUX1eyyM+18RYVOP81INC/X10XOrp70QRNLb9Ubs1AQ99+Z5+f++b33JTG4bMEsEsGugkd+gzf4x5b8yuE5uoXo0uFKJnC0rkGGkh0JHZzddjPMDC46G1PjA7JmO4LFhpWInBUA4kg3LTWn0s4WfnI1X6F4GgKodWNr3On8hZ/ZddQjtxeSUyMZyKGNvqBIXGX72JGKH+qSpre66JRNpSRGZ0JBuckOj9VbCI8MfvZQTOBG3Y0FXX87FzqnBIEtgOOqNqi3Mw+cXPrHgS6Mti5vYKdGNFmNDRC4NPhpzsW9K9S0D8hwh6d5xwA2FJ0g9Z8XEVvmrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lifLcLr3eWfwFYjAJuoAWwmFsDb0Bud01J1MFSeJuI=;
 b=t93q9MEP1i2HzZGk0trBfNf1Bk9RbdjVuQ3MLs3Q+i1GsYH3hgvMwDx7fxXDCftDmkK4rnT5fO6kymxCN+IoppGqkzEdd5y/iBYVxLhKYnYPR4SU7+ye3if6FwkuCJYRUwSNYQAyy/ysoPHRCF5/R9vLHNdMCuFQDG3F1CzRg9E=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB3404.namprd11.prod.outlook.com (2603:10b6:5:59::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 06:02:36 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385%11]) with mapi id 15.20.3391.024; Mon, 21 Sep
 2020 06:02:36 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Thomas.Kopp@microchip.com>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: atmel: Exposing effective spi speed
Thread-Topic: [PATCH] spi: atmel: Exposing effective spi speed
Thread-Index: AQHWj9zNkov9L5Se/kelVpfvsappFQ==
Date:   Mon, 21 Sep 2020 06:02:36 +0000
Message-ID: <fe705481-ef9e-4dfb-fa86-b138a8cbf4c9@microchip.com>
References: <20200918103737.400-1-thomas.kopp@microchip.com>
In-Reply-To: <20200918103737.400-1-thomas.kopp@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.77.80.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a60c983f-b722-41c8-2006-08d85df3f08c
x-ms-traffictypediagnostic: DM6PR11MB3404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3404874D048CFE5703B5E6B9F03A0@DM6PR11MB3404.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4fO6kJg0UwrEQPP1LqiZ04qqva8AMsGs984QxS39taCIBLIw5O/QAyOP5xfegNzdfdVgDU1YgbG6bS5E9Z1Ul3BdHXL1NZQyOy03sD2lb/Jv78aHlYTxYRrkFollhcipVHsYG6qtIAP0049CjbRxoWZZch9rfvaZ2Xrdc2gnG/9YKerr80m6PzW0bBV5K/vtzD0n9NC2ypP5u6rQMSeaafF7W0YfdtNvIDfa83y1D4CWIXpl7L3xJeIO6695WJ1utSq3T/RPa8Cx+oAxsnS/ZBX88iB1sW+AqDacQdh2NuOYjg/IMZMeb4+tcYUUyS4pZofZBGTWuuRudCkq3L9WCvJcEPZYSpmPGmug4Y7EUmcTuHOCeO0WTnRwC/XrmYmI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(366004)(396003)(64756008)(6506007)(66946007)(110136005)(66446008)(66476007)(26005)(66556008)(71200400001)(31686004)(53546011)(478600001)(6486002)(2616005)(36756003)(186003)(86362001)(31696002)(316002)(76116006)(2906002)(91956017)(5660300002)(6512007)(8936002)(8676002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mTNODRwiX5Z7ysk5+aLbMaj13emrdixx0ND8RqyFQConTNiRMPy5XecB7cjGW2jDKob6RqtNcnLIw6wzMlxUQ6rkrNj8MTyDktA/LQBxrpVP2zbtRHHK9cKixzUdas4sQ4bThvh2ihRLUnpuxopKM0ELp1skTFYX1Yf+0j/n1V1thkHyvzJ8mRtj0qI5x+2xCuak1bzuvn7KK1KJBj9rJwsII6Uh2GVB0bf+L3YO5C8nFgkNNCKWGoX6RcRsF2f3RWBbN+BtuWymfQzye3uGtXWK+6M8HYt77pJWHL2M2ReC0yWFj2eYyt9a3A8FYHXP5tCPGmT0eQdK9sHRw7RgT+kfBZPZF9PVxBX+ATc5h+ciCTKVxn85gmblHj3iHtpb2HEwf5HlKGpRLo93IXpbEayYE+/GxlnKH5olraINwYbQp7DhOuurkbNyHcMd9ZgXAaoAUQoP4sthdqV+Cqmt3SJJ9zMUHGLSEb+izBP0z1uF4ZqoJC0ohb2bMVreujO6Wy/+dIc282nUIeplqRle73GOBpKdOBxdPtxlPij5pboopRHizvdkSfbp+kNJ3CXdJ2HgJf8Ppm/ToEAEIhHgl2EC8H74x0uBvuiuEPQIGw2hKAIRxS2Z0N4pnjhTx1jOHC7innYkv/XqZAP3yz+9mg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C2E84FD54709C4E8A06F3ED52B3881F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60c983f-b722-41c8-2006-08d85df3f08c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 06:02:36.4567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xqccu2R+CtPBWBQtF2cY0ghlqob8/zBmAVAvCSpKDKKDIyGr8rXGELCgg+ohFrDqlGaYLnq41FBb7B76s9cIslUlHR1A4E2vtcV8EL6cMws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3404
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGksIFRob21hcywNCg0KT24gOS8xOC8yMCAxOjM3IFBNLCBUaG9tYXMgS29wcCB3cm90ZToNCj4g
VGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSByZXBvcnRpbmcgb2YgdGhlIGVmZmVjdGl2ZWx5IHVz
ZWQgc3BlZWRfaHogZm9yIHRoZQ0KPiB0cmFuc2ZlciBieSBzZXR0aW5nIHhmZXItPmVmZmVjdGl2
ZV9zcGVlZF9oei4NCj4gDQo+IFNlZSB0aGUgZm9sbG93aW5nIHBhdGNoLCB3aGljaCBhZGRzIHRo
aXMgZmVhdHVyZSB0byB0aGUgU1BJIGNvcmUgZm9yIG1vcmUNCj4gaW5mb3JtYXRpb246DQo+IA0K
PiAgICAgNWQ3ZTJiNWVkNTg1IHNwaTogY29yZTogYWxsb3cgcmVwb3J0aW5nIHRoZSBlZmZlY3Rp
dmx5IHVzZWQgc3BlZWRfaHogZm9yIGEgdHJhbnNmZXINCg0Kcy9lZmZlY3Rpdmx5L2VmZmVjdGl2
ZWx5DQoNCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tc3RyaWN0IHJhaXNlcyBhbiBlcnJvciBo
ZXJlLCB0aGUgY29tbWl0IHNob3VsZCBiZQ0KcmVmZXJyZWQgYXMgY29tbWl0IDVkN2UyYjVlZDU4
NSAoInNwaTogY29yZTogYWxsb3cgcmVwb3J0aW5nIHRoZSBlZmZlY3Rpdmx5IHVzZWQgc3BlZWRf
aHogZm9yIGEgdHJhbnNmZXIiKQ0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgS29wcCA8
dGhvbWFzLmtvcHBAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3NwaS9zcGktYXRt
ZWwuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMgYi9kcml2ZXJzL3NwaS9zcGktYXRtZWwu
Yw0KPiBpbmRleCAyY2ZlNjI1M2E3ODQuLjg2ODU3Yzg0MDhiMSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9zcGkvc3BpLWF0bWVsLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMNCj4g
QEAgLTg1OSw2ICs4NTksNyBAQCBzdGF0aWMgaW50IGF0bWVsX3NwaV9zZXRfeGZlcl9zcGVlZChz
dHJ1Y3QgYXRtZWxfc3BpICphcywNCj4gIAljc3IgPSBzcGlfcmVhZGwoYXMsIENTUjAgKyA0ICog
Y2hpcF9zZWxlY3QpOw0KPiAgCWNzciA9IFNQSV9CRklOUyhTQ0JSLCBzY2JyLCBjc3IpOw0KPiAg
CXNwaV93cml0ZWwoYXMsIENTUjAgKyA0ICogY2hpcF9zZWxlY3QsIGNzcik7DQo+ICsJeGZlci0+
ZWZmZWN0aXZlX3NwZWVkX2h6ID0gYnVzX2h6L3NjYnI7DQoNCnNwYWNlcyBwcmVmZXJyZWQgYXJv
dW5kIHRoYXQgJy8nDQoNCndpdGggdGhlc2UgYWRkcmVzc2VkIG9uZSBjYW4gYWRkOg0KUmV2aWV3
ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCg0KQ2hl
ZXJzLA0KdGENCg==
