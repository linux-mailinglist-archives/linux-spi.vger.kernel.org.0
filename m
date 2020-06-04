Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7606A1EDBE7
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 05:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgFDDrE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 23:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgFDDrB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Jun 2020 23:47:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C60CC03E96D;
        Wed,  3 Jun 2020 20:47:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t7so2949930pgt.3;
        Wed, 03 Jun 2020 20:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NxEaSPQeIOPRkfXUqBGWXS3DhANeE89pJJUJwsIWN6U=;
        b=XMh2NLBLCV1jRAsM/ApPVYMn0b8sSfJSvOD39kjJ1Om9Wed9iwphuhaPW9wZ3rsBHv
         u8UUaLG7LjbGEYX+lAyn6swrDVh9AvFtLNGkHG7klLKXrNclPthMtPF0i2sh2fLO3ys5
         wwT90Pe51q16aPifitePxyi03f77GMxf4NvhwVuaMusm7QLwD7q0iLO+TUj49JVRlbNe
         6cyzApJCV7abeGs6zUhOHAfrRSSPel6w+A6rfY006mPcSKCANZernfLy0CFifmBw7JAm
         XzUF0f/amIWLBpuMk7lrwlZdWFc2dYJbjwYnxzaY/mSz2cMDGqig2Qns1uSdl28izDXv
         BrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NxEaSPQeIOPRkfXUqBGWXS3DhANeE89pJJUJwsIWN6U=;
        b=dXmeR56coD0mjaGzIh8a+wyEXDa3+yr4fULC+UgluqkCharkuPMiDPWzgZtpOW5dVH
         DH7Km1eCYzGZ3EG36uDtYO3kEGZCXjpTq8/trqEbE9X43sTsgSDouKxDG49ujVt7qLFD
         H5q8qx76/gIPzhgM8RKHUJE76lF7n0bYITtNGc1/FJA4c0yIkGr0lVOSA/sFQDwgxA33
         nb+x0Rd43QcyF/OiqbE+jAvrqdm2KCf9hdeMVdvLcKxRW4UDYD4TcpRdsihMs4FMvUah
         4uU5uuvUKEHJh/lBzJ4zFLoiMs2EyLKtGNmefr3X2eaFktOYvC/JyEABgvNLyCnCLBDv
         7GNg==
X-Gm-Message-State: AOAM533X+S7JwNCXhiZire7vlDVB+YWPCIIwX2+JhqeFmlMRrAdjs3JS
        S+AVBXOmMTI+Tu7GbIE565dymmtx
X-Google-Smtp-Source: ABdhPJyuRIpehL8ILBEuAv8MYZ88AthlobDOSBfpKUE+4FSI+ipnlgCRqSzcWpGqCddTssyAUSN10g==
X-Received: by 2002:a05:6a00:150c:: with SMTP id q12mr2251871pfu.270.1591242420517;
        Wed, 03 Jun 2020 20:47:00 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p19sm3083367pff.116.2020.06.03.20.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 20:46:59 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Martin Sperl <kernel@martin.sperl.org>, lukas@wunner.de
Subject: [PATCH 1/3] dt-bindings: spi: Document bcm2711 and bcm7211 SPI compatible
Date:   Wed,  3 Jun 2020 20:46:53 -0700
Message-Id: <20200604034655.15930-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200604034655.15930-1-f.fainelli@gmail.com>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The BCM2711 and BCM7211 chips use the BCM2835 SPI controller, but there
are severl instances of those in the system and they all share the same
interrupt line. Document specific compatible strings such that the
driver can take appropriate actions.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
index f11f295c8450..3d55dd64b1be 100644
--- a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
@@ -5,7 +5,8 @@ SPI0, and the other known as the "Universal SPI Master"; part of the
 auxiliary block. This binding applies to the SPI0 controller.
 
 Required properties:
-- compatible: Should be "brcm,bcm2835-spi".
+- compatible: Should be one of "brcm,bcm2835-spi" for BCM2835/2836/2837 or
+  "brcm,bcm2711-spi" for BCM2711 or "brcm,bcm7211-spi" for BCM7211.
 - reg: Should contain register location and length.
 - interrupts: Should contain interrupt.
 - clocks: The clock feeding the SPI controller.
-- 
2.17.1

