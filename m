Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A95139E3D
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 01:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgANAaQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 19:30:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41287 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgANAaQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 19:30:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so10865647otc.8
        for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2020 16:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z4zWbyVluCegWLV1bmjQGYNlUCTLZBFCektijqCqk8g=;
        b=JkujE3zQ2JakbM4ijNqFaVznqMjsQuQA0QVDSNDU9RBOVLtMoW4Qz1myNBan0zRH4D
         CIVkRSe4V/cuQJI7/3C9dLsuwS0+9QXdEox6iEKYBoUse+zVR4WTwnCqTf74HSUtuGhN
         8UVb6jRvcscs3vWxMC961+7L9ltB4dNxuThHLta3yPtNHqktFvj3ZIooGr8DT9nxy4Ej
         t6SXnVzoTH9sJQmBkxoRA95Ovex+SkGPAplwtwuALVBy33qGm06LzDCdnWkallES1d2A
         RqPhtESH/hDFSWoUIM5Oz6OFds30X3yi/Cxfv5z5vKE/ehwAAiwpJsVut1nQEpREMpa4
         pZvw==
X-Gm-Message-State: APjAAAUR5yef2gkDNZymFXvpZet2Wf3tBqGpZwGwY6Es3bHcgUZkL3qA
        FPh59YEryojDdglKGdjMJoDt9VJn9w==
X-Google-Smtp-Source: APXvYqyYhEeys+ilN8cwUipvPZWQ+QxGy5/LZ3yMwbAux6Chw3AszlyB3mvE4oR8Ew63Au99XQqHHA==
X-Received: by 2002:a9d:3b23:: with SMTP id z32mr14322509otb.159.1578961815540;
        Mon, 13 Jan 2020 16:30:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i12sm4769110otk.11.2020.01.13.16.30.15
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:30:15 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219d0
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:20:42 -0600
Date:   Mon, 13 Jan 2020 18:20:42 -0600
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
Subject: Re: [PATCH v2 11/17] dt-bindings: atmel-gpbr: add
 microchip,sam9x60-gpbr
Message-ID: <20200114002042.GA17036@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-12-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-12-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Jan 2020 18:18:03 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-gpbr to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-gpbr.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
