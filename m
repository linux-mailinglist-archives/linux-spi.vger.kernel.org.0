Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F880228CC7
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 01:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgGUXpM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 19:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgGUXpL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Jul 2020 19:45:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9182077D;
        Tue, 21 Jul 2020 23:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595375111;
        bh=vNftebKTkLY/PaLWDa1NczN0BADcuqUpTe6BpSEV4N8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HxLDp8lVuLRUyBfdjW7oA5QrB2FpdQwhKf4zR6aWIqr71bUfr8ZPp/IJ2kvFTwYf
         buGOYSLTFpMsks1JoE3U2wdEvIkZ+ew4QCmPylDsB5OA3erwlV1KPF4Qg0rEFzAgaA
         I+yJ8GAt/q3LGPKUMgccQD1ImgMTb06uY1HrmUpk=
Date:   Wed, 22 Jul 2020 00:44:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] spi: lpspi: add NULL check when probe device
Message-ID: <20200721234458.GA16769@sirena.org.uk>
References: <20200714075251.12777-1-xiaoning.wang@nxp.com>
 <20200714075251.12777-3-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20200714075251.12777-3-xiaoning.wang@nxp.com>
X-Cookie: Knowledge is power.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2020 at 03:52:48PM +0800, Clark Wang wrote:
> Add a NULL check for device node and lpspi_platform_info when lpspi
> device probe.

This has build problems, I guess there's been a context change that's
caused issues along with causing the later patches to not apply:

/mnt/kernel/drivers/spi/spi-fsl-lpspi.c: In function 'fsl_lpspi_probe':
/mnt/kernel/drivers/spi/spi-fsl-lpspi.c:824:7: error: 'np' undeclared (first use in this function); did you mean 'up'?
  if (!np && !lpspi_platform_info) {
       ^~
       up
/mnt/kernel/drivers/spi/spi-fsl-lpspi.c:824:7: note: each undeclared identifier is reported only once for each function it appears in
/mnt/kernel/drivers/spi/spi-fsl-lpspi.c:824:14: error: 'lpspi_platform_info' undeclared (first use in this function); did you mean 'spi_board_info'?
  if (!np && !lpspi_platform_info) {
              ^~~~~~~~~~~~~~~~~~~
              spi_board_info

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8XffkACgkQJNaLcl1U
h9A0Mwf/dMlzfr1HWRvFHS+X/pn/UO1qlC/rqX0b3blAFFAKcPfOzkJbCG73V5kv
rbbvGx+Hrq3EO7bX3EgPLmY4expMyV6QZ4XhuhvpBqOoQ9ouxULVbpSdO9TQWkGN
9UTjIVq7nMX64In+0v3qYmn/FYGMlZhXQi9wuS6rwzKH0OHBGOcawtKPo2D9JeD6
Y2DnmiS7v+/VrVd1FB6VZ8O+f4HIzIk+5HdiPAMw2ugzx1Vf7xqc2a8XF/YZQLtC
OtNodZ+5fx24aBYvxjdI9UaDQENfjxgu0T0iq+kcla3Qjs+jGPLhns1x8ng2W+Fo
8ai/HRqPTd3/fStOm4HxNRzOLARJYQ==
=WCQf
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
