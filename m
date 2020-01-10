Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258E1136EF6
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2020 15:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgAJOH3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jan 2020 09:07:29 -0500
Received: from foss.arm.com ([217.140.110.172]:45060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgAJOH3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Jan 2020 09:07:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CCD3328;
        Fri, 10 Jan 2020 06:07:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05E883F534;
        Fri, 10 Jan 2020 06:07:27 -0800 (PST)
Date:   Fri, 10 Jan 2020 14:07:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        xuejiancheng@hisilicon.com, fengsheng5@huawei.com,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Message-ID: <20200110140726.GB5889@sirena.org.uk>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
X-Cookie: A little pain never hurt anyone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 10, 2020 at 11:55:37AM +0000, John Garry wrote:

> I will note that PRP0001+"jedec,spi-nor" compatible DSD seems to be the
> defacto method to describe the SPI NOR-compat part for ACPI - that's what
> I'm using. We could add properties there, but that seems improper.

OK, so that's just reusing the DT binding in which case everything
that's valid for the DT binding should also be valid for ACPI - I
thought that actually worked automatically without you having to do
anything in the code but ICBW.

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4YhR0ACgkQJNaLcl1U
h9CHqQf/fT6tkZc5rjRON7HtRrGsmNaUJN8ElUARXmp+zfbAka7ozgwC4DENqjOK
I9Of3xZsrE2VlGeIpXS7KAkjdbCOvoRmMhChM1VH7yF5lxz+AEOjWwKZlfXpurjM
RxElFm6u7Z9iiP0PDww9K+yEXS91EbxPFi7UvRL783aV3VJORsP9aY7ewmXSb9UP
E3SLtAQQMhQrwrMS7jGd3tex9ik6YdXOqChEsaScE7GDjvGUDNS54yYXK1lfCPHi
yKq7WymCtC2pgoVQxmQloHBzk82z6wMSwVp+DowO1eM3qbdevM6UVKniyJLDT5pN
EEDzuxOjUXvHls2lGkGX9YdKUFFLhw==
=lFqO
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
