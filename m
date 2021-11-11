Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3FF44D7A9
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 14:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhKKN7g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 08:59:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233648AbhKKN7b (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 08:59:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A46FD61183;
        Thu, 11 Nov 2021 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636639002;
        bh=6vOseyaNjpyc3RrsnYe5dQcUBdM9qrNIItmf8XBYGTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0kR/ARYirmImP0Ufca60fE2T2tLY/D2p6hLawPFm9nlvztEfcpfTLSDEOB3Ev8oQ
         LHV0I6+BosNwdqyHKU958VaVJhCHsHkX8AkzoDDQij5napZXEteUkVDgQBDsdJ5EXQ
         M7XeCvvKW1ZHzTDD+pQQRMQQP/I/48aBJ9AgmV4GJ4qum4ULXdFMybcAXf1B86Q0/E
         b+1NB/H99Wu9iZiFLJ+vX/NcTN/6RLQoipvCpoj8r06I6sBw4sQycrmE0RSJZsNBIR
         WI8mHcmLWZXZaxLQokOcjbqoGbCy7f2enUbFjClnnB1HX1iJziH6bC+cNDYfZ5Bsbz
         bTD/iQL/NW7NA==
Date:   Thu, 11 Nov 2021 13:56:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     nandhini.srikandan@intel.com
Cc:     fancer.lancer@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, rashmi.a@intel.com
Subject: Re: [PATCH v3 2/5] spi: dw: Add SSTE support for DWC SSI controller
Message-ID: <YY0hFOr0SnDDDuSf@sirena.org.uk>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-3-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2eQA/zqGWyINvOmX"
Content-Disposition: inline
In-Reply-To: <20211111065201.10249-3-nandhini.srikandan@intel.com>
X-Cookie: Teutonic:
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--2eQA/zqGWyINvOmX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 11, 2021 at 02:51:58PM +0800, nandhini.srikandan@intel.com wrot=
e:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
>=20
> Add support for Slave Select Toggle Enable (SSTE) in DWC SSI controller
> via DTS. The slave select line will toggle between consecutive data frame=
s,
> with the serial clock being held to its default value while slave
> select line is high.

This should be controlled by SPI_CS_WORD.

--2eQA/zqGWyINvOmX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGNIRMACgkQJNaLcl1U
h9AXtwf/b2yvopc/rcJwvQhIfY7WzAYCakC0ieVKTp3McpPZt67nMUBnaOqi8LlL
GCjmx1wtgTY6GhWjgaf6Mzmw37P6t74Y/S977Zn5FeeTLDIeuBwlk1etG03lnJBP
ELic6wolkf48XQVRyBu1VfQvUFH3CIh7v449ywdINGrp4zNfq1UzvJ4zIpQ7h/cX
qOY3dxs1NUT6d/hrgV1OVWRH3LhC0XFw/9CtYIbMGpqyjhDp9jc4JDhy0S9vI9x9
BDshR8AibUHzW91nTGY6cpRjqV+5c0XLzSC02kDzO1mkmoxaGDJcjaxnW/jcDGcS
dwp0aqSsmKZcruVfwSJB2/NvPhWa2g==
=8YXG
-----END PGP SIGNATURE-----

--2eQA/zqGWyINvOmX--
