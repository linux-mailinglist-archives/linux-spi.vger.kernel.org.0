Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7997139D7B
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 00:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgAMXki (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 18:40:38 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45669 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgAMXkg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 18:40:36 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so10056557oie.12
        for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2020 15:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hWr5fTf0UvM/FdokqnbY78OahK5vgKtckbIjPFsKcM=;
        b=VzlA3HUDi5hZyAoM85/In8mgYvHu0JWy0iOj6SszJ8jnJ5wxR2g7ojbB4UaicpF060
         9NdNKvSQRSHlfokxHln31s7C7VXGBZvGUtsLBo7VYr/zMbUB5geldrFdDeQRuC58jeMl
         Rrv1cyHbnGqzSPZ2EAUcYqrN52AAXEZlonBX0HodunIBShFQ12YdyZ4QoKZaUQxIJ3dc
         X7bffyvbk73xDW+4/FM/VcvGukCH3zRNyzCBkJ29kiI/ECsgptWToDed6T0HNUbZgPea
         IsHBTY1DHi3u0M4qkJWweueU+4ztzKGwpa1096qQtfs56UMQz8QKUKZ1sJ/PxmkvGs54
         lwFw==
X-Gm-Message-State: APjAAAWSobPMMZSvb4Ruw9vINnCjQ3pcy7boEiYkD6a89YCZgP17Z0Fy
        pfkAhEB9tXV/Xy3ELto2hopuhvBLug==
X-Google-Smtp-Source: APXvYqzL3e1l2zp5Ci9ooJkUhK1qwB4icL2XpqlpR/4Ya3K5oSUohBIGRNyFWwLZ1x3rIoOHt33NzQ==
X-Received: by 2002:aca:4442:: with SMTP id r63mr15312071oia.33.1578958835660;
        Mon, 13 Jan 2020 15:40:35 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p83sm4028302oia.51.2020.01.13.15.40.34
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:40:34 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 223f23
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:25:51 -0600
Date:   Mon, 13 Jan 2020 17:25:51 -0600
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
Subject: Re: [PATCH v2 05/17] dt-bindings: atmel-isi: add
 microchip,sam9x60-isi
Message-ID: <20200113232550.GA2344@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Jan 2020 18:17:57 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-isi to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/media/atmel-isi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
