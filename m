Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C5A3373D0
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 14:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhCKN1p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 08:27:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233450AbhCKN1n (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Mar 2021 08:27:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CD3364E22;
        Thu, 11 Mar 2021 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615469262;
        bh=F7euNJNrFk34ndAdP1XsbHT0SlNFOnOjDn5UnvDXwig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jBY23V7CkZER4odXeTZuNlNMXmWsiShTaSGRKyPlBkdEJPVexl73sJWHuQ/GX6vOi
         grmIu71NhkgprO6KE8W9/H6enSGRwuSwelRpjmCWi0FmeASbEsLnWVK6hidwaEP3Qb
         nj0eaEYAu/gobg33jQDJIIW8RDbzulOQYc12vr3Xi3Qv9bkS825jHMwxa+w82378rG
         V6id4rhmThM8pCLN/SCWMZlhNIEL8hO3Lz9TrEI2rvbwN8AfKuXIWRIE2GW9502l49
         1KpIb/hl0WpF0AZl97XRhuP2w/B1Xn3275berSa3CbqOAMl8DRY4vaLSiaUUuMySW5
         ZkWMZmEiEo9Dg==
Date:   Thu, 11 Mar 2021 13:26:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Meng.Li@windriver.com
Cc:     linux-kernel@vger.kernel.org, tudor.ambarus@microchip.com,
        vigneshr@ti.com, vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] drivers: spi: cadence: set cqspi to the driver_data
 field of struct device
Message-ID: <20210311132629.GD4962@sirena.org.uk>
References: <20210311091220.3615-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <20210311091220.3615-1-Meng.Li@windriver.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 11, 2021 at 05:12:20PM +0800, Meng.Li@windriver.com wrote:

> Fixes: 31fb632b5d43("spi: Move cadence-quadspi driver to drivers/spi/")

Commit: 5e838bc8035a ("spi: cadence: set cqspi to the driver_data field of struct device")
	Fixes tag: Fixes: 31fb632b5d43("spi: Move cadence-quadspi driver to drivers/spi/")
	Has these problem(s):
		- missing space between the SHA1 and the subject


--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBKGoUACgkQJNaLcl1U
h9CEOAf9EK8P+pv0zMFXiPfhu3vIKy7zn1sSJfa6bmK3kbEhggKpfioOA0uumdXv
q35lhERO6eF2H3424WKezS1Mwv3ZfgIiLCY4vyATvbK1YGbzbZIVRXQ0wHP7YHI6
nrATMnGx9CgugGsjMwnqGSCwMbnICccJ3Kqnxb37TVCkyakW2xoLjZ5Dlrjm2ZhU
GUDPnkDcVUD8bR53mSu5ZbPaTrT91XWl4blG4ppTnqin1fIhXI2NWMFIcRu6Y3Bk
VW3S21BpKlh1ksYZvjNYWo3YM/dp7Da9oxPZNs8UgChn1XwW1ghAY0brbD93Jy4x
foltOuHAlURBMpIjYs1JmkqA9J+xaQ==
=qQxQ
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
