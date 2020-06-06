Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3207C1F0669
	for <lists+linux-spi@lfdr.de>; Sat,  6 Jun 2020 14:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgFFMKS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 6 Jun 2020 08:10:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43122 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFFMKR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 6 Jun 2020 08:10:17 -0400
X-Greylist: delayed 1977 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jun 2020 08:10:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gG9j/rWX50d9lICYiJXpofBPjJPXKy09kX1GXEzlU8g=; b=Wt68VoaP4+YCMq6/Q/zcrTgo0
        PqKg6CFbjS6i+TNc7MKIhRK3lVoxKABNjasS+HNPfsbNvLHEQemr2Ry7pBRAbSPS5FJEngsCvOOA2
        RIwK0GQs6AnupAXqnxaiSDgGeOeRiuFw995m+amoKH+EQnTdtyFqUHjxsVBgTzsfTxjp4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1jhX8Y-0004V1-4n; Sat, 06 Jun 2020 11:37:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 54140D0660A; Sat,  6 Jun 2020 12:37:16 +0100 (BST)
Date:   Sat, 6 Jun 2020 12:37:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-spi@vger.kernel.org
Subject: Re: spi-oc-tiny.c and microwatt chip select
Message-ID: <20200606113716.GA2055@sirena.org.uk>
References: <f8586b1dde855e5d1d682444949a4cf6e4671482.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <f8586b1dde855e5d1d682444949a4cf6e4671482.camel@kernel.crashing.org>
X-Cookie: You do not have mail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 06, 2020 at 06:50:37PM +1000, Benjamin Herrenschmidt wrote:

> Now as for chip-selects... I could also add some concept of GPIOs,
> write a simple MMIO GPIO controller etc... or I could for now make my
> life easier and send a patch adding an extra register to control chip
> select to spi-oc-tiny.c keyd off a device-tree property (or the
> compatible property) :-)

> Any objection to the "easy/fast" way :-) ?

That sounds fine (I'd go with a different compatible).

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7bf+gACgkQJNaLcl1U
h9D13Qf/YCp1CEfFsqb/HaFMIDmTV2HlXNBMkXAJbiekF3skRvRCTwW211KHmdLU
B0pPY70CtzhE4K83ZcLs8iy7MxqERZUNET21ooNCria1smj1hX2Z7ooFujy/0EkU
5iEzQF0lEv1aht9MHWOqOdOXroXKt4FVUs7/rouDFV6bjUl4jm8JB/+Ps20no7tJ
GbtpJwkaPVdN67xSHweCo/rZjGIna54QGQAlIaVjExfUSn6U1NPFJQLqepmwjIL8
fuWVi0KsJxwLdf5o3RW1OG6qHU5KTkC87/PyeB38QHzngV6V5o9wJ5iGW8Ik6y2i
axvfXU7oZWckGUwvqrRa2bUxyjcdcA==
=LGVl
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
