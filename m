Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419411F6625
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 13:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgFKLCV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 07:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgFKLCP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 07:02:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E0A2063A;
        Thu, 11 Jun 2020 11:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591873334;
        bh=nuPUldf+Kf9CVAl9O34INN3TkphjdnE+85M+SwBPsnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gr7nGsgwaThhJknKPxLByb4nU7feVUzvO9XloD1l+jph11hLEJ7NBi1mXMAg096Tp
         G42gjYb5+mHF5DNfP1QLJETMF1U3wzaxqAZhPfbahyixFcoT+j1Pjg9VxzyezdoIhq
         dqabrDr1qq85AWPxOqlH9BCdg+IUgK1I/aX7H9l8=
Date:   Thu, 11 Jun 2020 12:02:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH 4/6] spi: altera: use regmap instead of direct mmio
 register access
Message-ID: <20200611110211.GD4671@sirena.org.uk>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
 <1591845911-10197-5-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <1591845911-10197-5-git-send-email-yilun.xu@intel.com>
X-Cookie: I like your SNOOPY POSTER!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2020 at 11:25:09AM +0800, Xu Yilun wrote:

> +	if (pdata && pdata->use_parent_regmap) {
> +		hw->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +		if (!hw->regmap) {
> +			dev_err(&pdev->dev, "get regmap failed\n");
> +			goto exit;
> +		}
> +		hw->base = pdata->regoff;

This seems very confused - there's some abstraction problem here.  This
looks like the driver should know about whatever is causing it to use
the parent regmap, it shouldn't just be "use the parent regmap" directly
since that is too much of an implementation detail.  This new feature
also seems like a separate change which should be in a separate patch,
the changelog only talked about converting to use regmap which I'd have
expected to be a straight 1:1 replacement of non-regmap stuff with
regmap stuff.

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7iDzMACgkQJNaLcl1U
h9DSDwf/a4sctmQVriGdxN8iwxuXftWGcODaBuBquFiDTHkID3HGDWyM3F8kl43W
7uKBlEwY8WrHcnjd4uCjGVLhHNOlWCeev4shAo4Z0V59rCpOZ5n1TNpX2fkGdqWL
9q2S6TpToXXJaEz7dU9prBbLRPMogWyG486n3/fyfmehUkW3jirIk+uh0qxP7vR+
waYSe2I+HI9P+G2JRSZgadgEubNWrsItn6r7czty0Y7aEy1Hoxm+GViSmGCUDpG7
cdyJT/f6YKdo+oeuvkEkYCdemrxbwxs3RzDBgT/fWQip+dz+s3xWDjeT/Oo2T9+4
SYzdCf18XBXYwijvplcOWyQCq0n9RA==
=/4g0
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
