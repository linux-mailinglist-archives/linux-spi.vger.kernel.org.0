Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070903F630B
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 18:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhHXQsD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 12:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbhHXQsC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 12:48:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6F9861183;
        Tue, 24 Aug 2021 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629823638;
        bh=ltTAxcnVq5FnPnHrkXah5AXz0yDZm3341oEzARJcVUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PT2VYda9E2xax8AkiXdEoytVS2L91VCGtjstVoO1022oYAUHd03h3DOTwp0NhSOkb
         B9pfgtWu4fShp6lnZC6yAb9DmAE5ql4sMcaG7nCGpfspfk+PSDbRoHunXZ8zHOPaWC
         JjVOno0J+MtA318Mv2YOsM5nDCRwEqciJpKHIxqoCEDwd7E7nmYvM5d/RUCvGr+OYC
         FDOwzF1G1pAP8DlHOGI5cN/GVKwbUab7QxwG+O+dza0zsZxTXZOgun9EuvffxXOE23
         xPTSm5PBH/EX/bsrQBRP8ccIFq2nDbgVIKcB44CM9YFx4DkipOBShmGJSo0o/F/Oll
         VXCOHPGLN5hhA==
Date:   Tue, 24 Aug 2021 17:46:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 5/9] spi: amd: Refactor amd_spi_busy_wait to use
 readl_poll_timeout
Message-ID: <20210824164650.GI4393@sirena.org.uk>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
 <20210824104041.708945-6-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l0l+eSofNeLXHSnY"
Content-Disposition: inline
In-Reply-To: <20210824104041.708945-6-tanureal@opensource.cirrus.com>
X-Cookie: Sentient plasmoids are a gas.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--l0l+eSofNeLXHSnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 24, 2021 at 11:40:37AM +0100, Lucas Tanure wrote:

> -	spi_busy = (ioread32((u8 __iomem *)amd_spi->io_remap_addr +
> -		    AMD_SPI_CTRL0_REG) & AMD_SPI_BUSY) == AMD_SPI_BUSY;

This does ioread32() while readl_poll_timeout() does a readl().  These
are almost but not quite equivalent and the differences apply to PCI
devices like this one, see device-io.rst.

--l0l+eSofNeLXHSnY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmElInkACgkQJNaLcl1U
h9COxAf+Jb+svZhpIf8l5/k432oxnfrF2Pl9Yx76uGMzaUCoJWJOlD7x5EcGGRwV
wwGzzofYp8ebrWAgBjCfvXuzHGmOxlr8kH9leBVWHQ6KEndheAHYZsYc30RqksMV
u0Aig6UNC2IUW6LTCnpHSFFkcWwQlmCmGPBte+R933TzZq0YKAGQNhITIYg9iJ3q
oVNbL478jWICmEPTDz9BXGUa5PDHnjgZTf3yvYipRLIUdXALR3hRQS5YYl7YydAF
ExwQhuJoBdfTbrgt/Sp3h2Ov3jmIJZ46bzH0eF6IhNSfP7mgvFpWlta15a/jjpf+
mxyNsCnoa+7RJgvFgefUG1mkD+9luQ==
=DIL2
-----END PGP SIGNATURE-----

--l0l+eSofNeLXHSnY--
