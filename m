Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1935633480
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2019 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfFCQEe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jun 2019 12:04:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55266 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfFCQEe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jun 2019 12:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0cUdzCSD5aTy1CLRMPEAv9Ir1iQsp2ShOu2rnQ9I/2A=; b=M9FEdq8/iVN2OhKi2AQQvqzwk
        FfgysU0HJocKBFa80YLFN++8JT2ShJ0ZyI4dAEUPjCLaOoNBjiPNXrC/QSWMDcU6aDszjk+uV1Rfp
        +QAXhgWvs40LjEe8VjIYqbPNIN58Zd7d+A5UePqU0xtwlJe+jq+ebk0Dqv8kHChU4AYfo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXpRm-0002J4-EI; Mon, 03 Jun 2019 16:04:30 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id E0D99440046; Mon,  3 Jun 2019 17:04:29 +0100 (BST)
Date:   Mon, 3 Jun 2019 17:04:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-spi@vger.kernel.org
Subject: Re: [RFC PATCH 23/57] drivers: spi: Use bus_find_device_by_acpi_dev
 match helper
Message-ID: <20190603160429.GC27065@sirena.org.uk>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-24-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <1559577023-558-24-git-send-email-suzuki.poulose@arm.com>
X-Cookie: Been Transferred Lately?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 04:49:49PM +0100, Suzuki K Poulose wrote:
> Switch to the generic helper bus_find_device_by_acpi_dev.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

Acked-by: Mark Brown <broonie@kernel.org>

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1RQ0ACgkQJNaLcl1U
h9CQBwf9H09l78szJ3SsaQn6PSfi69VPGAAQ3ow2xP765ppwg205GOWZSFh91i/F
S+GgszqbRJl/KiEwrPBe8nOrIAIXrBryWxDELZ4tI4h+nQnu5BoHq70B8rhGuZln
U80DQsvKrmTXSpgal77fz/OWr3+An9Bz+NQSmTfWkJRDSXasypcBOIowJ39CzvCh
DQdiFSpYkUXkX5ohtkRR1sWagTgbIvj2CtAyI74VcRPU8qT0f5ag46p7rJ01qmqr
Pbeb6wvubWgO2tPPiZ89bsR712tSXhxJ3dKCJ+Hg/ORBAVkqYl48hpov0PU0lJFh
kdzI6tgsUFi2fwHzKWdwoSnCby1C1g==
=9Tow
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
