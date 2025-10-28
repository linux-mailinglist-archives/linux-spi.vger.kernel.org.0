Return-Path: <linux-spi+bounces-10865-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1504FC1295E
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 02:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242671A6637C
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 01:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47555246786;
	Tue, 28 Oct 2025 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="fRrVoPIs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD44215F6B;
	Tue, 28 Oct 2025 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616087; cv=none; b=qpo5csDgZfe6fTnyTGag0QrF6tCPk/fnIWggfmdAPLlM10kRb0LH8W+Au9+l3JtMaxUev0ygvjxTI+Vq+Qqm/Fzf6BLLrBVkFILTua5rm5/d+56GsXxeeU2KUzW7SEn3VLJQl0A+l6AA7whJpu+i0BNUg+x0C2W+vSfCKvAjYUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616087; c=relaxed/simple;
	bh=Iv5rRjYY8JSRUIKds9sbbJvzC+aTVnp8pVpbAJNDqS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwbQtWmC9pNr50wjKDtf84gLgb7dbt+lsqCc18zoZkAGQj2CO7OmcK28/8nFW8Yt63K4ju/tQ2vkSSwKupQGVB7VcDWhbWPcEBmgISXogWavwQEI6WpHKndpNo2iNYKWkPggLpi4W5FqJC4a2m8d7cazqgTfs1yyXwMcDHgBZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=fRrVoPIs; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761616004;
	bh=ZZGiSuhveC35IDEiLoprkDlOVwgiu6jWGoH+rPsLx3c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=fRrVoPIs29UqTD0m3W7X56lgTJVygEyMciveva6ZK7qLlDlv+u9LNMQhkpu8IYult
	 cCBRkTBMQAaZxPko4cRncE/y3sPftOlL8w+tJXZnaYxlKG5jDzU3/HIrqS1gltW94g
	 xVsDdlE/6UQ8uZ+CCA9plMbuiVYnGNvhJKpJLrAI=
X-QQ-mid: esmtpgz16t1761615995t756b5b9f
X-QQ-Originating-IP: 7q80XCy0jGgLRN/KX1RproqfInXomRBfooCh3iM0zPE=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Oct 2025 09:46:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3934101092882309250
EX-QQ-RecipientCnt: 9
Date: Tue, 28 Oct 2025 09:46:33 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Alex Elder <elder@riscstar.com>, broonie@kernel.org, dlan@gentoo.org
Cc: p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v6 2/3] spi: spacemit: introduce SpacemiT K1 SPI
 controller driver
Message-ID: <FFC4D2691116C9D4+aQAgeeG28SpSI7YR@kernel.org>
References: <20251027125504.297033-1-elder@riscstar.com>
 <20251027125504.297033-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027125504.297033-3-elder@riscstar.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NvGGTAUhB2iW18mMlxXY2mDBeJh78WNKTROkTk6L8LQ3hqB4wCe7vAlx
	Iov5PVGTOE8ckjEVZgx023uvmPdFZP8CzSX6DQnnZoUD42iCzQvoJNWebc2kdoWK3uuVXNG
	VukIcw4F3JB4WdP4lGomOfsWjUMLP7aN2mgX/BhnPHY3J38vLk2ddoh8ZI2hkqJSA4fodsi
	SGCCAPxMldj7BKBMBIHHXVrfuaktnMJf7B78VlqXId/1YwyMYJWIV0v21U8LTtqjQLl7szk
	MQrokQ5eSnLNLCamqlaLXhxziB6SYZRqmKcwmaZxoBf8YKc0mzi3bc0Fi+/9rj9fG3JtkxU
	AA2fIXD/yN0gg5qd9SKPkBbpHHrluJMoLMOdcYUVKLsCBcTIBNYTAb4C+fu7HHggvBR7FY7
	0HogkCpIzuT1OpQLjj4IKqMcGlp+pFw+sbHhrlKIXiQ5UjUDwyV6NlypS+tlbbuxHWfmoO4
	FSBXHvIM7E3gw+D5lGCb3YSien6Yf+r8OpUiLgU6LEl53mVDwXj0AblXzcTz28cytCrHA2h
	Y1VvFzjkjpd6VOxYnC1IOW8zadT6JarzrCSjhzFH4ektZOO1S0IWQFJGim1Tg7E4oBw1G8f
	SKWGrggWBNNs9cBvF7Be+rzSiEWPSBkvKU82cG1/PCxOqTWqskQFollBzb3eZsXqS3+Wdqd
	GymwecOeRIzsLELni2fAHUyqPOAzNfADcCsqw4BO8u6/B74eFVS7h3xTlBh7xpFKDwktqHY
	cdvKHHxZ3nP6r6l/phPt6DTBtrYfUvH60ZlnPDNQttpD3wgCfR9W4jStZMQgyq9iH/sKz15
	+51juOmf3YHu6eHEKI5DtvIl0bFOEqa4OebUWYfbfJja8rmlHGsjFnW1XcA8ZecCDQXwrGq
	IioKv/xV1PY0gJHEF5OZnjjxwT0y5X/yDUC/EtaKHqGTZMXeyGw+a6Z7GNPACdenrwyi4pz
	X8UrXdiBhBTAYeBymXTe8X21F0wA61qOVOHCN77XKUuDB4ae4QTFXWzCpc8lsvYKgLTMRJ0
	7of+kZMM7h7HYdNvfk3Z5KF8qHhRJ8rTX6WNs4EZO7FaKUkNRHfVXHgG1FFZc=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Mon, Oct 27, 2025 at 07:55:02AM -0500, Alex Elder wrote:
> This patch introduces the driver for the SPI controller found in the
> SpacemiT K1 SoC.  Currently the driver supports master mode only.
> The SPI hardware implements RX and TX FIFOs, 32 entries each, and
> supports both PIO and DMA mode transfers.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/spi/Kconfig           |   9 +
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-spacemit-k1.c | 965 ++++++++++++++++++++++++++++++++++
>  3 files changed, 975 insertions(+)
>  create mode 100644 drivers/spi/spi-spacemit-k1.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 4d8f00c850c14..2e933edab1718 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1071,6 +1071,15 @@ config SPI_SG2044_NOR
>  	  also supporting 3Byte address devices and 4Byte address
>  	  devices.
>  
> +config SPI_SPACEMIT_K1
> +	tristate "K1 SPI Controller"
> +	depends on ARCH_SPACEMIT || COMPILE_TEST
> +	depends on OF
> +	imply MMP_PDMA if ARCH_SPACEMIT
> +	default ARCH_SPACEMIT
SPI needs to be a built-in feature?
if not, how about:
default m if ARCH_SPACEMIT

                  - Troy

