Return-Path: <linux-spi+bounces-1056-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB9849E17
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 16:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65F81F21F06
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4232C877;
	Mon,  5 Feb 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVRpipaJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014EC3D392
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146824; cv=none; b=kqpz7j0zPpP1tCLhL8ZswgAIeAWJhti7aceyDEhHy04Kx9xaUVx2PG6F+9DIKhUUlmItZWY7y5UrklJ5ARvXLQT+AcJixs9fpT35JMjIaE3GPXW0o/vfHo6tBkQ6SyqYGbb/SR86nQq/CfeZNwAeW0xE0YsziH8S+CZCiSmnRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146824; c=relaxed/simple;
	bh=lBmyhHAc/b/ds7tFylLz6RFQYMZo8mpB75YF921Oy48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5PUxYcOkunzw11OwZWOuOOBsl3v4iF1eEPmtH1abi9OoaO4vlmiZt5nJKvAhJX8xWutSzwfsDUNiQR3l5HU+e6nOCRX758jibOWy31nB3Epge15u+xRaYLyRcbV6HHDFQRC14EphXYWwxI7QMYbv9w4hCYlWvmGcBvJFkeCDuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RVRpipaJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso5511902a12.3
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 07:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707146820; x=1707751620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lBmyhHAc/b/ds7tFylLz6RFQYMZo8mpB75YF921Oy48=;
        b=RVRpipaJBXzjc9qFH9fw8jISSQzJ9dwDCTzoSW2Gj/Fah07NNfrIwLQO5/sv3Z4paH
         o5fuW9ySFbVO5iGfF42uGkp+GVYEY6otdUBcgQK3bqkANYo+NkuWRsYnw6XLvPo4hEqd
         LHFPGpn8Ar8ZiHWxuMqw2/O/7YDJZ6GmwxFROH1sgShoynB2XIY897jPb8O6r1j37bFj
         c8EyirQrJ/CR35DGm3WQOMKyyuh5TpdXbYt8WvpDGC+e9Ug4fhGqokqoMcV7tbLzaO47
         QEdQQUAcdwQCA02DyJEc4vwULptmOPQ9wvIFVC+9wHEf7gJ3b8BlO06cgqNLDIJqYnA6
         BT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146820; x=1707751620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBmyhHAc/b/ds7tFylLz6RFQYMZo8mpB75YF921Oy48=;
        b=FSggtKvBsgvFDKtennOgRk5/rbR4PDoCxfWmWmWxqz8QN5fvISbd/Da9p92dexKmer
         bdDAkV+84cZRgRMIPg6/GZB6glSQ7x/N6RhyxeVmBNJHL6twDp7xQc4GYwl+5KfZ1Ytt
         hWqjrZxu28RD78YLt+XgjYvYo8QcwaIlkO2l4QSd+0HR+hVzYYzqG0k7Ram9Adij3s6J
         H64NfEb4jUppHP3eqFXv2RS9uMyS0M4eQE6Dz1BBpfZDsXH88fBNHcfX3MyEtIvHzoct
         dfLAjNunufWvIHtNambyDPqdZ5swMpeC+6X2fgsXJo6onOfF/BaadC1fzBJp+eiQs4SH
         mYKQ==
X-Gm-Message-State: AOJu0Yy7w/p+Y+EzGW+oSO95rZzytKOaXhPQBYgaB/mKYKbhY6tcL/gK
	wLAqkG1WTG4xayDjUHtlfLmVCs/PGkedRc3jNJDmu+Gzd8kFyju46h5HbiI2K4Vpf7Qf8001/KX
	Q2OSjmWgbQQUyMOeuPlQhKJcSO5x2o9yRKsrKTw==
X-Google-Smtp-Source: AGHT+IFQoasCqxFOs1K52ZI+x/XzUUqCmUS+VdtJeXp3SaImGzfi0s4W0syhmRtpTA5yDxCp/YQX6n0921f0iNYwxv8=
X-Received: by 2002:aa7:d314:0:b0:55f:3975:209c with SMTP id
 p20-20020aa7d314000000b0055f3975209cmr4541024edq.18.1707146820112; Mon, 05
 Feb 2024 07:27:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205124513.447875-1-tudor.ambarus@linaro.org> <20240205124513.447875-4-tudor.ambarus@linaro.org>
In-Reply-To: <20240205124513.447875-4-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 5 Feb 2024 15:26:48 +0000
Message-ID: <CADrjBPoBj_TKFJnBDJ8gMgj3PwjBT=g8sy_LhXnJFUTutuMKNA@mail.gmail.com>
Subject: Re: [PATCH v4 03/16] spi: s3c64xx: avoid possible negative array index
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 12:45, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> The platform id is used as an index into the fifo_lvl_mask array.
> Platforms can come with a negative device ID, PLATFORM_DEVID_NONE (-1),
> thus we risked a negative array index. Catch such cases and fail to
> probe.
>
> Fixes: 2b90807549e5 ("spi: s3c64xx: add device tree support")
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

