Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606F826E2A5
	for <lists+linux-spi@lfdr.de>; Thu, 17 Sep 2020 19:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgIQRkp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Sep 2020 13:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgIQRka (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Sep 2020 13:40:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF749221EE;
        Thu, 17 Sep 2020 17:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600363750;
        bh=JRzJocDVRwRz8Eu7zhneKPg+A1fbAeosEYJUkbhaBzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFiBEHdt6If6PKA0rqcooqTP+SeSJY5c8XgyoeWyjpMLTP9ITzjeL29Okkkh4625r
         h0+yAD2VCb3c+yjFf2lC4GWkBrBZvQfaTP3Llk87hOHngzxqDqyjR/gJOk4kDThAVn
         8VwkILTsfxGRxDjFxGbyW1q3s8HPaB03plBy/TZI=
Date:   Thu, 17 Sep 2020 18:28:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, sgoud@xilinx.com, nagasure@xilinx.com
Subject: Re: [PATCH 1/3] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
Message-ID: <20200917172819.GA50407@sirena.org.uk>
References: <20200909152708.2767-1-amit.kumar-mahapatra@xilinx.com>
 <20200909152708.2767-2-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20200909152708.2767-2-amit.kumar-mahapatra@xilinx.com>
X-Cookie: "Yo baby yo baby yo."
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 09, 2020 at 09:27:06AM -0600, Amit Kumar Mahapatra wrote:
> Fix kernel-doc warnings in ZynqMP qspi driver file.

This doesn't apply against current code, please check and resend.

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9jnLMACgkQJNaLcl1U
h9C4IQf/d5SDj8OiR48Iw4Rb+CIX+uNuskYXsPqB17uibjxOIvEBm3RZt8awHK4w
JsVpSG6W3NzmPl4erAmIzg/5z2dstothRMBZWyBlL1uuIZAaCOKtipa708Q/p3K0
WbmYKRiHwpSiA5Zer9XWkCPxvgAXzLFQf9W1Mw5v6i4ZTCR9DQLkoZ37crnFGsyw
DdTYp63iRa21wamnFLqnIfH30kKqS4zAC4JCDHMif/re0XDHVM+uoTJtu/yCGa8r
qJtJaluvErNoQbZLCYN32xiZIGphDFXoAwzSKJxNdAs3HgkNW0E6frqv6tVV2zoU
r7mVJ4IKObDnw/Ig6be8t5V1tVC2hA==
=4afI
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
