Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3232F1718E
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 08:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEHG3B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 02:29:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42426 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfEHG3B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 02:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mIyxU7VnNV8jDbGTYSn2QuAAnMlpGNdTTNr/w7EuXoo=; b=LI15PkuFSDAwbSF9sshVlzmJX
        QALNE7xOrNA6nuZRUucLtQg4wVYxMeP61ahRZ3LFT0wPTskjpQU+6+ZzCN7LEJkgfYpaQgz9n3JkK
        +ERpQ0L4huR0X72bzTE89TxViqK81uX0ZHf5wS+6/KUmYerW1t3vbvmcOMCVOalm2CvTA=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOG4Y-00077p-FD; Wed, 08 May 2019 06:28:58 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id D462C440017; Wed,  8 May 2019 07:11:36 +0100 (BST)
Date:   Wed, 8 May 2019 15:11:36 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Message-ID: <20190508061136.GI14916@sirena.org.uk>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_k_D7=SPd=bi-=3EtBjeG6fe0EaTb4U4ZZgoOoRSub-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BX5bBAwwbKvz0cyO"
Content-Disposition: inline
In-Reply-To: <CAADWXX_k_D7=SPd=bi-=3EtBjeG6fe0EaTb4U4ZZgoOoRSub-Q@mail.gmail.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--BX5bBAwwbKvz0cyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 08:08:50AM -0700, Linus Torvalds wrote:
> On Mon, May 6, 2019 at 7:33 AM Mark Brown <broonie@kernel.org> wrote:

> > spi: Updates for v5.2

> Hmm. Please be more careful. Commit 1dfbf334f123 ("spi: ep93xx:
> Convert to use CS GPIO descriptors") caused a new warning because it
> removed a "for ()" loop, but left the now unused variable 'i' around.

> I fixed it up in the merge, because I hate warnings that may hide real
> problems. But I also expect maintainers to check their warnings,
> exactly because the normal build is supposed to have none. So a new
> warning does stand out.

Sorry, I've actually got a fix for that queued but obviously didn't
manage to make sure it made it all the way through the process to the
pull request.

--BX5bBAwwbKvz0cyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzScxgACgkQJNaLcl1U
h9CnJwf/eKpzIkTbhVcC7J2Bb3sJsMXD6vuBkkbnkgLlu4ajKp9FJx+eTtd4eETY
NobQp2PD84TpU62FmkQxvxvCMNezwtGN+IcttLV0o7I6MvJKbFU6vJwKTBztXawA
pcd43PWu9rI9KearSLkkGdVGAQAbY6CurPPJNeG3/JElOHkUgoEt04PW2DE6OoyX
lSHkynrdR+R+EmYtDXj9ZJO2Hd8ebDodBd/XB2Ay+VQubqzFY7rHiHI/q+zRDD6V
LLRkDphcmwVOnurHYGeYNoi56XYidEmvTN9dkjP+Jzu5l5K03kXf1Q2xo7LQPhZk
s96tTYvAn0pM7gu2JM7zy8m1BR9pOg==
=VZ8j
-----END PGP SIGNATURE-----

--BX5bBAwwbKvz0cyO--
