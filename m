Return-Path: <linux-spi+bounces-670-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53756839938
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 20:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82371F260C1
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 19:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AEF1272D0;
	Tue, 23 Jan 2024 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PzvNcWgl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9912DD88
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036671; cv=none; b=aax4xc0BCIpZIZ9xqTa4mGir/yvTGW6fOGTNmBBzl0ioVgolIL6hxivRrmG2A7XE0AClagi+6sqp2PvaAT7bkU94+XUyiPwjvM0HIzuTosHLegT7A1S+hgcIf9Rd4nNnlJIEeX519fmOjhR9sMa32Mi4eoqsLcHIb+6u8orTfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036671; c=relaxed/simple;
	bh=VS75+3gB3sq+wMUOnc02c0cs4tTZ16PoaoDey6IJecQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jq64IrJuZxscYqalb2T1B2vB5afrVC3hrCu4//kOsbjoT8+hVA68CI8A0oxXXutSmVKlzXGQ5aZok2hzRYI20FFa/paJmFuoHpJv1HkditGm+aKTKEsk14YrIzlOpH5RIjfNzotDTr/U5rEgwxWBhPoIK1b63c+Acp1PC58DiC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PzvNcWgl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28bec6ae0ffso2378576a91.3
        for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 11:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706036669; x=1706641469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ITsyqbQhjxk4s57336fVZCNir8lMBGnWIW10dpi4hs=;
        b=PzvNcWglfJnGT40DePLGCymoEGi4cIQhCrPs+1RxgkdujEU8iMVipNNQl/IdTZqjpQ
         0tL1AyHoOzm8G6cL8b9fWJFqnhbvw50DtA5BjBohmZo5ruYhftChiynOu1EsgUFjMkDx
         lY+w9DeHsiwdrxYPE+7LCZQWsRPn75jl24PV6Of/2HNPmSs3rTgYV1TIOGXFP6ODZDQT
         sf9TH/TnO9puSlxLetbqKgiVaMVme6c8/5JwLKQUV2+R+vfNm/2NIdHLvUF0vkP782z4
         drp3nf0IAepPTSLi+KfGKKzpdB84wkCIDpCI3ALjsh9usk2RCb74/fhehRAXuhwxBEmh
         iiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036669; x=1706641469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ITsyqbQhjxk4s57336fVZCNir8lMBGnWIW10dpi4hs=;
        b=Dr5qQZQvJjMVDzjEMcgsLQz7c+hM5hg5Y5sj6q3vxwDz8KuW1JzyOkNwq3ui5mpJSY
         1wFHSaZ4DkLT/bEj4J7gbaamMbBwc28o9qLDZQ7FGDTK7nScxbFXnqUNsdyGqqFxLY8s
         +kHzzdguNR351zIkdSMsSUOfBnuDVF3jumXneUOe4s73aP62jTQavpbA3PmKgtko0j77
         Ai9Mybs6nVG/m1X017p4lpxaS8std9SPfajdGOUfoQBqhpCHh2c6G+b9rlokRtF2CveM
         ImjPJhcs2eLAS7EkCcsPavEhjxmQl/BmdGjlx2hj0eokkeb3drDDe4dk5vx4N6ZWHzxU
         nKpQ==
X-Gm-Message-State: AOJu0YxLCzpX1aMKh8ko1SoaZgcNR9ll5WG45WnK0Xs4fUY8e61Dqzhy
	dFk4bkZ8ySXy2lwAFYMebaotbII4lCmM3IyQSlvA4RxSLcjsxtf06Dhl0fYLMHt+iuv9x6mpMyQ
	iRTIQNE2QvcxXQIWPV6IzMPpUSpXYSaORU1YYZQ==
X-Google-Smtp-Source: AGHT+IFqjIFCtd6wzKMn5T1MeVubJoGhj1g7ER8YvwlsiOaQDJe85pud46G6ASqfjh26U1Oe4Oq2VbK93aNHGLWxHN8=
X-Received: by 2002:a17:90a:c395:b0:290:6b0c:2603 with SMTP id
 h21-20020a17090ac39500b002906b0c2603mr2756498pjt.29.1706036669319; Tue, 23
 Jan 2024 11:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jan 2024 13:04:18 -0600
Message-ID: <CAPLW+4mOZ=0fkrAiW1jkTMxUF1Li=s4VVzw5WgEb+D4Qa-=SoQ@mail.gmail.com>
Subject: Re: [PATCH 00/21] spi: s3c64xx: winter cleanup and gs101 support
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:34=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Hi,
>
> The patch set cleans a bit the driver and adds support for gs101 SPI.
>

It might be more convenient (for review purposes) to extract all the
cleanup patches into a separate series, and base it on top of the
gs101 SPI enablement series.

> Apart of the SPI patches, I added support for iowrite{8,16}_32 accessors
> in asm-generic/io.h. This will allow devices that require 32 bits
> register accesses to write data in chunks of 8 or 16 bits (a typical use
> case is SPI, where clients can request transfers in words of 8 bits for
> example). GS101 only allows 32bit register accesses otherwise it raisses
> a Serror Interrupt and hangs the system, thus the accessors are needed
> here. If the accessors are fine, I expect they'll be queued either to
> the SPI tree or to the ASM header files tree, but by providing an
> immutable tag, so that the other tree can merge them too.
>
> The SPI patches were tested with the spi-loopback-test on the gs101
> controller.
>
> Thanks!
> ta
>
> Tudor Ambarus (21):
>   spi: dt-bindings: samsung: add google,gs101-spi compatible
>   spi: s3c64xx: sort headers alphabetically
>   spi: s3c64xx: remove extra blank line
>   spi: s3c64xx: remove unneeded (void *) casts in of_match_table
>   spi: s3c64xx: explicitly include <linux/bits.h>
>   spi: s3c64xx: remove else after return
>   spi: s3c64xx: use bitfield access macros
>   spi: s3c64xx: move error check up to avoid rechecking
>   spi: s3c64xx: use full mask for {RX, TX}_FIFO_LVL
>   spi: s3c64xx: move common code outside if else
>   spi: s3c64xx: check return code of dmaengine_slave_config()
>   spi: s3c64xx: propagate the dma_submit_error() error code
>   spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
>   spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
>   spi: s3c64xx: simplify s3c64xx_wait_for_pio()
>   spi: s3c64xx: add missing blank line after declaration
>   spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props
>   asm-generic/io.h: add iowrite{8,16}_32 accessors
>   spi: s3c64xx: add support for google,gs101-spi
>   spi: s3c64xx: make the SPI alias optional for newer SoCs
>   MAINTAINERS: add Tudor Ambarus as R for the samsung SPI driver
>
>  .../devicetree/bindings/spi/samsung,spi.yaml  |   1 +
>  MAINTAINERS                                   |   1 +
>  drivers/spi/spi-s3c64xx.c                     | 447 +++++++++---------
>  include/asm-generic/io.h                      |  50 ++
>  4 files changed, 276 insertions(+), 223 deletions(-)
>
> --
> 2.43.0.429.g432eaa2c6b-goog
>

