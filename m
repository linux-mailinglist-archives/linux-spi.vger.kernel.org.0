Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC05E1E6988
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 20:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405841AbgE1Shd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 14:37:33 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:1449 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405787AbgE1Shb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 14:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590691052; x=1622227052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZC+4PF417J+7ZXy9R0MrjLQuKiZGnap3XzD84XPhR14=;
  b=Og8PbWQwQq2/ekm8dnOsl+NMfWsQLsCjoFtdCU1x0ZUa7MhEfqwMcPOr
   BzNGgncxGJfoHxrqqSsHjE6otMVfbKVok6LXDaqXvo62r1xKZ4X+kMRwH
   HwQtMa1SDIUpIX3X7Fpt7R0OMHUEAwX2VyQoJgPm9av10U7yB6mOUaksX
   zxwgM/jgcXjaSV4dIjiFWdsdVKbkX7KvTVy/pFTfakyHWdeZ6RN+7p8jL
   9tCsvZBlFN/Oe8z7C4iqhQCfLURhuCtzk9J8GJeRt6bx4Gzky2MC5iuf1
   PkjJ33bmhHuks47ImEVM7mIF5YBRD/BDtCP9326Ix078Bz86teoTzb8Mg
   w==;
IronPort-SDR: H+9o4FzTPSLEoc3HfnF68+fARoZEyywEjMwf+6FqlmfVwDZ5/PGD5a1fjISOeiI6Uwv4Kj+XJB
 l39S4bH1LTy4IxCedFi65GimWPd7/Izen6wxFOmddycTdF5CWu7kH5DOWnAqb+4Cg75T3bsac2
 9K+FEpBFU0jwN7yeGJQ2ko/DX5sZ5QTfRre4ouTFpYOGJuULHafVIIMRqXQJOBHQzq4rguM+6W
 61/pbmGbQldBJBmP437UB4OT6oiOa69bEX2jeDPfI0IVwBKomyBVmm75HgUdsAWTRcUYNaLhpF
 G1k=
X-IronPort-AV: E=Sophos;i="5.73,445,1583218800"; 
   d="scan'208";a="77413573"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 May 2020 11:37:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 May 2020 11:37:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 28 May 2020 11:37:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgLBHxYrop/woSzkA+S056WTjkMdLwdq1XoQBzZmTnJBtS7PGXPGl27VaeYX4KPP5CX2BOCR9tkzPCAkRAM7TYRHCiBeBKpuS40gkJYPZyDE4f55UoCkURtZcrcXlpJrf6ebT2Ks8e0twEOQ8wfcVxXNcsc6SNs5mu3Rk3XuSBgFmQ1gDr3URJa9hcmxz21CXO5yXEKAbJFEESxn1HlYuQGkZ2IYT69Aud/cdcYoXeuNAtQeBb4xpPNgie6wzAaNPEukyBRmHwJF0feUzNOq+nOTA9kTVHbw5WWh6gR1okAmp1Q0wbq9Nftxdah4+9zZOxbdlAdjc2YU8wufQP8f7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/40cNo5Ei2pzFNRIVeQ6QVzkm3FJKwflvU8kuosvgo=;
 b=FAZvMClD5ssM+2dfzYsAaHeGOF0pK1ACKL93CRI79+sldSLs87OSnJ247mD7X6ztSKCg349jzYIvyQxOliHXkAScZFA+Ea2wz1PnYwIGOA/EwKc7TF43y7u0GIvH7hS6WoQl88jjnouEqd4H3UozmNBbtJix1owqr1qaC2A1TC6luzGKpVzJPMTe43zvVmFdAxZGPauxuui7Ou0/RHN2EGCmXQ9vN3BZjhCW3yaQAzfzTuv9mMCpdn0O8UF8x7bvVN9zK7wBCMDUSWLxf0gYnzFdHXQbU3w6oRbm2sKkGlrSP6Quk5IvU+tVZk5jwA+5VvDNlHWYEq+HIsxVhkE/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/40cNo5Ei2pzFNRIVeQ6QVzkm3FJKwflvU8kuosvgo=;
 b=r/Lyv/sJg+65BWvN46rXAglxHiJI3rPWKgENY+a4irSuYvcUt189Xa01mX5TBld3Bx5yYOkbZYYBVdQUPjKfk3Vg8nbQG2Yq96cW1Lll8IIuPcxhu97nc0PjqAkVk2BD2dfsyXB2hMPYZRCXwyEAnKf8JL5TG5zR0ja2NT4E7U8=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4386.namprd11.prod.outlook.com (2603:10b6:a03:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 18:37:28 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 18:37:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>
CC:     <broonie@kernel.org>, <bbrezillon@kernel.org>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: Re: [PATCH 2/6] mtd: spi-nor: cadence-quadspi: Provide a way to
 disable DAC mode
Thread-Topic: [PATCH 2/6] mtd: spi-nor: cadence-quadspi: Provide a way to
 disable DAC mode
Thread-Index: AQHWNR8J45vtEFmIPE2fbETkM911ng==
Date:   Thu, 28 May 2020 18:37:28 +0000
Message-ID: <2963748.sPVSOTQjie@192.168.0.120>
References: <20200508185411.487-1-vigneshr@ti.com>
 <20200508185411.487-3-vigneshr@ti.com>
In-Reply-To: <20200508185411.487-3-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f8c94d8-41d3-49cd-4136-08d803362c93
x-ms-traffictypediagnostic: BY5PR11MB4386:
x-microsoft-antispam-prvs: <BY5PR11MB43868A42DE70E2745752B695F08E0@BY5PR11MB4386.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ISXlBzeW5wXykNHpJv8tPnoFN/mK2v5ojGwaEA0I4N8kBpPoo4+49lMg8HO//Bpae0sEQ6V846iE55Gd6OnqWod1lxcw8rIeUNV1H9xbqjhbkTIyPiPqLu06Qw2U7XEH2IuGntnjC06N8qPz2c5Ugn3+IawRlL4VTchPk3+mhyxG2Tmbb4pqFE4YmMSuUqVb/QXk6QauhJtMSBNZ6mKDAHfAgIbjVwTSfCbNXifi35O7mkAmfyKiOuqwKzvRl+XbduyzaMNgQKEV6K1cbCDrKyv9cLNjlKpHiHaMkCbkNt1BbGSeW8DCQeVy4htSufQVNPAsS8Yh/Qeu1no2BtkhpgCgD76+yEUmCyDaol/0E8G6ejGJ5Dv8mm7r4muBSOiF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(14286002)(6486002)(66946007)(91956017)(76116006)(8936002)(316002)(54906003)(26005)(83380400001)(53546011)(6506007)(8676002)(66556008)(6512007)(64756008)(66476007)(4326008)(2906002)(71200400001)(9686003)(66446008)(7416002)(86362001)(5660300002)(478600001)(6916009)(186003)(4744005)(43043002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: u3c3VOAgoP1ZpS4fsEz06sq0TiLZ3sT6zCZfZ+ATreeUXg4sZpbNBcHl7el2n/5Ss7IzOsPr7S1YVySdmydtnU9B0Ljcr0urssxclyI8Txg4/DoTXTlrkjScZ0sureHZWChNIsuDow4OLKWgIeCulY+uAiVK/uyXuzdVVkEYj7cEqBVXRVbtK15kymIy8qTYtshFI/jJ3uqRVIiekvkGH2GeqWyMaZsmfuRlualhAfESq4kfKhb+fQJKGr9UdmK2QDJmxMPR0FY6SXjWTCdsrRxo+vdH/hFfGnJDwmTem+o3BhtR5HMiEWf4qB+B92VZzzwo75K7ecwiJ1VH8tIdmQIjmdc5ho0HIvN3TptgzYP2nqCF6bjWIn1dCBWFhzkmLJVddS1125Kymy4/+Jsw0aJfMGBsB7pG7hf003pts8vhOnxYbFSaFfCynq8EtvqdYWpWiq9RZm5HR5avbyWpvmRAVzsfP7QFoPxp6/uibKY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99577D8AD56E33429E5FFF694D09518E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8c94d8-41d3-49cd-4136-08d803362c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 18:37:28.2261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nj8WRC3OiwCzQsmN46Or5FcWdWEn9C96WDCXc+PUcPe7DB/IHyfaca5sjhXgUkzU6ZHaskkFrI4flqvaiMNHU7dxfBBTbRA/vzY2f/wIIsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4386
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Friday, May 8, 2020 9:54:07 PM EEST Vignesh Raghavendra wrote:
> Currently direct access mode is used on platforms that have AHB window
> (memory mapped window) larger than flash size. This feature is limited
> to TI platforms as non TI platforms have < 1MB of AHB window.
> Therefore introduce a driver quirk to disable DAC mode and set it for
> non TI compatibles. This is in preparation to move to spi-mem framework
> where flash geometry cannot be known.
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mtd/spi-nor/controllers/cadence-quadspi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

