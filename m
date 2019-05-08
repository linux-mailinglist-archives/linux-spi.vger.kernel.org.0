Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA261743C
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 10:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfEHItL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 04:49:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51920 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfEHItL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 04:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=om+fpMjoBeo6OmvhQLYoKQ1tz2zYXAg6W4JSs9Yvc1U=; b=Ndawc8EaIN1CnwwH1yY30g9CA
        XUmiOVbM3Ikdj9CJmX/VH/g7OTu+of8wzsmwn/n1kDAUPWCih56tUyMH4h79euPpQ/vpACTGDzdtD
        MWMXunQiT7M6fw7x2pphOqe2T+cKrTjlnyJGozwbj/gww/Ft2MCoKfPFJW45MIVuLxAIc=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOIG2-0007bS-V6; Wed, 08 May 2019 08:48:59 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id E4A75440017; Wed,  8 May 2019 09:42:05 +0100 (BST)
Date:   Wed, 8 May 2019 17:42:05 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     kernel@martin.sperl.org, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 5/6] spi: bcm2835: make the lower limit for dma mode
 configurable
Message-ID: <20190508084205.GD14916@sirena.org.uk>
References: <20190423201513.8073-1-kernel@martin.sperl.org>
 <20190423201513.8073-6-kernel@martin.sperl.org>
 <20190424070712.hh6ozvhkvkxhwak3@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mO8cNyIiGwRJ/NO+"
Content-Disposition: inline
In-Reply-To: <20190424070712.hh6ozvhkvkxhwak3@wunner.de>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--mO8cNyIiGwRJ/NO+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 24, 2019 at 09:07:12AM +0200, Lukas Wunner wrote:

> Indeed I'd prefer if another bit is added to "mode" in struct device
> to represent the need for another clock cycle in-between bytes.
> The SPI core could then reduce the clock speed based on this flag
> and the problem would be solved for everyone.

> Influencing this behavior with a module parameter feels a bit like a
> kludge and I fear may stay indefinitely even if a better solution
> is implemented later.

This does feel like we know enough to have a more advanced function in
the driver given a bit of information about the client device
requireemnts.  Though it's going to be complex to express them,
especially with the ATMega case where we want fast individual clocks but
lots of dead space in between bytes (is the controller capable of adding
that dead space itself in DMA mode BTW?).

--mO8cNyIiGwRJ/NO+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSll0ACgkQJNaLcl1U
h9BtCQf+Kt1H2BIy8rCRowJoHOYziXd77HiP3zga+61FigqwiVNAsnc9sgHceaX8
PC+sIWmiH3sdLwIO+ZCkNwTxPmPwrLLnv7xQa8NWnS7jCxIMnVLRnmlQ9cVuLQ0k
sHIA+aPAqT/wUZLDrwg4PhAq2laX/KDZb9rOpPbi4kb/zVhVtkXuYVFEgiR5Pl77
enqEIE+oEUG7Ebns1fzljdzv/h0zu1g+KpzTJ4hVTVCShHUAo8AZmBsgMfP/gT/Y
q0U8SBCda+HZH5Av6k9lBWMgGgOfF1E1JlQaNYQGTfEVOlt1imMXH4yQVy+bilZ2
8rHCL74K7lQ5reujgEtw/36TmfZ8qg==
=atSx
-----END PGP SIGNATURE-----

--mO8cNyIiGwRJ/NO+--
