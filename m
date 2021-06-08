Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E167E39F76B
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 15:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhFHNRT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 09:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhFHNRT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Jun 2021 09:17:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E349C061574;
        Tue,  8 Jun 2021 06:15:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso1920462wmi.3;
        Tue, 08 Jun 2021 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2TMyvIIwPE4R5XgejAWyA0oeljBF/9z9zhztcNvECHk=;
        b=opfaw7SUZcSViBtChgQEFamiyrAiU3sY4Cn/bZj6n4q/5DTGfKSkzuIDLFi7VJF9/6
         os4hCd+PJT5T5iEAF7yAx2CeE1BllwUiX4u/dz8kMY1cf2O7ly9lLwL8ylv4Ow43/cRB
         i32B+1QiTUWgoqzqhe7ubh2HvKJfq9gxONxAHkQkrEhSngEdk0mlt3Ha+Fg2degU/aeO
         tabslpUrb/DqeM4UX0wdPtGRp+xA6B6p3JDsS0cN0G5jIz/8ONM5XLcUZB6zo/Tu1+pe
         zu/1t0tpbCD6I1D6cWbyphMOIyR9Bj3+dRH1gaeLD+55g1YXQBFmC+bKgtA58dMrQfZE
         B3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2TMyvIIwPE4R5XgejAWyA0oeljBF/9z9zhztcNvECHk=;
        b=uaFnQZccZVy9y+g7n2al11aabeiTJAJ/mkDulE9hePTGTzpmERZShGnPig7jtKzEPV
         aB+H5gl5wyfj4xZvBZI4opPDhwQZTA0LSoOQtxL5QCzk2R3D1ajPnUj7ruEXNrgj6wNO
         z/I8JQ+7/PpDR20N2E8IQ4YQO6rCvT6u4l28HtmOiY9tIFzjSPJyoWnr07HTkj580/SM
         6ue+6sfqeSmuFnCTNuYBw6Q1kOBFmQLsfpKKngPZQM4zORqYF0KVNDEuNcbpMbp1WjoO
         uXDOprak5y+6GjTixDaGq678faJCLCkTkbRn83rgfco1zmAEfJl1fN9OxTuAVNaSFByq
         nOhg==
X-Gm-Message-State: AOAM533esDFbpbL4lsdiliJc+bjwZHSoHVHJsnY1UtQhEdsUUt0MfJPX
        0N2/QmnkOELuc0o/4eKzlTk=
X-Google-Smtp-Source: ABdhPJwC2Jemo5JztYm1DpKSV/7b7urgftIvfL7gCBhwMegTNwCrVvkPnBZzrRk2sbJkJkRdvYp2/w==
X-Received: by 2002:a1c:4c07:: with SMTP id z7mr4138038wmf.90.1623158115986;
        Tue, 08 Jun 2021 06:15:15 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c12sm22969557wrr.90.2021.06.08.06.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 06:15:13 -0700 (PDT)
Date:   Tue, 8 Jun 2021 15:16:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20-slink: Ensure SPI controller reset is
 deasserted
Message-ID: <YL9tx7gMCccFBWob@orome.fritz.box>
References: <20210608071518.93037-1-jonathanh@nvidia.com>
 <YL9eI8L32Tc8G7uF@orome.fritz.box>
 <7b4707f7-b895-9e98-c92e-d1e10b11c3f7@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sRptcuciJez17IB4"
Content-Disposition: inline
In-Reply-To: <7b4707f7-b895-9e98-c92e-d1e10b11c3f7@nvidia.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sRptcuciJez17IB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 2021 at 01:35:11PM +0100, Jon Hunter wrote:
>=20
> On 08/06/2021 13:10, Thierry Reding wrote:
> > On Tue, Jun 08, 2021 at 08:15:18AM +0100, Jon Hunter wrote:
> >> Commit 4782c0a5dd88 ("clk: tegra: Don't deassert reset on enabling
> >> clocks") removed some legacy code for handling resets on Tegra from
> >> within the Tegra clock code. This exposed an issue in the Tegra20 slink
> >> driver where the SPI controller reset was not being deasserted as need=
ed
> >> during probe. This is causing the Tegra30 Cardhu platform to hang on
> >> boot. Fix this by ensuring the SPI controller reset is deasserted duri=
ng
> >> probe.
> >>
> >> Fixes: 4782c0a5dd88 ("clk: tegra: Don't deassert reset on enabling clo=
cks")
> >=20
> > While it technically fixes an issue uncovered by that patch, I would
> > argue that the underlying issue has been present forever. So I think
> > this should be applied regardless of the above patch.
>=20
> Yes that is true and there is no dependency per-se but wanted to
> highlight that up until that patch there were no issues.
>=20
> > It also makes me wonder if we shouldn't drop the clock patch for now to
> > unbreak things and avoid having to model complicated dependencies to
> > make sure everything continues to work in v5.14-rc1.
>=20
> Yes but I guess we will need to revert that one now as it is part of the
> pull request you sent. However, that is fine with me.
>=20
> > Unless perhaps if Mark applies this for v5.13, then we can merge the
> > clock patch for v5.14-rc1 since SPI is the only IP that seems to be
> > broken by that change.
>=20
> Yes that works too.
>=20
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >> ---
> >>  drivers/spi/spi-tegra20-slink.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20=
-slink.c
> >> index f7c832fd4003..6a726c95ac7a 100644
> >> --- a/drivers/spi/spi-tegra20-slink.c
> >> +++ b/drivers/spi/spi-tegra20-slink.c
> >> @@ -1118,6 +1118,11 @@ static int tegra_slink_probe(struct platform_de=
vice *pdev)
> >>  		pm_runtime_put_noidle(&pdev->dev);
> >>  		goto exit_pm_disable;
> >>  	}
> >> +
> >> +	reset_control_assert(tspi->rst);
> >> +	udelay(2);
> >> +	reset_control_deassert(tspi->rst);
> >> +
> >=20
> > I wonder if this doesn't break now again on suspend/resume. Should we
> > perhaps move this into tegra_slink_runtime_resume()? Or better yet, move
> > the reset_control_assert() into tegra_slink_runtime_suspend() and the
> > reset_control_deassert() into tegra_slink_runtime_resume(). That should
> > ensure the device's reset is always deasserted when runtime resumed.
>=20
> So we do test suspend/resume on Cardhu and I have seen no issues with
> this applied. At first I did put this in the runtime_suspend/resume
> handlers, but then looking at what is done in spi-tegra114.c it appears
> we just do this on probe. See ...
>=20
> commit 019194933339b3e9b486639c8cb3692020844d65
> Author: Sowjanya Komatineni <skomatineni@nvidia.com>
> Date:   Tue Mar 26 22:56:32 2019 -0700
>=20
>     spi: tegra114: reset controller on probe
>=20
> I guess moving it to the runtime_suspend/resume handlers would be more
> consistent with the previous code. What do you think?

Do we test that SPI is still functional after suspend/resume? If it is,
I have no objection to this patch. I think making this part of runtime
suspend/resume would be a bit more correct or robust, but it's also a
bit more complicated and might introduce other problems. For example,
I suspect that if we reset on runtime suspend/resume, we would likely
need to reprogram the SLINK_COMMAND* registers as well.

Thierry

--sRptcuciJez17IB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC/bcQACgkQ3SOs138+
s6FoHg/+OmNeuJcktzioe/qhtgVut8QJ0qbYv7SIwuARDX3e+5auzr7Fa0UuKERU
r6bIhJnHTMxeWpMl0zZoMmf2yfFXghx3ql1h66AgE8XXQj8mboG88FMIb5mmWSPZ
8pvbjMue3rf5Crx2lXz3T1OqrqliNpHlo9kBp5iVFVqtvMKZ8F3DC8rcIG9UPr93
AfUl2jojwutvheAB3/tlPAHdKAr86p23OdDG5ez8khMKOqZuSaiq8Rl2Irc7ahHR
WoSaEeg3Ribv5sKBG6BI1tTanaJJA6/mp+dz3Y2s4vnRO43AwFisl59fn+0QMvMZ
VgGQmQxJRpFAZMD9gw2uS53/V8qLk2cqn2H5nQU38KWOKMWmU1ey1AxD+/1QVNj0
AthaHCxEFme5E1FzGGLfUG05hJUWepPuAl64DZZCvwOzMc/GqRq/xgNdQLh5zMn9
bFDoUH9mtuk0ioJI+nbyDfUjaLFAkxsmAtlMudVDVmOV5afXjEBm2ZC8GTmvKnkl
X+Hm7cuEdw1Ql3HEO5tAycrzGFHyeyZnQLDQVnek4Dn8Am+d7fD9gmz9vX3jjw7i
MEp1dPM0UeF/c9QJg5qyXdLnjQyIWrKvZxYZ95qd9UNbEtMJ4FZlStiE8vQN+6a+
L963aL74b75WSF9Id2wRTx9DYQzUbqs5szu93/KzmkJ8rFuzyXQ=
=HdBw
-----END PGP SIGNATURE-----

--sRptcuciJez17IB4--
