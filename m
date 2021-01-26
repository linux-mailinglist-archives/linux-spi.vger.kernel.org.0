Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7917303D77
	for <lists+linux-spi@lfdr.de>; Tue, 26 Jan 2021 13:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbhAZMpR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Jan 2021 07:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391827AbhAZKE0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Jan 2021 05:04:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE76C061573;
        Tue, 26 Jan 2021 02:03:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u14so2163788wmq.4;
        Tue, 26 Jan 2021 02:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p+yTLdMp+wdm8rqW7k9ulXoCG2QOEZDOYmfAPK4UtQA=;
        b=jq8Ipo3tWDxI1kpWxPZhyqC0GKEKkyGTiWH0XOiTfhWqaWQNXb3VdcdBL3GUkmjkXz
         7Wf1zvNPKXMmd/c/LtcSsK1YVx7/+YuhwTLZwNPvSEY1aS21SSUVqD1DNIHtay8N+Prk
         S3LUhN1aFm/7EPbcRao026d8wONA8LiyO0MyCx/bNV/MULJ+n3+TpNKMwghCGdDjrQLA
         A2Cg0m6tpPtwD0/S5Z0iuyrkg2iHrFenhE4UwxjplugzxvzvQxbGf6FwxDDAlRdnoQsT
         aMO1HvIYYMJL6OC6fX4tuVXsh1wWlsIoH4vu6Nwq4U0PSkdqETTTXJNF7sSWssb/mWgP
         1OMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p+yTLdMp+wdm8rqW7k9ulXoCG2QOEZDOYmfAPK4UtQA=;
        b=WOj4MNBXTaHn/1Rf+IW27BAhLeOicd/jESWIeU74JDNOkVG93Ht1UrNPu6yUgCnp6M
         YBe+/UBYdPXbz1u/WBvO02eMlDp+oXRttvBATH/NwoZOiJkwc19DDHnoefiFKs6QsYYL
         KD3BuK9ZfXvpAcR77YllD/8DgXtDcoh7sDucSXhtP7OM0DR3SPyoCEmg04vpaYg+9WF+
         Qh/32pyS/EidGmio7DwN7nQd822jVZ2ftabqOzusSTSatY4A6eyIJYqi0HqEivfI/ftf
         7UNX8XaZegrrF37lEc6iPEe8une+V9fPfa39hBX0vbT1AVEiKB5q2hBzOXLXjF4PnC0Y
         ajIA==
X-Gm-Message-State: AOAM5333LMtfamONGD4xPHQ472lhMZb2EagcjUjYJgh03uT/gDGZw6cm
        /UP1gv4WDMIN3CmIhD2rtkc=
X-Google-Smtp-Source: ABdhPJzh9o0CKfJiCtHBFn9UYUF0IRM/4u5jlJfX3NyVyaSeqr9h3w9B1chYOp59w4Vriij0P3Z+lA==
X-Received: by 2002:a1c:e407:: with SMTP id b7mr3929661wmh.46.1611655425425;
        Tue, 26 Jan 2021 02:03:45 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id r25sm26387449wrr.64.2021.01.26.02.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 02:03:43 -0800 (PST)
Date:   Tue, 26 Jan 2021 11:03:42 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        robh+dt@kernel.org, lukas@wunner.de, bbrezillon@kernel.org,
        p.yadav@ti.com, tudor.ambarus@microchip.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/9] dt-bindings: clock: tegra: Add clock ID
 TEGRA210_CLK_QSPI_PM
Message-ID: <YA/o/stKkt7I0tg1@ulmo>
References: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
 <1608585459-17250-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aGBUejITbxyEzHkq"
Content-Disposition: inline
In-Reply-To: <1608585459-17250-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/2.0.4 (26f41dd1) (2020-12-30)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--aGBUejITbxyEzHkq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 21, 2020 at 01:17:31PM -0800, Sowjanya Komatineni wrote:
> Tegra210 QSPI clock output has divider DIV2_SEL which will be enabled
> when using DDR interface mode.
>=20
> This patch adds clock ID for this to dt-binding.
>=20
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  include/dt-bindings/clock/tegra210-car.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Mark,

It looks like you applied this patch along with the driver patches.
Unfortunately, if I apply the DT updates without this patch, the DT
files will fail to build because this symbol is missing.

Since the TEGRA210_CLK_QSPI_PM symbol isn't used by the driver patches
directly, would you mind dropping this so that I can pick it up into the
Tegra tree along with the DT updates?

I realize this is completely unobvious, so sorry for not noticing and
bringing this up earlier.

Thanks,
Thierry

--aGBUejITbxyEzHkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmAP6PoACgkQ3SOs138+
s6H0bBAAvXB1Ul7lT2k4grn2Sh05TsVP0F8DrIpm5pLc8W4C7i/wLdC2Pcxhg1Jy
UyoR42XPTEBR/8+tMD1mzmnIfW1THuevkRDqQkiScZnxPoCSegI48JNIFpOR3mkz
HxGmgV8NlmzyUi7Tym2X65spLUfTmBxtWG1c13Nh2oWoThNbW90FD5KYfJ+FK0jI
C4/7M7OKLplG+DrnKLL5DkD03q/wL+QGkH1Wx0ELzKhmvxiUv2gBicUualB6OioZ
U5UE51NE6eKDOXNHuW230ODEsVaCgDv2SRjLEjwy5hpzJSXnS83QnpTvdJVU/FzQ
a/YKvLIY8+ztVzb51Ug9BnvuOgqTZrea3jiSODthEDPpRxtZi4ACNIvmcCPwbIPH
clz3Z3Rzow/wooQG/AYd9wvKbLygGw3v7PO0ifh4NmbbTwuRVFVNkluTZZc5DQBt
pAc9LJgpSZhj7AkVwi9ara/E610jnk+wDQztBOSVDxMzSUo0wi7qGVqawLcIBHYq
MOS8Cn1GtKA6ubjGAzsmbAdFtRqKMxN9zgipcDVr5HpqwXbIkBHVAoGeBSHse+Kp
sWb078zKw+RZamdFYifhM0234HtH9MeZuaHseIPXJroOCq62DC1scWdsoBsTX62u
jIZSTBGpdVEVabyifqPxvPHbtCYdF/NpH/CGvh8uq1xFUD6bTZw=
=SxaA
-----END PGP SIGNATURE-----

--aGBUejITbxyEzHkq--
