Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83EF139DE1
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 01:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgANAQb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 19:16:31 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38930 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbgANAQb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 19:16:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so10844613oty.6
        for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2020 16:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E6IJAm/G2BZsEtWssBpYlld99L9pgrhy2OUvTYO1Gu4=;
        b=L/tCSJfKgXRtfFYPfXEAifjnzuQFN36mid7Iy9I7wtC/9gzGeptDdZvyHIYwfxdN8u
         qb1mdV3DMoktbOl6Lf3D3HnreeSo4kIHJCC/8vx0kXbcu/9Tj3cVvzQ5vwq3agGl3bWv
         xphk7aDaznZK5zT6nsBODX4T1xV/Jm2n7rVzCwOXzFlhPJeQWZp5fDPKIJKhQGC42THP
         uFuAZ2oYBxfOf/jyRp+8+JC+tr7mr18IiUDD7FjaN+nUeDDQ5eoGsXFxJqX7UYeDH2dp
         lVnkZ4NMPSPMn6ZqjhnGgNYGJIX3tc6KVdfH5FwuZR+usIMvzSR7JU5621nhEPra8HlP
         8s9g==
X-Gm-Message-State: APjAAAWsWomvUP84Vs+KFh8t5991uBuBYW1u299coVdtIHnP4CmzDsT6
        ta2tBocnXylxQZJnMM6vnEo/JETWJg==
X-Google-Smtp-Source: APXvYqyqAQCTqRTj1rS+GfZfnAdYzaKjQpbfyIixeOpwZzR3sTZrutoWIs9jK6vdc52USQeqgPSqtA==
X-Received: by 2002:a9d:6d10:: with SMTP id o16mr15440621otp.28.1578960989946;
        Mon, 13 Jan 2020 16:16:29 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y196sm4070002oie.1.2020.01.13.16.16.28
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:16:29 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:16:27 -0600
Date:   Mon, 13 Jan 2020 18:16:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 06/17] dt-bindings: at91-sama5d2_adc: add
 microchip,sam9x60-adc
Message-ID: <20200114001627.GA10411@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-7-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-7-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Jan 2020 18:17:58 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-adc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
