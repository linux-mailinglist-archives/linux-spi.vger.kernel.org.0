Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91261373B8B
	for <lists+linux-spi@lfdr.de>; Wed,  5 May 2021 14:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhEEMkO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 May 2021 08:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhEEMkN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 May 2021 08:40:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2090608FE;
        Wed,  5 May 2021 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620218357;
        bh=54dU6dSYiEntoujKHzkvNojxOEYRfhM+A67m4LrvzSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIQ0HktfI4mtijUjcT18t4NFvBX/GgxkwzVxYeUvF3KexwRxv6BrPpu1mou61loSD
         9Z7i5Wyy7nCRDpIsQhSGT2sZ7lqkoOM1ptUXJAjJKueyMRzS6hmwfOytBfY6L1kIbl
         DmR/GiIyBrL13mLFTaWddeaMs9+33g69YjfiVTwOtHRPLObh0aStidVqMj7MQGXeW6
         XJa/v7ATnPoyKYOyLnxdpkBS1DtQ5zAFqvtbWt16FcmPeD4PDFG/l7GeTB5Dq3GsSa
         +pKdmo55rlI0Y6Wx7UmMd7BoBDq1XaJRYrllaZ8t7FvGROeoAcGLCrrqYWbJNK2ceQ
         QZe4ZOGeAGi+w==
Date:   Wed, 5 May 2021 13:38:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] spi: Don't have controller clean up spi device before
 driver unbind
Message-ID: <20210505123840.GA4541@sirena.org.uk>
References: <20210505031416.30128-1-saravanak@google.com>
 <20210505054838.GA22603@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20210505054838.GA22603@wunner.de>
X-Cookie: Please ignore previous fortune.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 05, 2021 at 07:48:38AM +0200, Lukas Wunner wrote:

> As I've written yesterday, calling spi_cleanup() in
> spi_unregister_device() should be fine if you move it to the end
> of the function, but before the final put_device().  For that,
> you need to open code the calls to device_del() and put_device()
> that happen in device_unregister() so far.

Indeed.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCSkdAACgkQJNaLcl1U
h9C8JQf+NaV0aho4M5PbriQYD/9COSKhGGUdlZypLj/s+ZRCIRXjryamrFajafek
YqpStp4it+gRDz7Pg8W2vWA0QpvzA+O/KWM5DQJ+hwgUqiVffe5N8zIKhdmwFsTB
hUwfuZ4Eg7TWC7KjK/0yuWn3+CH5+st5eqYO9aYhtEYV3POTVIxJajUgMcihOfpp
bWDnNOfG05OkVIlABAoGslHpcSOigrl3YcQAKneIGaQXH8Plh/AGU5ryRNNAGSyw
l+5lMmea74lJdfjs53bg6Z951S1VyTB4AJeeGRyaB5Squbj4+ieAdj5VqQaP9qwi
DUeape1mbA8Gz/8ASfCIMnnHML9zRw==
=CEzc
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
