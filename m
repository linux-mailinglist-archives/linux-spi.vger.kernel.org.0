Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87EAE76478
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2019 13:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfGZL3S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jul 2019 07:29:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48290 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfGZL3S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jul 2019 07:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tmj943UI2GE6JqWb1wO5QjWgNH6NQQ0vyuXq2eJUd20=; b=WFVaTPJMPU4srOQFD8ydc5JvE
        YdZFCrE86M81nq/6ah/bC7ukAKGLnqQfpXzmpiCgNVu5El8kxBfpdwKctmbeT2B/RhhzBX/AZJpV2
        7O9b2OvG8iK0QQAs9rrGxphvvAq8dc+PeyZTczYccjqXUqVA3qdZMTtLv0pJnI5JieGhc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqyPG-0001LW-I2; Fri, 26 Jul 2019 11:29:02 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C04912742B63; Fri, 26 Jul 2019 12:29:01 +0100 (BST)
Date:   Fri, 26 Jul 2019 12:29:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, weicx@spreadst.com, sherry.zong@unisoc.com,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] dt-bindings: spi: sprd: Change the hwlock support to
 be optional
Message-ID: <20190726112901.GC4902@sirena.org.uk>
References: <cover.1564125131.git.baolin.wang@linaro.org>
 <23d51f5d9c9cc647ad0c5a1fb950d3d9fb9c1303.1564125131.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline
In-Reply-To: <23d51f5d9c9cc647ad0c5a1fb950d3d9fb9c1303.1564125131.git.baolin.wang@linaro.org>
X-Cookie: List at least two alternate dates.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2019 at 03:20:53PM +0800, Baolin Wang wrote:
> No need to add hardware spinlock proctection due to add multiple
> msater channel, so change it to be optional in documentation.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl064/wACgkQJNaLcl1U
h9B7bgf/fakNc6GhblvBArHGpWpC8q89Ra3uoMipte1qypILuTKN7E62daZdcjYe
Gj8ANmdKpEkZw01Qst3bSW52x/rxSnP4/FHF/GJCtxtVd/KhM9n+JMMiA4qelyOM
cY9P5GmhDNrVFj1j0rVN0fJ9AIs2ac1dZi8J6CjLsQplr6EoxsimMv2Ajx3eE5rc
p2NLuwvU4iWW4IFm08HME8zJU5vJQB9kLRZedpZMl8ICP4O2gAbR34mHXmvaXdBE
NLETx7mZtKpC1l9H5DSE0t9172tDOceqcJIYwx+4grk8uwDPLvqXZ4UBk2ukvWSI
fgisQ7kn7VuWXe5GeA7R3roV8LUciw==
=6yRt
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
