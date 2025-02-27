Return-Path: <linux-spi+bounces-6961-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B7BA47AC2
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 11:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7B11731FC
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 10:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE9B22A816;
	Thu, 27 Feb 2025 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM6Gkssq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A82288EA;
	Thu, 27 Feb 2025 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653216; cv=none; b=h3jU2aKJnNOiJwmj5ovah1JBZLWsgvJIRqbfIJGpD7nkDsZ05yrnh9RM29TTlA30WX/gtIfXmqXLUgvEe7+MT899cOxPS/HUAul32ZgehCcwXzxuKHlVhFTVR58lG2j9XWttUUVaimkOrIhDDgK0RkcOYNf/TZ0fYwVLIOMNAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653216; c=relaxed/simple;
	bh=fFEnkANQ+TB1DMqxkrT4iVz+aKmjaV4cRTueGWDyFFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tluw3xknYEj05YVIsAys7coYC5WQWG65svvXqntuXoHENbPB4KWm2U0idcyV78W06yFOwWyObe9H/EM+XfdSOh+3ibsX24bw6KF99Pmx7U1F6kTwshoTyFmEJlyAOQQH1jD/vG3khDfANSXO41KHU+xamiaWAzsAvAeUuSeXJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM6Gkssq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390dd35c78dso908217f8f.1;
        Thu, 27 Feb 2025 02:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740653213; x=1741258013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRQH+rhuKQldNnsltSF+H7OhLVbbDlEOTB+LhTVAS8k=;
        b=hM6GkssqGstmLvJEDEQ+OyCPjkhOrzkdQFTD3eJuL5aOY/6iFLPhpVb6mh6DB8NPBK
         0tEQIxuo51HvfBC/Uvd3QqBBLXQ1AxS2AzTbVnkUjkFmGcIa9U0CejiPJMjlYUhTZxJu
         8FGrJwRCk4HiKg4v9PoE6pwLpdeUQssFXK9E5lWA9lrAe0+erhis4i4jcCTbfQOtmBd3
         RHwlbBhI1nO4x0fxLahLDlS2+Q1WQBr174/YS+G3BMYEJpojC0LZbwwS1yf+IhvSahGA
         iSSjCG4WYbAxRuRiSWQmA1UkfUFEn56SD3wVDWlBiur+ayHP46RorAXt8EXCylrYygXx
         dmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740653213; x=1741258013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRQH+rhuKQldNnsltSF+H7OhLVbbDlEOTB+LhTVAS8k=;
        b=SAQmTASxyeNSolxNcZgdCd8oFsJuMfT/NkaHURKQB0XbHP5jbtSUjA1O47O97k8DSd
         j2k9ZxjdwGGeZC5ASpsu4TcTt1FIySWMFk6XHTlkZ/Bc0DlVC9xH5P3XTJx4qk7Eaeyo
         xozOpjLQbldjbdZyvs/IbjWVmNUBQy7gcaNMgh5UuDNhvCjwMhvcB4TxOJ8l7i4KoEEq
         VuO+VsrFSAlBnYpW/slI9JoNlpE42znrZX2kW/vqUvPXSzEyx+Nq8Ne/dNIyPByd3A0v
         ChdoObGfYo0A4w/UVPgy/OL5c5liuhMD6oKfhxUO+75bNmzK13Xq2A+N4qgCYaKBO+Zm
         2psw==
X-Forwarded-Encrypted: i=1; AJvYcCUU31pKA9Ldm/J4M9X7qs91GIGf9yNxwh9YNXFeTzS7d2LIdludh9VzaL+cBltcYw2Y3XP4vYCbfnvxqEU=@vger.kernel.org, AJvYcCUcQMr/JDAcehKesmCjjpc+kwyGA51zZzJONu+XXTgo90DvNLDrM3SQ3xObzGgD8nLD6FuwoMS5yX6VJIc=@vger.kernel.org, AJvYcCWfveB5nEr2+tkPyLQd+/pzT1VeclThh1QkbsD0A4deAIMewAHtUSl/JaqshYkds28tsyapyhJDb/FD@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKTj2cjJ6Rfl6spcMjIxMWtlK8xKdPTzpMtsdWT3Fm+JOSjsA
	mKma1vdMimuFzbH+fyoiY3EMfDlPhuXexAH8k7ZKO2FI4LWxbeNqCSRoiw==
X-Gm-Gg: ASbGncvkBhRoAkX4OHcvMgYlGN1FVlSujDAF1ycCboXy/jfHySOP2dIqAGx0B8hox0Z
	tLxSCuXiSyoautuaKeSfB0V35W1IsPvF/Bt+We6uVjhTEWN45Ic1CQlFJE2kWL6LD20DBdODmd4
	o4ZhvJrLnJia3kXnZuo2CLvfjV0xrlHkiFQnQIiFfFe7q++jjKKaDMsx9uf9yjWZIwf6XSY7e3R
	VkOPPZaww3WdxSxeCRhhKlD4bAjdUIotwkxHuQesxzLUWB2XKW4wWMlwU0I5YFEuFtSf/GG/kmA
	AKsmadxKrEYTCc8/esatVXv9fpB8bfb8Zhw8dvB1FOLBuSCe5DjvWZlXYgMbCWYpSSLzd7y7nvz
	I4c14MWQcS+Zu
X-Google-Smtp-Source: AGHT+IFozguorFHo7fZZe5EaA6PBwZ6mncviZRLUXZtN6kT3BIH9c8VDVf6DFEtDUuzJVzJdjrOGOQ==
X-Received: by 2002:a5d:59a7:0:b0:38d:d222:ee70 with SMTP id ffacd0b85a97d-390e1699a32mr2404891f8f.20.1740653212699;
        Thu, 27 Feb 2025 02:46:52 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d8e4sm1574882f8f.85.2025.02.27.02.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:46:51 -0800 (PST)
Date: Thu, 27 Feb 2025 11:46:49 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com, 
	broonie@kernel.org, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com, smangipudi@nvidia.com
Subject: Re: [PATCH v2 5/6] spi: tegra210-quad: modify chip select (CS)
 deactivation
Message-ID: <msvqwjnj6gb3gpnqtev5ebc7fpriprc3blrsg4yhjrwul63dza@dd5pmpjr2gd3>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
 <20250212144651.2433086-6-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qlfxoqvmbcrcawlt"
Content-Disposition: inline
In-Reply-To: <20250212144651.2433086-6-va@nvidia.com>


--qlfxoqvmbcrcawlt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/6] spi: tegra210-quad: modify chip select (CS)
 deactivation
MIME-Version: 1.0

On Wed, Feb 12, 2025 at 02:46:50PM +0000, Vishwaroop A wrote:
> Modify the chip select (CS) deactivation and inter-transfer delay
> execution to be performed only during the DATA_TRANSFER phase when
> the cs_change flag is not set. This ensures proper CS handling and
> timing between transfers while eliminating redundant operations.
>=20
> Fixes: 1b8342cc4a38 ("spi: tegra210-quad: combined sequence mode")
>=20
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-q=
uad.c
> index 2d7a2e3da337..04f41e92c1e2 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -1171,16 +1171,16 @@ static int tegra_qspi_combined_seq_xfer(struct te=
gra_qspi *tqspi,
>  				ret =3D -EIO;
>  				goto exit;
>  			}
> -			if (!xfer->cs_change) {
> -				tegra_qspi_transfer_end(spi);
> -				spi_transfer_delay_exec(xfer);
> -			}
>  			break;
>  		default:
>  			ret =3D -EINVAL;
>  			goto exit;
>  		}
>  		msg->actual_length +=3D xfer->len;
> +		if (!xfer->cs_change && transfer_phase =3D=3D DATA_TRANSFER) {
> +			tegra_qspi_transfer_end(spi);
> +			spi_transfer_delay_exec(xfer);
> +		}
>  		transfer_phase++;

I'd prefer blank lines around the "if" block to make this less
cluttered, but since this was always like this, either way:

Acked-by: Thierry Reding <treding@nvidia.com>

--qlfxoqvmbcrcawlt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfAQpkACgkQ3SOs138+
s6EEpg//dVDXWz/PSPQmWy9On92DUNZ9uyazh6XBdJcDsrl/ntAOUD7+FzjnGJrO
Ij8Dfgn8hDOHhgzQ9nhYhIY9QlK7L2wQOM6BbVZk674bQqXoi4XEjOBbM7Tj01uT
7fQuefkQLaF7O3Ou8TuaEZ/SCWkN+iOciCVGOMMEjUI5uf+kShZFjw8y4WLkI7Pf
lOjBN+PuzEZdatZBSkIv0NlvTjF2ZZ1pCPNLKLp4+NZgtunSaHvsYXtK+69k0X20
OB9ObwG03SywlRsonmH3lotESMSS4/vdahlZqNArs3erPW/ZhrENVWAumy2hDq2w
AblJayS7q0k+F3aP0RsrwQvDENOCe01c0M/2ZuSCxHFFqxa5lerTo3ejH06bIedG
4zE+kPtgSK2VHtlBj670qNpkU3QV1cfWxGuJEctIvVgQvKmwv4mGB4paWXJLboaM
gak+CtMT2BSqtUPoZkeuYIpQg40UYZ9eP3B4rRUHb+N9l7kO/8IbwJaBKMqj+irj
970QGELVQjztHCj+xFeIR0ZhamtBtc0W+3T5s+E0tpdyzpsBHrvlGfiq3GoXLSva
xJPicvJUA798YFjkfwpT5RJ3xnVZxxCDCG0sdILzmT7udNEhm+vkEhxXYHw8eh6O
42pKQpmVvkI8DDieZg5xjZFQnyjE9e/8NCFz9WmFW2kANNt03CA=
=0DfQ
-----END PGP SIGNATURE-----

--qlfxoqvmbcrcawlt--

