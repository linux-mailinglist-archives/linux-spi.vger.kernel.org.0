Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920A51F01E
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2019 13:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbfEOLkz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 May 2019 07:40:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44110 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732489AbfEOL3I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 May 2019 07:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c2nb29zF7zxfX/kIeJWPumZNWap+6etEox+DI/tfr/E=; b=oKXIs7i6XSRQmXCCL9OwSOOuy
        pWSF/98Q3Ej9L5o9E1vHpkn4OVxa4tBNlkjcSoo5DaMKMxuu//hFb4nJ/3l9PFOALBtRVVsh/4lJc
        G5ewaW8I22P63tq4/U/oejQ5EtO/H9q7Xe8ipFwch4Xol801IcYTWjDNPZX76UFVbAIA4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQs5k-0003dJ-PD; Wed, 15 May 2019 11:29:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 362941126D6A; Wed, 15 May 2019 12:29:00 +0100 (BST)
Date:   Wed, 15 May 2019 12:29:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Message-ID: <20190515112900.GE5613@sirena.org.uk>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
 <cf4bd167-49b8-5649-a2e2-7bf5ddcc6e2d@nvidia.com>
 <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190515093522.GC5613@sirena.org.uk>
 <BYAPR12MB3398ED52051F5BFA08D7B3A6C2090@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398ED52051F5BFA08D7B3A6C2090@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Cookie: You will lose an important tape file.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2019 at 11:24:22AM +0000, Sowjanya Komatineni wrote:

> > Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.

> I did changed but looks like it didn't made diff. Will try with different=
 email client.

Yeah, the behaviour is exactly the same - it's not only not wrapping
your content but also reflowing quoted content.

> > Please don't ignore review comments, people are generally making them
> for a reason and are likely to have the same concerns if issues remain
> unaddressed.  Having to repeat the same comments can get repetitive and
> make people question the value of time spent reviewing.  If you disagree
> with the review comments that's fine but you need to reply and discuss
> your concerns so that the reviewer can understand your decisions.

> If you are referring to comment from Jon on updating commit, I didn't ign=
ored. I am just waiting if any more comments from you or others before post=
ing updated patch.=20

That was more about the continuing issues with mail formatting.

> But I see you applied patch now. So how should I post with updated commit?

No, it's fine.  It would have been better to have a clearer commit
message but I think the usage makes it reasonably clear in the final
code why that was done and honestly "the hardware doesn't support all
the features we need to properly control devices" is an extremely common
reason for using GPIO chip selects even when hardware support is
available.

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzb9/sACgkQJNaLcl1U
h9BUDwf/bPfCyFuksT4NWyI8p6GWwFAUqqbX6kRmGX6QVE+z2hnkF6KlYKBRlIV6
lgYs5tiInlHAw7ZLHeqzL0i6R+OzTGprmMKnl+Tjh1JmwwVbbpe4MX2i0EM575Yo
tySU55KRQjtCC9pDBjqbND2Drh7PcAQqZNnj2izJyimjcQrCNTlZaUeWDbdptqVI
JInzZFPpsdvgSMMj7RTAmo22RzO2jdNNZncxo86MXp8zCvBupMDZTem3aXL9PFCJ
qVP1LJ8JvHPGZcyCag9ForjT5XTHqygCSupKrqol9X2QXsJMNFMqcB5tsJkINGXk
pZdS55eooHyxJvRybmtWPKzsiGJCww==
=2+CF
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
