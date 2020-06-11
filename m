Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4961F6631
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgFKLEL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 07:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgFKLEL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 07:04:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3141207C3;
        Thu, 11 Jun 2020 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591873450;
        bh=v2AdTRzjbbgd7womXSACVoFWkqyyTxBb929qt9XbrRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rf8xtPQ5r3OfPpuLjL5Ki7VUsTw35zVTwMh9wIpFDiGcadbIolsGvOFiv9KndPywK
         Y1uOy69somR5DjeG0H2iHRtZI6vejCgd0o2+jmWITNv3eOS/88KIXO+7GLE9hdm0Us
         MD3Z/iLxcIMAlhqcqV6MW8C5rMr6gJK6jPukUQu0=
Date:   Thu, 11 Jun 2020 12:04:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH 6/6] spi: altera: fix size mismatch on 64 bit processors
Message-ID: <20200611110407.GE4671@sirena.org.uk>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
 <1591845911-10197-7-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
In-Reply-To: <1591845911-10197-7-git-send-email-yilun.xu@intel.com>
X-Cookie: I like your SNOOPY POSTER!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 11:25:11AM +0800, Xu Yilun wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> The spi-altera driver was originally written with a 32
> bit processor, where sizeof(unsigned long) is 4.  On a
> 64 bit processor sizeof(unsigned long) is 8.  Change the structure
> member to u32 to match the actual size of the control
> register.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---

You've not provided a Signed-off-by for this, I can't do anything with
it.  For details on what Signed-off-by means and why it's important
please see Documentation/process/submitting-patches.rst.

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7iD6cACgkQJNaLcl1U
h9DmFQf+MF+WXsXCFsAfGFGJ1jFKWqFKkoRuV75/8RMHj4RvGzpz+qi9amx3/XB4
rwaDRe2KGuRagCKXty2M3m6Pmxz40YaVa/u1TXSTpNcInSqNJfLdicBH2c0ekJwM
eeMtXlBR8+/2D+i0nmf0mZedynI9VhlTS7ro8bHiDEoTKDXS2TiqQmx+AzR0siIQ
4BAXoYyFbgH66MJHUBg9+coggkvUNVl+BtoluzGuYVGkbr5ekFyjG57PFPwQ6CkI
UI2IU48U2hZkB2RZtECWFDApxHwrYcfcnXBediZbJ6ZXIf+bR7EZMmCA84V1bI5U
rQWoudzQthh5XCbSRsqytve8fTZVhw==
=mDOl
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--
