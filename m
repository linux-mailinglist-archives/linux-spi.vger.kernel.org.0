Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A0D67B2E0
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jan 2023 14:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbjAYNCT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Jan 2023 08:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbjAYNCS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Jan 2023 08:02:18 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7D245235
        for <linux-spi@vger.kernel.org>; Wed, 25 Jan 2023 05:02:11 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o20so28819564lfk.5
        for <linux-spi@vger.kernel.org>; Wed, 25 Jan 2023 05:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WUlWEcztX7LC+YPVdX7zQ3TiSCzemn77YbP9UmZzYSE=;
        b=ZWujWps5xV+1Wp9WkpTktZV8uw9uUYoO8g5XV6hX5GoFex0wS6QvPRwAG/2X2m1TpC
         AnHeNzLJDDtn53tWfoYWTefbTDjXDAE0nyphHivQZvoRdrxbqpV+7GwZiiMjSczRHu8S
         2+wR907XANDw+tY9iJAZ7kQb7uGdBtK+VXYG5abfl8fMtfvdNrdyGPXGOMxIoU9QKeVu
         4IlTBODyMAWFOY81r6JOyh5Fa315CiPWT2rXXbjFQEfpJSeF4VXVDJglh9UTsnUwh9su
         TYGOZhQhykmGOSX5lbdOvzn5eD1DRAR9mumAOcV1QbWLinLDbhcnO/qlNyd2Axsp+wEi
         p/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUlWEcztX7LC+YPVdX7zQ3TiSCzemn77YbP9UmZzYSE=;
        b=fnXyd1I7gBPoGmzq+SYpKa3MsmLTqLs9tGpuB3KnZ2IQNMD9X9nNIFjBLCDj8ZWQWf
         SN0U0uBE0bbenpmU+edD0KhS+7iyZN4uaNeYj2Qk0Vq5tMvF05ptgO4RcbqyJqZ0gR4v
         I8na3yMIG2wv+uKp4XtVfaChAJ8CaxNKrXJ4NKwummR8cDV081nsJObz6UYFPN6s2lVo
         18Qe+/Gjja41Ha5LwzZ9cI+RODWjnm0Z5go9nWd0sZTIjT+bom31Xv7JQSD5X6x/vNPE
         gF73zELvfV/Gmc3xWtnlAID3BAqRF8uIzZlaG2NAYGG9d1tmLG5SiSMhrtBqo+pLUeHc
         mn5Q==
X-Gm-Message-State: AFqh2kqgAeJfpmw+rVYH8NrBKAih4Jj+YM3AptcX56oQRKYvTIaVuhr7
        gnmciAPmMCV8v2nZfGPL+gHQd8ImQ7nFNvv0inClMw==
X-Google-Smtp-Source: AMrXdXua3Xzk3n+mAS+SHWDmCwyiaUE3a82cF5mU8PKvzbJFSacMHuyCjbHJ/PWxjesRw9CjRh1dmLPf3Blx2uP0BXc=
X-Received: by 2002:a05:6512:3984:b0:4ca:faca:5b59 with SMTP id
 j4-20020a056512398400b004cafaca5b59mr2768406lfu.615.1674651728174; Wed, 25
 Jan 2023 05:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20230124230048.371144-1-robh@kernel.org>
In-Reply-To: <20230124230048.371144-1-robh@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 25 Jan 2023 14:01:55 +0100
Message-ID: <CAMRc=MfdDv5teeQx802Qi3otwfXtZ1jAX_bzvH4DQMvdas9YtQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add missing (unevaluated|additional)Properties
 on child node schemas
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jan 25, 2023 at 12:00 AM Rob Herring <robh@kernel.org> wrote:
>
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present.
>
> Add unevaluatedProperties or additionalProperties as appropriate, and
> then add any missing properties flagged by the addition.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

[...]

>  .../devicetree/bindings/gpio/x-powers,axp209-gpio.yaml |  1 +

[...]

> diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
> index 7f26f6b1eea1..31906c253940 100644
> --- a/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
> @@ -35,6 +35,7 @@ properties:
>  patternProperties:
>    "^.*-pins?$":
>      $ref: /schemas/pinctrl/pinmux-node.yaml#
> +    additionalProperties: false
>
>      properties:
>        pins:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[...]
