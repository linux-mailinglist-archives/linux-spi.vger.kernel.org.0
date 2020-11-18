Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E798F2B731F
	for <lists+linux-spi@lfdr.de>; Wed, 18 Nov 2020 01:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgKRAbn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 19:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgKRAbm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Nov 2020 19:31:42 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F30FC0613CF;
        Tue, 17 Nov 2020 16:31:42 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id k7so38690plk.3;
        Tue, 17 Nov 2020 16:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qdYVNJ2Aplo81w2amqUYCJ0n3ezHL6JKHaN7183HJoM=;
        b=JDto2PTsEojHnuZUskhed9LPRe+piZf5+EceHLO7hDEONxT9WoERu0/DoL9Zw2zcOA
         TEF4UAupgQXjNulBFDYenFpSVE6g7c8w2kqEwa1OYIr0ipaSLW/bGopCF66ABXwvdTcC
         MMYsKUnqiTvHB67oDhy6ZePbuU2CqFoGFY244kenJc8pHX5c3JPowsQ1uRVL8AjvSWYU
         lFKZHoy+weIpxH9pW0oiXIUUep4uXMxzokXnIT36toUKtmHTfrZpFMsPoP83WuwNCSBl
         k5wJPycMePfdUHNRaJTZ1Z7zeu1xvn3HI4dyYMkx0+msJJ6kQsdltic5dK3WDJv9pUBi
         daww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qdYVNJ2Aplo81w2amqUYCJ0n3ezHL6JKHaN7183HJoM=;
        b=m4piqVF5oOo0iEHf5vYpZLE98msivDDvRCZJyldOL867FPzjQFjAPQoH4chppCGkwB
         zb90tbC6dbviiXK7OJwTzw7oJzFUsh5CHPyZD1NSMIcOlu4tYfI2sNbghFWfuykE1Nqx
         vi2xM0TkxCcsoElAlhtER3+GF2IRVs021xa4BkamICYoJRD+t5/l1IcO+zTLt9PXA0KM
         k5lU2DBIglsvRHutdyWpv6FnpjP+jIfAdn7gPGebAhmryZOzZpg1hE5r5G1t45qblL8D
         RGMXTerhmKlcA4YND1j34usTE7m1rpJxLvghfTbm9atOcPuqzX8zKLpmhYt2MzvV6zdH
         IuXQ==
X-Gm-Message-State: AOAM530hNt0Rt0dCn5IcWJtkAbvxeK/dyJxnebmCvCOE8fRqu3e9+aOU
        ZuSVxJkPRrPb1pGM94RKB+8=
X-Google-Smtp-Source: ABdhPJxTvBqAAoOJERiOVF3DAqvxDBF2r854Xyfqa80CxSsRj3PGimAoxCTiRHMTqTO9IAV6S0q3mQ==
X-Received: by 2002:a17:902:468:b029:d5:ad3c:cf52 with SMTP id 95-20020a1709020468b02900d5ad3ccf52mr1702104ple.7.1605659501862;
        Tue, 17 Nov 2020 16:31:41 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id m23sm11133731pfo.136.2020.11.17.16.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 16:31:41 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:31:38 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 2/2] Input: ads7846: convert to one message
Message-ID: <20201118003138.GD2009714@dtor-ws>
References: <20201110085041.16303-1-o.rempel@pengutronix.de>
 <20201110085041.16303-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110085041.16303-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 10, 2020 at 09:50:41AM +0100, Oleksij Rempel wrote:
> Convert multiple full duplex transfers in to a single transfer to reduce
> CPU load.
> 
> Current driver version support following filtering modes:
> - ads7846_no_filter() - not filtered
> - ads7846_debounce_filter() - driver specific debounce filter
> - pdata->filter - platform specific debounce filter (do any platform
> 	provides such filter?)
> 
> Without filter this HW is not really usable, since the physic of
> resistive touchscreen can provide some bounce effects. With driver internal
> filter, we have constant amount of retries + debounce retries if some anomaly
> was detected.
> 
> High amount of tiny SPI transfers is the primer reason of high CPU load
> and interrupt frequency.
> 
> This patch create one SPI transfer with all fields and not optional retires. If
> bounce anomaly was detected, we will make more transfer if needed.
> 
> Without this patch, we will get about 10% CPU load on iMX6S on pen-down event.
> For example by holding stylus on the screen.
> 
> With this patch, depending in the amount of retries, the CPU load will
> be 1% with "ti,debounce-rep = <3>".
> 
> One buffer transfer allows us to use PIO FIFO or DMA engine, depending
> on the platform.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thank you.

-- 
Dmitry
