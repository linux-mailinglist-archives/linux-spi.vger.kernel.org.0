Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED23B37CD
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jun 2021 22:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhFXUaX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Jun 2021 16:30:23 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:38768 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXUaW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Jun 2021 16:30:22 -0400
Received: by mail-io1-f42.google.com with SMTP id k11so9886799ioa.5;
        Thu, 24 Jun 2021 13:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yT5uzxIGnFP5VZf20UNWQIt+98NYYNNQY54nzUDWUYw=;
        b=NYRDS8qfWOTlEh5N7mOugBA8mQHHWTPXqChiJC4/uK1zSDTLW+QUN4MokHdEkxgnRg
         oZ4elRJT6ft2/sDFfQjua+hxTI2yjt0SYUpXv1k2bhhpP/pzLcRAilhR+KzYfDC3MDOr
         qXTN80JN5cni60uU4B5rCl2xw2bmWfLoVLpqVPZ5rEPOLmUbiAOMnCfcoPFCK7wXw8kt
         wmSspm7aW6rk3Y097H7GtH+oVfvTpgxfrqthI/jeh4djpxhlNkjDo01Sx0Z5E35JByX+
         CbM18YD3zKtiEWLRLF0xMS8JhgOanwjVrNTdWuwJxizA7l3K935w0kKu9IOwhcVhw+jB
         ctlw==
X-Gm-Message-State: AOAM531mO+IQXcjG4wn4TRoZnK8l6jIGpXeGZ4pQXSoyqOuVySkoscxR
        cYKg2EHYApzA/xZQ7KR0ZA==
X-Google-Smtp-Source: ABdhPJx4UX0nDQ6JgXzaRAmpINTOK+KHNgOmbLY28VavvrlWiZnbdnHHhgJs8HXeXZh/T98Bl7OhuQ==
X-Received: by 2002:a05:6638:3594:: with SMTP id v20mr6186139jal.25.1624566483218;
        Thu, 24 Jun 2021 13:28:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w7sm2499383ilu.74.2021.06.24.13.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:28:02 -0700 (PDT)
Received: (nullmailer pid 1934646 invoked by uid 1000);
        Thu, 24 Jun 2021 20:27:59 -0000
Date:   Thu, 24 Jun 2021 14:27:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, robh+dt@kernel.org, broonie@kernel.org,
        michal.simek@xilinx.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: convert Xilinx Zynq UltraScale+ MPSoC
 GQSPI bindings to YAML
Message-ID: <20210624202759.GA1934589@robh.at.kernel.org>
References: <20210613214317.296667-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210613214317.296667-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 14 Jun 2021 06:43:17 +0900, Nobuhiro Iwamatsu wrote:
> Convert spi for Xilinx Zynq UltraScale+ MPSoC GQSPI bindings
> documentation to YAML.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  .../bindings/spi/spi-zynqmp-qspi.txt          | 25 ---------
>  .../bindings/spi/spi-zynqmp-qspi.yaml         | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
