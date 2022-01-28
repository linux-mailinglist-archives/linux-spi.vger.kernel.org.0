Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EFB49F4E6
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jan 2022 09:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbiA1IIV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jan 2022 03:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiA1IIU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jan 2022 03:08:20 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6387AC061714
        for <linux-spi@vger.kernel.org>; Fri, 28 Jan 2022 00:08:20 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6794E60010;
        Fri, 28 Jan 2022 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643357297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jPnJR32xLLkbiFVCd9L8Sm2uwU+IkeHFVLp2nHMmM2g=;
        b=ocm2jVYL8+4LeyO6T7WpjtSRUfHDZYytFmONdZpAzAEdkC2WIW8Y15xn++kov76fBDEGA4
        jSFnQVZrrgYVDzysc6fOlyKPxC/dXtfV0aosKNRxFEZMDNNK0VSqVi/DFmeVh1wbDRTHl7
        HZ7fRq4dVTv/HDmy0lS3ljP4RD7ibnECct85DIt3ntqw2l6k9OvlLmnuOClmlxdFc3VNzp
        9J29/fMi3AlXebEu1Js/mIlQ/JXj63vk8zqkGUV6h18IxsM+60We8pT8sVqqvxbkNQGADz
        aGQ2ZZKGuYNMtxtd52rYwNizxml7GD4z0S+Uc97bL49x5Hv1rC+iHqo6lGtRgg==
Date:   Fri, 28 Jan 2022 09:08:12 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v10 00/13] External ECC engines & Macronix support
Message-ID: <20220128090812.5b7a5982@xps13>
In-Reply-To: <YfL5ApsG7c619+R0@sirena.org.uk>
References: <20220127091808.1043392-1-miquel.raynal@bootlin.com>
        <YfL5ApsG7c619+R0@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Thu, 27 Jan 2022 19:56:50 +0000:

> On Thu, Jan 27, 2022 at 10:17:55AM +0100, Miquel Raynal wrote:
> > Hello all,
> >=20
> > I've applied the beginning of the series (bindings + ECC part) in a
> > branch named spi-mem-ecc on the MTD korg repository. I already applied
> > this second halve on top of the spi-mem-ecc branch but there was a
> > misunderstanding and they ended up not being fully reviewed. Hence here
> > there are once again, there are no changes since v9 beside the rebase. =
=20
>=20
> This looks good, please send a pull request.

Great thanks!

> In general for future reference if there's patches for one of my
> subsystems that I've not explicitly commented on I'm probably expecting
> to apply them.

Oh yeah this is very clear, but as this series heavily depends on some
core MTD changes as well, it was decided that everything would be merged
in one operation and that's why I started constructing the spi-mem-ecc
branch, which touches four different 'cores': nand, spi-nand, spi,
spi-mem.

Because of the last minute reviews right before the beginning
of the merge window I decided not to apply the second halve of the
series too quickly and delayed the whole patchset including the
previous patches which had no interest on their own.

> On Fri, Nov 26, 2021 at 03:10:59PM +0100, Miquel Raynal wrote:
>=20
> > If you acknowledge the SPI bits I believe I can carry the entire series
> > through the MTD tree. If you fear conflicts and need an immutable tag I
> > can also do that. =20
>=20
> It'd be good to have the tag just in case, there's generally a lot of
> work in this area.
>=20
> Reviewed-by: Mark Brown <broonie@kernel.org>

As three patches in this series were new/reworked I dropped your tag
there. I should have asked you again. Shall I add them (back) to the
following patches?

	spi: cadence-quadspi: Provide a capability structure
	spi: mxic: Provide a capability structure
	spi: spi-mem: Introduce a capability structure

Thanks,
Miqu=C3=A8l
