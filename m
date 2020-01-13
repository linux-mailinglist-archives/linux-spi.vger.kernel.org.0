Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF157139D37
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 00:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgAMXXN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 18:23:13 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43897 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgAMXXN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 18:23:13 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so10697604oth.10
        for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2020 15:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7d1TijNzzm5olBqQ6BOPTTjVLO96fK38vWoVBLQU76w=;
        b=WQnmktMXTVb+kHerYU3SWAztCA3+LiMxMClc4RvnI7TkHWUQv0LYdz8LBWhUbuDGui
         shBro7ec9oxNumhlapJtYqUzy1XYAGfrhfELR1QoCPiJX+RNLOCpuGnBFzwzNX92t/5a
         uDb+6DYcxyW0D5/7aYdegw4lJCnd9dPgk5+FaJijNnq6Tx8hYbwRyBzpDIXNFC/Nxnbq
         1Pc17Btk3jUh7QeEEGwRpkjBvH5Pbxu72LDbcPciL+zaE0VeHQTZJraWoCtY+t65ZMIq
         XBkHj2ok8S4DJsxxGSGi7kPS/WKPbFbeLR18eNxc60brg3hqKX3/JYXoSAN8q2uXlIXc
         Kfkw==
X-Gm-Message-State: APjAAAVdbfdJpyRQx2i/udUJRzT3/JosWJVNgVrGEn0GkPF2RmHMK6wE
        M/FLHbC2uewTwGprBQmUhu5ACfypcw==
X-Google-Smtp-Source: APXvYqyZATy+DJBG0j5UmvN8ag6qU/L/ConZMkNWHfPV18q2opDim8u6pIpkstAZCJd6/i7IV2FJzA==
X-Received: by 2002:a05:6830:110a:: with SMTP id w10mr15229325otq.300.1578957792381;
        Mon, 13 Jan 2020 15:23:12 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c10sm4656372otl.77.2020.01.13.15.23.11
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:23:11 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d0
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:23:10 -0600
Date:   Mon, 13 Jan 2020 17:23:10 -0600
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
Subject: Re: [PATCH v2 02/17] dt-bindings: at_xdmac: add microchip,sam9x60-dma
Message-ID: <20200113232310.GA30698@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Jan 2020 18:17:54 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-dma to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel-xdma.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
