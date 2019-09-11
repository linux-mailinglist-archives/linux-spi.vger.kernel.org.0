Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC46EAFABF
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 12:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfIKKrX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 06:47:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51562 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKKrX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 06:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=obMQBjQk21sSrNDQ9pzr5Lrl4+GQWjmyi37MqvNhcFo=; b=BkFtIyszpUZQvUpa0xiEd9+lT
        Kz9hqZEbQG09bwIxmytYOdk69zUPPadkXKecfaQ4MuexvS0BH6jL1q0o/FH26jN5ljfLwwpDaYIUw
        SuelNo3itJ87mtHGb/Gn3M9zxwL8c9e29uxUvuOaMVwysuy91N+UyaeSvGpbdM/y6HY74=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i809h-0008Hf-Sl; Wed, 11 Sep 2019 10:47:21 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3A04CD00330; Wed, 11 Sep 2019 11:47:21 +0100 (BST)
Date:   Wed, 11 Sep 2019 11:47:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/10] Speed up SPI simplex transfers on Raspberry Pi
Message-ID: <20190911104721.GX2036@sirena.org.uk>
References: <cover.1568187525.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sBvc846/5FzkyDmz"
Content-Disposition: inline
In-Reply-To: <cover.1568187525.git.lukas@wunner.de>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sBvc846/5FzkyDmz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 12:15:30PM +0200, Lukas Wunner wrote:
> Extend the BCM2835 SPI driver to handle simplex transfers internally,
> thereby reducing their latency and CPU usage and obviating the need to
> have the SPI core convert to full-duplex via SPI_CONTROLLER_MUST_TX/RX.

Whatever you're doing to send these is still not sending the
patches in order:

    779 N T 09/11 Lukas Wunner    (1.6K) [PATCH v2 00/10] Speed up SPI simp=
lex t
    780 N T 09/11 Lukas Wunner    (2.1K) =E2=94=9C=E2=94=80>[PATCH v2 02/10=
] dmaengine: bcm2835:
    781 N T 09/11 Lukas Wunner    (1.3K) =E2=94=9C=E2=94=80>[PATCH v2 01/10=
] dmaengine: bcm2835:
    782 N T 09/11 Lukas Wunner    (2.6K) =E2=94=9C=E2=94=80>[PATCH v2 03/10=
] spi: Guarantee cac

--sBvc846/5FzkyDmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl140LYACgkQJNaLcl1U
h9CJuAf40t7iOsCtCUCgOGIXB+YibWRckLCGnZaxx9lO8FpS02JKK8a1kZ7BzmBu
KUB9QEeaKj5mR76HSW9ptzpbLt2Dhgy92E9In/53UHZK8w7xCRzpngrLvLy/ngg9
BKxBDoUN5rANRRMIhK18StZ4TKHqviLnTyfFlFkchbmu9KH3bQpwV1v+t0Mv4TqS
rbeE860BfkVkR6iCMCt/vTlIi+XwRxoTVgjLUWPIphox2CzAYX0ChmRuuX+lXfz3
t1LJLptjNXavM3z03a/6EeLrgjIvTlc0EmXJNb2YpjSl4w2Lfhtiy8saxwuwXa1s
UIApc9MXI4DnImX3tQ8K1ZWo2qJq
=9QgI
-----END PGP SIGNATURE-----

--sBvc846/5FzkyDmz--
