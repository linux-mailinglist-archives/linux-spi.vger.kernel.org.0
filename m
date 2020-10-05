Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B4C283979
	for <lists+linux-spi@lfdr.de>; Mon,  5 Oct 2020 17:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgJEPZh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Oct 2020 11:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgJEPZh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 5 Oct 2020 11:25:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C7AE207BC;
        Mon,  5 Oct 2020 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601911537;
        bh=/0vJ0HMwCSkrTpW5w34rc3yXEgUT3MBnMmLGptxX8uM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qy98+eb/pll06WRY9c4Hdk9tjpntJ5pyAruG18eik5s0/fQE1SlJMSZvfQsdpUPpk
         0BZSMPkAh3tXs21TzpDU7l8N6VqBiCGPOo17y4Q1JRvtEUq2RgVZhCJjYiJpuPq5+O
         q6tCRQnpcbbxDs3TVukuSm+tWILbREc8hd2aZPWE=
Date:   Mon, 5 Oct 2020 16:24:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/4] spi: spi-mtk-nor: use dma_alloc_coherent() for
 bounce buffer
Message-ID: <20201005152433.GA48857@sirena.org.uk>
References: <20200929073755.3741416-1-ikjn@chromium.org>
 <20200929153320.v4.2.I06cb65401ab5ad63ea30c4788d26633928d80f38@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20200929153320.v4.2.I06cb65401ab5ad63ea30c4788d26633928d80f38@changeid>
X-Cookie: Check here if tax deductible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2020 at 03:37:53PM +0800, Ikjoon Jang wrote:
> Use dma_alloc_coherent() for bounce buffer instead of kmalloc() to
> make sure the bounce buffer to be allocated within its DMAable range.

This doesn't apply against current code, please check and resend.

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl97OrAACgkQJNaLcl1U
h9AT1wf9ESrZU04ckhFQ4aOa5o4YIQYd+068sqPdWJvoXIuVHFya+smMWADlWXXo
jRD77fQGo8++5zgtAv3JYvJ86yal8Y9vrg3ZCZmn6Jh4pJTMQx7pJkLABTffTU+T
7FTBAo5l1uZLrxr2BsR4ZKrkmANWBpVAtjscoz5zm5goUYTuDDspW7MzKoHEgjP+
0BBEzpKvRYA3Ixn0KX9KCtX2U6emSR+nIGOht9TjD3+XFBCSW7OSBlwsLDq7DH5I
3+xFFzP2qHz+fE2pfYjpiIAFJrDVGD8vSi83HtU6/9NxDTzUfAVT3SIPZUdSKDXg
X4F4jfG1IUlJnb59tQOD7o/Bwib1Pg==
=AQQn
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
