Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97A1E1EF8
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2019 17:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391653AbfJWPLj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Oct 2019 11:11:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48642 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390140AbfJWPLj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Oct 2019 11:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CFlPf+0Bqqc/DNWZaN1DVp0k7e+Yp/Tsp5TFWxhBZs8=; b=U9m0ZiHax9S1avQBBTw9dmxLA
        +2uG08eOR+JihrKXYnJtB7UMDACgBMRXUYOfFzhYtbT7NR3xhkr2+fPhiybolm/lZK+LmfCGbXj5Z
        SGcdauL4wYj87bsJV/1DTM5W9YQA5QGdnx4vcD14c7TmmVIUnu+/2vAKhDimwNAWlIHYQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNIIQ-0000pH-7I; Wed, 23 Oct 2019 15:11:34 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B561A274301E; Wed, 23 Oct 2019 16:11:33 +0100 (BST)
Date:   Wed, 23 Oct 2019 16:11:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Luhua Xu <luhua.xu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH 0/1] Add spi power control when set cs
Message-ID: <20191023151133.GD5723@sirena.co.uk>
References: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 08:38:41AM -0400, Luhua Xu wrote:
> This patch add power control when set spi cs to fix register
> access violation.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2wbaQACgkQJNaLcl1U
h9AZ8wf/YsPE4g2DB7vKBwqbkxq/ALWspomqahnmYRS1ybVmFae84b4Y3Xzplke5
VU7AJlcmslaIf2Js7txBb4HlATcKiqZlF0TsqOiIsw2Q4/rS0hJBFZ6DLVuLrwwz
dtvRrTurDuYVBo5Empbka7kYAgowqqZxwcqWVAPXHcx6C2wbdOO7VmQmxsMD/VvX
qWJ2DgEFIps2ZKsofdbLOK+iVaQFVcsT3mo/X/TfFz7zWB0GEglAXVUixrD8iqRZ
LRok6FnVsK+vVRasKGCp9c9Thjb3+DPfx64ONurPnRphX6RkYHSb4EgTlecjgOVj
+g+CiFeIDbyPWJaII6qEnmOs/OwejA==
=MGjC
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
