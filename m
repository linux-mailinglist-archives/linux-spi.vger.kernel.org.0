Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146CE43D5EF
	for <lists+linux-spi@lfdr.de>; Wed, 27 Oct 2021 23:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhJ0VlY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Oct 2021 17:41:24 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41830 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhJ0VlU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Oct 2021 17:41:20 -0400
Received: by mail-ot1-f45.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so5623976ote.8;
        Wed, 27 Oct 2021 14:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qN2OWQfIBen89F+CnV+7pDb+bvP855OIMnE0g4TXizs=;
        b=ZqykvfJBJi4JaJnkaoUcI2fz3a1f42c7D36Jr/EVeJdAXwtHCSTVznAr11vF8YNc+8
         LS80aS+ivNVdqDmjwsXYout4E8QzqXbvjKqnPJc+nBLU2Z2ahmsg4km9c+x6HbZ5kRUF
         9OSTXjdjEZXM6SQLTARwwYUYz3zxHZDU1Wqg5Qz1e0Rx6lmaKRRBnhYMg18+FDmk3738
         oWH8pi4293FBjM4Yg6PuvYoKPvr3rtIIyOHXfEA/i8klAY6NR8oRnoTFIjCj+YcXPC5y
         NPHIQ/aMF1XRJEF1MGIOu7rYHTXUFz4XfmZ7a3gchUHFaTZxtTWbXopz7+jMH8nPln+4
         tcmw==
X-Gm-Message-State: AOAM530KWZcvE6CDe0osb29mE+t0PMDAMNWwc2KnewNNXZRXeAyv+uRk
        I5LDe7KlbEng5Ge5SklmQA==
X-Google-Smtp-Source: ABdhPJydGeHd2y2IvDdgo0xQfX2260VtNIEprcWKD/u+TjseM65iZjDxyVJX6pGQp0xTzO/8X8iMPQ==
X-Received: by 2002:a05:6830:232b:: with SMTP id q11mr262189otg.164.1635370733859;
        Wed, 27 Oct 2021 14:38:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bb39sm387159oib.28.2021.10.27.14.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:38:53 -0700 (PDT)
Received: (nullmailer pid 2214117 invoked by uid 1000);
        Wed, 27 Oct 2021 21:38:52 -0000
Date:   Wed, 27 Oct 2021 16:38:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linus.walleij@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        adrian.hunter@intel.com, olof@lixom.net, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, fancer.lancer@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v3 04/11] dt-bindings: spi: Add compatible for Pensando
 Elba SoC
Message-ID: <YXnG7JdaaSWIHq4c@robh.at.kernel.org>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-5-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025015156.33133-5-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 24 Oct 2021 18:51:49 -0700, Brad Larson wrote:
> Document the cadence qspi controller compatible for Pensando Elba SoC
> boards.  The Elba qspi fifo size is 1024.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
