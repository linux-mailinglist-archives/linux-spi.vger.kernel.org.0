Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27B967B6EA
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jan 2023 17:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjAYQ0y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Jan 2023 11:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbjAYQ0x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Jan 2023 11:26:53 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0BC1BF3;
        Wed, 25 Jan 2023 08:26:48 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w11so7049981edv.0;
        Wed, 25 Jan 2023 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ilN6S2DYFu/DESx5TOWbGLPHlfDmzvINI2SI+/X/LA=;
        b=o4j8nJomybIx4kE59DRw52ujqDVZ1WQewtiJ58C37pZX/5DWWR3us5SruXAAGyfGBc
         0oxAeGxQTdIDM++/ONptAOL1nO0F6K6FiZC1F/r6Qme1XRV2lBzY485x0B9dWJnV3W0W
         TnQMulrN7yyZXGHFTiOyWDC1wY59f/tjlS5vjPAnXkbmCVxXIc2maTfx3FlJemGXPbEd
         oIhFRB2EHA0oTv8BIEwV/oq0Vp9kY4A8qUg2UpNdvj82VIuPM+pGvvRPDGd+iKkdN0iE
         fMhuNZyuRhr5wQD9uKjHTu0/dBcgt18B09bb5lO3wvYzPbjdtZ4zCb8IaUuWGDUTVpmZ
         9R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ilN6S2DYFu/DESx5TOWbGLPHlfDmzvINI2SI+/X/LA=;
        b=5ZfFRpnn9Eay7xwuP6gMu+s3NAAsN8lM5nYsZrS6M3Z+k9qGfFlmtzVOSecXs5kpHm
         4pDF7WpB/Pnf5ADu5LznRG7U7cYDh5roKMCl6b00sAGV0VLzoROddbfN2VwXtdhystFt
         PQwqE3kUCtn2LoV0Gw676JM/SKi/JO50qB//RE7pJmXTSmU/e9kxpGw15ROosz1EpoQr
         J8B0uyG5od6G6u8wMIgK1smVV/OTVMXbAYAVeXNsRya+X+k+EzZFXsxG2dxCeQUb8KyO
         c419wfdWhfy+DgD1qPtUV6SJ7tcp0L2AA5A/3I+Ty+jmrite5Y6xkSTm/6fHFNQfkxJn
         b0rQ==
X-Gm-Message-State: AO0yUKW1+W0Gi/vqzSD17cFIUGlgHEvIbnoyjyTi8KPi+IhO0U/FLkWl
        1j4qK4pg3cPiH7oA+UfeNbRvI2vlBfSe05CRqhM=
X-Google-Smtp-Source: AK7set8Ywx0iAQrGoEEkgv3qLgP8YXwI3+TvqWY8ReSLX18XMQnjssyGUpWN7izePXDq8V+lj0t2lykY83BEM5yxFts=
X-Received: by 2002:a05:6402:d59:b0:4a0:90da:4653 with SMTP id
 ec25-20020a0564020d5900b004a090da4653mr814683edb.153.1674664006555; Wed, 25
 Jan 2023 08:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20230124230048.371144-1-robh@kernel.org>
In-Reply-To: <20230124230048.371144-1-robh@kernel.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 25 Jan 2023 10:26:35 -0600
Message-ID: <CABb+yY3FwCwEsNYuNP8MBi+2TUra5O7+-GWMzWr06x1g4MJUyg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add missing (unevaluated|additional)Properties
 on child node schemas
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jan 24, 2023 at 5:00 PM Rob Herring <robh@kernel.org> wrote:
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
For the mailbox change,
   Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
