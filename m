Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C1123CF8A
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 21:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgHETWV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 15:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgHERl4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 Aug 2020 13:41:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C4DF22CAD;
        Wed,  5 Aug 2020 11:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596625347;
        bh=cmz98b4aN6klrGIsOTUwn9K0/pumDsFYeqieDUYCi30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVIFO7jxtvIz8aTDGf7shxm4OV5InZb/7jnDWISeCyJFZ4UJQtRfFtLzIm4cnB7bc
         04VZ9RTFmwFOce4ZsAgN2Sg5khJDyARPhguXwycRZ6mCSA8bnLG95y5recuPWh8wh+
         fwpV+5nUZvh2jhG5qgSWRza5gtkWletx20dKAVGE=
Date:   Wed, 5 Aug 2020 12:02:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     amelie.delaunay@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH 13/18] spi: stm32h7: fix handling of dma transfer
 completed
Message-ID: <20200805110205.GH5556@sirena.org.uk>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
 <1596610933-32599-14-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="svZFHVx8/dhPCe52"
Content-Disposition: inline
In-Reply-To: <1596610933-32599-14-git-send-email-alain.volmat@st.com>
X-Cookie: Fast, cheap, good: pick two.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--svZFHVx8/dhPCe52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 09:02:08AM +0200, Alain Volmat wrote:
> From: Amelie Delaunay <amelie.delaunay@st.com>
>=20
> The rx dma is completed "after" the last data is received
> from spi. Thus, to avoid loss of rx data, it's mandatory to
> wait for the dma callback before tearing down the rx dma in
> stm32_spi_disable().

Again, please put fixes at the start of the series before new
development.

--svZFHVx8/dhPCe52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8qkawACgkQJNaLcl1U
h9AC7wf/Tc9hKs/yIxoXXdFXrgFaODwz5noiIf85U1PqJmzIfy4Q0csYUwSL+p03
vZmqEmP1gK3M+JsByWO+nU3KBW40ZbfLzoEuYTjfCyg3fqlR83UW+fI2s8H9ddcc
IKjdXeSDZJzL/c+SOzHq6eMcRN/UT1K19TibNV4kuTbfOU29/uMnF87jyk7k8mzy
RPq0QgjVFnU5EL4lUXha1Vq1p7jGVhKA1iR8yqBwP+aHbgfC6M8tueHPjztMbVX3
fWF+54fHl9URy1O3f5ymycoNqXfHiKrjsIbCzpA9rcWILZNht5qf+YOasDNUJ0Ai
VYjSU+o3H9L1uJKSd2QoZlsnRNUswA==
=ARDB
-----END PGP SIGNATURE-----

--svZFHVx8/dhPCe52--
