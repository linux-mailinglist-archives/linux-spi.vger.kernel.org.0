Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA93D0ED1
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 14:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhGULvk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 07:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232908AbhGULvf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Jul 2021 07:51:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0697261221;
        Wed, 21 Jul 2021 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626870732;
        bh=XQHf2979Xlx/iaZS18v88toAob2o+9Cb5fbI2ZSNIWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xo8/ygYg4NMC7fOpp2VARr/Gu/BNupkOCXn5WIVbNPdXXb7n5QN3CK+IeDlMMONIL
         6yUO9Ll1v8GyjRbyTFgIliumZxtDobA2FZCXtpjx1yUyFWEw/LLXm8mjVzcDBJZCEf
         RByxyvVfmGvGk0TsrHoDyGvKU9NFCp/3dSQSk7BuhLmkXalFEvQMYrCJPl9qmKMrCa
         GH1diIeE1an+UCi6hkSM1wEQU7Nm1RZBa5Zo79RGMEkxgaInIrn/EzYD9733iptVfy
         UT3PRNV8FfotQ92YWBd6r7uzbURtBoCj4WG5e6oxlZc+TMzcnS+wu1MX3MGTqY0Pqo
         zuB92JuqPlsAw==
Date:   Wed, 21 Jul 2021 13:32:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Tachici, Alexandru" <Alexandru.Tachici@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "nsaenz@kernel.org" <nsaenz@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "bootc@bootc.net" <bootc@bootc.net>
Subject: Re: [PATCH 0/1] spi: spi-bcm2835: Fix deadlock
Message-ID: <20210721123207.GD4259@sirena.org.uk>
References: <20210716210245.13240-1-alexandru.tachici@analog.com>
 <162680680557.11423.14003826010912823109.b4-ty@kernel.org>
 <PH0PR03MB6366CFFFF5846F7018FFA03699E39@PH0PR03MB6366.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <PH0PR03MB6366CFFFF5846F7018FFA03699E39@PH0PR03MB6366.namprd03.prod.outlook.com>
X-Cookie: Many pages make a thick book.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 21, 2021 at 06:47:01AM +0000, Sa, Nuno wrote:
> > To: Tachici, Alexandru <Alexandru.Tachici@analog.com>; linux-
> > kernel@vger.kernel.org; linux-spi@vger.kernel.org
> > Cc: Mark Brown <broonie@kernel.org>; nsaenz@kernel.org;
> > f.fainelli@gmail.com; rjui@broadcom.com; swarren@wwwdotorg.org;
> > bcm-kernel-feedback-list@broadcom.com; bootc@bootc.net; Sa,
> > Nuno <Nuno.Sa@analog.com>
> > Subject: Re: [PATCH 0/1] spi: spi-bcm2835: Fix deadlock

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> I'm really curious about this one and how should we proceed. Maybe this is not
> new (just to me) and the way to go is just to "fix" the spi controller when we hit the
> issue? I'm asking this because there's a more fundamental problem when this pieces
> align together (CCF + SPI). What I mean is that this can potentially happen in every
> system that happens to have a spi based clock provider and in which the spi controller
> tries to access the CCF in the spi transfer function... Doing a quick and short look I can
> already see that [1], [2], [3] and [4] could hit the same deadlock...

The clock API just doesn't work very well for things on buses that might
sleep, I2C is another example - it's a long standing general issue that
needs to be addressed in the clock framework for example with finer
grained locking but nobody has come up with anything yet.

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD4E8YACgkQJNaLcl1U
h9CYAAf7BWXFxsLJR0wtgTKipOtavmlW4sbr+1qOD4EqV53Q0uCO+u9UhLqhqDKf
pah8nixXNUSfNW6Yc+myXrrwNm9wBBw638E2OMEnFo5w5+/m8cL/a/Y2LQimtpfl
Nw9aWwGaiPUSqbByaPqWQyNgR4VG2N5qN6hLLdCKlkMHI6xejBqc0WBXSmyIDqi3
HVxRS7a9H2GwIYcjyoBtowguYCuD3vPux7eaFPvdBG1D/K8Rn2jHuWXGNb589h/C
6xPnM7jmPghS/CrAL6+YZW3/Iz/iX5TZn9/X82PPQbKd694h+dOSbOLd/MlOx6vi
NsgO/BBT2qkVAX6aoE3Vu+3oNcwJZg==
=VEKT
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
