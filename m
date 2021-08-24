Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1772E3F6342
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 18:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhHXQvD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 12:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232294AbhHXQvB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 12:51:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FBC261183;
        Tue, 24 Aug 2021 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629823817;
        bh=PqWcM2DXGBqdI5G1i+z9Vad05u3WXsmZil2k4r/K1+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Am0xGlRWm4DlvaeTt1E8gmrAXLLRwxeU0tMsInw62CXOcKlbyB0J+xDGND5WV+C/v
         8MN/8Ck47wxynFEzVQ5jcYki9Hua7J3iuH9CZhj2AZFcWz+3cfL50wkC7eECzpYlIE
         gDwHdx2UVxxRokYldJxD5JauDgOFyQXsNeledSXUt9izAegnfuu44k2rlf2yZVTx5u
         0LStKLaUyJk5xP4SgxI7RY6ZFwhodM0pVH4jLx55+niu9W2yT4N7GwX7OexNwfqNRk
         xVPxgqaLKAfUlvV9PyLJJiDx22PTdZIlHxV2LcS6ufxuw+pKEj+QP7DFrn1UFlx8M4
         0uZWA0e5iwJhA==
Date:   Tue, 24 Aug 2021 17:49:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 7/9] spi: amd: Check for idle bus before execute opcode
Message-ID: <20210824164949.GJ4393@sirena.org.uk>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
 <20210824104041.708945-8-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/qIPZgKzMPM+y5U5"
Content-Disposition: inline
In-Reply-To: <20210824104041.708945-8-tanureal@opensource.cirrus.com>
X-Cookie: Sentient plasmoids are a gas.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/qIPZgKzMPM+y5U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 24, 2021 at 11:40:39AM +0100, Lucas Tanure wrote:
> Check if the bus is not in use before starting the transfer
> Also wait after so the READ bytes in the FIFO are ready to
> be copied

This means that we will wait for read to be ready even for write only
operations, as opposed to potentially just absorbing the delay while the
CPU does other stuff.  If we need to wait prior to reading we should do
that in the relevant code.

--/qIPZgKzMPM+y5U5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmElIy0ACgkQJNaLcl1U
h9BVpAf9EgW5aal3kzLoffCA4qyVNqQdAp8Fs8kUL3eu0uyTFQNYSJ18tJkPXRgf
WDOPjBYLzJAiJk0R4k5koZRT5/JvQiqsQRdHxVAVtWpl6qqTFvmMKmU4pzpStIw9
w+bzDAshDBTRAu5F0nlts8i9KM/Mo+gVdjCPJDH+GmO3VTxw1KvZpsGe6ZJ1ATbs
0NMi4qFlYLA0higQ8gTOcrBQzxf/uHdL8HGXdwIqPreZ9guUWuSYaFg0ft7hrHVD
cY4uuwU5gI2+gZkZOCwAjmVU90TMAN9KDZk7O0VbVOS8uDzEwLE2rf0pfjTE8CAn
w92nvXrDo74py3LunUvSLSrTvek28Q==
=QJBt
-----END PGP SIGNATURE-----

--/qIPZgKzMPM+y5U5--
