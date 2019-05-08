Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518AC17870
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfEHLh1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 07:37:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46709 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfEHLh1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 07:37:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so616916ljk.13
        for <linux-spi@vger.kernel.org>; Wed, 08 May 2019 04:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpnqPkoNie8VmWKHRIpsFiWwxyYHdk0y7DvESb47NKw=;
        b=mbcEThxtHl49DxJFwaowXuzI7O1hKSRz8ynBF7KQphTgOg3MvGiKlfJZKS+mbeD0VK
         qiaUydH/m8ZgkzN/cZl5xLXIua5/qZll5IJdOsSwi8QaUXxu023BnPON8Q7F0MLqojxb
         TGZHDF8CFVtIimWRZVMxojhfMcaBBQOlYYZ2PlgZWCOga6EtiKxjMuDHCTSv70E5BKhA
         uUu24qk0IqqvhlmNIvJqUYMA0DQm9uhFwnZZvHXs0raGlnEAj67zl0lw9dvpPcFbPCVB
         EEJ7zJ92TEpqsLLwjP3pmyAR9k7KywJOdupgZ4AVZhyh8880zi2uk0kt5NLcUx5C3UR5
         CCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpnqPkoNie8VmWKHRIpsFiWwxyYHdk0y7DvESb47NKw=;
        b=b5ZVske9zmH0MsemHn/81/Np4iz+jn56EnH/iSOczKKyAkec6Wf+PwWqDZmgcIe3yk
         RVA4CtwqmnxPqRrbo2rQ2LQBbmmhEXq4x0T9IzkdUQwXzBNXH2HISHkqSiYyTvzQ38Tt
         xvIYqCL0I2EMc3OfC18/F6QLzeH3EDrdkfl5gGb1xIgsrpnQlOgL7FUuDwjf03n/nZuf
         W5E7x99ShqEa6N12C1nDXbNSzRmk7UUF2przmTWtx00aMbJxSmZceCesBCkfDIV/83Nd
         ovQrTwaQ/q1x0QIsqg9z5TxlV2PuP+gt8j/ksJvTZOD6xQLaQ2J0EFWOdccReKEYf5Bc
         0SHA==
X-Gm-Message-State: APjAAAVUQLrZf84b/Ld3IpyaW1Hg8QPPBlmcHlfxOJUZu8atxbCceWzQ
        S1Syd64z0Qd7kSLLvvs/dvBg3mYRChyZ7A8UJaS8Zg==
X-Google-Smtp-Source: APXvYqxzokkoYM0CYuKBdGSmRVEMfbeYgO/MyK+IGeHzFGxkNxpbkvrtGY9SLOeyBiISFuFxSx34VgJB+9ntDFcD0tg=
X-Received: by 2002:a2e:9547:: with SMTP id t7mr20959335ljh.153.1557315445260;
 Wed, 08 May 2019 04:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190420111404.6225-1-linus.walleij@linaro.org>
 <20190420111404.6225-2-linus.walleij@linaro.org> <20190508085447.GA16289@sirena.org.uk>
In-Reply-To: <20190508085447.GA16289@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 May 2019 13:37:13 +0200
Message-ID: <CACRpkdZethuC-da_ePjMyhXDmaxrcxTj8iK9taFptdAPp0FOhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: fsl: Convert to use CS GPIO descriptors
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 8, 2019 at 10:54 AM Mark Brown <broonie@kernel.org> wrote:
> On Sat, Apr 20, 2019 at 01:14:04PM +0200, Linus Walleij wrote:
> > This converts the Freescale SPI master driver to use GPIO
> > descriptors for chip select handling.
>
> This doesn't apply against current code, please check and resend.

Let's hold this for the next kernel cycle. No rush.
I will rebase on v5.2-rc1 and resend.

Yours,
Linus Walleij
