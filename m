Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4EF157E2
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 05:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfEGDJX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 May 2019 23:09:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57808 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfEGDJX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 May 2019 23:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=khFxpRl02USJUzpyMLkUGZ+tc4b4r8QmCyQqy6hkspo=; b=E3Vwwn1yM8pqViPhHCCH5xb44
        EtiTUyEI+VnmPBbDvA/Fe9PrP4LtTf54h0Zb1KZUDpXNITavN6UIBuU10JHjTuH3divp8d4JFUdOr
        w00hFhLr8Fw8YHs50x5LNrh4f14X5zyg30ibyArpmw3QuivY6oVCJTWSjEKpt7JJQW+qU=;
Received: from [2001:268:c0e6:658d:8f3d:d90b:c4e4:2fdf] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNqTp-0003Yx-1P; Tue, 07 May 2019 03:09:21 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 2127C44000C; Tue,  7 May 2019 04:09:17 +0100 (BST)
Date:   Tue, 7 May 2019 12:09:17 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Message-ID: <20190507030917.GE14916@sirena.org.uk>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
 <CAHk-=whLZMe5kNpNMnhh5oVHFKNv7Um4tBS+rH=kLvM+CWzzxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lXp6bW3Dj4tVIRc6"
Content-Disposition: inline
In-Reply-To: <CAHk-=whLZMe5kNpNMnhh5oVHFKNv7Um4tBS+rH=kLvM+CWzzxw@mail.gmail.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--lXp6bW3Dj4tVIRc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2019 at 07:34:29PM -0700, Linus Torvalds wrote:

> So I think it's just google that still doesn't like sirena.org.uk.
> Iirc, that's happened before, no?

In the past that always looked like it was triggered by some of the
blacklists that basically seem to have a business model that involves
at least partly charging people money for whitelisting and so are
perhaps a little trigger happy when it comes to listing servers.  This
time around I'm not seeing any signs of that happening but I might've
missed some, I don't know if Google stopped using those blacklists or
something.

--lXp6bW3Dj4tVIRc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQ9twACgkQJNaLcl1U
h9DlmAf+PS8WuSqYd3RRA49FxQqSRt+Bp5GM5C0z2IJfoqh0YnlayPl0Eqc2O95h
IiTKzDfw4odLeEzdtFz1gUXK8EXE+22Lv1IhOmu9AZ+/yQKWh1LJNn5XqHMWFY9K
NhPgP+HE9wcr5DRSbjxCiZiUpGyz+guCcXGU2LUOpyWKWO6wMvqiDar8h7GYWtsC
oH+ttNsgHSvIQtSHG74JhykgPcWuHgEDngMtUnteCcvEcQvvO3QbX/hPBYqnTjvG
it6bKiu1FOkBeWKA9xgBzFC7/rjcrOeQPePWkn/Y1lBXo0ep89OpM1Y8kaWJ5pFR
GvyswI4qHc+povDf88hk5ETcW1ux7A==
=NvuY
-----END PGP SIGNATURE-----

--lXp6bW3Dj4tVIRc6--
