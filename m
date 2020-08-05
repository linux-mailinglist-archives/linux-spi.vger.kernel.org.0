Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1023CB64
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 16:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHEN2j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 09:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgHEMfj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 Aug 2020 08:35:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A9C022B40;
        Wed,  5 Aug 2020 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596625195;
        bh=uziuqXCitzn0yn3qcVqQktbrIktU/bdFnWIvUXG2d1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbMQoHTPo85qCfSbIxmgRbiP8VmVogdCuCkgmhfUc0VRYTty0OcrgsXe9VjbqzVdw
         AnOvnnkCp11BEtbHm44+ShvXz+ERCpXbKUN9sZMoZ+DseMUZBIX4Mvas3w7p5gvWXy
         qknPK8+AgzU2F0zcd/SXOiCLyI1t+IzYlAQ/0tOs=
Date:   Wed, 5 Aug 2020 11:59:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     amelie.delaunay@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH 11/18] spi: stm32: fix fifo threshold level in case of
 short transfer
Message-ID: <20200805105933.GF5556@sirena.org.uk>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
 <1596610933-32599-12-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <1596610933-32599-12-git-send-email-alain.volmat@st.com>
X-Cookie: Fast, cheap, good: pick two.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2020 at 09:02:06AM +0200, Alain Volmat wrote:
> From: Amelie Delaunay <amelie.delaunay@st.com>
>=20
> When transfer is shorter than half of the fifo, set the data packet size
> up to transfer size instead of up to half of the fifo.
> Check also that threshold is set at least to 1 data frame.

This looks like another fix which should be before any new development.

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8qkRQACgkQJNaLcl1U
h9D1Qwf/XK6Jhnh2m7+idtrH3vBpQSfYJ4/Gm+BchdfooNE/YEdndCoIkP/ZFbTq
HGasfDFqk0X+nnOBMxzvPKpSUPWYbqQd7dqb2Iak+JjLS3qKSxME/QPUQHrTwhzR
DvWFLzhLULQmUvkbvzqPnRuLYjhmRRYEjLXZJ6ZJrm3uJvqkguuDqW5F0yEFlXoh
JQSSVPe8qnb7Ok2+MUnATsFMuhlolzIYxKKgGp0MDgQxY+nBcwXcUG2UY+KZfFeD
OaG3oMz44hY1wkKWaJUa81qQMpLHl5yAU6U4ELbAYJeipCQ+uint7lh8eY9uoR1N
oISq56SrksDEpi1gC50Hs8XacwcRcA==
=HRmL
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
