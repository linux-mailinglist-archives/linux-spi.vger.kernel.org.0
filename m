Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F71CDCF
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 19:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfENRS6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 13:18:58 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:45863 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfENRS5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 May 2019 13:18:57 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdaf87d0000>; Wed, 15 May 2019 01:18:53 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 14 May 2019 10:18:53 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 14 May 2019 10:18:53 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 17:18:52 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.57) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 14 May 2019 17:18:52 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2919.namprd12.prod.outlook.com (20.179.91.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Tue, 14 May 2019 17:18:48 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e843:91f7:56c:73e8]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e843:91f7:56c:73e8%5]) with mapi id 15.20.1900.010; Tue, 14 May 2019
 17:18:48 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Thread-Topic: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Thread-Index: AQHVChJyTuikRwKAUUyx+CcmS+4wvqZqXBUAgACAP+A=
Date:   Tue, 14 May 2019 17:18:48 +0000
Message-ID: <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
 <cf4bd167-49b8-5649-a2e2-7bf5ddcc6e2d@nvidia.com>
In-Reply-To: <cf4bd167-49b8-5649-a2e2-7bf5ddcc6e2d@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd9679c2-3bb5-48f7-ecc7-08d6d8903a75
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR12MB2919;
x-ms-traffictypediagnostic: BYAPR12MB2919:
x-microsoft-antispam-prvs: <BYAPR12MB29198C5C9168BA094744B15DC2080@BYAPR12MB2919.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(4744005)(55016002)(53546011)(486006)(54906003)(5660300002)(6506007)(4326008)(476003)(6246003)(11346002)(66476007)(64756008)(66946007)(73956011)(446003)(53936002)(66556008)(66446008)(76116006)(52536014)(478600001)(2906002)(33656002)(74316002)(6436002)(68736007)(26005)(316002)(7696005)(102836004)(7736002)(305945005)(66066001)(86362001)(6116002)(99286004)(25786009)(229853002)(186003)(2501003)(110136005)(3846002)(9686003)(8936002)(14454004)(8676002)(256004)(71200400001)(81156014)(81166006)(71190400001)(6636002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2919;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cw6DzW1TdFaPjFqjWJqTOKJzBigbQJ2GKACoCLgepYrPRhE4vOXkL+UnDWrtwdRrScX/KoUgJAARYMPqxB/oeHXTiPGAkvJJddUfNEpDmW4iuPk40glyp1Kp3wND/DbpKCziyxK9dpWSH5q/cxcOtXQu59VtD4bJkHgDyE3f9m3N9MLsGK/7dpVzvr7Wh02ZfCklfXLHkqltjglciAhockukfpghwb5BuoNjBdFj4DatQwlXsuVkOU5HfP/qMcip2bmWibj4y0Yho+W4y4WaHh9ZnJ8VNT2myy8YIJ0P+AgCsqtsCetL2oxilyucFTJI0KL2DPyIKX/muRVwT1TxerW2jkBEZWMedCrlYG4yzRSAE28scg0Fm7qDK01zOSQaaqdqQkt+7A6gqOrKEiJJi5GknAC5VvOQn+w4YByNwvc=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9679c2-3bb5-48f7-ecc7-08d6d8903a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 17:18:48.5631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2919
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557854333; bh=CNfAJmJXTse5O37//Wk0m9tM+T47HPFZ0mHfZYmjD4Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=lPSL0+DJMnM5qUeKQuDmrjUxff7BZa3XwMqJvq5muQyEHgOwON3cVKlJ0mxoLU2rW
         49p6q9zQsN9EIpDQjDVxj09chB+WfgPRfp3BlNt8DrBZH2qDnj84N/fIMb5uwXAZak
         cNccij7a+HQhQIWHpGMQQiMtZWO8B2nDGVN2Xs3jnNepcSmmwQqUWxjI/5D3ezUJr3
         MR9WKdeVyY/jLXEhbF/qSKAcH+Y5b3amPg8byeqiffFNNAV1dMv2tIt2BJd/Iz1f/s
         TX/P3pN7aiUI1tP/4Ihp5+iDGngH7jNNwbkQmg7WaocWHJqWERpnUDTz0MTZVKmPQp
         HDfPrMdSynlgg==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY1IDEvNF0gc3BpOiB0ZWdyYTExNDogYWRkIHN1cHBvcnQg
Zm9yIGdwaW8gYmFzZWQgQ1MNCg0KPiBPbiAxNC8wNS8yMDE5IDA2OjAzLCBTb3dqYW55YSBLb21h
dGluZW5pIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciBHUElPIGJhc2Vk
IENTIGNvbnRyb2wgdGhyb3VnaCBTUEkgY29yZSANCj4gPiBmdW5jdGlvbiBzcGlfc2V0X2NzLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFNvd2phbnlhIEtvbWF0aW5lbmkgPHNrb21hdGluZW5p
QG52aWRpYS5jb20+DQo+IENhbiB5b3UgZWxhYm9yYXRlIG9uIHRoZSB1c2UtY2FzZSB3aGVyZSB0
aGlzIGlzIG5lZWRlZD8gSSBhbSBjdXJpb3VzIHdoYXQgcGxhdGZvcm1zIGFyZSB1c2luZyB0aGlz
IGFuZCB3aHkgdGhleSB3b3VsZCBub3QgdXNlIHRoZSBkZWRpY2F0ZWQgQ1Mgc2lnbmFscy4NCj4N
Cj4gQ2hlZXJzDQo+IEpvbg0KDQpUZWdyYSBTUEkgZG9lc27igJl0IHN1cHBvcnQgaW50ZXIgYnl0
ZSBkZWxheSBkaXJlY3RseSB0byBtZWV0IHNvbWUgU1BJIHNsYXZlIHJlcXVpcmVtZW50cy4NClNv
IHdlIHVzZSBHUElPIGNvbnRyb2wgQ1MgaW4gcGFyYWxsZWwgd2l0aCBhIGR1bW15IEhXIENTIGFu
ZCB1c2UgaW5hY3RpdmUgY3ljbGVzIGRlbGF5IG9mIFNQSSBjb250cm9sbGVyIHRvIG1pbWljIGlu
dGVyIGJ5dGUgZGVsYXkuDQoNCkN1cnJlbnRseSB3ZSBkb27igJl0IGhhdmUgc3BlY2lmaWMgU1BJ
IHNsYXZlIG9uIHVwc3RyZWFtIHN1cHBvcnRlZCBwbGF0Zm9ybXMgYnV0IGNvbnNpZGVyaW5nIHJh
c3BiZXJyeSBQSSBoZWFkZXIgd2hlcmUgU1BJIEkvRiBpcyBleHBvc2VkIHRvIHBpbnMgaXQgYWxs
b3dzIHVzZXIgdG8gY29ubmVjdCBhbnkgU1BJIHNsYXZlIGFuZCB0aGlzIGhlbHBzIGZvciBzb21l
IHNsYXZlcyB0aGF0IG5lZWQgc3BlY2lmaWMgaW50ZXIgYnl0ZSBkZWxheS4NCg0KVGhhbmtzDQpz
b3dqYW55YQ0K
