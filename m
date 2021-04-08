Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97232357FB6
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 11:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhDHJqD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 05:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhDHJqD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Apr 2021 05:46:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C588BC061761
        for <linux-spi@vger.kernel.org>; Thu,  8 Apr 2021 02:45:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a7so1969833eju.1
        for <linux-spi@vger.kernel.org>; Thu, 08 Apr 2021 02:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=LB/KmcYLjZI/oCsVp6U+bzgnGB9mkbdvneRbUEvlMZ8=;
        b=a0dZv/+mmNPBMXkmtFv0vLM+bX1fDbelRyMg2yllEjuCCgLHXJwagSdZ5UHVTNZiAZ
         Oauqtjp/Dis+/66ASg7dKycF/2g2WaMuBtc4gfNI/1YzYkTaxrzdtu+H0MI3IYWDsSEl
         dRmte7a066M3R2amHhNtdwMmFC7iGFS3tIBxJ31YgFxHArikHRmJY5XrZ4+QzUarm2TJ
         TqTinRy8BqBi6x9i/150CWnc623YnJjWs+dQtqWhfZPN3xb2Jg5QpFAoyC2mfGr8cDz2
         EqlZ+Duqzo1PvGU8f/OZ3JYwQqDAHaFBNmo45H9nYyPqFn2cQ951PD9oEiXzRufOz78a
         LJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LB/KmcYLjZI/oCsVp6U+bzgnGB9mkbdvneRbUEvlMZ8=;
        b=Spb1acWZjj3QmxFy79SZOAuIf9fiF1GrANMi6SfnP/XcBa66MQ1GO75AbxeOTpv8bn
         L5pKztZnF10TDHULnFAxhe7GryxRHFTKAxKN0qoptv7R1FzUY0tXcMF/4eGMmG++PbnG
         iCNf54Ycex11FUjtBhhvczRvYHyVm/8udAasDnKyhIAZOmg1gNITrdC3jrqMOBE9x/EU
         /OhaeUC43vcvYiDBfYx+uNX4I4tY0pVvhhvSvU9xq/A9QTWVxFKpMZevu/xcgkgEjhQf
         XhP+xLPu8s/8Rg0CN389GypBwv0FWZwJFPDXaVPZ0ImUmc/K3qR+4SAYExfHOrJdNLm9
         Fmvw==
X-Gm-Message-State: AOAM530gsQtHlN/9w2EhLxk2AEiTCI5Pqb17seIIAbTKhv37luiQ2Axp
        CnAvSBEXZvXgGB7VlPzraR2B7Xoir1RlwA==
X-Google-Smtp-Source: ABdhPJxUGQDSfuXm9V6OvKQ/901hW/dJmHjvQbioul2Ggb92Qq5si/N3Yzknr8WNVyvLWr3+7msdJA==
X-Received: by 2002:a17:906:2704:: with SMTP id z4mr8972578ejc.137.1617875149564;
        Thu, 08 Apr 2021 02:45:49 -0700 (PDT)
Received: from skbuf (5-12-16-165.residential.rdsnet.ro. [5.12.16.165])
        by smtp.gmail.com with ESMTPSA id b13sm3175894edw.45.2021.04.08.02.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 02:45:49 -0700 (PDT)
Date:   Thu, 8 Apr 2021 12:45:48 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Subject: Default configuration for CS-to-SCK/SCK-to-CS delays
Message-ID: <20210408094548.o4uj6jzlcrnnacb4@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

The spi-fsl-dspi.c driver has two device tree properties per child node:
- fsl,spi-cs-sck-delay: a delay in nanoseconds between activating chip
  select and the start of clock signal, at the start of a transfer.
- fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping the clock
  signal and deactivating chip select, at the end of a transfer.

Some people are complaining about the fact that when these properties
are missing, the DSPI controller will use zero delay values with that
specific SPI slave. This is particularly relevant when the SPI slave
driver is spidev, so you don't know exactly what is connected.

I tried to search for "delay" under drivers/spi/, but I am not exactly
edified as to what other drivers do to solve this problem. For example,
a SPI-connected Ethernet switch I am working with does explicitly say in
the datasheet that "after the CS signal has been asserted at the
beginning of an SPI read or write operation, the SPI clock signal
(SCK) must be stable for at least 0.5 x t_clk before being asserted".
Many more peripherals may have similar requirements, but I'm not sure
that there is any universal formula. Hence the question: is there any
default configuration that the driver can perform in order to avoid
having to put it in device tree?

Thanks,
-Vladimir
