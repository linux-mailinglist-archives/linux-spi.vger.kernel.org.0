Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250C94396CD
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 14:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhJYM4m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Oct 2021 08:56:42 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:35393 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhJYM4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 Oct 2021 08:56:41 -0400
Received: by mail-ot1-f51.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so14814831ott.2;
        Mon, 25 Oct 2021 05:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QEjs2AwnO2Ur5YJn6P5w/EnVp73YUTavMQU16y98cUk=;
        b=jOFw45N1wPafz/Dbq/cDudhloMElsxWN44hFudQ0Hc6c6kzXCcFxNH79WyU0W4pRYB
         aGXyIajL42KbozK6D7dhVPPFkuePNo8ewDpmpR9pIqnEuv9fnJ4OhTpfL2JqTNqkiLi6
         kVYS2cHqcUCHHP5ozRZFrXmWQjAhmxsY6TVRTFjdKBU6bx7s6Z+K4rV7kkWJx6ir2Y0x
         IinvCG2ztAGXQBzE+LkOrjpLmMDJsWF455DJcbjyePy3g4/lwm9Utw9SfjSUrPVYYNfj
         oJaB1mtUm2ynejq1oSsmPo87bS9UdF/uKgOogUU27E7fD+Zq+RYYyllZLsSXOZgkt31Y
         2cgQ==
X-Gm-Message-State: AOAM5335P7hwDJQIQXIrEmcmjTZbqLqcsF+i/PjvxUz2vEqH2loboU7m
        QqOofmuAQjg/rUCVIIZA8g==
X-Google-Smtp-Source: ABdhPJztdVgWQ1YHyEB7LVuV95ww9aPD+XrZT5nCV7Nt0zjUuuT0pJy9M/ipCL6XGEqils5z8U3nCA==
X-Received: by 2002:a05:6830:1c2e:: with SMTP id f14mr12867262ote.159.1635166458627;
        Mon, 25 Oct 2021 05:54:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e22sm3543127otp.0.2021.10.25.05.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 05:54:17 -0700 (PDT)
Received: (nullmailer pid 190978 invoked by uid 1000);
        Mon, 25 Oct 2021 12:54:14 -0000
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        fancer.lancer@gmail.com, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, bgolaszewski@baylibre.com, olof@lixom.net,
        ulf.hansson@linaro.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211025015156.33133-4-brad@pensando.io>
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-4-brad@pensando.io>
Subject: Re: [PATCH v3 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
Date:   Mon, 25 Oct 2021 07:54:14 -0500
Message-Id: <1635166454.830065.190977.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 24 Oct 2021 18:51:48 -0700, Brad Larson wrote:
> Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables resulting in an additional
> reg property resource.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml         | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1545481

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

