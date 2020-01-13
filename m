Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3D139D99
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 00:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAMXog (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 18:44:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41678 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgAMXof (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 18:44:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so10767820otc.8
        for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2020 15:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyL/JS9B7rUgj8Iql4HM1FyxI7CsxZnIzSDjO8scpzY=;
        b=FXvsW3mTyAntuiV3phNnMueHUE/lKO+lO0VgC1gtsEHB/TsijzDr/QxhW5E2EtBtMh
         opst0Fm5vZ0lM7E6a2mWNeW2qj8eRdSeLAXA+uCaELJoWtVbfvIaUbkAAPAKU0ZvtOub
         zZKw6TYKh4wYIGpjgCNlcVOqy4FRRKUjdoP8zgvXjBVVPhkC3CLN7TmeV4NPLebnOjsh
         IpFdzMswHzBNGvBeEwEkc2Vj6dkofJiQGFc4QdfP+/1l5QAyOxno9bI4sFlZVVu1jxC1
         xtAuaBuuFnwE4ATijmO+PtXjoMr2N/hjoEBACWDPT+HdOaJ+NM9nQkhcMtme/6lU5Nf+
         Qk2g==
X-Gm-Message-State: APjAAAWk5nq2N1yC9J/qDurlsa0W5sztVHIf1O3785k9L2lTgYQNxsT6
        Cps0xOpkAKmV1F75c+z8joafGedAUw==
X-Google-Smtp-Source: APXvYqwgcJHcsYhOh9MvGWnM2bv6P9zS5LcgUVRjnslr/4Nm+7bc++y5olTrQAeqbh0K7uSS6MgdFQ==
X-Received: by 2002:a05:6830:1d4c:: with SMTP id p12mr15357475oth.198.1578959074756;
        Mon, 13 Jan 2020 15:44:34 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i3sm4709239otr.31.2020.01.13.15.44.33
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:44:34 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221a32
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:23:23 -0600
Date:   Mon, 13 Jan 2020 17:23:23 -0600
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
Subject: Re: [PATCH v2 03/17] dt-bindings: atmel-can: add
 microchip,sam9x60-can
Message-ID: <20200113232323.GA31125@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Jan 2020 18:17:55 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-can to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/can/atmel-can.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
