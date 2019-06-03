Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9323347D
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2019 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfFCQEK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jun 2019 12:04:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54530 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbfFCQEJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jun 2019 12:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0ucS/kI4RoTagRVnKejFbeSo7H42KuZSv6+50wgMi6g=; b=XXsE/34kd2FVwxJwQ6n4Zf5GD
        w6ZS9bOr9GL+ppDwKYIgCVoC4N/sDLzqjrlmGMNeciZ1rPgX6D4WFQpAPhozm3Sl3+CtIpHE/I1YH
        YOO1j/B1zTcCdLO5d4J88N7Hhz60Tnpxg1Qe17c5/HBh0tOxjg1hZf4lK88+6jAF2kAp0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXpRN-0002It-Kn; Mon, 03 Jun 2019 16:04:05 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 046D7440046; Mon,  3 Jun 2019 17:04:04 +0100 (BST)
Date:   Mon, 3 Jun 2019 17:04:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-spi@vger.kernel.org
Subject: Re: [RFC PATCH 08/57] drivers: spi: Use bus_find_device_by_of_node
 helper
Message-ID: <20190603160404.GB27065@sirena.org.uk>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-9-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <1559577023-558-9-git-send-email-suzuki.poulose@arm.com>
X-Cookie: Been Transferred Lately?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 04:49:34PM +0100, Suzuki K Poulose wrote:
> Switch to using the bus_find_device_by_of_node helper

Acked-by: Mark Brown <broonie@kernel.org>

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1RPQACgkQJNaLcl1U
h9BXywf+PLFx0lkRGZEfw5IZNYRqZfaVe2asdEE8TGCDbggkTn/3pGXKq5dYe4L3
HoTFkDRqRjtLq4COXOHxRQywm55vCWRLOBbeEzpzgdtV9Ya1ZjgoUK/T9yFa96YF
4sm3P5JyvJ0pGDbgXhTe2uy7NlK69P3nNlsYcDHMzdPxNg26Yos/P0UzLsNdu60K
NmEpruSUpWpFLG6R8BnuPw4pVmSioBPcIpayrICjudNldt3W8TmosL8HUXQqLDgP
slmAV5jvLoZF2mM5TjJPuXbpTbJs+V7BYuZYXGHF+JoBQCkiH0nzCujVwOs/jnJ9
kRzXLhhCpobMcp+dg9tElwPRGsG2mQ==
=MQwB
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
