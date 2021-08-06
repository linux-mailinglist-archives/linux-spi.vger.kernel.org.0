Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3B73E202D
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 02:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbhHFAsX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Aug 2021 20:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229735AbhHFAsW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Aug 2021 20:48:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58E4F61179;
        Fri,  6 Aug 2021 00:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628210887;
        bh=EQVYbPRoxJQ4RDDnm9QlLivnidLNRB1ZkU1u4/jsb40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVRLF7TmG9WBy7/D1W7ZK6BhAarkTioUDyPc2Fg0Vf3OY+k/JxHfd0XBkRYQId1el
         gn/Y2xiar/5/FvluK/+7C1Tc1l+yPxHnei2CWCIp0gLKf29ca9j/0A7bzu5D93i9HM
         VEsGVT1+b2XUdQEhfLye6ANb+3njgeRe8RSbNii/tpq5TqUvrTL4XBQEr0zr/s/xU+
         l4xGBJmksCVaDeil1jrNL6paz6nxDiRhoHHRbii3355dZhcHKRtm6OvuAB1etisJHm
         xsxd0t8+rH5iP7hN+RnET/yb2dtBMc9CJ5Bp53G5gdqvA9CUKHwWCvXxMYuvgVUilH
         xlQpTXIPYGQsQ==
Date:   Fri, 6 Aug 2021 01:47:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "quanyang.wang" <quanyang.wang@windriver.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-zynq-qspi: use wait_for_completion_timeout to
 make zynq_qspi_exec_mem_op not interruptible
Message-ID: <20210806004751.GU26252@sirena.org.uk>
References: <20210730031753.1317917-1-quanyang.wang@windriver.com>
 <e639bfc1-ce6f-c5d3-6412-70d03706127d@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="msgLTjjeumHWYklJ"
Content-Disposition: inline
In-Reply-To: <e639bfc1-ce6f-c5d3-6412-70d03706127d@windriver.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--msgLTjjeumHWYklJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 06, 2021 at 08:41:41AM +0800, quanyang.wang wrote:
> ping.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--msgLTjjeumHWYklJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEMhrcACgkQJNaLcl1U
h9BAkQf/XzqzDaswEkmzzfYPCGH2UHyvags44BukN9JEi3TbVUfxPl0fiGJPX3Kw
60fLwAkhvh1q9aXtDwkb4CdUod2mXFQDIpONil6EZrTlx8TQ2WFJ/VrAnNNXAQ3I
KiJNUlF7SIogdvLfMbAgN9F7HusIjSCL394xe2QfgvpisXSJGwRcjgXHqKFY8cEI
33m/2bVvGqThj0YS8F87/lSFbEmnnvZE1/tcc7kS0l1y/aiZ5pKwCo570GdYSdhr
HmPXGBSKKKCDg3VxKc2BH4zMZbbkwtR9DpvrNvr5gKFqUw/nkocgvQppu2QsJbA7
VDcEWDEkn2ebe5v24TZFr/WNAueh8w==
=CSVE
-----END PGP SIGNATURE-----

--msgLTjjeumHWYklJ--
