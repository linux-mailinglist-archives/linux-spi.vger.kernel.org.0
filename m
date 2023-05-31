Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B50717822
	for <lists+linux-spi@lfdr.de>; Wed, 31 May 2023 09:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjEaH1C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 May 2023 03:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjEaH1B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 May 2023 03:27:01 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7E6134
        for <linux-spi@vger.kernel.org>; Wed, 31 May 2023 00:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685518005; x=1717054005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HboPTvd4KDBJvfV3IAdP9GNDPpQKqLISZoGpPjntWFQ=;
  b=clO5mWbdvt0pWOGnpFQaaZp7OdGZ64JfmIMCxf/4f9PBFrmbYeM6JzUu
   AvsOircR3tOYz5PNkW6iQ2m7vc1/X6Xs+0QSwunx/isGihUnGsyQhcxZ1
   SG3krDDhZB+5xvLNOhuliMg1LQv3YtQYSKB+xGzIIRxc/PDBVUJq3m2vM
   xyRvCE2GTppv3cJdgYVUXzHLZycmMQb85Y60yDnP6MUMeIsTYXW+Pe5s/
   QZqf1GcMdNsXUFu0Tw13yf6Wk3pKxOmK4co8x7Za28mN/6OvWYSlxGkwg
   2d6Nf5jnt8RIPR1BLy66EIeiaamW+vRhQqOLmrmZD8I3MYzF88EXDqhsA
   w==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681164000"; 
   d="scan'208";a="31184590"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 May 2023 09:26:43 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 31 May 2023 09:26:43 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 31 May 2023 09:26:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1685518003; x=1717054003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HboPTvd4KDBJvfV3IAdP9GNDPpQKqLISZoGpPjntWFQ=;
  b=fuiZu1gNHsw57Rd/7pLWKGuY3TtX43AMVWLufImSw76wHfoZaWcuOAId
   aBIyxX97jBz69v2tRy0oNWV+93C6YYA39Qjmyj+p1FpO4pSQukHW9cVbR
   2c+1+UOXHIvkjZp90WWIqazvt5v7DxhscA2S7Rbtc8BxcoxNAbiczfQ56
   nsvkNM2sb8OpKNueUCV805nhs5msZbikYCNVxaxxM/0ECz81MO1ZbsbkS
   99F1dMiT0kZaVP1srfY+yFdiX7eNg4ztmM1ymoGSa9aVxtgOV4SY3y+dh
   kF3PYcWuVG3bWX313FLXvWz5zJWcMBoBulXLTppM+I76Ki8OC7My3jtiK
   g==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681164000"; 
   d="scan'208";a="31184589"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 May 2023 09:26:43 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3C557280099;
        Wed, 31 May 2023 09:26:43 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] spi: spi-imx: Use dev_err_probe for failed DMA channel requests
Date:   Wed, 31 May 2023 09:26:42 +0200
Message-ID: <3243730.44csPzL39Z@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230418083505.466198-1-alexander.stein@ew.tq-group.com>
References: <20230418083505.466198-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

gentle ping.

Alexander

Am Dienstag, 18. April 2023, 10:35:05 CEST schrieb Alexander Stein:
> If dma_request_chan() fails, no error is shown nor any information is
> shown in /sys/kernel/debug/devices_deferred if -EPROBE_DEFER is returned.
> Use dev_err_probe to fix both problems.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> With this patch applied /sys/kernel/debug/devices_deferred actually
> shows these lines on my platform:
> 30820000.spi    spi_imx: can't get the TX DMA channel!
> 30830000.spi    spi_imx: can't get the TX DMA channel!
>=20
>  drivers/spi/spi-imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 34e5f81ec431e..b23325a3bb667 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1318,7 +1318,7 @@ static int spi_imx_sdma_init(struct device *dev,
> struct spi_imx_data *spi_imx, controller->dma_tx =3D dma_request_chan(dev,
> "tx");
>  	if (IS_ERR(controller->dma_tx)) {
>  		ret =3D PTR_ERR(controller->dma_tx);
> -		dev_dbg(dev, "can't get the TX DMA channel, error %d!\n",=20
ret);
> +		dev_err_probe(dev, ret, "can't get the TX DMA channel!
\n");
>  		controller->dma_tx =3D NULL;
>  		goto err;
>  	}
> @@ -1327,7 +1327,7 @@ static int spi_imx_sdma_init(struct device *dev,
> struct spi_imx_data *spi_imx, controller->dma_rx =3D dma_request_chan(dev,
> "rx");
>  	if (IS_ERR(controller->dma_rx)) {
>  		ret =3D PTR_ERR(controller->dma_rx);
> -		dev_dbg(dev, "can't get the RX DMA channel, error %d\n",=20
ret);
> +		dev_err_probe(dev, ret, "can't get the RX DMA channel!
\n");
>  		controller->dma_rx =3D NULL;
>  		goto err;
>  	}


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


