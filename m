Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D966113129D
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2020 14:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAFNMg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jan 2020 08:12:36 -0500
Received: from foss.arm.com ([217.140.110.172]:43894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgAFNMf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Jan 2020 08:12:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7F3B328;
        Mon,  6 Jan 2020 05:12:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 600723F534;
        Mon,  6 Jan 2020 05:12:34 -0800 (PST)
Date:   Mon, 6 Jan 2020 13:12:32 +0000
From:   Mark Brown <broonie@kerenl.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [GIT PULL] spi fixes for v5.5
Message-ID: <20200106131232.GC6448@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
X-Cookie: It's later than you think.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 63aa6a692595d47a0785297b481072086b9272d2:

  spi: fsl: use platform_get_irq() instead of of_irq_to_resource() (2019-12-16 11:54:55 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.5-rc5

for you to fetch changes up to 09b6636cea4f8e419d7cca4155e8695e462535a6:

  spi: Document Octal mode as valid SPI bus width (2020-01-03 01:02:11 +0000)

----------------------------------------------------------------
spi: Fixes for v5.5

A small collection of fixes here, one to make the newly added PTP
timestamping code more accurate, a few driver fixes and a fix for the
core DT binding to document the fact that we support eight wire buses.

----------------------------------------------------------------
Kunihiko Hayashi (1):
      spi: uniphier: Fix FIFO threshold

Vignesh Raghavendra (1):
      spi: Document Octal mode as valid SPI bus width

Vladimir Oltean (2):
      spi: Don't look at TX buffer for PTP system timestamping
      spi: spi-fsl-dspi: Fix 16-bit word order in 32-bit XSPI mode

wuxu.wu (1):
      spi: spi-dw: Add lock protect dw_spi rx/tx to prevent concurrent calls

 .../devicetree/bindings/spi/spi-controller.yaml    |  4 +--
 drivers/spi/spi-dw.c                               | 15 ++++++++---
 drivers/spi/spi-dw.h                               |  1 +
 drivers/spi/spi-fsl-dspi.c                         | 24 +++++++----------
 drivers/spi/spi-uniphier.c                         | 31 +++++++++++++---------
 drivers/spi/spi.c                                  | 22 ++++++---------
 include/linux/spi/spi.h                            |  4 +--
 7 files changed, 54 insertions(+), 47 deletions(-)

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4TMkAACgkQJNaLcl1U
h9Avjgf9GlqKPfiuEc9tJ7BwdeCWC5muNQl/ME0FOwxBZr1pmup24A5ZiL+/6r+G
dpdWZbGeiM90jsbcGqSDVjsg+v8brmKM0G6WJH8YQiZEBFzbrZ5kOqC8xYXoKaOi
LX9yvAQKrIfl+eKltGZ4Mspnu+fUfF4Xa5ZiK5nXkbfZPN/B0zaPH8NvnjoQnwro
oQnsKixrp3Q1A9MHZi4HgUrBha1wHZwjpS3Z9u2QmKRGXjuyxJHPSb57VoYXtb42
hDVd/5BWreHe4z2LeIQVsvQPXx4fgmZCi25nEOdfYDzkBT30zJA15c1GtmkW6j5J
9fSTGiOc2oRuLFG+itKtwSkx/stKcg==
=OS15
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
