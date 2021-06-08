Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755C739F60D
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 14:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhFHMK1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 08:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhFHMK1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Jun 2021 08:10:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078E5C061574;
        Tue,  8 Jun 2021 05:08:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so1820650wms.0;
        Tue, 08 Jun 2021 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ybQU5ze1ZeeSCrW8t3qld65ejH8jmVbB1srbBPHb3Y4=;
        b=fdWUzI8Wd1EgeQS7Idqhm2BAzzwGFCFBarj1vPAmcJKv02LxGHOJO84OCsr42IVP/u
         iOzcDWSQPgXr6qiy7QMlCE8nV4ErT6jyW72J0c1paVFpd1xtaWKLpY19j9eQdltz2yaU
         GqjIpwF4xCzz0oQryfejM3m576t2XyApsyGW4cde/psOBN8OGMkDGCd5HFI/dBSQyo5/
         8le0jOOS+6Vwf+qo7TsWLheoOe6id/3gLJu/1hdV0nRk2MxwmG/7uwPFGN9C2bgck3bD
         +YscvnW0go+t/KZa0QI0ZIddOspS3UQYc7TYAxlS0qRcD4fmagNEDrD/PPHsdnZrja8V
         KxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ybQU5ze1ZeeSCrW8t3qld65ejH8jmVbB1srbBPHb3Y4=;
        b=qF5vykGk1HMV1QwGdJ2U+CtobGz8Z/u50uchvwyExzsVa82jjykTmUAK0p3xspy5oa
         K9kIuax/E5vguAh6MAlCy/gXGBRBXOn9Ehd67J2L7WrAF8USMS79NCgrtzrqoEfye2Ud
         2z4W3oXzYoOwFXgzXCiPEI6nbvUu+wEevloCB+ZhKJgHEOl3tLww5Ctux7iqZUAfOo1V
         imzg2IxiWIXsekrp4rZOp0JxI1hT23UgrlUZ5PpPG7QRcwLvaQ86U7LS+WppYHj1QI8u
         0g6RkYt0ddJZraRZ2WsfuOHEGFfu2n0GogOiLtUfUOghuUp66D9/3pFuRhKn2t9XSsQ0
         gONQ==
X-Gm-Message-State: AOAM532qX1fLWqrgb29e1l37tmjMFxduv5NTkddMIxsnoFmkPSZRiK80
        23xVEX+9APEdGO1sQesoJcg=
X-Google-Smtp-Source: ABdhPJyZW1L2YLbqbYz3fFtf2QotCaGTVBitgSQaVnr5/fSGzyV9XoabZ6h6y/v+b8TAGfriRI4XsQ==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr3869611wms.175.1623154110942;
        Tue, 08 Jun 2021 05:08:30 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o3sm13272567wrc.0.2021.06.08.05.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 05:08:29 -0700 (PDT)
Date:   Tue, 8 Jun 2021 14:10:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20-slink: Ensure SPI controller reset is
 deasserted
Message-ID: <YL9eI8L32Tc8G7uF@orome.fritz.box>
References: <20210608071518.93037-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QFm6nwGJ+i46x73f"
Content-Disposition: inline
In-Reply-To: <20210608071518.93037-1-jonathanh@nvidia.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--QFm6nwGJ+i46x73f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 2021 at 08:15:18AM +0100, Jon Hunter wrote:
> Commit 4782c0a5dd88 ("clk: tegra: Don't deassert reset on enabling
> clocks") removed some legacy code for handling resets on Tegra from
> within the Tegra clock code. This exposed an issue in the Tegra20 slink
> driver where the SPI controller reset was not being deasserted as needed
> during probe. This is causing the Tegra30 Cardhu platform to hang on
> boot. Fix this by ensuring the SPI controller reset is deasserted during
> probe.
>=20
> Fixes: 4782c0a5dd88 ("clk: tegra: Don't deassert reset on enabling clocks=
")

While it technically fixes an issue uncovered by that patch, I would
argue that the underlying issue has been present forever. So I think
this should be applied regardless of the above patch.

It also makes me wonder if we shouldn't drop the clock patch for now to
unbreak things and avoid having to model complicated dependencies to
make sure everything continues to work in v5.14-rc1.

Unless perhaps if Mark applies this for v5.13, then we can merge the
clock patch for v5.14-rc1 since SPI is the only IP that seems to be
broken by that change.

> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/spi/spi-tegra20-slink.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-sl=
ink.c
> index f7c832fd4003..6a726c95ac7a 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -1118,6 +1118,11 @@ static int tegra_slink_probe(struct platform_devic=
e *pdev)
>  		pm_runtime_put_noidle(&pdev->dev);
>  		goto exit_pm_disable;
>  	}
> +
> +	reset_control_assert(tspi->rst);
> +	udelay(2);
> +	reset_control_deassert(tspi->rst);
> +

I wonder if this doesn't break now again on suspend/resume. Should we
perhaps move this into tegra_slink_runtime_resume()? Or better yet, move
the reset_control_assert() into tegra_slink_runtime_suspend() and the
reset_control_deassert() into tegra_slink_runtime_resume(). That should
ensure the device's reset is always deasserted when runtime resumed.

Thierry

--QFm6nwGJ+i46x73f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC/XiEACgkQ3SOs138+
s6FhpxAAhOhlZVTPNJkcOQXn6d3SBj/J9iL9BSYS4IrB9FqSggTq8em1d5ePecfA
PhUMs3sEzMgThPeaS3tjrzY9sGC1kar8HmQyt5b8QFqcj/mLJT9N+uwRfxv7Uqh9
F4bU9quEZ6mNWSiMkh/YasmiubuCeXEUWrMAAQL5Hd06SF2pycJCPWM2xR3qYjk8
tLrHGGtBG+BgfabjQT73quN9V7BqqNm0jlb7Tt0fFYOYzNBVQnfapvwnmbm92vMA
yYt+aYytAN/xmAXYC0tVhE2Cj4OzBy1SI+ji/RHKG4qq9oMtU0okGZDilqV5mOnN
6LZtEFujyOW3qm8fEpyE35+Xp1Wh6Z3JbVFplAsglUtp3Wf7DL+3LLmHCJbCxSsI
0G9Libr68XNV9NmL0f9cEydc6JnDrJZ4BKk1GnXx/cMA7IONMQ3+IPwzeduZztXm
pUpwsd1Bv9N9Ia2fMJePZdgfHYeOqQ1mJ+O4EtClXzvi5E0LiOsbCMxuHf4hEVz1
zlFHm023NP+URoQCc6CUwnJJ6O+bO9HxEp2cfPj2iZrSA+COpvWO3n+nWUB+FVlJ
O1tRUBpDaMsxpxYSZvQB8Obzq5ddtqC/ztgA9PGvAqO+CnvVSGFoRYhMi6rUH6Fq
agZgc9taWa1bPioKEJiGxVO1xkYz1rqjhPyqETlnLnBS65Y1XbA=
=T+aE
-----END PGP SIGNATURE-----

--QFm6nwGJ+i46x73f--
