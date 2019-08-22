Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1978199FC4
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2019 21:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbfHVTVi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Aug 2019 15:21:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56146 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbfHVTVi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Aug 2019 15:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vsUIbNnricD1CtOC++D3RP8hy2wQsrovvKJsVqbVI0A=; b=JoQBqHuhqUmhhRTrW6TghQ0+c
        txx7bNZg/FTAnIT0EZCRdn/Xvr6PF4DkhAkt8E9vJ5/mcsZyHASqtoRtasEIGqSyH1f4dsUPfq2X7
        yePWImnanZ5Kgi57tdX2iFLEtH6u8vJIZ+kDn4kyMwe1/1ibMUshYjAGjGL7I5mfJlOs4=;
Received: from 92.40.26.78.threembb.co.uk ([92.40.26.78] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i0seO-00080F-Ds; Thu, 22 Aug 2019 19:21:36 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id DD0A0D02CB0; Thu, 22 Aug 2019 20:21:34 +0100 (BST)
Date:   Thu, 22 Aug 2019 20:21:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Santos <daniel@gsat.us>
Cc:     linux-spi <linux-spi@vger.kernel.org>
Subject: Re: Is there a "spimon" anywhere? Also spi flash data rate question
Message-ID: <20190822192134.GJ23391@sirena.co.uk>
References: <ccad9bc9-3a3a-142a-dfa7-1120ff5a5430@gsat.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Content-Disposition: inline
In-Reply-To: <ccad9bc9-3a3a-142a-dfa7-1120ff5a5430@gsat.us>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2019 at 03:44:27PM -0500, Daniel Santos wrote:

Please remember to copy maintainers on things if you want them to
reliably see things.

> I'm having some trouble getting a Winbond W25Q128FV to operate faster
> than 24MHz (it's supposed to do 50 reading and 100 for everything
> else).=A0 Is there some type of "spimon" project or patch set anywhere to
> dump spi traffic via netlink or printk for debugging?

There's extensive trace points

   https://blog.sirena.org.uk/2011/01/22/tracing-asoc-with-trace-points/

applies.

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1e6z4ACgkQJNaLcl1U
h9CtFgf/ZfoSuzKyiLAiWzTW0aF/s8YvSksoND5sAuEN1sw+G5bpHgmClBgaPc7B
JytYy1EsowymyX5QPUSVF7ZOXU4YjC91Iq5t3KQGOip383TopF8bK5CP2k5k9Sem
BdAY68TwSYV8OCktTYoCTJ6G10pfxxh8xffV/DYxwCrETS7bGsPju2l8llO/1uMK
Q57UcH2Mr9XX/M4v0Wi61pjdQTZgASYX82LvI7d80A3duf8eD9ve54V6j1HB/eB/
yZu1r+H3BJsWe+dakS9yKQ+1hjZVJg9HvpsSD11TrialLKQrN81OvWBpDu/Pvbm6
VsW+x0LgZKpulWjU9eu/pjF9Gi9hRg==
=N8A/
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--
