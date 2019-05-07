Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B75157DD
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 05:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfEGDCy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 May 2019 23:02:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46904 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfEGDCx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 May 2019 23:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4paIWQmsel3Y1u+b/28Ss2581piDqiZSgAIYtUzM7Pk=; b=s6DSX818nzoQCucd5HWaqY88g
        +dyKQqwL3AM1G5pImJIJRiAc2F3EtGfdza1YdjhucvIrYo+6ah2Tgl6DjZUjKEjAWYwabWvCZFfPX
        Fk2j7Eg+mkLHEeQDkcQtbKpOby4BwPWu7cWY/mVfzbVCDgpl6uuZAa7AmS3mJsF1dMsPo=;
Received: from [2001:268:c0e6:658d:8f3d:d90b:c4e4:2fdf] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNqNW-0003Xx-GD; Tue, 07 May 2019 03:02:50 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 7898244000C; Tue,  7 May 2019 04:02:41 +0100 (BST)
Date:   Tue, 7 May 2019 12:02:41 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Message-ID: <20190507030241.GC14916@sirena.org.uk>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sAD49wDt4u2G8n56"
Content-Disposition: inline
In-Reply-To: <20190507021853.GY14916@sirena.org.uk>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sAD49wDt4u2G8n56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 11:18:53AM +0900, Mark Brown wrote:

> Possibly it's not actually anything to do with the DKIM and it's just
> upset that I'm travelling and so the mail was injected from a mobile
> broadband IP in Japan which doesn't match up with the .uk domain.

I've tried sending equivalent mail to one of my own Google accounts and
it gets delivered, though I do see the dmarc=fail bit in the headers.
The full header there is for a newer spec called ARC that builds even
more stuff on top of DKIM and SPF.

ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=gYHUGKmm;
       spf=pass (google.com: best guess record for domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org

which suggests it's adding some guesswork in there on top of what's
explicitly in there for SPF (though that's not causing trouble as it
worked out that the mail is OK).  The fact that this got through OK and
all the NONEs there suggest that they are to at least some extent doing
the right thing with the lack of any advertised policies for kernel.org,
either something else about the message or your incoming mail is causing
the spam filtering.

Unfortunately I can't immediately see any exim stuff for ARC (and I
don't know that there's anything there that could really help) and I
can't do DKIM for kernel.org (for good reasons), the only thing I can
think of is to disable signing of the From: and hope Google just stop
trying to validate it but that doesn't seem ideal.  Everything I'm
seeing is saying that Google just isn't enthusiastic about domains like
kernel.org which is going an issue.

Not really sure what I can do here...

--sAD49wDt4u2G8n56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQ9VAACgkQJNaLcl1U
h9BOEQf/XUeAJbQXmzLfhaLbUCZgEuFkUF7T9cjQr+zWPMTXqNgX3iOEJ4IXeHYL
YvFV9hTskDTB7ARMObAWb0cLtsVrHLs57xNabk9kAb096s3T7YhGede479XCa92M
6aBWrfTlg//NeRIRKSoQWaGO14CAlSaK9/R/zzoOS5gdehx67fjQmGGP0wHTprdK
8NxYWNQP2+Cu/u49mNTdfcz3mcAm6HcVO4Ir6ta2EWW+ZwvcytwWuoZ7LYQWtJHz
RanYDzDCqUs+preuymnOWIpyM9RLdi6AWv6CH8wx6Luw/HhPcOq+tik1vKWK2B7U
CTKgkKREbUWPj+FDW/VfaX/CBeut/A==
=VDXp
-----END PGP SIGNATURE-----

--sAD49wDt4u2G8n56--
