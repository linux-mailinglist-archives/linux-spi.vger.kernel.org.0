Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364722740D4
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 13:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIVLas (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 07:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgIVLas (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Sep 2020 07:30:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B60221EB;
        Tue, 22 Sep 2020 11:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600774247;
        bh=kkHMiTnA8Nd+aNMKB4+cFh6WyDZVD2UyQqEdCRsNUHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dbq8X/tmUq2LMM968Bp1Ys6XHzFCqQ8pvadivZlll9wmipSA3kAcm/4GO4Bsr71Kq
         EpL+rhPpGlnjHlpy4a1IJiTlIBCS5Mbwn2XWPmvhV6Cb3W3I6qmOen+N79zxQUcaS+
         YzzrL5PWJB1Itu+C3gjJU75AxcJGeyXmXIgeVPTg=
Date:   Tue, 22 Sep 2020 12:29:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoud@xilinx.com, nagasure@xilinx.com
Subject: Re: [PATCH 1/3] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
Message-ID: <20200922112954.GQ4792@sirena.org.uk>
References: <20200909152708.2767-1-amit.kumar-mahapatra@xilinx.com>
 <20200909152708.2767-2-amit.kumar-mahapatra@xilinx.com>
 <20200917172819.GA50407@sirena.org.uk>
 <83866279-52f2-6c85-40b4-e0b78ad2d713@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0fZkDq/H4AmqaB8D"
Content-Disposition: inline
In-Reply-To: <83866279-52f2-6c85-40b4-e0b78ad2d713@xilinx.com>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--0fZkDq/H4AmqaB8D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 01:24:18PM +0200, Michal Simek wrote:

> for-next/for-linus/for-5.10 and I can't see any issue with applying
> these patches.
> Can you please let us know if what tree/branch should be used?

In the first instance I'll try to apply against for-5.10.

--0fZkDq/H4AmqaB8D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9p4DEACgkQJNaLcl1U
h9A50wf+N6ohMbgVl81zvY1qCcAAWyJl1teB1/HySXDUtt5pZaNWpYqztgcRnywQ
sKE/A1/XQqwEHoEhDaqaI29/y3yGpu9RX4CH1AYr5oh6KGVWiYjRZXij7uraAzFK
lZ4ZhUIpJXL/FLDtfZ5JyajRA4QmqgE4dYqowJUr+6tVLAJENaODC2zk/Up1U+Uj
te7foQrDbC1nt4sJ/oSVXRpksdAI798WcatoH4DeeunRRYez3nVqgmkbsk8PCM0V
4YC/R9sQIvYlP8KpgLL3gZew1/jEtPZaJFr5j+0dUSZRbR30HyAZPRaQA3135bZm
7LZMPNPclFt4EfflmRkHnKsspoPHIw==
=1N3X
-----END PGP SIGNATURE-----

--0fZkDq/H4AmqaB8D--
