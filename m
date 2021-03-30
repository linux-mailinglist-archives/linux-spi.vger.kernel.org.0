Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54934E73A
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhC3MMn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 08:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231934AbhC3MMh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 30 Mar 2021 08:12:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EE8F61999;
        Tue, 30 Mar 2021 12:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617106356;
        bh=z0+3h7xcvL8q9K5bqyasn5ar1L8Rt2hJsmKKmXHkj2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1cgkb+BWCMku8xQfFIoBhwos0zSAbnDvm8aSu7nma2vcIanIBcxujlZ53W+GJCaP
         n82J9HBP6Kgn9Pt2r/nZ8KqLdpBR25e27pwwTfbtQyAjfHI06ljFOv/J/ivig9kZ5z
         ztf7NgBHloQJMfUiV8QtsK7pzrpHoLaZhME5+UFeT9z1t/qiygZNTqGGyhSAlXgg/r
         1KUTnqdJ1TzIwYIOZIoKFGMczLnnWyBcmf8G6p1LMklqjH/+pKZlvlENb/4705zMZI
         gAgSJO2gYFJjzkjcC8XmFT2ZaEns+o6Y5Jyd93pA0IonmwyzuMOKI8p9EGXRUvkz8O
         2GQgJDq/SDV0Q==
Date:   Tue, 30 Mar 2021 13:12:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "tiantao (H)" <tiantao6@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: davinci: Use of_device_get_match_data() helper
Message-ID: <20210330121225.GC4976@sirena.org.uk>
References: <1617008316-60426-1-git-send-email-tiantao6@hisilicon.com>
 <20210329152157.GB5166@sirena.org.uk>
 <67027863-b52d-ad32-6e17-af5c1d284216@huawei.com>
 <CAOMZO5ArUtHLREuWqKxSrh-SzYtaduWg9gQZqTFjXj9uEkzn9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <CAOMZO5ArUtHLREuWqKxSrh-SzYtaduWg9gQZqTFjXj9uEkzn9g@mail.gmail.com>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 30, 2021 at 08:56:41AM -0300, Fabio Estevam wrote:

> What about doing it like this?

> -       spi_data = (struct davinci_spi_of_data *)match->data;
> +       spi_data = device_get_match_data(&pdev->dev);

Yes, exactly.

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjFagACgkQJNaLcl1U
h9D9ggf/aeu5OMHFPlm3WpVdThSfQ0D1ScrzwJX6Dm251yRurm3ER7n5TTn7k4Jt
cZ0k8TtATx21Fc93lk+ncwMFNT3GCHrM9bq6WrjHN1HTaalpCz1RJAHnJfkkV3vu
vtnCpO/4aCGDK+enkQal5PXve7nV85tU516SlPP8lZPrOQMtE5ED5xMqgOiT2d4Q
aQ9j7NRlK4TSo7LO8+sawpVE8t5jeb6CKpMx6rXXvnt4312PmNsyJwLT3SHrG9xc
heXnYQPfdn8aNLBpqAzQxSomPyIsh33s0qz0jtgRCODGswCAYa7VqPh/TVrRyjYg
TbjQb2bqKhOFg98eXixrg3MwUGqRiA==
=tvfo
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
