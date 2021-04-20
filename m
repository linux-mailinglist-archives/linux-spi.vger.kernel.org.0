Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238F3365B94
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhDTO5P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 10:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232507AbhDTO5P (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 10:57:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB6AE613C9;
        Tue, 20 Apr 2021 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618930603;
        bh=OjpAHxYSjz1nKguIwOjvjwG797cyGyxRd8zj1GA8A6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSi1gD4gRZii1uwZWu3lWIdjF68NqC0N2ErMHIfJSr9B2M4LxAR1tFLqHcXAyH8XU
         qAcZN6Kzx0V82cKA4OzsAJHwDtTcrETA5zvlGn5DS2JRyaSYrVQ3OmVUpQyAXHqgT4
         ZnRUXmA6fO5Uzs+Ab5XFMjtlnMCN06fX9Yh3rb79UZZdCtQGgMSHV0skPci6Rn8ED+
         hTWyuZAvL3hfWxnIpnIHO/8n5Hxw4AQFdwL4MDTL+gW1igYuXWA+/ZxFk5uETX9gSt
         zTKNmiLDuRWcyOyYUOYXWxe9OvEmBBpdtcjvCX/GmId605oKo4wqNs4DeiHpyVOAb1
         pt3Ol4pRbgaug==
Date:   Tue, 20 Apr 2021 15:56:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] spi: Avoid potential UB when counting unused
 native CSs
Message-ID: <20210420145616.GC6073@sirena.org.uk>
References: <20210420141004.59936-1-andriy.shevchenko@linux.intel.com>
 <20210420141004.59936-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <20210420141004.59936-2-andriy.shevchenko@linux.intel.com>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 20, 2021 at 05:10:04PM +0300, Andy Shevchenko wrote:
> ffz(), that has been used to count unused native CSs, might produce UB

Bit of an IA there...

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB+65AACgkQJNaLcl1U
h9AJgQf/agvyEji+YtnLOMfyI4yiAeKBCbuq7ii0u6jLgUpgJBBA0cxRzNrUWCwt
GPZyz+mbEm8XuHjviwgCDbRIC5Hr1r2HzDzD1LLPn1UmEwVC4MBJ/uY4x9pRa5gJ
h/mfgt9U9k8mQzVIPwRq/ZWPAAXLA9uUf05a+sPmfgafrMcnAlDx+uiDZz0mRvZd
Qd9B5qVd2sPhbgoYNwrARx8xMho0y8JryRVg5H3XIFmDWZa2bl5Wvjb42TEBiOXm
Y6SIXzf0cLhWVqEf3pSOYA+DIfCYNY2otIrin7AaGYofLBqCC3J1gVgkP0zCIm1a
XItdzeRynrjho8XN/kGghM2AklaDDg==
=CmGw
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
