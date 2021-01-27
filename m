Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4853059D5
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jan 2021 12:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbhA0Lcc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jan 2021 06:32:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234567AbhA0La2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Jan 2021 06:30:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2EE32076E;
        Wed, 27 Jan 2021 11:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611746980;
        bh=MeXh87PhrXGbxuFNLGsx1zwPAc25m19iwuT8SQtjfxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mN3AANCpN24xFffemzewOHV6grTdbxxS9mB86vkxuBnaH3UP65G7fhJ4XbU6mlVuE
         bOiBn8AfBKsWcqHfnUgWPLEAy33uVN10uS5fxR406SbIoPD4l268dDhS1W4Vxl9ezo
         x4y55qp7EzLbFu321LifyESl+IQmsbmjvi2F3gTdPIiLWNZhEtRkdbub/V9Zo/3vO5
         amAQlDSJT2ZV8QlvHhU2KUn5QsFEpcfSYWtWqntRrXXnT2HdrN2pIHjQUXjdBvLpx5
         1JHhFLbfXqlhonfYw2i2gWc5UclrLPTcG5HvjMB8+FAlq2V/GQAECRgaSoZioVa5hO
         BTi4jsm5haKKw==
Date:   Wed, 27 Jan 2021 11:28:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Corentin Chary <corentin.chary@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-spi@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-hwmon@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ACPI: Test for ACPI_SUCCESS rather than !ACPI_FAILURE
Message-ID: <20210127112857.GA4387@sirena.org.uk>
References: <20210126202317.2914080-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20210126202317.2914080-1-helgaas@kernel.org>
X-Cookie: La-dee-dee, la-dee-dah.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2021 at 02:23:17PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> The double negative makes it hard to read "if (!ACPI_FAILURE(status))".
> Replace it with "if (ACPI_SUCCESS(status))".

Acked-by: Mark Brown <broonie@kernel.org>

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmARTngACgkQJNaLcl1U
h9C2dwf9GE0PHhDzOzGae10MRkXBNzBdmeTf035YAM12jQ6o9G9kDK3xBSA64Jcy
rr3+mkHvYkCEBEdAzV25MDRg2iXAoLBYJdmfMHXt/u9D0aJf80gMEXgrUDE6yjQo
AJvXTJrJqu+KS2RMpnxIHfO1rXRZrQMIAln9GbePtqKjGUN5cx6QJKUDYyrMlevp
9KZr/ClGQmLOYJ7suU9mr1NFgEgf6XnsU7Gq6BGuyo10GO62Qg3bztHtkiiRxz/x
zvr9PngfutrIGT7qfvKBSmWk2y50qe5XDeJRD8e6YbFS/Ge5LnOwmNc24jjts04w
OE5TwTVKRHFfy39WTQ3IdmJaznDhqg==
=b7Y/
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
