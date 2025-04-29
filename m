Return-Path: <linux-spi+bounces-7794-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BEDAA06A7
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 11:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3509D1A81C2E
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CC429DB69;
	Tue, 29 Apr 2025 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6BOioSs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4684E1C;
	Tue, 29 Apr 2025 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917738; cv=none; b=CGbZiWvlW+WppCpEpYeDS/LO5eouXi/ZqGEIaGFuiaj2oP5VplFRJ6ufECuqx9QXNUkaR51XJPE3rfvtQuoh1n+qYG0MK4sg930h1Fc8oksHJiDg2gHoiahMtKjedmoCHlFeECmKQyqsSqg0Z1mp0YRLVIscfrxPq5JUMUM08TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917738; c=relaxed/simple;
	bh=8fXu87wrLogbPcLCUtUFGpTSKiwrSRGee+XNAKCCh+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7OlwWlMJ3X8mA2aa58TTTAH7EiEx07XEjC4F9jdWbQpVKLh/8XA1hAEFNqKDZ0QwvjdFjsnMf91LoWayxk+ps8RfJtK9xh5VDoZFTQ2l3AelaY6YaCCDkCXjQUigWmgmCOD2imQOEtYeIj/iEz/l9BCqbPc0dPdjZXyrtUD4hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6BOioSs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-440685d6afcso54941205e9.0;
        Tue, 29 Apr 2025 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745917735; x=1746522535; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0aok3Qu+pOHjUcAXyJrsWt5iHlE6McYGVKF+Vb+3/xY=;
        b=i6BOioSsN8Ed50Fn+ZuXz/AoD/xMrOfjhPLwMFh+mCmLgldC+uj8E3PquP0j9gB5af
         IqkDaobgQcaplEgltiNuR3o4OydldW4xzROBew8tQYVDIfWfBFieD+MzGCCGFBZzMBL9
         /mCfreVVb6A14aCgYtt86SdFbsV/qsYS1FuOiQZtluHxW46B/n9GOfhyyCA/Bh78GQMh
         vgCIvK7Md9Rf+zRNjrYgTgG1nj5e8bYT5rHvTOfW6eQH1A9WQqSFqwkoQRRlwH68ElWY
         FcNhLxxJtSprsxYt69GCbPElIAHm6bYdFI6py23rpeY9FzCmekB9jYpS8ZNbBLpr5DYE
         /UQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745917735; x=1746522535;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0aok3Qu+pOHjUcAXyJrsWt5iHlE6McYGVKF+Vb+3/xY=;
        b=NQucJtr0+8CNU5d4yYVevM+Yk8l13N+H9ILNrwYAsxFskvDt8xLq8fdAvL1rJ+KaP6
         l8W9D4Ybpban7GJgs8vDNsLnboxpDxDqb1nr9VDnEQlfhDcushHxKTODRYBlxRW001wz
         Rnath4Tlzwo+7+3wKHIHoXqIuR57hZPr8tdBDHqKKqgtdYosQBjhiY4XBZmbTz3jU4dB
         P/REU9gOwVVluRH8Q1KZoZub9CR8XSW31Cnfiq6J4UAqy9v9qEIywYkbaYzGZiqWJWvV
         rEqhq37k8Q8UeHuOER4c+2nwQE29MsBuW+KeXsQJgEsAmbFvW7ciLzwUp8l02Yz5ZQ3n
         W+CA==
X-Forwarded-Encrypted: i=1; AJvYcCVQEvc2BSwcaVJ7MuWnevdxAWTpOey2KjGlHdNR3b92ArJgk7YOWhedW68LkQ55b13o17L405T8vcB67tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZDxFTVaRvgKgdWDxIZSurpVq3VNP+hZC6JeVVv109j4QQ0fWl
	eaqrG1YiWkMZC140UWMtmTcaR5TLCTsJi+TMOL9WDej5v2Sj/AWs3Z8tWqaXmnA=
X-Gm-Gg: ASbGnctAbGxyYnTMCuRYfxE0xImopfOmPfK4BvPGkcFX59tPW80WoTHLnLLlvv86HIY
	Kgz2tYn5MwauISXVj0+8qQ3K7H0bjo7MQCSHjD3KnpI7Bp3uCrGuK7EG62Wb8j+LSXG+Hp4noap
	SAxLdn1BVEqvyGW9CdtR8hlOtij1TPLwj1jlAo63RTxIIknHdRRHxFatylSz9AT5QIuYd+sWGLt
	HFOUqM+RnDy2qXutHwB54LEpjWi5DUkcAFsdq2997AK/GOCzklJpn6O86tbrnb/4wa3+8ZvL/eK
	dQFlXEykScg1QzYHsq5VMIlk4NhiuOjmgG1EDJpHFwimQKKAzKciogNOADgQCU9DihXicw7yVJc
	oYOdf7oybUwzg
X-Google-Smtp-Source: AGHT+IH8oCqqIyKJxT9sjj0Ig3d8sTKUmeM+NsJyG+vKjNZHc9paag4DrkaoJ8WsYaO0tRZqM3Jwhw==
X-Received: by 2002:a05:600c:3b24:b0:43c:fcbc:968c with SMTP id 5b1f17b1804b1-440ab76a956mr107558995e9.7.1745917734315;
        Tue, 29 Apr 2025 02:08:54 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a531dc6csm148355325e9.24.2025.04.29.02.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:08:53 -0700 (PDT)
Message-ID: <ca7708856683596894b5fb9cfd6caa164535a50a.camel@gmail.com>
Subject: Re: [PATCH 2/4] spi: axi-spi-engine: don't repeat mode config for
 offload
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2025 10:08:58 +0100
In-Reply-To: <20250428-adi-main-v1-2-4b8a1b88a212@baylibre.com>
References: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
	 <20250428-adi-main-v1-2-4b8a1b88a212@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi David,

The whole series LGTM but I do have a small concern (maybe an hypothetical =
one)
in this one...


On Mon, 2025-04-28 at 15:58 -0500, David Lechner wrote:
> Add an optimization to avoid repeating the config instruction in each
> SPI message when using SPI offloading. Instead, the instruction is
> run once when the SPI offload trigger is enabled.
>=20
> This is done to allow higher sample rates for ADCs using this SPI
> controller.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0drivers/spi/spi-axi-spi-engine.c | 33 +++++++++++++++++++++++++++++=
+---
> =C2=A01 file changed, 30 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-
> engine.c
> index
> d040deffa9bb9bdcb67bcc8af0a1cfad2e4f6041..05ef2589f8dc0bdaa1b3bb3a459670d=
174f8
> 21a2 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -141,6 +141,7 @@ struct spi_engine_offload {
> =C2=A0	struct spi_engine *spi_engine;
> =C2=A0	unsigned long flags;
> =C2=A0	unsigned int offload_num;
> +	unsigned int spi_mode_config;
> =C2=A0};
> =C2=A0
> =C2=A0struct spi_engine {
> @@ -284,6 +285,7 @@ static void spi_engine_compile_message(struct spi_mes=
sage
> *msg, bool dry,
> =C2=A0{
> =C2=A0	struct spi_device *spi =3D msg->spi;
> =C2=A0	struct spi_controller *host =3D spi->controller;
> +	struct spi_engine_offload *priv;
> =C2=A0	struct spi_transfer *xfer;
> =C2=A0	int clk_div, new_clk_div, inst_ns;
> =C2=A0	bool keep_cs =3D false;
> @@ -297,9 +299,18 @@ static void spi_engine_compile_message(struct spi_me=
ssage
> *msg, bool dry,
> =C2=A0
> =C2=A0	clk_div =3D 1;
> =C2=A0
> -	spi_engine_program_add_cmd(p, dry,
> -		SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
> -			spi_engine_get_config(spi)));
> +	/*
> +	 * As an optimization, SPI offload sets once this when the offload is
> +	 * enabled instead of repeating the instruction in each message.
> +	 */
> +	if (msg->offload) {
> +		priv =3D msg->offload->priv;
> +		priv->spi_mode_config =3D spi_engine_get_config(spi);
> +	} else {
> +		spi_engine_program_add_cmd(p, dry,
> +			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
> +				spi_engine_get_config(spi)));
> +	}
> =C2=A0
> =C2=A0	xfer =3D list_first_entry(&msg->transfers, struct spi_transfer,
> transfer_list);
> =C2=A0	spi_engine_gen_cs(p, dry, spi, !xfer->cs_off);
> @@ -842,6 +853,22 @@ static int spi_engine_trigger_enable(struct spi_offl=
oad
> *offload)
> =C2=A0	struct spi_engine_offload *priv =3D offload->priv;
> =C2=A0	struct spi_engine *spi_engine =3D priv->spi_engine;
> =C2=A0	unsigned int reg;
> +	int ret;
> +
> +	writel_relaxed(SPI_ENGINE_CMD_SYNC(0),
> +		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
> +
> +	writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
> +					=C2=A0=C2=A0=C2=A0 priv->spi_mode_config),
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi_engine->base + SPI_ENGINE_REG=
_CMD_FIFO);
> +
> +	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
> +		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
> +

I would assume that SPI_ENGINE_CMD_SYNC(0) + SPI_ENGINE_CMD_SYNC(1) should =
be
executed in order by the core? I think all this relaxed API's don't give an=
y
guarantee about store completion so, in theory, we could have SYNC(0) after
SYNC(1). Even the full barrier variants don't guarantee this I believe [1].
There's ioremap_np() variant but likely not supported in many platforms. Do=
ing a
read() before SYNC(1) should be all we need to guarantee proper ordering he=
re.

Or maybe this is all theoretical and not an issue on the platforms this dri=
ver
is supported but meh, just raising the possibility.


[1]: https://elixir.bootlin.com/linux/v6.12-rc6/source/Documentation/driver=
-api/device-io.rst#L299

- Nuno S=C3=A1

> +	ret =3D readl_relaxed_poll_timeout(spi_engine->base +
> SPI_ENGINE_REG_SYNC_ID,
> +					 reg, reg =3D=3D 1, 1, 1000);
> +	if (ret)
> +		return ret;
> =C2=A0
> =C2=A0	reg =3D readl_relaxed(spi_engine->base +
> =C2=A0			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num=
));

