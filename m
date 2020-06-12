Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E78C1F7782
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jun 2020 13:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFLLwH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Jun 2020 07:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgFLLwH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Jun 2020 07:52:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 919A4207D8;
        Fri, 12 Jun 2020 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591962726;
        bh=mTt+Jh35Pp0ahlcoy+6Sr39U4JxkvotoC11yiL0zg+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYqpgiPGkmnchmysC/r96L+hiQO/H31xeJQ00HMxLUKEREjrNwNoQX4H2cdNrnKz1
         fjswOjh7m2dvum/xgq7g+TMrHPvg1JqnyPJNMCC8WAoXR3/3i7gTlz+Ya22G8qvs+t
         aZG6GyZ1AQEziUyb3oBrbL6MuX3J89F9xwfcQD8o=
Date:   Fri, 12 Jun 2020 12:52:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH 4/6] spi: altera: use regmap instead of direct mmio
 register access
Message-ID: <20200612115202.GD5396@sirena.org.uk>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
 <1591845911-10197-5-git-send-email-yilun.xu@intel.com>
 <20200611110211.GD4671@sirena.org.uk>
 <20200612044346.GC21214@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <20200612044346.GC21214@yilunxu-OptiPlex-7050>
X-Cookie: As seen on TV.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2020 at 12:43:46PM +0800, Xu Yilun wrote:

> So we think of creating regmap to abstract the actually register accessing
> detail. The parent device driver creates the regmap of indirect access,
> and it creates the spi-altera platform device as child. Spi-altera
> driver could just get the regmap from parent, don't have to care about
> the indirect access detail.

To be clear there's absolutely no problem with the end result, my
concern is the way that we're getting there.

> It seems your concern is how to gracefully let spi-altera driver get the
> regmap. or not using it. Since our platform doesn't enable device tree
> support, seems the only way to talk to platform device is the
> platform_data.

No, the problem is with how that platform data is structured.  Based on
what you're saying I'd suggest adding another device ID for this - you
can use the id_table field in struct platform_driver to have more than
one ID like you can have more than one ACPI ID or OF compatible.  That
would mirror how this would be handled if things were enumerated through
firmware.

> I think the driver may need to figure out the role of the device in
> system, whether it is a subdev of other device (like MFD? Many mfd subdev
> driver will get parent regmap by default), or it is an independent mmio
> device. But I'm not sure how to do it in right way.

Yes, it sounds like this card is a MFD.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7jbGEACgkQJNaLcl1U
h9AMAwf+N/1o1gxv/MaYstof7MSjapJ2xT9M3K7h+qCIyYAdNQkfqEVoP0Iz9mt1
fFHuBiDzA6J4QtLtMSbhZVt8LcmjLGy6jd7d+Id5slh/e7EaExUMDoqtCgr9nG3s
A4mRr7hd44KTXbZELLKMtV0AfRD8l3fcEUdEnWRDDQCm3v3m07gbKZIwSo5y3/yF
SdelKa+ihiJVfntXICDMTvyeXoJ8FtLGVUzZyeakfzabOi7ej7i7vNeQXWlSjq1c
XFkO4/3v9f5HXPNEPCaAIlcR1rbgS+OpRatLfpCj5dkZWo9WRHRRLjrdb364Eayc
Z9SHE/1eDmWAkSdBqcY2Yn5y46WHNA==
=+BqO
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
