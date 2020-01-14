Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFE139E4E
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 01:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgANAdf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 19:33:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43654 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgANAdf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 19:33:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so10853600oth.10
        for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2020 16:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXJN2b85yGTyfLCLDYBimi22Hg8WM/nHD10wRzYfTm4=;
        b=CgolyJL0vjHPP0ETgNnvGgsomZQ2CU+dt1+otcX4bZOfKG5oQCdrLnSIUO4+b1mbqp
         UtRoZVnM3Y8CPdEKun0k4/ONZCRCwR7hJ6E5teVLroUKe4FxtKKyPWHNkBkiLj7N7W1c
         yjY4EWcfVjphPhBoX107PMvwSbAkfAaRtGYgZJ+fAXp9kgfR0hPll0hTOPovbyIrH1Zr
         001aDv59gy4+CrkiNidIIIJHhlAT+JF4r9s2GfDNpva5pbwskXcSwLaUM0QSZxgJ5QCn
         sH6HDXoODjVwnobGqdFAhiiHM/pyE33rjOt5nFD9iWhAkOtxRTsTZg5ZndqzzEQ41YRc
         TqQQ==
X-Gm-Message-State: APjAAAWVqjWd2Wp/q1yr4PmN9LCWwZX3utWMZDMayXaiz0QqF8qmLBUE
        ictRM0OxaI/gBgy1YhBUFw3YwNUn/Q==
X-Google-Smtp-Source: APXvYqxj2CjW199ZDiOG4aXo19/v3ugjUodhR3o8dP7lIU5zryu3cCigexpy6lsBE9WnAljk6QqurA==
X-Received: by 2002:a05:6830:20d3:: with SMTP id z19mr13854057otq.330.1578962014421;
        Mon, 13 Jan 2020 16:33:34 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j20sm4757091otp.24.2020.01.13.16.33.32
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:33:33 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:33:32 -0600
Date:   Mon, 13 Jan 2020 18:33:32 -0600
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
Subject: Re: [PATCH v2 15/17] dt-bindings: arm: add sam9x60-ek board
Message-ID: <20200114003332.GA3401@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-16-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-16-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Jan 2020 18:18:07 +0200, Claudiu Beznea wrote:
> Add documentation for SAM9X60-EK board.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
