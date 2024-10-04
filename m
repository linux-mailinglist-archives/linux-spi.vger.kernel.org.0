Return-Path: <linux-spi+bounces-5098-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E1498FEA7
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 10:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BAB21C232E1
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD83B13D2BE;
	Fri,  4 Oct 2024 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="czBPWuCb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DEB1386B3
	for <linux-spi@vger.kernel.org>; Fri,  4 Oct 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029339; cv=none; b=k8vbnTwz92CVlwBE3IOrp0e2FZVbXJreSY4f41Tn6CKFGkHTUHfnhUmsNSYZXNwzLiFQPhxnLQGIpLZ7DQ+RlkLCbKY1noCJ32UKtbUwhgUL1Xtd8MXiVU2drfQPDVE8Kew6YmkNZSB79pgkQyKP9gwcdDfyLjEG7nvd5domoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029339; c=relaxed/simple;
	bh=R+t3jUtz0cFUE2iiC1aaK+uppYUomP576AZCbtGubGw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=h3W5OBizkjcZW/dti8WE17gq6RmOVJWhCxGHhBd+s56XYAuhZnvrHzvyA/fo7rEllNS3MVwxK7YF/ADhRd6/q8RiKEG9pNg1x2DwHzUHQMYHMzTeYXDJl0hB7RjRbF/DqmNMkNbmdCuAjVQ/Ga0WhtqxRZ67vbiINFfAoxEpkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=czBPWuCb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d3cde1103so237302866b.2
        for <linux-spi@vger.kernel.org>; Fri, 04 Oct 2024 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728029335; x=1728634135; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4auiUipRSvioY5qlUieN0FCimA2FylPsygyRNrf3t9I=;
        b=czBPWuCbZx5GFdrJDX/9xSe5FSbHs09OA7IekwuS4vyzfRt+8mo+KYT8ohTqM6uUsE
         s/4TskM7k65RnvotLXnaEDUrXyIynBtr27FgpCiawtku/5LFIpjehtyXfTly2hWGsJ8f
         I91LmFlXLXMlQAirEjLUeSFdvCD4oum+GbN3YxSMPu8fX7q4rkxB1xudq98A4zuRzvhf
         MiE4LzIW4WNCixOWTVX4RAlHvBMacwQ3bSKvVgukXvmuPGtWCAHSj5mMw1m+ZdYD1iVA
         HlTqAe5HhHwW8s0DdyjcI5ZzdjQP+3osdLgc/Wg1am6FzV2ThCjNu0pYes4t5+CFT2vR
         k0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029335; x=1728634135;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4auiUipRSvioY5qlUieN0FCimA2FylPsygyRNrf3t9I=;
        b=cI+zPP2f3UYzwmRUcvFxJfG+B0x3W0TwN6etdxAhhcYL9LRyFhR7VfYKGbk06S2Gz4
         OGg5I0Bg+o7Z/6wXrItTuLerc7dbkZfCyRTwOSa/iPFukIAzzMDdhGku+BpE5tgNXhaS
         OD5t1B2HkAOd/17NpVr9vDbtMNkPB6g8ivdLgklGhmssPZU0xehyqJ2d9IDnsiWshK65
         UYkAGHntgcrgS7MgJSEXNk56qWwz2pvRdmH8SQQCiXxUMuKO244giW/e9Xi60iAZZ5DU
         9i0mTgwH2bVKELvj1AfK8tTN1E46ZG4uQxfDxuGi1mgx3f1o1mb9wmNDYC1sdGkqepbQ
         1dAw==
X-Forwarded-Encrypted: i=1; AJvYcCUpL9glm+NN5HBoRbZgXNT4a5xpDvYYIH/hcH5Oucm43XuMG4L3b2q+VDBCSEIclfkEaRj14thd12c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6LThk+eLAzECgm1j7oFsX0wmtUqoUNFT4yqrX0npUL/4nLiqB
	wlX2uBiSO7gMN6UdOUycJJxYW9VUCrq5+8BB/BUf7wSKqNaRZvaBcj0sSR37enU=
X-Google-Smtp-Source: AGHT+IFgl/nvfLhcNVun/syHAmXlZefx9G+73C15fAoSRXNCIuh634p0eFrgfM/y8L+b25rL7WLqkA==
X-Received: by 2002:a17:907:9306:b0:a86:b64e:bc4d with SMTP id a640c23a62f3a-a991c033557mr210668066b.44.1728029335197;
        Fri, 04 Oct 2024 01:08:55 -0700 (PDT)
Received: from [10.11.12.174] ([82.76.204.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910473a89sm193047166b.149.2024.10.04.01.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 01:08:54 -0700 (PDT)
Message-ID: <5b2bcd4d-faae-40f6-908a-63f4dbb02adc@linaro.org>
Date: Fri, 4 Oct 2024 11:08:51 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Cc: AlvinZhou <alvinzhou.tw@gmail.com>, Pratyush Yadav <pratyush@kernel.org>,
 mwalle@kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 richard@nod.at, "open list:SPI NOR SUBSYSTEM"
 <linux-mtd@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>,
 chengminglin@mxic.com.tw, leoyu@mxic.com.tw
Subject: [GIT PULL] spi-mem/swap16 changes for v6.13
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Mark,

I've made an immutable tag for the spi-mem swap16 changes. I let the
0day bot run on them, I got no complains. Pull if you need them.

Thanks,
ta

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
tags/mtd/spi-mem-swap16-for-6.13

for you to fetch changes up to 50cb86f21ec2ede08d0ec0479fbd8697a8a25616:

  spi: mxic: Add support for swapping byte (2024-10-02 09:44:57 +0300)

----------------------------------------------------------------
This allows specifying the byte order in Octal DTR mode.

There are NOR flashes (Macronix) that swap the bytes on a 16-bit
boundary when configured in Octal DTR mode. The byte order of
16-bit words is swapped when read or written in Octal Double
Transfer Rate (DTR) mode compared to Single Transfer Rate (STR)
modes. If one writes D0 D1 D2 D3 bytes using 1-1-1 mode, and uses
8D-8D-8D SPI mode for reading, it will read back D1 D0 D3 D2.
Swapping the bytes may introduce some endianness problems. It can
affect the boot sequence if the entire boot sequence is not handled
in either 8D-8D-8D mode or 1-1-1 mode. Therefore, it is necessary
to swap the bytes back to ensure the same byte order as in STR modes.
Fortunately there are controllers that could swap the bytes back at
runtime, addressing the flash's endianness requirements. Provide a
way for the upper layers to specify the byte order in Octal DTR mode.

----------------------------------------------------------------
AlvinZhou (1):
      spi: mxic: Add support for swapping byte

Tudor Ambarus (1):
      spi: spi-mem: Allow specifying the byte order in Octal DTR mode

 drivers/spi/spi-mem.c       |  3 +++
 drivers/spi/spi-mxic.c      | 17 +++++++++++++----
 include/linux/spi/spi-mem.h |  8 +++++++-
 3 files changed, 23 insertions(+), 5 deletions(-)

