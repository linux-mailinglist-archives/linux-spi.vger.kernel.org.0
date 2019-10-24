Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2E3E2EB5
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 12:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407656AbfJXKXx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 06:23:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36720 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407344AbfJXKXx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 06:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8n+XLVyUobbc+/UmO7NjLUyrQevv80urDK3GZxqpQ8E=; b=c4+X8gj4RYEx2KngkvDNoMu8B
        Qjg8qvJqJ3godFzdWeP6qKmKU+4+ZXMinY7nH0VPiUWYYsybJmHa79Yv8qBIA4h0mUODNGCSWskBX
        D9pHA2GDiVOGL+wQfolwtQX6/P6W3bTxSSiGofTNVMneqBFVInRgAx3OVY5YQ9vS1h7WQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNaHT-0003IF-Ey; Thu, 24 Oct 2019 10:23:47 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C583027428E5; Thu, 24 Oct 2019 11:23:46 +0100 (BST)
Date:   Thu, 24 Oct 2019 11:23:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     luhua xu <luhua.xu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH 1/1] spi: mediatek: add power control when set_cs
Message-ID: <20191024102346.GB5207@sirena.co.uk>
References: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
 <1571834322-1121-2-git-send-email-luhua.xu@mediatek.com>
 <20191023151121.GC5723@sirena.co.uk>
 <1571898319.4311.3.camel@mbjsdccf07>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <1571898319.4311.3.camel@mbjsdccf07>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 02:25:19PM +0800, luhua xu wrote:

> Spi framework provideds  spi_setup() to modify spi settings for spi
> device (maybe spi is runtime idle now), and this will call
> spi_controller->set_cs() accessing registers.

OK, so fix that so it takes the power at the setup() level then.

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2xe7EACgkQJNaLcl1U
h9BupAf/enXFS1bm5HhfceiQntahs4gT3FPXaEDsQ+rJ2S90V4JwcUbi1oSpDvWj
w2OeywscDvkZdcEaQtre4ZASwvSefR01VajXmtigEOPry80kECDHAKGiSKVXBSJ/
9V9Qf/dFBi0ej5+/Nw+3wEGXN75TgQ472XrOoHykyWerqXI4qjnUWyCXTQXO7Asn
hzr9BF9bL/1BGCUG+eK86VPC7sG9bCaQL8pvn3VFHiTgiSfCdMlIIK24LfAMjS7x
/NfY0ARLNoF1MvvTbBHHGHbG1d1pp+FeqEo+Yj+5CgIvo390+KgCjSqhzTv+PQ4Z
RglXSQMhEAM9OExTQLMO86LCuoiC+Q==
=Qdg5
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
