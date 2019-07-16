Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4956A45C
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2019 10:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbfGPI4x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jul 2019 04:56:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44766 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731702AbfGPI4x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jul 2019 04:56:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so19117747ljc.11
        for <linux-spi@vger.kernel.org>; Tue, 16 Jul 2019 01:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InUWrv7LAkQKvZ+McQ69NdIMdHUt9wQBtSn0Ql2S6b4=;
        b=NYWBxxtkEarHHKN4dpAk9Z3o+e7dlOaIFbYRjCgVyDUXE5/Q7hCWk37cEjSrv+kDaI
         v7yHpJDZmf/3oYGlbX117KQzLJ4umJQ5+OjX6dw31RpDF48K6L5OswFhXCK2/NpCeonR
         jNNqGULBmAFVTWgakUEu4ZcLpiMAjEecaPzDROkawKgKwYej+eNtIu6Sj0yns/uOU40q
         TQ/2gC66WBgRApLvY2Qn8suKx1B64NI8JQeg/SyQBB+mBkNPYCOO26gNFyyVaq5smfTc
         2mZLXc/xf0XXa5oYidiHELyQSWN/3pnZoGg9/bVf2tLlzPOewh0d4cEHHMqWpOZfR0CT
         F65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InUWrv7LAkQKvZ+McQ69NdIMdHUt9wQBtSn0Ql2S6b4=;
        b=eboAnGGt6kQvXkntkThy1udkrEEbArdihYoyz5qGxFSojod2yCL6guVQt4qaKiztRQ
         yXv1CJmczyG4QK2ZkMZuXvpgIkc07TEnKoHV1iP7tqZWCh4PH0uU5mj30Q5+G5LB35Mm
         maOKW7sFUvBraUO4u4KIkzH3FXPvNN9Ufps3OJt3sN1xcjHeeHE4SpS265VdKfN+/IAk
         D1bGiuWht48cfCXrIKEdpMB9ROADvTJlhWqHa1z69mwIkSNvVxJhJ/HoJKbNyEM5bCir
         mJHwJ4DkoanTYge8uMkLnMaqI2GpHTzjOVbPFU40BEpiSG4+hLT3ADeEpk+ZNd+FF7eU
         /KLA==
X-Gm-Message-State: APjAAAWhc9Km5/pckFLwrR10bKoow+0Sdh8FygpVlx16aHBMef2ZFZKC
        qQN0+5G4J+ikmeEhmcIoIPbe3I7alyofqhwilSqi3A==
X-Google-Smtp-Source: APXvYqz0/LleO9xJcnbDEQsKjfgEBzAose29BV4VVCT9BK/mzxrXWaVnDmJyWLu7V7p65vgCAaGIQkI8PUIsBxalh2E=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr16865993ljc.28.1563267411846;
 Tue, 16 Jul 2019 01:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190715204529.9539-1-linus.walleij@linaro.org> <20190716012712.BC9F22173C@mail.kernel.org>
In-Reply-To: <20190716012712.BC9F22173C@mail.kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Jul 2019 10:56:40 +0200
Message-ID: <CACRpkdaLQzax2XPJ4j1a9gNw3r=ZizVSgsbLFGAycCLd2TzD0g@mail.gmail.com>
Subject: Re: [PATCH] Revert "gpio/spi: Fix spi-gpio regression on active high CS"
To:     Sasha Levin <sashal@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 16, 2019 at 3:27 AM Sasha Levin <sashal@kernel.org> wrote:

> v5.2.1: Build OK!
> v5.1.18: Failed to apply! Possible dependencies:
(...)
> How should we proceed with this patch?

Only apply it to 5.2.y once upstream.

Thanks!
Linus Walleij
