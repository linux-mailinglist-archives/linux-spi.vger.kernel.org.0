Return-Path: <linux-spi+bounces-9911-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F18B43F75
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219EDA452F9
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FC11F0995;
	Thu,  4 Sep 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1lHhWKt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E79A1EEA54;
	Thu,  4 Sep 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996913; cv=none; b=ICZpCe6dXS6DPObl8xtX+Vilzw0xVL9DJll+UuovVN7biJn9H1aDnZvhtd6il/4b8nFw7Jz5pw3/dXIAGgaX0OVGd7LfvwnPy7tkDwIo068+Ree53w3G1DLALxpwUwHnrfG65GmbGlflf7HGShojYX1pr4URg3FEN5hS7ycqPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996913; c=relaxed/simple;
	bh=9cs235LQtrbaGvvGVIeGx02rjqKRETFU5vYJb9QKACM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mlYHohOwaoyC7VQd/jGtq7rGoDj+5Pz32t4bwmtYoXK/zxs33sbnVFS5gY/3CabTRjmoG64GftNqtJm3fVKu5rhtoFmQ6MF/ntdYUdqsxfg9FbXZWA3Nx9Ql55FpRRLMrj9OAz5PigD90G4pSaJ/dwL7Daj5mT2l+REYQA1mJhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1lHhWKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170E4C4CEF1;
	Thu,  4 Sep 2025 14:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996913;
	bh=9cs235LQtrbaGvvGVIeGx02rjqKRETFU5vYJb9QKACM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Z1lHhWKtuBLSoBswmKyVvFU0wKx5lGxd2yN+f028PiUXS6a7JaZiYGhIQYyp3A+ML
	 hDzw/IgTEDmmdP+QeqJFsuQp2k5AGQbmC9HscuSvb/kh1kovg3EZPzrTzAC/iISnnn
	 c7/01OB5fH/PvgAtn+0HIWbAWweW+7Uicjb82GYu5+dIMAW8qMmIYdLeBO+KcpulgW
	 u1lUYHzVCDI7FYteFfkHA9tECsmRZ2A063P+yVbIpUCm+EDtnMbBvMAUnRVOond+ru
	 kUhZUL4/6vWl+PF8PLXcUdo0RGk7Pkvqqx0Ra3eXgGlkceTnLPkPEYAtx1fMQ6W3+i
	 GTyK3vTmdcd8g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <miquel.raynal@bootlin.com>,  <broonie@kernel.org>,  <vigneshr@ti.com>,
  <marex@denx.de>,  <computersforpeace@gmail.com>,
  <grmoore@opensource.altera.com>,  <theo.lebrun@bootlin.com>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <praneeth@ti.com>,  <p-mantena@ti.com>,  <a-dutta@ti.com>,
  <u-kumar1@ti.com>
Subject: Re: [PATCH 3/4] spi: cadence-quadspi: Fix cqspi_setup_flash()
In-Reply-To: <20250904133130.3105736-4-s-k6@ti.com>
References: <20250904133130.3105736-1-s-k6@ti.com>
	<20250904133130.3105736-4-s-k6@ti.com>
Date: Thu, 04 Sep 2025 16:41:50 +0200
Message-ID: <mafs0ms7ath3l.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 04 2025, Santhosh Kumar K wrote:

> The 'max_cs' stores the largest chip select number. It should only
> be updated when the current 'cs' is greater than existing 'max_cs'. So,
> fix the condition accordingly.
>
> Fixes: 0f3841a5e115 ("spi: cadence-qspi: report correct number of chip-select")
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 447a32a08a93..da3ec15abb3e 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1722,7 +1722,7 @@ static const struct spi_controller_mem_caps cqspi_mem_caps = {
>  
>  static int cqspi_setup_flash(struct cqspi_st *cqspi)
>  {
> -	unsigned int max_cs = cqspi->num_chipselect - 1;
> +	unsigned int max_cs = 0;
>  	struct platform_device *pdev = cqspi->pdev;
>  	struct device *dev = &pdev->dev;
>  	struct cqspi_flash_pdata *f_pdata;
> @@ -1740,7 +1740,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
>  		if (cs >= cqspi->num_chipselect) {
>  			dev_err(dev, "Chip select %d out of range.\n", cs);
>  			return -EINVAL;
> -		} else if (cs < max_cs) {
> +		} else if (cs > max_cs) {

Makes sense. Out of curiosity, are you using multiple CS in a real use
case or is this only theoretical?

Also nit: this could be simplified to:

		if (cs >= cqspi->num_chipselect) {
			dev_err(dev, "Chip select %d out of range.\n", cs);
			return -EINVAL;
		}

		max_cs = max_t(unsigned int, cs, max_cs);

but I think it is fine either way.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>  			max_cs = cs;
>  		}

-- 
Regards,
Pratyush Yadav

