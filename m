Return-Path: <linux-spi+bounces-7523-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF3A843A5
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 14:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D46B4429E7
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570292857EB;
	Thu, 10 Apr 2025 12:48:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4532857CB
	for <linux-spi@vger.kernel.org>; Thu, 10 Apr 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289297; cv=none; b=JwEKjCDMWF0zfGkEgq+HJ8ti9cRUC7cVxf2UUk+Af305hrfOP+khzbJOz7G8043nYR+DRkDnSmA+DJiHlWQtsZH3wibD60mcCKLdCyQDS7JiioiKNU0Lg25J0IR+HpuLgqciIc2L7lqa3yNb4hWva4HRUgvPgEtPI4ogKODZZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289297; c=relaxed/simple;
	bh=XWRyqZQPWdogCOVY7DJKLUH14Wag6FL0hExrw8wiAhg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=El72owND8LD+bpJKyYrMva4CLU3zwVTIa5Vu0MX2/0jJmiqwNQkOtX1a2w+Arm+M0WfNvVDrRYXlNifMynEh8me65FJUqCbMY96+VmhMUSGsLQ1Emxl7UvLmmmiBUYwckgSQQQbeaNBnwM36IecrT/jbw1cWlr9beqZ8EQEPq5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1u2rKC-00081a-9j; Thu, 10 Apr 2025 14:48:08 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1u2rKB-004Guz-1D;
	Thu, 10 Apr 2025 14:48:07 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1u2rKB-00093a-0z;
	Thu, 10 Apr 2025 14:48:07 +0200
Message-ID: <2bb410e34babc4c66895e8e74cf014f89127914d.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Patrice Chotard <patrice.chotard@foss.st.com>, Mark Brown
 <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Thu, 10 Apr 2025 14:48:07 +0200
In-Reply-To: <20250410-b4-upstream_ospi_reset_update-v1-2-74126a8ceb9c@foss.st.com>
References: 
	<20250410-b4-upstream_ospi_reset_update-v1-0-74126a8ceb9c@foss.st.com>
	 <20250410-b4-upstream_ospi_reset_update-v1-2-74126a8ceb9c@foss.st.com>
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

On Do, 2025-04-10 at 14:23 +0200, Patrice Chotard wrote:
> As ospi reset is consumed by both OMM and OSPI drivers, use the reset
> acquire/release mechanism which ensure exclusive reset usage.
>=20
> This avoid to call reset_control_get/put() in OMM driver each time
> we need to reset OSPI children and guarantee the reset line stays
> deasserted.
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  drivers/spi/spi-stm32-ospi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index 668022098b1eac3628f0677e6d786e5a267346be..96fa362432f13c19e4dde63d9=
64a0db64c8ade95 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -804,7 +804,7 @@ static int stm32_ospi_get_resources(struct platform_d=
evice *pdev)
>  		return ret;
>  	}
> =20
> -	ospi->rstc =3D devm_reset_control_array_get_optional_exclusive(dev);
> +	ospi->rstc =3D devm_reset_control_array_get_exclusive_released(dev);

Why does this drop _optional?

Also, since _acquire() is right below in the same function, I see no
benefit in requesting the reset control in released state.

>  	if (IS_ERR(ospi->rstc))
>  		return dev_err_probe(dev, PTR_ERR(ospi->rstc),
>  				     "Can't get reset\n");
> @@ -937,9 +937,11 @@ static int stm32_ospi_probe(struct platform_device *=
pdev)
>  		goto err_pm_enable;
> =20
>  	if (ospi->rstc) {

This check only makes sense if the reset control (array) is optional,
otherwise ospi->rstc can never be NULL.

> +		reset_control_acquire(ospi->rstc);

This is missing error handling. Alternatively, you could just use the
normal request function to get an already-acquired reset control.

>  		reset_control_assert(ospi->rstc);
>  		udelay(2);
>  		reset_control_deassert(ospi->rstc);
> +		reset_control_release(ospi->rstc);
>  	}
> =20
>  	ret =3D spi_register_controller(ctrl);

regards
Philipp


