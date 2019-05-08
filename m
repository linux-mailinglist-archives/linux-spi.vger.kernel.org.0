Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F30175FA
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 12:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfEHKay (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 06:30:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53660 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfEHKay (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 06:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6zKEjeMM16COzxVFPj2qwKD0N14L6e+VxtnDZD3acEk=; b=fsCXGVb8UjYuCmhgNP7K1zHLd
        XQLDXNv3RxBAkaOgfNmOTLZsvAUPjkfOF6eop4tj/Sw0t8fN0zANvMNm0Os97csT071qPQCcbxjxz
        QFu63GtwVc3M+mGWYER+g9Gzk3SzioV69NrT/tjI+GudYlyI+v7RMMXF16qqA97K1voaY=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOJqc-0007sb-Q7; Wed, 08 May 2019 10:30:51 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id B7E6144000C; Wed,  8 May 2019 11:27:36 +0100 (BST)
Date:   Wed, 8 May 2019 19:27:36 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Message-ID: <20190508102736.GO14916@sirena.org.uk>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
 <20190507030241.GC14916@sirena.org.uk>
 <CAHk-=wi4EJQLoMNd4ptiiZvLy8ZW49pcCy0VQwZt4xhDDqSOjw@mail.gmail.com>
 <20190507110345.GF14916@sirena.org.uk>
 <20190507120730.5ylk6v4yvzxuzqld@earth.universe>
 <20190508060936.GH14916@sirena.org.uk>
 <20190508101301.lxwt4e6eziujdfit@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N8EXF1oXVIanxtk/"
Content-Disposition: inline
In-Reply-To: <20190508101301.lxwt4e6eziujdfit@earth.universe>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--N8EXF1oXVIanxtk/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 12:13:01PM +0200, Sebastian Reichel wrote:
> On Wed, May 08, 2019 at 03:09:36PM +0900, Mark Brown wrote:

> > I'd have to send all mail out via kernel.org to do that, or persuade a
> > MTA to route mail differently based on contents which seems interesting
> > - I inject most of my mail via /usr/sbin/sendmail rather than SMTP
> > (including a bunch of scripts).

> I have a locally installed postfix in sender dependent relay
> configuration, which does that for me:

> http://www.postfix.org/SOHO_README.html#client_sasl_sender

I'm using exim on the central relay box which is much more painful to
configure than postfix sadly (one of these days I'll get round to
converting to Postfix since I prefer it and already use it on my client
boxes but the DKIM stuff is painful enough and there's enough stuff
using the box that it'll require me to actually sit down properly to do
something as substantial as cutting over MTAs).  It's also not clear to
me that Postfix can be configured based on From rather than envelope
sender, I have used the configuration options you're pointing at for
envelope senders before but at least at that time Postfix didn't support
setting envelope sender via /usr/sbin/sendmail.

--N8EXF1oXVIanxtk/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSrxcACgkQJNaLcl1U
h9ApdQgAgd+Tex6oCuaxwPfVHqJlxF6U9IdZ5e/tN4kqyoqXrVHGYgd8Ty++q8gD
MyNkEy2rO+N8SzvfTIlffM6E4ascQA8lXu/iSyNzeuDI12tsc0N5TxixRSDZgVWz
OQ/9hGdtUvxUipxH/lF7upTNtKEH0lylrP3iSNrnXiED3sUY4niyt+yGukCLS00T
q9gXwFNo9Dr0LoPmQ3wEwDfF+AktWDZtDlskljh709qztoeJPOzpIWPdlBgTXp+5
71u0dUMk4PQJavsDy19LYBvCH1doaTe1HLt0orwjvM5ROyJu1iYhjdWjyyTPhZ08
xuD4PXII2siLA1yJ3UIDPZjois9prg==
=QGT7
-----END PGP SIGNATURE-----

--N8EXF1oXVIanxtk/--
