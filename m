Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DC834EF40
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 19:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhC3RUO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 13:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232404AbhC3RUF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 30 Mar 2021 13:20:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9590F619CC;
        Tue, 30 Mar 2021 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617124805;
        bh=2/dPY9t5kX+DrpyqHP3skhadiWt2xW/f6QwafOFqAr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmqqrVgXK8BKxCXrHWxgFyu080dcpyxqmuq1Ck7EzTT2Tez5F5LPx3OhU2iDGYHRS
         b1b/X9QDBPmCs1r/QRa4ljaZARr6q6QZRsO41qr2+c8Wf+o5aWEe0Xg2XDLRI2TCpB
         Pff6etnmOMTxdqfvMkF/jm3TUsx0w8bDiO14kCnxIXtnqHwsR/lByvbcMHU8ZDqddx
         3nyl1SNa7eOkDl4LGIeeUpyFytJVJxNXpb6XHLYOq0Nl8eU4juFBm1MoGtpDUvJ2C9
         vgaCKEsJop6IQEs8QYWYE2oh8EcMXDRMzR3D/YBAL6XsIUrt29y3zLSwYrDKGMrEsk
         J2KVGG6ST60jA==
Date:   Tue, 30 Mar 2021 18:19:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: ensure timely release of driver-allocated resources
Message-ID: <20210330171953.GI4976@sirena.org.uk>
References: <YFf2RD931nq3RudJ@google.com>
 <20210322123707.GB4681@sirena.org.uk>
 <YFjyJycuAXdTX42D@google.com>
 <20210323173606.GB5490@sirena.org.uk>
 <YFo7wkq037P2Dosz@google.com>
 <20210324213225.GD4596@sirena.org.uk>
 <YFu8y9CuG6Mouxnq@google.com>
 <20210324233935.GE4596@sirena.org.uk>
 <YFvWsA3WnMAqVLGU@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="54ZiyWcDhi/7bWb8"
Content-Disposition: inline
In-Reply-To: <YFvWsA3WnMAqVLGU@google.com>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--54ZiyWcDhi/7bWb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 24, 2021 at 05:17:52PM -0700, Dmitry Torokhov wrote:

> OK, I can look into it. In the meantime wills something like below a bit
> easier for you to stomach? If so I'll resubmit formally.

Well, it's a bit nicer for a bus level bodge so I guess, but really I'm
more thinking we need something in the driver core for this.

--54ZiyWcDhi/7bWb8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjXbgACgkQJNaLcl1U
h9Bk7gf/buRs+lVX7ALKqplNAG8yg1soNU48Gbe5haaWHCBqxdM3YvLGIAiEYAY8
qhqwoHy6psIHROgbdBZuUUx549QPqERFawXjUkjhhZstGT7yubbDNB7MJ6Gygz/L
LeSXv2AWcoTyTctaflOb+PZAGFIt9A079/Kf0CcRgv+fN5ERCmBOEFqnHT4vwTs6
iyi7IAif3Ak2qIt6ZNYTm0eR3LxfKOhY18MeMDH8wiWt/U2vAJ6GMW3Nai7ADtGi
TkVsC2cTXuWu4+2Z6Rkte++4DKjPmiZLTTe5v8Tc3lA8JAScDtpR6a5kb+Qb7rYQ
JjgXwfb0St5f7lCY+yXxUOuIfSxFxA==
=uj9j
-----END PGP SIGNATURE-----

--54ZiyWcDhi/7bWb8--
