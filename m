Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2EB35854E
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 15:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhDHNwZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 09:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231617AbhDHNwY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 09:52:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12AC461025;
        Thu,  8 Apr 2021 13:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617889933;
        bh=ItxFtSk9nqYGhm5Le6OfQUe5dITkbn2zcqXE6HXfH9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UrHChY75NG7lRlkxKqveKoPzTwyFQ3kYAFBEwrXz67zYECGGoSh9Vbr/8sp0sY12O
         iPmkUjVuJQgw7Gs1eUC8fOKY33flazzulsYW0Ggty/eHVsGsQfaxk3nd7C7X5wrAz/
         cw/MxI6rVvTPSKg9apq/pP4dR1FqfklP/kaoplABBJ9twAbIGMwjg7JqtcFgwJPEZM
         jxYwHDW67go5xH9Ct1wXuOjepJMkeJKWhouCWNqmeAA4kVIhie+ul8YZak5S7KTYbY
         crMQo/2SJIqb2BnC5/U7YH9ZWo8+LHaDOL3HRopsOjqWvOQAwIK+4MMBlgSa1PzK+u
         UDFOvGXZFW2Dw==
Date:   Thu, 8 Apr 2021 14:51:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-spi@vger.kernel.org, john.garry@huawei.com,
        prime.zeng@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 2/2] spi: hisi-sfv-v3xx: drop unnecessary ACPI_PTR and
 related ifendif protection
Message-ID: <20210408135155.GG4516@sirena.org.uk>
References: <1617881505-51552-1-git-send-email-yangyicong@hisilicon.com>
 <1617881505-51552-3-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7uYPyRQQ5N0D02nI"
Content-Disposition: inline
In-Reply-To: <1617881505-51552-3-git-send-email-yangyicong@hisilicon.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 08, 2021 at 07:31:45PM +0800, Yicong Yang wrote:
> The ACPI_PTR() and related IS_ENABLED(CONFIG_ACPI) protection is
> redundant, so drop them.

The driver supports building without ACPI so are you sure these are
redundant?

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBvCnsACgkQJNaLcl1U
h9BaNAf9GAvFliTYG9MZw++xev+zlfh0agy8qJUMcJrJG+JbNd7hjvRWCkC9cOgU
xHGZHP+kk0wzbPrDKZLA2l9yqFWhAjeCEPo69jdcpkOjJpaMWHxrrxIC9qDCy+fU
nbvcFimYsVtKt+Isx5Yv7dBaTnd7u7WtZq2LIj/Q74EYyKyyATyAqNajynaraJKY
tnVxs/d2Hf7gr2/uwpRulDnWvqAIJd49UPulA6FXW1n6TK7Xh07e1+AxnJg7ivt6
Qo/C/jA5djY6ubl1knN1wdHt5dwNzdelwh6Z94+gfO0t7mZvysTKr9rgLEgMbcyD
9ofuxYA4C7ag+GHnTJ/Edgovh80qSg==
=q2c5
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--
