Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7199528ECDE
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 07:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgJOFxj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Oct 2020 01:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgJOFxj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Oct 2020 01:53:39 -0400
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Oct 2020 22:53:39 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189FC061755
        for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2020 22:53:39 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7768E100FC137;
        Thu, 15 Oct 2020 07:44:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 405311D5BAF; Thu, 15 Oct 2020 07:44:23 +0200 (CEST)
Date:   Thu, 15 Oct 2020 07:44:23 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Daniel Mack <daniel@zonque.org>, kernel@pengutronix.de
Subject: Re: [PATCH 0/6] Fix use-after-free in SPI drivers
Message-ID: <20201015054423.GA21422@wunner.de>
References: <20200922093228.24917-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922093228.24917-1-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 22, 2020 at 11:32:22AM +0200, Sascha Hauer wrote:
>   spi: bcm2835: Use devm_spi_register_controller()
>   spi: dw: Use devm_spi_register_controller()
>   spi: pxa2xx: Use devm_spi_register_controller()

Sorry but NAK at least for these three patches as they re-introduce
the issue fixed by 9dd277ff92d0, 32e5b57232c0, ca8b19d61e3f.

The use-after-free is real but it needs to be addressed differently.
Let's continue the discussion in this thread:

https://lore.kernel.org/linux-spi/20201015053829.GA2461@wunner.de/

Thanks,

Lukas
