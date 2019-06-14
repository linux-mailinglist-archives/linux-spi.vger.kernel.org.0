Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14B40461DF
	for <lists+linux-spi@lfdr.de>; Fri, 14 Jun 2019 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfFNO7L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jun 2019 10:59:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36616 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbfFNO7L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jun 2019 10:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ODvuEo2UhMVgECkphX4nfw40sbJoOoQzAeDtCHR4CWM=; b=ZlKNKdhWi8dhKQ5ANaRcOUdFV
        UqC7Dh0qAqQQnsa2qK5mzE+Mj++Crlwe1gMNPTmuAEKWurG9qw8lRA3ByRzf/w5Z8JOvqbdth7EFd
        R60pWK02pC0rWOM+dj9G1bW9EapNKc4ZiuzF3aGhnNxpvVWNkDAmTScZebGTLK5jqress=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hbnfT-00085e-V5; Fri, 14 Jun 2019 14:59:04 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id F309C440046; Fri, 14 Jun 2019 15:59:02 +0100 (BST)
Date:   Fri, 14 Jun 2019 15:59:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: Re: SPI regression with today's build
Message-ID: <20190614145902.GA5316@sirena.org.uk>
References: <5be80c08e0873ab200ed472b98ea8772666852ff.camel@suse.de>
 <a2f71bcab3756dc35385288ca3287af6849933a6.camel@suse.de>
 <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
 <CAHp75VdhfYXa_6wkYD+_DYQh1k5Mc43e6yF4uj00e6EvgGuOHg@mail.gmail.com>
 <d9be77a9-5198-fc80-636b-41865f3eec85@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jIdBwf7/i7YThJrI"
Content-Disposition: inline
In-Reply-To: <d9be77a9-5198-fc80-636b-41865f3eec85@tronnes.org>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jIdBwf7/i7YThJrI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 11:56:34AM +0200, Noralf Tr=F8nnes wrote:
> Den 14.06.2019 10.28, skrev Andy Shevchenko:

> > I gave a suggestion during LPC 2016 about this all stuff. We have to
> > provide a DMA channel capability to tell user what is the maximum
> > length is supported by the DMA engine. In such case the user may
> > prepare the transfers which are satisfying limitations and no
> > recreation is necessary, moreover, it will be performance wise to do
> > so.

> In this case the problem isn't the DMA engine, but the SPI controller
> DLEN register which limits the overall transfer to ~64kB.

Andy's point still stands though, we just need to make sure we also
include SPI controller limits in case they're lower than the DMA
controller limit.

--jIdBwf7/i7YThJrI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0DtjYACgkQJNaLcl1U
h9BTCAf/Xo48iePX8UFs/NDW9WIOjh9ylCoT2wrwGi1neuJSQC+JJDCkEhIHME8b
jv4cYbVsjzg1j6wTfS1QT+YrrvMy4DhbtDMNlRgqs0lxpErKFjBd/HXFxodSaRnI
okC/vFp08wtzRCQl1bV6Bvcmc7u4k5d3DKoWeB4vZBw/8jdUtbNc4aIxH3UTLzAt
2075mRbyWFoujRgHSixD5l80iUOUvC9XZ5Ou480msNVrqp/AhYWLwqlKWuipxsaF
QzomSCNqZlX0/eoy6lnpfUz3l/QwDNEOH5eDHgCm7ftCdeFtxxLrWK6Tz8hu/Yv6
L2FfTzdTBxnLQJyYVYQqI/ZVXHoCvQ==
=OG+P
-----END PGP SIGNATURE-----

--jIdBwf7/i7YThJrI--
