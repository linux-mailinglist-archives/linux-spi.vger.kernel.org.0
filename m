Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E42493848
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 11:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349059AbiASKVI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jan 2022 05:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbiASKVI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jan 2022 05:21:08 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F67C061574
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 02:21:07 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id x33so3522468uad.12
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 02:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAq2GHUlmK9e0a4SGMbGLyaITkdBnfKqtBK3aX9Whcs=;
        b=I3rVfJXq2NVP8dqgHqcFAirDhg+hPcQzCZyxN7SHayOy8ckvDF8N/62MjRBrz97aL6
         Ma1/dYJOnkrehrJSWMtXeUYFGQ5PXpI7I8uUcmUiC/9LAMUUmfRai2gTWUyFVuLR3VHx
         a6NSw9WXkWKtzZYzoTE6AepIt6tmP65aNdHVIQTV62u7fFtym2M5S3YzTh44U3kiwMnC
         MrL9J1Bx9i6M5Oq6mp6L1yXg670xBL68ndzH0SUJ6xZQlgN+WLIA+Ru7tAA77VJYXFlA
         mi+bhPhD9B20PX56nw5u7eZK6HKMD4hKDlrmm2x7SMzNihwk/ATFEYQi10eBrx4v6Nol
         ZjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAq2GHUlmK9e0a4SGMbGLyaITkdBnfKqtBK3aX9Whcs=;
        b=V5CHPOR1ETqUTU8lVbc846oLhwpV3vQS4yqE8RoIZQYL/xYZXPKQHTGMeX4xKI8Yc6
         OfTu92A8Nu0ROGEtziDoN1pvFzp5tKq7OQhe7JVJCU6PVMGMv1CCfiVo6WUYhkPTPbP+
         mG1806mOPrNMpiyfLxXiRl/W2oIlsUpzvCSrgAjF6V0g4jR03GEpIxC3XlFKpCYkMLgE
         EZwOV8gF4aXC8WgyLQQqZoIpCtRFVFy9Mi4xwZz/MfIVeCMl70VIgNO3jv1gy3x8OExv
         jDsS+Lpr0hXOGLmz742WKwHBhdYOAQoxQgzHGi0ZAhGD5VTRtWb/uGYjl74lWHdFMq8c
         +dTQ==
X-Gm-Message-State: AOAM5320dAdu9YH393IlT2uSOt1XUrohXmJpVd418e50JgWCswxUCsbK
        PclIJHU5p9PAiBLlDxW9FQs2kyr2lZkV84m2fQj9WA==
X-Google-Smtp-Source: ABdhPJzWMPXB35VP2FzS7xpvvyuejvxAZ6PKtDb7KxZe1WiMf/xocc++NtG2JakFJuMWZLXpMzBwXBKfixe+m4QmKXk=
X-Received: by 2002:a67:e109:: with SMTP id d9mr10945818vsl.57.1642587667172;
 Wed, 19 Jan 2022 02:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20220118230915.157797-1-linus.walleij@linaro.org> <20220118230915.157797-2-linus.walleij@linaro.org>
In-Reply-To: <20220118230915.157797-2-linus.walleij@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 19 Jan 2022 12:20:56 +0200
Message-ID: <CAPLW+4=7aqcA=n6Hb8Fd+hoWSSzZSeMGDUkA_ceBmesC4ndJTA@mail.gmail.com>
Subject: Re: [PATCH 2/3 v3] spi: s3c64xx: Drop custom gpio setup argument
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 19 Jan 2022 at 01:11, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The SPI0 platform population function was taking a custom
> gpio setup callback but the only user pass NULL as
> argument so drop this argument.
>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - No changes
> ChangeLog v1->v2:
> - Split out to separate patch
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
