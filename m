Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6661A3CF9A6
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jul 2021 14:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbhGTLxT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Jul 2021 07:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238023AbhGTLxI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Jul 2021 07:53:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A260660E0C;
        Tue, 20 Jul 2021 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626784417;
        bh=qSaJndvw0eSPzb1gW9yIAvb9Vq6Nk50WPF3Eeahy8xI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lWEXZznuBByWEWzal9juxO4tCbTpRVgRt2IjaADVVKtIt04801gWWyA5y3l92/yKY
         I+O2F/oI5fzngTDM4/nXsP8pwdgs9XlNA8foJ5Jw+Vch+GEVZg5dqXHbovzl4WlX2n
         E2FjuLsBUC7HkPpaioprFRYyn7hfbiyZk8hcDPgrs3qZ47n22yK2pD1BTwWlDn93Mb
         aAqlmNE24nlUmSMrtZCMzkAD//zwk319AthEwYIdfV/KeBWC71sqcsk4kIhOXsULnP
         wdLK+lfpHn1oExM8R7xCt1gRANMc2rtfauoKFGmZeLvJbE5ECylm9c5FF1jmtEHrKj
         mtwR13LjcQQQQ==
Date:   Tue, 20 Jul 2021 13:33:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nuno.sa@analog.com, bootc@bootc.net, swarren@wwwdotorg.org,
        bcm-kernel-feedback-list@broadcom.com, rjui@broadcom.com,
        f.fainelli@gmail.com, nsaenz@kernel.org
Subject: Re: [PATCH 0/1] spi: spi-bcm2835: Fix deadlock
Message-ID: <20210720123332.GA5042@sirena.org.uk>
References: <20210716210245.13240-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20210716210245.13240-1-alexandru.tachici@analog.com>
X-Cookie: Revenge is a meal best served cold.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 17, 2021 at 12:02:44AM +0300, alexandru.tachici@analog.com wrot=
e:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
>=20
> The bcm2835_spi_transfer_one function can create a deadlock
> if it is called while another thread already has the
> CCF lock.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD2wpsACgkQJNaLcl1U
h9DVKwf/QCjmRsWnwf3OJAbQXENQAPS5Wn3HZaxmBJRq58r7GSxewpaGSlqIeeB0
xuDUtWVB6l0TLkCbpI2gr/P7JmR+LuCZHOlGHCO/kwRqbf4oFThl1bB74uXhXEPi
7IH9lZfJE8ScAh6yr8Ji6Iw5Y3RmI62DAgFqC/Oslq1U5MNUX9R5RqcmG9bOrdIw
X2fSoNQ+6gWvJeMyT77iu6eskYhtacgBn8pt/A/PUivlmi5Dw5UCtZVmB3EU4rFz
IcH6kYYQmoe+Wj+LxHhzxTecAvQOAuJXW7dbsmfWIIQ06LC8JV3BarrhTQ3xVQ9q
bG3VVV+Azk+vyGfPj+yr3P6W4aKOOg==
=hQzo
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
