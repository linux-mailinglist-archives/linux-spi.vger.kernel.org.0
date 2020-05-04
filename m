Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3E11C3945
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 14:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgEDM0R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 08:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgEDM0R (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 08:26:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE2ED2073B;
        Mon,  4 May 2020 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588595177;
        bh=+loy7BvFNdSB1sfj+Wzdxe+1Q9MQi5pjwen9TPc06GI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=06yZhSQq3epAEx9mGeMma8wTIJpLMSKN9edsr7d1tGmNMf9YI2B4m6mUs//g4s/6o
         iNiIdVAQsixQBnF6M1hq4Km9+Xz8I+8MY7iGDKb+ykNGUDpiu3w7luZud8rQmQuMaG
         9qLJY1tTM4s3fmhAH1dDtShVybvQ6aJTFoq+PHu4=
Date:   Mon, 4 May 2020 13:26:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3 5/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to
 json-schema
Message-ID: <20200504122614.GE5491@sirena.org.uk>
References: <20200504121151.1085-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200504121151.1085-6-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline
In-Reply-To: <20200504121151.1085-6-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Cookie: My life is a patio of fun!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2020 at 08:11:49PM +0800, Wan Ahmad Zainie wrote:
> Convert the Synopsis DesignWare dw-apb-ssi binding to DT schema format
> using json-schema.

The point with reordering everything was to make this the very last
patch in the series after all the new stuff so that adding the new
features and their DT bindings is not held up by the conversion.
Reordering the series alone doesn't really help with this issue, the
DT changes for the feature additions need reworking.

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6wCeUACgkQJNaLcl1U
h9CoAwf/dnVroxV9iRYzPtHEsFbIJHUs2Edp6U7TiwATW+bqlrfIHF2cabrAIfgm
dxS+M4ipV7PNjQs8zAUXvMghFmuBInD80sCSaObliHCzbyJoEH+y6nwezzIG5GfL
qZkfeD7vwP/iavhyPvryzWwEzR7y1f+uRYJx2RJJLnZvNY8OnKYIpS9wmRC/8wHb
sjl5uURlN+YNBQJrCSfD2jwejVSy82U9KPitKsNAojX9mTWKrxJxR38D28xBXM6K
lqTQKIOvaPkhww/p0O4fbyW4TJy09iDVOuaNndih7qo563fNUYlup21fLkHOYG7r
sGinQaAaYoqRXt8pKdfGzesbkHqEyA==
=f7MT
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
