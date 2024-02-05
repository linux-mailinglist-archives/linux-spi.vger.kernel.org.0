Return-Path: <linux-spi+bounces-1054-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C3849E02
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 16:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2601F26453
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E662D610;
	Mon,  5 Feb 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpj4suvj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37B3A1CC
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146705; cv=none; b=hyJSlwfMeyzzfTwv6R6q0bD3WJ8uc20G/odiN8KSXJczuZdHfP35OsA+27fIMOKiZlF+9EM5iWCEixcRbjIwnqZMEB62dMjPOmtGnIGagkUC9AKsxd9rPbTgZ+kAJHG3FQ5QqDlvKCrkvvTSRNpprHISsbMmhZ6pWLFwHUr7v3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146705; c=relaxed/simple;
	bh=HKwxeUSsLvhmFJpMmpEtAXXRzIFcWThX4sy4vjHNQ7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EETeZDLkgrLPgvsBr1Po8d4ABLOUkg8CEG3reh+0Jo7e4nnMZhzo/XZ51I54Hke8vxSi3ceAHdBI9BbZ9MRPMDS1JW2WHcT1oLc0sAg9tKfAXl5c4qE9fAtmoT4D+vowtDiLC/m89BkIWWsOrWOoXOsmsvU8ggcUJqiba673KOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kpj4suvj; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e118da997cso2308234a34.3
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 07:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707146702; x=1707751502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HKwxeUSsLvhmFJpMmpEtAXXRzIFcWThX4sy4vjHNQ7Y=;
        b=kpj4suvjEaFOuSQ5DCte0p/y4dABRIygiWIT+hNr+j5yZQPs2Gvqp1FF+FVXLV4v3m
         a+yeSJTeF1mhDnCepLLExo2TB4t6yi05qwz3wqiubAklu68qxDPXBGANRy89V8yJlRgP
         vdA64R0AP4y/OCqz0+as+RGEZACAThDYuIV1QtTnnDQl+l6mQe7rWcKkjLMR++FeQ8dp
         1ddmlpGhySzqTrOnoubhe/XSJAb8WwcpQSNQkMwyTyN1OOtc3VqLcNfbWp0S40MQqVyL
         DB7W1T7M9dB5131LVqiMtozFgCP6TiI0p86PBjodOxHyu5hpGnYJuIHYkw2iXc8Xpsc6
         uwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146702; x=1707751502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKwxeUSsLvhmFJpMmpEtAXXRzIFcWThX4sy4vjHNQ7Y=;
        b=i2MnTcC6+jNw2DhwtCCFqs6VEFORJPuzYXxp42dAnLokPs3ElWVuMkSOL+q8oqYsHW
         3IZ8KiieEkpcxvmHQw+SGSb++Q4HcJ5JlZVsz0n6DFWLUZJO5RqCkS1MRI0XdwYOOjl8
         GtjNeF1Pv+ignTK3/rhsDyKTee7YBPVtV3mD2NIul945CvElX45Rqktodi1Fgwe14gMe
         IDLrrDX/x7vTz3KzDaX0ppnaX5N1QVMeQ1XnzNm/z6kFFGNE7NGSgZtKtMvKV5M7lzZ9
         uRQHJVDuyZj5IMBEjgDV0XYwNLc/uwore+ckCbQf2kjRk2mgo5Pizf9yHXwnxogYWSGr
         xK6Q==
X-Gm-Message-State: AOJu0YzKKcL0BXJzlZ29qsbAZ7vTCaKY/2CWL/PQryHYS19YDhDF9nCc
	fT5Ga2xL3xAxcxs/uXp+4VFC0e75T3fTLzhDifU7ta/2jvGxxRclLK2whOpJPo5gOkeOPskTlVa
	vZ/gtPjueEfuyHmM0SmJdvSgyH//yPuXmqrodiA==
X-Google-Smtp-Source: AGHT+IHy/zvd52PWnVfGZ0cIa7PK3W2ziJXs/4hoP7SDCkTIOKpF2KQTNlCotEw7lTj8YOyyv/iuUThqyrMK/IlilsI=
X-Received: by 2002:a05:6870:390e:b0:219:476a:c1a8 with SMTP id
 b14-20020a056870390e00b00219476ac1a8mr13118oap.6.1707146702651; Mon, 05 Feb
 2024 07:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205124513.447875-1-tudor.ambarus@linaro.org> <20240205124513.447875-2-tudor.ambarus@linaro.org>
In-Reply-To: <20240205124513.447875-2-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 5 Feb 2024 15:24:51 +0000
Message-ID: <CADrjBPpZzdO8VtPexWJOjHh_t+4CwSF=tcn+sC-i6eLcrxYhfQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/16] spi: s3c64xx: explicitly include <linux/io.h>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 12:45, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> The driver uses readl() but does not include <linux/io.h>.
>
> It is good practice to directly include all headers used, it avoids
> implicit dependencies and spurious breakage if someone rearranges
> headers and causes the implicit include to vanish.
>
> Include the missing header.
>
> Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

