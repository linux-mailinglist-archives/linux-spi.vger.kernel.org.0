Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E0DBD0EE
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2019 19:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfIXRuk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Sep 2019 13:50:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36700 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfIXRuk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Sep 2019 13:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w1/8bGByujMGBxY7WOdtfIlR1B3nsSl2LOvw1SymH6M=; b=JeDXDKe2r+Y61Qg0LubTrvz4D
        CNPychaF1OZcz0kczc5YHHZQhcWC7bzYYue+nMdkb7kVCuYzx9McCu42CUWG3mFQc7xYVnSIguDfY
        CdiCraKXiRG8M315TiwareUbq//7AVwVL97W9zN0C5lxYn5sTIHsUHBC+JVnA8gDg7CCs=;
Received: from [12.157.10.118] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iCoxS-0002Ii-6A; Tue, 24 Sep 2019 17:50:38 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 99FEFD02FC7; Tue, 24 Sep 2019 18:50:36 +0100 (BST)
Date:   Tue, 24 Sep 2019 10:50:36 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Claus Stovgaard <claus.stovgaard@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org
Subject: Re: State of spidev from devicetree
Message-ID: <20190924175036.GA2036@sirena.org.uk>
References: <CAHirDJ_gtrjL_nq0T2qvn_kv9-UweL+=bc7EBLrTfNfNkVn0QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1MV0VfA6Y2yiVCnw"
Content-Disposition: inline
In-Reply-To: <CAHirDJ_gtrjL_nq0T2qvn_kv9-UweL+=bc7EBLrTfNfNkVn0QA@mail.gmail.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1MV0VfA6Y2yiVCnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2019 at 02:52:59PM +0200, Claus Stovgaard wrote:

> What is yours response to the idea of creating a custom-hardware binding
> for spidev, intended to be used for programmable hardware unknown at the
> devicetree time.

You should use a device tree overlay to describe whatever
hardware you've instantiated on your FPGA then load the overlay
along with your FPGA image.

--1MV0VfA6Y2yiVCnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2KV2sACgkQJNaLcl1U
h9CfCAgAgpnOWa5r0/h0bsDj1diMrHbB1YVhM8iVST3lb2eMpq9dySrQ+Kx1gbsh
CMpV+HUNlDP+ktOapuiKUr+NWd46ov4szfeSp+dHBrkA/yMwWVhIpAAcasC9pqoZ
ss6h4n7FlxJa2vUHEK90CW247hITTHW64jyrQUt3pSJ6jjZYhpwY4vkcjsawSUfq
EtnI0fW0eQXs8Pi4vsnGDm8Sb0qfgxomN1J9eusuqrodvkYJi0iAKzV5PUymEQIH
6d4qsK9SRjskX2PoFAK3hLyKJnYz6d/BkC7oFhKiMmntDuSZSqic/Esr7r0KbnOJ
XGYH9RzoXqUk4iXf4Ky3vIpZWHTfUA==
=dyAF
-----END PGP SIGNATURE-----

--1MV0VfA6Y2yiVCnw--
