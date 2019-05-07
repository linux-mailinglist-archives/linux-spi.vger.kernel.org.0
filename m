Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD7D15782
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 04:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEGCTB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 May 2019 22:19:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57466 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEGCTB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 May 2019 22:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HJ6HqMU1sPHXWvDxvJW6MISYuiPP8r+D0++57SCHFmI=; b=DUSD2I6furej502T+29FUF5s9
        Ir1MXxFDaIAYjGXu+mv2qZKFhrjjdbNYAzamOBTMyVx+dtcF9Em4yCq/cs+TsitOwz2F4xttFh1gA
        Rw4TL4qm6gewD73gJL2Rc80kPtWf/dSRi5P/pmY585tILEZ5/kQaUm13kBKEl0Tpuqo3s=;
Received: from kd111239185057.au-net.ne.jp ([111.239.185.57] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNph3-0003Pa-85; Tue, 07 May 2019 02:18:57 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 878CA44000C; Tue,  7 May 2019 03:18:53 +0100 (BST)
Date:   Tue, 7 May 2019 11:18:53 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Message-ID: <20190507021853.GY14916@sirena.org.uk>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iwX7oKFvAj2SwWc7"
Content-Disposition: inline
In-Reply-To: <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--iwX7oKFvAj2SwWc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 12:01:44PM -0700, Linus Torvalds wrote:
> Mark,
>  gmail once again hates your emails. Your email ends up as spam, due to
>=20
>     dmarc=3Dfail (p=3DNONE sp=3DNONE dis=3DNONE) header.from=3Dkernel.org

That looks like it's a fail on validation of the kernel.org bit of
things which I have no control over and which purposely doesn't
advertise DKIM stuff in the hope that people will actually be able to
send mail from non-kernel.org mail servers.  I'm really unsure why
that's failing at all, there's no policy for kernel.org to fail.

> but it has a DKIM signature for sirena.org.uk:
>=20
>     DKIM-Signature: v=3D1; a=3Drsa-sha256; q=3Ddns/txt; c=3Drelaxed/relax=
ed;
> d=3Dsirena.org.uk; ...

which should match the envelope sender.

As far as I can tell Google is going to be unhappy no matter what unless
I use their services - if there's DKIM records it's not going to like
that the from is from kernel.org and if I don't have DKIM records then
it's not going to like that either and I'll be more vulnerable to the
blacklists that try to extort money out of people for permanent
delisting.

Possibly it's not actually anything to do with the DKIM and it's just
upset that I'm travelling and so the mail was injected from a mobile
broadband IP in Japan which doesn't match up with the .uk domain.

--iwX7oKFvAj2SwWc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQ6woACgkQJNaLcl1U
h9CVoQf/VViEns1FF+b1XU9wV7gcbUx9zYS/VA3JSRel7Z5EwW95p98WYkw8RG3k
BKLav1zV87dO+uCB2jhW9QZX6M1HC9k09MR3W5hlRPmh9WEYfNdTmhBxAad7MFje
XpYC2lrYAoBeOx4Lf0GwsjbLERG4D4t9zc424sazqj6spnnwIMlgw9LlU8oYpuqJ
CdyWWs3tTPrMhfMo7KyN52/X0xAxuvdNn/ENDgEOlUC49msa/+mAnsgsOKRL4kAd
A7omKODjAzUUXDxPAkjkmtvdtZc5SwdvJ4OJ57OcKtOZkQp6Qjjo6DA6cG3V6Hby
dt2hGyITxKXWX5i1WsjCtLuHrBzWIQ==
=AaKX
-----END PGP SIGNATURE-----

--iwX7oKFvAj2SwWc7--
