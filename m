Return-Path: <linux-spi+bounces-3576-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B299167E4
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 14:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88811F25B14
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA3F14D45E;
	Tue, 25 Jun 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOp1rDAq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8A14B091;
	Tue, 25 Jun 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318776; cv=none; b=LQT57oQjpbQVk8wPjj5wefugklGSOKj3JyU4ivpkQdO2VwFOH9F4AeE+lFNrrIvlypXuPEwPhb71FhvghJkqwTmLqDfI4x57RY0X8GC3PwvkmBl5b3aT6KwSYIo4mzTry8SS90XCJi67GaRlkakScRPCGJezzhqDjRyG+cAgfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318776; c=relaxed/simple;
	bh=jax1LOTh2JiPAGq4tsyp2HMkEK6vupoll6oTv96ic3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udcX2tJ6VFIQmL7YgtCN1iUZX38Z57YwhxoiE0dIruKP0jfuPXo4yeb0tvx7tehe8BxKRwkzN+MWPYtQykMO4PmtK78AfHyuqQgjc0CXQFaCIsqxnkRlu/dvU6aeOw2Ust8EvKdmJmFsvXUyeRqGSiVdtbv0DFqymFQJLiEX64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOp1rDAq; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so59836321fa.2;
        Tue, 25 Jun 2024 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318772; x=1719923572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJG5YoibKlpkyRo0y3DdOvaMl7oM0h1j0RRMvKszlts=;
        b=DOp1rDAqepFOAJF9wBem5rxbyjiN1SiYXHwDKelfmXc10ex28fesyuv2ekZuAiW3xK
         S0o8NfxEIxQACeom7BhuUa/ADLZfMjOy1hAwn8DUJVFZzT8gxWjXcmHgBo3dFQGQs+r+
         l7SnS/bKjaXylkwSz2YhhCUfzsdUnmRosRnzbHwQWNXDEqmDtQ3kzeHRtevFWlM1e3aO
         481Dua07XN3kESNTGrjrU4mfpl6fkf5YiVTZnxcepNsKGwaee9YdQ455D9gos74yT6zg
         MXcMM0r6tnMxrMCP+15x966fB8CoIo/sQ2QK9WnoMsWCfX4dS3JU4SxhdFIrzkcWC9PS
         cWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318772; x=1719923572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJG5YoibKlpkyRo0y3DdOvaMl7oM0h1j0RRMvKszlts=;
        b=UECSytHd/Qw5KxslS1hzI2xw+CsBT2MUMMU/QHjERBvLF9d6iZW9Fq0D8vg3fOKnnw
         qqVUTE6YJv5WrPirirhi66qIWGzUb6wc8T4Du74Udj6BqvXQIVZHLuon1PfjXqG0v+Lw
         Ld98UwAApR9XDe9lpejLy85sc7g7H10bFueWtY5pG6kX8bWqQ+ceiJm3l9jI7byBpEcX
         tJBL5YW+Vz3C34qN+wPCv7hiYGmm4H7cZLKduFoOexUkxhF9chSICVKi4rAKHBpqFuA9
         D0YMEVP7r3KWrjHAcLXG3AbqtCdZYEOkOkk3xOeTs5P6FS6QaFIeLtKe2RldcI8FqRL9
         N14g==
X-Forwarded-Encrypted: i=1; AJvYcCXSJfe4mZGehCzip7AZntsN/DLP7vJV1TCYwGmTdBFfZD9Z/rDzozr1EmWrS12gb3IEOMAi0k345E7fFujjrVqEayQRXGR6QH99/0028JSqqxnvktxMGNI8SgbF5Wna6TUG7NqDcuO2uLfRZqqWYHpcd8XU65+7iDP2lPB+FacgBs/vmQ==
X-Gm-Message-State: AOJu0Yznse73/kAdyD2inwKnSvuqKVrSnGWGpuNNUAsu6f8lxuwLQ8Xr
	e+I8sLCB01YsZglGoGqMzqbRMA2QX/MVvwt9/GSEKw5Ss/VQPz/n
X-Google-Smtp-Source: AGHT+IHrq4jVzTqZE1uNfWg9tb8O22LmO6dOjioBxfQu7ZNX2sgEezbk18ODgnKQ/Wh+Kz6njYn/XA==
X-Received: by 2002:a05:6512:138e:b0:52c:e08c:a0dc with SMTP id 2adb3069b0e04-52ce185f753mr5189826e87.51.1719318771577;
        Tue, 25 Jun 2024 05:32:51 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a9667sm168583705e9.15.2024.06.25.05.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:32:51 -0700 (PDT)
Date: Tue, 25 Jun 2024 15:32:48 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 1/3] spi: fsl-dspi: use common proptery
 'spi-cs-setup(hold)-delay-ns'
Message-ID: <20240625123248.2svpybglw2ydd6gg@skbuf>
References: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
 <20240624-ls_qspi-v4-1-3d1c6f5005bf@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624-ls_qspi-v4-1-3d1c6f5005bf@nxp.com>

On Mon, Jun 24, 2024 at 02:55:27PM -0400, Frank Li wrote:
> Use SPI common DT binding properties 'spi-cs-setup-delay-ns' and
> 'spi-cs-hold-delay-ns'. If these properties do not exist, fall back to
> legacy 'fsl,spi-cs-sck-delay' and 'fsl,spi-sck-cs-delay'.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
> - check spi_delay_to_ns() return value, which may return negative value as
> error code. It will be very big value when cast to u32.
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

