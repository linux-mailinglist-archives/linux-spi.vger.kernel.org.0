Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB451E0E47
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 14:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbgEYMUh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 08:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390569AbgEYMUg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 May 2020 08:20:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6925EC08C5C1
        for <linux-spi@vger.kernel.org>; Mon, 25 May 2020 05:20:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x22so10418545lfd.4
        for <linux-spi@vger.kernel.org>; Mon, 25 May 2020 05:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2uL/BTgbcmhuM5YoKw/xsIFunhmdvIl/vJd/r4JhQGI=;
        b=s27kr2eqyPVVUBlXSvFGIQr/trFb1G9zTpaZkf+2EZG3Hx2n20tojKndnRmHxnFm5B
         ASp5qUZUcNhgDtSz05MKDEc0AhNM7RX+XqKC4RcH+dueKzNuzdA9UUtfJm3QObywiyNn
         gLyUfwWbN87noM3TipQ1xxzLT/qC8suP8C2ItO0uKVBLZF7gkDhYZYdyWaPhGsZlURx5
         dC7jiymi5TrHLn3WrjWoWbTG/vN0K0XXq9T9jya4WAVmkhAW4KU3DPDDLxbaJk+51A8y
         NPUY8Y3/kWXC5iqcAEtXLI21yhLyJybrVzQtHPxoRDO5FDHaT8xNMF10qM6k/sr2ih0m
         THuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uL/BTgbcmhuM5YoKw/xsIFunhmdvIl/vJd/r4JhQGI=;
        b=YqQywV3/uJTVb521T8nac+5WuD3tldsUvNGPSMSPkn8V3B6sPFGyNDiy6gcUUV12Ry
         rDK4BRq5gEvcZ5aR3dYCN8WxxNWbZTIuY5S2NcQlD57Nsh8qqVMbC/8IA+mbo0Cm12e2
         V3cudurjCP9TDKDlMx3asuOx2hEoCK8aa3MacimkymrqEk4P7XUoDBR6O4TOyvr9ffWQ
         YwI1n46qcSPH5RBzsrOTKJRxDBIeqm4JrpEn34T8AFvxZDlSM6+55+9B2O9uf0nyaKk3
         WKUOnOMEdk2oMhGBR/eJOtOuVvbPXVNPrOq/EBuEDI/zL2fH2aWhDFbj4AIAVsMjtpsH
         V/hA==
X-Gm-Message-State: AOAM533d+tpAr7Oww6WEZmsgtTgkL877PsZ1rfx0wqD/EHUALuTUxTrv
        Z8q7WkZJRz4Lt75ZpGOG3dRb66WPo+WqjXG+rS2IYQ==
X-Google-Smtp-Source: ABdhPJzzn4cmibq9OV9VwB1X2PlikxB9SvAFGTTF5EB8YLtQ3tUTqPOcsUIpd9PFnnM7N1+NhdQzLiY+0rFB4yQUkHM=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr14251823lfn.21.1590409234803;
 Mon, 25 May 2020 05:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com> <1590378348-8115-5-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1590378348-8115-5-git-send-email-dillon.minfei@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 14:20:23 +0200
Message-ID: <CACRpkdb=+T0jSzBkrViHnuXGNhD4F3d_VX1t-hkqMG0CSdDhnQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] dt-bindings: display: panel: Add ilitek ili9341
 panel bindings
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 25, 2020 at 5:46 AM <dillon.minfei@gmail.com> wrote:

> From: dillon min <dillon.minfei@gmail.com>
>
> Add documentation for "ilitek,ili9341" panel.
>
> Signed-off-by: dillon min <dillon.minfei@gmail.com>

This looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
