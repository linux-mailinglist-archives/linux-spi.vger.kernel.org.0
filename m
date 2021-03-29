Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E234D46E
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 18:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhC2QB1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 12:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhC2QBD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 29 Mar 2021 12:01:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70E3661924;
        Mon, 29 Mar 2021 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617033663;
        bh=rQV5AbU1TqIJq6Dn7PUWlS4xbiMTRSbnOLaIFDxk4nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSXbHPt6NDGPFALaopcViJuplIgega19/+JH6uN7YehWFjUqeDYA/0IrQWXZYcxC4
         txQzhbBvZbk1xhf5gsLR9gdG8PtYfTgjuWsNEFdiDeRKkqLFWlq0LDWGQ5e5nuEkZh
         /tACcSZeGG7clWAflLOGC2Hi1C2V2j3e1C/v25pPpHviun19XgJrEEOe5PmxQVwOBX
         Lc6lZCGG7EeApG3ofs0HjxlrYcTjB+ndNr58XQzcoFYXIs33xBYmnlHjIOgmoGYVLZ
         PKQVWpF6PvgxkkP6U1NprtAvjzXPYUipW7nxlN54InRTOfyV0LcID8gwG97666IVa/
         0T35oFCFhtLDQ==
Date:   Mon, 29 Mar 2021 17:00:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        fancer.lancer@gmail.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] dt-bindings: spi: cadence-qspi: Add support for
 Pensando Elba SoC
Message-ID: <20210329160052.GE5166@sirena.org.uk>
References: <20210329015938.20316-1-brad@pensando.io>
 <20210329015938.20316-11-brad@pensando.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <20210329015938.20316-11-brad@pensando.io>
X-Cookie: Never give an inch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 28, 2021 at 06:59:35PM -0700, Brad Larson wrote:
> Add new vendor Pensando Systems Elba SoC compatible
> string and convert to json-schema.

These are two unrelated changes and should be separate patches, again as
covered in submitting-patches.rst.  It is generally better to do the
changes adding new stuff first and then convert to YAML as the final
patches as the series since there is often a delay on reviews of YAML
conversions.

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBh+bMACgkQJNaLcl1U
h9CDbAf+L5QvrNeIedpULkACeq0jhTxi0Y/E94XfZCTThCINeFIpwUVDK0V7kt2a
7PJs3B5yElvcuw01MD/9GfQECCB4F85Sms98L0hKXeylxUEc28OOx4FLqc3MtXVD
OxhFuGu5WD4acijFRarcUdRw4rg330n9CaEMCW9O6xSMaGVgb8wyrTBnFxTlj+Iz
MqCsVF0o2XMc+v+e0eycS0JN1mhjPgk94mWfoQyBevJfQN/KCBFUcR39y2K8f3AK
q9PDB46BgqVrx88Oqf+txM+0BsWLeiHND8WhwL6pDkHhzvVpol7A5vLkZNSC2K62
UExFTAl9MFU1sVTB9r55dHrJ4mrtjA==
=P4y3
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
