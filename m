Return-Path: <linux-spi+bounces-7995-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 910F7AAF68F
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 11:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B4C3A698C
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB1E262FE5;
	Thu,  8 May 2025 09:16:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C9625487E
	for <linux-spi@vger.kernel.org>; Thu,  8 May 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695772; cv=none; b=nNHhzNZiQM81WKIFUDgED11l841edHi//aSEGwDdORUVOXKyeFdqroQuk1giXJOgafEtD1sx39bt4JHoYpCQXPaRyKwBLrR1ksNEqAi1CjH9h9vYwoVBwwEa0XsJ7/W6xC/m6YFep3FXdmxsxDk0Yc6Ma1gFjYUM5duR7h4u6dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695772; c=relaxed/simple;
	bh=Lt1tCIVKqujgjKveVsfdMdl7K2P6aj9gN0VCsU4Q+0U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EPwMllnlJVb7JyUdC8tSusWL31C4RmUVBj+YUKc5aksRaNJ3uI+jPAsxFi24WDi91Gfs9a41jlr5GAFaTwoebml/fjy7zDmlh/+855yaaUW3RZ8XJ56/iCqU4x1jBS6ePhOGywnXfYPwfWVDmEoX/wxCFokxCDPmgaWEJHzZjF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uCxMN-0002ns-0K; Thu, 08 May 2025 11:16:07 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uCxMM-001hZc-0Y;
	Thu, 08 May 2025 11:16:06 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uCxMM-00042G-0L;
	Thu, 08 May 2025 11:16:06 +0200
Message-ID: <ee4e3e521434a0dadce058e7e5f3bbd77f598f90.camel@pengutronix.de>
Subject: Re: [PATCH v3] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Patrice Chotard <patrice.chotard@foss.st.com>, Mark Brown
 <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Thu, 08 May 2025 11:16:06 +0200
In-Reply-To: <20250507-b4-upstream_ospi_reset_update-v3-1-7e46a8797572@foss.st.com>
References: 
	<20250507-b4-upstream_ospi_reset_update-v3-1-7e46a8797572@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Hi Patrice,

On Mi, 2025-05-07 at 18:04 +0200, Patrice Chotard wrote:
> As ospi reset is consumed by both OMM and OSPI drivers, use the reset
> acquire/release mechanism which ensure exclusive reset usage.
>=20
> This avoid to call reset_control_get/put() in OMM driver each time
> we need to reset OSPI children and guarantee the reset line stays
> deasserted.
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> Changes in v3:
>   - Remove previous patch 1/2 as already merged.
>   - Keep the reset control acquired from probe() to remove().
>   - Link to v2: https://lore.kernel.org/r/20250411-b4-upstream_ospi_reset=
_update-v2-0-4de7f5dd2a91@foss.st.com
>=20
> Changes in v2:
>   - Rebased on spi/for-next (7a978d8fcf57).
>   - Remove useless check on reset.
>   - Add error handling on reset_control_acquire().
>   - Link to v1: https://lore.kernel.org/all/20250410-b4-upstream_ospi_res=
et_update-v1-0-74126a8ceb9c@foss.st.com/
> ---
>  drivers/spi/spi-stm32-ospi.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index 668022098b1eac3628f0677e6d786e5a267346be..b2597b52beb1133155e0d6f60=
1b0632ad4b8e8f5 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -804,7 +804,7 @@ static int stm32_ospi_get_resources(struct platform_d=
evice *pdev)
>  		return ret;
>  	}
> =20
> -	ospi->rstc =3D devm_reset_control_array_get_optional_exclusive(dev);
> +	ospi->rstc =3D devm_reset_control_array_get_exclusive_released(dev);
>  	if (IS_ERR(ospi->rstc))
>  		return dev_err_probe(dev, PTR_ERR(ospi->rstc),
>  				     "Can't get reset\n");
> @@ -936,11 +936,13 @@ static int stm32_ospi_probe(struct platform_device =
*pdev)
>  	if (ret < 0)
>  		goto err_pm_enable;
> =20
> -	if (ospi->rstc) {
> -		reset_control_assert(ospi->rstc);
> -		udelay(2);
> -		reset_control_deassert(ospi->rstc);
> -	}
> +	ret =3D reset_control_acquire(ospi->rstc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Can not acquire reset %d\n", ret);
> +
> +	reset_control_assert(ospi->rstc);
> +	udelay(2);
> +	reset_control_deassert(ospi->rstc);
> =20
>  	ret =3D spi_register_controller(ctrl);
>  	if (ret) {
> @@ -983,6 +985,8 @@ static void stm32_ospi_remove(struct platform_device =
*pdev)
>  	if (ospi->dma_chrx)
>  		dma_release_channel(ospi->dma_chrx);
> =20
> +	reset_control_release(ospi->rstc);
> +
>  	pm_runtime_put_sync_suspend(ospi->dev);
>  	pm_runtime_force_suspend(ospi->dev);
>  }
> @@ -993,6 +997,8 @@ static int __maybe_unused stm32_ospi_suspend(struct d=
evice *dev)
> =20
>  	pinctrl_pm_select_sleep_state(dev);
> =20
> +	reset_control_release(ospi->rstc);

It would be nice to point out in a comment that OMM will temporarily
take over control during resume. But either way,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

