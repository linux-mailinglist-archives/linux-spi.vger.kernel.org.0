Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A9139D33
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 00:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgAMXXC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 18:23:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46865 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgAMXXB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jan 2020 18:23:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id r9so10705599otp.13
        for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2020 15:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F2iDZ52lWikDVmU5g/bwIONEfUCTF197jf9k+MTeRXI=;
        b=Mq3MCqIa0D266+QTgwPEeeCNW7nfH6/3YFip8OQvKLkSNrb89CXLnU2VXuQFsObt31
         TlrYdXT6YYCJQcd8EBjXKQOMT7XUtv0d92kE/875I5JP+J7qtPUtvlpj6LQoBene2dKP
         xQRg4ObJP0a/64gDC+nzbMg/9lfHZmqEoogRJpfScbkBA43VgdepNgkui6PFY6hdhjyu
         jWI48Pfav8Pw07YSTBcj11eXA+2n2JJ810YP6IYwzENORNQM17yEu8yolw0ipdv5TZGd
         Pwv77b1IQMoTseAvhCTydDUF3S6T9QH76wy4DjwD9UG2SsMHKP/bYUI7WRXV3qtTudiG
         mZ/g==
X-Gm-Message-State: APjAAAXlAujTbmVb7f8iOKblhx5COQ1YFmC1AM414UXZU6w2Z1aHt/Eh
        d+Q1bhH0eVi1e97WqSL2z3KRzVA=
X-Google-Smtp-Source: APXvYqzZrlZ6W8v2+xgk/Cwcn1Gpn0UrQsPjNPJKxe7u3BDZOUfkTQs38+p7DYgXQNKkDAzSpuiAug==
X-Received: by 2002:a9d:75c5:: with SMTP id c5mr14929387otl.172.1578957780869;
        Mon, 13 Jan 2020 15:23:00 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y196sm4026330oie.1.2020.01.13.15.22.58
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:22:58 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:22:57 -0600
Date:   Mon, 13 Jan 2020 17:22:57 -0600
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
Subject: Re: [PATCH v2 01/17] dt-bindings: at_xdmac: remove wildcard
Message-ID: <20200113232257.GA30124@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Jan 2020 18:17:53 +0200, Claudiu Beznea wrote:
> Remove wildcard and use the available compatible.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel-xdma.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
