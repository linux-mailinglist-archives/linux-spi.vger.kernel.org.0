Return-Path: <linux-spi+bounces-9583-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF645B2F6E8
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 13:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06E23B9334
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CDA30F7E4;
	Thu, 21 Aug 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5usWGKA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA02C1FBEA6;
	Thu, 21 Aug 2025 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776103; cv=none; b=nrtt5CyinNGeJRevYWjh0cC2TTZRutXv23YrHfMwG5h0LAs46uPtMERVZ4CXqKT/UjmqNtfioQiYR2t4kQxxRdSvyheg2d//UwD5SgbLHA4VdH5PtapYSk6Y+VMf+CTo1fnnROk+8M12eEwuDE5AflLnwW7gFlLCcPTQdQAtB2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776103; c=relaxed/simple;
	bh=Mtgl0PdlBLAE8c0yy8tJp7Vtvf88Vj9PP/tXS+OYlo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8650kxnI5ISgnPbYrNwuNQfyeeF6DtACIV2meNsVNPX518bbW1ykuCJ6dJ8YyBNRqW/kfYKsijRc+zW4ptOOTWIwg6A8rzExkrzZddCdvu2Rzwt+SoKc4DtIfAvjFJpm9M8QwsT3VTDSO+ti3+G6QYy/MLxOxylp9M7wfVY95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5usWGKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBBDC4CEEB;
	Thu, 21 Aug 2025 11:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755776102;
	bh=Mtgl0PdlBLAE8c0yy8tJp7Vtvf88Vj9PP/tXS+OYlo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5usWGKAAO1lQsOx+rbsDR6gLbfmiGENVcU1hT+ZsyVVSBOaBXiQILxohvFDlax3H
	 WGHZS7z6Sna8K9FJ9MidFbpIxR/UR4baaXcusFHgHHLF8r/9AUwYe2OT78GNN35fGH
	 /GYXmSiWrWjmEo4sU/8Ki81WkELLfSUt/H99qa1t1e8Pt5g7BNu9uOmAdv1WARaaeh
	 JTv/cvB7QMlBRPJs5NRX51ynb2E37mjhnz1IO8VFe5ntIWcf4OEcnaS24InoScgOrJ
	 AsHDwF6x4xwxjg9k26a7kfD4anhPga9AotZyhLjOatcvf3p0IhIOfuuv3PxD1O1mxu
	 WBZM2qjU4WghA==
Date: Thu, 21 Aug 2025 13:34:58 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v3 00/14] spi: airoha: driver fixes & improvements
Message-ID: <aKcEYn_hX0ZIusne@lore-rh-laptop>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
 <aKbDjIZhJuWo3yFu@lore-rh-laptop>
 <7bca8089-09ad-4550-93d1-35a365bcd167@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x8+Rd9hZnvWmebul"
Content-Disposition: inline
In-Reply-To: <7bca8089-09ad-4550-93d1-35a365bcd167@iopsys.eu>


--x8+Rd9hZnvWmebul
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> On 21.08.2025 09:58, Lorenzo Bianconi wrote:
> >> This patch series greatly improve airoha snfi driver and fix a
> >> number of serious bug.
> >>
> >> Fixed bugs:
> >>  * Fix reading/writing of flashes with more than one plane per lun
> >>  * Fix inability to read/write oob area
> >>  * Fill the buffer with 0xff before writing
> >>  * Fix reading of flashes supporting continuous reading mode
> >>  * Fix error paths
> >>
> >> Improvements:
> >>  * Add support of dual/quad wires spi modes in exec_op().
> >>  * Support of dualio/quadio flash reading commands
> >>  * Remove dirty hack that reads flash page settings from SNFI registers
> >>    during driver startup
> >>
> >> Unfortunately I am unable to test the driver with linux at the moment,
> >> so only the following testing was done:
> > It seems to me this is quite an important rework of the driver. I would=
 prefer
> > to have some test results for this series. Are you able to run mtd_test=
 kernel
> > module for testing?
>=20
> I'll try to build latest openwrt with this patches=A0 and mtd_test kernel
> module and try it on one of our boards.

what board are you using for testing? If it is based on Airoha-7581 you cou=
ld
use the following repo for testing.

https://github.com/Ansuel/openwrt/tree/openwrt-24.10-airoha-an7581-stable

Regards,
Lorenzo

>=20
> Actually patches can be divided on to parts:
> * fixes of current driver (patches 1-10)
> * change of behavior to avoid reading flash page settings from SNFI
> registers during driver startup (patches 11-14)
>=20
> The changes are based on the code we are using for more than 3 years. I
> adapt it to latest linux/u-boot code.
>=20
> Up to now the only known issue appears on en7523 chips only. Here a
> corresponding patch description (not added to this series)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D spi: airoha:
> en7523: workaround flash damaging if UART_TXD was short to GND We found
> that some serial console may pull TX line to GROUND during board boot
> time. Airoha uses TX line as one of it's BOOT pins. This will lead to
> booting in RESERVED boot mode. It was found that some flashes operates
> incorrectly in RESERVED mode. Micron and Skyhigh flashes are definitely
> affected by the issue, Winbond flashes are NOT affected. Details:
> -------- DMA reading of odd pages on affected flashes operates
> incorrectly. Page reading offset (start of the page) on hardware level
> is replaced by 0x10. Thus results in incorrect data reading. Usage of
> UBI make things even worse. Any attempt to access UBI leads to ubi
> damaging. As result OS loading becomes impossible. Non-DMA reading is
> OK. =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>=20
> Regards,
> Mikhail
>=20
>=20
> >
> > Regards,
> > Lorenzo
> >
> >>  * Driver compiles without error.
> >>  * All changes were tested with corresponding u-boot driver. U-Boot
> >>    SpiNAND driver was modified as well to match linux-6.17-rc2 with
> >>    additional fixes for continuous mode.
> >>
> >> Changes v2:
> >>  * minor fix
> >>  * add comments to code
> >>
> >> Changes v3:
> >>  * add patch to prevent continuous reading
> >>
> >> Mikhail Kshevetskiy (14):
> >>   spi: airoha: return an error for continuous mode dirmap creation cas=
es
> >>   spi: airoha: remove unnecessary restriction length
> >>   spi: airoha: add support of dual/quad wires spi modes
> >>   spi: airoha: remove unnecessary switch to non-dma mode
> >>   spi: airoha: unify dirmap read/write code
> >>   spi: airoha: switch back to non-dma mode in the case of error
> >>   spi: airoha: fix reading/writing of flashes with more than one plane
> >>     per lun
> >>   spi: airoha: support of dualio/quadio flash reading commands
> >>   spi: airoha: allow reading/writing of oob area
> >>   spi: airoha: buffer must be 0xff-ed before writing
> >>   spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
> >>   spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG a=
nd
> >>     REG_SPI_NFI_SECCUS_SIZE registers
> >>   spi: airoha: set custom sector size equal to flash page size
> >>   spi: airoha: avoid reading flash page settings from SNFI registers
> >>     during driver startup
> >>
> >>  drivers/spi/spi-airoha-snfi.c | 508 +++++++++++++++++-----------------
> >>  1 file changed, 260 insertions(+), 248 deletions(-)
> >>
> >> --=20
> >> 2.50.1
> >>

--x8+Rd9hZnvWmebul
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKcEXgAKCRA6cBh0uS2t
rHlkAQCnnfXQhEwCqeyAoAXrliU5ohBl9ETMGPOldm648EN+fgEAvncAtUoj/911
w8qFdbO/bXNBPXs4NLY9ZsmLqe96dA4=
=SuZn
-----END PGP SIGNATURE-----

--x8+Rd9hZnvWmebul--

