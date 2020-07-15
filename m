Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362352202FC
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 05:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgGODkL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 23:40:11 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:51718 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgGODkL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jul 2020 23:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594784410; x=1626320410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eKM8/Dm8nPH5gPrB7Mymj3FJ+zIUiGTPb0j+AWn6nHQ=;
  b=rCcmWjMWjGA/tL5PDEvG9dcCcC/LaqF/TNBnxCVYvmRCbs4v7m9WsMZq
   taVElYgTnxyts9FhS4eV91Ha9Trqas5E3m2wuSpG80WL+uT61BBCwedKl
   LCgBAhub6wfw/K0NuvBg7uOB46L+1TCgi/thhqspJfgGL8bGmdOYNjh7V
   urneIck9xReuPZ0K5uQZ6lRSgmiiQzcydV6UGnK49+9oChocvj4lECrLo
   J24kyIgOKBTR4s6d4SnCVRJaDlLnBoMz48o9mWccicaputVDvl3NSfsgt
   70bJcCavy7dsX0ub278q+F/M7iUO1N4eDm/HKXG+1Mm5ZEL2pz/FmSPlR
   Q==;
IronPort-SDR: xdcrL1V+OL/OgjPKOyZ8+YcjVPbQTYIYuzytWdz4RbhWIUn3DL0NK5UX3eODhSLYnDd03djPrw
 JZ8S7Kf/6fhUZPVYVOzefofGZF9TW+l9rSXdM985hug9V7SRoXlq8o8awE1igcwnu9qwqvTgLj
 ixvbHwtkhh3GkKU/uYDt9x+N39J3MgkHas/NthujWVV0kfiakBq7HMSz+UCk3tS/fEVm90MI6S
 h0wqTmBJJ9c7peYgiW3YAgR2xyMFpYVkKm6x3OxARFVcbVGKwnhPvvk098Ife52OAeEsAb28R8
 q/0=
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="19228366"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2020 20:40:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 14 Jul 2020 20:40:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 14 Jul 2020 20:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqDjQ9pKZURCvHjvrMuSbayijL43OjbArkqEfk4D8/vnEENPPqQQr4/w16NYr/pdf3wK0A+eIPDPByHoLxxax9ul6lAKry5OUKoIRUIqsLJbsNT8xL9mCzJxh3y7foPSVqbA3HVBcY7ON/pHxpVP+z3/x+0sHlx6+QGKHukOxIB6naUSgrLPVijslnFE2lLLFbZE3F10hInXfXRNRSCrp58lcD0bYeNligPAX+e75w2m78fDjmW96elOKuTf/lK4XLJ66QxureyWsvmdwrc9hRlQcfaqwfQf3jXZoCGRqpd3zuXh2mjc6ukKNhh+TTAKUvebpgdXhutKENWGMMO9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR1ZT07LcbtLX2nHPWSFHFhp/4OrIpdnirumqv4S3YE=;
 b=I+3xRDODFy0qUpGJY8R3ukLJ6UQcB/Au3MjZYrw7IZzHsGFzRTST99SZTbHMVwUx/aoYscxI1JCsDBFGKs3upCWJTghNTFrYv0CO45VTlZ5UJna7HOFVBa0VhY+W9jpEO4w5YzBV3OoPs0xtDql0hjeAS6dy1e+q57W1n1HwCoV8nxGnFWrOguVxsWW6yZErHqSKe1fNJbJKSE3ZjPvXhg1LPJtjj0dzn/hcrio3yPQKte3qI+f8FDRsTCj5rVJtrdG4EiTdTA2aYwYC1Uo2tOcdtWiO0+nNLzPKYASHS5c3LJKMlKap79rb9Gl2Vhw1//S4rH1hMJz86sKflABKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR1ZT07LcbtLX2nHPWSFHFhp/4OrIpdnirumqv4S3YE=;
 b=tt4hAZw+pVhbO7SMxjjIVl5+Sud9POHnJNr/yDrQcJYIh+ROUJMetwS4IiF2RKehRoFP0LRWhkbx7+bU7P1h+MBYZpVSJ2PM5+9zRB+YHmDxIo7loVLKEvgE9ONj09WcR53HckOcRpEdntKALEEX4wOTWt4O0v5jVMwsckn2oh0=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB2741.namprd11.prod.outlook.com (2603:10b6:a02:bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Wed, 15 Jul
 2020 03:40:06 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 03:40:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <p.yadav@ti.com>, <vigneshr@ti.com>, <linux-spi@vger.kernel.org>,
        <boris.brezillon@collabora.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <matthias.bgg@gmail.com>, <michal.simek@xilinx.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <nsekhar@ti.com>
Subject: Re: Re: [PATCH v10 00/17] mtd: spi-nor: add xSPI Octal DTR support
Thread-Topic: Re: [PATCH v10 00/17] mtd: spi-nor: add xSPI Octal DTR support
Thread-Index: AQHWWN+dU3MRlEjPj0CyeRCYqGYmmg==
Date:   Wed, 15 Jul 2020 03:40:06 +0000
Message-ID: <afa04032-b886-81ea-7c4c-07ad281aeb98@microchip.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <e6d4c015-b70f-40e3-2275-89d245e817e8@microchip.com>
 <20200714191947.GI4900@sirena.org.uk>
In-Reply-To: <20200714191947.GI4900@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.122.210.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd64182b-e8c4-418d-0704-08d82870c443
x-ms-traffictypediagnostic: BYAPR11MB2741:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2741D444E3A6F34DB56477DEF07E0@BYAPR11MB2741.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EuLQbpM/HkXHl7bfPiK+hL+sEsoY53dNe+bDZR1XXYxna3fZNm2dpLiIxva/vM4p5nYkd47+xD20n/4rFxzkISnjhWi5zVIxZcD9UCQsgj0388n+omwvS8MKVpRZovcerCMDXNmJLn4pW4aVCtSMuh/WmwGggiRY5pPKoUXwxxV06UF0H8Dc+H8nBW5/ELjlVIzlvmnUDWinKp5BjNonrbAfMMLvJg9FWUzI/iLIezdM5WzB35c3fgqRb231zt3K685C8QnIWSnL2LxVuXtMuUGmBETEwYuovxMo/8Y3gofNnWhAFLjt4FQZVSuOthzcUcdWd7kcgMZhlo7/z/iyPAKdxrx+owbyynLDA1ji+1JDCgOBa1DPupBJUQlQYih6pwTowagOJ8S2UZaa9A9pefx6z2l+L6ReWdEgdC+iRmaSD8z2vquu1Q4WLDTFe0ic/7UzL7X9LvFWb2RJJqBVkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(136003)(396003)(39860400002)(376002)(966005)(64756008)(478600001)(76116006)(7416002)(86362001)(2616005)(2906002)(5660300002)(6506007)(31696002)(91956017)(36756003)(66476007)(53546011)(31686004)(54906003)(66556008)(66946007)(71200400001)(6512007)(4326008)(26005)(66446008)(6486002)(316002)(83380400001)(8936002)(6916009)(186003)(8676002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4aXFAirlv/LBEo5SbvvDMN/ex7xRliwP0vCQhVbefdnoLdKmuqTIPRy85XB5PUf6w7TTZnlkdtGmyc1UGwEYuRqluuP/89f8gpan4k8YVPKKUO8gre3cCG4vVDG6T4E5sag5KeNqXLw6WMI4kNWE36WS6Fo/1hHk8YBQWhmKsHKOUGN7QKBqKO5LBORCDO02ftztjEML/xtUM74XYQKgtJe1R3hTaD8So8DmjiHwxEMFzbDlowQ+c0xOUlPv8kvLjwLDG/RgUECc7VA2pcURFQkZtkojU3wkCBHj/CeIf47fAP2cPH1d9VkaDl4ilcPDV2U5AZplWaFc5l6XZlGa7Bj3EPHAgQCy1yeWoiJ1roL/mfc2QQIW1ys/A1qBa8E6dXkwxIQi+VrXthv5IrmjGO9/iNHI1o/Lz2g+r76EbTIvWoDgxar6RJIBT66cyy2CmV8Q6yIWmjxxZ9mABUwmUXyw/8NNfTPUxI7ERO8dSU1mQ+WN3fAjWTJrBbqWziem
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <13CCC07CF7F57F4B95EC309B09037CB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd64182b-e8c4-418d-0704-08d82870c443
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 03:40:06.5461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxaPsg4hDN8uIASWRQ/mHYFIedCgB1A9QhAxsPDMstOI2+qp2DDNTzsdl+gWWgyRDacqDcbucUfkXGz6la7doYmkv3ZviCX53bRH7Z3EsAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2741
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 7/14/20 10:19 PM, Mark Brown wrote:
> On Mon, Jul 13, 2020 at 06:34:12AM +0000, Tudor.Ambarus@microchip.com wro=
te:
>=20
>> These four patches are looking good, I had just few minor comments.
>> If you too think that they are ok, would you take them through the
>> SPI tree? If so, I would need an immutable tag on top of v5.8-rc1
>> preferably, so I can merge them back to SPI NOR and continue the
>> development on top of them.
>=20
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c74=
07:
>=20
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/sp=
i-mem-dtr
>=20
> for you to fetch changes up to 4728f073bfc66b8b555274ef0d7741d7f5a48947:
>=20
>   spi: spi-mtk-nor: reject DTR ops (2020-07-14 17:29:40 +0100)
>=20
> ----------------------------------------------------------------
> spi: Support for DTR ops
>=20
> ----------------------------------------------------------------
> Pratyush Yadav (4):
>       spi: spi-mem: allow specifying whether an op is DTR or not
>       spi: spi-mem: allow specifying a command's extension
>       spi: atmel-quadspi: reject DTR ops
>       spi: spi-mtk-nor: reject DTR ops
>=20
>  drivers/spi/atmel-quadspi.c |  6 ++++++
>  drivers/spi/spi-mem.c       | 16 ++++++++++------
>  drivers/spi/spi-mtk-nor.c   | 10 ++++++++--
>  drivers/spi/spi-mxic.c      |  3 ++-
>  drivers/spi/spi-zynq-qspi.c | 11 ++++++-----
>  include/linux/spi/spi-mem.h | 14 +++++++++++++-
>  6 files changed, 45 insertions(+), 15 deletions(-)
>=20

Merged into spi-nor/next. Thank you!

