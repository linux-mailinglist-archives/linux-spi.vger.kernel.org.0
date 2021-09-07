Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C9402D4F
	for <lists+linux-spi@lfdr.de>; Tue,  7 Sep 2021 18:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345505AbhIGQ7t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Sep 2021 12:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345314AbhIGQ7t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Sep 2021 12:59:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F21DC061575;
        Tue,  7 Sep 2021 09:58:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q11so15474686wrr.9;
        Tue, 07 Sep 2021 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QOvPnmUsLHR2ePcx/VDpvZbJYRDmRyZEnoWkG5O40CA=;
        b=JQd9jMgMO73LlAPc/I61qpuzM7alrLRWzAGsCnuzjJPHGcshaPZKq5BUYFgsDAqocf
         Xos6T4xCNhOsThojP4G/SeWPAzwggsvpmHLWhmKJJJp/t7Z5/zbj2VCLt/UPULBca1j7
         KEGt3bTJEwSbxeXwVYDWU7CNgUSvGhFh6LCePtzSKduNQOxddBYfH66DICH0NfJY/XLX
         yltKL9T14ePvyX1rqsNb1RZIwfIwk70HMkzoIkkSxHuiZPNPhID7TEEr9Jh2+mYc4CuG
         K/mUGACppGhBuG+ZIqr5J4oGaHH+skY1zc+6tyycg3q1dJY+JzIy+F9L/mkGhLXo7k0V
         /jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QOvPnmUsLHR2ePcx/VDpvZbJYRDmRyZEnoWkG5O40CA=;
        b=kO+lMXSrCJ4vVSnwlBCwsk5LfFTUUpBQHAnJG/Tk+mgpCVxPbDLJ/SbcFF1SNfZqP9
         DaVodAEzZAue/vw1Cm5HRDEZHtITkhchv34VYPFvB27yXztNTAXEIfIDnDR0KQjFt7Jj
         3CvO1JYqqNAmbcAHnrPmpNIHB/xex/LW0MtuipVeY6oS1X0uLSh4MawN5v5Nv1JEuuQo
         IfEOr2cPHkvYyhzpZxlMN1pZxigaxRhj271ER2ZL4mojWLmEyQlzQuRQWTh+3b8KWGkb
         0dAQxVnYwy6eYZcBlxz845oddNxNmqcgd48cbPOqGzwq/43KbdiF+PFT05A3g0U/h+zT
         zNvA==
X-Gm-Message-State: AOAM531Uda5WmLF1IKOx8mA529GDFllGSiWjuugbBWaKrJ4YFx0IJYzT
        XSzuZOwlMvLtQG0101uTXFo=
X-Google-Smtp-Source: ABdhPJxUpZEg5VjevA3LTacU1KoAqbnsaJciaWYIIQzfgbuVKLvgKanSXJWznVLvvxVSeZDHIji3rA==
X-Received: by 2002:adf:f552:: with SMTP id j18mr18845200wrp.273.1631033920629;
        Tue, 07 Sep 2021 09:58:40 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id r27sm2216242wrr.70.2021.09.07.09.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 09:58:39 -0700 (PDT)
Date:   Tue, 7 Sep 2021 18:58:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20-slink: Declare runtime suspend and resume
 functions conditionally
Message-ID: <YTeaPnxDhmia4/OB@orome.fritz.box>
References: <20210907045358.2138282-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L1EJoNpK+VemqDAB"
Content-Disposition: inline
In-Reply-To: <20210907045358.2138282-1-linux@roeck-us.net>
User-Agent: Mutt/2.1.2 (9a92dba0) (2021-08-24)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--L1EJoNpK+VemqDAB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 06, 2021 at 09:53:58PM -0700, Guenter Roeck wrote:
> The following build error is seen with CONFIG_PM=3Dn.
>=20
> drivers/spi/spi-tegra20-slink.c:1188:12: error:
> 	'tegra_slink_runtime_suspend' defined but not used
> drivers/spi/spi-tegra20-slink.c:1200:12: error:
> 	'tegra_slink_runtime_resume' defined but not used
>=20
> Declare the functions only if PM is enabled. While at it, remove the
> unnecessary forward declarations.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/spi/spi-tegra20-slink.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-sl=
ink.c
> index ebd27f883033..8ce840c7ecc8 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -204,9 +204,6 @@ struct tegra_slink_data {
>  	struct dma_async_tx_descriptor		*tx_dma_desc;
>  };
> =20
> -static int tegra_slink_runtime_suspend(struct device *dev);
> -static int tegra_slink_runtime_resume(struct device *dev);
> -
>  static inline u32 tegra_slink_readl(struct tegra_slink_data *tspi,
>  		unsigned long reg)
>  {
> @@ -1185,6 +1182,7 @@ static int tegra_slink_resume(struct device *dev)
>  }
>  #endif
> =20
> +#ifdef CONFIG_PM
>  static int tegra_slink_runtime_suspend(struct device *dev)
>  {
>  	struct spi_master *master =3D dev_get_drvdata(dev);
> @@ -1210,6 +1208,7 @@ static int tegra_slink_runtime_resume(struct device=
 *dev)
>  	}
>  	return 0;
>  }
> +#endif /* CONFIG_PM */
> =20
>  static const struct dev_pm_ops slink_pm_ops =3D {
>  	SET_RUNTIME_PM_OPS(tegra_slink_runtime_suspend,

Looks like this is mostly leftover from commit e4bb903fda0e ("spi:
tegra20-slink: Improve runtime PM usage"). That's likely going to go
into v5.15 since it's been in linux-next for a couple of weeks, so this
one should go there as well.

But yeah, looks correct. On a side-note: ARCH_TEGRA always selects PM,
so we typically assume that these guards are not needed. However, since
SPI's Kconfig has these two symbols || COMPILE_TEST, that assumption is
obviously no longer true.

Anyway, this looks correct, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--L1EJoNpK+VemqDAB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmE3mjwACgkQ3SOs138+
s6F12w/+NoQME2r+r4vwCE2N55IVSsRTdKiTGpqM+Efen8JBWkcq66FZMbZIUZkB
E/+IVm0NcPAxziikeDJ6PrAN+95QHpqMKHb4X7AKTzXKO3LikLhgq7Sdk9TJLKdl
MA+s6UUX7N/+k2/ittrgoolI+l44+i0UXjRiRCiiquLui9p7p3hrLMWx8ZXNoOdy
3NaY9jk8AnVAvHLSAsd8TbexCiQ4HRDPiH2LpLxDsRXwr2gyPtkFwFYnR/ZZdDnw
NEijSyLhG71ixlY5Mn39MaeDrX0w08y2SoVvHLjGLODL1byvTqXHI4JI8gl1RfcR
6Dycj7X7XZP6WcSUrzgm/lslcm9xDESLcmxGxf6cExiN38KhdJBORfhTB8htn8Xm
Q/QIR+TZvAItTVOjeEo8gFjVIjrwEKR9oPHVSp43MUslLW8G3kMOoloIlnfaswPX
9O8Ako6NUK7/m45NKNYpSJtLZDNBgSHPTKJLViSfpd+44k+90BKVNbMNFG/hG6Mx
LOV0FqA2bZ4TmwHWdEshA94Mdnn1h3Eo+l5gigRGESlbGoZUf0pdwYqh4yxaSGEp
EgbynKLiEluOXhy4KEmSADZ1aZsIsaWeOH15m86GZnJ3MgPcmB7UmzEcbtyIH0qW
nO52jLL6SUlkHIYjy0Sb94qzTMcLA3qjFi1pArvBHPFKSxNVXrU=
=fjmd
-----END PGP SIGNATURE-----

--L1EJoNpK+VemqDAB--
