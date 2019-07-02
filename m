Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2615D5C8
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 19:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGBR6v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 13:58:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54338 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGBR6v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 13:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zDkkFruDgEc76Kn9IcJqixFSeRcKCWxigGe9KohcN2U=; b=GwqV23bLSCe9nl2kovi6Beruh
        XWNmWAWY74tmwy1n+D07LY3qbRcSD9TCnBBTL0Xb+7yXVAgEm+vm86Nw2ErUFbtxpmGrH2WsxOUGd
        Q6dy4UOM0uBRP/5Sw+QbJmg5SL/iws+4TqZrgIxeADTzs4Fosd8suQ9/XqQcDTU8wNLzo=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiN3C-0002ik-F9; Tue, 02 Jul 2019 17:58:42 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 9D013440046; Tue,  2 Jul 2019 18:58:41 +0100 (BST)
Date:   Tue, 2 Jul 2019 18:58:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        kbuild-all@01.org, linux-spi <linux-spi@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [spi:for-5.3 41/41] drivers/spi/spi-synquacer.c:153:3: error:
 implicit declaration of function 'readsb'; did you mean 'readb'?
Message-ID: <20190702175841.GR2793@sirena.org.uk>
References: <201906042339.gt5sS7Hb%lkp@intel.com>
 <CAHp75VcqTvoSf3-vbH555iY9NNu+fd5bzL0TFxfZEVU3M=Pg2Q@mail.gmail.com>
 <CAHp75VdVKCwwijbQNTqxLaR8k=D2SHRZ=D6pJDaTSVQL=j_Oow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YkilVOb9qhI0mB+X"
Content-Disposition: inline
In-Reply-To: <CAHp75VdVKCwwijbQNTqxLaR8k=D2SHRZ=D6pJDaTSVQL=j_Oow@mail.gmail.com>
X-Cookie: This sentence no verb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--YkilVOb9qhI0mB+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2019 at 08:52:03PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 2, 2019 at 8:50 PM Andy Shevchenko
> > On Tue, Jun 4, 2019 at 6:59 PM kbuild test robot <lkp@intel.com> wrote:

> > It seems false positive.
> > kbuild bot has to be fixed,

> Ah, didn't noticed ALPHA!
> Perhaps,

> depends on !ALPHA (or how is it called?)

> should fix this.

Is that the only architecture that's missing these functions?  If
not it's probably better to have something for the feature (or
have Alpha stub it out like we ended up doing with the DMA stuff
for s390).

--YkilVOb9qhI0mB+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0bm1AACgkQJNaLcl1U
h9AAlwf+PN8S5rp6gTtD75wP6P59+SuK7TFKfzj751DeitLePIiXUws1TomnHq2H
8NB1lFKbB2dxKtUjn+Xno54xZR18Im/Q18zilfkZt95cNeLQR2/tHgGxE31sF1EL
oOGOjNId7GNbrXZd1UIeTnDlwyDEwLRDlnQFUi/8pdDrF04XL0KTYvUZhaHh5gkp
o46IMhpKJEAj0Mxi/igRwxcwLtJS4Le3JgtXl3DrDZLPwt5wkahO8vBpToz20gEz
hjJAX7x7TbXGK/Fp7hulAUf1k9aJ6jjqg+NpCB45Nd5Xvwbd+wxL1i8hfkGtzW4q
Dsh+8v1ss/XHGi+QOwS7jYVxOYmmgQ==
=K7qf
-----END PGP SIGNATURE-----

--YkilVOb9qhI0mB+X--
