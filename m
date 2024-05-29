Return-Path: <linux-spi+bounces-3123-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD2D8D3680
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 14:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE521B20FDE
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 12:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C758181306;
	Wed, 29 May 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aaYYDV1F"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68DC13F45C;
	Wed, 29 May 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986133; cv=none; b=qF1P7AXGD6rtFxLk1qSBKsFI67rFGeL/VFaUoYH3NcbaUdOwe1U2JgOLAuOGpEqxmClzF1H/97a5XR+tILCNLC6BSRk3gSQpVnVNkNn56dQiSaPZ/lFsL6jBaBV9nmR+axb5v/O3GE4hzuHBl6fv50x6yXEmH1moQADK+RifbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986133; c=relaxed/simple;
	bh=0JlbSlo5riKFwe8ZzyJD7KlN1OTLvRfyEC2YgaDeV/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB5AG6VdGX8H3nY7VczhWvzI+sAXwhF5ljBNZ8tok4TBRXzMj789fGu1TY/2n6tGZ1blsMZGPoucGJSRb6pHh6eZeoNeG7OCsbPylBlyI8tqkvtD/Q1zcj2FcmgIDN2M9kurTfG6nrMIukWh5bEQzBFslcyyoDYlaeSF0b0l2co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aaYYDV1F; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716986130;
	bh=0JlbSlo5riKFwe8ZzyJD7KlN1OTLvRfyEC2YgaDeV/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aaYYDV1FYkUl6f+SzuqplR72lQN5HB/GfHhzddQCo8OLVTxi1F2UlOyLJo9eGUjgk
	 iq1kVbSEa9mZj1Rbr1+qlrwYmNCJXHC/dEWM+dTzyanuN4Km/dy1EY/6v4Q9vE9GgI
	 9h5dcHbVU1cS5Q10mnHPYAcR0wZZM8BZjeKMqy9ENy++JryAY98iW6tU6h+k2pPUy7
	 tbkYVzM/2/SJc5/uGfjY/dY2ZHVCYkLdG/n4QLh9OWzAXXTQkFwR7w5hmehwCLSUmY
	 d6l2Bd7OzNBLsJQFNbrSaCn1uRF8d/eoUQmzm9EnYycugRSKHwhBt+RN43TkMYChZs
	 C+VzbYAGTM9VQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 27206378000A;
	Wed, 29 May 2024 12:35:29 +0000 (UTC)
Date: Wed, 29 May 2024 08:35:26 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 2/2] spi: Check if transfer is mapped before calling
 DMA sync APIs
Message-ID: <60691eb7-ca16-4547-8744-f9bfae919a3f@notapiano>
References: <20240522171018.3362521-1-andriy.shevchenko@linux.intel.com>
 <20240522171018.3362521-3-andriy.shevchenko@linux.intel.com>
 <4748499f-789c-45a8-b50a-2dd09f4bac8c@notapiano>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4748499f-789c-45a8-b50a-2dd09f4bac8c@notapiano>

On Wed, May 22, 2024 at 02:41:51PM -0400, Nícolas F. R. A. Prado wrote:
> On Wed, May 22, 2024 at 08:09:50PM +0300, Andy Shevchenko wrote:
[..]
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index f94420858c22..9bc9fd10d538 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1220,6 +1220,11 @@ void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
>         spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);
>  }
> 
> +/* Dummy SG for unidirect transfers */
> +static struct scatterlist dummy_sg = {
> +       .page_link = SG_END,
> +};
> +
>  static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
>  {
>         struct device *tx_dev, *rx_dev;
> @@ -1258,6 +1263,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
>                                                 attrs);
>                         if (ret != 0)
>                                 return ret;
> +               } else {
> +                       xfer->tx_sg.sgl = &dummy_sg;
>                 }
> 
>                 if (xfer->rx_buf != NULL) {
> @@ -1271,6 +1278,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
> 
>                                 return ret;
>                         }
> +               } else {
> +                       xfer->rx_sg.sgl = &dummy_sg;
>                 }
>         }
>         /* No transfer has been mapped, bail out with success */

Hi Andy,

I can send this patch to the list myself with your authorship, I just need your
SoB.

Thanks,
Nícolas

