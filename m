Return-Path: <linux-spi+bounces-3578-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A104391680A
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 14:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7051F28465
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 12:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133FC16D9C1;
	Tue, 25 Jun 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG0TOPWK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A29156879;
	Tue, 25 Jun 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318860; cv=none; b=RrzQdtMguADKD9svb/AzeOhngW2bcp/cUgvTB1ZH3f2ExGtxWzqBtzTKXXNknGhTzvFPjJXGtNGbDfJjPRBcYkzfqViEOqFuvFDl4Vz0jahS/qx9BTs0Q7yKlrVgcW448GAbJjtsFHYRYwm85dBcdRDMaOSkSnix1lIgvyLEbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318860; c=relaxed/simple;
	bh=MmNcMBBJtVyzgiafwqkLrHq6NRCQRYl4dPawbnLh1E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrmuFQtQAlRZKhxNcXdHRKQfmJbBS1LMJth/2NRiLoVKcdtiDHRfxbWOs9pPzUBEgoid99iCZrpO9QIAOtBSHtjkWGd0XbjXEduWqYJTpk1gAKjXRBxXyGKQPuJzzAyS6XPds/5u7Coi5xjHRz1Bd3Y12rsB91aCoHbop5CVYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG0TOPWK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ccc40e72eso3680370e87.3;
        Tue, 25 Jun 2024 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318856; x=1719923656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oN2/K84i9zl3GaHFtyuViU5S2IN/66gi6BYv+zbirms=;
        b=EG0TOPWKURaI5NU3kxqfBn5rpkPqZ+7RfgoYxlLN+kjd0fAFbVpQnrjBcxHQNgDNPU
         j3ZlRfaEICRGOlIGbJc8wpy6RHbms+9oxawavgruXcX46Okpfi0BQ3FtFmgzwpGhBLHz
         oxbd23Pv15+FdYN7lcHdPzIO/O/7f6NP+W+xn/AWOOWnWki+H8r4oT/NSQJIct5L6ytk
         RlkyGloh0IN0iNKOHyLyjag2kZ0pO3Qt8WFMy8nHy5SOKdS1m0J1yEzL0p+Cj1PsTZzt
         B7q2+FBddpggcp3esH0UMj0utogG1kCWbTxfw4OJzbIRhx2RygZ/hzzvCKnZUZoJAU9s
         1U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318856; x=1719923656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oN2/K84i9zl3GaHFtyuViU5S2IN/66gi6BYv+zbirms=;
        b=cdJyQ39yeEoSjgDCq5QalU3tzoTK8cCAZ2HkeyftH3Xvvowbwr40YJmyVw778IF5+Z
         YEIpMutVAC/l/0BzCiUmdnJstd3Y0Lezp5qFxl5c0Mwcncqy2DLsvPbyYaR8SPEQTJXO
         H0iA7HTMspZBvvLd77VHB+J+AFsTqXsXUR702fXpg7Gjr7ZQglS4ey+I+svAfcxGJnV2
         +ondI4hBoRiasjsq2HeiFJa8es0sA0Rk9Ozv6e5jdyuCm/q9jA0UOxLnL+IK1PZ3k6AO
         H5T/Wuin/HSurD3pfuq2/3Ed0/6vZEkLRQF7PXttEDm6y8VbB9PLMSI0drJOlMIvBLLr
         n5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE7P5p1Q3H0oKubE4lg40k5MFHxv9gH8HcDJKUJtc8CBYhBUcyYYSrPBz3rv7iXRTe4SfZWfbhgkc58r08dTe8ye/GVdwmVyR7KmwbFYH78cv6wcUUYbtM5thdZMa6j58nFN+QYWHY3C6KyoKyR7svMJfRE6RsE0/qs6k+MHvpfKLceQ==
X-Gm-Message-State: AOJu0Yxg8pxD/jMfTgEeelSZJZOCZ7+/Wun7g1wyKEsP8oND29HeXiyx
	9fjXo64PWDGG0pYTupkymxNdK/aOxbWMC8JXX3cco0ua7uys/beEOTMRpotO
X-Google-Smtp-Source: AGHT+IEugLyqoJPVUeJAwzI9eTjBQERaf1IqQnBaVqPFo7vfcEFHGeoEL5luenucOLlOBIKM4l/LLQ==
X-Received: by 2002:ac2:420a:0:b0:52c:e00c:21cb with SMTP id 2adb3069b0e04-52ce1861722mr5540533e87.62.1719318856164;
        Tue, 25 Jun 2024 05:34:16 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b6355sm208725045e9.2.2024.06.25.05.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:34:15 -0700 (PDT)
Date: Tue, 25 Jun 2024 15:34:13 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 3/3] arm64: dts: fsl-ls1043a-rdb: use common
 spi-cs-setup(hold)-delay-ns
Message-ID: <20240625123413.kksqh4zbi5bzfaan@skbuf>
References: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
 <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
 <20240624-ls_qspi-v4-3-3d1c6f5005bf@nxp.com>
 <20240624-ls_qspi-v4-3-3d1c6f5005bf@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624-ls_qspi-v4-3-3d1c6f5005bf@nxp.com>
 <20240624-ls_qspi-v4-3-3d1c6f5005bf@nxp.com>

On Mon, Jun 24, 2024 at 02:55:29PM -0400, Frank Li wrote:
> Use SPI common properties 'spi-cs-setup-delay-ns' and
> 'spi-cs-hold-delay-ns', mark private properties 'fsl,spi-cs-sck-delay'
> and 'fsl,spi-sck-cs-delay' as deprecated.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Chang from v3 to v4
> - fix typo at commit message
> - use comments:
> Standard CS timing
> properties replace the deprecated vendor variants below
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

