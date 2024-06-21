Return-Path: <linux-spi+bounces-3527-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8C291260A
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 14:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF111F26C60
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B2D1527A2;
	Fri, 21 Jun 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE9KLRT8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF215C3;
	Fri, 21 Jun 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974448; cv=none; b=F/2+DZv7FIQmANl/VPJB3RpMLaMAcE9zos2kP5LIfRdVFzAHpE9ZMjq2fR7HSlSnfYO10RGAcqO9Z4sXolf9QVbCFZjz1hvAyJJ7sS7aoeHCIW3rAw1klNeAxugGamq7ycjm4APMJwsRl/HgrfXitl3f8xf5r0j1tHXzcLPgopY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974448; c=relaxed/simple;
	bh=LSQJ9I0cgRdYxNFwJwcV1JJibD4wbsNz2zrUxK+ak8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2TvbnvgL6XzMQZA/uJXVB0dKUBIkez0YLaF/N+9MoOO6emf+tsEU5wC87uddcvxCHqmPnwXoqUYfc/666cLjPTsbQhMLmdDT3l+4rvXO1EMEZ4HF4Ka9DlDQUYN8UqaDbe1z/Ovh2Kh9JScSLAoQAxlTt/uZ4H1OuU9JXL6Ts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE9KLRT8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6fd4d1c173so63385166b.2;
        Fri, 21 Jun 2024 05:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718974445; x=1719579245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qYJaA7XS25MstQlFWDdKfpHlFF9Sx8XLgOyXscP6JLU=;
        b=VE9KLRT8c1lrBtBzQrgjE/LrieIiZCf0OGotZv16YcarjqDQYF3i+EJET5GS6L7rlG
         HcHAe67R6P6MhCDrWPd3yStcOQKP7ZluXjUspR4g9XxO8FrGLPcSZpwe1Z5XGB62Dj9v
         RQ+W9nxgHPlcRmTEktvQcMiBAHTUW6QORiOI9bByDqB9nR2O6nAKrEY1g0eemPR1Bbhx
         tlsurwyMsJMOwNPJIOQb3vVkUFIagy/2MvAFv4w6z4ZU6tv9K7fsA0AF9I9Ll4QDXwln
         BU2cIVwmGXn+gtdhB8CHi+qZsn+4tevCqMUkBtzJqgLmTfuPWqPuWh8ia0ieT64PAoTr
         e83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718974445; x=1719579245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYJaA7XS25MstQlFWDdKfpHlFF9Sx8XLgOyXscP6JLU=;
        b=W/jDu1pjU95FjT/fENJUpYhbr7jhaK7q1g1lgl37tJwklpD0+nI7wWSqcxYG3beBNB
         I6luG+YeLyEfi83c2QONk8bj33BUr7gfnvi26Y06L1Bj+7WjzxGVnY5IhyWPkZR6+Q/p
         ZlNKFwvzitL+Laab1xdmBAW6yjmG1zA5FaqBCijoCa98ST0YiooEZyWksj3k03P20pUt
         0UVAC/zJ9WfHeD+VryKqB0lIE5ds0TTa47pTBjnG29Gcbu6xHfLiuQV8MyrikE3H1MCW
         d5KtHB2UPcMwwYz6erTT9+MDRSRT2RZpXOKt3ktSMPpvwF/iSyxBGYBB++RISULI8+sv
         kdaw==
X-Forwarded-Encrypted: i=1; AJvYcCU8t2F+XCScwqmFUeJergyn5Fyf0cBIid/rpDlR/bNaJ1gFdbO9MlSpmQfJYVep4ReVkV4yZM5uiW+5YmKq8AyeovR0eqMj5QaPLA4oit2/NlOdJHPMhc8CiQ60ako+yioGDru9vr8jDc3K0M/CYNMslv8MPaMDTYuec2neUNzKEw5leA==
X-Gm-Message-State: AOJu0Ywb3ic8SffTSXWiomu8ut3aW3FFUSY8hv1Im2t1U53RCD+FOuO2
	65Z+bGUTCjVbu+zJuEx3IeDfUPuEVLJZLUVConqQ/PL3mQQzKfGj
X-Google-Smtp-Source: AGHT+IHRru8dj1JPrNty1M+sqrOOATWLXykc/0tIQFtaLKd3tUycWUm6+/vMJitFroUxg9wBZEO6Ew==
X-Received: by 2002:a17:907:a4c7:b0:a6f:c167:614e with SMTP id a640c23a62f3a-a6fc167622bmr318798866b.31.1718974444550;
        Fri, 21 Jun 2024 05:54:04 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf560532sm80916166b.163.2024.06.21.05.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:54:04 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:54:01 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 3/3] arm64: dts: fsl-ls1043a-rdb: use common
 spi-cs-setup(hold)-delay-ns
Message-ID: <20240621125401.of5rge7imyp4fdhz@skbuf>
References: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
 <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
 <20240620-ls_qspi-v3-3-1a2afcf417e4@nxp.com>
 <20240620-ls_qspi-v3-3-1a2afcf417e4@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620-ls_qspi-v3-3-1a2afcf417e4@nxp.com>
 <20240620-ls_qspi-v3-3-1a2afcf417e4@nxp.com>

On Thu, Jun 20, 2024 at 12:58:29PM -0400, Frank Li wrote:
> Use SPI common propteries 'spi-cs-setup-delay-ns' and

properties

> 'spi-cs-hold-delay-ns', mark private properties 'fsl,spi-cs-sck-delay'
> and 'fsl,spi-sck-cs-delay' as depericated.

deprecated

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> index 26f8540cb101b..fef3534157a1d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> @@ -104,6 +104,11 @@ flash@0 {
>  		compatible = "n25q128a13", "jedec,spi-nor";  /* 16MB */
>  		reg = <0>;
>  		spi-max-frequency = <1000000>; /* input clock */
> +		/* Add common SPI property */

I guess if you do insist on adding comments for this (not necessary IMO),
we could improve on the stylistic elegance by saying "Standard CS timing
properties replace the deprecated vendor variants below" or something
like that. But currently it doesn't look great when there is a verb in
the present tense and another in the past tense. Also, the plural form
should have been used for 'property'.

Additionally, I don't believe that a new line between the groups of
properties is necessary.

> +		spi-cs-setup-delay-ns = <100>;
> +		spi-cs-hold-delay-ns = <100>;

Do you plan on deprecating the fsl, CS timing parameters tree-wide, or
are you going to stop at the LS1043A-RDB?

