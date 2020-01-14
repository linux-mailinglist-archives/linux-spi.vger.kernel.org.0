Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6884E13B5C3
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 00:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgANX1C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 18:27:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35992 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgANX1C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 18:27:02 -0500
Received: by mail-ot1-f65.google.com with SMTP id m2so9570669otq.3
        for <linux-spi@vger.kernel.org>; Tue, 14 Jan 2020 15:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ttZMLAqDhxSTsHlfd8sLeyc9soxLzGATxjf7nZzKPPw=;
        b=G+kIFIWGhWmVSqRI3p19g4jhEM53GhaSu87oyD7LLn9n44ztNdzNAS+tJvrJbwucn3
         PvEK67S2G4K6z/GeuXT4phiR3GxDZPhdi6kKhkH2fgDK5VQ3ALW5cgaQ4Hnk8iJx1eWh
         deHV6j0kkwFjSI4m9SJX0r+2NX0p42qDLZPRJh0dePGBxTEZV1DwZuTUe+b/5AnW8CKb
         3xyLnTlzfLgGQs+dEWq5TcEh/wUsQ/xktm+t65MDKvl2iJuIgs/YKD9KbAw7xX5VJsgI
         gZjlB3DSgnsQ8XMx+4/z8E50Xkj918+OdKWymoEqM82G3ah9C1lokT4oYVXAI2p12mMj
         86Yw==
X-Gm-Message-State: APjAAAW3BiyW8Ym6TmU4xTTWml4F0fSKMzrsImr24ltYAbTl52OUTCSm
        HijYDcc1dgnVUKWnATXp7jBDX/M=
X-Google-Smtp-Source: APXvYqx+H6LZIzAsxLSbvD6H0a5VgaYBa/QfYro/v7cTDVgm1ANeFgJ3HKH6W36QnyoDeSmuruDcsQ==
X-Received: by 2002:a05:6830:194:: with SMTP id q20mr702341ota.92.1579044421262;
        Tue, 14 Jan 2020 15:27:01 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q13sm5896242otc.5.2020.01.14.15.27.00
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:27:00 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221a3a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 17:26:59 -0600
Date:   Tue, 14 Jan 2020 17:26:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: atmel-tcb: add microchip,sam9x60-tcb
Message-ID: <20200114232659.GA16642@bogus>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578997397-23165-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 14 Jan 2020 12:23:12 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-tcb to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-tcb.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
