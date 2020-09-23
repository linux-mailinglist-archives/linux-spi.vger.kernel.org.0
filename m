Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB7275FF9
	for <lists+linux-spi@lfdr.de>; Wed, 23 Sep 2020 20:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIWSf2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Sep 2020 14:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgIWSf1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Sep 2020 14:35:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C742D235FD;
        Wed, 23 Sep 2020 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600886126;
        bh=J/8hPr1C+0si+jZBTowGwC2PwN9FIWY4BkhwW1InYuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsB0Z2w7wknngIB3HKNKKmIJB5dOHsgjbmnLbzbjlNsA6f+6y0ZHUW1dAlN68wmqz
         GzvHUKyuJtbhN8RTYTLPmU1iePYHUTQyHiYEv9puG9oBvq6NDh06DljXS+7SnVFtU3
         59Yc3o03WUU2kNQOECgH6Nhg2wmwb2z8jmPDtq80=
Date:   Wed, 23 Sep 2020 19:34:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [RESEND PATCH 1/3] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
Message-ID: <20200923183431.GF5707@sirena.org.uk>
References: <20200922164016.30979-1-amit.kumar-mahapatra@xilinx.com>
 <20200922164016.30979-2-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <20200922164016.30979-2-amit.kumar-mahapatra@xilinx.com>
X-Cookie: This report is filled with omissions.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 10:40:14AM -0600, Amit Kumar Mahapatra wrote:
> Fix kernel-doc warnings in ZynqMP qspi driver file.

This *still* doesn't apply against current code:

$ git am -3 --signoff ~/queue/spi/next/20200922_amit_kumar_mahapatra_spi_spi_zynqmp_gqspi_update_driver_to_use_spi_mem_framework.mbx
Applying: spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
Using index info to reconstruct a base tree...
error: patch failed: drivers/spi/spi-zynqmp-gqspi.c:173
error: drivers/spi/spi-zynqmp-gqspi.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.

Are you positive that you are using my for-5.10 branch and that your
mail server is not mangling the patches you are sending?  I also tried
with plain patch and had similar results with almost all hunks in this
series failing to apply.

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9rlTYACgkQJNaLcl1U
h9B/JAf+J19B8MvDa5B5/HykKrhQfd/IE5/4HY/JDzKkVRjXyzah2xz5T+qDGoQD
4qT6UwtOemOdYS07KhrRBwDqARqYszypr+JCOJ64zW9lvxQ9GvPBlmK7rayOMqX1
abL0HWsTzWojyz7B1FICqqBV1ZegBo+SUPZChYCypduXQFhoRE2MniHoehEIsmqT
ILCBtH/BYRePbOTzVoMrL7Ex7Hz/aPEUgZuvjhCct38xmfy5D8ffYI3wX2fOH9/+
MQmvTBfYl8KLT42OfPRkbuvBCLXSqyAgzKU2OQ2xa3z8+YUY2oPJXSbJnJ2xF2AM
yFfZKjQNDsvDyQeY3lGCMUGWUx72kw==
=bnhe
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
