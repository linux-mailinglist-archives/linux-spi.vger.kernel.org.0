Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE9F1C53A0
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgEEKu0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 06:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbgEEKu0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 May 2020 06:50:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 187B7206A5;
        Tue,  5 May 2020 10:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588675825;
        bh=jdITTTdJ8QmpA/hQeLQ32qrrNcbG6mdnuVwPPkTiCZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=giJhS33ATK1fGUBlHXvmcG0RNawpGnBV4+z9MjsCc+1nTNdmzXroVtX8YgQGxhwMW
         rBq6nFED7eOp75BP5krzXqliC+LyUxMRjbGNP+GEUMWZoGcRGCnSMuN5+QBFMgP1SK
         ALvr53H4xXuV8T8AfbRBDvtBy3EErXZq5Y8gbGnQ=
Date:   Tue, 5 May 2020 11:50:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v4 1/7] spi: dw: Fix typo in few registers name
Message-ID: <20200505105022.GA10294@sirena.org.uk>
References: <20200504130246.5135-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200504130246.5135-2-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20200504130246.5135-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Cookie: Yes, but which self do you want to be?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2020 at 09:02:40PM +0800, Wan Ahmad Zainie wrote:
> This patch will fix typo in the register name used in the source code,
> to be consistent with the register name used in the databook.

This doesn't apply against current code, please check and resend.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6xRO4ACgkQJNaLcl1U
h9DrJgf+KU5UUbUm11LyJJxFkCAPIdpC83xNT+OBucZM79m32Q94UzARD26dTcfw
6J4P4oKXss6nFdQzZN+ak4QzPCR0s+j3FrExMuUN0oIkpEwqbBHDnS+oQYHmSrHg
GBe4kjVqACuvGhVseoVKJaVR2IDcJ+RpLoCU8cPl2VCw4n2xp8djlL/Q9MunAvvk
xj8n9h9CA1kiSI98RIFJbCPwCxf/QOGbE4LTyJOlu4V4ft2WS5gzamnmnvU5YsFs
IzFnCv6sgLBHoWWVJhH7WhyaPmlJafPc+PcNx2Yjmdp2/XtRf4K5Xb7dzSdETUIt
IjHkUZS7KG0UVyvJRjFVK7ZUS8cieA==
=OXpU
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
