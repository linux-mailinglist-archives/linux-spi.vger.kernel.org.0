Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B326406
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2019 14:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfEVMt6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 08:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbfEVMt6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 May 2019 08:49:58 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1EC2184E;
        Wed, 22 May 2019 12:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558529397;
        bh=5ZGoJi7NkwXVR/OD6kRE/4231NNk5lVLqumccNmisaM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P/Xi9UJqmeYRdPazqEcKP9IuQTWCddd6kst1SKQ3qjtCiUCMbvuOEEDFicZv/pk63
         NeV63sW+AFY9dTKnLz1Lreb0QxFX4AC9RFKcvXTXt1ZrMWRDQBPXZKLqEvEDUM4vwH
         QT+r59SQPi1NU1B28D+wbB9ZjFloODaKSgvs63xA=
Received: by mail-qt1-f176.google.com with SMTP id l3so2117819qtj.5;
        Wed, 22 May 2019 05:49:57 -0700 (PDT)
X-Gm-Message-State: APjAAAWgIyM8BMsyZnX/4MYJ8PqkHZq5xjOzjYEdpm1Io3t19gHUAHMF
        UcE59Zt4y1/JJ/VW0C0ExMivMPm8k9Kup2H2tQ==
X-Google-Smtp-Source: APXvYqxJyh8gPJdSllFYvlfTjnDcRfyrin0i7k2617dS8CfKNsSi0ccmNnsl8crgC8wL+I59VDGEoYxEPmonj9M9fPU=
X-Received: by 2002:ac8:3884:: with SMTP id f4mr75987199qtc.300.1558529396825;
 Wed, 22 May 2019 05:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190521212325.16639-1-robh@kernel.org> <20190522104226.nwcvx33akt6q576m@flea>
In-Reply-To: <20190522104226.nwcvx33akt6q576m@flea>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 May 2019 07:49:44 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+JimAYW9GiPz6_hNJfnA+8bnN=kPDOEJFPyt+57bwriw@mail.gmail.com>
Message-ID: <CAL_Jsq+JimAYW9GiPz6_hNJfnA+8bnN=kPDOEJFPyt+57bwriw@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: Convert Arm pl022 to json-schema
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 22, 2019 at 5:42 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi Rob,
>
> On Tue, May 21, 2019 at 04:23:24PM -0500, Rob Herring wrote:
> > +allOf:
> > +  - $ref: "spi-controller.yaml#"
>
> You're using a different construct on the spi-gpio binding you just
> sent (/schemas/spi/spi-controller.yaml).
>
> Is that on purpose?

No. This one is correct (though both work).

Rob
