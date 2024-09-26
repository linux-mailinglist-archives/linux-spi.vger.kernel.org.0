Return-Path: <linux-spi+bounces-4991-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EA5986F75
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 11:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EEDBB22162
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2024 09:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3230317C988;
	Thu, 26 Sep 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1g3477Zy"
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D3610B;
	Thu, 26 Sep 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341250; cv=none; b=BfS/vAZINSB6XSeQJSEVzIXrWE9S5mkeGZlZ05Y6c96ssmWTMCC8poAzYObQVcNyB+xwx3pPC9or+wXrPQNQtrn+QyaCkB9P7rC6zfewgTzARdtHuvYm+0ZnjuseuHVEgoBtV5oeA9P8xyZCzR38nbGAdfdy1kONirocMxbxZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341250; c=relaxed/simple;
	bh=aeFPmcKmmbExL2IR7IpGRpWzRnxI8fggckfYDKs4nnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=he+qiEhQSrCZHIHPYj/G150/1LsU5TiU1ydTcxb2gMWgarFRndlpoO93UBFMVW3NZK5Z3mWCWLXhlr+OQHGiwxlkjwNn4k4DveaKnV03S62bBavt0gKde9GDTMfLEIYy7Es0bji9iXv46fqni0NfZx2c9rpI1EFtEThtZyYHHC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1g3477Zy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ub1Y8m82tTvGVFmDgJcqPN+qV5RmpDIawEahuLWehTE=; b=1g3477Zy2dgHxKLcQr/xqn6BQ0
	6dOScrwm1tsNJa/iGqfwY8XN20f76oNDwl8JetA1lAAL3/EBFfvtXHkRaBUg9Ts20ygy7uM9NsYy1
	sNzJBKjEF4RJibW1x2egx7nZbqnbEJ0LBCq+cTftm65gHJhv9KZvAfw5530DWUrSyhWvwl4CLVamk
	Ma3J/dnfP993j43GHnykZMdHMBaK32jK4RvAtMfDeTUXuA5NvpYyOO9j4CwgOFajjrZ8ywsvjY7D8
	I2pe7Q48Tf1k4KHp/GHzzJRH6UPkovSFVXGKHQu+Fa6dDG65i3tV69U38Ufd+o26swa99OOmSGg7b
	WR9v4PCw==;
Received: from 85-160-70-253.reb.o2.cz ([85.160.70.253] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1stkMd-0001t8-SA; Thu, 26 Sep 2024 11:00:43 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Dragan Simic <dsimic@manjaro.org>
Cc: broonie@kernel.org, oss@helene.moe, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: rockchip: Use dev_err_probe() in the probe path
Date: Thu, 26 Sep 2024 11:00:42 +0200
Message-ID: <6673004.tM3a2QDmDi@phil>
In-Reply-To:
 <8bc905ff3c47ed458d8c65a031822ba6b9df8a07.1727337732.git.dsimic@manjaro.org>
References:
 <cover.1727337732.git.dsimic@manjaro.org>
 <8bc905ff3c47ed458d8c65a031822ba6b9df8a07.1727337732.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 26. September 2024, 10:38:15 CEST schrieb Dragan Simic:
> Use function dev_err_probe() in the probe path instead of dev_err() where
> appropriate, to make the code a bit more uniform and compact, and to impr=
ove
> error handling for the TX and RX DMA channel requests.
>=20
> Previously, deferred requests for the TX and RX DMA channels produced no
> debug messages, and the final error messages didn't include the error cod=
es,
> which are all highly useful when debugging permanently failed DMA channel
> requests, such as when the required drivers aren't enabled.
>=20
> Suggested-by: H=E9lene Vulquin <oss@helene.moe>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  drivers/spi/spi-rockchip.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 28879fed03f8..6b5c67a357bb 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -853,22 +853,21 @@ static int rockchip_spi_probe(struct platform_devic=
e *pdev)
> =20
>  	ctlr->dma_tx =3D dma_request_chan(rs->dev, "tx");
>  	if (IS_ERR(ctlr->dma_tx)) {
> -		/* Check tx to see if we need defer probing driver */
> -		if (PTR_ERR(ctlr->dma_tx) =3D=3D -EPROBE_DEFER) {
> -			ret =3D -EPROBE_DEFER;
> +		/* Check tx to see if we need to defer driver probing */
> +		ret =3D dev_err_probe(rs->dev, PTR_ERR(ctlr->dma_tx),
> +				    "Failed to request TX DMA channel\n");

you're upgrading here from a warning to an error log level.
As it seems the controller may actually provide some level of functionality
even without dma, is this approriate?

Same for rx below.

Heiko

> +		if (ret =3D=3D -EPROBE_DEFER)
>  			goto err_disable_pm_runtime;
> -		}
> -		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
>  		ctlr->dma_tx =3D NULL;
>  	}
> =20
>  	ctlr->dma_rx =3D dma_request_chan(rs->dev, "rx");
>  	if (IS_ERR(ctlr->dma_rx)) {
> -		if (PTR_ERR(ctlr->dma_rx) =3D=3D -EPROBE_DEFER) {
> -			ret =3D -EPROBE_DEFER;
> +		/* Check rx to see if we need to defer driver probing */
> +		ret =3D dev_err_probe(rs->dev, PTR_ERR(ctlr->dma_rx),
> +				    "Failed to request RX DMA channel\n");
> +		if (ret =3D=3D -EPROBE_DEFER)
>  			goto err_free_dma_tx;
> -		}
> -		dev_warn(rs->dev, "Failed to request RX DMA channel\n");
>  		ctlr->dma_rx =3D NULL;
>  	}
> =20
>=20





