Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3919247F90
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 12:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfFQKWA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 06:22:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39896 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbfFQKWA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 06:22:00 -0400
Received: by mail-io1-f67.google.com with SMTP id r185so13995705iod.6
        for <linux-spi@vger.kernel.org>; Mon, 17 Jun 2019 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JN2E+IwtUfQPQQdy3G00TP2y5zUBmIutyR32yrXAa5Q=;
        b=bK4We18fXjsKW9J7Zm1QQRQux9wehYKeNyWDZejPf18JE2mD2V4L9EZuTpYkZ/7N9F
         Hzl/mifZZ6YHnZUdiOhaxtz6AwF9W85WBp7auez0ujP0s4rtcEDY9PJSJStWO7kI9I0a
         jwBuk4afyDo0K3E6kUP7JIiA0l9pgZ44xHdoMVaSEhEHyBmgD5PYaefMOObZOFdv0lFX
         /aaVVX2eeQ08995BryjZlsDgD08OsYA7Cn+owgLgm+pQZm4Wei0pMUe0w6IkfPG9EaY4
         NKWOBe48y7qvYTH//YBKGtEfMn38h3j/bKeGN8xaL31Ir/q08d9vMfiLgLOhA3b5CIIG
         GkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JN2E+IwtUfQPQQdy3G00TP2y5zUBmIutyR32yrXAa5Q=;
        b=o7qDqfVeFtD+eagPaq9vza/LX+JHYekx2Qe6MqpFAvNUdFmqBr/ytpeK1wyWi7A3cY
         ZYhUJBl/jyUm/fL4rxKrERuJS5OISQe3B5QlxO4JH4aKeJNxviFNJjdCyXpb/5hgrkXk
         YZFqRymMYOhrYn8lz3lWNbdObqq3FplHcwOqO6ArpJKeOvqZR5fN1CECy50w6aj2THYn
         MUMMz8X07z56hTJw80BsfVbx7r0B0paM/Z/V/ip8b7383O8Q0BsH5r5BzB94sN11aHG+
         I1vocRGkdbp7rrvA2ylmFe6+YthTb27ACTudKP/3t4wy+7oicibcCJDJqskd3LpHh6Aq
         /vIw==
X-Gm-Message-State: APjAAAVHhxzPrZORynxAQrw1Bw7sjM6jkc1q+sPZExcbaEqT84Ua5RLS
        tn4w7D2k2OZXbkTAC7m8rGMTz+tWdjYi88skDX2XQA==
X-Google-Smtp-Source: APXvYqztG8Xi2GdOvDt7kBVg9NBMnmPkc0/McZDRzUdkIP2yIslywl5O/RkImLd2B6f3cVTtSHyXbtsrmcKtcr+cahU=
X-Received: by 2002:a5d:8794:: with SMTP id f20mr10556579ion.128.1560766919750;
 Mon, 17 Jun 2019 03:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190617060957.16171-1-masahisa.kojima@linaro.org> <20190617101741.GK5316@sirena.org.uk>
In-Reply-To: <20190617101741.GK5316@sirena.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 17 Jun 2019 12:21:47 +0200
Message-ID: <CAKv+Gu-DYzRRG82t27nFZKeLOPzCYphY=AQCQy78=m591rXs_A@mail.gmail.com>
Subject: Re: [PATCH] spi: Kconfig: spi-synquacer: Added ARM and ARM64 dependence
To:     Mark Brown <broonie@kernel.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-spi@vger.kernel.org,
        Jaswinder Singh <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 17 Jun 2019 at 12:17, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 03:09:57PM +0900, Masahisa Kojima wrote:
> > kbuild test reported that Alpha and some of the architectures
> > are missing readsx/writesx functions.
> > spi-synquacer driver is only targeted for arm and arm64 platforms.
> > With that, added ARM and ARM64 dependence in Kconfig.
>
> Are you sure it's those functions (which only appear to be defined on
> arc according to a quick grep) and are you sure that there's no other
> Kconfig symbol specifically for those being defined which can be used
> rather than depending on specific architectures?
>

I'm not sure I see the point of this. Building this driver for alpha
and parisc has no use in practice, and does not provide any additional
build coverage given that the driver can be enabled on any ARMA/ARM64
build.

> > This patch also specifies the default compile type as module.
>
> This should be a separate patch and we don't generally change the
> default unless there's a reason to do so.'

That was my suggestion - just 'default m' is generally not accepted,
but 'default m' for a driver if you enabled the ARCH_xxxx in question
is reasonable, no?
