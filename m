Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C9C506C0C
	for <lists+linux-spi@lfdr.de>; Tue, 19 Apr 2022 14:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbiDSMQI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Apr 2022 08:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbiDSMP5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Apr 2022 08:15:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0569C52
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 05:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58B55B81185
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 12:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5340CC385A8;
        Tue, 19 Apr 2022 12:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650370385;
        bh=FzB9R4QNdtle8G5es3X6MThPPUPCJpMLRg4hyaJlBQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWJGvi/jytrDuGlM5FSavn5RIkiTwr07ACM995obH4t8uuuVivW0CbedGWOuDCKnq
         27FV9Zi3l5J5im79ASlXyvYHMLvMm3lNYXlwezt5s/3h1JpSbi1425kvuwvVaaSUgn
         X7KAxxnT9jLw0PgDiNUvbuCar3P4FbbwGkK3wr2wZ+2rayjy7kzLukUV2816zSZh2r
         /0h9qvl3no4cHgMwXJMLGElcdwLMJM7xLEc2jWf460Xm3HMdKPiwH47W3qMhovJrvq
         NVZxYKY9ytNaDZv2QcwxGuTvnm0qzXD3coO0u2bXeGhdOHFIdBTi7DBNq4hc1OGDXd
         aff6G+DJNy4yw==
Date:   Tue, 19 Apr 2022 13:12:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Hongli Li <hongli.li@intel.com>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] spi: intel: Implement dirmap hooks
Message-ID: <Yl6nS0kSdSGOCYM3@sirena.org.uk>
References: <20220411113158.2037-1-mika.westerberg@linux.intel.com>
 <20220411113158.2037-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CJk5db7UBq5CSMUG"
Content-Disposition: inline
In-Reply-To: <20220411113158.2037-2-mika.westerberg@linux.intel.com>
X-Cookie: You buttered your bread, now lie in it.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--CJk5db7UBq5CSMUG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2022 at 02:31:58PM +0300, Mika Westerberg wrote:
> Currently the driver goes over the supported opcodes list each time
> ->exec_op() is called and finds the suitable for the given operation.
> This consumes unnecessary amount of CPU cycles because the operation is
> always the same. For this reason populate dirmap hooks for the driver so
> that we cache the selected operation and then simply call it on each
> read/write.

This breaks an x86 allmodconfig build:

/build/stage/linux/drivers/spi/spi-intel.c: In function =E2=80=98intel_spi_=
dirmap_read=E2=80=99:
/build/stage/linux/drivers/spi/spi-intel.c:808:38: error: passing argument =
2 of =E2=80=98iop->exec_op=E2=80=99 from incompatible pointer type [-Werror=
=3Dincompatible-pointer-types]
  808 |         ret =3D iop->exec_op(ispi, desc->mem, iop, &op);
      |                                  ~~~~^~~~~
      |                                      |
      |                                      struct spi_mem *
/build/stage/linux/drivers/spi/spi-intel.c:808:38: note: expected =E2=80=98=
const struct intel_spi_mem_op *=E2=80=99 but argument is of type =E2=80=98s=
truct spi_mem *=E2=80=99
/build/stage/linux/drivers/spi/spi-intel.c:808:45: error: passing argument =
3 of =E2=80=98iop->exec_op=E2=80=99 from incompatible pointer type [-Werror=
=3Dincompatible-pointer-types]
  808 |         ret =3D iop->exec_op(ispi, desc->mem, iop, &op);
      |                                             ^~~
      |                                             |
      |                                             const struct intel_spi_=
mem_op *
/build/stage/linux/drivers/spi/spi-intel.c:808:45: note: expected =E2=80=98=
const struct spi_mem_op *=E2=80=99 but argument is of type =E2=80=98const s=
truct intel_spi_mem_op *=E2=80=99
/build/stage/linux/drivers/spi/spi-intel.c:808:15: error: too many argument=
s to function =E2=80=98iop->exec_op=E2=80=99
  808 |         ret =3D iop->exec_op(ispi, desc->mem, iop, &op);
      |               ^~~
/build/stage/linux/drivers/spi/spi-intel.c: In function =E2=80=98intel_spi_=
dirmap_write=E2=80=99:
/build/stage/linux/drivers/spi/spi-intel.c:824:38: error: passing argument =
2 of =E2=80=98iop->exec_op=E2=80=99 from incompatible pointer type [-Werror=
=3Dincompatible-pointer-types]
  824 |         ret =3D iop->exec_op(ispi, desc->mem, iop, &op);
      |                                  ~~~~^~~~~
      |                                      |
      |                                      struct spi_mem *
/build/stage/linux/drivers/spi/spi-intel.c:824:38: note: expected =E2=80=98=
const struct intel_spi_mem_op *=E2=80=99 but argument is of type =E2=80=98s=
truct spi_mem *=E2=80=99
/build/stage/linux/drivers/spi/spi-intel.c:824:45: error: passing argument =
3 of =E2=80=98iop->exec_op=E2=80=99 from incompatible pointer type [-Werror=
=3Dincompatible-pointer-types]
  824 |         ret =3D iop->exec_op(ispi, desc->mem, iop, &op);
      |                                             ^~~
      |                                             |
      |                                             const struct intel_spi_=
mem_op *
/build/stage/linux/drivers/spi/spi-intel.c:824:45: note: expected =E2=80=98=
const struct spi_mem_op *=E2=80=99 but argument is of type =E2=80=98const s=
truct intel_spi_mem_op *=E2=80=99
/build/stage/linux/drivers/spi/spi-intel.c:824:15: error: too many argument=
s to function =E2=80=98iop->exec_op=E2=80=99
  824 |         ret =3D iop->exec_op(ispi, desc->mem, iop, &op);
      |               ^~~
cc1: all warnings being treated as errors

--CJk5db7UBq5CSMUG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJep0sACgkQJNaLcl1U
h9CXGwf/Z1pNpFk1a+5idHEjLLL6oaCXehYuZoV/e6gpbbu1B6lTVA4JPe6ueaMJ
9FUxFE2D2gKbRauWSpbEOrPpiRuuwAENeeoO/AemFcWmQsS4O9uowL3OZ0bYqzt+
KKOK5CmPbqbd6qbaqvG0we82qBzYQAH99LtExpivHqAFHYxY4/aXLxHF98p56qVA
DOZ+Sl+cxVC+ez8YkLRtmREMOIwba60swMU6IM/Z/fYW7EvHyzdskOpClz45BsSx
rVf9w7eht7B3FIXUTIN90VMz+e0jz60+KbaQGKVkZ/jkvexfOvicQQSOZpEvW5Cy
fhgNatLNzmF0ms/KCmmRy7i8GjgKyQ==
=rXOb
-----END PGP SIGNATURE-----

--CJk5db7UBq5CSMUG--
