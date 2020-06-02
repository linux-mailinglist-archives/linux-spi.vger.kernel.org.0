Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294221EB8EA
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 11:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBJyO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 05:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgFBJyN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Jun 2020 05:54:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E854120679;
        Tue,  2 Jun 2020 09:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591091653;
        bh=xY97r6XE7nDvMY9qfV2dYPNsEywjIYh98R3K9sGQhfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lvBd6gXIUGl3MscitKsaUR50Mj4FF2zE9p5qjHeSaHO4WZ6UPEuN62/uI8BcwBsmg
         NYxV6qhwEbXtpOFfzzrnPcnhUdr/A9o6JpSJ0NNHdAKqXqU3IdOkPca6wu8YuXPBgK
         YKbJJA/aZOmP7cPCyo80JpoHQVGccEUP9JFplW7Y=
Date:   Tue, 2 Jun 2020 10:54:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
Subject: Re: [PATCH] spi: spi-ti-qspi: call pm_runtime_put on pm_runtime_get
 failure
Message-ID: <20200602095411.GB5684@sirena.org.uk>
References: <20200602043637.5317-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20200602043637.5317-1-navid.emamdoost@gmail.com>
X-Cookie: We are not a clone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2020 at 11:36:37PM -0500, Navid Emamdoost wrote:
> The counter is incremented via pm_runtime_get even in failure case.
> To correct the counter call pm_runtime_put in case of failure, too.

Someone already sent a fix for this but in any case this isn't the
correct fix - pm_runtime_put() will also undo the pm_runtime_resume()
that pm_runtime_get() failed to do which is wrong.  pm_runtime_idle() is
what you're looking for.

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7WIcIACgkQJNaLcl1U
h9CQHwf/U9Q8TkqC+76gfe2ld5ZNuYAen9SF+VvOpstls0rpjNUczlFvyKGD0//I
K/Yvi8soH63/nDO5lhAgL8VjDt4IYR88Z/QANsGAcVUmDjiBZ1ReDKRSrmA4d2Mw
7Ljnkt5U9JudniSKG8QtlwOzALdoamUJjyXuqWM7/3FKN5C9jhakR4t4a5PcoGho
TAghfZuztaO0wFB7vt2rdqHkPiVkG0IAcO1LYJMJvufAuARtdfxM8YbCWTWr6A4L
oGQ4ImVv5G+d+ci5kJaS3QOk3woJAePMx8O7hg59Vkrg152vewrhqc3Kg+z5vkr2
OQ03OswFxIFs3EowbpfXTSZWrTRqEw==
=AS75
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
