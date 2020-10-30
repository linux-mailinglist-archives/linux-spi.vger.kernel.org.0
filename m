Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1492A078D
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 15:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgJ3OMN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 10:12:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43114 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgJ3OMN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Oct 2020 10:12:13 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kYV8U-0006ee-Tl; Fri, 30 Oct 2020 14:12:10 +0000
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: spi: bcm2835: fix gpio cs level inversion
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-spi@vger.kernel.org,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <ad239665-e342-cdef-71c0-4eba06b76797@canonical.com>
Date:   Fri, 30 Oct 2020 14:12:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

Static analysis with coverity on today's linux-next has detected a
potential issue in  bcm2835_spi_setup() in the following commit:

commit 5e31ba0c0543a04483b53151eb5b7413efece94c
Author: Martin Hundebøll <martin@geanix.com>
Date:   Wed Oct 14 11:02:30 2020 +0200

    spi: bcm2835: fix gpio cs level inversion

The analysis is as follows:

1191 static int bcm2835_spi_setup(struct spi_device *spi)
1192 {
1193        struct spi_controller *ctlr = spi->controller;
1194        struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
1195        struct gpio_chip *chip;

1. var_decl: Declaring variable lflags without initializer.

... and later on ...

Uninitialized scalar variable (UNINIT)

9. uninit_use_in_call: Using uninitialized value lflags when calling
gpiochip_request_own_desc. [show details]

1262        spi->cs_gpiod = gpiochip_request_own_desc(chip, 8 -
spi->chip_select,
1263                                                  DRV_NAME,
1264                                                  lflags,
1265                                                  GPIOD_OUT_LOW);


The call to gpiochip_request_own_desc passes the uninitalized lflags
down to  gpiod_configure_flags:

int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
3698                unsigned long lflags, enum gpiod_flags dflags)
3699{
3700        int ret;
3701
3702        if (lflags & GPIO_ACTIVE_LOW)
3703                set_bit(FLAG_ACTIVE_LOW, &desc->flags);
3704
3705        if (lflags & GPIO_OPEN_DRAIN)
3706                set_bit(FLAG_OPEN_DRAIN, &desc->flags);

so this looks like lflags needs to be initialized with something
legitimate, probably zero?

Colin
