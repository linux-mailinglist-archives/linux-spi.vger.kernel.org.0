Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8D51D5849
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 19:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgEORvE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 13:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEORvD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 13:51:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC86C206D8;
        Fri, 15 May 2020 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589565063;
        bh=tcvAYJHglzwUNfNTWbEPrAeLOSbX+1crX3AKhXvoL5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRzyo3nUmxd8NpKUMnioyB/kziXRo5fJ+uPX0zWb/ZU+Yooi03NiG3naVx/tj//jz
         /mRfY1nzCj0CM2YoShJ9RJmbzLUS/LK2c8IeplSGvGAV2rYJo40Z4qRe/9dGhDZKnR
         qvRDUrGb5N6uiOnVK0MX3E/MNUHZGcXMB2Z5FWY0=
Date:   Fri, 15 May 2020 18:51:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] spi: dw: Clear DMAC register when done or stopped
Message-ID: <20200515175100.GL5066@sirena.org.uk>
References: <20200515174856.1406-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Content-Disposition: inline
In-Reply-To: <20200515174856.1406-1-Sergey.Semin@baikalelectronics.ru>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 08:48:54PM +0300, Serge Semin wrote:

> Acked-by: Mark Brown <broonie@kernel.org>

I didn't ack this but Andy did (or at least the for-5.8 version)?

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+1oMACgkQJNaLcl1U
h9CKggf8DwgS+z/RTKKCOSWkzy5KUqsXHelAyHkx/m4g22mXx2lAUIO/JRtskyqN
bw6XePwD9D3G4HqYStuMKJ9eumQ+sV2/GGkAwwQoPqNhr4RH/Y/W2qVOVHXW7mYy
eNVMr0Vt3Y4NouV5wKo3KVnZ3U7uV9TrHgqT0uDXNJDL6bO+8ZskMDOE6XHzVrA4
DWuTr5cd+f9i05eWrmXazAxREUcnrcXpVr9qhwcplO8NQx99uGQSSiFcnFUJkCN+
9j/6KEvvYscKcmYg/M8FH0tGcLk3ok7T4sxUu+Gvm+F6oW5Ol5ioVVR34o95mhNb
L1U9jBBY4G0VL5LDPX1197nV5qQF8g==
=LKb+
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--
