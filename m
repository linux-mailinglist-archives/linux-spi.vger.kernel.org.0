Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CEB1628C
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 13:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEGLDy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 07:03:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35360 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfEGLDy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 May 2019 07:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VxO5HXqAUGV48DUVM+11/Wfy8Lwq9a0eGcJIbwEBSr0=; b=pwV9zI+7Gb/AO2irMfgamCo/8
        9SzCfi0XGbTSRPnLjCFuzRY9A/XU77YOhPYnOgUt1FYjqMv367eK6Enk3ZmH2Lcs6/7xkTz3isiGI
        goqe9+c14AroYvA5dSK5VF3Q6Cqbz1kgmBKtOYrZcz6IQUxX5mO8MIUiL9gdtGzHTCqjw=;
Received: from [2001:268:c0e4:c15b:6e1:832c:7bbd:a9e1] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNxt1-0004cv-5v; Tue, 07 May 2019 11:03:51 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 6C5BB44000C; Tue,  7 May 2019 12:03:45 +0100 (BST)
Date:   Tue, 7 May 2019 20:03:45 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Message-ID: <20190507110345.GF14916@sirena.org.uk>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk>
 <20190507030241.GC14916@sirena.org.uk>
 <CAHk-=wi4EJQLoMNd4ptiiZvLy8ZW49pcCy0VQwZt4xhDDqSOjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5yI2NvEZ36o0Huwo"
Content-Disposition: inline
In-Reply-To: <CAHk-=wi4EJQLoMNd4ptiiZvLy8ZW49pcCy0VQwZt4xhDDqSOjw@mail.gmail.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5yI2NvEZ36o0Huwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2019 at 08:13:49PM -0700, Linus Torvalds wrote:
> On Mon, May 6, 2019 at 8:02 PM Mark Brown <broonie@kernel.org> wrote:

> >                    Everything I'm
> > seeing is saying that Google just isn't enthusiastic about domains like
> > kernel.org which is going an issue.

> Well, there are other people who use kernel.org email addresses.  Ingo
> Molnar, Rafael Wysocki, a couple of others.  But you're the one
> getting marked as spam.

I'm not going to search for rule 36 SPI.

> Somebody just hates you. I do end up checking my spam-box regularly,
> so maybe it doesn't matter.

Some spot checks are suggesting that they use gmail as their outbound
relay which I can imagine they'd like but would break some stuff for me
for non-kernel.org mail I think, it'd be a major rework to not inject
stuff via sendmail.

--5yI2NvEZ36o0Huwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzRZg4ACgkQJNaLcl1U
h9CAyQf8DVlvoFWeiTUwpzTQFEIq5Wwp/JRRXMVMhw7sxqeRaOBRVanVtNu8wtKH
ZcDWMjKJnSwyS6aaMJi+mVvWklpvUZoJDWV1WhpTgdPE7GMpA76Iylgp2ykHlaCX
aiHtn/eDeipQQVNN9/AUhmVzph3pOS5QamOfi4QKA9EY7+5xMfiFT1bEPbfi1p58
PykMZ+pbaIWrLFhdo5uRzJdF6AnlyMxsyRVh0JSFTk+E5JoEEMKTM78CfwXH6FIF
Nv0sHzV5bxN6FJrGXRh6BQJM1RSEkUvRIsounFTh7IfSqyNb7aITNXRBoXYPqEQ2
uN7xilb711sEZoay6sh217Saj+5RFA==
=wPfk
-----END PGP SIGNATURE-----

--5yI2NvEZ36o0Huwo--
