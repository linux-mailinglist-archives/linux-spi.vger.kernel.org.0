Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5901FBF8B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 22:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgFPUA1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 16:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgFPUAZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 16:00:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB47AC061573
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 13:00:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id c17so25078646lji.11
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=BmSBD7h3njitpLi5QsmTDnHJWiGkucDb02pMa3UrBRI=;
        b=WhqH5S0fm4kJwR2Us6nTMFyavpr+p2ob9Rh92WurpdcnnW5dg4ylnEawx9M3rYu501
         d4GfjWWMYHeTubZjlkm4f02fv5NNyjqtykLc+PaQIFEYXzuZ8q37LAxd71Yfce3XRm1E
         agmR/gKyan3/H8rWKzJvDHDLW/cDk0Y8E1iguSPdKAECAJgAjD96Xat6TCetvIpDyOJ2
         A9zPP4Gku7Nd4TI4lCddOFavCkmP+z6JUCfXrJbzslogeCEwe5GBtXxDY6835ZdMBZTs
         SmDAl+uMz9DZT0zSNM3bLpOxSwCB2QmprJxY1rhM2mf1RmMGX5voK9sF7YGACEuKmaSj
         T1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=BmSBD7h3njitpLi5QsmTDnHJWiGkucDb02pMa3UrBRI=;
        b=qstbim7Uyd8jS2/De7U6ViRsxxeUHjFY8cEZlFdMPwHw23uBZ2dx+vrViRi1BM+rbZ
         reHyQTYcshnLLhJX9uivwUPqf3gYV1UAHCAeghAdeHq4hrX3wzk+gvz2zEqPILvER0eY
         78eX69sXzAkmHghK8VZlsXHFy6nED4ClDtoCUtRFS4EHDy4hU+gmGMlvqr4rMjZJYcXn
         B4BFI7fvAJQMz8Iw6c5Dh46VEygVM7E934zN7Va1Q/fWuF5HDK7HNy6qa3BrnqF9OEyF
         S9hwEtjDx2nqYx5zV2VdT1c2hvUwwrLr661WSsr/ls9w9uGRpkXDQOZ/XQVKBZtk6yLG
         Pydg==
X-Gm-Message-State: AOAM533mnUVDss0Zc5IzYT0KmlT54XLUMoSN9o4UrjLKXNdZrbFH8yli
        XPq1GCgXrv9pXuMPDlpER6OhMg==
X-Google-Smtp-Source: ABdhPJy8D91PJpYVXRICr86OQToa9hkNd7RwcHACmvb8FHbjd7ERv0jv9sQ0T5ab4xzjIL4LEGIIZw==
X-Received: by 2002:a2e:a495:: with SMTP id h21mr2286305lji.436.1592337622099;
        Tue, 16 Jun 2020 13:00:22 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:44fe:a796:a57:d8fd:42a6:762c])
        by smtp.gmail.com with ESMTPSA id b26sm5480405lfp.40.2020.06.16.13.00.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 13:00:21 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v5 0/2] Add Renesas RPC-IF support
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Organization: Cogent Embedded
Message-ID: <9969c8a1-e6be-38a9-ced5-ce8c5ff07046@cogentembedded.com>
Date:   Tue, 16 Jun 2020 23:00:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

Here's a set of 2 patches against Linus' repo. Renesas Reduced Pin Count
Interface (RPC-IF) allows a SPI flash or HyperFlash connected to the SoC
to be accessed via the external address space read mode or the manual mode.
The memory controller driver for RPC-IF registers either SPI or HyperFLash
subdevice, depending on the contents of the device tree subnode; it also
provides the abstract "back end" API that can be used by the "front end"
SPI/MTD drivers to talk to the real hardware...

Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

[1/2] dt-bindings: memory: document Renesas RPC-IF bindings
[2/2] memory: add Renesas RPC-IF driver

MBR, Sergei
