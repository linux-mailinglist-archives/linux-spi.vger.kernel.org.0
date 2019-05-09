Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32C0183BC
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 04:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfEIC1X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 22:27:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49706 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfEIC1W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 22:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wMySUkO+0cF93SEvvlk2EZh5iYW76SXJnk6D3wJbWEU=; b=J9EYztFGNcxx5eL4h+09TANOg
        Tdd+9C6xDL1A5YX03Hc+xBtWXul7+odU98ghuc7WNY7uqciDnnWYW+XbnYcZRxREAT2/wthmFs0Rt
        dglH+QE5LfKqDPSbWkN0uOB8DsxaBsRANFG1rTb1BDtLO2fzDEXFrGFxTY10YTq+MeYUw=;
Received: from [2001:268:c0e3:9e6d:fb20:4124:5afd:9c02] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOYm2-0001QV-Ej; Thu, 09 May 2019 02:27:06 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id EF4BE44000C; Thu,  9 May 2019 03:27:01 +0100 (BST)
Date:   Thu, 9 May 2019 11:27:01 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: Re: SPI regression with today's build
Message-ID: <20190509022701.GS14916@sirena.org.uk>
References: <5be80c08e0873ab200ed472b98ea8772666852ff.camel@suse.de>
 <a2f71bcab3756dc35385288ca3287af6849933a6.camel@suse.de>
 <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jF32gZOFbnzmk3b4"
Content-Disposition: inline
In-Reply-To: <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jF32gZOFbnzmk3b4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2019 at 07:33:32PM +0200, Noralf Tr=F8nnes wrote:

> Unless Martin Sperl, who wrote spi_split_transfers_maxsize(), has other
> suggestions, I think we should just revert this patch.

I'll just revert for now, we can always re-apply things later but
that'll get the problem sorted in Linus' tree quickest.

--jF32gZOFbnzmk3b4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzTj/UACgkQJNaLcl1U
h9CCFAf/bSOhxvFDl0KXMCJmE62+jQP9FM0+gqOV5Pq1uVRKl1XzLVAvNZu/rgNt
2sRNYWnVyFsRuBNsR9dQt4bTcB8DpOq9aY88LVtS8eump10ffZyOSajkeQblbFFi
XcDqRQAuvwSKTqDnu/ojvOiWdRaAfUJ9JBnZGds1k0mKH9CzuWNMIlqW2mCnhHqn
G101xVEXtPMj4kmVySW4q33gySCiAPVRUmnR0ai43ynYUpsFnJBfqMJ4dIYQ1QZY
hbr48KmMV0dZvXwu4MbRpnfIO+Q1ALMtQXugZZLPQ5gYnEcZqaOnPkrlj7GpfKQq
RexQ7EiIO/W7x+dxnyUiForXCxvdJA==
=tQvz
-----END PGP SIGNATURE-----

--jF32gZOFbnzmk3b4--
