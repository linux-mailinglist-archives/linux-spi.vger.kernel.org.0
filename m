Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8781FB25F
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2019 15:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfKMOSl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Nov 2019 09:18:41 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:64834 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKMOSk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Nov 2019 09:18:40 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: MnQdp/DAw1u45jOwmtQvvwATuT4dgvdkSzfYFsQRKN0bZukuSmg8e5zlWyHPfH9sbu6ep04mfk
 89PZW1DaTizvXbQp8r8sOWYbsbR8wAyZETeniUZxUybY8g3uVpcYyiUx3zU47ccd5/OJTSvlMA
 9BB4YRMt7DOWFAIUJeJpAES54fvL5WUXLbiIOWEvKrwdMt6F9EnrZwudRb+fOhKer1qGCsv9WS
 4MVyCm+0JnMRLl6pNVsP/1CzI9aq6rVsheiXrxOAEXpZSJxoYJyXS/fV6r+8gADyqffk7DQiV0
 p+s=
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="56485877"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2019 07:18:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 07:18:38 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 07:18:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlFLJ5YzCy06Fy3Tyu6tHGWeoTLFVizASDl86CY+lGq9eqx0kkHCkyyuc6VeHmYqMA9O54rsc4ERXyBMAVrW4X60xfyHlpwYLz0yxJV+IX0l57jUZg5ZKhR9Vbs+D2jFkGnBexD9GUdImL2Th/dA/6gLKYWFz9BT/bRSJjgw7H6BUb5goYUVSVqSLypDsAucvXAz2nd95QnOsUxesZM28XZpERixzqJKTW2f96if3fYn2r2ubPXRN27F/5qu/s0XM5vNXNsJ4O/8hnElU1AhFkVzUd2j6V/63RELH3RIlvs3V0H82LztgVOoU4t9FftZzVDHDMz+j3ao0CVGKS7SZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqWleQ1D4BU+AoZiAXKQK2xpoSli5BvDi9mvNKmj+eA=;
 b=kJ21mIFIYJ/F46kKkjTNA+c9XuIaz/9muwe+/UJb11jIPBir9qD2H0YJokkakBJ2STBHjVL/XY6iRt0basGBKt/gCmYUcLApwi2rDUtisqa2bkkWhUkxzXsLqLPpNqVwzIpYGVuyD1PSM8LoaH12lTLCiox76xHZAqj83qkKOnFggqRETkprYd/dj18E1+KsMwyRCQyb68pFTB9kUSPwsSGuswLPSZ99jOoU6LUI6eZWytnkECKU/BGY3nQtgLU0zZndjB0oDFb0Dqb/+uuALHTqEuJ4aJabd8gIvn6cQ+yD9xSGtLh85+McfD+503jti4XfEN1I3qNcFwqEavVyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqWleQ1D4BU+AoZiAXKQK2xpoSli5BvDi9mvNKmj+eA=;
 b=s7ssGI+IJkV8/vG0PQqeI3fBHl6n1nMf6o5tRM54UG3IkzWw/YWiWYtFA/WVzkXOnthyUNuu8kceQZZodz9TnQ8M0jkssnHWI+O0x6e3MQko912hjKGlM2BG1SCpdMzKUbUKR2s58xjLCePj3SKvc4uBQ5cXiyNOrfjnXgp70xY=
Received: from SN6PR11MB2830.namprd11.prod.outlook.com (52.135.93.21) by
 SN6PR11MB3486.namprd11.prod.outlook.com (52.135.112.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Wed, 13 Nov 2019 14:18:37 +0000
Received: from SN6PR11MB2830.namprd11.prod.outlook.com
 ([fe80::6460:e571:9440:bd83]) by SN6PR11MB2830.namprd11.prod.outlook.com
 ([fe80::6460:e571:9440:bd83%6]) with mapi id 15.20.2451.024; Wed, 13 Nov 2019
 14:18:37 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <peter.ujfalusi@ti.com>, <broonie@kernel.org>,
        <radu_nicolae.pirea@upb.ro>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <linus.walleij@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <andi@etezian.org>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <alexandre.belloni@bootlin.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
        <linux-spi@vger.kernel.org>, <vkoul@kernel.org>,
        <kgene@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/9] spi: atmel: Use dma_request_chan() directly for
 channel request
Thread-Topic: [PATCH 2/9] spi: atmel: Use dma_request_chan() directly for
 channel request
Thread-Index: AQHVmi09L5MBKmNT6kyxMhevGP2mlw==
Date:   Wed, 13 Nov 2019 14:18:37 +0000
Message-ID: <90cd6e97-2eda-934a-3175-b7d93d86115a@microchip.com>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-3-peter.ujfalusi@ti.com>
In-Reply-To: <20191113094256.1108-3-peter.ujfalusi@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0038.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::26)
 To SN6PR11MB2830.namprd11.prod.outlook.com (2603:10b6:805:5b::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a01:cb1c:a97:7600:a0f2:f1f3:de5d:e88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04cc951e-b654-45a4-f236-08d768445f8e
x-ms-traffictypediagnostic: SN6PR11MB3486:
x-microsoft-antispam-prvs: <SN6PR11MB348605871B0458A53DE6158FE0760@SN6PR11MB3486.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(256004)(386003)(6506007)(229853002)(53546011)(6436002)(476003)(2616005)(86362001)(2201001)(8936002)(7736002)(446003)(11346002)(76176011)(71190400001)(8676002)(81156014)(81166006)(6486002)(71200400001)(66476007)(31696002)(486006)(305945005)(102836004)(66556008)(7416002)(64756008)(31686004)(66446008)(186003)(99286004)(66946007)(54906003)(52116002)(110136005)(316002)(46003)(14444005)(4326008)(2501003)(5660300002)(4744005)(6246003)(14454004)(25786009)(36756003)(478600001)(2906002)(6116002)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3486;H:SN6PR11MB2830.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0FeR3eX7asHWTTAW5SFV3F8EowyNyZr/WmHrk/975BUbGOfee+oKYlmNie7vhVaMzhP19kea6lqx+Fo+LXWRx2OXNNxANtA+Wq3qbdmNH0Q9dQtIIKUo4iRzat9JJ9zdSc3tP7LzRvhWhY6FlYy89uJ9w9D2pSU5xz7sgJvj5T1fOKHD6mvj9VXUmoRIZd0C44GsYzItH1H3VhyubHumRfhoYmAOMlyZ/9eRG3ugbZMftNWHmAJdlmScsUWWjxpPAKyglfHXWCqXiPN6YZanhjaOAwGEcfKbOSAs9eCLI0JC9a5cemXp1vGtQuR6VBD3jtIlx6cHKYizspN22woqoHCvn9yJy6veJw86tC5mp2J4JTgRsVz7t/F77FBgHm++7BTuZ1Wl9FrOclfaymVY7ExF6FEZjqJ4IGOC+ffjbeyLFjGI7st0eFfOH/M8LaPF
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <56B4D518BD1BC143B10FEFA116F9DA10@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cc951e-b654-45a4-f236-08d768445f8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 14:18:37.0730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qvLBGKzbpgM1ZPUltowRoDj1hUPqqOyQWbvIOzXYuEZ+u0W+1pX8Mc4Em0OidT4h6erSepEC3zJlOZoGhd8H4521vmj7hZPMoDsDIIOEbBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3486
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 13/11/2019 at 10:42, Peter Ujfalusi wrote:
>=20
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I'm not sure we need one patch per driver. If series taken:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/spi/spi-atmel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 9e84a93083bc..56f0ca361deb 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -511,7 +511,7 @@ static int atmel_spi_configure_dma(struct spi_master =
*master,
>   	dma_cap_zero(mask);
>   	dma_cap_set(DMA_SLAVE, mask);
>  =20
> -	master->dma_tx =3D dma_request_slave_channel_reason(dev, "tx");
> +	master->dma_tx =3D dma_request_chan(dev, "tx");
>   	if (IS_ERR(master->dma_tx)) {
>   		err =3D PTR_ERR(master->dma_tx);
>   		if (err =3D=3D -EPROBE_DEFER) {
>=20


--=20
Nicolas Ferre
