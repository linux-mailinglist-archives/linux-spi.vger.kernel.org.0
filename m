Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19BFFB260
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2019 15:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfKMOSy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Nov 2019 09:18:54 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:12233 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKMOSy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Nov 2019 09:18:54 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 8r1LOxkgUn8VI9rT9PlZYtvYcX9KosJx0t17VixGxmeT+XLuSbXvXZFaGit9egKW4zz9+LfsX9
 ZI1XTl3NXN5C8ld/Of3OWI4fMrkdvDt/WgOXJCSh41Gora/bI7wAk5s8UzosbN9Oepjh8E8OKq
 tcrEeipRu5ejFIDbt9ptLL0UpuAv4Zv2N+FVaeETRgRuS1MoPCdZK7TjUzflAO6biioHjDSSTT
 bJxpMhjaLU+BWB0Ry9usXYyUjy1oU+G6fPDa7CTuF06hN2lzrcuIUJD9NT81RncppwjEWfF6Q8
 bDg=
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="54145797"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2019 07:18:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Nov 2019 07:18:52 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 13 Nov 2019 07:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzzbDNVynApcZ9eKDGplbiKCaM/noE5edJP3LUllRTvTU9Cu/8rUEOeMv8+G2/0I3yV1TtfUl7l90lzjUNni6MtDQbJL6+AfJk9Td5m9YoRwoSlV+5Nh/aFR1hH0IRE9MHoIDVA9rAKQuicjsJNOlUuDtIDFh4bpUYvGc67U6uUK3o0vOMcTxOU5kheQiX/5vYA2r0/FSJQ3eJo3yg+xLhE342Jk/2E6i1wu+eovEUf+HtSkW1aig2vBdSUNynWH72a5qXXJZxGUAyq/gyT86reMsUEjrtOSt1a6C8Rxd11wm5E/gAa8vkiTg7RcbSPruxGtlDAuQCNB2wFU4OZnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BJNR5FIHY+1k0Xyl/mnU+RGnNdeRWYVHV/K7yxU+hY=;
 b=YcvUgrcJoVwExahVHdOpifblbKo9GjurDveNOY0PlcOxYtUVf4yIErPpiwnI+kb5vGtrPJu87AbROy0yc8rifmPewwVhFd7zSA9dW/OFNhq+GpRozOClmA1VZ77TIB6VbZ4nAwspxihciK2qmY//YLkP18YWb+7L1Md3fZ4KPr5mMhOvfZh4nXZTGE8fKZsPDofntIVKm4VUNtgY8UebfMZN3P2dVsE8SVm827xwOzu0tS2uT6FVqHVFOzhmtwyfXGb7uwLBZv3ltzGeI4CdJYtiFjncafPZ7T7Ygjq5+Dt0D1elGvH+IUhVCYo7FidyPAM4RIR5Wg8U6AfWQxCw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BJNR5FIHY+1k0Xyl/mnU+RGnNdeRWYVHV/K7yxU+hY=;
 b=ZV+M1pldDQ7T6XA9q+ujT60+OajMk03yUkWDg66GQarb7DzsfCaj3H5jw707rNXSoLnQLX9XOysueXRgXETBz1YJokRNulCXqMXAuXIzpNWWQcfKTYsXtrkTXppBOnkFhtSBG/FebG1OCvm3dMDZwI/JUf8TXes4YYutugssI1I=
Received: from SN6PR11MB2830.namprd11.prod.outlook.com (52.135.93.21) by
 SN6PR11MB3486.namprd11.prod.outlook.com (52.135.112.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Wed, 13 Nov 2019 14:18:51 +0000
Received: from SN6PR11MB2830.namprd11.prod.outlook.com
 ([fe80::6460:e571:9440:bd83]) by SN6PR11MB2830.namprd11.prod.outlook.com
 ([fe80::6460:e571:9440:bd83%6]) with mapi id 15.20.2451.024; Wed, 13 Nov 2019
 14:18:51 +0000
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
Subject: Re: [PATCH 1/9] spi: at91-usart: Use dma_request_chan() directly for
 channel request
Thread-Topic: [PATCH 1/9] spi: at91-usart: Use dma_request_chan() directly for
 channel request
Thread-Index: AQHVmi1FIf5yTfqv106gQVZTWXlKoQ==
Date:   Wed, 13 Nov 2019 14:18:51 +0000
Message-ID: <05f47be4-f58a-d61f-92e1-c4985c4c3680@microchip.com>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-2-peter.ujfalusi@ti.com>
In-Reply-To: <20191113094256.1108-2-peter.ujfalusi@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::24)
 To SN6PR11MB2830.namprd11.prod.outlook.com (2603:10b6:805:5b::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a01:cb1c:a97:7600:a0f2:f1f3:de5d:e88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f58dd08e-2d66-4537-ba2e-08d7684467f6
x-ms-traffictypediagnostic: SN6PR11MB3486:
x-microsoft-antispam-prvs: <SN6PR11MB348652F8BE37A222629252C8E0760@SN6PR11MB3486.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:177;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(256004)(386003)(6506007)(229853002)(53546011)(6436002)(476003)(2616005)(86362001)(2201001)(8936002)(7736002)(446003)(11346002)(76176011)(71190400001)(8676002)(81156014)(81166006)(6486002)(71200400001)(66476007)(31696002)(486006)(305945005)(102836004)(66556008)(7416002)(64756008)(31686004)(66446008)(186003)(99286004)(66946007)(54906003)(52116002)(110136005)(316002)(46003)(14444005)(4326008)(2501003)(5660300002)(6246003)(14454004)(25786009)(36756003)(478600001)(2906002)(6116002)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3486;H:SN6PR11MB2830.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uORPit9S6cooYTLG51MbJHa83qKpuL5sFgHrEIcARFwuVis1mG8fZbL0VBPHEpXRmVpyVPRmUdpk5vBfvL27w5iUP8IK2mMbGUd9F2cpoxj0rm+2KjpW7cMgx5BTMMWoaAP2czrwVUztWtJ55SI7q3zvXUuDmFCVJUqM0y0U8rH2UhA4y4DoKurlSxXf2Wi1IQjB28FHlltEtmUfePueEHG72lTFDt/rASZmhNs1ANqB1mMrSDSymwWMyb7+we3ViQdrwkRP7cLleZ6aifXPrFLyZ5gMceMb/DFEvtpWKOC1FY2SWshIndE7wvUEm/TiirCJG15gSB4jBnz9b19GHCzHQAmAOsY1IypYZGZ/2ZAzEwiBmtGg9qnVbI4+HDMin5JjILDfNWPQ/ZeezkIilM/l+udgNj25pNa+b9UMLtX75FWNwrqvxyJDU+kCQg/W
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E9B225392312DD4A83975A3892B8473A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f58dd08e-2d66-4537-ba2e-08d7684467f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 14:18:51.1369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qelW7BqasSdr83gKMNZeBpIrC6hU0MycY4HdWRJnjWxn58YigfK0a/6X0f5XzZA8KWRbHZV8R1gRc5IiObSwgswfRSu8zc4RaDjRfCFkzts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3486
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 13/11/2019 at 10:42, Peter Ujfalusi wrote:
> External E-Mail
>=20
>=20
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/spi/spi-at91-usart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
> index a40bb2ef89dc..88033422a42a 100644
> --- a/drivers/spi/spi-at91-usart.c
> +++ b/drivers/spi/spi-at91-usart.c
> @@ -132,7 +132,7 @@ static int at91_usart_spi_configure_dma(struct spi_co=
ntroller *ctlr,
>   	dma_cap_zero(mask);
>   	dma_cap_set(DMA_SLAVE, mask);
>  =20
> -	ctlr->dma_tx =3D dma_request_slave_channel_reason(dev, "tx");
> +	ctlr->dma_tx =3D dma_request_chan(dev, "tx");
>   	if (IS_ERR_OR_NULL(ctlr->dma_tx)) {
>   		if (IS_ERR(ctlr->dma_tx)) {
>   			err =3D PTR_ERR(ctlr->dma_tx);
> @@ -145,7 +145,7 @@ static int at91_usart_spi_configure_dma(struct spi_co=
ntroller *ctlr,
>   		goto at91_usart_spi_error_clear;
>   	}
>  =20
> -	ctlr->dma_rx =3D dma_request_slave_channel_reason(dev, "rx");
> +	ctlr->dma_rx =3D dma_request_chan(dev, "rx");
>   	if (IS_ERR_OR_NULL(ctlr->dma_rx)) {
>   		if (IS_ERR(ctlr->dma_rx)) {
>   			err =3D PTR_ERR(ctlr->dma_rx);
>=20


--=20
Nicolas Ferre
