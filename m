Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A663E7A193A
	for <lists+linux-spi@lfdr.de>; Fri, 15 Sep 2023 10:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjIOIyK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Sep 2023 04:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjIOIyJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Sep 2023 04:54:09 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9744A2717
        for <linux-spi@vger.kernel.org>; Fri, 15 Sep 2023 01:54:04 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7f1bc4ece3so1900838276.1
        for <linux-spi@vger.kernel.org>; Fri, 15 Sep 2023 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694768043; x=1695372843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozcR6ThzA7QtjFN0NTilMZpZlXZ4jUHDhIN9Pty4pME=;
        b=RdIFaPK6WXMA8NxoD/9rlB1kdvCV4zQZGOGc4ucqHpLktM3oMaUzdTegoRjCguHMUv
         hmbeN3hfzNWn7mP0iwOmit/5EA6low25RbjG6avZ0mcbM19iTa97ayLw2KEYEK/FIYeB
         0aBQqdtLcqG57CdfNKt9bKmX7rSq13R5OX/1y2jM834ZNux79R/mI9rg6uQNjurSpeDL
         6SM7K2RfasPQ4lxZ3wCeMqzuPXObIwRNcosrRajGTkhq6bWmwLIn+V7xmpP589EjN2mM
         h47f+VjcUlxQ6BMjRW6dQ9aZonuu3WmpuWwKIElNuCi0JNqKK2qgB7tn4L86mjSwMITU
         9Ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694768043; x=1695372843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozcR6ThzA7QtjFN0NTilMZpZlXZ4jUHDhIN9Pty4pME=;
        b=NdzDdRve9x/r2Jfsmj56LTfOgJ32T/F7DjR3IrEU8ZvsrH0hW3H7JqaVmeKDCPcKq5
         unfOFV0VYdoIsH+yKVDpWsRAeYd/dyqtCSUAm23lfAwJDUtOuvwWNBHzMpzJvRuOCT/4
         Oyyj4FMp45bq0exb4vE8TJ7pXOMfSPWkUyLO8zdi3UtLhD8MHizpfmLxR16AV+RJjaxd
         w9cI4gGXv4IYZVGj6iONUpBI/F+BmEVjHEVinw8Gvzo67fGATd8ohuJ6wkkP8+PN5+c1
         QO4rNm5ZX69J4Fdxn907njSu+QJp2GA3voocezm2oUo5vivDFaI7M+8YG114awgCui4A
         kEAw==
X-Gm-Message-State: AOJu0YzQG8qa6eZIq4Ge+U/9BghAgu/oyVld/QZ+jg2V9/VA058+Nx3x
        JuMLly1dnMSr0f7z1o23XD7O2txEiwTtia9VgwlLk5QFKK0BuFjs
X-Google-Smtp-Source: AGHT+IE5GD6AR8wXJRyVCK8a8mpKDMVIWfxvb3VIxHpflBqUfMn3LyR3kah62SgEc2uR8Mpi15pSDhj55sdCR0ytQ7s=
X-Received: by 2002:a25:9087:0:b0:d81:3e64:f649 with SMTP id
 t7-20020a259087000000b00d813e64f649mr868400ybl.7.1694768043606; Fri, 15 Sep
 2023 01:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230914190033.1852600-1-robh@kernel.org>
In-Reply-To: <20230914190033.1852600-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Sep 2023 10:53:52 +0200
Message-ID: <CACRpkdYjhwEtYdCF=Wd=oco4fnm0bOLFsQwjUYfZA3ZzK9FFOw@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: arm,pl022: Move child node properties
 to separate schema
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Sep 14, 2023 at 9:00=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:

> In order to validate SPI peripherals, SPI controller-specific child node
> properties need to be in a separate schema, spi-peripheral-props.yaml,
> which SPI peripheral schemas reference. Move the arm,pl022 child
> properties to their own schema file and add a $ref in
> spi-peripheral-props.yaml.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

That makes a lot of sense. Thanks Rob!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
