Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0225CE01EF
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2019 12:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfJVKUL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Oct 2019 06:20:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46964 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKUL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Oct 2019 06:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ru1ltVsskPwiYq/hZGwXqqIVvv9S26L5XBBOMkAelow=; b=PyNW0zpNmmPq45vuHcHIS2a8M
        7vTvNO4Ft1kzgga9K1rQRIID2sSCHqZVrV503edrbcurdXdz9WXPGhiBCcRAP6MmcJd1hzAFTwx0A
        4yOLJlNL/EkvbKwiIa/Mx4tu+P1t7xjUdzT6Atkyv/qOrEMerPVWXVlJebSHct2yA1xPM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMrGr-0006MG-0Z; Tue, 22 Oct 2019 10:20:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5E7432743259; Tue, 22 Oct 2019 11:20:07 +0100 (BST)
Date:   Tue, 22 Oct 2019 11:20:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: xilinx: Add DT support for selecting transfer word
 width
Message-ID: <20191022102007.GA5554@sirena.co.uk>
References: <20191022090007.15147-1-alvaro.gamez@hazent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20191022090007.15147-1-alvaro.gamez@hazent.com>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2019 at 11:00:07AM +0200, Alvaro Gamez Machado wrote:

>  		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
>  					  &num_cs);
> +		ret = of_property_read_u32(pdev->dev.of_node,
> +					   "xlnx,num-transfer-bits",
> +					   &bits_per_word);
> +		if (ret)
> +			bits_per_word = 8;

Any new DT property needs documentation adding but in any case this
shouldn't be set in DT, it should be set by the client driver - it's
going to be a fixed property of the device, not something that varies
per system.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2u19QACgkQJNaLcl1U
h9C/Xgf+Pf4Zt25eKj9I51x2PMSfr9iDGEJtEtKuT2bXdSWyxgDjJkk5MKdkC8FH
6gjPB7+JAYnOl4cW+A+BCyxwsRPRUbpRwRLwzUVhy/ewniHoZvnRriaZpvWU9nSB
AU8+TJWnG2ejFomAVPjEW+pxBS57TrmpIcvVKWEfERuac+ju4I3X1cPikVE7qUnj
y8+62gXs+iY3jlLPmcAenuGxjCluU5bnWycxuxfT60nHrDfZDY1GilLbJ5rRfpav
5urr2CTlDiLFGc9eJXwK+IWzXaCqlT9t0nyZp8YajKXbeuY6yD9ZmTa8nZvhc8AF
W+gDo4sCefK26pWP23I9HrgM8KJ7WA==
=bjqZ
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
