Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9A171123
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 07:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgB0Gww (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 01:52:52 -0500
Received: from mail-eopbgr760074.outbound.protection.outlook.com ([40.107.76.74]:32490
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbgB0Gww (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 Feb 2020 01:52:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTbkNh81FEDIBjOAqSKCDFk8fvNM6Q8l2PJscE6vKjstEkkToG/9pfN+pAP81+99J3CSzsXAhrTEfLQnfW97ZcQg//zU54pp4PLjxARtm40zIp8FXTSQPg7e86KginQvao6Mvc7wOgviIe8ak7E07nQiKw9I+KT648jsHsPSdxdzqJzoyiIeNtJnFoSqJXCKcdmPxGnJC1csTIufZSaj64k43SHxo2VXOkGjh7hgF1NeUuCPZG4r2UXijh17IJUcPpAmfQoNlS44U97ncjJBmZXmQedRngcZx/YV97w1N9/RNjWy1Xq5NMf3+GEECGRERJpzZyU7f1Idpt4ernutqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+Yl933nkOx3ABAp6VyhEOGTadkOA2c4kzfShKnlQbo=;
 b=FjY/xBgYUtyUEhJeWtE9md3bkwhtBoRDZN/FmALctm4AvOGOoyuBa6zwaYEmGWgt7om/vhjcViuDXd+Fod7wdB8XfighIOiK+AWHcQYHT/UIhJwGa23lz7Zpg9u52LQRbhzP7phGJ4EVZDO9uurcDTX6FGy4V67Uh7wHdmZH1rjr00hSWcgbrZT8zUQm4murUDV7S4g7bwh4RP/V0mhEgb3+325dkxOw4vs2zxqiJosV/8Z2imli0ivQIxjgXyN8BEz7kAaEyYbVuWwkSlxAhg6DBVoMa9vsGUa4WJKN5YOsWF8Qnze/1MMfS4KfuXcJsm9yGyTceS7s4inT4N3nBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+Yl933nkOx3ABAp6VyhEOGTadkOA2c4kzfShKnlQbo=;
 b=Hqk7Yqg4PZpMDhdRX2w1laXNt1Fre9PmEtcFuJwiFK5aJ5U++kaYVxWw+KsLYF3jRrJGT/wGvMeYUPnLBrXYnOIS0jJyocBDfkQj4DiC9HBS2af/xH2Kb7CDDqO2DZS9U7FXOxnGtTenKGGNuFfTq5roj2cUtejMKmlIu92Lw7E=
Received: from MN2PR02MB5727.namprd02.prod.outlook.com (2603:10b6:208:10e::25)
 by MN2PR02MB6285.namprd02.prod.outlook.com (2603:10b6:208:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 06:52:35 +0000
Received: from MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::19aa:babf:422f:e25a]) by MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::19aa:babf:422f:e25a%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 06:52:34 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Thommy Jakobsson <thommyj@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH] spi/zynqmp: remove entry that causes a cs glitch
Thread-Topic: [PATCH] spi/zynqmp: remove entry that causes a cs glitch
Thread-Index: AQHV6y9bgeb5P/e+2UGAkvYV/Vp9g6gunRDw
Date:   Thu, 27 Feb 2020 06:52:34 +0000
Message-ID: <MN2PR02MB572711F7545C52882C32F7C6AFEB0@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <20200224162643.29102-1-thommyj@gmail.com>
In-Reply-To: <20200224162643.29102-1-thommyj@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 788a547c-9732-4b1c-a495-08d7bb51a028
x-ms-traffictypediagnostic: MN2PR02MB6285:|MN2PR02MB6285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB62853C03F997F8D118FFBF2FAFEB0@MN2PR02MB6285.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(8676002)(52536014)(55016002)(5660300002)(66946007)(66476007)(76116006)(64756008)(9686003)(81156014)(66556008)(66446008)(81166006)(8936002)(71200400001)(33656002)(26005)(53546011)(86362001)(186003)(478600001)(7696005)(316002)(2906002)(110136005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6285;H:MN2PR02MB5727.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hLNXSLUBXY7jQOubohk3zwIig4luLdTIt61XJJ8rc/kky999SiYD3b/EUHrT+FUO6nCk1H07Tj+1mQccus4cSG5bsXuNduzZp7EK5yBb2LHk49IdbYuCQ4o5hDNAVF4c5VnTxaBb7q4I2mgvFxkU/vnq7pSei83LSurTMEYyL7TinRITAz1zJo2rIfZ5wQhnEuYoEGPx4TId2bN5Wr6S879zWXrSJ5OxCWS8bE0fqUsUMvZtwktJAh4iSDQZkhwH5LyUljcybYhwXufkufE0xIpWAblGdDw7CGb9r/sZ3TKbzjUkVr61VNTqZCZzDAcSUsdUK3KJbr4O+jz8XzTJTP1Qty9dfDjFpV/WOt7fJ6NTdO10e6uKu+XRFxiCyyPHa+UqyvxOL2AYj82+BUHF4n+ARPanxHh1j+RCzNhH83jYxjragQ2Y17albQZRhCc+
x-ms-exchange-antispam-messagedata: Qptz7O8Ipus6DRs0If2nEQUweoUOPa9gm5vVhu//6fBAUCN5OsUO58eLSDUtwMAcCsobkyF5LJMUQHY7rL+Pbp+fiibUU7xWl3x8HqqXrhyhPUHQS0FZH7yuh6AfGIG+z+HMltoyH0gLOwinJL18mA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788a547c-9732-4b1c-a495-08d7bb51a028
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 06:52:34.7828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2WrukfGrDFcYmL46kHBV3gAOfaKW5/ckKjpqBA66S22tKdLPGAavEvD9mpK9iKyiSjTPNGyPolftUXF9YbcJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6285
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Thommy,

> -----Original Message-----
> From: linux-spi-owner@vger.kernel.org <linux-spi-owner@vger.kernel.org> O=
n Behalf Of
> Thommy Jakobsson
> Sent: Monday, February 24, 2020 9:57 PM
> To: broonie@kernel.org; Michal Simek <michals@xilinx.com>; linux-spi@vger=
.kernel.org
> Cc: Thommy Jakobsson <thommyj@gmail.com>
> Subject: [PATCH] spi/zynqmp: remove entry that causes a cs glitch
>=20
> In the public interface for chipselect, there is always an entry commente=
d as "Dummy generic
> FIFO entry" pushed down to the fifo right after the activate/deactivate c=
ommand. The dummy
> entry is 0x0, irregardless if the intention was to activate or deactive t=
he cs. This causes the cs
> line to glitch rather than beeing activated in the case when there was an=
 activate command.
>=20
> This has been observed on oscilloscope, and have caused problems for at l=
east one specific
> flash device type connected to the qspi port. After the change the glitch=
 is gone and cs goes
> active when intended.
>=20
> The reason why this worked before (except for the glitch) was because whe=
n sending the actual
> data, the CS bits are once again set. Since most flashes uses mode 0, the=
re is always a half clk
> period anyway for cs to clk active setup time. If someone would rely on t=
iming from a
> chip_select call to a transfer_one, it would fail though.
>=20
> It is unknown why the dummy entry was there in the first place, git log s=
eems to be of no help
> in this case. The reference manual gives no indication of the necessity o=
f this. In fact the lower
> 8 bits are a setup (or hold in case of deactivate) time expressed in cycl=
es. So this should not be
> needed to fulfill any setup/hold timings.
>=20
> Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
> ---
>  drivers/spi/spi-zynqmp-gqspi.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqsp=
i.c index
> 60c4de4e4485..7412a3042a8d 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -401,9 +401,6 @@ static void zynqmp_qspi_chipselect(struct spi_device =
*qspi, bool
> is_high)
>=20
>  	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
>=20
> -	/* Dummy generic FIFO entry */
> -	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
> -
>  	/* Manually start the generic FIFO command */
>  	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
>  			zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
> --
> 2.17.1
Reviewed-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>

