Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5669332CEC4
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 09:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhCDIuF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 03:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbhCDItk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 03:49:40 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2B5C061763
        for <linux-spi@vger.kernel.org>; Thu,  4 Mar 2021 00:48:30 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f1so41878856lfu.3
        for <linux-spi@vger.kernel.org>; Thu, 04 Mar 2021 00:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2wbxkZ5EFhhbbOmwBTKlvU1xjWHEm3aG6/6XZryrvM=;
        b=aP2tQTyLBKDPBoAnWKTOPwDqLrDfAzvHWjHRByw8Q2HneMAUDwP/6S3cHX5ozzAxSc
         mr/c++GCpYQcsIn0n4iMZK9iT+3Y7/GTWYLayG5b/NiUHV292Obc1KsdVePmOAGnuFnP
         dLZ/btA6PpMa1U/KMCHGMNAhub4bmozr5RJZbJ75y+St9LLksdz4HQpeMyyM7q0NGTKb
         XJDLW/N8DaA3AIdtaanC7CBGLXPw/Uhx+oOn1uJvR86/6/n8c4BOOsXxLikhMEf/1yeJ
         Ywnj2iLiASEAeh15xadVyP/Dpk+E/MQpIq83p6oFAXLQOHQhWs+U1ByEjbei5Bug16y2
         fJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2wbxkZ5EFhhbbOmwBTKlvU1xjWHEm3aG6/6XZryrvM=;
        b=i8mimKYzYuNMmBaJU5isQTZ89p4+27wGYAvSFddLkibiEwM+Xh9iKXF2jpWfcM9u36
         t97YM7sOh4luVGcoxn4I+UtzVdRXvDWdvj+rfZXattq6bSaAskBYJ1jAnkZgwHfklKS9
         TZJV68tPZMZ+Wd3Faz0rN0GjXHWAEJNru4PqF+xBmgC7ksPom6zj1PZsB/JsUO85nm/Q
         7AxUdkWOZnL1ly5kUStp+VQt70JE04Y6eUalG/a83XNRVGk1jFYg8o4fS77HQFROmcB7
         rztLkCDAmORl+oz7RWSBKFHjEGj5cNGHSVui1momGQXa4ayUOrts6Lok7eQlU5e2v84K
         84BQ==
X-Gm-Message-State: AOAM533bYXdE7F7zECKQxv5fvJsuK3FYVDK4YTbkJcuF9JhMjBxyXReY
        uLSWvkaYx0MLNAdiec6W71GkMQ0ZpMLDuDWX503KAQ==
X-Google-Smtp-Source: ABdhPJy1+p6e1tWc1GyX6LEEz232ReBa7exSHnMHwCH8+LPQuXuIdaQFmdvSbMVG2X4FN7uvfv/aIVi6+AmRoKuFNHc=
X-Received: by 2002:a05:6512:547:: with SMTP id h7mr1696001lfl.529.1614847708722;
 Thu, 04 Mar 2021 00:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-4-brad@pensando.io>
In-Reply-To: <20210304034141.7062-4-brad@pensando.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Mar 2021 09:48:18 +0100
Message-ID: <CACRpkdbqkmUXTPyX8OFxBRJahEL-vdxR0wP=rMAWud34bq7tcQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] spi: dw: Add support for Pensando Elba SoC SPI
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 4, 2021 at 4:42 AM Brad Larson <brad@pensando.io> wrote:

> The Pensando Elba SoC uses a GPIO based chip select
> for two DW SPI busses with each bus having two
> chip selects.
>
> Signed-off-by: Brad Larson <brad@pensando.io>

I agree with Serge's comments here: the existing cs callback should
work for your SoC, you should only need the new compatible string.

I see why you need the special GPIO driver for this now, as that
is obviously driven by totally different hardware.

Yours,
Linus Walleij
