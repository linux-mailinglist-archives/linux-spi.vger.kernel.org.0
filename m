Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFF412626
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386206AbhITSxy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 14:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353920AbhITSww (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01D1E61183;
        Mon, 20 Sep 2021 18:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632162851;
        bh=BXNQK6bkJOK5antDAwpDv51Zva0iK4JfI1QofmdAr2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1r3u49tLC0B6CPNGwkeQFGhEpVjRZ5s3c7dVcj0fIdyxYVIda32+nZbeRJ6Iw0tW
         P1vZHaSsT2k9Zoo+vJbolrVRjr+4PH1kXc/oRgUuAUf/rcHyrm4QbQ6rkWwMGZWDac
         6LWJSP6aU96o7AVm6u32bEzNOwA9EXuaE9xTlyqiz+V3ApwkuPk3eA+TttHdCIp9j5
         NOxX4MEgJcAeDr8KWIde+fMkIwoxRA/h7KVdPQSGQkuyPvdd59SAnzjO6fsPaFAx5g
         tTd4LY8EFLyVdsO62O7muNlpfswlw6868CpuAEpDJZlIdR2K3dI0GUovMQCvwNRjOw
         Ljx9n+djqc/0Q==
Date:   Mon, 20 Sep 2021 19:33:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Andreas Schwab <schwab@suse.de>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, robh@kernel.org
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
Message-ID: <20210920183327.GO4192@sirena.org.uk>
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N/GrjenRD+RJfyz+"
Content-Disposition: inline
In-Reply-To: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
X-Cookie: diplomacy, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--N/GrjenRD+RJfyz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 20, 2021 at 11:20:29AM +0100, Russell King (Oracle) wrote:

> spi-flash@0 {
>         compatible =3D "st,w25q32";

> which is entirely legal according to the binding documentation in
> Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml.

Are you sure?  Looking at the binding document it appears that the
fallback to jedec,spi-nor is mandatory in all cases - it's either one of
the two items: cases both of which are lists with jedec,spi-nor in them
or just the plain jedec,spi-nor fallback.  It kind of doesn't matter
given that we weren't enforcing it in the past but still.

> MODALIAS=3Dof:Nspi-flashT(null)Cst,w25q32

> However, the spi-nor module only supports these "of" modaliases:

> alias:          of:N*T*Cjedec,spi-norC*
> alias:          of:N*T*Cjedec,spi-nor

> but supports _way_ more "spi" modaliases, including "spi:w25q32".

> Therefore, this change breaks module autoloading.

Ugh, right.  This sort of stuff is why I really dislike not listing all
the compatibles in driver like some of the SoC vendors seem allergic to,
I keep having to fight for that. =20

> Hence there are two commits that may need to be reverted:

> e09f2ab8eecc ("spi: update modalias_show after of_device_uevent_modalias =
support")
> 3ce6c9e2617e ("spi: add of_device_uevent_modalias support")

This then causes issues for anything trying to bind based with DT
aliases AIUI so it's just pushing the problems around to different
devices.  I think ideally we should be including the fallback compat IDs
that could also be matched along with the OF aliases.

> Alternatively, we need to add _all_ the flash types that the spi-nor
> driver supports to the DT table, which sounds like a recipe for
> disaster waiting to happen as it means maintaining two large tables of
> flash devices, one for the SPI aliases with the flash information and
> one for the DT aliases.

That doesn't seem particularly hard TBH, and if we're going to be
listing any compatibles we really ought to be including them all rather
than just a random one.

--N/GrjenRD+RJfyz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFI0/YACgkQJNaLcl1U
h9A4Fwf/etq/BvG54Bi0v0k23sKr+zw/xOQmHN319utA52PCzKbSsTjjiLZa9/qt
7VqwmDmtSF52u06Ktn6BWzJvs3K2r1FiDEveTrjZZU+XLfGcAPPe0iFjBcaU+Eyd
p1ZK3UM8o5ZAeBsQ1UjQKgYOkM1rl9YmrFlNLNONqrbXr3yHmUK10012Zte3s8bp
De5N7F4e4+P7QAkRXDADQgC0sZ6a2UCVfSt02q4F32w+GkMttZ8UEd08u6HCW3rQ
sd/L8V3fUM/tiCc8UmVIhIjxxPydgmbCwB9C+hbXvvTdkKUea2JgjbrVnBRL1oRh
SFQuJO+CMSMnOI+N04gfb1ysIfUwHg==
=O3x6
-----END PGP SIGNATURE-----

--N/GrjenRD+RJfyz+--
