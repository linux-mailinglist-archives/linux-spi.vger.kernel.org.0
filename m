Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32675344229
	for <lists+linux-spi@lfdr.de>; Mon, 22 Mar 2021 13:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhCVMjO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Mar 2021 08:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhCVMhp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Mar 2021 08:37:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B228619B1;
        Mon, 22 Mar 2021 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616416633;
        bh=2l6rVO3mWThw0cnnqLKMHgT4wVnMf+2Jd8waAnFXn8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m24jh1cGUbqLywhutLaMjrdVvu34FkdywLSI3gBFrxn+J5NckaCQQclp0Qwr9yDwI
         QAgb51vca8+rIrQwaY+JQO/EegzzvMlrGIlQYtfQLa54t57BTMx398EerhdWzYaAt9
         LovFlXP0EQk5qAkw36joqtEuP5bVxUGm+8SlBakukT3axKmdfTACUxEcd20DQAgdk5
         PFTXAfGwtMp3ZUjrhAyYYdNYiUI39+ShuHamRc/fOx2fLNK+KUFBKpnE5Wqk1JTNTN
         z6+QbTt+AaoUw6I+nGwjUTknAsINSj1ZkIButjUV6ML0qAeRfgnQ0TjUGteGq/d1+/
         EWSvScn1Cro2w==
Date:   Mon, 22 Mar 2021 12:37:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: ensure timely release of driver-allocated resources
Message-ID: <20210322123707.GB4681@sirena.org.uk>
References: <YFf2RD931nq3RudJ@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <YFf2RD931nq3RudJ@google.com>
X-Cookie: A friend in need is a pest indeed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 21, 2021 at 06:43:32PM -0700, Dmitry Torokhov wrote:

> Note that this is not SPI-specific issue. I already send a similar
> patch for I2C and will be sending more.

This feels like it might make sense to push up to the driver core level
then rather than doing in individual buses?

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBYj3MACgkQJNaLcl1U
h9CrkQf/UETgb5x1iLO0DKe44AggifFZVyrHWKjAAM0dcdTy/lgsg8OjXlyg1nAX
a1/aKWMP4x/BOcIuc9aqSvvcdabFUzX6zqtjAYKAW/dcrbTZKIJuS+b+i9zk7jCI
E63I/3H9zf2zxs6OWqFNg6qI0tajYlYj6Hleiad1xIur3IuavR+0ILA8N42x4tHh
cWKst/QHxkYLRYsvr8MkjW9oIsZfBoXGGeT5RmWilQURGx3HsnluRrRJYFEBatRb
sF12FvwFLjtWJ0pNwAuT6YinOrEp/UB0IQgHf053/GoFq7bUahLiDpupqiPmIuUr
rfg+jBS2JeGxHCxWxyP5LBY1v73zUw==
=hsLc
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
