Return-Path: <linux-spi+bounces-6047-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8C29F0A48
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 12:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97B416A39B
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6351C07F0;
	Fri, 13 Dec 2024 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Tp6VIkKZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCDE1B6D0F
	for <linux-spi@vger.kernel.org>; Fri, 13 Dec 2024 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087642; cv=none; b=FS7XX3x9DYykF9fHh5eB6ImzjPoV2jXpsCBb/MVx78Pt9rcQEUTsQA/sX7qqcd7sJb0kdtc+OPnS1tpBLsd7BhFTKy2tn6WnGjFn0IPnzMgzttu0RksbXAfmdY5IuoZEYYow+FxrElmBfx7qB+hjlybGisX0JwVxKH9ePo5v+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087642; c=relaxed/simple;
	bh=ghJfDJQrGb+JKsXHfSOnVUgL6QGG/gcoCMUQJblVAao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SrRNsMd4eCeO2qowqS4zetjRuExF0A6bxS6sonWx5A6VUSJrUQlwsQVkXlGyuw1DcxgrPD06r+68IIpAmi19ikhsDInXoq/8UlkntX6Qrf0ovnKRZA8WBjr8uZ+W2IPX4Ml8P6FKZIfZ4ij3WeG46qcczU1ONJKzlCAheQTvF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tp6VIkKZ; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 463041BF20A;
	Fri, 13 Dec 2024 11:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734087637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghJfDJQrGb+JKsXHfSOnVUgL6QGG/gcoCMUQJblVAao=;
	b=Tp6VIkKZy9QbAgzj3iKljiho8FI4dat8C5c4dTsghYv45TS3cslQRGDzjQ33++zisBK0OR
	wj7XMyehPZ46GIxO+4C9sLv5aXwBfZt5XCLT/lXy9Q6n33oamTHhXCAf/6y6nTRDCfrFSF
	48EWMx9Tm2deDjxV02dDR7Vl5ZnjsMxF/9F8q1wxpyn/UXdAjO0d+39XMySlibc/6xwxEN
	WZ2FCJSAHDhQ24XDFJLoIrzyftMSbpJO1NTAA8eYSnuaaOZ4OX2cCKc7F73hji/KowzdoA
	BEj8PDB2VfNvsMXbXWas1ISN18F2j8pmfJ9X3X/Gdsf4QU9eDBcrxFx3UCMiiw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <michael@walle.cc>,  linux-mtd@lists.infradead.org,  Mark Brown
 <broonie@kernel.org>,  linux-spi@vger.kernel.org,  Steam Lin
 <stlin2@winbond.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Sanjay R Mehta <sanju.mehta@amd.com>,  Han Xu <han.xu@nxp.com>,  Conor
 Dooley <conor.dooley@microchip.com>,  Daire McNamara
 <daire.mcnamara@microchip.com>,  Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Haibo Chen
 <haibo.chen@nxp.com>,  Yogesh Gaur <yogeshgaur.83@gmail.com>,  Heiko
 Stuebner <heiko@sntech.de>,  Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 02/24] spi: spi-mem: Add a new controller capability
In-Reply-To: <59d350f3-73f7-411a-9ab2-0b2eee5247b0@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Nov 2024 13:18:36 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-3-miquel.raynal@bootlin.com>
	<59d350f3-73f7-411a-9ab2-0b2eee5247b0@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 13 Dec 2024 12:00:35 +0100
Message-ID: <878qsjonjg.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Tudor,

>> Among all the spi-memory controllers, I believe all are capable of
>
> nit: SPI memory? or spi memory? but no "-" I think

...

>> changing the spi frequency on the fly. Some of the drivers do not make
>> any frequency setup though. And some others will derive a per-chip
>
> nit: s/per-chip/per chip?

...

>> pre-scaler value which will be used forever.
>
> nit: s/pre-scaler/prescaler?

...

>> + * @per_op_freq: Supports per-operation frequency switching
>
> nit: s/per-operation/per operation?
>
> If you fix the bug that you identified you can add my R-b tag,
> regardless if you address these nits or not:
>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

No idea why I like '-' so much. I removed them all as advised :-)

Thanks!
Miqu=C3=A8l

