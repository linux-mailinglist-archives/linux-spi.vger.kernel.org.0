Return-Path: <linux-spi+bounces-86-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E5D7FD11F
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 09:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9401C20F02
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB2F111B5;
	Wed, 29 Nov 2023 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mFQLKk5s"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A8A1BD9;
	Wed, 29 Nov 2023 00:40:32 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 707364000B;
	Wed, 29 Nov 2023 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701247231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4WHEu2UhaCM6cUWSOjsX+5/aR0VdKdzzHzZ2V8osTk=;
	b=mFQLKk5sZBWrCJqIdxGBpDdZukBQ9RPNMxydeLHeMGtsOj6GxRQ6s6Yv42M5B9yiATn2eD
	nAfzCSN/4dZgSM1jznBDMwyWf6CNZRLf1pPnuCechP4ocpmTeHrTkppsWzeng/Pdg0rcBX
	TOhfy++gFRC5Nx1QQRqQVm1xrA9yJAn+mRkUjOjBd9uMaoN5NCze5jR5+UkFJwbp7iTm6N
	QagP+l6Nw5O6ec7CoyHGmuUQoz3wPmtfgJ1WW6HLymibXrhA+i7zThdml212j1ef2p+7fj
	G31N0HM3zeULewamC5GzuCMoVP56x57IGbxeVpfK4iwCqwASpJ0lCsihCACIUw==
Date: Wed, 29 Nov 2023 09:40:26 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Michael Walle <michael@walle.cc>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Dhruva Gole <d-gole@ti.com>,
 linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>, Kamal Dasu
 <kamal.dasu@broadcom.com>, Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?=
 <j.neuschaefer@gmx.net>, Mario Kicherer <dev@kicherer.org>, Chuanhong Guo
 <gch981213@gmail.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] mtd: spi-nor: Stop reporting warning message
 when soft reset is not suported
Message-ID: <20231129094026.4dee1cb1@xps-13>
In-Reply-To: <20231129064311.272422-2-acelan.kao@canonical.com>
References: <20231129064311.272422-1-acelan.kao@canonical.com>
	<20231129064311.272422-2-acelan.kao@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi AceLan,

acelan.kao@canonical.com wrote on Wed, 29 Nov 2023 14:43:11 +0800:

> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
>=20
> When the software reset command isn't supported, we now stop reporting
> the warning message to avoid unnecessary warnings and potential confusion.
>=20
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

