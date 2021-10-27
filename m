Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA96A43D5EC
	for <lists+linux-spi@lfdr.de>; Wed, 27 Oct 2021 23:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhJ0VlF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Oct 2021 17:41:05 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41482 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhJ0Vk7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Oct 2021 17:40:59 -0400
Received: by mail-oi1-f175.google.com with SMTP id y128so5388786oie.8;
        Wed, 27 Oct 2021 14:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HUJoxRyEwnAT1/jR2hsyOAUrYJR51Yh2zZgiV0a6rxM=;
        b=TTPQrEtWhvcd0SCi4gPI0FKU+8Oz0hqIfjmt/XJsQlURv2Zt2aeUjFXD4+Z8tyFtT+
         xdY46fxR2lUa/t68b8/uzthVXwQB0pF+mA6k/aAgYXvdHSXqyyK7fCyMDuH43tPkN4lY
         aUzhk8qmdR8rxP3AYPzFvi2WdoEYNsDKo+lPx7IOl2TZxRSbZg4B0fjlDF5EqUPseRc+
         yfn2Qv4SVafs8S76zMrWpBvwdIpUM9dOeUQAezJG106Uenru6ryN52fSs6Fov4eTpanC
         NS++GKac1ElJs/0wRXNP7JrbdXp2/NV5V4uHlmWfxp5Jy0Cbb59CjnSlVVfZCrm5DUi1
         LPuA==
X-Gm-Message-State: AOAM530qr4mXJJ5lmeUe5NT1Xga/NoEd1U0hnSCOCDldpzRkgfB10UDr
        NTLOuQNR5zs13h1RI0dmww==
X-Google-Smtp-Source: ABdhPJywHeBN/2tekiqyCn9hqnbJ75XgYR/HZrJGOxXEkjwSRAly0eC1iT8Tn+DRLFoj+J30Ogd8EA==
X-Received: by 2002:aca:c086:: with SMTP id q128mr5695693oif.40.1635370712834;
        Wed, 27 Oct 2021 14:38:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 70sm407237otn.74.2021.10.27.14.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:38:32 -0700 (PDT)
Received: (nullmailer pid 2213501 invoked by uid 1000);
        Wed, 27 Oct 2021 21:38:31 -0000
Date:   Wed, 27 Oct 2021 16:38:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/11] dt-bindings: Add vendor prefix for Pensando
 Systems
Message-ID: <YXnG10suyQYqYv5T@robh.at.kernel.org>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-3-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025015156.33133-3-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Oct 24, 2021 at 06:51:47PM -0700, Brad Larson wrote:
> Add vendor prefix for Pensando Systems: https://pensando.io

This should be before patch 1.

> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
