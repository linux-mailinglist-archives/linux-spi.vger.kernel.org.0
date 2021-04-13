Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEF435DFC3
	for <lists+linux-spi@lfdr.de>; Tue, 13 Apr 2021 15:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhDMNKV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Apr 2021 09:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231483AbhDMNKU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Apr 2021 09:10:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AA6B60FED;
        Tue, 13 Apr 2021 13:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618319401;
        bh=vvY4tuETc+Xa/tBMGoEIqFLIZ+8YzeuypXqR4OfLAyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELxWVDoMBrAD202t2nHfsmaQKjmghiJ2yY4IgObjsoxp4A/wUUzSx9dT5+6fHgPxN
         P2fmbn5LchzAHvl1R7+nH31yLzzFckwydkiRhPXrtyClsoN6Z8oYl96lh9Cq+9XWEd
         q2oOVYJEnlFkqrE1yuLJf8qCLxhkozXoS6C9w9xQ0mEtUkRPBaP6p3I+oQUOTi98nA
         yFW/zflfLUl8axi6YLMWWUTvcKwr3p4orVIARvXsDnbFrPqU8YQEOOo3ESyZ7cmEeZ
         qVGJ7asAxD1kmOOU0Mpx53SYAsvY5NudwMEtpPeFqVyaZeViiF8QI1bfUyen6U66ad
         3f7t4lu/c4ynA==
Date:   Tue, 13 Apr 2021 14:09:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wei Xu <xuwei5@hisilicon.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangdaode@huawei.com
Subject: Re: [PATCH] spi: SPI_HISI_KUNPENG should depend on ARCH_HISI
Message-ID: <20210413130939.GF5586@sirena.org.uk>
References: <d93934dfdbb4d35e35371517de3b64c144aeb5ef.1618316782.git.geert+renesas@glider.be>
 <20210413124715.GE5586@sirena.org.uk>
 <46a47db2-338e-2ca4-0eac-c2b129ee7b7d@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Content-Disposition: inline
In-Reply-To: <46a47db2-338e-2ca4-0eac-c2b129ee7b7d@huawei.com>
X-Cookie: Shake well before using.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 13, 2021 at 08:59:02PM +0800, Jay Fang wrote:
> On 2021/4/13 20:47, Mark Brown wrote:
> > On Tue, Apr 13, 2021 at 02:27:23PM +0200, Geert Uytterhoeven wrote:

> >> The HiSilicon Kunpeng SPI controller is only present on HiSilicon
> >> Kunpeng SoCs.  Hence add a dependency on ARCH_HISI, to prevent asking
> >> the user about this driver when configuring a kernel without Hisilicon
> >> platform support.

> > Are you *sure* about this?  HiSilicon produce a wide range of SoCs with
> > very diverse target markets, this driver looks like it's for enterprise
> > stuff while most things guarded by that config option look like they're
> > for embedded applications.

> SPI_HISI_KUNPENG does not depend on ARCH_HISI.

Right, but that's what Geert is proposing to change - the question is
does it make sense to do so or not?

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB1mBMACgkQJNaLcl1U
h9BibAf/UGsOeW1w9mT9jPqivXHv0DUWhbNDh4VWXrThIYf7eiLUwjPWWH6fT9hL
XhjtAPDoZyknZByoC3IUCWsOSHFLhcZquBM+10Pto0auYaOvhKwfi0d+KyX9wu2e
IwsgxZ0tlRssUroxZaVyLFjcEW6ExmHmibzCAyD4iM4bUt5NXSsIycmBfO8MnIma
IO0pUYAljaAmlU96cZONUJW6RvD0RDIJbV2RZ52Kof+J5HtPoNeiBTl9uq+mqEpF
jalNdK2F3XyrUjt1McgSSTqs0pVA76fgwDSnGqpaKuL9+ESOMv5EFbIQzmz7FohT
QUFwsNBJf+60ufEcL8KF+uw30Ie7EQ==
=pm6V
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--
