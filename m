Return-Path: <linux-spi+bounces-2733-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2854A8BADA7
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 15:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925611F224BF
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D466815357A;
	Fri,  3 May 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sscqAnkw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44414A0AB;
	Fri,  3 May 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742419; cv=none; b=Wzs1vIfbMQkbuUYyoeIfJPLp7iZ4CJ/ad+w2HgWaP2vM3yweCHANppv1spmialBkUe+Yy3TGxJBCSac6PsZf9z9zZNj4BjXEm9MNf51gr2HfSImkPCg3W8ObH8/66nc9LyDV/8rJvgp3jpRBsOb2P4usSTDT6P+792eNfuhXx4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742419; c=relaxed/simple;
	bh=y8ACv/eZbhEwWdhd7+zMjvdVcezL22PFRTFmyeFY3Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euyuqVz0AKu52q6dATt5P1POjA7nzU1hPInNlMmqMTc9OkBO7vScSNOk9PUZYtJjZ2CmA82TAvftiRQPQ93DAq5LqGDePk+8tm3KkWaN41H61Ydo6mn8+d26BxIngLTnQ1my4dBh6ppsENn5RULcNjwFU+nFti8vGHaHNUTiLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sscqAnkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA3CC2BBFC;
	Fri,  3 May 2024 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714742419;
	bh=y8ACv/eZbhEwWdhd7+zMjvdVcezL22PFRTFmyeFY3Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sscqAnkwl4Tl311D/3B6x2XjiBli4iuNRThqjwmUvUjtrAbnTgOIq7aNfJa4V1xzp
	 nHpbyqXYYb4QtjB5kLNwFHaF1NcmNXnIhMgrrHdxA1UCGYOxcU8Du3qp+vOkq5GoL4
	 Wh2EkmL8rpxczOjYGQ0PzWJVMjadUdWrmgrxKyV3twK1OzqcSeHNGuX7jwZrMkrUO4
	 bpoPNJmnQ8JMTc3bF+zAqfp93Et+elf30qivCEZvy4ACIXlSoSI5eXsRDZiFh2RPY3
	 88M2RV94M8VE2+/Ju+uIq412DmVr8gOfHYnf9SueNAVCFNI9f+MfdDRYtetT8vzjZr
	 bvUJWDIYlP/Rw==
Date: Fri, 3 May 2024 15:20:15 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	conor@kernel.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org,
	dd@embedd.com, catalin.marinas@arm.com, will@kernel.org,
	upstream@airoha.com, angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v6 3/3] spi: airoha: Add spi-nand flash controller driver
Message-ID: <ZjTkj30SxYeTKTA4@lore-desk>
References: <cover.1714571980.git.lorenzo@kernel.org>
 <08f55e89a1eb655402a748d700a023e1e27a194a.1714571980.git.lorenzo@kernel.org>
 <ZjRHSWEPbFijFXqT@finisterre.sirena.org.uk>
 <ZjTVaenC3xm-4-Ik@lore-desk>
 <CAHp75VcHuQ_7ZZQgysZOZ5TY=2pqC3uy_NoTF-iz6Wnu2cq2BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+yOtApDSoM3ooQfX"
Content-Disposition: inline
In-Reply-To: <CAHp75VcHuQ_7ZZQgysZOZ5TY=2pqC3uy_NoTF-iz6Wnu2cq2BQ@mail.gmail.com>


--+yOtApDSoM3ooQfX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, May 3, 2024 at 3:15=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.o=
rg> wrote:
> >
> > > On Wed, May 01, 2024 at 04:06:43PM +0200, Lorenzo Bianconi wrote:
> > > > Introduce support for spi-nand driver of the Airoha NAND Flash Inte=
rface
> > > > found on Airoha ARM SoCs.
> > >
> > > This doesn't apply against current code, please check and resend.
> >
> > Hi Mark,
> >
> > patch v6 3/3 has just a couple of cosmetic changes requested by Andy wi=
th
> > respect to v5 3/3.
> >
> > @Andy: do you think we can drop these changes or do you prefer to add t=
hem? (in
> > the latter case I can post an incremental patch).
>=20
> I am not sure what this is about, do you mean the changes asked by me
> made this driver not applicable?
>=20

These are the only changes between patch v5 3/3 (applied by Mark) and patch=
 v6 3/3:

--- /tmp/spi-airoha-snfi.c	2024-05-03 15:13:35.020903623 +0200
+++ drivers/spi/spi-airoha-snfi.c	2024-05-03 15:13:41.836924124 +0200
@@ -638,9 +638,9 @@
 					u64 offs, size_t len, void *buf)
 {
 	struct spi_device *spi =3D desc->mem->spi;
+	struct airoha_snand_ctrl *as_ctrl =3D spi_controller_get_devdata(spi->con=
troller);
 	struct airoha_snand_dev *as_dev =3D spi_get_ctldata(spi);
 	struct spi_mem_op *op =3D &desc->info.op_tmpl;
-	struct airoha_snand_ctrl *as_ctrl;
 	u32 val, rd_mode;
 	int err;
=20
@@ -661,7 +661,6 @@
 		break;
 	}
=20
-	as_ctrl =3D spi_controller_get_devdata(spi->controller);
 	err =3D airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
 		return err;
@@ -768,13 +767,12 @@
 					 u64 offs, size_t len, const void *buf)
 {
 	struct spi_device *spi =3D desc->mem->spi;
+	struct airoha_snand_ctrl *as_ctrl =3D spi_controller_get_devdata(spi->con=
troller);
 	struct airoha_snand_dev *as_dev =3D spi_get_ctldata(spi);
 	struct spi_mem_op *op =3D &desc->info.op_tmpl;
-	struct airoha_snand_ctrl *as_ctrl;
 	u32 wr_mode, val;
 	int err;
=20
-	as_ctrl =3D spi_controller_get_devdata(spi->controller);
 	err =3D airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
 		return err;
@@ -885,12 +883,12 @@
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	struct airoha_snand_dev *as_dev =3D spi_get_ctldata(mem->spi);
+	struct spi_device *spi =3D mem->spi;
+	struct airoha_snand_ctrl *as_ctrl =3D spi_controller_get_devdata(spi->con=
troller);
+	struct airoha_snand_dev *as_dev =3D spi_get_ctldata(spi);
 	u8 data[8], cmd, opcode =3D op->cmd.opcode;
-	struct airoha_snand_ctrl *as_ctrl;
 	int i, err;
=20
-	as_ctrl =3D spi_controller_get_devdata(mem->spi->controller);
 	if (opcode =3D=3D SPI_NAND_OP_PROGRAM_EXECUTE &&
 	    op->addr.val =3D=3D as_dev->cur_page_num) {
 		as_dev->data_need_update =3D true;
@@ -965,11 +963,9 @@
=20
 static int airoha_snand_setup(struct spi_device *spi)
 {
-	struct airoha_snand_ctrl *as_ctrl;
+	struct airoha_snand_ctrl *as_ctrl =3D spi_controller_get_devdata(spi->con=
troller);
 	struct airoha_snand_dev *as_dev;
=20
-	as_ctrl =3D spi_controller_get_devdata(spi->controller);
-
 	as_dev =3D devm_kzalloc(as_ctrl->dev, sizeof(*as_dev), GFP_KERNEL);
 	if (!as_dev)
 		return -ENOMEM;
@@ -994,10 +990,9 @@
=20
 static void airoha_snand_cleanup(struct spi_device *spi)
 {
+	struct airoha_snand_ctrl *as_ctrl =3D spi_controller_get_devdata(spi->con=
troller);
 	struct airoha_snand_dev *as_dev =3D spi_get_ctldata(spi);
-	struct airoha_snand_ctrl *as_ctrl;
=20
-	as_ctrl =3D spi_controller_get_devdata(spi->controller);
 	dma_unmap_single(as_ctrl->dev, as_dev->dma_addr,
 			 as_dev->buf_len, DMA_BIDIRECTIONAL);
 	spi_set_ctldata(spi, NULL);
@@ -1049,12 +1044,6 @@
 	.max_register	=3D REG_SPI_NFI_SNF_NFI_CNFG,
 };
=20
-static const struct of_device_id airoha_snand_ids[] =3D {
-	{ .compatible	=3D "airoha,en7581-snand" },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, airoha_snand_ids);
-
 static int airoha_snand_probe(struct platform_device *pdev)
 {
 	struct airoha_snand_ctrl *as_ctrl;
@@ -1114,6 +1103,12 @@
 	return devm_spi_register_controller(dev, ctrl);
 }
=20
+static const struct of_device_id airoha_snand_ids[] =3D {
+	{ .compatible	=3D "airoha,en7581-snand" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, airoha_snand_ids);
+
 static struct platform_driver airoha_snand_driver =3D {
 	.driver =3D {
 		.name =3D "airoha-spi",

As you can see the only differences are your comments about patch v5 3/3:
- initialize struct airoha_snand_ctrl *as_ctrl initialization as we did
  for struct airoha_snand_dev *as_dev pointer.
- move struct of_device_id airoha_snand_ids below airoha_snand_probe routin=
e.

My question is if we can drop those changes (they are just cosmetics) or do
you prefer to add them as incremental patch.

Regards,
Lorenzo

>=20
> --=20
> With Best Regards,
> Andy Shevchenko

--+yOtApDSoM3ooQfX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZjTkjwAKCRA6cBh0uS2t
rG67AQCCeqn+NBSKMNbpU3BSlxsZhOoX3ggqhuSSqGMrX8zXpgEA+Begx9xwfp7y
UZc5nEg9/HPAyQ7Dr1hVa0YzIDAIGQg=
=JUI+
-----END PGP SIGNATURE-----

--+yOtApDSoM3ooQfX--

