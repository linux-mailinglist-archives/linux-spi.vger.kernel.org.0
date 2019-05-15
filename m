Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18241F0B6
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2019 13:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfEOLYb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 May 2019 07:24:31 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19659 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731805AbfEOLY1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 May 2019 07:24:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdbf6c20000>; Wed, 15 May 2019 04:23:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 04:24:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 04:24:26 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 May
 2019 11:24:26 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 15 May 2019 11:24:26 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2888.namprd12.prod.outlook.com (20.179.91.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Wed, 15 May 2019 11:24:22 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e843:91f7:56c:73e8]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e843:91f7:56c:73e8%5]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 11:24:22 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Thread-Topic: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Thread-Index: AQHVChJyTuikRwKAUUyx+CcmS+4wvqZqXBUAgACAP+CAARKPAIAAHQTz
Date:   Wed, 15 May 2019 11:24:22 +0000
Message-ID: <BYAPR12MB3398ED52051F5BFA08D7B3A6C2090@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
 <cf4bd167-49b8-5649-a2e2-7bf5ddcc6e2d@nvidia.com>
 <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>,<20190515093522.GC5613@sirena.org.uk>
In-Reply-To: <20190515093522.GC5613@sirena.org.uk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a389552-fcc3-42fd-d114-08d6d927e157
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR12MB2888;
x-ms-traffictypediagnostic: BYAPR12MB2888:
x-microsoft-antispam-prvs: <BYAPR12MB2888F1D7A3D1AB4DE35F95E1C2090@BYAPR12MB2888.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(39860400002)(396003)(199004)(189003)(6916009)(102836004)(66066001)(54906003)(229853002)(256004)(6506007)(478600001)(14454004)(71200400001)(71190400001)(86362001)(6116002)(2906002)(7736002)(66476007)(4326008)(186003)(9686003)(81166006)(8676002)(68736007)(11346002)(81156014)(446003)(486006)(8936002)(3846002)(73956011)(55016002)(52536014)(5660300002)(66446008)(99286004)(64756008)(66556008)(6436002)(66946007)(76116006)(7696005)(76176011)(25786009)(74316002)(53936002)(6246003)(26005)(33656002)(305945005)(476003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2888;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h+6GLRc1A+sEBDIzX0BGHQksHEmu8SyHtqJdQTrYbCy5w9fnmgKKWV9geCxLUqWmCDSN+k/hGfkaowDvFnYejaHWaHOYzBr58WZw8aync2jTaK0M/wS6GbTkpHjvS5J+3rM0qBYDKDctYaOam57ksl2uhp1qQKZ3uAz8k0Ng1eDMMD1c+/dWkdp2vaEOCN/IOsPJ50pYb4/qWO+rB2SOPTSnCQYP+othZjVei6HPgBMHWDvp60jymgNkxd8eMg7Ub/NK1ffkzZ8Z9HWEgwBibRVlU7tYzbVRAnCWSzpANeSSceWPmYuk9UAD+bv/ZLeNIo/l6KQjzBGmvVu6/amDgBlahCRFDPD2nJCwnZrIegozGvuIDjygWWVuuJvESTTI5gbxoVffK2E+5+3BpRDsFaJQbKZgcf7zjwK6sT6+toU=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a389552-fcc3-42fd-d114-08d6d927e157
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 11:24:22.5275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2888
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557919426; bh=JeH8eqv+lXYcPjDvBywwbC9f2Ip3KnltI9obfH5lE+Q=;
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
        b=U2X6HEGgqdYQjZYMzAPA48gRYv9szkbYqpuKbWc3M/LQGd6cpKq8K59xTRajIKSKu
         kwl5g9tS6vZIr4SzneQwhGWa/+XGHAoWDBYuS1rGCGHKW8aqQrUdf0Gae7mWMB3fll
         Rcd90mnxTxDw9IkJ1DTJ0MOGnQMiuk8bv0K4pKzO2yTywCJuXBBiJUUPuP5eS4VsN2
         MH7+Ign8JrE/IBBvJM7TNK1nXNwUO0UtIH90MgGrUFtpoF0AZZ3LWnpVuzo9AHnal/
         0tG8QjRDn0pyBQgMsD6PJu4oqaGtG4rf8wM8yKBF/y4mT3awBp+kK3bmW62x3g/tUW
         LyLYZllAW7w5A==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> > Tegra SPI doesn=92t support inter byte delay directly to meet some SPI =
slave requirements.
> > So we use GPIO control CS in parallel with a dummy HW CS and use inacti=
ve cycles delay of SPI controller to mimic inter byte delay.

> Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

I did changed but looks like it didn't made diff. Will try with different e=
mail client.

> Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.


If you are referring to comment from Jon on updating commit, I didn't ignor=
ed. I am just waiting if any more comments from you or others before postin=
g updated patch.=20

But I see you applied patch now. So how should I post with updated commit?=
