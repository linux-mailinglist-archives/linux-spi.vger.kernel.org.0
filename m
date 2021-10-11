Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA21428CD9
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 14:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhJKMRi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 08:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235092AbhJKMRh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Oct 2021 08:17:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99E2A60EBB;
        Mon, 11 Oct 2021 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633954537;
        bh=GIyRuvfib8GRNJz7ecQG89JjO013H49WTTUqm4s95lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9lQ3EUOdqaP704DLMq5cH1RZLeT15um3TdK0/HL96AWF7HZmLHJSiKJbHQM7wjRW
         0NuTbLzdE9pSM8dlEO78qxrluR1D1j8jNibWcf9GHjWGmPUuUPHeIH/rZP+BbcIySe
         f6to+Cj8eeL4L+o9i5fuf2nS4UA4Okju5xFrr//kUbgmcLxDTf4T7xsmxW0GtoVsIF
         RFvPiOd3VtpMUNg04qt6c0Gz97sGnxSe6Ak5Su3XtZ4plBgs9omxl3mbnRt1F4Q2DD
         9oCdR7PcGGLZa9GnC9wuculRyruZGj1DFWETzwjeatO9n29trO5Nj4JFk2NVygk9YD
         PJjC1K+mYymrA==
Date:   Mon, 11 Oct 2021 13:15:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        yendapally.reddy@broadcom.com, Kamal Dasu <kdasu@broadcom.com>
Subject: Re: [PATCH 2/3] spi: bcm-qspi: clear MSPI spifie interrupt during
 probe
Message-ID: <YWQq5cOvDTgf5rql@sirena.org.uk>
References: <20211008203603.40915-1-kdasu.kdev@gmail.com>
 <20211008203603.40915-3-kdasu.kdev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xOqAsnaWS/lHizBU"
Content-Disposition: inline
In-Reply-To: <20211008203603.40915-3-kdasu.kdev@gmail.com>
X-Cookie: Your ignorance cramps my conversation.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--xOqAsnaWS/lHizBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 08, 2021 at 04:36:02PM -0400, Kamal Dasu wrote:
> From: Kamal Dasu <kdasu@broadcom.com>
>=20
> Intermittent Kernel crash has been observed on probe in
> bcm_qspi_mspi_l2_isr() handler when the MSPI spifie interrupt bit
> has not been cleared before registering for interrupts.
> Fix the driver to move SoC specific custom interrupt handling code
> before we register IRQ in probe. Also clear MSPI interrupt status
> resgiter prior to registering IRQ handlers.

Fixes should come at the start of a series before any new code so that
they can be sent as bug fixes without pulling in any of the new work.

--xOqAsnaWS/lHizBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkKuQACgkQJNaLcl1U
h9DQXgf/eTSW4vbBBCQmn3yS4uGqsr8gvwfs+OSutnuLs9VwMhWpCQ5mmUReZ/do
UqEJg9KpkBugYA9YCCtrooc1lHoEFRzVdgdYiBiX4FFOwCvoSgx4rA0PXigZ3TB5
n977UKdIWlbAD50f+YEf3KdmXoSb8kW//a17BTkm0g5J44Q2jgRkKIJ/XCUT/wHh
tt5sRG1PFtSXk1JjWaPiT8WTDNRDSlp/8+AodGxiaPDx04RcHAZhRVL2Hr1kZ5kQ
c+9G0efJGip4k+XgYigjibn7VzdLjhcUbx8dSYkAooVcKI/3io01ISg1+atRYhT4
Omn1lllpWd0E4slaC58/9miCHCLHBg==
=ikRg
-----END PGP SIGNATURE-----

--xOqAsnaWS/lHizBU--
