Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B0011ECEF
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 22:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfLMVeV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Dec 2019 16:34:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37772 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMVeV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Dec 2019 16:34:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id k14so746052otn.4;
        Fri, 13 Dec 2019 13:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CnL0ppP0hu7PBsUqVprgfTmViSxAVBY2hM4t+lEup30=;
        b=KfLYesjRMXVEv5JsN9TJ0Z8DO4bfG0oqoO18/D4lEYVhPwP/dcaaqB+uIynRrnuOdc
         Zf9S630/ZLJ9Ub4ftx++e7KHSoZb3hPtkqPSXQV/dLjYyNqXP3kLl15YZlCF90OD57zR
         SItJXIdOpW4Y6eGFaGcq374RcyjUVK9ftiZKiAFyK26YeISxqt0e+mP5VyJ4sOywJFwd
         bC8AjB03hZfH2ELBQ1Qiz03d1O0Foc7PO2hVZCC4LzHnY3pJXUxdkS5ISK1Vnuw0WsX2
         o572auBBovnGBB050+neKe4vrLRqREzpwPUxKshUL17pn3bNNgratq3R18j0K7IWEeXP
         QwwA==
X-Gm-Message-State: APjAAAXnULB8J0UaOvzixqyJou9UoRgSm03gGTnUl4bbDCkiJwx5EBAS
        bb0DnxWZGNX3iixsyHnQrg==
X-Google-Smtp-Source: APXvYqxtLmwCSQzcGbNdN9x9BipFNkJ2YdICwPsaYd45wZnOrdGRLQWzOOV9fMbVNvAU4hoYVvYkLw==
X-Received: by 2002:a9d:6181:: with SMTP id g1mr17366399otk.104.1576272860189;
        Fri, 13 Dec 2019 13:34:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a16sm3798678otd.64.2019.12.13.13.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 13:34:19 -0800 (PST)
Date:   Fri, 13 Dec 2019 15:34:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] powerpc/devicetrees: Change 'gpios' to 'cs-gpios' on
 fsl,spi nodes
Message-ID: <20191213213418.GA17361@bogus>
References: <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 28, 2019 at 12:16:35PM +0000, Christophe Leroy wrote:
> Since commit 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO
> descriptors"), the prefered way to define chipselect GPIOs is using
> 'cs-gpios' property instead of the legacy 'gpios' property.

This will break using a new dtb on a kernel without the above commit. Or 
with any OS that never made the change.

I'm fine with the doc change, but you should keep 'gpios' as deprecated.

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  Documentation/devicetree/bindings/spi/fsl-spi.txt | 8 ++++----
>  arch/powerpc/boot/dts/mgcoge.dts                  | 2 +-
>  arch/powerpc/boot/dts/mpc832x_rdb.dts             | 2 +-
>  arch/powerpc/boot/dts/mpc8610_hpcd.dts            | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
