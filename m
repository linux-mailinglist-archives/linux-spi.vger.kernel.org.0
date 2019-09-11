Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85032AFC04
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2019 13:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfIKL7c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Sep 2019 07:59:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60046 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfIKL7c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Sep 2019 07:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tK0JR9oNjstb9FQfTR2pCydHBSMT54MQKglFzHOPGBo=; b=afFRogvBvedLbX+TNVz+KvzgQ
        mz0+OBWqrRfumTS5Ds0ZHMoGK8UXa0nGhET+Ogu4W620uJ5AJLXpJhv2RGPzId1T3qv6/swLu38pq
        2yOLEtNYfSrbtYAwlhYA/ozrEK/LkeCaeK3NloVuXWE3Il4GjQ0UaNIk2ydU8bFAsI284=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i81HU-0000P6-So; Wed, 11 Sep 2019 11:59:28 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3D00AD00486; Wed, 11 Sep 2019 12:59:28 +0100 (BST)
Date:   Wed, 11 Sep 2019 12:59:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/10] Speed up SPI simplex transfers on Raspberry Pi
Message-ID: <20190911115928.GE2036@sirena.org.uk>
References: <cover.1568187525.git.lukas@wunner.de>
 <20190911104721.GX2036@sirena.org.uk>
 <20190911114352.w2htkzfi5v6zl7nq@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lg8eXa+brxrbjAbR"
Content-Disposition: inline
In-Reply-To: <20190911114352.w2htkzfi5v6zl7nq@wunner.de>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Lg8eXa+brxrbjAbR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2019 at 01:43:52PM +0200, Lukas Wunner wrote:

> I use "git format-patch --thread=shallow", then use a Perl script
> to change the Date: header and send out the raw messages with msmtp.

Sounds like your perl script could just be git send-email?

> I suspect the incorrect order may be because all messages use the
> same Date: header and you're using "sort_aux=date-sent" in Mutt.

or that the messages are getting reordered in transit by the
intervening MTAs and it's falling back on delivery order lacking
any other information.

--Lg8eXa+brxrbjAbR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl144Z0ACgkQJNaLcl1U
h9CiGgf+IZkFNPyHBjwAVwbah4Xor1XYDP/HVn9fnXlcm4hxeMSuYkCdimjnkwFy
NBEgTw0samr7jvJtNwoU8GIOuntj2nbkPyQRTRktAfUX7hwXoPnWXyo6CKmBlGKY
kL1CZhQa62BVgS8p8a/0e9q4oE4hUo/7zTqNrNw11kMcIA1SSs+h6dtWtT65RidS
YZsY4IJclh+qZpnERxE9ceRCOuviz7bIEcGz8H0ZA7/nftR+9va8vjmYgwjnW0ir
5pel+Me4nixf0+fYorS97DvGGq2puMhUfwwajDAaFYa6shsNjea2EbBho5BpqIH5
JBsy+0Z93PeNmUEGgvfprEGmbnpxxw==
=CdYe
-----END PGP SIGNATURE-----

--Lg8eXa+brxrbjAbR--
