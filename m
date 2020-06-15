Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EF41F9E53
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 19:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgFORZ7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 13:25:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42802 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgFORZ4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 13:25:56 -0400
Received: by mail-io1-f68.google.com with SMTP id x189so9699243iof.9;
        Mon, 15 Jun 2020 10:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dS/bdtyItiFAm48ZgF1YTbFmFfDKJ+FCEj9MlB0IAp4=;
        b=Mh0Ka0/cKEgpKLlxOSeYVWIMR6LVkaGR3s77d98ifHYMG3k2Eax8NY1OM9nctyhEJw
         CgSnNMTtUwWe38pErH3E2fvU21HrLYHmPwn8edEJV6En26Ev/txmMvg+NvN3lNiyAyiv
         DqZprbJCizSTxTJ/B7zMIXgyr3F9TY1BKVeLRpDCkycUbAODGkMURseBQSZO48sPBh5Z
         ZGcQmzla5KMbNLuwFpZKDIfC/+1XhyaUiRLDZglovWDCRMkRDT4hJ/uvdAf+0eDaZZey
         M63luWtJq55bdYxTBLfg3T2UhHNNd7s/g5+wco2O7Buy6TOMnDuHUC6MhCc4j4qNc1Xe
         MrYQ==
X-Gm-Message-State: AOAM533Y0eTeIdSCEqOd5Uub/6Oc86tBfF18dJDXqmcJAMrs0h6Kpf5b
        +bZO5tJ5lkYBtAKyawWsHQ==
X-Google-Smtp-Source: ABdhPJypddMh0DtNo4yEvMLEEWMso2FJiLJSg0Shc51QJu95Vb3Bgqf+obC4mOb9N+9IlXsrnh6G0Q==
X-Received: by 2002:a02:6c8f:: with SMTP id w137mr23100744jab.38.1592241955783;
        Mon, 15 Jun 2020 10:25:55 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id 2sm8612606ila.0.2020.06.15.10.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:25:55 -0700 (PDT)
Received: (nullmailer pid 1992268 invoked by uid 1000);
        Mon, 15 Jun 2020 17:25:52 -0000
Date:   Mon, 15 Jun 2020 11:25:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH 3/3] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200615172552.GA1978070@bogus>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
 <20200604034655.15930-4-f.fainelli@gmail.com>
 <20200604041732.7ijkvad2yadtgjid@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604041732.7ijkvad2yadtgjid@wunner.de>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 04, 2020 at 06:17:32AM +0200, Lukas Wunner wrote:
> On Wed, Jun 03, 2020 at 08:46:55PM -0700, Florian Fainelli wrote:
> > +static const struct of_device_id bcm2835_spi_match[] = {
> > +	{ .compatible = "brcm,bcm2835-spi", .data = &bcm2835_spi_interrupt },
> > +	{ .compatible = "brcm,bcm2711-spi", .data = &bcm2835_spi_sh_interrupt },
> > +	{ .compatible = "brcm,bcm7211-spi", .data = &bcm2835_spi_sh_interrupt },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, bcm2835_spi_match);
> 
> Maybe I'm missing something but I think you either have to reverse the
> order of the entries in this array or change patch [2/3] to drop
> "brcm,bcm2835-spi" from the compatible string:
> 
> __of_match_node() iterates over the entries in the array above and
> calls __of_device_is_compatible() for each of them, which returns
> success if the entry matches any of the device's compatible string.

The order here doesn't matter. I'm pretty sure we fixed this years ago 
to always match to the most specific compatible.

Rob
