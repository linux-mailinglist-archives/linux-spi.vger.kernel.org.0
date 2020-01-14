Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4A9139EAB
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 02:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgANBAF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 20:00:05 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34445 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgANBAE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 20:00:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so10960412otf.1
        for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2020 17:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UiO2+Fp93HhiZmZTyPCKddyYzvj9rECWLiqMRlRa5BM=;
        b=g/mZLuDzxiKEo8DGZ1w5qcbRr//W4vgy4PF9zHXYR0kYGuWPDnerU5kZmIQ3av+FNL
         d9cXBzYx2Y6lYhj5xr4HPxegRvVgsQYG1ONtQkFeqORaYy9THgF1qdRHc1jrG0hL7LTW
         izYbDCpv2D3aR27lGUKIk133TTUEdr47tBX2Ha02tZukmEoTXQmENcn9rdnn+D4fDdoK
         8hS3gpSIcEscaoeacllT1iXFo+sglF1e5EbfxFyzfgRipQ//IVchKsXvtbbcR2rI/GNd
         8C9uF7L0UIDnOX3mp6gCzAPUarxRXLpbYAG57bJv0QUbwsodua6IXyydNzdrESsLq2Py
         HLbA==
X-Gm-Message-State: APjAAAVHg/YYYgAyYh734Hy6v1KMqJU//E1jODl2po67UO96Gm7CC7fx
        IuFMXLc84RaFb17kFi/inCeGleEElQ==
X-Google-Smtp-Source: APXvYqwoK8CneFNglZQ+s1yuc2+ABP7ma52gBvKHLmlYfnkprL2bRFQtbuXPKRhPs6FFdQM92/PJbA==
X-Received: by 2002:a9d:2028:: with SMTP id n37mr15746140ota.127.1578963604080;
        Mon, 13 Jan 2020 17:00:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 67sm4112621oid.30.2020.01.13.17.00.03
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 17:00:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:18:03 -0600
Date:   Mon, 13 Jan 2020 18:18:03 -0600
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
Subject: Re: [PATCH v2 10/17] dt-bindings: atmel-smc: add
 microchip,sam9x60-smc
Message-ID: <20200114001803.GA13249@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-11-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-11-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Jan 2020 18:18:02 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-smc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-smc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
