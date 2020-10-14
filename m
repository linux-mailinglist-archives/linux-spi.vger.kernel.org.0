Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E174528E17F
	for <lists+linux-spi@lfdr.de>; Wed, 14 Oct 2020 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbgJNNlz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Oct 2020 09:41:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38277 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbgJNNlz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Oct 2020 09:41:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12so3446629ota.5;
        Wed, 14 Oct 2020 06:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODkuPdZmS51vjj18LfZxUJIoA3CbimjnhVaLrPWSbJ8=;
        b=V0kyEuJLfOSbAACGQELlY6Hc4bRdm4ES8qPo8kXByjMWmJvTJG7JiYiKtBruJejC+u
         V19yNv51leEhGqoG7l1+n86Z576Pl2Ij2FberXQX3Le/ysEdJb6XCYYsxX9LvatAqz6E
         eDYrBGdMB7+arW34DY4b0bEgBmBkZ1yaUzZhD9EeGsoQH/4Rb3nKzBOuV3dgSKQ7ZBbt
         JqznRoFKjUG964IQl5K5Ehji0j/YnxZhH7tu5fMe42Q47eFAFuxch0y98i53Anant9Tu
         Lo41o0MJpNkR7Z/U+lKRZfTPPlBl+Q5Q5dEiEnhvghvooZQ7bxsgIBK5RPxfa4ohWrol
         7e/Q==
X-Gm-Message-State: AOAM533w/tFsvJEvxgGkGeb2HcS8MNeYFMjF+GTgJFar9LdwF+lscwSp
        NETU/r9YzfNOphtHEjUDyYiDbU5TeF41
X-Google-Smtp-Source: ABdhPJx2mT4anlgAXwIFtYcquTufwd0maY1yyo9ARfmO4AejEUr6gWCV4FXd8hyjIW1aG2Mk1X+9LQ==
X-Received: by 2002:a9d:8d2:: with SMTP id 76mr3388791otf.270.1602682913956;
        Wed, 14 Oct 2020 06:41:53 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c64sm1009630otb.50.2020.10.14.06.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 06:41:53 -0700 (PDT)
Received: (nullmailer pid 1562646 invoked by uid 1000);
        Wed, 14 Oct 2020 13:41:52 -0000
Date:   Wed, 14 Oct 2020 08:41:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Benson Leung <bleung@chromium.org>,
        Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree <devicetree@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-leds <linux-leds@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 3/6] spi: dt-bindings: spi-controller: explicitly require
 #address-cells=<0> for slave mode
Message-ID: <20201014134152.GA1560405@bogus>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
 <20201013160845.1772-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013160845.1772-4-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 14 Oct 2020 00:08:42 +0800, Zhen Lei wrote:
> scripts/dtc/checks.c:
> if (get_property(node, "spi-slave"))
> 	spi_addr_cells = 0;
> if (node_addr_cells(node) != spi_addr_cells)
> 	FAIL(c, dti, node, "incorrect #address-cells for SPI bus");
> if (node_size_cells(node) != 0)
> 	FAIL(c, dti, node, "incorrect #size-cells for SPI bus");
> 
> The above code in check_spi_bus_bridge() require that the number of address
> cells must be 0. So we should explicitly declare "#address-cells = <0>".
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../devicetree/bindings/spi/spi-controller.yaml      | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 

Applied, thanks!

Note that I tried fixing this in dtc, but that was rejected. So this 
gets the schema in sync with dtc.

Rob
