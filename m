Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F25D13D889
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2020 12:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgAPLDn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jan 2020 06:03:43 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:18112 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgAPLDn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jan 2020 06:03:43 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: IivA98Bhg2m3qL8LCCuh1WhPm/0EPhK64tzN0snAv3PoE17Nq4RE1Hu0o8LT8RtxSZYHjQVhrR
 2gu2czXCx2KolzFe/wK7wH81T+SXn8D74kobVEU5WCxzRyH4dFe7BnyGmunFLhotVUx5hExWwz
 +b5KNu9AkC1wDO8tyHzUIrHHy/hE2xk+NjzXSJOjYJoHVabBEM1K3pSMpZHi0M6f+YEZW7kmpd
 mwX7e6CkS+0gzw+tAnT8wlQ0Sr4sSMN6nqDDQxK9bkWzT+7qFn6I7KvV5AchFqBwoJBYVsh6fk
 jSk=
X-IronPort-AV: E=Sophos;i="5.70,326,1574146800"; 
   d="scan'208";a="62134877"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jan 2020 04:03:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Jan 2020 04:03:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Jan 2020 04:03:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiFHuagGAy7FtooMDvIgEtxwHRA/oQWXk5QZQqzS/reWdMGfu514J7oUgq8nyyExGb4MUQw2t5BRkfMOoTVf8OYWHKVS7hBoyeaFDIRcMYVxNaY3EFzM5m9KRBLCAx83xO0RvNb0t8la8yHUr6XMTQL51dBmDBrfFSSSLk7sn+Bxwn6LtOIVMtJVlxhZ8rz2jz21HiTvhCE5F9OPp5DuEAOjDs3N6aVyYW6b9676nKGG/f5uGHaB8fucOZqa7XlgoIPpRAh/W3uCRP34j6rgSN/hbvQpif22fEY3eP5pR9ib2dRe4ao3fhQ7+I2a2RpxtUT7yHieLOd4tJAEO/4E/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3E1Uf9YjpEnzOQ9wdQczo9eB2VUC7vh8nelDkZGBao=;
 b=GnIPmMNE0Tyjv3l3JhLfbaKXo2q2ncLeFPrzr2247I7jt3iSqzAnpIDkz2WBY7gsov/kJdVd2gdGvCiCDnwe1m1kpjMT/YzUkxLsGgqVmtZP57T9Th1xLU0px488oWv2jgjf5IYPeqF6OnBF4DKfSec42CpsbzLkSH0XusxeWns54zCXuxQqMRKRxbF6k3H5t5VNZHG2Ktx7MIYSoAkufCM5dbY/hED6ZO2qV4VOW8oO59olwRA+U0Bne9LHV5HqnlQpyZCl5FfWx1TrKEVPYbvDZDzLz5dCQL4mDsSRMpiJZtHARfi3emQ2OCI1T28woLZiJU0zTj+36lk9xy2e7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3E1Uf9YjpEnzOQ9wdQczo9eB2VUC7vh8nelDkZGBao=;
 b=hJjWMRHiJTck5kL/p/NBr6C59F0l0dzpNzCwp2kXIRGWx769sS0QmOgyfX8zP+XMvicifIAXJyc/49HlENryujJG5g/6wZAtOooBUHmelE5pl+3fCI4pyPZv7wFfHr3k9qcWUV7xuvjQ/tPv3xsF1yp6+LsneXbldLxPwAYSEcs=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3808.namprd11.prod.outlook.com (20.178.254.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Thu, 16 Jan 2020 11:03:40 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::71cc:a5d4:8e1a:198b%7]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 11:03:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <john.garry@huawei.com>
CC:     <broonie@kernel.org>, <marek.vasut@gmail.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>,
        <chenxiang66@hisilicon.com>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: hisi-sfc: Try to provide some
 clarity on which SFC we are
Thread-Topic: [PATCH v2 1/3] mtd: spi-nor: hisi-sfc: Try to provide some
 clarity on which SFC we are
Thread-Index: AQHVzFycMbrvA6TGIEC+fP+g3Q+2Jw==
Date:   Thu, 16 Jan 2020 11:03:40 +0000
Message-ID: <38021504.DDLjaa3fGf@localhost.localdomain>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1575900490-74467-2-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f70c070-febc-4589-8745-08d79a73be9f
x-ms-traffictypediagnostic: MN2PR11MB3808:
x-microsoft-antispam-prvs: <MN2PR11MB38089458871684B7ADB6D602F0360@MN2PR11MB3808.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(91956017)(76116006)(6916009)(478600001)(66946007)(53546011)(66556008)(6506007)(64756008)(66476007)(66446008)(4326008)(26005)(2906002)(4744005)(186003)(8936002)(9686003)(6512007)(316002)(7416002)(86362001)(71200400001)(54906003)(5660300002)(8676002)(81166006)(81156014)(6486002)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3808;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NbufhORklvftI0vHFiTNjMFfo8O/22pN+WFjvgktoInzYfRp5ou7bPtWldhonQ89HVIRntyOr/OM8unuwE3kMr5n2nKSU9qOWFREGgGnfuzgNpoGZeUO0M7qnxxczg8f8PutYS4H0br3x/ruekeSBEqZnR8rteGSPTv1OJCH+yYWde4EZRn0Ef2B5UATwoz9K0ej8rnW42UyMkGCLLde7RKrexs57X6rACvCDcR6TQI6bHv0//vzFzLQt7Q9f3XUo86k/jZ2Hyy7nhZyeWh7IDVpylm8GHn/fYw3IlpnFp3fT2nEVSzCQHdHiaseW2d/nDPWRN8KNcrPkXOwVju5sUjyoVjdosIFv/ViaZK9X1zJcOiq1uROJ9ORtl9XFYNP1a/gyqwWgO+tNYd8nqLxjeA7sPetBXNZHfyqSjw8SD5DRUDv7AyOGh0hdCAxOtc3W99rZ6lkldV6C7yzc/mdul3otFNu/cq0Hl92kvPHST4Xb1PzTkug0OEJPT3vF9d/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62518802EC87D140AEBB9D9B17F20A25@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f70c070-febc-4589-8745-08d79a73be9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 11:03:40.5287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3J4gtj7ECzr79SobIuGMZYDpshH+sk/E9ZCTMC1oPJwYjrb4EpttjOpBUl2JWcx2L0NfQyjEKHweQV1iqR+OWcTxRLuOiQmsR7ly0IpvQrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3808
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Monday, December 9, 2019 4:08:08 PM EET John Garry wrote:
> The driver is for the HiSilicon FMC (Flash Memory Controller), which
> supports SPI NOR in addition other memory technologies, like SPI NAND.
>=20
> Indeed, the naming in the driver is a little inappropriate, especially
> considering that there is already another HiSilicon SPI NOR flash
> controller (which I believe the FMC is derived from).
>=20
> Since we now want to provide software support for this other HiSilicon
> controller, update code comments to at least try to make it clear that
> this driver is for the FMC.
>=20
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/mtd/spi-nor/Kconfig    | 4 ++--
>  drivers/mtd/spi-nor/hisi-sfc.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20

Applied to spi-nor/next.

Thanks,
ta

