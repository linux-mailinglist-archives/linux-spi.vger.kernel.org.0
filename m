Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51AEE071A
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2019 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbfJVPNN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Oct 2019 11:13:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59768 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbfJVPNM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Oct 2019 11:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TxtgKlRlvJ6grgDenPVmjfx8ccV2Inu8uAih6cB/GoU=; b=S1RrkOLuOWiNOGm9wWrKFFIua
        acDjxr7vVVnztTeRoIMQUpU74ghS9JH0o5BRj9pg+p/LVWMsobTSfexGsqQAhnX00g9ZDkP4sxuOZ
        xVQlwA6OO8QUUG6JJ69pkm4BkYxxTcsri48KYja0TCFx6sMvokXuDpj2vzcblKV+xP3gA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMvqQ-0006t6-Hy; Tue, 22 Oct 2019 15:13:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B68802743259; Tue, 22 Oct 2019 16:13:09 +0100 (BST)
Date:   Tue, 22 Oct 2019 16:13:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: xilinx: Add DT support for selecting transfer word
 width
Message-ID: <20191022151309.GG5554@sirena.co.uk>
References: <20191022090007.15147-1-alvaro.gamez@hazent.com>
 <20191022102007.GA5554@sirena.co.uk>
 <20191022102859.GA1928@salem.gmr.ssr.upm.es>
 <CAMuHMdWavg_50DrKnSa5K9j4oxN5gn0RWGhS2yr42x6okHvLoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zrag5V6pnZGjLKiw"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWavg_50DrKnSa5K9j4oxN5gn0RWGhS2yr42x6okHvLoQ@mail.gmail.com>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2019 at 03:03:18PM +0200, Geert Uytterhoeven wrote:

> Is this "spi-bits-per-word" a property of the SPI slave device?
> If yes, it may be better to hardcode it in the SPI slave device driver,
> as it is fixed for that type of SPI slave.

> If not, perhaps I'm misunderstanding the purpose.

It most likely is.

> > AXI Quad SPI core in a HDL design that's exactly one of the options you can
> > provide. In fact, in the board I'm working with right now, I'm instantiating
> > two SPI cores, one of them with 8 bits per word but the other one requires
> > 32 bits per word, as the devices it's going to talk to have this
> > requirement.

> So you're instantiating two variants of the same "xlnx,axi-quad-spi-1.00.a"
> controller, with different options?
> While you could add an "xlnx,foo" DT property for that, an alternative could
> be to introduce a new compatible value.
> It all depends on how many options there are when instantiating such a
> controller.

...and the slaves will still need to set the word length they're trying
to use otherwise things might get corrupted.

--Zrag5V6pnZGjLKiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vHIQACgkQJNaLcl1U
h9Br3Af/Q8KmhdPqdCKgXeoahUsf/6Hytmjo4CkNYllGT0+9Cdls/9nlSoL9gYPu
YxZRNTPLAwoMpCweth+9v7h7tbhcZtVkCVDdOH7SDDoCsV1BLbMs560XplNcUcWH
qHaZUDA2VOL6IpfSdASKEQ/o+/yyEabcPF3LPAuNCHPy12143mQzhTltOcoyL7GK
U/pwm/85e6e3YBpCCbktTGRnDFe97TJhnz3ZKTCraMyHWnffN1gLWE3JebJXhcj+
6F+p4AjpfqUcKYXfJfWkE86YeobU/MzNGMz5rKn4VegcTfm02dI3my7aipHiXyFJ
fUpc5j8BVm7Qct9exsRsvRtyitprjQ==
=V9sA
-----END PGP SIGNATURE-----

--Zrag5V6pnZGjLKiw--
