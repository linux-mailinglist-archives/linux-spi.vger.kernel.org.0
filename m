Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536CF27F9A7
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 08:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgJAGuL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 02:50:11 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:15328 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAGuL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 02:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601535010; x=1633071010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X8SE8XDfW54X2d1maaP6Hof9pb/+fI5oL7DRtCSgIJw=;
  b=wbpmkyzfeYAcmtqE9K49KzESqR4a5IJgSmSoswlV3jGKCrCPUnY9N/tu
   sM8636hx2cg1VBSQ+Bu5qb2tgyWhKlCFsdbzrpTc7VgsTdcz/E6fZNZxA
   iIaSEuLD6mJaQp+rxuWNig3XM/5ygS+mb7jNDunq5pG0y0gNd0kD8l68m
   P8LkTe3U1K8n1JFuUJ3Osdp8Ma7WNuSTffChqwLi6vNTSjoQ/6Rt1MST6
   1TFdsTbPWkKLELAkRgcpNSDmXQwpq+oh4vJhNXERDg7x2WZU89YKVs+zd
   JcA+X2sE2nqhs4e+6dBudDF/P6UIMh5cthzPUrayBmsobDewFGVKeEwFf
   A==;
IronPort-SDR: bcUo0Z3GieuuTmnxcIHcgDHC/R3i9Y9TWezelWRPgsuxkbySJlhnUHW/F6L/xxCxi4rH3K0bA8
 5Fg0+UPK91Bp/dRpcHWMaAEXPHOYj3Eymtq9N2mL3ZKSbBO3jKgIMTxN0NaMfUEYgP5g64oA6v
 8bef78VfQZKSHiOJQZoV8/gbYNk+2Ishr26+/hd0TsPoLfvb+9B3QFhwOR8vZHedvA1akblljU
 0TelR4xV7oPvl4dvqjM86dw6NeqkU4PKTezeISWt6/GOcrdREGl5EbWhncXUL3RiCzEtp6u8dT
 iAs=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="88755262"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2020 23:50:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 23:50:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 30 Sep 2020 23:50:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RX5R6F6vWRlObActEZBvOeufb3qiR7auz1k2Bd+VltModUSxvn2LDc6VjWK1NycPb9cwqrhlt7GTRUEkpzxHwdtMMJBqs7n+se547CJGyLi/6uEXaim9AqF1+jBUl202nwfBIMyBf+lmAHErduozmSr46VZQJ26PZyf05cTKgGh9tl8Gf9igU5KZ/QAUAO+GxHd9sBBgerCCm7IYpw7fYP1+Erf7Do+jzSl1C0aeJV92+rOi9dpVtsdST4O912zEpObcuDc8GDGnEpbyMiyJe9GRo3gDrJ13jLgYKQstU8Dty+WqX+b40w13qfi7TK3NNNmDf8j1jl2yaVdB/eNaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3dAV3NvxipdOUfNl2dbSzJBaN9MEUmHyUVKeh/t688=;
 b=W5ePfkGmaYh5zf2vDlUfMdY6ClN/K0YnS+BAbSV7IXfDw7658u1luuehME4klX+ZNzRwBQQbRa7BJKG4gw2azMsSCI41ybGP+UgjgJay+28GyaiYWxLCMPZEFMB/mOWUrLd/j33gU/2FvreSyQWbvsAL5ctYpYdU85jf8DVtosoJez06q4+8CWRec/AQtoSheqdVUD8zkx6qOeiA84RHfvsqtUAQeneKuTK+Y94/1+ZwAlGfsKBg4ECZDca01LXIu6ziI1VZps4lV0FqZemJkMVlsGOHlnWjPIxE3IQtA9TN65V58AipOOP3rQyv1qG1WcdwaSiTcqdZKmjZBjB6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3dAV3NvxipdOUfNl2dbSzJBaN9MEUmHyUVKeh/t688=;
 b=CQO+KUETUi7mw9+Sl/ifU+HqnwHknpi06I39vFF9cHt78Eh0LUM0j7PpqTYAGGn2zKQohLpgUPQ5RSB3ZTQhcZO+s8U4soIozv+amWWxcUmYfpAJOX6aW4ny/U/qla3eO9AEQ4maxBT2jYHrzFaXL7fzEgwZ8tqvbn2FPQBScEY=
Received: from DM6PR11MB4283.namprd11.prod.outlook.com (2603:10b6:5:206::32)
 by DM6PR11MB2604.namprd11.prod.outlook.com (2603:10b6:5:c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 1 Oct
 2020 06:50:08 +0000
Received: from DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::e97c:9647:f0c8:e603]) by DM6PR11MB4283.namprd11.prod.outlook.com
 ([fe80::e97c:9647:f0c8:e603%5]) with mapi id 15.20.3433.034; Thu, 1 Oct 2020
 06:50:08 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <broonie@kernel.org>
CC:     <Tudor.Ambarus@microchip.com>, <linux-spi@vger.kernel.org>
Subject: RE: [PATCH v2] spi: atmel: Exposing effective spi speed
Thread-Topic: [PATCH v2] spi: atmel: Exposing effective spi speed
Thread-Index: AQHWj+ZcPhTD3715Gkq4z9EiHlh5A6mCXESQ
Date:   Thu, 1 Oct 2020 06:50:08 +0000
Message-ID: <DM6PR11MB428354FF073BCB8668D50DDFFB300@DM6PR11MB4283.namprd11.prod.outlook.com>
References: <20200921071036.2091-1-thomas.kopp@microchip.com>
In-Reply-To: <20200921071036.2091-1-thomas.kopp@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [93.241.63.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2af98ef-b2b6-4ad6-12e7-08d865d63c99
x-ms-traffictypediagnostic: DM6PR11MB2604:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB26046A45DB1542AE470F6AD8FB300@DM6PR11MB2604.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P5S/oZgPi+sRsMBp8tvzqHN/iRJr75K2lIjr3gvFS8lvTWOEYVgWpEnICJTYH4MHQsFE3yw6HJA78vAjXQLLyeI1lZxrb/2hpAjhg7TvWgqQNLXLKe7T9/82xGujN7bCQbyMqgD1ln2LY8JOhHovGd5RD2Rj8vQsmB6VCOi1z7Niwf9dAt/dRRPaaVgi9Bq5is/RtX4KZe+kSWTOdbAuGzSqTkciGWQ39iTpWHSpXSUX7UxwjChEYvplX7xCg/mxHGXqZJktFZDF0+e8aWzqooa/ctpChE/UtOrG/Tqd8eQXo/PM11+PIdiQB7OtKIiQHDsrC2RBWwCQeBdPn4l8Po5y0F2hvuDF1NwL3PIm1NQZceoaFJgp47L/jVMT7f0l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4283.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(39860400002)(396003)(7696005)(6916009)(66946007)(71200400001)(26005)(55016002)(9686003)(2906002)(6506007)(52536014)(33656002)(4326008)(316002)(86362001)(66446008)(5660300002)(54906003)(8936002)(66556008)(478600001)(76116006)(8676002)(64756008)(186003)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dhRazo7Zlrt9CMxfDpTTEVfMqyJjHKhHAaSubLF5xpQuLs5MQwvrmEHkVR8XCIrS4Lzj96vWlbRbFO7St/JtzM7UGLeGHhSCLdQVFxZLiQqvhYUedrzSc1MqdbjeC4T+H5z4j9PBfVgV87s00qbgDNCeXP1pNwi8+Aj0IjqgDgZ8gjYG6dKP/ziMQsxzxiLOgfhKPjM6vB4DeGF2CyDOQIwgNInkPo0fc/6No3gOTVOgJ3vM0x4+mk3Wsgt+bPjEhSsOpTCPIWp0wmpqlOk8KoMfKiJkZsEGzsnmNVfx60AtoTggrhoLk/tZYq7CLQDxxmWgJPd/XDe2G8sCGOWFV8FeHHvxUB+5ebdWKAlSL52ePKO1TMr0c23fBjxHfsKWzdZIbCpTWsg74T6SrSAje125uxAeWWZo/G3Ikl7GclDhbiLvjVzxVKUUyMhTTHFoFe95l+skWFnU1NVde1vyrpe9zbE520u55JKiNZUADl6v+A5chJBJklYsvLNaDjIPgrCVsYTk28VYXeE8oQJSD2F97W75hMxnA6ANCPesEN/OycZ+Mmw6I/AZ1VpY4RdWZbxDjvEUBnp0NGgJwMIBEZSQ/xEFZbjfpHaBXXOSaKAArjpEJQ+Iatfn5Qd6iWGovm6dJkoB6B1KLQdn7G2tNA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2af98ef-b2b6-4ad6-12e7-08d865d63c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 06:50:08.5287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XY3wFMkz21yP3f9lDDBcMBR6CRhEsNf1+v2AtxT1YhfYWl0lNSvvsE5cy8LXTTvzj92l4by8sD0njsIim3wtStWYe1SydlqBVpYDDZZUM1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2604
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> This patch implements the reporting of the effectively used speed_hz for
> the transfer by setting xfer->effective_speed_hz.
>=20
> See the following patch, which adds this feature to the SPI core for more
> information:
> commit 5d7e2b5ed585 ("spi: core: allow reporting the effectivly used
> speed_hz for a transfer")
>=20
> Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/spi/spi-atmel.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 2cfe6253a784..799229bc34e1 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -859,6 +859,7 @@ static int atmel_spi_set_xfer_speed(struct
> atmel_spi *as,
>  	csr =3D spi_readl(as, CSR0 + 4 * chip_select);
>  	csr =3D SPI_BFINS(SCBR, scbr, csr);
>  	spi_writel(as, CSR0 + 4 * chip_select, csr);
> +	xfer->effective_speed_hz =3D bus_hz / scbr;
>=20
>  	return 0;
>  }
> --
> 2.25.1

Hi Mark,

I realized I only sent this to the list, not to you on to/cc. Can you consi=
der=20
pulling this please?

Thanks,
Thomas
