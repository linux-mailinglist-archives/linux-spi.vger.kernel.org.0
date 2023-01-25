Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C1467B4A2
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jan 2023 15:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjAYOfm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Jan 2023 09:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbjAYOfg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Jan 2023 09:35:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4095B5927C;
        Wed, 25 Jan 2023 06:35:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5DDAB819FC;
        Wed, 25 Jan 2023 14:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17329C4339C;
        Wed, 25 Jan 2023 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674657305;
        bh=DwE0aciCS7m1CLloDdEbT7AoS3V1fBrqXEptGTtb0rM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Affl/NlCjExKztE4qzigDJQkInvfvtCIrYxIvlFxplAQlFKKBKPjPicyergcu0VEs
         mnldq2oV5JNcE2Q7uuFLlFFERUT6cYcWS0cyde5uyy2oTCzp/RaPABF65YcrGxK61o
         PknfYSDA12Xv0MtPGnatIXO/wxd3AjIIhGAS5G1o=
Date:   Wed, 25 Jan 2023 15:35:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Add missing
 (unevaluated|additional)Properties on child node schemas
Message-ID: <Y9E+FjXnZiizTLc6@kroah.com>
References: <20230124230048.371144-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124230048.371144-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jan 24, 2023 at 05:00:48PM -0600, Rob Herring wrote:
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
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: David Airlie <airlied@gmail.com>
> To: Daniel Vetter <daniel@ffwll.ch>
> To: Bartosz Golaszewski <brgl@bgdev.pl>
> To: Jean Delvare <jdelvare@suse.com>
> To: Guenter Roeck <linux@roeck-us.net>
> To: Thomas Gleixner <tglx@linutronix.de>
> To: Marc Zyngier <maz@kernel.org>
> To: Jassi Brar <jassisinghbrar@gmail.com>
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> To: Lee Jones <lee@kernel.org>
> To: Ulf Hansson <ulf.hansson@linaro.org>
> To: Richard Weinberger <richard@nod.at>
> To: Vignesh Raghavendra <vigneshr@ti.com>
> To: Sebastian Reichel <sre@kernel.org>
> To: Mark Brown <broonie@kernel.org>
> To: "Rafael J. Wysocki" <rafael@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@linaro.org>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: openbmc@lists.ozlabs.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-spi@vger.kernel.org
> Cc: linux-usb@vger.kernel.org

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
