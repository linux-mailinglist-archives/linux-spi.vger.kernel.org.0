Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128511AD8D0
	for <lists+linux-spi@lfdr.de>; Fri, 17 Apr 2020 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgDQIlH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Apr 2020 04:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbgDQIlH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Apr 2020 04:41:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B050C2137B;
        Fri, 17 Apr 2020 08:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587112867;
        bh=Q4esTZYVNmqT30vqB5Ty7wXcBtA09QLwSlf9T8E+ZBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4dvaNIUbdbJ++rgfPga0xtZ6c8pwdLGVZ+75rsfMK9B9GAAJEGFjchkTAIYPyRFK
         xAk/AsjrAsDm6THYnGnC8TPcjHOYM02u9ih+qEpIuCZ+Jk9BNw2esVekMPso2ccuNE
         PgJnnDiPoaAGfONc5XICnGncl0FKtvoliUkQnf0A=
Date:   Fri, 17 Apr 2020 09:41:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/9] spi: bcm-qspi: Handle clock probe deferral
Message-ID: <20200417084104.GA5315@sirena.org.uk>
References: <20200416174309.34044-1-kdasu.kdev@gmail.com>
 <20200416174932.GP5354@sirena.org.uk>
 <7b2db6ed-1aab-4c61-e519-a73d9e3af454@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <7b2db6ed-1aab-4c61-e519-a73d9e3af454@gmail.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2020 at 01:55:21PM -0700, Florian Fainelli wrote:
> On 4/16/2020 10:49 AM, Mark Brown wrote:

> > Did Florian author this patch or you?  The signoffs look like it was
> > him.

> I believe I did author that one ;)

In that case the patch (and any others that are similar, I saw more)
should say so - please resend with a From: in the patch.  Kamal, if you
do git commit --amend --author='Florian Fainelli <f.fainelli@gmail.com>'
that should do the right thing.

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6Za5kACgkQJNaLcl1U
h9A9xwf4tJJ4FQfCqc3g/g18a7HQvQ+rTSw1zy3scDDH2VMdbuuwSDGW/r4v4JWQ
oU95OE0cL3DSRieGt97D4iXnct/lP+38ETY9tWW+dVYMP7s+pmXEEWgWLd/qIIFc
seoBQuSxW0CeZTBGlS6b7SY/G2LK9c9s5kgxkhvqay0Uvc1jgKZqCu0gwKzbHXJv
PGbE89ob5MzL7PkjsftkZ+imKogOvIf286UVvrd6setQqjh9AbMgblDhaKlvYERb
20m9D0jkpJeTjkxYz+g8Xh5Op1b0bDgm1VY2K/wCHPRdSS3W59TY7rgZXhxD0cN5
vsi8xG8mYfU/E/peqBMYftWPtk/j
=gGzp
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
