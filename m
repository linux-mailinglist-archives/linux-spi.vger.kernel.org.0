Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F2C21D2DA
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jul 2020 11:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgGMJdg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jul 2020 05:33:36 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:49915 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGMJdf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jul 2020 05:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594632816; x=1626168816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tzrKYV0RnDHglnWsm4gldpC30T80bQPxTEiXyMr7Xvg=;
  b=EIAB3CEAZY0ThXQDHujJMAP4nN998/UV+ifoMRmzVkHi6znhHLJ0jbXB
   RW1yoTNtrc1TdffdycmwtaiOHhjMcncu9+dCxQAvNcrO7uHyvtNLykdap
   /uFr+vxpPgs/LirrhJL7GgB/EhCMmz3fwMRPbYTaPXEd0+zFUCq1gT24s
   2fiC992E24MnNwksa4ydvBeL26860twnYDFb58Wvsl8am+ojPQzcyH12T
   hqh//yuRoqNyZNoSX61ZANIpF+u87HzvJPSiZqW9O8/Ug1LSMDna9GZ9X
   sk999RuEePoTYlcZ1YGznwd36z1yniXn3aMPI7hHFFuH/VTBeMyI3kdC0
   A==;
IronPort-SDR: onRjiQwPJPWTq5PBeXFGckRfXmDnlwAKxM4weWGxUDI0isHUwOXwvFTfKMGE+bZlhrjdX7KUz7
 8iR5+vqCg+GzIymx6B5WKR2QPwe1i/qVczQAxjxWGbjDwkDnhdVmCvKyo51wLaWY9EQb/RAXUE
 FfCp3qaCM7oB24k3Z1Z8jAsVDs8beRGY7985rydP23YmuO1PY92xeC2xFxoWwaGVWtPiiOsKvn
 bT6f0vOEo7GHgs2OzmIj7kdZSNvveamdoNoBSPN0WhBQmV6bUutGl0rYJ1ONr+FZ3CEkIeUETx
 zRs=
X-IronPort-AV: E=Sophos;i="5.75,347,1589266800"; 
   d="scan'208";a="82872495"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2020 02:33:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 13 Jul 2020 02:33:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 13 Jul 2020 02:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJxU+lfmAc/1fyaq4B98DGwyohdtdocxKyPQqhLeWZJiP8+zbUyJ9twKh9/LAthtQfN058cf3BdQcUsqciIaI2NuBCy/LeCNJMyMYNT4mnrxvxgejK/FRwprKwTkNtm+hTl1x5RmZxkE27PrzfdcTT4LFfj17+WYVnghTvhVf3nxK6BjurLLWM45/iBFpJWzhVN0TtU4X8AWOc0Czu/DXJme6cw3A2XvgEp2Cqj7zHYzxKUlvfYBdcViwklrF/4pOCgZqD5bJuUpibuC+hqbeYkPvp5p04Rs5gm5167kpBkOWoQIcm2X7LcAIQg9zyTSoYYy8hUnfAtRFCHiZDXiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzrKYV0RnDHglnWsm4gldpC30T80bQPxTEiXyMr7Xvg=;
 b=aXRWlRKhwWWmG84EapTfqYeoxVrwReaQv5m1u27H2Fs2S8HyPB0H0oCY3cjxuWOP9epcW8vWOkBKkXfTydvsEA+t6jn0NoTd1LDG5DvzzHVc2T7JPb62nc00y/FCPr1C6KBmUJNxkJq8sGsHJ3yo3yjv/ewXuol5Uu+Gfv8ZSnarBcim75oYfR5nK99EnKMQkKJlQHijWuBViH/MzREhGu/fxrt4bSqnsW9lNS4cu+PXBelipBEv9XLyfhGphhfc6q/GXplFX9MUzEWkYVPSQWgTEui69p75FTSrPpJ0g8mUOq33FKJw6tMjaZDSCwrjPaP8jk35obyPdaglo4wjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzrKYV0RnDHglnWsm4gldpC30T80bQPxTEiXyMr7Xvg=;
 b=Nauv0QAO3fRSvI++fhuqde273zzS5UGFQu4GQK5NCIbTkqVIvQYR9A+s/d9enijT2NhqJ1U3k0jUH1w1kgY5RiCBlYvhVagHmfukx7tmHU5Q71O8jubKLhzA0b7ufBnj7gvRETiZy3TnXPXkKGAPklgn5B6GJptAkFyN4o7cccs=
Received: from DM6PR11MB2858.namprd11.prod.outlook.com (2603:10b6:5:bd::19) by
 DM6PR11MB3868.namprd11.prod.outlook.com (2603:10b6:5:19f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.23; Mon, 13 Jul 2020 09:33:30 +0000
Received: from DM6PR11MB2858.namprd11.prod.outlook.com
 ([fe80::5103:7e0:4953:2aa0]) by DM6PR11MB2858.namprd11.prod.outlook.com
 ([fe80::5103:7e0:4953:2aa0%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 09:33:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <broonie@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <matthias.bgg@gmail.com>,
        <michal.simek@xilinx.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v10 11/17] mtd: spi-nor: sfdp: do not make invalid quad
 enable fatal
Thread-Topic: [PATCH v10 11/17] mtd: spi-nor: sfdp: do not make invalid quad
 enable fatal
Thread-Index: AQHWWPirkap/N5S5zkOx47e9JB4BNQ==
Date:   Mon, 13 Jul 2020 09:33:30 +0000
Message-ID: <33513a5d-fbf2-7321-e46b-2f2ba8b337de@microchip.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-12-p.yadav@ti.com>
In-Reply-To: <20200623183030.26591-12-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.120.242.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9685040-a473-4729-3280-08d8270fcddf
x-ms-traffictypediagnostic: DM6PR11MB3868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB38683FE6872058EE1C373E91F0600@DM6PR11MB3868.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZS0BlmH84NsPMeJ4xgXWllNN+5t8qUgTOOvH5D5uWH1QSP5nfENOSsMpkUcbUv9O9GV1/qzSKBSdN23mGCZFWA0U1TeFVfOz3gXGmMEt3RPbEaACkEgogGqGQI1Oi2DQ/wB6pYmn4BjGcRsEYrIdomT8UVIwy94l3xZlr9xKKGpqoEpwR6YrSQp45hxeJrKWz1mv1M4GgKMFrhyczcMxYX6OlObwdb0J5eEvx7XsfyjprwRPWqqw97jI0BpSL2mLwE0IgMS25LUKW/1CdhvLIMCFLkQHyEM5vYPqy7f6Gdb/ufYI8c4e3ot2vWWQ161LoBK17YOyEwD2CEufNnSFmXAlNu9dvwCoixwzmT3s6QnZ2cMxRSYoFoPxXFo5Q6rqGNqQ3h34TlEdODdtDtjl6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2858.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(366004)(396003)(39860400002)(53546011)(2616005)(186003)(26005)(6506007)(83380400001)(6512007)(4326008)(316002)(31696002)(6486002)(7416002)(86362001)(110136005)(54906003)(66946007)(66476007)(66556008)(64756008)(76116006)(91956017)(66446008)(36756003)(4744005)(31686004)(2906002)(5660300002)(8676002)(8936002)(478600001)(71200400001)(921003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WGBeH3vCn8M/MEUooKYSsILZdffasnZ2p+Tj3XB+rz5yfPAWzBJkXQ2EUCQNRIgCQP1lwDh0PsGX+HbJ5Xz803W7QrTF6fXg0MXdLUiFXqPm8b7zD0oUPsxPz+/o2r+5nYj11t8dBfEtHSSdP3EqkrirFiC/7rFR7s2yX+KQHwaLm10rCwrKsUJDgs9c4fQXq6VM/zzP5RNPMdSvlIjp0fuW3plFoLZK3azm/dcHyWyW5wPEuU4q3hOgj9I1T2LAH4nfc9Y/cK/alUAKKuqRfNbNq1iXbwTskMsUP6+NjnxcEWCkxw4UYJGXvf/RIHAi5E1T6h9Ag/K+x2U4b+cTQt8xexNW2AtpsRrxcQMcbQobPp/KwytqDsxE5vTxDpONXNliwWbOqtdoR+P18kkBQJNZiln/EHbsSEbjhnKVGyzDKut4oUQcPNMfOnJLM+7/zyQvEMXMUyjCcQ1Kpb+u9cr6pyJY7TeSm0c0t6QHtw+t/csphIz1iihrSyxrsRij
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDB2BA490C737C46B6A72E3285091DB0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2858.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9685040-a473-4729-3280-08d8270fcddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 09:33:30.3875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClnI+K6aD5yrpqa/r5zWazCCxRb8r+2JS+dWNECsUWj1bcZIt8utoCWhtolLbLxP/Vp6gReUSoNO5Uyb2rrDzGd78KxA2wXn6sC9pJxUdzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3868
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gNi8yMy8yMCA5OjMwIFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gVGhlIE1pY3JvbiBN
VDM1WFU1MTJBQkEgZmxhc2ggZG9lcyBub3Qgc3VwcG9ydCB0aGUgcXVhZCBlbmFibGUgYml0LiBC
dXQNCj4gaW5zdGVhZCBvZiBwcm9ncmFtbWluZyB0aGUgUXVhZCBFbmFibGUgUmVxdWlyZSBmaWVs
ZCB0byAwMDBiICgiRGV2aWNlDQo+IGRvZXMgbm90IGhhdmUgYSBRRSBiaXQiKSwgaXQgaXMgcHJv
Z3JhbW1lZCB0byAxMTFiICgiUmVzZXJ2ZWQiKS4NCj4gDQo+IFdoaWxlIHRoaXMgaXMgdGVjaG5p
Y2FsbHkgaW5jb3JyZWN0LCBpdCBpcyBub3QgcmVhc29uIGVub3VnaCB0byBhYm9ydA0KPiBCRlBU
IHBhcnNpbmcuIEluc3RlYWQsIGNvbnRpbnVlIEJGUFQgcGFyc2luZyBhbmQgbGV0IGZsYXNoZXMg
c2V0IGl0IGluDQo+IHRoZWlyIGZpeHVwIGhvb2tzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUHJh
dHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1u
b3Ivc2ZkcC5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCg0KQXBwbGllZCwgdGhhbmtzIQ0K
