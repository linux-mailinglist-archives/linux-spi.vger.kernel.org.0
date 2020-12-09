Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFD52D4B8B
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 21:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbgLIUQW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 15:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388287AbgLIUQU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 15:16:20 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793F1C0613D6;
        Wed,  9 Dec 2020 12:15:40 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id r24so4865644lfm.8;
        Wed, 09 Dec 2020 12:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=29gZ51AkHeHCkCBWFFsi9l3IwIA6vH7qxHMCsXGWoI0=;
        b=bdM2JCllWcdfTu9dV/dczeEr2cO+tdrNi4Hxo3cI99rlZ3mxfb4yc4FQ4lpFJJKAan
         jfnWrJUgV7MgyhEfa2Twq7zGjbehVdekhkXeeoO6t/tbQ992RhF6Eq4qiqfXjSxfjuEW
         wsgpnPhwx30QVLLKklpcr+x8XnVnAXn+hzGQleARi8IKninKono1ji9hcVUzcC021A2d
         xnfrHpxmimMNYW7VEfpGeLWmuh5o5DJatorJbWcDGojJOy3M94DMcmb31oNcg/tIXbNj
         /C6aWTQPKjPQwrrgoHYMOHWDbpU4xRlSddyLykYCUd/Myg5e+SfOFOTB0toOU912f3e5
         rbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=29gZ51AkHeHCkCBWFFsi9l3IwIA6vH7qxHMCsXGWoI0=;
        b=VrSob6Jxpo3fm0LYlHJM5cNz4g8w+3a+9qs96BJkQnK8jBoCyBZusfm/ycjJKfE6Sc
         ROFK8f6EjBYqiuEptjWjrAk0TIbm2OpQhzSkSLV7lNfi92JSmz1xlFa7Ky7UXkO7DxUw
         SbNxZCxr5Z+fQNyQoeg/ln/ykvJYyTsv4XYfg9wd4Ms+vLVtpxJivhFtUE2r2DYGUweE
         4sLAw/OK83p+5TWbZuxtaQqzmh4XBiA9plBEapAMQSVPKqFruYv9eEBAZpaCSNCTN0dE
         u8sU9fceMt7Ba73z3/Za/VVE08H0xJIa7iTNUw8j9u+gHtvo1EYEoiPkz9fJ9p597Mkr
         vjow==
X-Gm-Message-State: AOAM530x1XdxI4ei4efkApPikLq8RdjGQv21XOwJe4kUUO22A2+PRpqi
        HDwChlikfbIFeJviMAMoLtU=
X-Google-Smtp-Source: ABdhPJzyUdycABRT6q1y12AqHQ1EOoHiKlplfWlMDq+dTWG+8zhZDCN5CnHtSbiwWHaPhugBgGZk0g==
X-Received: by 2002:ac2:5a0b:: with SMTP id q11mr1438133lfn.640.1607544938712;
        Wed, 09 Dec 2020 12:15:38 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id o21sm275096lfc.153.2020.12.09.12.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:15:37 -0800 (PST)
Date:   Wed, 9 Dec 2020 23:15:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Limit the spi device max speed to controller's max
 speed
Message-ID: <20201209201535.32g4kwpzo45jiqr3@mobilestation>
References: <20201209173514.93328-1-tudor.ambarus@microchip.com>
 <20201209194636.32f4ioxxdggezklr@mobilestation>
 <20201209195420.GD4790@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209195420.GD4790@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 09, 2020 at 07:54:20PM +0000, Mark Brown wrote:
> On Wed, Dec 09, 2020 at 10:46:36PM +0300, Serge Semin wrote:
> 
> > On Wed, Dec 09, 2020 at 07:35:14PM +0200, Tudor Ambarus wrote:
> 
> > > Make sure the max_speed_hz of spi_device does not override
> > > the max_speed_hz of controller.
> 
> > I have doubts that's right thing to do. It seems better to let
> > the controller driver to handle the speed clamping itself, while
> > to leave the SPI client device max_speed_hz field describing the
> > device speed capability. Moreover the SPI-transfers passed to the
> > controller will have a SPI-bus speed fixed in accordance with the
> > controller and client device capabilities anyway.
> > See the __spi_validate() method for details:
> > https://elixir.bootlin.com/linux/v5.10-rc7/source/drivers/spi/spi.c#L3570
> 

> Right, in general we aim to do this sort of fixup on the transfers
> and messages rather than the devices, I guess we might be missing
> validation in some of the flash acceleration paths or was this an issue
> seen through inspection?

In case of DW SPI driver we just make sure the SPI-client device
speed set in the max_speed_hz doesn't exceed the controller SPI-bus
clock frequency and clamp it if it does. So the driver is safe in that
matter.

-Sergey
