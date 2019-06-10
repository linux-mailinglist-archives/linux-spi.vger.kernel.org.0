Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4D83B74D
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2019 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbfFJO0v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Jun 2019 10:26:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47908 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388936AbfFJO0v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Jun 2019 10:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w7gFGP/pm4Hi9glOBcXMYzWxwWWedAusuMfX2g2W4Ew=; b=SML5uyMHHW5MmXWWqP8/oUcTR
        bz5uNebXLz0slpqYb/6Db9NNEhdD/sXD+ZzqTqTCz8KVTaGJFtkg8Mfow53irEQu7Qf5GgRvSnqCt
        98L8JF0qhOK2iwXntL6z8P9NXED2elDbhtih+tb9xgW/yCWHNCYjKLAoZqSxVZukmhiSA=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1haLG5-0005tm-Ta; Mon, 10 Jun 2019 14:26:49 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id BAF45440046; Mon, 10 Jun 2019 15:26:48 +0100 (BST)
Date:   Mon, 10 Jun 2019 15:26:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] spi fixes for v5.2
Message-ID: <20190610142648.GB5316@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d61ad23cb3be09ff4956e9b9794134456522817f:

  spi: Clear SPI_CS_HIGH flag from bad_bits for GPIO chip-select (2019-05-02 10:38:00 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.2-rc4

for you to fetch changes up to f3440d9a0da292dc4998d9393162fcfb996fd671:

  spi: abort spi_sync if failed to prepare_transfer_hardware (2019-05-23 14:36:13 +0100)

----------------------------------------------------------------
spi: Fixes for v5.2

A small set of fixes here, one core fix for error handling when we fail
to set up the hardware before initiating a transfer and another one
reverting a change in the core which broke Raspberry Pi in common use
cases as part of some optimization work.  There's also a couple of
driver specific fixes.

----------------------------------------------------------------
Christophe Leroy (1):
      spi: spi-fsl-spi: call spi_finalize_current_message() at the end

Mark Brown (1):
      spi: Fix Raspberry Pi breakage

Super Liu (1):
      spi: abort spi_sync if failed to prepare_transfer_hardware

YueHaibing (1):
      spi: bitbang: Fix NULL pointer dereference in spi_unregister_master

 drivers/spi/spi-bitbang.c |  2 +-
 drivers/spi/spi-fsl-spi.c |  2 +-
 drivers/spi/spi.c         | 11 ++++++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz+aKcACgkQJNaLcl1U
h9CIFAf/ROOT3trWHzotcI7wHH8gQPZdZ9Ojm2mjxC6XGbhafTvd+XgLv9dDiT88
B70DVcuR7VUBtJSDSirKXeOuDQ+vG9/xKtRQMLjIojmkJ2+yO6MzmZLCX3xRZZ9K
xIgj8U+A5Mbed48XvwD9kHRd57SpUvjaUwp4GBypxHVp6cqJnFDoEcLkN15MNgOQ
6t2hReLFATJdEPMVRfADLkr6ksVc25pIfmXgpeedT7NXiErkDNez5AtVY0gukLqK
YM4TSwidRhp8gnXD6wZtBZtniiI881zw25YbCGpIyNJBfL2PykskDGDARB4Gl1t7
uaEtGcGKR23bSzjQQ2+s9cDmwpADZA==
=XCGZ
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
