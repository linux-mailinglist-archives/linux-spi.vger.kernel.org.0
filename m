Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5398B8C92
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2019 10:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395233AbfITIWe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Sep 2019 04:22:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41658 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395229AbfITIWe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Sep 2019 04:22:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id f5so6211344ljg.8
        for <linux-spi@vger.kernel.org>; Fri, 20 Sep 2019 01:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Y0dVg0rkJK+8ZRofkpbBt2xSCy2wZHIwHwOHo3SAF4=;
        b=ijM79mHPeghORpgUUpSTuQqXqvtIACE0riFZ3nYDpc7/JUA+ll2naj/N+DHS02awJw
         OniheqFSOFHPSooSh0bgBiyzFsuOXTRYpEMCETKNwyTJSBtUwC/J0gXUK14oLL5diJzK
         UTTDsVF+fEvrLh6Jx3Yh9ddZazJDlygia+Pv1NJ4DAJQPC/LRaRb96Kg8T4rFQ7JRQhD
         V3wmSB1E8e4lkLsBD5Fdhe9QRWMrh6VaXkErzyu38LWRLUY8G3SbCo/Bd/tr8fmGuca6
         gezS2HqWJwtcIrSj95vLbF50pdpCfwssPGNI48JgGfEQPicD3R/4wmNhYazixE/codC8
         zygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Y0dVg0rkJK+8ZRofkpbBt2xSCy2wZHIwHwOHo3SAF4=;
        b=fU/DOnIec9jBrqEtHYKYhssG1entUK/QRpFrL07cT1VCe/E/18I7UyCdE6GBiNd07U
         eZuowq7L6BaeC3/osHfboGAwDu54fLRzzQ/LUgsxvdvN7l8w7NDYq4r4uHdP+RInKxET
         oZa6ILqKvidDC6niNPh+4PqH7LJWEogF3NSAor+ssY1sU4BI2lZVNLMi21jGCwx3RPep
         w6HcYuPgxmmggsBqptunBa8wAX14+nSbNv4vUynRU7YdpeCQXRezp5MtTGJJrWbGuQn6
         tpkyG081g/lI2+iMNsPMm/u88agotFQCN/5e2K6Avi3lD2m4snz7GvzgJS/JqSDnXb+z
         IZVA==
X-Gm-Message-State: APjAAAWXOdCfcSlU52mRiaMAIz9Nxip4TBrbS3vO3l/9mN+WNDXcwJgT
        uXMf4xSWXytCuwVha898inSui/HilobhjoIrsDOAO+lfNnwCyA==
X-Google-Smtp-Source: APXvYqxO/HYaho83HxZXL87Foe1xgGVU5sQjvCOZPhZImVv2TthQt26ZN5SvNOQQR4SC29BcqRjlR1d06awwiiwTB0g=
X-Received: by 2002:a2e:9ccb:: with SMTP id g11mr4454624ljj.62.1568967752338;
 Fri, 20 Sep 2019 01:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190918155200.12614-1-dqfext@gmail.com>
In-Reply-To: <20190918155200.12614-1-dqfext@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Sep 2019 10:22:21 +0200
Message-ID: <CACRpkda30tm0cVHpZHnjQki86m_4ZfGiufg8e=6Rx-S+zFHF_g@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-gpio: fix crash when num-chipselects is 0
To:     DENG Qingfang <dqfext@gmail.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 18, 2019 at 5:52 PM DENG Qingfang <dqfext@gmail.com> wrote:

> The cause is spi_gpio_setup() did not check if the spi-gpio has chipselect pins
> before setting their direction and results in derefing an invalid pointer.
>
> The bug is spotted in kernel 4.19.72 on OpenWrt, and does not occur in 4.14.
>
> There is a similar fix upstream 249e2632dcd0509b8f8f296f5aabf4d48dfd6da8.

So since this is fixed upstream I assume you mean that this should be for
stable v4.19?

I think the stable people want a special commit message structure,
see:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Yours,
Linus Walleij
