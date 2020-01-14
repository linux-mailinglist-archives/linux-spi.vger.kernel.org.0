Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92EB213B5BF
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 00:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgANX0w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 18:26:52 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33147 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgANX0w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 18:26:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so14453642otp.0
        for <linux-spi@vger.kernel.org>; Tue, 14 Jan 2020 15:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OD3k/3afce55aKrw/+Sox/ckv7HTxlsRWXlz74Axqv4=;
        b=JviTAVYQXpmumON0QoNZXUBAUONUZ/CkIWpz7CO2Cp69RiY4GrAAQZQQSncWkIBEOo
         SkFZ9r/PMMNx8y7om1qPaXaigS22BKU9i1AT0GhUIhHtOjnZUJhRK39Gw8rGcTWHsRtq
         Yh0MyK4W7FB2XyxQjD8kkkzDAu5p7LryEbsRbYFtl0T7MXPb/axeum+prkcjIsfTPTFH
         esph/IIVuNG7a7mT3nPyvesdQCU5/SXn75O9n/hpqXqO+8IklIBvWKCORCvpQ2ubRJHb
         xdPJyDknp0YzlTAtGQDsSbkaM+vWF1uCLH+INV2pAqFZ+O/TXci28rXPRRaRVZb9xBA+
         WIzA==
X-Gm-Message-State: APjAAAX0RiTYf8I0JN/m2kHglrjeSWcoEbsDbDIdNxdYcytJmcU5PRSy
        LSP+hHV93AWtrlRTbWU+q94FhHg=
X-Google-Smtp-Source: APXvYqwN/KIJ38oddjwbMxp0obhA0fswkkQBN/sbNJKtLoNbfxL2XEjMfszGdi11/URGWpoZPN8O+A==
X-Received: by 2002:a05:6830:1251:: with SMTP id s17mr669955otp.108.1579044411247;
        Tue, 14 Jan 2020 15:26:51 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w6sm5029457oih.19.2020.01.14.15.26.49
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:26:50 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2209ae
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 17:26:49 -0600
Date:   Tue, 14 Jan 2020 17:26:49 -0600
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
Subject: Re: [PATCH v3 1/7] dt-bindings: atmel-tcb: remove wildcard
Message-ID: <20200114232648.GA16276@bogus>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578997397-23165-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 14 Jan 2020 12:23:11 +0200, Claudiu Beznea wrote:
> Remove wildcard and use the available compatibles.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-tcb.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
