Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E642F1B26B3
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 14:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgDUMu3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 08:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUMu2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Apr 2020 08:50:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0303B2076C;
        Tue, 21 Apr 2020 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587473428;
        bh=suoahaCGuZlLczO0io1rO9mdX176xgr8vmo8LKyoeTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yyhIpdLJAZ3bIOyjqwFU18PS70/eta9vlOWz0aDhgxXezu/jcXtj4BkWkreFG5o1L
         +0Jro3bptwUCX/UccNg5VdScjqObcPEnuN5Cfcma++Rjqdip+6oGEzzleLKPjcQE3I
         nolgB5+p536ZR2WVrkQdaWN5P/moAtqJ7uQ/mSMQ=
Date:   Tue, 21 Apr 2020 13:50:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists
 only on legacy controllers
Message-ID: <20200421125025.GB4540@sirena.org.uk>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
 <20200420190853.45614-10-kdasu.kdev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <20200420190853.45614-10-kdasu.kdev@gmail.com>
X-Cookie: Non-sequiturs make me eat lampshades.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 03:08:53PM -0400, Kamal Dasu wrote:
> Set MASTER bit on the MSPI_SPCR0_MSB only for legacy MSPI and HIF_MSPI
> controllers.
>=20
> Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

If this is a fix it should have been near the start of the series before
any new features to make sure that it can be applied cleanly as a fix.

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6e7BAACgkQJNaLcl1U
h9Bnqgf/XnwmafaswG9KdNaZ05xrhtMxH3MoL9M/OQR+vW1TZgsUuuu7PAZy7bRG
upiLbLB5xaILboqcx+YPE0MRofDKK3id+RpC7JiVqE7ICHa+rYjwS2yJljFGNlWB
VSm08TN/K1nNXKzUx838zge4t3bc/4hme5kkuOCGhymxmo5MQVl2L6RbOgW8CUNO
VXPGUwBDq0ojKLIVfzdCQC+p2bUw+pRLmfXATHYCLlCIjr7at+K+t9M7JuwUlNpf
YrImXkmQsBloQjK/+5cEx8VSBUbuG9jRS8thd2/thWIb3/sfCSrwJ9NbqpUjF94D
n+jbm3grtaHoKo2j5VxqBgtmW/01CQ==
=7JZw
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
