Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6AB44D8CD
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 16:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhKKPEI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 10:04:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhKKPEH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 10:04:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CBC1610A2;
        Thu, 11 Nov 2021 15:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636642878;
        bh=uS7AjnXMAtTTLK2QXT7jX014gaj/3UVYVDR6aRPON98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5ovTJil3ubv82wwqLB2yw9MZ3IehldRT16BUotCXwAerMxBegV1j1cFwKBho2lVP
         QdNvgIHtBd4JA1W+FZ8Po7F1yz0RNmx8WSxykS6/IMoiBl6boZWXC/wqqntQ5Om+z8
         jsmQ0wzQbVdcMRKNF+jiN8oewSCzSZCJ1c7W1E14RaLbYZZBTWMf3SL1lydAG3e1Bb
         w9OZPkxydOKU94CwSJ7XS2JmheEy1iFBGnWFk3XdSh280A1kghB7IqeLMbtuDCuqhC
         WdaTF28E5D2F7mjlpkYZY5qflopmvCXXmGcS/m2keY+DZQJik8/DkKbuhQv0CKU3yK
         TI+/qiMTAku5g==
Date:   Thu, 11 Nov 2021 15:01:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     nandhini.srikandan@intel.com,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v3 1/5] dt-bindings: spi: Add SSTE support for DWC SSI
 controller
Message-ID: <YY0wOBoT7X//GfQ8@sirena.org.uk>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-2-nandhini.srikandan@intel.com>
 <20211111143108.pxovseqvm2ywmoc2@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="msY2aCMFe/FNn5o4"
Content-Disposition: inline
In-Reply-To: <20211111143108.pxovseqvm2ywmoc2@mobilestation>
X-Cookie: Teutonic:
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--msY2aCMFe/FNn5o4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 11, 2021 at 05:31:08PM +0300, Serge Semin wrote:

> BTW Mark, why not to have a generic DT-property which would set that
> flag automatically by the SPI-core subsystem seeing it's indeed a
> client device-property? For instance there can be some property like
> "spi-cs-toggle" DT-property which when specified for the particular
> SPI-client DT-node will make the SPI-core subsystem to set the

Anything like this is fundamentally part of the wire protocol for the
device, there's no need for an extra property on top of the compatible
for the device and the driver really, really needs to know what's going
on to avoid data corruption.  You could also use this feature together
with varying the word size as an optimisation at runtime (eg, do long
sequences of register writes in a single hardware operation by setting
an appropriate word length to cause the controller to bounce chip
select between writes).

> SPI_CS_WORD flag of the device mode? Like it has already been done for
> "spi-cs-high"/"spi-lsb-first"/etc.

I don't think either of those properties was a good idea, there's a
bunch of stuff in the older SPI bindings that don't make much sense.

--msY2aCMFe/FNn5o4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGNMDgACgkQJNaLcl1U
h9A69wf8DefUDl1wuH91X13IzD3bwWUOzWSPEV4LGsq2YCdUNo9VfRJ9L7e+J4Br
/1tkwFSlJhOVlrRAp66Ov/kVhM+Br8h+yCrLNuOHrBqDZFPIh2N5j6MSn0+QjZNB
SN2WX7vH2FErJLjvb4iMu+6cvYKes1K9X2yXWrHvdhvQ27EgOp+BcmrF14MtDh2Y
Y/zsuW/fYHAXqeRWPSghPLiU/mLM8Rk2Uy4nlmOPm3OB34otL2OCvo2n5hZlKr8b
VQVxRlA3iDMNi5dyaqKXWgupLo0CiVbY6FsdBM3DXm121jLoYFOoqbm46EEBbunq
MjOILfeaeIW0pK9oK3KIaiwhMFmyLA==
=kf7P
-----END PGP SIGNATURE-----

--msY2aCMFe/FNn5o4--
