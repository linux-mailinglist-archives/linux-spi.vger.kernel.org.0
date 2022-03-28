Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D804E9F55
	for <lists+linux-spi@lfdr.de>; Mon, 28 Mar 2022 21:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbiC1TDK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Mar 2022 15:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245404AbiC1TCt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Mar 2022 15:02:49 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B14B847
        for <linux-spi@vger.kernel.org>; Mon, 28 Mar 2022 12:01:08 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id gi14so12641243qvb.0
        for <linux-spi@vger.kernel.org>; Mon, 28 Mar 2022 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FYymUjBWxv8swP0pijWEBFK2FMnunv9Q5Y+SxWDGhW4=;
        b=g/vTz8d/Y7hYUUIXVnRKhg/Cfxdflp3msTFYwDm1KrmE71sSmZXgV7LebC5QfEakrn
         zPXW/mtcfvB7etWTTI0aBQI5/QoeDlAzysqA8wG/9sGwnEeSu4Pg+iA6OBZ4kmbgl2GN
         /pnj4/n2ax8wJaHyPTCuyKJGkrTqYQkihJbV9N7f9y655jXHdb9gOutBDZTaKfQVRqvH
         NgdbHnIjZY0WrsMvqq7c+AcOH1zDUX9Gb8qamhRyZcYnzusqG/JANNz9FYl7fNlesMKV
         16eD5gCw/lFJVCoROYdOaezSqf8kaDHWcglaFyZMarvmXnUKAv6Yxkj6bgxWShxgIfzJ
         e5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FYymUjBWxv8swP0pijWEBFK2FMnunv9Q5Y+SxWDGhW4=;
        b=1KsAy6Zy/yc99roUEHZdkf8ELMN+xs/irVJtdaD7Wu34cY1DNuuBzY3Mn7ZDJvWyJw
         PUUYTrKjXWnx4CpQ/3STIFXeFhvpfvebo6IjLzF6/m9a62r9ghBEfCVv9zwKmeUjGqiu
         hAJeQ0aO4KvWydegzYQjP07wKRqS04sZRZ+4o2101NQGixylSKmAPUmOnVxjgKfOPyC6
         42chIM9DjzGUJZmKS3p0qNiIZdflwwKbJ/t4VC3Zc/Hfn40V2RAPU0VEc7GOgvrICqF6
         gvRO7hngqC6dPCMyyfa+GU+zdzEL0ZsYdLYvsvDGRYEHcwYk/oCptB6B/YxuPpSFHAAq
         HwoQ==
X-Gm-Message-State: AOAM531vJ5tgmyb+Pn3A3G/+lygwaAM8/AEpQ/2sBdaLZDtgj23UXKlk
        02x8hbg9qmanuOWIZ8n6TlwojGXKJYk=
X-Google-Smtp-Source: ABdhPJwBJZE2aSxifyljIwQb3RAtBh3pRsQhQoX9Cbw02rclfTH6iWDG5huoCWD2vTHnmlY1bHBM/g==
X-Received: by 2002:a05:6214:23c6:b0:433:8a2:c244 with SMTP id hr6-20020a05621423c600b0043308a2c244mr22419065qvb.88.1648494066822;
        Mon, 28 Mar 2022 12:01:06 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id b21-20020a05620a04f500b0067b4895472esm8375977qkh.5.2022.03.28.12.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 12:01:06 -0700 (PDT)
Date:   Mon, 28 Mar 2022 15:01:04 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     linus.walleij@linaro.org, vz@mleia.com,
        alexandre.belloni@bootlin.com
Subject: spi-pl022 on lpc32xx
Message-ID: <20220328190104.GA11946@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

I have a spi-nor chip (m25p16) connected to the SPI1 bus of an LPC32xx-based
machine that I can't get working.

The LPC32xx has both an SPI controller and an SSP controller, but only one can
be active at a time. The SSP is an ARM primecell component which is a "SPI on
steroids" device. The SSP can be run in several modes, one of which is "SPI"
mode.

The LPC32xx machine does not have a SPI driver in the kernel, but it does have
a driver for the SSP controller. Since there is no SPI driver, I'm using the
SSP driver in "SPI" mode, but not having much luck.

I can see the SPI subsystem sending the 0x9f command (READ ID), the spi-pl022
driver writes the command to the SSP data register, but the flag in the SSP
status register to say data has been received never goes up.

I'm wondering if anyone is successfully using the current spi-pl022 driver to
interact with an SPI device (preferably on a lpc32xx-based machine)?

I've spent the better part of the last week poking at this. I've tried many
combinations of device tree, but what I think should work is:

	&ssp0 {
		status = "okay";
		num-cs = <1>;
		cs-gpios = <&gpio 3 4 1>;

		m25p16@0 {
			compatible = "jedec,spi-nor";
			reg = <0>;
			spi-max-frequency = <500000>;

			pl022,interface = <0>;
			pl022,com-mode = <1>;
		};
	};

I've tried a couple other compatible strings ("micron,m25p16", "st,m25p16"),
I've tried a range of frequencies (from 0.5MHz to 33MHz). The 3 options for
interface are 0 (SPI), 1 (TI), or 2 (Microwire) and I've tried all of them. I
don't believe the DMA system works generically on the lpc32xx but I've tried
both interrupt <0> and polling <1> for the com-mode. I believe SPI1 and SSP0
are the same and SPI2 and SSP1 are the same (which is why I'm using SSP0
here).

The pl-022 driver is quite aggressive about shutting off the SSP and raising
the chip select after a message is sent, so I modified my driver to leave the
SSP enabled and keeping the (active-low) chip select low (in case those were
affecting the reply) but there's no change.

One thing that's curious is that the platform_info->bus_id is -1. This bus
number comes from the parent device (spi core). I wonder if this driver is not
registering itself correctly with the spi core?

Best regards,
 	Trevor
