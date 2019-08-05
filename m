Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B4081F75
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2019 16:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfHEOuS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Aug 2019 10:50:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43938 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfHEOuS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Aug 2019 10:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2qYGdFyCH95p20i9diOVmgkNhS9ej7OzPV6au+bJxxs=; b=tU9LO1+KpYKVn3+h7O+gBv/p1
        1L+WdLOavAK8sUHuXIUV4/ZpLc3Zpi+S3i+S3XlwpACB+e+oC/6tE5hK91x2zTZhQzc0E/HClYeOj
        NRXjM6WrThdzYabhj6IsXtCSHK325voQkPRo+0OzYsBfWFJArc7U6DZJ6o31mOLPjMQYk=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hueJT-0000WM-Uw; Mon, 05 Aug 2019 14:50:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D210F2742D06; Mon,  5 Aug 2019 15:50:14 +0100 (BST)
Date:   Mon, 5 Aug 2019 15:50:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] SPI fixes for v5.3
Message-ID: <20190805145014.GI6432@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hABqaeELJqnDDeDE"
Content-Disposition: inline
X-Cookie: Place stamp here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--hABqaeELJqnDDeDE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8cc7720470a17558bd6f8d67df63361600e46c55:

  spi: pxa2xx: Add support for Intel Elkhart Lake (2019-07-03 13:03:44 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.3-rc3

for you to fetch changes up to a4127952859a869cf3fc5a49547dbe2ffa2eac89:

  spi: pxa2xx: Add support for Intel Tiger Lake (2019-08-02 12:14:23 +0100)

----------------------------------------------------------------
spi: Fixes for v5.3

A bunch of small, device specific things here plus a DT bindings fix for
the new validatable YAML binding format.  The most notable thing is the
fix for GPIO chip selects which fixes a corner case in updates of that
code to modern APIs, unfortunately due to a historical mess the code
around GPIO support is obscure, fragile and an ABI which makes and
attempt to improve the situation painful.

----------------------------------------------------------------
Han Xu (1):
      spi: spi-fsl-qspi: change i.MX7D RX FIFO size

Jarkko Nikula (1):
      spi: pxa2xx: Add support for Intel Tiger Lake

Linus Walleij (1):
      spi: gpio: Add SPI_MASTER_GPIO_SS flag

Lubomir Rintel (1):
      spi: pxa2xx: Balance runtime PM enable/disable on error

Lukas Wunner (1):
      spi: bcm2835: Fix 3-wire mode if DMA is enabled

Rob Herring (1):
      spi: dt-bindings: spi-controller: remove unnecessary 'maxItems: 1' from reg

 Documentation/devicetree/bindings/spi/spi-controller.yaml |  1 -
 drivers/spi/spi-bcm2835.c                                 |  3 ++-
 drivers/spi/spi-fsl-qspi.c                                |  2 +-
 drivers/spi/spi-gpio.c                                    |  6 ++++++
 drivers/spi/spi-pxa2xx.c                                  | 14 ++++++++++++--
 5 files changed, 21 insertions(+), 5 deletions(-)

--hABqaeELJqnDDeDE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1IQiYACgkQJNaLcl1U
h9DVrAf4rI7VruSCdKi9gWLD+MK79ppEONhiDo3KiVnkHghlOck5NtA88KzhQizW
QF3hd29Y3hJil+r31iuPIqj9GdLKGMpFPrgovR184SrA7aUikm8niuuqh0RE0voX
KKEAXz+AYpUxsBlLAu6pyF+5treKw+B/HmHXSaT/+Bv9TDrbrL1GcZKYLVm747ta
BkFP6Sc/IJRgw8hq6TdRtshGoxlgT4rLaSxuMtkltbu1UoAA/qyq98rjmJvNfbSi
b4Y0hmhY50wM9dN1F0Vj4PGmfGOTqM9YqubE6yLuWHS8dgXL/pLULjXqfxoYMjCE
PQxWUtWfcE/GAHD/sMUs8IYK8L3Q
=AiZ5
-----END PGP SIGNATURE-----

--hABqaeELJqnDDeDE--
