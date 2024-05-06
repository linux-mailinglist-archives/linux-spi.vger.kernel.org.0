Return-Path: <linux-spi+bounces-2753-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4838F8BD0CB
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 16:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049B728DEF6
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806E7153822;
	Mon,  6 May 2024 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M/Hp8vbq"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87078153811;
	Mon,  6 May 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007222; cv=none; b=T0yCrM6FBzEHSSWcpkjUEkzarn6LE19updVpyi43LMNqa30K1BhJxx1KXaGloun1bxMXeDOv1iCFo6ZP2SAxAzUZP4HXLJMo9xsGAIJf6E13fPJ6iGNywfdJpEizWOPFwsOGK5vZmRzTH8bHtazW8Jc2TdsP83xLMXoa/jIGcrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007222; c=relaxed/simple;
	bh=VqwS8HLlclFcMgXtUlE14xVFAIrbzqdqBf23L1eAVIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5Inl53CgF1pRZefyrwCBy1vF6KQeDahp/X1VoJd+1nMEHJvGnWnTd7mrJOPQh0ysP85zRZz7xISrlFlHhBp+n6gnCQNyFrgzvXkNloq31MOav2MYJ07IVKn39gXQRPxZ3nwRcUC6zgSebFYqnVGIRUQIBnWarO9w4nsP7LkyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M/Hp8vbq; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DBBC1C0002;
	Mon,  6 May 2024 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715007217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gE9sVWIpmtf/xp/E4mNpiGxkkhDUpOJ02B6qf1T2ziA=;
	b=M/Hp8vbqXojVBUVgaulLG7GU9Zp9DgtpWSDP/uaekzkwyNUlQy9jkJ514QtsEfoakG0kV7
	q2d0y1nqeakzPBFA36us8tYmwiNeUg6r/fF2MKxJvbYWfMLpYaOGvP7YuFPhM9i7nrbQVu
	k9MmzF0x6Lb9E4uVGAmpDET20+OIXCybVpGj9KIf9Z+k4vbD5mMbNsXq7kU8TcnOHWrpz/
	IdhuB8WQArTNpJj6rIp9FPNnr5FApG0o3CKbbOCMVYeSAv1Kjcjm2HwWPxeyR9/i2Ww5cZ
	zQwNcaMR1kznVbY6HfwRkiB2Vgl0HYQetxX4IaY8VIYX6gKlbfStH17HNEMaeA==
Date: Mon, 6 May 2024 16:53:36 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 yen-mei.goh@keysight.com, jeremie.dautheribes@bootlin.com
Subject: Re: [PATCH v2] spi: omap2-mcspi: Ensure that CS is correctly
 asserted when switching from MULTI mode to SINGLE mode
Message-ID: <20240506165336.6ab8213e@xps-13>
In-Reply-To: <20240506-fix-omap2-mcspi-v2-1-d9c77ba8b9c7@bootlin.com>
References: <20240506-fix-omap2-mcspi-v2-1-d9c77ba8b9c7@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Louis,

Minor nits below.

louis.chauvet@bootlin.com wrote on Mon, 06 May 2024 16:27:59 +0200:

> The OMAP2 support features a "multi" mode, where the controller

s/The //

> automatically sets the Chip Select (CS) when necessary. This mode allows
> for shorter delays between CS selection and word content, but the CS is
> always deasserted at the end.
>=20
> The default transfer_one_message function expects the last transfer of a
> message to keep the CS enabled. However, when two consecutive messages
> use "multi" mode followed by "single" mode, the chipselect is not enabled

Above you wrote Chip Select and CS, maybe you want to reuse one of them
to be more consistent?

> during the second message. This discrepancy causes the driver to time
> out.
>=20
> To address this issue, the CS is now reasserted for each new message that

				needs to be

> follows a "multi"-mode message. This change ensures proper CS handling
> and prevents driver timeouts.
>=20
> Fixes: d153ff4056cb ("spi: omap2-mcspi: Add support for MULTI-mode")
>=20

No new line needed here, but more importantly, I see no valid Git object
with this hash, can you double check?

> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
> Changes in v2:
> - Fix build error, I used the old API (master instead of controller)
> - Link to v1: https://lore.kernel.org/r/20240409-fix-omap2-mcspi-v1-1-f2b=
881ae196d@bootlin.com
> ---
>  drivers/spi/spi-omap2-mcspi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 7e3083b83534..dd514a7504ec 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1264,6 +1264,15 @@ static int omap2_mcspi_prepare_message(struct spi_=
controller *ctlr,
>  	struct spi_transfer	*tr;
>  	u8 bits_per_word;
> =20
> +	/*
> +	 * When the last transfer used multi-mode, the CS is not keep down by t=
he controller.

	   If the						 kept

> +	 * The default transfer_one_message expect that the last transfer of a =
message keep the CS

					    expects			               keeps

> +	 * active.
> +	 * Ensure that the next call to spi_set_cs will work as expected if sin=
gle-mode is used.
> +	 */
> +	if (mcspi->use_multi_mode)
> +		ctlr->last_cs[0] =3D -1;

Maybe you should use SPI_INVALID_CS?

> +
>  	/*
>  	 * The conditions are strict, it is mandatory to check each transfer of=
 the list to see if
>  	 * multi-mode is applicable.
>=20
> ---
> base-commit: dfca7eb7615116b696ecdc85417c9e2df0b546dc
> change-id: 20240408-fix-omap2-mcspi-a6b41142ad9a
>=20
> Best regards,


Thanks,
Miqu=C3=A8l

